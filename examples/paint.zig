// ********************************************************************************
//! https://github.com/PatrickTorgerson
//! Copyright (c) 2022 Patrick Torgerson
//! MIT license, see LICENSE for more information
// ********************************************************************************

const std = @import("std");
const zcon = @import("zcon");

var paint_color: zcon.Color = zcon.white_bg;

///
const Rect = struct {
    left: i16 = 0,
    right: i16 = 0,
    top: i16 = 0,
    bottom: i16 = 0,

    fn init(l: i16, r: i16, t: i16, b: i16) Rect {
        return .{
            .left = l,
            .right = r,
            .top = t,
            .bottom = b,
        };
    }

    fn intersect(this: Rect, p: zcon.Position) bool {
        return p.x >= this.left and p.x <= this.right and
            p.y >= this.top and p.y <= this.bottom;
    }

    fn draw(this: Rect, color: zcon.Color) void {
        zcon.set_color(color);

        var x = this.left;
        var y = this.top;

        zcon.set_cursor(.{ .x = x, .y = y });

        while (y <= this.bottom) {
            while (x <= this.right) : (x += 1) {
                zcon.write(" ");
            }
            x = this.left;
            y += 1;
            zcon.set_cursor(.{ .x = x, .y = y });
        }

        zcon.set_color(.default);
    }
};

///
const Swatch = struct {
    bounds: Rect,
    color: zcon.Color,
};

///
const pallete: [14]Swatch = blk: {
    var p = [14]Swatch{
        .{ .bounds = .{}, .color = zcon.bright_white_bg },
        .{ .bounds = .{}, .color = zcon.bright_black_bg }, // grey

        .{ .bounds = .{}, .color = zcon.red_bg },
        .{ .bounds = .{}, .color = zcon.bright_red_bg },

        .{ .bounds = .{}, .color = zcon.green_bg },
        .{ .bounds = .{}, .color = zcon.bright_green_bg },

        .{ .bounds = .{}, .color = zcon.blue_bg },
        .{ .bounds = .{}, .color = zcon.bright_blue_bg },

        .{ .bounds = .{}, .color = zcon.magenta_bg },
        .{ .bounds = .{}, .color = zcon.bright_magenta_bg },

        .{ .bounds = .{}, .color = zcon.yellow_bg },
        .{ .bounds = .{}, .color = zcon.bright_yellow_bg },

        .{ .bounds = .{}, .color = zcon.cyan_bg },
        .{ .bounds = .{}, .color = zcon.bright_cyan_bg },
    };

    const ydistance = 3;
    const col1_left = 3;
    const col1_right = 6; // 3456 = 4 wide
    const top_start = 3;
    const height = 2;

    // set bounds
    var i: i16 = 0;
    for (p) |*swatch| {
        const col1 = i % 2 == 0;

        const left = if (col1) col1_left else col1_left + 6;
        const right = if (col1) col1_right else col1_right + 6;
        const top = (@divTrunc(i, 2) * ydistance) + top_start;
        const bottom = top + height - 1;

        swatch.bounds.left = left;
        swatch.bounds.right = right;
        swatch.bounds.top = top;
        swatch.bounds.bottom = bottom;

        i += 1;
    }

    break :blk p;
};

///
fn sample_pallete(pos: zcon.Position) bool {
    for (pallete) |swatch| {
        if (swatch.bounds.intersect(pos)) {
            paint_color = swatch.color;
            return true;
        }
    }
    return false;
}

///
fn draw_pallete() void {
    for (pallete) |swatch| {
        swatch.bounds.draw(swatch.color);
    }
}

///
pub fn main() !void {
    try zcon.enable_input_events();
    zcon.alternate_buffer();
    defer zcon.main_buffer();
    zcon.show_cursor(false);
    zcon.clear_buffer();

    draw_pallete();

    var left_mouse_down: bool = false;
    var right_mouse_down: bool = false;

    while (true) {
        while (zcon.poll_input()) |input| {
            switch (input) {
                .key_pressed => |key| {
                    // escape to quit
                    if (key.equals(.escape, .{}))
                        return;
                    // ctrl+c to quit
                    if (key.equals(.c, .{.ctrl}))
                        return;

                    // space clearscreen
                    if (key.equals(.space, .{})) {
                        zcon.clear_buffer();
                        draw_pallete();
                    }
                },

                .mouse_pressed => |button| {
                    _ = sample_pallete(button.pos);

                    if (button.equals(.left, .{}))
                        left_mouse_down = true;
                    if (button.equals(.right, .{}))
                        right_mouse_down = true;
                },

                .mouse_released => |button| {
                    if (button.equals(.left, .{}))
                        left_mouse_down = false;
                    if (button.equals(.right, .{}))
                        right_mouse_down = false;
                },

                .mouse_move => |pos| {
                    if (pos.x <= pallete[1].bounds.right + 1)
                        continue;

                    var color: zcon.Color = undefined;

                    if (left_mouse_down)
                        color = paint_color
                    else if (right_mouse_down)
                        color = .default
                    else
                        continue;

                    zcon.set_color(color);
                    zcon.write_at(pos, " ");
                },

                else => {},
            }
        }
    }
}
