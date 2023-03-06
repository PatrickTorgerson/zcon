// ********************************************************************************
//  https://github.com/PatrickTorgerson
//  Copyright (c) 2022 Patrick Torgerson
//  MIT license, see LICENSE for more information
// ********************************************************************************

//!
//! Buffered writer that writes to stdout
//! resolves macros using `zcon/macro.zig`
//!

const std = @import("std");
const builtin = @import("builtin");
const win32 = @import("../zigwin32/win32.zig").system.console;
const input = @import("InputQueue.zig");
const macro = @import("macro.zig");

const WriterProxy = @import("WriterProxy.zig");
const RingBuffer = @import("ring_buffer.zig").RingBuffer;
const Color = @import("color.zig").Color;

const MacroMap = macro.MacroMap;
const ParamIterator = macro.ParamIterator;
const MacroWriter = macro.MacroWriter;

const This = @This();

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

const ColorState = struct {
    fg: ?Color,
    bg: ?Color,
};

/// creates a Zcon.Writer
pub fn init() This {
    const stdout_file = std.io.getStdOut();
    return This{
        .stdout = stdout_file.writer(),
    };
}

/// writes contents of buffer to stdout, clears buffer
pub fn flush(this: *This) void {
    this.stdout.writeAll(this.buffer[0..this.buffer_end]) catch {};
    this.buffer_end = 0;
}

/// writes to buffer without resolving macros or indenting
pub fn writeRaw(this: *This, str: []const u8) FsError!usize {
    if (this.buffer_end + str.len > this.buffer.len) {
        this.flush();
        if (str.len > this.buffer.len)
            return try this.stdout.write(str);
    }

    std.mem.copy(u8, this.buffer[this.buffer_end..], str);
    this.buffer_end += str.len;
    return str.len;
}

/// writes to buffer without resolving macros or indenting
pub fn writeAllRaw(this: *This, str: []const u8) FsError!void {
    var index: usize = 0;
    while (index != str.len) {
        index += try this.writeRaw(str[index..]);
    }
}

/// return a writer that writes directly to the buffer without any processing
/// this writer will carry a pointer and cannot out-live the calling `zcon.Writer`
pub fn bufferWriter(this: *This) std.io.Writer(*This, FsError, This.writeRaw) {
    return .{ .context = this };
}

/// prints formatted text to buffer without resolving macros or indenting
pub fn printRaw(this: *This, comptime fmt_str: []const u8, args: anytype) !void {
    try std.fmt.format(this.bufferWriter(), fmt_str, args);
}

///
pub fn write(this: *This, str: []const u8) Error!usize {
    var indent_writer = IndentWriter.init(this);
    var macro_writer = MacroWriter.init(zcon_macros, this, WriterProxy.init(&indent_writer));
    macro_writer.writeAll(str) catch |e| return convert_err(e);
    return str.len;
}

///
pub fn print(this: *This, comptime fmt_str: []const u8, args: anytype) Error!void {
    var indent_writer = IndentWriter.init(this);
    var macro_writer = MacroWriter.init(zcon_macros, this, WriterProxy.init(&indent_writer));
    std.fmt.format(macro_writer, fmt_str, args) catch |e| return convert_err(e);
}

///
pub fn put(this: *This, str: []const u8) void {
    _ = this.write(str) catch {};
}

///
pub fn putRaw(this: *This, str: []const u8) void {
    this.writeAllRaw(str) catch {};
}

///
pub fn fmt(this: *This, comptime fmt_str: []const u8, args: anytype) void {
    this.print(fmt_str, args) catch {};
}

///
pub fn fmtRaw(this: *This, comptime fmt_str: []const u8, args: anytype) void {
    std.fmt.format(this.bufferWriter(), fmt_str, args) catch {};
}

///
pub fn putAt(this: *This, pos: input.Position, str: []const u8) void {
    this.setCursor(pos);
    this.put(str);
}

///
pub fn fmtAt(this: *This, pos: input.Position, comptime fmt_str: []const u8, args: anytype) void {
    this.setCursor(pos);
    this.fmt(fmt_str, args);
}

/// for std writer compatability
pub fn writeAll(this: *This, str: []const u8) Error!void {
    _ = try this.write(str);
}

/// for std writer compatability
pub fn writeByte(this: *This, byte: u8) Error!void {
    if (this.buffer_end >= this.buffer.len)
        this.flush();
    this.buffer[this.buffer_end] = byte;
    this.buffer_end += 1;
    // TODO: trailing_newline = true in byte == '\n'
}

/// writes a single char
pub fn putChar(this: *This, char: u8) void {
    this.writeByte(char) catch {};
}

/// for std writer compatability
pub fn writeByteNTimes(this: *This, byte: u8, n: usize) Error!void {
    var bytes: [256]u8 = undefined;
    std.mem.set(u8, bytes[0..], byte);
    var remaining: usize = n;
    while (remaining > 0) {
        const to_write = std.math.min(remaining, bytes.len);
        try this.writeAll(bytes[0..to_write]);
        remaining -= to_write;
    }
}

/// returns current foreground color
/// null for default console foreground
pub fn getForeground(this: *This) ?Color {
    if (this.color_hist.top()) |color_state| {
        return color_state.fg;
    } else return null;
}

/// returns current foreground color
/// null for default console foreground
pub fn getBackground(this: *This) ?Color {
    if (this.color_hist.top()) |color_state| {
        return color_state.bg;
    } else return null;
}

/// sets foreground color
pub fn setForeground(this: *This, color: Color) void {
    color.writeAnsiFg(this.bufferWriter()) catch {};
    this.color_hist.push(.{
        .fg = color,
        .bg = this.getBackground(),
    });
}

/// sets background color
pub fn setBackground(this: *This, color: Color) void {
    color.writeAnsiBg(this.bufferWriter()) catch {};
    this.color_hist.push(.{
        .fg = this.getForeground(),
        .bg = color,
    });
}

/// sets color to last used foreground or background color
pub fn usePreviousColor(this: *This) void {
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
pub fn useDefaultColors(this: *This) void {
    this.putRaw("\x1b[0m");
    this.color_hist.push(.{
        .fg = null,
        .bg = null,
    });
}

///
pub fn setMargins(this: *This, top: i16, bottom: i16) void {
    const size = input.get_buffer_size() catch return;
    this.fmtRaw("\x1b[{};{}r", .{ top, size.height - bottom });
}

///
pub fn saveCursor(this: *This) void {
    this.putRaw("\x1b7");
}

///
pub fn restoreCursor(this: *This) void {
    this.putRaw("\x1b8");
}

///
pub fn setCursor(this: *This, pos: input.Position) void {
    this.fmtRaw("\x1b[{};{}H", .{ pos.y, pos.x });
}

///
pub fn setCursorX(this: *This, x: i16) void {
    this.fmtRaw("\x1b[{}G", .{x});
}

///
pub fn setCursorY(this: *This, y: i16) void {
    this.fmtRaw("\x1b[{}d", .{y});
}

///
pub fn cursorRight(this: *This, amt: i16) void {
    this.fmtRaw("\x1b[{}C", .{amt});
}

///
pub fn cursorLeft(this: *This, amt: i16) void {
    this.fmtRaw("\x1b[{}D", .{amt});
}

///
pub fn cursorUp(this: *This, amt: i16) void {
    this.fmtRaw("\x1b[{}A", .{amt});
}

///
pub fn cursorDown(this: *This, amt: i16) void {
    this.fmtRaw("\x1b[{}B", .{amt});
}

///
pub fn showCursor(this: *This, show: bool) void {
    if (show)
        this.putRaw("\x1b[?25h")
    else
        this.putRaw("\x1b[?25l");
}

/// switches to a dedicated console buffer
pub fn useDedicatedScreen(this: *This) void {
    this.putRaw("\x1b[?1049h");
}

/// switches to default console buffer
pub fn useDefaultScreen(this: *This) void {
    this.putRaw("\x1b[?1049l");
}

/// clears console buffer with current bg color
pub fn clearScreen(this: *This) void {
    this.putRaw("\x1b[2J");
}

/// clears the row the cursor is on with current bg color
pub fn clearLine(this: *This) void {
    this.putRaw("\x1b[2K");
}

///
pub fn backspace(this: *This) void {
    try this.putRaw("\x1b[1D \x1b[1D");
}

// like print but newlines line up with starting column
pub fn draw(this: *This, comptime fmt_str: []const u8, args: anytype) void {
    // get cursor pos
    const stdout = std.io.getStdOut();
    var csbi: win32.CONSOLE_SCREEN_BUFFER_INFO = undefined;
    if (win32.GetConsoleScreenBufferInfo(stdout.handle, &csbi) == 0)
        return;

    const out = this.bufferWriter();
    const column = csbi.dwCursorPosition.X + 1;
    const margin_writer = MarginWriter.init(column, WriterProxy.init(&out));
    const macro_writer = MacroWriter.init(zcon_macros, this, WriterProxy.init(&margin_writer));
    std.fmt.format(macro_writer, fmt_str, args) catch {};
}

/// like print but newlines line up with starting column
pub fn drawAt(this: *This, pos: input.Position, comptime fmt_str: []const u8, args: anytype) void {
    this.setCursor(pos);
    this.flush();
    this.draw(fmt_str, args);
}

/// leaves cursor pos at top left corner inside box
pub fn drawBox(this: *This, size: input.Size) void {
    // get cursor pos
    const stdout = std.io.getStdOut();
    var csbi: win32.CONSOLE_SCREEN_BUFFER_INFO = undefined;
    if (win32.GetConsoleScreenBufferInfo(stdout.handle, &csbi) == 0)
        return;

    const column = csbi.dwCursorPosition.X + 1;
    const buffer_writer = this.bufferWriter();
    const out = MarginWriter.init(column, WriterProxy.init(&buffer_writer));

    out.writeAll("\x1b(0") catch {}; // line draw mode
    //defer out.writeAll("\x1b(B") catch {}; // back to norm

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

///
pub fn drawBoxAt(this: *This, pos: input.Position, size: input.Size) void {
    this.setCursor(pos);
    this.flush();
    this.drawBox(size);
}

/// helper writer that inserts indentatin after newlines
pub const IndentWriter = struct {
    pub const Error = anyerror;
    pub const WriterInterface = std.io.Writer(IndentWriter, IndentWriter.Error, IndentWriter.write);

    out: *This,

    /// forward bytes to out inserting indents after newlines
    pub fn write(this: IndentWriter, bytes: []const u8) IndentWriter.Error!usize {
        if (this.out.trailing_newline) {
            this.out.trailing_newline = false;
            this.out.putIndent();
        }
        var i: usize = 0;
        while (i < bytes.len) : (i += 1) {
            const start = i;
            while (i < bytes.len and bytes[i] != '\n')
                i += 1;
            this.out.putRaw(bytes[start..i]);
            if (i >= bytes.len)
                return bytes.len;
            this.out.putChar('\n');
            if (i + 1 >= bytes.len) {
                this.out.trailing_newline = true;
                return bytes.len;
            }
            this.out.putIndent();
        }
        return bytes.len;
    }

    pub fn init(out: *This) WriterInterface {
        return .{ .context = IndentWriter{
            .out = out,
        } };
    }
};

///
fn putIndent(this: *This) void {
    var l: usize = 0;
    while (l < this.indent_lvl) : (l += 1)
        this.put(this.indent_str);
}

///
pub fn indent(this: *This, amt: i32) void {
    this.indent_lvl += amt;
    if (this.indent_lvl < 0)
        this.indent_lvl = 0;
}

///
pub fn unindent(this: *This, amt: i32) void {
    this.indent_lvl -= amt;
    if (this.indent_lvl < 0)
        this.indent_lvl = 0;
}

///
pub fn setIndentStr(this: *This, comptime str: []const u8) void {
    this.indent_str = str;
}

/// helper writer that aligns every line with a given column
const MarginWriter = struct {
    pub const WriterInterface = std.io.Writer(MarginWriter, error{}, MarginWriter.write);

    out: WriterProxy,
    column: i16,

    pub fn write(this: MarginWriter, bytes: []const u8) error{}!usize {
        var i: usize = 0;
        while (i < bytes.len) : (i += 1) {
            const start = i;
            while (i < bytes.len and bytes[i] != '\n')
                i += 1;
            this.out.writeAll(bytes[start..i]) catch {};
            if (i >= bytes.len)
                return bytes.len;
            this.out.writeByte('\n') catch {};
            this.out.print("\x1b[{}G", .{this.column}) catch {};
        }

        return bytes.len;
    }

    pub fn init(column: i16, out: WriterProxy) WriterInterface {
        return .{
            .context = .{
                .out = out,
                .column = column,
            },
        };
    }
};

/// converts any error type to `zcon.Writer.Error`
/// any error not in `zcon.Writer.Error` with return
/// `zcon.Writer.Error.Unexpected`
fn convert_err(e: anyerror) Error {
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
        => @errSetCast(Error, e),
        else => FsError.Unexpected,
    };
}

// -- builtin macros

///
const zcon_macros = MacroMap.init(.{
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
    .{ "bred", redMacro },
    .{ "bgrn", grnMacro },
    .{ "bblu", bluMacro },
    .{ "bmag", magMacro },
    .{ "bcyn", cynMacro },
    .{ "byel", yelMacro },
    .{ "gry", gryMacro },
    .{ "dgry", dgryMacro },
    .{ "rule", ruleMacro },
    .{ "box", boxMacro },
    .{ "indent", indentMacro },
    .{ "up", upMacro },
    .{ "down", downMacro },
    .{ "left", leftMacro },
    .{ "right", rightMacro },
});

fn upMacro(writer: *This, param_iter: *ParamIterator) !bool {
    if (param_iter.next()) |amt_str| {
        var amt = try std.fmt.parseInt(i16, amt_str, 10);
        writer.cursorUp(amt);
    } else writer.cursorUp(1);
    return true;
}

fn downMacro(writer: *This, param_iter: *ParamIterator) !bool {
    if (param_iter.next()) |amt_str| {
        var amt = try std.fmt.parseInt(i16, amt_str, 10);
        writer.cursorDown(amt);
    } else writer.cursorDown(1);
    return true;
}

fn leftMacro(writer: *This, param_iter: *ParamIterator) !bool {
    if (param_iter.next()) |amt_str| {
        var amt = try std.fmt.parseInt(i16, amt_str, 10);
        writer.cursorLeft(amt);
    } else writer.cursorLeft(1);
    return true;
}

fn rightMacro(writer: *This, param_iter: *ParamIterator) !bool {
    if (param_iter.next()) |amt_str| {
        var amt = try std.fmt.parseInt(i16, amt_str, 10);
        writer.cursorRight(amt);
    } else writer.cursorRight(1);
    return true;
}

fn indentMacro(writer: *This, param_iter: *ParamIterator) !bool {
    _ = param_iter;
    writer.put(writer.indent_str);
    return true;
}

fn defMacro(writer: *This, param_iter: *ParamIterator) !bool {
    _ = param_iter;
    writer.useDefaultColors();
    return true;
}
fn prvMacro(writer: *This, param_iter: *ParamIterator) !bool {
    _ = param_iter;
    // TODO
    writer.usePreviousColor();
    return true;
}
fn redMacro(writer: *This, param_iter: *ParamIterator) !bool {
    _ = param_iter;
    writer.setForeground(Color.col16(.red));
    return true;
}
fn grnMacro(writer: *This, param_iter: *ParamIterator) !bool {
    _ = param_iter;
    writer.setForeground(Color.col16(.green));
    return true;
}
fn bluMacro(writer: *This, param_iter: *ParamIterator) !bool {
    _ = param_iter;
    writer.setForeground(Color.col16(.blue));
    return true;
}
fn magMacro(writer: *This, param_iter: *ParamIterator) !bool {
    _ = param_iter;
    writer.setForeground(Color.col16(.magenta));
    return true;
}
fn cynMacro(writer: *This, param_iter: *ParamIterator) !bool {
    _ = param_iter;
    writer.setForeground(Color.col16(.cyan));
    return true;
}
fn yelMacro(writer: *This, param_iter: *ParamIterator) !bool {
    _ = param_iter;
    writer.setForeground(Color.col16(.yellow));
    return true;
}
fn whtMacro(writer: *This, param_iter: *ParamIterator) !bool {
    _ = param_iter;
    writer.setForeground(Color.col16(.white));
    return true;
}
fn blkMacro(writer: *This, param_iter: *ParamIterator) !bool {
    _ = param_iter;
    writer.setForeground(Color.col16(.black));
    return true;
}
fn gryMacro(writer: *This, param_iter: *ParamIterator) !bool {
    _ = param_iter;
    writer.setForeground(Color.col16(.gray));
    return true;
}
fn dgryMacro(writer: *This, param_iter: *ParamIterator) !bool {
    _ = param_iter;
    writer.setForeground(Color.col16(.dark_gray));
    return true;
}
fn bredMacro(writer: *This, param_iter: *ParamIterator) !bool {
    _ = param_iter;
    writer.setForeground(Color.col16(.bright_red));
    return true;
}
fn bgrnMacro(writer: *This, param_iter: *ParamIterator) !bool {
    _ = param_iter;
    writer.setForeground(Color.col16(.bright_green));
    return true;
}
fn bbluMacro(writer: *This, param_iter: *ParamIterator) !bool {
    _ = param_iter;
    writer.setForeground(Color.col16(.bright_blue));
    return true;
}
fn bmagMacro(writer: *This, param_iter: *ParamIterator) !bool {
    _ = param_iter;
    writer.setForeground(Color.col16(.bright_magenta));
    return true;
}
fn bcynMacro(writer: *This, param_iter: *ParamIterator) !bool {
    _ = param_iter;
    writer.setForeground(Color.col16(.bright_cyan));
    return true;
}
fn byelMacro(writer: *This, param_iter: *ParamIterator) !bool {
    _ = param_iter;
    writer.setForeground(Color.col16(.bright_yellow));
    return true;
}

fn ruleMacro(writer: *This, param_iter: *ParamIterator) !bool {
    if (param_iter.next()) |len_str| {
        var len = try std.fmt.parseInt(i16, len_str, 10);
        writer.putRaw("\x1b(0");
        defer writer.putRaw("\x1b(B");
        while (len > 0) : (len -= 1) {
            writer.putChar('q');
        }
    }
    return true;
}

fn boxMacro(writer: *This, param_iter: *ParamIterator) !bool {
    const wstr = param_iter.next();
    const hstr = param_iter.next();

    if (wstr != null and hstr != null) {
        const w = try std.fmt.parseInt(i16, wstr.?, 10);
        const h = try std.fmt.parseInt(i16, hstr.?, 10);
        writer.drawBox(.{ .width = w, .height = h });
    }

    return true;
}

// slightly modified from 'std.debug.detectTTYConfig()'
// to check stdout instead of stderr and to better detect ansi support on windows
// fn detectTTYConfig() std.debug.TTY.Config
// {
//     if (std.process.hasEnvVarConstant("ZIG_DEBUG_COLOR")) {
//         return .escape_codes;
//     } else if (std.process.hasEnvVarConstant("NO_COLOR")) {
//         return .no_color;
//     } else {
//         const stdout_file = std.io.getStdOut();
//         if (stdout_file.supportsAnsiEscapeCodes()) {
//             return .escape_codes;
//         } else if (builtin.os.tag == .windows and stdout_file.isTty()) {
//             const ENABLE_VIRTUAL_TERMINAL_PROCESSING = 0x0004;
//             var mode: win.DWORD = undefined;
//             if(win.kernel32.GetConsoleMode(stdout_file.handle, &mode) != 0) {
//                 if((mode & ENABLE_VIRTUAL_TERMINAL_PROCESSING) > 0)
//                     return .escape_codes;
//             }
//             // else
//             return .windows_api;
//         } else {
//             return .no_color;
//         }
//     }
// }
