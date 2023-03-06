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

    out.putRaw("\n\n\n");
    out.setForeground(zcon.Color.hex("a2a") orelse zcon.Color.col16(.red));

    out.put("#box:21,3    Hello friend!");
    out.cursorDown(5);
    out.put("#down:5 #left:20 hello#indent friend");
    out.put("#up:5 (printed last)");
    out.put("#down:5 #fg#bg #repeat:once  #repeat:' Many',5");
}
