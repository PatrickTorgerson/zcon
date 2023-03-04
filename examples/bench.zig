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

    out.setBackground(zcon.Color.rgb(100, 50, 50));
    out.put("#red one #grn two #blu three #prv four #prv five #prv six #prv seven\n");
}
