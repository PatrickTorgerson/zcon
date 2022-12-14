# zcon

```zig
const zcon = @import("zcon");

pub fn main() !void {

    try zcon.enable_input_events();

    zcon.alternate_buffer();
    defer zcon.main_buffer();

    zcon.clear_buffer();

    zcon.set_color(zcon.bright_yellow);

    zcon.write("yellow text #red red text #def default text");

    while(true)
    while(zcon.poll_input()) |input| {
        .key_pressed => |key| {
            if(key.equals(.c, .{.ctrl}))
                return;
            zcon.print("key press: {}", .{@tagName(key.code)});
        },
        .key_released => |key| _ = key,
        .mouse_pressed => |button| _ = button,
        .mouse_released => |button| _ = button,
        .mouse_move => |pos| _ = pos,
        .mouse_scroll => |delta| _ = delta,
        .buffer_resize => |size| _ = size,
        .focus => |focused| _ = focused,
    }
}
```

## license
---

> MIT License
>
> Copyright (c) 2022 Patrick Torgerson
>
> Permission is hereby granted, free of charge, to any person obtaining a copy
> of this software and associated documentation files (the "Software"), to deal
> in the Software without restriction, including without limitation the rights
> to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> copies of the Software, and to permit persons to whom the Software is
> furnished to do so, subject to the following conditions:
>
> The above copyright notice and this permission notice shall be included in all
> copies or substantial portions of the Software.
>
> THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
> AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
> SOFTWARE.
