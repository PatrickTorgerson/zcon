// ********************************************************************************
//! https://github.com/PatrickTorgerson/zcon
//! Copyright (c) 2022 Patrick Torgerson
//! MIT license, see LICENSE for more information
// ********************************************************************************

const std = @import("std");

pub const GenericWriter = @import("zcon/generic_writer.zig").GenericWriter;
pub const Cli = @import("zcon/Cli.zig");
pub usingnamespace @import("zcon/macro.zig");
pub usingnamespace @import("zcon/input.zig");
pub usingnamespace @import("zcon/output.zig");

test "zcon" {
    std.testing.refAllDecls(@This());
}
