// ********************************************************************************
//! https://github.com/PatrickTorgerson
//! Copyright (c) 2022 Patrick Torgerson
//! MIT license, see LICENSE for more information
// ********************************************************************************

const std = @import("std");
const win32 = @import("win32.zig");

///
pub const Input = union(enum)
{
    key_pressed: Key,
    key_released: Key,

    mouse_pressed: Button,
    mouse_released: Button,
    mouse_move: Position,
    mouse_scroll: i16,

    buffer_resize: Size,
    focus: bool,
};

///
pub const Position = struct
{
    x: i16 = 1,
    y: i16 = 1,
};

///
pub const Size = struct
{
    width: i16 = 1,
    height: i16 = 1,

    pub fn resize(this: *Size, delta_width: i16, delta_height: i16) void {
        this = this.resized(delta_width, delta_height);
    }

    pub fn resized(this: Size, delta_width: i16, delta_height: i16) Size {
        return .{
            .width = this.width + delta_width,
            .height = this.height + delta_height,
        };
    }
};

///
pub const ButtonCode = enum(u16)
{
    left = 1,
    right = 2,
    middle = 4,
};

pub const Button = struct
{
    pos: Position,
    code: ButtonCode,
    modifiers: InputModifiers,

    pub fn equals(this: Button, code: ButtonCode, modifiers: anytype) bool
    {
        return this.code == code and this.modifiers.matches(modifiers);
    }
};

///
pub const KeyCode = enum(u16)
{
    backspace = 8,
    tab = 9,
    clear = 12,
    enter = 13,
    shift = 16,
    contol = 17,
    alt = 18,
    pausebreak = 19,
    capslock = 20,
    escape = 27,
    space = 32,
    page_up = 33,
    page_down = 34,
    end = 35,
    home = 36,
    left = 37,
    up = 38,
    right = 39,
    down = 40,
    printscreen = 44,
    insert = 45,
    delete = 46,

    num_0 = 48,
    num_1,
    num_2,
    num_3,
    num_4,
    num_5,
    num_6,
    num_7,
    num_8,
    num_9,

    a = 65,
    b,
    c,
    d,
    e,
    f,
    g,
    h,
    i,
    j,
    k,
    l,
    m,
    n,
    o,
    p,
    q,
    r,
    s,
    t,
    u,
    v,
    w,
    x,
    y,
    z,

    apps = 93,
    numpad_0 = 96,
    numpad_1 = 97,
    numpad_2 = 98,
    numpad_3 = 99,
    numpad_4 = 100,
    numpad_5 = 101,
    numpad_6 = 102,
    numpad_7 = 103,
    numpad_8 = 104,
    numpad_9 = 105,

    numpad_multiply = 106,
    numpad_add = 107,
    separator = 108,
    numpad_subtract = 109,
    numpad_decimal = 110,
    numpad_divide = 111,

    F1 = 112,
    F2 = 113,
    F3 = 114,
    F4 = 115,
    F5 = 116,
    F6 = 117,
    F7 = 118,
    F8 = 119,
    F9 = 120,
    F10 = 121,
    F11 = 122,
    F12 = 123,
    F13 = 124,
    F14 = 125,
    F15 = 126,
    F16 = 127,
    F17 = 128,
    F18 = 129,
    F19 = 130,
    F20 = 131,
    F21 = 132,
    F22 = 133,
    F23 = 134,
    F24 = 135,

    numlock = 144,
    scrolllock = 145,

    plus = 187,
    comma = 188,
    minus = 189,
    period = 190,

    semicolon = 186,
    forward_slash = 191,
    backtick = 192,

    lbracket = 219,
    backslash = 220,
    rbracket = 221,
    single_quote = 222,
    OEM_8 = 223,
};

pub const InputModifiers = struct
{
    state: u32,
    pub fn capslock(this: InputModifiers) bool
    { return this.state & win32.system.console.CAPSLOCK_ON > 0; }
    pub fn left_alt(this: InputModifiers) bool
    { return this.state & win32.system.console.LEFT_ALT_PRESSED > 0; }
    pub fn right_alt(this: InputModifiers) bool
    { return this.state & win32.system.console.RIGHT_ALT_PRESSED > 0; }
    pub fn left_control(this: InputModifiers) bool
    { return this.state & win32.system.console.LEFT_CTRL_PRESSED > 0; }
    pub fn right_control(this: InputModifiers) bool
    { return this.state & win32.system.console.RIGHT_CTRL_PRESSED > 0; }
    pub fn numlock(this: InputModifiers) bool
    { return this.state & win32.system.console.NUMLOCK_ON > 0; }
    pub fn scrolllock(this: InputModifiers) bool
    { return this.state & win32.system.console.SCROLLLOCK_ON > 0; }
    pub fn shift(this: InputModifiers) bool
    { return this.state & win32.system.console.SHIFT_PRESSED > 0; }
    pub fn control(this: InputModifiers) bool
    { return this.left_control() or this.right_control(); }
    pub fn alt(this: InputModifiers) bool
    { return this.left_alt() or this.right_alt(); }

    pub fn matches(this: InputModifiers, modifiers: anytype) bool
    {
        var state = this.state & 0x000000FF;
        state &= ~(win32.system.console.NUMLOCK_ON);
        state &= ~(win32.system.console.SCROLLLOCK_ON);
        state &= ~(win32.system.console.CAPSLOCK_ON);

        inline for(std.meta.fields(@TypeOf(modifiers))) |field| {
            switch(@field(modifiers, field.name)) {
                .ctrl => if(this.control()) {
                    state &= ~(win32.system.console.LEFT_CTRL_PRESSED);
                    state &= ~(win32.system.console.RIGHT_CTRL_PRESSED);
                } else return false,
                .alt => if(this.alt()) {
                    state &= ~(win32.system.console.LEFT_ALT_PRESSED);
                    state &= ~(win32.system.console.RIGHT_ALT_PRESSED);
                } else return false,
                .shift => if(this.shift()) {
                    state &= ~(win32.system.console.SHIFT_PRESSED);
                } else return false,

                .capslock => if(!this.capslock()) return false,
                .numlock => if(!this.numlock()) return false,
                .scrollock => if(!this.scrolllock()) return false,

                else => return false,
            }
        }

        return state == 0;
    }
};

pub const Key = struct
{
    code: KeyCode,
    repeat_count: u16,
    char: ?u8,
    modifiers: InputModifiers,

    pub fn equals(this: Key, code: KeyCode, modifiers: anytype) bool
    {
        return this.code == code and this.modifiers.matches(modifiers);
    }
};

pub fn get_buffer_size() !Size
{
    const out = std.io.getStdOut();
    var csbi: win32.system.console.CONSOLE_SCREEN_BUFFER_INFO = undefined;
    if(win32.system.console.GetConsoleScreenBufferInfo(out.handle, &csbi) == 0)
        return error.get_console_info_fail;
    return Size { .width = csbi.dwSize.X, .height = csbi.dwSize.Y };
}

var inbuf: [10]win32.system.console.INPUT_RECORD = undefined;
var read_count: u32 = 0;
var i: u32 = 0;
var mouse_state: u8 = 0;
var buffer_size: Size = undefined;

pub fn poll_input() ?Input
{
    const stdin = std.io.getStdIn();

    if(i >= read_count) {
        i = 0;
        if(win32.system.console.ReadConsoleInputA(stdin.handle, &inbuf, 10, &read_count) == 0)
                return null;
    }

    if(read_count == 0)
        return null;

    var input: Input = undefined;

    const event = inbuf[@intCast(usize, i)];
    i += 1;

    switch(event.EventType) {

        win32.system.console.KEY_EVENT => {
            if(event.Event.KeyEvent.bKeyDown == 0) {
                input = .{ .key_released = undefined };
                input.key_released = .{
                    .code = @intToEnum(KeyCode, event.Event.KeyEvent.wVirtualKeyCode),
                    .repeat_count = event.Event.KeyEvent.wRepeatCount,
                    .char = event.Event.KeyEvent.uChar.AsciiChar,
                    .modifiers = .{ .state = event.Event.KeyEvent.dwControlKeyState },
                };
            }
            else {
                input = .{ .key_pressed = undefined };
                input.key_pressed = .{
                    .code = @intToEnum(KeyCode, event.Event.KeyEvent.wVirtualKeyCode),
                    .repeat_count = event.Event.KeyEvent.wRepeatCount,
                    .char = event.Event.KeyEvent.uChar.AsciiChar,
                    .modifiers = .{ .state = event.Event.KeyEvent.dwControlKeyState },
                };
            }
        },

        win32.system.console.MOUSE_EVENT => {
            switch(event.Event.MouseEvent.dwEventFlags) {

                win32.system.console.MOUSE_MOVED => {
                    input = .{ .mouse_move = undefined };
                    input.mouse_move = .{
                        .x = event.Event.MouseEvent.dwMousePosition.X + 1,
                        .y = event.Event.MouseEvent.dwMousePosition.Y + 1,
                    };
                },

                win32.system.console.MOUSE_WHEELED => {
                    input = .{ .mouse_scroll = undefined };
                    input.mouse_scroll = @ptrCast(*const i16, &(event.Event.MouseEvent.dwButtonState >> 16)).*;
                },

                win32.system.console.DOUBLE_CLICK, 0 => {
                    const xor: u8 = mouse_state ^ @intCast(u8, event.Event.MouseEvent.dwButtonState & 0x07);
                    std.debug.assert(xor > 0 and xor <= 4 and xor != 3); // 1, 2, 4
                    // pressed
                    if(xor & mouse_state == 0) {
                        input = .{ .mouse_pressed = .{
                            .pos = .{
                                .x = event.Event.MouseEvent.dwMousePosition.X + 1,
                                .y = event.Event.MouseEvent.dwMousePosition.Y + 1,
                            },
                            .code = @intToEnum(ButtonCode, xor),
                            .modifiers = .{ .state = event.Event.MouseEvent.dwControlKeyState },
                        }};
                    }
                    // released
                    else {
                        input = .{ .mouse_released = .{
                            .pos = .{
                                .x = event.Event.MouseEvent.dwMousePosition.X + 1,
                                .y = event.Event.MouseEvent.dwMousePosition.Y + 1,
                            },
                            .code = @intToEnum(ButtonCode, xor),
                            .modifiers = .{ .state = event.Event.MouseEvent.dwControlKeyState },
                        }};
                    }
                },

                else => return null,
            }

            mouse_state = @intCast(u8, event.Event.MouseEvent.dwButtonState & 0x07);
        },

        win32.system.console.WINDOW_BUFFER_SIZE_EVENT => {
            input = .{ .buffer_resize = undefined };
            input.buffer_resize = .{
                .width = event.Event.WindowBufferSizeEvent.dwSize.X,
                .height = event.Event.WindowBufferSizeEvent.dwSize.Y,
            };
            buffer_size.width = event.Event.WindowBufferSizeEvent.dwSize.X;
            buffer_size.height = event.Event.WindowBufferSizeEvent.dwSize.Y;
        },

        win32.system.console.FOCUS_EVENT => {
            input = .{ .focus = undefined };
            input.focus = event.Event.FocusEvent.bSetFocus != 0;
        },

        else => return null,
    }

    return input;
}
