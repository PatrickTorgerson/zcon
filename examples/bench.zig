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

    out.put("#inverse\n");
    out.put("#blk;  #gry;  #red;  #yel;  #grn;  #cyn;  #blu;  #mag;  \n");
    out.put("#dgry;  #wht;  #bred;  #byel;  #bgrn;  #bcyn;  #bblu;  #bmag;  \n");
    out.put("#d");
    out.put("#blk;  #gry;  #red;  #yel;  #grn;  #cyn;  #blu;  #mag;  \n");
    out.put("#dgry;  #wht;  #bred;  #byel;  #bgrn;  #bcyn;  #bblu;  #bmag;  \n");
}
