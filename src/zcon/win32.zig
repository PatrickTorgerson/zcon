// ********************************************************************************
//  https://github.com/PatrickTorgerson
//  Copyright (c) 2022 Patrick Torgerson
//  MIT license, see LICENSE for more information
// ********************************************************************************

pub const HANDLE = *anyopaque;
pub const BOOL = i32;

pub const CONSOLE_SCREEN_BUFFER_INFO = extern struct {
    dwSize: COORD,
    dwCursorPosition: COORD,
    wAttributes: u16,
    srWindow: SMALL_RECT,
    dwMaximumWindowSize: COORD,
};

pub const COORD = extern struct {
    X: i16,
    Y: i16,
};

pub const SMALL_RECT = extern struct {
    Left: i16,
    Top: i16,
    Right: i16,
    Bottom: i16,
};

pub extern "kernel32" fn GetConsoleScreenBufferInfo(
    hConsoleOutput: ?HANDLE,
    lpConsoleScreenBufferInfo: ?*CONSOLE_SCREEN_BUFFER_INFO,
) callconv(@import("std").os.windows.WINAPI) BOOL;
