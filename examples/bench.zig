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
        .desc = "print some useless information",
        .help = "RIP",
    });

    try cli.add_option(.{
        .alias_long = "name",
        .alias_short = "n",
        .desc = "<NAME> ; sets a name (just prints lol)",
        .help = "RIP",
    });

    if (!try cli.parse()) {}
}

fn do_option(cli: *zcon.Cli) !bool {

    if (cli.is_arg("test-option")) {
        zcon.write("Goats are the best climbers of any mammel!\n");
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
