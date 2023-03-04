// ********************************************************************************
//  https://github.com/PatrickTorgerson
//  Copyright (c) 2022 Patrick Torgerson
//  MIT license, see LICENSE for more information
// ********************************************************************************

const std = @import("std");

///
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

    /// writes ansi escape code to set fg color
    pub fn writeAnsiFg(color: Color, writer: anytype) !void {
        switch (color) {
            .as_col16 => |col| {
                try writer.print("\x1b[{}m", .{@enumToInt(col)});
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
                try writer.print("\x1b[{}m", .{@enumToInt(col) + 10});
            },
            .as_rgb => |col| {
                try writer.print("\x1b[48;2;{};{};{}m", .{ col.r, col.g, col.b });
            },
        }
    }
};
