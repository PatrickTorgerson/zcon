// ********************************************************************************
//  https://github.com/PatrickTorgerson/zcon
//  Copyright (c) 2022 Patrick Torgerson
//  MIT license, see LICENSE for more information
// ********************************************************************************

const std = @import("std");
const zcon = @import("zcon");

pub fn main() !void {
    var out = zcon.Writer.init();
    defer out.flush();
    defer out.useDefaultColors();

    const evens = [_]i32{ 2, 4, 6, 8 };
    const odds = [_]i32{ 1, 3, 5, 7 };

    // new zig 0.11.x feature
    for (&evens, &odds) |even, odd| {
        out.fmt("{}, {}, ", .{ odd, even });
    }
    out.putChar('\n');

    // sundenly for loops are usefull
    // inclusive..exclusive
    for (1..11) |i| {
        out.fmt("({}) ", .{i});
    }
    out.putChar('\n');

    out.put("\n \x1b[31m RED \x1b[91m BRED \n");
    out.fmt("\n \x1b[{}m RED \x1b[{}m BRED \n", .{ 31, 91 });
    out.put("\n #red; RED #bred; BRED \n\n");

    out.setForeground(zcon.Color.col16(.red));
    out.putRaw("  RED");
    out.setForeground(zcon.Color.col16(.bright_red));
    out.putRaw("  BRED\n\n");
}
