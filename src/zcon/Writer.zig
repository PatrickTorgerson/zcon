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
const input = @import("input.zig");
const macro = @import("macro.zig");

const WriterProxy = @import("WriterProxy.zig");

const MacroMap = macro.MacroMap;
const ParamIterator = macro.ParamIterator;
const MacroWriter = macro.MacroWriter;

const This = @This();

pub const black = Color.foreground(.black, .dim, .normal);
pub const red = Color.foreground(.red, .dim, .normal);
pub const green = Color.foreground(.green, .dim, .normal);
pub const yellow = Color.foreground(.yellow, .dim, .normal);
pub const blue = Color.foreground(.blue, .dim, .normal);
pub const magenta = Color.foreground(.magenta, .dim, .normal);
pub const cyan = Color.foreground(.cyan, .dim, .normal);
pub const white = Color.foreground(.white, .dim, .normal);
pub const bright_black = Color.foreground(.black, .bright, .normal);
pub const bright_red = Color.foreground(.red, .bright, .normal);
pub const bright_green = Color.foreground(.green, .bright, .normal);
pub const bright_yellow = Color.foreground(.yellow, .bright, .normal);
pub const bright_blue = Color.foreground(.blue, .bright, .normal);
pub const bright_magenta = Color.foreground(.magenta, .bright, .normal);
pub const bright_cyan = Color.foreground(.cyan, .bright, .normal);
pub const bright_white = Color.foreground(.white, .bright, .normal);
pub const black_bg = Color.background(.black, .dim, .normal);
pub const red_bg = Color.background(.red, .dim, .normal);
pub const green_bg = Color.background(.green, .dim, .normal);
pub const yellow_bg = Color.background(.yellow, .dim, .normal);
pub const blue_bg = Color.background(.blue, .dim, .normal);
pub const magenta_bg = Color.background(.magenta, .dim, .normal);
pub const cyan_bg = Color.background(.cyan, .dim, .normal);
pub const white_bg = Color.background(.white, .dim, .normal);
pub const bright_black_bg = Color.background(.black, .bright, .normal);
pub const bright_red_bg = Color.background(.red, .bright, .normal);
pub const bright_green_bg = Color.background(.green, .bright, .normal);
pub const bright_yellow_bg = Color.background(.yellow, .bright, .normal);
pub const bright_blue_bg = Color.background(.blue, .bright, .normal);
pub const bright_magenta_bg = Color.background(.magenta, .bright, .normal);
pub const bright_cyan_bg = Color.background(.cyan, .bright, .normal);
pub const bright_white_bg = Color.background(.white, .bright, .normal);

/// this will be replaced very soon
pub const Color = enum(u8) {
    default = 0,
    black = 30,
    red,
    green,
    yellow,
    blue,
    magenta,
    cyan,
    white,
    _,

    pub const Brightness = enum(u8) { dim = 0, bright = 1 };
    pub const Style = enum(u8) { normal = 0, underline = 1 };

    pub fn foreground(color: Color, bright: Brightness, underline: Style) Color {
        if (color == .default)
            return color;

        return @intToEnum(Color, (@enumToInt(color) + @enumToInt(bright) * 60) | (@enumToInt(underline) << 7));
    }

    pub fn background(color: Color, bright: Brightness, underline: Style) Color {
        if (color == .default)
            return color;

        return @intToEnum(Color, (@enumToInt(color) + 10 + @enumToInt(bright) * 60) | (@enumToInt(underline) << 7));
    }

    pub fn underlined(color: Color) Color {
        return @intToEnum(Color, @enumToInt(color) | 0x80);
    }

    pub fn is_underline(color: Color) bool {
        return (@enumToInt(color) & 0x80) != 0;
    }

    pub fn get_ansi_code(color: Color) u8 {
        return @enumToInt(color) & 0x7F;
    }
};

const FsError = std.fs.File.WriteError;
const Error = FsError || macro.Error;

/// output writer for all zcon functions, null for stdout
stdout: std.fs.File.Writer,
/// buffered bytes from write calls
buffer: [2048]u8 = undefined,
/// marks end of buffer contents
buffer_end: usize = 0,

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
    var out = this.bufferWriter();
    var indent_writer = IndentWriter.init(&indent_lvl, &trailing_newline, indent_str, WriterProxy.init(&out));
    var macro_writer = MacroWriter.init(zcon_macros, WriterProxy.init(&indent_writer));
    macro_writer.writeAll(str) catch |e| return convert_err(e);
    return str.len;
}

///
pub fn print(this: *This, comptime fmt_str: []const u8, args: anytype) Error!void {
    var out = this.bufferWriter();
    var indent_writer = IndentWriter.init(&indent_lvl, &trailing_newline, indent_str, WriterProxy.init(&out));
    var macro_writer = MacroWriter.init(zcon_macros, WriterProxy.init(&indent_writer));
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
    this.set_cursor(pos);
    this.put(str);
}

///
pub fn fmtAt(this: *This, pos: input.Position, comptime fmt_str: []const u8, args: anytype) void {
    this.set_cursor(pos);
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

///
pub fn setColor(this: *This, color: Color) void {
    write_color(this.bufferWriter(), color);
}

///
pub fn prevColor(this: *This) void {
    write_prev_color(this.bufferWriter());
}

///
pub fn setUnderline(this: *This, u: bool) void {
    write_underline(this.bufferWriter(), u);
}

///
pub fn setBright(this: *This, b: bool) void {
    write_bright(this.bufferWriter(), b);
}

///
fn write_color(writer: anytype, color: Color) void {
    set_color_impl(writer, color);
    color_hist_push(color);
}

///
fn write_prev_color(writer: anytype) void {
    set_color_impl(writer, color_hist_pop());
}

///
pub fn write_underline(writer: anytype, u: bool) void {
    const prev = color_hist_peek(-2);
    write_color(writer, @intToEnum(Color, @enumToInt(prev) & (@boolToInt(u) << 7)));
}

///
pub fn write_bright(writer: anytype, b: bool) void {
    const prev = color_hist_peek(-2);
    if (prev.get_ansi_code() < 90)
        write_color(writer, @intToEnum(Color, @enumToInt(prev) + 60 * @boolToInt(b)))
    else
        write_color(writer, @intToEnum(Color, @enumToInt(prev) - 60 * @boolToInt(!b)));
}

///
fn set_color_impl(writer: anytype, color: Color) void {
    const code = color.get_ansi_code();
    const u: u8 = if (color.is_underline()) 4 else 24;
    writer.print("\x1b[{};{}m", .{ u, code }) catch return;
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
    const macro_writer = MacroWriter.init(zcon_macros, WriterProxy.init(&margin_writer));
    std.fmt.format(macro_writer, fmt_str, args) catch {};
}

/// like print but newlines line up with starting column
pub fn drawAt(this: *This, pos: input.Position, comptime fmt_str: []const u8, args: anytype) void {
    this.setCursor(pos);
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
    defer out.writeAll("\x1b(B") catch {}; // back to norm

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
}

///
pub fn drawBoxAt(this: *This, pos: input.Position, size: input.Size) !void {
    try this.setCursor(pos);
    try this.drawBox(size);
}

var indent_lvl: i32 = 0;
var indent_str: []const u8 = "    ";
var trailing_newline: bool = false;

///
pub const IndentWriter = struct {
    pub const Error = anyerror;
    pub const WriterInterface = std.io.Writer(IndentWriter, IndentWriter.Error, IndentWriter.write);

    lvl: *i32,
    str: []const u8,
    output: WriterProxy,
    trailing_newline: *bool,

    pub fn write(this: IndentWriter, bytes: []const u8) IndentWriter.Error!usize {
        if (this.trailing_newline.*) {
            this.trailing_newline.* = false;
            try this.writeIndent();
        }

        var i: usize = 0;
        while (i < bytes.len) : (i += 1) {
            const start = i;

            while (i < bytes.len and bytes[i] != '\n')
                i += 1;

            try this.output.writeAll(bytes[start..i]);

            if (i >= bytes.len)
                return bytes.len;

            try this.output.writeByte('\n');

            if (i + 1 >= bytes.len) {
                this.trailing_newline.* = true;
                return bytes.len;
            }

            try this.writeIndent();
        }

        return bytes.len;
    }

    pub fn init(lvl: *i32, trailing: *bool, str: []const u8, out_writer: WriterProxy) WriterInterface {
        return .{ .context = IndentWriter{
            .lvl = lvl,
            .str = str,
            .output = out_writer,
            .trailing_newline = trailing,
        } };
    }

    fn writeIndent(this: IndentWriter) !void {
        var l: usize = 0;
        while (l < this.lvl.*) : (l += 1)
            try this.output.writeAll(this.str);
    }
};

///
pub fn indent(amt: i32) void {
    indent_lvl += amt;
    if (indent_lvl < 0)
        indent_lvl = 0;
}

///
pub fn set_indent_str(comptime str: []const u8) void {
    indent_str = str;
}

///
const MarginWriter = struct {
    pub const Error = This.Error;
    pub const WriterInterface = std.io.Writer(MarginWriter, MarginWriter.Error, MarginWriter.write);

    output: WriterProxy,
    column: i16,

    pub fn write(this: MarginWriter, bytes: []const u8) MarginWriter.Error!usize {
        var i: usize = 0;
        while (i < bytes.len) : (i += 1) {
            const start = i;
            while (i < bytes.len and bytes[i] != '\n')
                i += 1;
            this.output.writeAll(bytes[start..i]) catch |e| return convert_err(e);
            if (i >= bytes.len)
                return bytes.len;
            this.output.writeByte('\n') catch |e| return convert_err(e);
            this.output.print("\x1b[{}G", .{this.column}) catch |e| return convert_err(e);
        }

        return bytes.len;
    }

    pub fn init(column: i16, out_writer: WriterProxy) WriterInterface {
        return .{
            .context = .{
                .output = out_writer,
                .column = column,
            },
        };
    }
};

// -- color history junk, TODO: overhaul soon

// circle buffer stack of previous colors
const color_hist_capacity = 32;
var color_hist = [_]Color{.default} ** color_hist_capacity;
var color_hist_next: usize = 0;
var color_hist_available: usize = 0;

///
fn color_hist_inc() void {
    color_hist_next += 1;
    if (color_hist_next >= color_hist.len)
        color_hist_next = 0;
    if (color_hist_available <= color_hist_capacity)
        color_hist_available += 1;
}

///
fn color_hist_dec() void {
    if (color_hist_available == 0)
        return;
    color_hist_available -= 1;
    color_hist_next -%= 1; // wrapping subtraction
    if (color_hist_next >= color_hist.len)
        color_hist_next = color_hist.len - 1;
}

///
fn color_hist_push(color: Color) void {
    color_hist[color_hist_next] = color;
    color_hist_inc();
}

///
fn color_hist_pop() Color {
    color_hist_dec();
    return color_hist_peek(-1);
}

///
fn color_hist_peek(amt: isize) Color {
    if (amt + @intCast(isize, color_hist_available) < 0)
        return .default;

    var i: isize = @intCast(isize, color_hist_next) + amt;

    if (i < 0)
        i += color_hist.len;
    if (i >= color_hist.len)
        i -= color_hist.len;

    return color_hist[@intCast(usize, i)];
}

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
    .{ "def", def_macro },
    .{ "prv", macro_prv },

    .{ "red", red_macro },
    .{ "grn", grn_macro },
    .{ "blu", blu_macro },
    .{ "mag", mag_macro },
    .{ "cyn", cyn_macro },
    .{ "yel", yel_macro },
    .{ "wht", wht_macro },
    .{ "blk", blk_macro },

    .{ "bred", red_macro },
    .{ "bgrn", grn_macro },
    .{ "bblu", blu_macro },
    .{ "bmag", mag_macro },
    .{ "bcyn", cyn_macro },
    .{ "byel", yel_macro },

    .{ "gry", gry_macro },
    .{ "dgry", dgry_macro },

    .{ "rule", rule_macro },
    .{ "box", box_macro },
});

fn def_macro(writer: WriterProxy, param_iter: *ParamIterator) !bool {
    _ = param_iter;
    write_color(writer, .default);
    return true;
}
fn macro_prv(writer: WriterProxy, param_iter: *ParamIterator) !bool {
    _ = param_iter;
    write_prev_color(writer);
    return true;
}
fn red_macro(writer: WriterProxy, param_iter: *ParamIterator) !bool {
    _ = param_iter;
    write_color(writer, .red);
    return true;
}
fn grn_macro(writer: WriterProxy, param_iter: *ParamIterator) !bool {
    _ = param_iter;
    write_color(writer, .green);
    return true;
}
fn blu_macro(writer: WriterProxy, param_iter: *ParamIterator) !bool {
    _ = param_iter;
    write_color(writer, .blue);
    return true;
}
fn mag_macro(writer: WriterProxy, param_iter: *ParamIterator) !bool {
    _ = param_iter;
    write_color(writer, .magenta);
    return true;
}
fn cyn_macro(writer: WriterProxy, param_iter: *ParamIterator) !bool {
    _ = param_iter;
    write_color(writer, .cyan);
    return true;
}
fn yel_macro(writer: WriterProxy, param_iter: *ParamIterator) !bool {
    _ = param_iter;
    write_color(writer, .yellow);
    return true;
}
fn wht_macro(writer: WriterProxy, param_iter: *ParamIterator) !bool {
    _ = param_iter;
    write_color(writer, bright_white);
    return true;
}
fn blk_macro(writer: WriterProxy, param_iter: *ParamIterator) !bool {
    _ = param_iter;
    write_color(writer, .black);
    return true;
}
fn gry_macro(writer: WriterProxy, param_iter: *ParamIterator) !bool {
    _ = param_iter;
    write_color(writer, white);
    return true;
}
fn dgry_macro(writer: WriterProxy, param_iter: *ParamIterator) !bool {
    _ = param_iter;
    write_color(writer, bright_black);
    return true;
}
fn bred_macro(writer: WriterProxy, param_iter: *ParamIterator) !bool {
    _ = param_iter;
    write_color(writer, bright_red);
    return true;
}
fn bgrn_macro(writer: WriterProxy, param_iter: *ParamIterator) !bool {
    _ = param_iter;
    write_color(writer, bright_green);
    return true;
}
fn bblu_macro(writer: WriterProxy, param_iter: *ParamIterator) !bool {
    _ = param_iter;
    write_color(writer, bright_blue);
    return true;
}
fn bmag_macro(writer: WriterProxy, param_iter: *ParamIterator) !bool {
    _ = param_iter;
    write_color(writer, bright_magenta);
    return true;
}
fn bcyn_macro(writer: WriterProxy, param_iter: *ParamIterator) !bool {
    _ = param_iter;
    write_color(writer, bright_cyan);
    return true;
}
fn byel_macro(writer: WriterProxy, param_iter: *ParamIterator) !bool {
    _ = param_iter;
    write_color(writer, bright_yellow);
    return true;
}

fn rule_macro(writer: WriterProxy, param_iter: *ParamIterator) !bool {
    const lstr = param_iter.next();

    if (lstr != null) {
        var l = try std.fmt.parseInt(i16, lstr.?, 10);

        try writer.writeAll("\x1b(0");

        while (l > 0) : (l -= 1) {
            try writer.writeByte('q');
        }

        defer writer.writeAll("\x1b(B") catch {};
    }

    return true;
}

fn box_macro(writer: WriterProxy, param_iter: *ParamIterator) !bool {
    _ = writer;
    _ = param_iter;
    // TODO
    //     const wstr = param_iter.next();
    //     const hstr = param_iter.next();
    //
    //     if (wstr != null and hstr != null) {
    //         const w = try std.fmt.parseInt(i16, wstr.?, 10);
    //         const h = try std.fmt.parseInt(i16, hstr.?, 10);
    //         draw_box(.{ .width = w, .height = h });
    //     }
    //
    //     return true;
    return false;
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