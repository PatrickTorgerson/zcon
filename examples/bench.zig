const std = @import("std");
const zcon = @import("zcon");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}) {};
    defer _ = gpa.deinit();
    var allocator = gpa.allocator();

    var cli = try zcon.Cli.init(allocator, do_option, do_input);
    defer cli.deinit();

    try cli.add_option(.{
        .alias_long = "test-option",
        .alias_short = "t",
        .desc = "do box <W> by <H>",
        .help = "RIP",
        .arguments = "<W> <H>"
    });

    try cli.add_option(.{
        .alias_long = "name",
        .alias_short = "n",
        .desc = "sets a name (just prints lol)",
        .help = "RIP",
        .arguments = "<NAME>",
    });

    if (!try cli.parse()) {}
}

fn do_option(cli: *zcon.Cli) !bool {

    if (cli.is_arg("test-option")) {
        const width  = try cli.read_arg(i16) orelse return false;
        const height = try cli.read_arg(i16) orelse return false;
        zcon.draw_box(.{.width = width , .height = height});
        zcon.cursor_down(height);
        zcon.write("\n");
    }
    else if (cli.is_arg("name")) {
        if (try cli.read_arg([]const u8)) |name| {
            zcon.print("name set to {s}\n", .{name});
        }
    }

    return true;
}

fn do_input(cli: *zcon.Cli) !bool {
    zcon.print("Oops, you dropped this useless garbage; '{s}'\n", .{cli.current_arg});
    return true;
}
