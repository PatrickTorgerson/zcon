const std = @import("std");
const zcon = @import("zcon");

pub fn main() !void {
    std.debug.print("std.debug.print\n", .{});

    zcon.write("start me up : ");
    zcon.indent(1);
    zcon.write("zcon.write #red red?\nyuss\n");

    zcon.set_color(.default);
}
