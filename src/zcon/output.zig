// ********************************************************************************
//! https://github.com/PatrickTorgerson
//! Copyright (c) 2022 Patrick Torgerson
//! MIT license, see LICENSE for more information
// ********************************************************************************

const std = @import("std");
const builtin = @import("builtin");
const win32 = @import("../zigwin32/win32.zig").system.console;

const GenericWriter = @import("generic_writer.zig").GenericWriter;

const macro = @import("macro.zig");
const MacroMap = macro.MacroMap;
const ParamIterator = macro.ParamIterator;
const MacroWriter = macro.MacroWriter;

const input = @import("input.zig");

///
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

///
pub fn set_color(color: Color) void {
    const out = std.io.getStdOut().writer();
    write_color(out, color);
}

///
pub fn prev_color() void {
    const out = std.io.getStdOut().writer();
    write_prev_color(out);
}

///
pub fn set_underline(u: bool) void {
    const out = std.io.getStdOut().writer();
    write_underline(out, u);
}

///
pub fn set_bright(b: bool) void {
    const out = std.io.getStdOut().writer();
    write_bright(out, b);
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
pub fn set_margins(top: i16, bottom: i16) void {
    const size = input.get_buffer_size() catch return;
    print("\x1b[{};{}r", .{ top, size.height - bottom });
}

///
pub fn set_cursor(pos: input.Position) void {
    print("\x1b[{};{}H", .{ pos.y, pos.x });
}

///
pub fn set_cursor_x(x: i16) void {
    print("\x1b[{}G", .{x});
}

///
pub fn set_cursor_y(y: i16) void {
    print("\x1b[{}d", .{y});
}

///
pub fn cursor_right(amt: i16) void {
    print("\x1b[{}C", .{amt});
}

///
pub fn cursor_left(amt: i16) void {
    print("\x1b[{}D", .{amt});
}

///
pub fn cursor_up(amt: i16) void {
    print("\x1b[{}A", .{amt});
}

///
pub fn cursor_down(amt: i16) void {
    print("\x1b[{}B", .{amt});
}

///
pub fn show_cursor(show: bool) void {
    if (show)
        write("\x1b[?25h")
    else
        write("\x1b[?25l");
}

///
pub fn alternate_buffer() void {
    const out = std.io.getStdOut();
    out.writeAll("\x1b[?1049h") catch return;
}

///
pub fn main_buffer() void {
    const out = std.io.getStdOut();
    out.writeAll("\x1b[?1049l") catch return;
}

/// clears bufffer with current bg color
pub fn clear_buffer() void {
    const out = std.io.getStdOut();
    out.writeAll("\x1b[2J") catch return;
}

/// clears the row the cursor is on with current bg color
pub fn clear_line() void {
    const out = std.io.getStdOut();
    out.writeAll("\x1b[1M") catch return;
}

/// windows only
pub fn enable_input_events() !void {
    const stdin = std.io.getStdIn();
    var mode: win32.CONSOLE_MODE = undefined;
    mode = @intToEnum(win32.CONSOLE_MODE, @enumToInt(win32.ENABLE_MOUSE_INPUT) |
        @enumToInt(win32.ENABLE_WINDOW_INPUT) |
        @enumToInt(win32.ENABLE_INSERT_MODE) |
        @enumToInt(win32.ENABLE_EXTENDED_FLAGS));
    if (win32.SetConsoleMode(stdin.handle, mode) == 0)
        return error.could_not_enable_input_events;
}

///
pub fn backspace() void {
    write("\x1b[1D \x1b[1D");
}

///
pub fn write(str: []const u8) void {
    const out = std.io.getStdOut().writer();

    var indent_writer = IndentWriter.init(&indent_lvl, &trailing_newline, indent_str, GenericWriter.init(&out));
    var macro_writer = MacroWriter.init(zcon_macros, GenericWriter.init(&indent_writer));
    macro_writer.writeAll(str) catch return;
}

///
pub fn print(comptime fmt: []const u8, args: anytype) void {
    const out = std.io.getStdOut().writer();

    var indent_writer = IndentWriter.init(&indent_lvl, &trailing_newline, indent_str, GenericWriter.init(&out));
    var macro_writer = MacroWriter.init(zcon_macros, GenericWriter.init(&indent_writer));
    std.fmt.format(macro_writer, fmt, args) catch return;
}

///
pub fn write_at(pos: input.Position, str: []const u8) void {
    set_cursor(pos);
    write(str);
}

///
pub fn print_at(pos: input.Position, comptime fmt: []const u8, args: anytype) void {
    set_cursor(pos);
    print(fmt, args);
}

/// like print but newlines line up with starting column
pub fn draw(pos: input.Position, comptime fmt: []const u8, args: anytype) void {
    const out = std.io.getStdOut().writer();

    set_cursor(pos);
    const column = pos.x;
    const margin_writer = MarginWriter.init(column, out);
    const macro_writer = MacroWriter.init(zcon_macros, margin_writer);
    std.fmt.format(macro_writer, fmt, args) catch return;
}

/// leaves cursor pos at top left corner inside box
pub fn draw_box(size: input.Size) void {
    const stdout = std.io.getStdOut();
    var csbi: win32.CONSOLE_SCREEN_BUFFER_INFO = undefined;
    if (win32.GetConsoleScreenBufferInfo(stdout.handle, &csbi) == 0)
        return;
    const column = csbi.dwCursorPosition.X + 1;
    const out = MarginWriter.init(column, stdout.writer());

    out.writeAll("\x1b(0") catch return;
    defer out.writeAll("\x1b(B") catch {};

    var y: i16 = 0;
    while (y < size.height) : (y += 1) {
        if (y == 0) {
            out.writeByte('l') catch return;
            var x: i16 = 1;
            while (x < size.width - 1) : (x += 1)
                out.writeByte('q') catch return;
            out.writeByte('k') catch return;
            out.writeByte('\n') catch return;
        } else if (y == size.height - 1) {
            out.writeByte('m') catch return;
            var x: i16 = 1;
            while (x < size.width - 1) : (x += 1)
                out.writeByte('q') catch return;
            out.writeByte('j') catch return;
            out.writeByte('\n') catch return;
        } else out.print("x\x1b[{}Cx\n", .{size.width - 2}) catch return;
    }
}

///
pub fn draw_box_at(pos: input.Position, size: input.Size) void {
    set_cursor(pos);
    draw_box(size);
}

var indent_lvl: i32 = 0;
var indent_str: []const u8 = "  ";
var trailing_newline: bool = false;

///
pub const IndentWriter = struct {
    pub const Error = anyerror;
    pub const Writer = std.io.Writer(IndentWriter, Error, IndentWriter.write);

    lvl: *i32,
    str: []const u8,
    output: GenericWriter,
    trailing_newline: *bool,

    pub fn write(this: IndentWriter, bytes: []const u8) Error!usize {
        if (this.trailing_newline.*) {
            this.trailing_newline.* = false;
            try this.write_indent();
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

            try this.write_indent();
        }

        return bytes.len;
    }

    pub fn init(lvl: *i32, trailing: *bool, str: []const u8, out_writer: GenericWriter) Writer {
        return .{ .context = IndentWriter{
            .lvl = lvl,
            .str = str,
            .output = out_writer,
            .trailing_newline = trailing,
        } };
    }

    fn write_indent(this: IndentWriter) !void {
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
pub const MarginWriter = struct {
    pub const Error = anyerror;
    pub const Writer = std.io.Writer(MarginWriter, Error, MarginWriter.write);

    output: GenericWriter,
    column: i16,

    pub fn write(this: MarginWriter, bytes: []const u8) Error!usize {
        var i: usize = 0;
        while (i < bytes.len) : (i += 1) {
            const start = i;

            while (i < bytes.len and bytes[i] != '\n')
                i += 1;

            try this.output.writeAll(bytes[start..i]);

            if (i >= bytes.len)
                return bytes.len;

            try this.output.writeByte('\n');

            try this.output.print("\x1b[{}G", .{this.column});
        }

        return bytes.len;
    }

    pub fn init(column: i16, out_writer: anytype) Writer {
        return .{
            .context = .{
                .output = GenericWriter.init(&out_writer),
                .column = column,
            },
        };
    }
};

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

// -- macros

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

fn def_macro(writer: GenericWriter, param_iter: *ParamIterator) !bool {
    _ = param_iter;
    write_color(writer, .default);
    return true;
}
fn macro_prv(writer: GenericWriter, param_iter: *ParamIterator) !bool {
    _ = param_iter;
    write_prev_color(writer);
    return true;
}
fn red_macro(writer: GenericWriter, param_iter: *ParamIterator) !bool {
    _ = param_iter;
    write_color(writer, .red);
    return true;
}
fn grn_macro(writer: GenericWriter, param_iter: *ParamIterator) !bool {
    _ = param_iter;
    write_color(writer, .green);
    return true;
}
fn blu_macro(writer: GenericWriter, param_iter: *ParamIterator) !bool {
    _ = param_iter;
    write_color(writer, .blue);
    return true;
}
fn mag_macro(writer: GenericWriter, param_iter: *ParamIterator) !bool {
    _ = param_iter;
    write_color(writer, .magenta);
    return true;
}
fn cyn_macro(writer: GenericWriter, param_iter: *ParamIterator) !bool {
    _ = param_iter;
    write_color(writer, .cyan);
    return true;
}
fn yel_macro(writer: GenericWriter, param_iter: *ParamIterator) !bool {
    _ = param_iter;
    write_color(writer, .yellow);
    return true;
}
fn wht_macro(writer: GenericWriter, param_iter: *ParamIterator) !bool {
    _ = param_iter;
    write_color(writer, bright_white);
    return true;
}
fn blk_macro(writer: GenericWriter, param_iter: *ParamIterator) !bool {
    _ = param_iter;
    write_color(writer, .black);
    return true;
}
fn gry_macro(writer: GenericWriter, param_iter: *ParamIterator) !bool {
    _ = param_iter;
    write_color(writer, white);
    return true;
}
fn dgry_macro(writer: GenericWriter, param_iter: *ParamIterator) !bool {
    _ = param_iter;
    write_color(writer, bright_black);
    return true;
}
fn bred_macro(writer: GenericWriter, param_iter: *ParamIterator) !bool {
    _ = param_iter;
    write_color(writer, bright_red);
    return true;
}
fn bgrn_macro(writer: GenericWriter, param_iter: *ParamIterator) !bool {
    _ = param_iter;
    write_color(writer, bright_green);
    return true;
}
fn bblu_macro(writer: GenericWriter, param_iter: *ParamIterator) !bool {
    _ = param_iter;
    write_color(writer, bright_blue);
    return true;
}
fn bmag_macro(writer: GenericWriter, param_iter: *ParamIterator) !bool {
    _ = param_iter;
    write_color(writer, bright_magenta);
    return true;
}
fn bcyn_macro(writer: GenericWriter, param_iter: *ParamIterator) !bool {
    _ = param_iter;
    write_color(writer, bright_cyan);
    return true;
}
fn byel_macro(writer: GenericWriter, param_iter: *ParamIterator) !bool {
    _ = param_iter;
    write_color(writer, bright_yellow);
    return true;
}

fn rule_macro(writer: GenericWriter, param_iter: *ParamIterator) !bool {
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

fn box_macro(writer: GenericWriter, param_iter: *ParamIterator) !bool {
    // rip
    _ = writer;
    const wstr = param_iter.next();
    const hstr = param_iter.next();

    if (wstr != null and hstr != null) {
        const w = try std.fmt.parseInt(i16, wstr.?, 10);
        const h = try std.fmt.parseInt(i16, hstr.?, 10);
        draw_box(.{ .width = w, .height = h });
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
