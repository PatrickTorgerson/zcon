// ********************************************************************************
//  https://github.com/PatrickTorgerson
//  Copyright (c) 2024 Patrick Torgerson
//  MIT license, see LICENSE for more information
// ********************************************************************************

const std = @import("std");

pub const Color = union(enum) {
    /// 16 bit color
    const Col16 = enum(u8) {
        black = 30,
        red,
        green,
        yellow,
        blue,
        magenta,
        cyan,
        gray,
        dark_gray = 90,
        bright_red,
        bright_green,
        bright_yellow,
        bright_blue,
        bright_magenta,
        bright_cyan,
        white,
    };

    /// rgb color values
    const Rgb = struct { r: u8, g: u8, b: u8 };

    as_col16: Col16,
    as_rgb: Rgb,

    /// create color from 16 bit
    pub fn col16(col: Col16) Color {
        return .{
            .as_col16 = col,
        };
    }

    /// create color from rgb
    /// note, not all terminals support rgb
    pub fn rgb(r: u8, g: u8, b: u8) Color {
        return .{
            .as_rgb = .{
                .r = r,
                .g = g,
                .b = b,
            },
        };
    }

    /// create color from hex code
    /// note, not all terminals support rgb
    pub fn hex(code: []const u8) ?Color {
        if (code.len != 3 and code.len != 6)
            return null;
        const byte_len = code.len / 3;
        return Color{
            .as_rgb = .{
                .r = hexToByte(code[0..byte_len]) orelse return null,
                .g = hexToByte(code[byte_len .. byte_len * 2]) orelse return null,
                .b = hexToByte(code[byte_len * 2 .. byte_len * 3]) orelse return null,
            },
        };
    }

    /// writes ansi escape code to set fg color
    pub fn writeAnsiFg(color: Color, writer: anytype) !void {
        switch (color) {
            .as_col16 => |col| {
                try writer.print("\x1b[{}m", .{@intFromEnum(col)});
            },
            .as_rgb => |col| {
                try writer.print("\x1b[38;2;{};{};{}m", .{ col.r, col.g, col.b });
            },
        }
    }

    /// writes ansi escape code to set bg color
    pub fn writeAnsiBg(color: Color, writer: anytype) !void {
        switch (color) {
            .as_col16 => |col| {
                try writer.print("\x1b[{}m", .{@intFromEnum(col) + 10});
            },
            .as_rgb => |col| {
                try writer.print("\x1b[48;2;{};{};{}m", .{ col.r, col.g, col.b });
            },
        }
    }

    fn hexToByte(code: []const u8) ?u8 {
        return if (code.len == 2)
            std.fmt.parseInt(u8, code, 16) catch null
        else if (code.len == 1)
            switch (code[0]) {
                '0' => std.fmt.parseInt(u8, "00", 16) catch null,
                '1' => std.fmt.parseInt(u8, "10", 16) catch null,
                '2' => std.fmt.parseInt(u8, "20", 16) catch null,
                '3' => std.fmt.parseInt(u8, "30", 16) catch null,
                '4' => std.fmt.parseInt(u8, "40", 16) catch null,
                '5' => std.fmt.parseInt(u8, "50", 16) catch null,
                '6' => std.fmt.parseInt(u8, "60", 16) catch null,
                '7' => std.fmt.parseInt(u8, "70", 16) catch null,
                '8' => std.fmt.parseInt(u8, "80", 16) catch null,
                '9' => std.fmt.parseInt(u8, "90", 16) catch null,
                'a', 'A' => std.fmt.parseInt(u8, "a0", 16) catch null,
                'b', 'B' => std.fmt.parseInt(u8, "b0", 16) catch null,
                'c', 'C' => std.fmt.parseInt(u8, "c0", 16) catch null,
                'd', 'D' => std.fmt.parseInt(u8, "d0", 16) catch null,
                'e', 'E' => std.fmt.parseInt(u8, "e0", 16) catch null,
                'f', 'F' => std.fmt.parseInt(u8, "f0", 16) catch null,
                else => null,
            }
        else
            null;
    }
};
