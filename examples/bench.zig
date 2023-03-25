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

    out.put("#blink#inverse#du#s#b#i Whoa Dude #n , what bruh");
}
