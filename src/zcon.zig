// ********************************************************************************
//  https://github.com/PatrickTorgerson/zcon
//  Copyright (c) 2022 Patrick Torgerson
//  MIT license, see LICENSE for more information
// ********************************************************************************
const std = @import("std");

pub const Writer = @import("zcon/Writer.zig");
pub const WriterProxy = @import("zcon/WriterProxy.zig");
pub const Color = @import("zcon/color.zig").Color;
pub const Cli = @import("zcon/Cli.zig");

pub usingnamespace @import("zcon/input.zig");
pub usingnamespace @import("zcon/macro.zig");

test "zcon" {
    std.testing.refAllDecls(@This());
}
