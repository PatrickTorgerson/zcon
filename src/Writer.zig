// ********************************************************************************
//  https://github.com/PatrickTorgerson
//  Copyright (c) 2024 Patrick Torgerson
//  MIT license, see LICENSE for more information
// ********************************************************************************

//!
//! Buffered writer that writes to stdout.
//! resolves macros using `zcon/macro.zig`
//!

const std = @import("std");
const builtin = @import("builtin");
const macro = @import("macro.zig");

const RingBuffer = @import("ring_buffer.zig").RingBuffer;
const Color = @import("color.zig").Color;
const MacroMap = macro.MacroMap;
const ParamIterator = macro.ParamIterator;
const MacroWriter = macro.MacroWriter;
const ZconWriter = @This();

const FsError = std.fs.File.WriteError;
const Error = FsError || macro.Error;

/// output writer for all zcon functions, null for stdout
stdout: std.fs.File.Writer,
/// buffered bytes from write calls
buffer: [2048]u8 = undefined,
/// marks end of buffer contents
buffer_end: usize = 0,
/// current level of indentation
indent_lvl: i32 = 0,
/// string used for a single indent
indent_str: []const u8 = "    ",
/// whether last write ended with a newline
/// important for indentation
trailing_newline: bool = false,
/// stores history of previous colors
color_hist: RingBuffer(ColorState, 32) = .{},

is_bold: bool = false,
is_dim: bool = false,
is_italic: bool = false,
is_blink: bool = false,
is_inverse: bool = false,
is_strikethrough: bool = false,
is_underline: Underline = .off,

const Underline = enum { off, single, double };

const ColorState = struct {
    fg: ?Color,
    bg: ?Color,
};

/// creates a zcon.Writer
pub fn init() ZconWriter {
    const stdout_file = std.io.getStdOut();
    return ZconWriter{
        .stdout = stdout_file.writer(),
    };
}

/// writes contents of buffer to stdout, clears buffer
pub fn flush(this: *ZconWriter) void {
    this.trailing_newline = this.buffer_end == 0 or this.buffer[this.buffer_end - 1] == '\n';
    this.stdout.writeAll(this.buffer[0..this.buffer_end]) catch {};
    this.buffer_end = 0;
}

/// writes to buffer without resolving macros or indenting
pub fn writeRaw(this: *ZconWriter, str: []const u8) FsError!usize {
    if (this.buffer_end + str.len > this.buffer.len) {
        this.flush();
        if (str.len > this.buffer.len) {
            try this.stdout.writeAll(str);
            return str.len;
        }
    }
    @memcpy(this.buffer[this.buffer_end..][0..str.len], str);
    this.buffer_end += str.len;
    return str.len;
}

/// return a writer that writes directly to the buffer without any processing.
/// this writer will carry a pointer and cannot out-live the calling `zcon.Writer`
pub fn bufferWriter(this: *ZconWriter) std.io.GenericWriter(*ZconWriter, FsError, ZconWriter.writeRaw) {
    return .{ .context = this };
}

/// prints formatted text to buffer without resolving macros or indenting
pub fn printRaw(this: *ZconWriter, comptime fmt_str: []const u8, args: anytype) !void {
    try std.fmt.format(this.bufferWriter(), fmt_str, args);
}

pub fn write(this: *ZconWriter, str: []const u8) Error!usize {
    if (this.buffer_end > 0)
        this.trailing_newline = this.buffer[this.buffer_end - 1] == '\n';
    const indent_writer = IndentWriter.init(this);
    const macro_writer = MacroWriter.init(zcon_macros, this, indent_writer.any());
    macro_writer.any().writeAll(str) catch |e| return convertErr(e);
    return str.len;
}

pub fn print(this: *ZconWriter, comptime fmt_str: []const u8, args: anytype) Error!void {
    if (this.buffer_end > 0)
        this.trailing_newline = this.buffer[this.buffer_end - 1] == '\n';
    const indent_writer = IndentWriter.init(this);
    const macro_writer = MacroWriter.init(zcon_macros, this, indent_writer.any());
    std.fmt.format(macro_writer.any(), fmt_str, args) catch |e| return convertErr(e);
}

pub fn put(this: *ZconWriter, str: []const u8) void {
    _ = this.write(str) catch {};
}

pub fn putRaw(this: *ZconWriter, str: []const u8) void {
    _ = this.writeRaw(str) catch {};
}

pub fn fmt(this: *ZconWriter, comptime fmt_str: []const u8, args: anytype) void {
    this.print(fmt_str, args) catch {};
}

pub fn fmtRaw(this: *ZconWriter, comptime fmt_str: []const u8, args: anytype) void {
    std.fmt.format(this.bufferWriter(), fmt_str, args) catch {};
}

pub fn putAt(this: *ZconWriter, pos: Cursor, str: []const u8) void {
    this.setCursor(pos);
    this.put(str);
}

pub fn fmtAt(this: *ZconWriter, pos: Cursor, comptime fmt_str: []const u8, args: anytype) void {
    this.setCursor(pos);
    this.fmt(fmt_str, args);
}

/// for std writer compatability
pub fn writeAll(this: *ZconWriter, str: []const u8) Error!void {
    _ = try this.write(str);
}

/// for std writer compatability
pub fn writeByte(this: *ZconWriter, byte: u8) Error!void {
    if (this.buffer_end >= this.buffer.len)
        this.flush();
    this.buffer[this.buffer_end] = byte;
    this.buffer_end += 1;
}

/// writes a single char
pub fn putChar(this: *ZconWriter, char: u8) void {
    this.writeByte(char) catch {};
}

/// for std writer compatability
pub fn writeByteNTimes(this: *ZconWriter, byte: u8, n: usize) Error!void {
    var bytes: [256]u8 = undefined;
    @memset(bytes[0..], byte);
    var remaining: usize = n;
    while (remaining > 0) {
        const to_write = @min(remaining, bytes.len);
        try this.writeAll(bytes[0..to_write]);
        remaining -= to_write;
    }
}

/// for std writer compatability
pub fn writeBytesNTimes(this: *ZconWriter, bytes: []const u8, n: usize) Error!void {
    for (0..n) |_| {
        try this.writeAll(bytes);
    }
}

/// returns current foreground color
/// null for default console foreground
pub fn getForeground(this: *ZconWriter) ?Color {
    if (this.color_hist.top()) |color_state| {
        return color_state.fg;
    } else return null;
}

/// returns current foreground color
/// null for default console foreground
pub fn getBackground(this: *ZconWriter) ?Color {
    if (this.color_hist.top()) |color_state| {
        return color_state.bg;
    } else return null;
}

/// sets foreground color
pub fn setForeground(this: *ZconWriter, color: Color) void {
    color.writeAnsiFg(this.bufferWriter()) catch {};
    this.color_hist.push(.{
        .fg = color,
        .bg = this.getBackground(),
    });
}

/// sets background color
pub fn setBackground(this: *ZconWriter, color: Color) void {
    color.writeAnsiBg(this.bufferWriter()) catch {};
    this.color_hist.push(.{
        .fg = this.getForeground(),
        .bg = color,
    });
}

/// sets color to last used foreground or background color
pub fn usePreviousColor(this: *ZconWriter) void {
    _ = this.color_hist.pop();
    if (this.color_hist.top()) |prev| {
        if (prev.fg) |fg|
            fg.writeAnsiFg(this.bufferWriter()) catch {}
        else
            this.putRaw("\x1b[39m");
        if (prev.bg) |bg|
            bg.writeAnsiBg(this.bufferWriter()) catch {}
        else
            this.putRaw("\x1b[49m");
    } else this.putRaw("\x1b[0m");
}

/// sets colors to console defaults
pub fn useDefaultColors(this: *ZconWriter) void {
    this.putRaw("\x1b[0m");
    this.color_hist.push(.{
        .fg = null,
        .bg = null,
    });
}

/// turn underline off, single, or double.
/// may not be supported by all terminals
pub fn underline(this: *ZconWriter, on: Underline) void {
    this.is_underline = on;
    // switching directly from single to double, or vice-versa
    // doesn't work, so we disable undeline first
    this.putRaw("\x1b[24m");
    switch (on) {
        .off => {},
        .single => this.putRaw("\x1b[4m"),
        .double => this.putRaw("\x1b[21m"),
    }
}

/// turn italics on or off.
/// may not be supported by all terminals
pub fn italic(this: *ZconWriter, on: bool) void {
    this.is_italic = on;
    if (on)
        this.putRaw("\x1b[3m")
    else
        this.putRaw("\x1b[23m");
}

/// turn dim on or off.
/// may not be supported by all terminals
pub fn dim(this: *ZconWriter, on: bool) void {
    this.is_dim = on;
    if (on)
        this.putRaw("\x1b[2m")
    else
        this.putRaw("\x1b[22m");
}

/// turn bold on or off.
/// may not be supported by all terminals
pub fn bold(this: *ZconWriter, on: bool) void {
    this.is_bold = on;
    if (on)
        this.putRaw("\x1b[1m")
    else
        this.putRaw("\x1b[22m");
}

/// turn blink on or off.
/// may not be supported by all terminals
pub fn blink(this: *ZconWriter, on: bool) void {
    this.is_blink = on;
    if (on)
        this.putRaw("\x1b[5m")
    else
        this.putRaw("\x1b[25m");
}

/// turn inverse on or off,
/// switches fg and bg color.
/// may not be supported by all terminals
pub fn inverse(this: *ZconWriter, on: bool) void {
    this.is_inverse = on;
    if (on)
        this.putRaw("\x1b[7m")
    else
        this.putRaw("\x1b[27m");
}

/// turn strike through on or off.
/// may not be supported by all terminals
pub fn strikethrough(this: *ZconWriter, on: bool) void {
    this.is_strikethrough = on;
    if (on)
        this.putRaw("\x1b[9m")
    else
        this.putRaw("\x1b[29m");
}

pub fn setMargins(this: *ZconWriter, top: i16, bottom: i16) void {
    const size = this.getSize() catch return;
    this.fmtRaw("\x1b[{};{}r", .{ top, size.height - bottom });
}

pub fn saveCursor(this: *ZconWriter) void {
    this.putRaw("\x1b7");
}

pub fn restoreCursor(this: *ZconWriter) void {
    this.putRaw("\x1b8");
}

pub const Cursor = struct {
    x: i16,
    y: i16,
};

pub fn setCursor(this: *ZconWriter, cur: Cursor) void {
    this.fmtRaw("\x1b[{};{}H", .{ cur.y, cur.x });
}

pub fn setCursorX(this: *ZconWriter, x: i16) void {
    this.fmtRaw("\x1b[{}G", .{x});
}

pub fn setCursorY(this: *ZconWriter, y: i16) void {
    this.fmtRaw("\x1b[{}d", .{y});
}

pub fn cursorRight(this: *ZconWriter, amt: i16) void {
    this.fmtRaw("\x1b[{}C", .{amt});
}

pub fn cursorLeft(this: *ZconWriter, amt: i16) void {
    this.fmtRaw("\x1b[{}D", .{amt});
}

pub fn cursorUp(this: *ZconWriter, amt: i16) void {
    this.fmtRaw("\x1b[{}A", .{amt});
}

pub fn cursorDown(this: *ZconWriter, amt: i16) void {
    this.fmtRaw("\x1b[{}B", .{amt});
}

pub fn showCursor(this: *ZconWriter, show: bool) void {
    if (show)
        this.putRaw("\x1b[?25h")
    else
        this.putRaw("\x1b[?25l");
}

/// Gets the cursor position
/// returned cursor will be invalidated when the buffer scrolls
/// use of this function should be minimized
pub fn getCursor(this: *ZconWriter) !Cursor {
    if (builtin.os.tag == .windows) {
        const win32 = @import("win32.zig");
        this.flush();

        const stdout = std.io.getStdOut();
        var csbi: win32.CONSOLE_SCREEN_BUFFER_INFO = undefined;
        if (win32.GetConsoleScreenBufferInfo(stdout.handle, &csbi) == 0)
            return error.win32_fail;
        return .{
            .x = csbi.dwCursorPosition.X + 1,
            .y = csbi.dwCursorPosition.Y + 1,
        };
    } else {
        const c = @import("c.zig");
        this.flush();

        // save current term state
        var saved_term: c.termios = undefined;
        var result: i32 = 0;
        while (true) {
            result = c.tcgetattr(std.io.getStdOut().handle, &saved_term);
            if (!(result == -1 and std.c.getErrno(result) == .INTR)) break;
        }
        if (result == -1) return error.save_state_fail;

        // restore previos term state on return
        defer {
            while (true) {
                result = c.tcsetattr(std.io.getStdOut().handle, c.TCSANOW, &saved_term);
                if (!(result == -1 and std.c.getErrno(result) == .INTR)) break;
            }
        }

        var term: c.termios = saved_term;
        term.c_lflag &= ~@as(c_uint, @intCast(c.ICANON)); // don't hang on read
        term.c_lflag &= ~@as(c_uint, @intCast(c.ECHO)); // don't display response
        term.c_lflag &= ~@as(c_uint, @intCast(c.CREAD)); // don't mix standard input and console responses.

        // update term state with above flags
        while (true) {
            result = c.tcsetattr(std.io.getStdOut().handle, c.TCSANOW, &term);
            if (!(result == -1 and std.c.getErrno(result) == .INTR)) break;
        }
        if (result == -1) return error.update_state_fail;

        // request cursor position
        this.stdout.writeAll("\x1b[6n") catch unreachable;

        var buffer_data: [16]u8 = undefined;
        const reader = std.io.getStdIn().reader();

        const buffer = reader.readUntilDelimiterOrEof(&buffer_data, 'R') catch {
            return error.read_fail;
        } orelse return error.read_fail;

        if (buffer[0] != '\x1b')
            return error.missing_escape;
        if (buffer[1] != '[')
            return error.missing_bracket;

        var end: usize = 2;
        while (end < buffer.len and buffer[end] != ';')
            end += 1;
        const y = std.fmt.parseInt(i16, buffer[2..end], 10) catch return error.parse_fail;
        var r: usize = 2;
        while (r < buffer.len and buffer[r] != 'R')
            r += 1;
        const x = std.fmt.parseInt(i16, buffer[end + 1 .. r], 10) catch return error.parse_fail;

        return .{ .x = x, .y = y };
    }
}

pub const Size = struct {
    width: i16,
    height: i16,
};

/// Get size of the console screen buffer
/// use of this function should be minimized
pub fn getSize(this: *ZconWriter) !Size {
    _ = this;
    if (builtin.os.tag == .windows) {
        const win32 = @import("win32.zig");

        const stdout = std.io.getStdOut();
        var csbi: win32.CONSOLE_SCREEN_BUFFER_INFO = undefined;
        if (win32.GetConsoleScreenBufferInfo(stdout.handle, &csbi) == 0)
            return error.win32_fail;
        return .{
            .width = csbi.dwSize.X,
            .height = csbi.dwSize.Y,
        };
    } else {
        const c = @import("c.zig");

        var w: c.winsize = undefined;
        const result = c.ioctl(c.STDOUT_FILENO, c.TIOCGWINSZ, &w);
        if (result != 0)
            return error.ioctl_fail;

        return .{
            .width = @intCast(w.ws_col),
            .height = @intCast(w.ws_row),
        };
    }
}

/// switches to a dedicated console buffer
pub fn useDedicatedScreen(this: *ZconWriter) void {
    this.putRaw("\x1b[?1049h");
}

/// switches to default console buffer
pub fn useDefaultScreen(this: *ZconWriter) void {
    this.putRaw("\x1b[?1049l");
}

/// clears console buffer with current bg color
pub fn clearScreen(this: *ZconWriter) void {
    this.putRaw("\x1b[2J");
}

/// clears the row the cursor is on with current bg color
pub fn clearLine(this: *ZconWriter) void {
    this.putRaw("\x1b[2K");
}

pub fn backspace(this: *ZconWriter) void {
    try this.putRaw("\x1b[1D \x1b[1D");
}

/// like print but newlines line up with starting column
/// `drawAt()` should be preffered wherever possible
pub fn draw(this: *ZconWriter, comptime fmt_str: []const u8, args: anytype) void {
    const cur = this.getCursor() catch return;
    this.drawAt(this, cur, fmt_str, args);
}

/// like print but newlines line up with starting column
pub fn drawAt(this: *ZconWriter, cur: Cursor, comptime fmt_str: []const u8, args: anytype) void {
    this.setCursor(cur);
    this.flush();
    const column = cur.x;
    const margin_writer = MarginWriter.init(column, this);
    const macro_writer = MacroWriter.init(zcon_macros, this, margin_writer.any());
    std.fmt.format(macro_writer.any(), fmt_str, args) catch {};
}

/// leaves cursor pos at top left corner inside box
/// `drawBoxAt()` should be preffered wherever possible
pub fn drawBox(this: *ZconWriter, size: Size) void {
    const cur = this.getCursor() catch return;
    this.drawBoxAt(cur, size);
}

/// leaves cursor pos at top left corner inside box
pub fn drawBoxAt(this: *ZconWriter, cur: Cursor, size: Size) void {
    this.setCursor(cur);
    this.flush();
    const column = cur.x;
    const margin_writer = MarginWriter.init(column, this);
    const out = margin_writer.any();
    out.writeAll("\x1b(0") catch {}; // line draw mode
    var y: i16 = 0;
    while (y < size.height) : (y += 1) {
        if (y == 0) {
            out.writeByte('l') catch {};
            var x: i16 = 1;
            while (x < size.width - 1) : (x += 1)
                out.writeByte('q') catch {};
            out.writeByte('k') catch {};
            out.writeByte('\n') catch {};
        } else if (y == size.height - 1) {
            out.writeByte('m') catch {};
            var x: i16 = 1;
            while (x < size.width - 1) : (x += 1)
                out.writeByte('q') catch {};
            out.writeByte('j') catch {};
            out.writeByte('\n') catch {};
        } else out.print("x\x1b[{}Cx\n", .{size.width - 2}) catch {};
    }
    out.writeAll("\x1b(B") catch {}; // back to norm
    out.print("\x1b[1C\x1b[{}A", .{size.height - 1}) catch {};
}

/// helper writer that inserts indentation after newlines
pub const IndentWriter = struct {
    pub const Error = anyerror;

    out: *ZconWriter,

    pub fn init(out: *ZconWriter) IndentWriter {
        return .{
            .out = out,
        };
    }

    /// forward bytes to output writer, inserting indents after newlines
    pub fn write(this: *const IndentWriter, bytes: []const u8) IndentWriter.Error!usize {
        if (this.out.trailing_newline) {
            this.out.putIndent();
        }
        var i: usize = 0;
        while (i < bytes.len) : (i += 1) {
            const start = i;
            while (i < bytes.len and bytes[i] != '\n')
                i += 1;
            this.out.putRaw(bytes[start..i]);
            if (i >= bytes.len) break;
            this.out.putChar('\n');
            if (i + 1 >= bytes.len) break;
            this.out.putIndent();
        }
        return bytes.len;
    }

    pub fn any(this: *const IndentWriter) std.io.AnyWriter {
        return .{
            .context = @ptrCast(this),
            .writeFn = typeErasedWriteFn,
        };
    }

    fn typeErasedWriteFn(context: *const anyopaque, bytes: []const u8) anyerror!usize {
        const ptr: *const IndentWriter = @alignCast(@ptrCast(context));
        return ptr.write(bytes);
    }
};

fn putIndent(this: *ZconWriter) void {
    var l: usize = 0;
    while (l < this.indent_lvl) : (l += 1) {
        const buffer_writer = this.bufferWriter();
        const macro_writer = MacroWriter.init(zcon_macros, this, buffer_writer.any());
        macro_writer.any().writeAll(this.indent_str) catch {};
    }
}

pub fn indent(this: *ZconWriter, amt: i32) void {
    this.indent_lvl += amt;
    if (this.indent_lvl < 0)
        this.indent_lvl = 0;
}

pub fn unindent(this: *ZconWriter, amt: i32) void {
    this.indent_lvl -= amt;
    if (this.indent_lvl < 0)
        this.indent_lvl = 0;
}

pub fn setIndentStr(this: *ZconWriter, comptime str: []const u8) void {
    this.indent_str = str;
}

/// helper writer that aligns every line with a given column
const MarginWriter = struct {
    out: *ZconWriter,
    column: i16,

    pub fn init(column: i16, out: *ZconWriter) MarginWriter {
        return .{
            .out = out,
            .column = column,
        };
    }

    pub fn write(this: *const MarginWriter, bytes: []const u8) error{}!usize {
        var i: usize = 0;
        while (i < bytes.len) : (i += 1) {
            const start = i;
            while (i < bytes.len and bytes[i] != '\n')
                i += 1;
            this.out.putRaw(bytes[start..i]);
            if (i >= bytes.len)
                return bytes.len;
            this.out.putChar('\n');
            this.out.fmtRaw("\x1b[{}G", .{this.column});
        }

        return bytes.len;
    }

    pub fn any(this: *const MarginWriter) std.io.AnyWriter {
        return .{
            .context = @ptrCast(this),
            .writeFn = typeErasedWriteFn,
        };
    }

    fn typeErasedWriteFn(context: *const anyopaque, bytes: []const u8) anyerror!usize {
        const ptr: *const MarginWriter = @alignCast(@ptrCast(context));
        return ptr.write(bytes);
    }
};

/// converts any error type to `zcon.Writer.Error`
/// any error not in `zcon.Writer.Error` with return
/// `zcon.Writer.Error.Unexpected`
fn convertErr(e: anyerror) Error {
    return switch (e) {
        error.DiskQuota,
        error.FileTooBig,
        error.InputOutput,
        error.NoSpaceLeft,
        error.AccessDenied,
        error.BrokenPipe,
        error.SystemResources,
        error.OperationAborted,
        error.NotOpenForWriting,
        error.LockViolation,
        error.WouldBlock,
        error.ConnectionResetByPeer,
        error.macro_returned_error,
        => @errorCast(e),
        else => FsError.Unexpected,
    };
}

// -- builtin macros

const zcon_macros = MacroMap.initComptime(.{
    .{ "def", defMacro },
    .{ "prv", prvMacro },
    .{ "red", redMacro },
    .{ "grn", grnMacro },
    .{ "blu", bluMacro },
    .{ "mag", magMacro },
    .{ "cyn", cynMacro },
    .{ "yel", yelMacro },
    .{ "wht", whtMacro },
    .{ "blk", blkMacro },
    .{ "bred", bredMacro },
    .{ "bgrn", bgrnMacro },
    .{ "bblu", bbluMacro },
    .{ "bmag", bmagMacro },
    .{ "bcyn", bcynMacro },
    .{ "byel", byelMacro },
    .{ "gry", gryMacro },
    .{ "dgry", dgryMacro },
    .{ "fg", fgMacro },
    .{ "bg", bgMacro },
    .{ "n", normalMacro },
    .{ "b", boldMacro },
    .{ "d", dimMacro },
    .{ "i", italicMacro },
    .{ "u", underlineMacro },
    .{ "s", strikeMacro },
    .{ "du", doubleUnderlineMacro },
    .{ "blink", blinkMacro },
    .{ "inverse", inverseMacro },
    .{ "repeat", repeatMacro },
    .{ "rule", ruleMacro },
    .{ "box", boxMacro },
    .{ "indent", indentMacro },
    .{ "up", upMacro },
    .{ "down", downMacro },
    .{ "left", leftMacro },
    .{ "right", rightMacro },
});

fn colorMacroFg(color: Color, writer: *ZconWriter, param_iter: *ParamIterator) void {
    writer.setForeground(color);
    if (param_iter.next()) |text| {
        writer.put(text);
        writer.usePreviousColor();
    }
}

fn colorMacroBg(color: Color, writer: *ZconWriter, param_iter: *ParamIterator) void {
    writer.setBackground(color);
    if (param_iter.next()) |text| {
        writer.put(text);
        writer.usePreviousColor();
    }
}

fn normalMacro(writer: *ZconWriter, param_iter: *ParamIterator) !bool {
    const is_underline = writer.is_underline;
    const is_bold = writer.is_bold;
    const is_dim = writer.is_dim;
    const is_italic = writer.is_italic;
    const is_blink = writer.is_blink;
    const is_inverse = writer.is_inverse;
    const is_strikethrough = writer.is_strikethrough;
    writer.underline(.off);
    writer.bold(false);
    writer.dim(false);
    writer.italic(false);
    writer.blink(false);
    writer.inverse(false);
    writer.strikethrough(false);
    if (param_iter.next()) |text| {
        writer.put(text);
        writer.underline(is_underline);
        writer.bold(is_bold);
        writer.dim(is_dim);
        writer.italic(is_italic);
        writer.blink(is_blink);
        writer.inverse(is_inverse);
        writer.strikethrough(is_strikethrough);
    }
    return true;
}

fn boldMacro(writer: *ZconWriter, param_iter: *ParamIterator) !bool {
    if (param_iter.next()) |param| {
        if (std.mem.eql(u8, param, "off"))
            writer.bold(false)
        else {
            const was_bold = writer.is_bold;
            writer.bold(true);
            writer.put(param);
            writer.bold(was_bold);
        }
    } else writer.bold(true);
    return true;
}

fn dimMacro(writer: *ZconWriter, param_iter: *ParamIterator) !bool {
    if (param_iter.next()) |param| {
        if (std.mem.eql(u8, param, "off"))
            writer.dim(false)
        else {
            const was_dim = writer.is_dim;
            writer.dim(true);
            writer.put(param);
            writer.dim(was_dim);
        }
    } else writer.dim(true);
    return true;
}

fn italicMacro(writer: *ZconWriter, param_iter: *ParamIterator) !bool {
    if (param_iter.next()) |param| {
        if (std.mem.eql(u8, param, "off"))
            writer.italic(false)
        else {
            const was_italic = writer.is_italic;
            writer.italic(true);
            writer.put(param);
            writer.italic(was_italic);
        }
    } else writer.italic(true);
    return true;
}

fn blinkMacro(writer: *ZconWriter, param_iter: *ParamIterator) !bool {
    if (param_iter.next()) |param| {
        if (std.mem.eql(u8, param, "off"))
            writer.blink(false)
        else {
            const was_blink = writer.is_blink;
            writer.blink(true);
            writer.put(param);
            writer.blink(was_blink);
        }
    } else writer.blink(true);
    return true;
}

fn inverseMacro(writer: *ZconWriter, param_iter: *ParamIterator) !bool {
    if (param_iter.next()) |param| {
        if (std.mem.eql(u8, param, "off"))
            writer.inverse(false)
        else {
            const was_inverse = writer.is_inverse;
            writer.inverse(true);
            writer.put(param);
            writer.inverse(was_inverse);
        }
    } else writer.inverse(true);
    return true;
}

fn underlineMacro(writer: *ZconWriter, param_iter: *ParamIterator) !bool {
    if (param_iter.next()) |param| {
        if (std.mem.eql(u8, param, "off"))
            writer.underline(.off)
        else {
            const was_underline = writer.is_underline;
            writer.underline(.single);
            writer.put(param);
            writer.underline(was_underline);
        }
    } else writer.underline(.single);
    return true;
}

fn strikeMacro(writer: *ZconWriter, param_iter: *ParamIterator) !bool {
    if (param_iter.next()) |param| {
        if (std.mem.eql(u8, param, "off"))
            writer.strikethrough(false)
        else {
            const was_strikethrough = writer.is_strikethrough;
            writer.strikethrough(true);
            writer.put(param);
            writer.strikethrough(was_strikethrough);
        }
    } else writer.strikethrough(true);
    return true;
}

fn doubleUnderlineMacro(writer: *ZconWriter, param_iter: *ParamIterator) !bool {
    if (param_iter.next()) |param| {
        if (std.mem.eql(u8, param, "off"))
            writer.underline(.off)
        else {
            const was_underline = writer.is_underline;
            writer.underline(.double);
            writer.put(param);
            writer.underline(was_underline);
        }
    } else writer.underline(.double);
    return true;
}

fn fgMacro(writer: *ZconWriter, param_iter: *ParamIterator) !bool {
    const hex = param_iter.next() orelse return false;
    colorMacroFg(Color.hex(hex) orelse return false, writer, param_iter);
    return true;
}

fn bgMacro(writer: *ZconWriter, param_iter: *ParamIterator) !bool {
    const hex = param_iter.next() orelse return false;
    colorMacroBg(Color.hex(hex) orelse return false, writer, param_iter);
    return true;
}

fn repeatMacro(writer: *ZconWriter, param_iter: *ParamIterator) !bool {
    const text = param_iter.next() orelse return false;
    const count_str = param_iter.next() orelse "1";
    var count = std.fmt.parseInt(usize, count_str, 10) catch return false;
    while (count > 0) : (count -= 1)
        writer.put(text);
    return true;
}

fn upMacro(writer: *ZconWriter, param_iter: *ParamIterator) !bool {
    if (param_iter.next()) |amt_str| {
        const amt = std.fmt.parseInt(i16, amt_str, 10) catch return false;
        writer.cursorUp(amt);
    } else writer.cursorUp(1);
    return true;
}

fn downMacro(writer: *ZconWriter, param_iter: *ParamIterator) !bool {
    if (param_iter.next()) |amt_str| {
        const amt = std.fmt.parseInt(i16, amt_str, 10) catch return false;
        writer.cursorDown(amt);
    } else writer.cursorDown(1);
    return true;
}

fn leftMacro(writer: *ZconWriter, param_iter: *ParamIterator) !bool {
    if (param_iter.next()) |amt_str| {
        const amt = std.fmt.parseInt(i16, amt_str, 10) catch return false;
        writer.cursorLeft(amt);
    } else writer.cursorLeft(1);
    return true;
}

fn rightMacro(writer: *ZconWriter, param_iter: *ParamIterator) !bool {
    if (param_iter.next()) |amt_str| {
        const amt = std.fmt.parseInt(i16, amt_str, 10) catch return false;
        writer.cursorRight(amt);
    } else writer.cursorRight(1);
    return true;
}

fn indentMacro(writer: *ZconWriter, param_iter: *ParamIterator) !bool {
    _ = param_iter;
    writer.put(writer.indent_str);
    return true;
}

fn defMacro(writer: *ZconWriter, param_iter: *ParamIterator) !bool {
    _ = param_iter;
    writer.useDefaultColors();
    return true;
}
fn prvMacro(writer: *ZconWriter, param_iter: *ParamIterator) !bool {
    _ = param_iter;
    writer.usePreviousColor();
    return true;
}
fn redMacro(writer: *ZconWriter, param_iter: *ParamIterator) !bool {
    colorMacroFg(Color.col16(.red), writer, param_iter);
    return true;
}
fn grnMacro(writer: *ZconWriter, param_iter: *ParamIterator) !bool {
    colorMacroFg(Color.col16(.green), writer, param_iter);
    return true;
}
fn bluMacro(writer: *ZconWriter, param_iter: *ParamIterator) !bool {
    colorMacroFg(Color.col16(.blue), writer, param_iter);
    return true;
}
fn magMacro(writer: *ZconWriter, param_iter: *ParamIterator) !bool {
    colorMacroFg(Color.col16(.magenta), writer, param_iter);
    return true;
}
fn cynMacro(writer: *ZconWriter, param_iter: *ParamIterator) !bool {
    colorMacroFg(Color.col16(.cyan), writer, param_iter);
    return true;
}
fn yelMacro(writer: *ZconWriter, param_iter: *ParamIterator) !bool {
    colorMacroFg(Color.col16(.yellow), writer, param_iter);
    return true;
}
fn whtMacro(writer: *ZconWriter, param_iter: *ParamIterator) !bool {
    colorMacroFg(Color.col16(.white), writer, param_iter);
    return true;
}
fn blkMacro(writer: *ZconWriter, param_iter: *ParamIterator) !bool {
    colorMacroFg(Color.col16(.black), writer, param_iter);
    return true;
}
fn gryMacro(writer: *ZconWriter, param_iter: *ParamIterator) !bool {
    colorMacroFg(Color.col16(.gray), writer, param_iter);
    return true;
}
fn dgryMacro(writer: *ZconWriter, param_iter: *ParamIterator) !bool {
    colorMacroFg(Color.col16(.dark_gray), writer, param_iter);
    return true;
}
fn bredMacro(writer: *ZconWriter, param_iter: *ParamIterator) !bool {
    colorMacroFg(Color.col16(.bright_red), writer, param_iter);
    return true;
}
fn bgrnMacro(writer: *ZconWriter, param_iter: *ParamIterator) !bool {
    colorMacroFg(Color.col16(.bright_green), writer, param_iter);
    return true;
}
fn bbluMacro(writer: *ZconWriter, param_iter: *ParamIterator) !bool {
    colorMacroFg(Color.col16(.bright_blue), writer, param_iter);
    return true;
}
fn bmagMacro(writer: *ZconWriter, param_iter: *ParamIterator) !bool {
    colorMacroFg(Color.col16(.bright_magenta), writer, param_iter);
    return true;
}
fn bcynMacro(writer: *ZconWriter, param_iter: *ParamIterator) !bool {
    colorMacroFg(Color.col16(.bright_cyan), writer, param_iter);
    return true;
}
fn byelMacro(writer: *ZconWriter, param_iter: *ParamIterator) !bool {
    colorMacroFg(Color.col16(.bright_yellow), writer, param_iter);
    return true;
}

fn ruleMacro(writer: *ZconWriter, param_iter: *ParamIterator) !bool {
    if (param_iter.next()) |len_str| {
        var len = std.fmt.parseInt(i16, len_str, 10) catch return false;
        writer.putRaw("\x1b(0");
        defer writer.putRaw("\x1b(B");
        while (len > 0) : (len -= 1) {
            writer.putChar('q');
        }
    }
    return true;
}

fn boxMacro(writer: *ZconWriter, param_iter: *ParamIterator) !bool {
    const wstr = param_iter.next() orelse return false;
    const hstr = param_iter.next() orelse return false;
    const w = std.fmt.parseInt(i16, wstr, 10) catch return false;
    const h = std.fmt.parseInt(i16, hstr, 10) catch return false;
    writer.drawBox(.{ .width = w, .height = h });
    return true;
}
