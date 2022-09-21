// ********************************************************************************
//! https://github.com/PatrickTorgerson
//! Copyright (c) 2022 Patrick Torgerson
//! MIT license, see LICENSE for more information
// ********************************************************************************

const std = @import("std");
const zcon = @import("zcon");

const Task = struct {
    label: []const u8,
    complete: bool = false,

    pub fn init(allocator: std.mem.Allocator, label: []const u8) !Task {
        return Task.dupe(.{ .label = label }, allocator);
    }

    pub fn deinit(this: *Task, allocator: std.mem.Allocator) void {
        allocator.free(this.label);
        this.* = undefined;
    }

    pub fn dupe(this: Task, allocator: std.mem.Allocator) !Task {
        var buff = try allocator.alloc(u8, this.label.len);
        std.mem.copy(u8, buff, this.label);
        return Task{
            .label = buff,
        };
    }

    pub fn render(this: Task) void {
        if (this.complete)
            zcon.write("[*]")
        else
            zcon.write("[ ]");
        zcon.print(" {s: <40}\n", .{this.label});
    }
};

const List = struct {
    label: []const u8,
    items: std.ArrayList(Task),

    pub fn init(allocator: std.mem.Allocator, label: []const u8) !List {
        var buff = try allocator.alloc(u8, label.len);
        std.mem.copy(u8, buff, label);
        return List{
            .label = buff,
            .items = std.ArrayList(Task).init(allocator),
        };
    }

    pub fn deinit(this: *List, allocator: std.mem.Allocator) void {
        allocator.free(this.label);
        for (this.items.items) |*item| {
            item.deinit(allocator);
        }
        this.items.deinit();
        this.* = undefined;
    }

    pub fn add_task(this: *List, task: Task, allocator: std.mem.Allocator) !void {
        try this.items.append(try task.dupe(allocator));
    }

    pub fn render(this: List) void {
        zcon.print("{s}:\n", .{this.label});
        zcon.indent(1);
        defer zcon.indent(-1);

        for (this.items.items) |item|
            item.render();
    }
};

var root: List = undefined;
var root_i: usize = 0;

pub fn main() !void {
    try zcon.enable_input_events();

    zcon.alternate_buffer();
    defer zcon.main_buffer();

    zcon.show_cursor(false);
    zcon.clear_buffer();

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    var allocator = gpa.allocator();

    root = try List.init(allocator, "root");

    var size = try zcon.get_buffer_size();
    var command: bool = false;
    var command_buffer = [_]u8{0} ** 128;
    var command_i: usize = 0;

    render_root(size);

    loop: while (true)
        while (zcon.poll_input()) |input| {
            switch (input) {
                .key_pressed => |key| {
                    if (key.equals(.c, .{.ctrl})) {
                        break :loop;
                    } else if (command) {
                        if (key.equals(.enter, .{})) {
                            command = false;

                            zcon.show_cursor(false);
                            try do_command(allocator, command_buffer[0..command_i]);
                            render_root(size);
                        } else if (key.equals(.backspace, .{})) {
                            if (command_i > 0) {
                                zcon.backspace();
                                command_i -= 1;
                            }
                        } else if (key.equals(.backspace, .{.ctrl})) {
                            if (command_i > 0) {
                                while (command_buffer[command_i - 1] == ' ') {
                                    command_i -= 1;
                                    if (command_i <= 0) break;
                                }
                                while (command_i > 0 and command_buffer[command_i - 1] != ' ') {
                                    command_i -= 1;
                                    if (command_i <= 0) break;
                                }
                                zcon.clear_line();
                                zcon.set_cursor(.{ .x = 1, .y = size.height });
                                zcon.print(": {s}", .{command_buffer[0..command_i]});
                            }
                        } else if (key.char) |char| {
                            zcon.print("{u}", .{char});
                            command_buffer[command_i] = char;
                            command_i += 1;
                        }
                    } else if (key.equals(.semicolon, .{.shift})) {
                        zcon.set_cursor(.{ .x = 1, .y = size.height });
                        zcon.write(": ");
                        command_i = 0;
                        zcon.show_cursor(true);
                        command = true;
                    } else if (key.equals(.up, .{})) {
                        if (root_i > 0)
                            root_i -= 1;
                        render_root(size);
                    } else if (key.equals(.down, .{})) {
                        if (root.items.items.len > 0 and root_i < root.items.items.len - 1)
                            root_i += 1;
                        render_root(size);
                    } else if (key.equals(.space, .{})) {
                        if (root.items.items.len > 0)
                            root.items.items[root_i].complete = !root.items.items[root_i].complete;
                        render_root(size);
                    }
                },
                .buffer_resize => |s| {
                    size = s;
                    render_root(size);
                },
                else => {},
            }
        };

    // free memory and check for leaks
    root.deinit(allocator);
    zcon.clear_buffer();
    zcon.set_cursor(.{ .x = 1, .y = 1 });
    if (gpa.detectLeaks()) {
        // hang
        while (true)
            while (zcon.poll_input()) |input| {
                switch (input) {
                    .key_pressed => |_| return error.leaks_detected,
                    else => {},
                }
            };
    }
}

pub fn render_root(size: zcon.Size) void {
    zcon.clear_buffer();
    zcon.set_cursor(.{ .x = 1, .y = 1 });
    zcon.print("// TODO: {}, {}", .{ size.width, size.height });
    zcon.draw_box_at(.{ .x = 1, .y = 2 }, size.resized(0, -2));
    zcon.set_cursor(.{ .x = 2, .y = 3 });
    for (root.items.items) |item, i| {
        if (i == root_i)
            zcon.set_color(zcon.bright_black_bg);
        zcon.set_cursor_x(2);
        item.render();
        zcon.set_color(.default);
    }
}

fn do_command(allocator: std.mem.Allocator, command: []const u8) !void {
    try root.add_task(.{ .label = command }, allocator);
}
