// ********************************************************************************
//  https://github.com/PatrickTorgerson
//  Copyright (c) 2022 Patrick Torgerson
//  MIT license, see LICENSE for more information
// ********************************************************************************

const std = @import("std");
const zcon = @import("zcon");

paint_color: zcon.Color = zcon.Color.col16(.white),
left_mouse_down: bool = false,
right_mouse_down: bool = false,

const This = @This();

fn run(this: *This, writer: *zcon.Writer) !void {
    var queue = try zcon.InputQueue.init();

    drawPallete(writer);
    writer.flush();

    while (true) {
        while (queue.pollInput()) |input| {
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
                        writer.useDefaultColors();
                        writer.clearScreen();
                        drawPallete(writer);
                    }
                },

                .mouse_pressed => |button| {
                    _ = this.samplePallete(button.pos);

                    if (button.equals(.left, .{}))
                        this.left_mouse_down = true;
                    if (button.equals(.right, .{}))
                        this.right_mouse_down = true;

                    this.drawAt(writer, button.pos);
                },

                .mouse_released => |button| {
                    if (button.equals(.left, .{}))
                        this.left_mouse_down = false;
                    if (button.equals(.right, .{}))
                        this.right_mouse_down = false;
                },

                .mouse_move => |pos| {
                    this.drawAt(writer, pos);
                },

                else => {},
            }
            writer.flush();
        }
    }
}

/// set paint color from pallete swatch at pos
fn samplePallete(this: *This, pos: zcon.Position) bool {
    for (pallete) |swatch| {
        if (swatch.bounds.intersect(pos)) {
            this.paint_color = swatch.color;
            return true;
        }
    }
    return false;
}

/// draw single pixel at pos
fn drawAt(this: This, writer: *zcon.Writer, pos: zcon.Position) void {
    if (pos.x <= pallete[1].bounds.right + 1)
        return;
    if (this.left_mouse_down)
        writer.setBackground(this.paint_color)
    else if (this.right_mouse_down)
        writer.useDefaultColors()
    else
        return;
    writer.putAt(pos, " ");
}

pub fn main() !void {
    var writer = zcon.Writer.init();
    defer writer.flush();

    writer.useDedicatedScreen();
    defer writer.useDefaultScreen();

    writer.showCursor(false);
    writer.clearScreen();

    var this = This{};
    try this.run(&writer);
}

fn drawPallete(writer: *zcon.Writer) void {
    for (pallete) |swatch| {
        swatch.bounds.draw(writer, swatch.color);
    }
}

const pallete: [14]Swatch = blk: {
    var p = [14]Swatch{
        .{ .bounds = .{}, .color = zcon.Color.col16(.white) },
        .{ .bounds = .{}, .color = zcon.Color.col16(.dark_gray) },

        .{ .bounds = .{}, .color = zcon.Color.col16(.red) },
        .{ .bounds = .{}, .color = zcon.Color.col16(.bright_red) },

        .{ .bounds = .{}, .color = zcon.Color.col16(.green) },
        .{ .bounds = .{}, .color = zcon.Color.col16(.bright_green) },

        .{ .bounds = .{}, .color = zcon.Color.col16(.blue) },
        .{ .bounds = .{}, .color = zcon.Color.col16(.bright_blue) },

        .{ .bounds = .{}, .color = zcon.Color.col16(.magenta) },
        .{ .bounds = .{}, .color = zcon.Color.col16(.bright_magenta) },

        .{ .bounds = .{}, .color = zcon.Color.col16(.yellow) },
        .{ .bounds = .{}, .color = zcon.Color.col16(.bright_yellow) },

        .{ .bounds = .{}, .color = zcon.Color.col16(.cyan) },
        .{ .bounds = .{}, .color = zcon.Color.col16(.bright_cyan) },
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

    fn draw(this: Rect, writer: *zcon.Writer, color: zcon.Color) void {
        writer.setBackground(color);

        var x = this.left;
        var y = this.top;

        writer.setCursor(.{ .x = x, .y = y });

        while (y <= this.bottom) {
            while (x <= this.right) : (x += 1) {
                writer.putChar(' ');
            }
            x = this.left;
            y += 1;
            writer.setCursor(.{ .x = x, .y = y });
        }

        writer.useDefaultColors();
    }
};

const Swatch = struct {
    bounds: Rect,
    color: zcon.Color,
};
