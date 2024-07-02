// ********************************************************************************
//  https://github.com/PatrickTorgerson/zcon
//  Copyright (c) 2022 Patrick Torgerson
//  MIT license, see LICENSE for more information
// ********************************************************************************

const std = @import("std");

pub const Writer = @import("Writer.zig");
pub const Color = @import("color.zig").Color;
pub const MacroFn = macro.MacroFn;
pub const MacroMap = macro.MacroMap;
pub const ParamIterator = macro.ParamIterator;
pub const MacroWriter = macro.MacroWriter;
pub const expandMacros = macro.expandMacros;

const macro = @import("macro.zig");

test {
    std.testing.refAllDecls(@This());
}
