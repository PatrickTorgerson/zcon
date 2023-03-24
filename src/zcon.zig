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
pub const InputQueue = @import("zcon/InputQueue.zig");
pub const Input = InputQueue.Input;
pub const Position = InputQueue.Position;
pub const Size = InputQueue.Size;
pub const ButtonCode = InputQueue.ButtonCode;
pub const Button = InputQueue.Button;
pub const KeyCode = InputQueue.KeyCode;
pub const InputModifiers = InputQueue.InputModifiers;
pub const Key = InputQueue.Key;

pub usingnamespace @import("zcon/macro.zig");

const win32 = @import("zigwin32");

pub fn getBufferSize() !Size {
    const out = std.io.getStdOut();
    var csbi: win32.system.console.CONSOLE_SCREEN_BUFFER_INFO = undefined;
    if (win32.system.console.GetConsoleScreenBufferInfo(out.handle, &csbi) == 0)
        return error.get_console_info_fail;
    return Size{ .width = csbi.dwSize.X, .height = csbi.dwSize.Y };
}

test "zcon" {
    std.testing.refAllDecls(@This());
}
