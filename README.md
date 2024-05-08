# zcon

A console output library.

```zig
const zcon = @import("zcon");

pub fn main() !void {
    var out = zcon.Writer.init();
    defer out.flush();
    defer out.useDefaultColors();

    out.useDedicatedScreen();
    defer out.useDefaultScreen();

    out.clearScreen();
    out.setColor(zcon.Color.col16(.bright_yellow));
    out.put("yellow text #red red text #def default text #prv red text");
}
```

## write functions

`zcon.Writer` has all the standard zig writer functions so it can be passed to any function expecting a writer. `zcon.Writer` also contains additional functions for convenience and performance.

* `zcon.Writer.put()` : like writer.writeAll() but ignores errors
* `zcon.Writer.fmt()` : like writer.print() but ignores errors
* `zcon.Writer.putRaw()` : like writer.put() but does no macro expansion or indenting
* `zcon.Writer.fmtRaw()` : like writer.fmt() but does no macro expansion or indenting
* `zcon.Writer.putAt()` : like writer.put() but sets cursor position before writing
* `zcon.Writer.fmtAt()` : like writer.fmt() but sets cursor position before writing

All writing is buffered, `zcon.Writer.flush()` should be called to ensure output gets printed.

## macros

A `zcon.Writer` will resolve any macros before printing to stdout. Macros take the form `#name:param1,'param2';`.
The terminating semicolon is optional, with no semicolon the macro will consume a single space.
Parameters can be surrounded in single quotes to include spaces, semicolons, and hashes.

* `#name#age` expands to `patrick26`
* `#name #age` expands to `patrick26`
* `#name;#age;` expands to `patrick26`
* `#name; #age;` expands to `patrick 26`

Below is a complete list of built in macros. Parameters surrounded in square brackets are optional.
Macros with optional `[text]` paramer prints `text` with effect but does not persist the effect.

Note: most macros are implemented with ansi escape codes and require terminal support.
If some macros aren't working try a defferent terminal.

macro | parameters | desc | example
---|---|---|---
`#def` | `[text]` | set to default fg color |`"#blu blue #def back to normal"`
`#prv` | `[text]` | restore previous fg color |`"#blu blue #red red #prv blue"`
`#red` | `[text]` | set fg color to red |`"#blu blue #red:'this is red' blue"`
`#grn` | `[text]` | set fg color to green |`"#blu blue #grn:'this is green' blue"`
`#blu` | `[text]` | set fg color to blue |`"#blu blue text`
`#mag` | `[text]` | set fg color to magenta |`"#mag; magenta, leading space"`
`#cyn` | `[text]` | set fg color to cyan |`"#cyn this text is cyan"`
`#yel` | `[text]` | set fg color to yellow |`"#yel bannana"`
`#wht` | `[text]` | set fg color to white |`"#wht white text"`
`#blk` | `[text]` | set fg color to black |`"#blk can you see me?"`
`#bred` | `[text]` | set fg color to bright red |`"#blu blue #bred:'this is bright red'; blue"`
`#bgrn` | `[text]` | set fg color to bright green |`"#blu blue #bgrn:'this is green' blue"`
`#bblu` | `[text]` | set fg color to bright blue |`"#bblu blue text`
`#bmag` | `[text]` | set fg color to bright magenta |`"#bmag; magenta, leading space"`
`#bcyn` | `[text]` | set fg color to bright cyan |`"#bcyn this text is cyan"`
`#byel` | `[text]` | set fg color to bright yellow |`"#byel bannana"`
`#gry` | `[text]` | set fg color to grey | `"#gry grey text"`
`#dgry` | `[text]` | set fg color to dark grey | `"#gry grey text"`
`#fg` | `hex,[text]` | set fg color to rgb hex color | `"#fg:ff55ff purple!"`
`#bg` | `hex,[text]` | set bg color to rgb hex color | `"#bg:ff55ff purple background!"`
`#n` | `[text]` | disable all styles | `"#b#i bold and italic #n normal"`
`#b` | `off\|[text]` | use bold style | `"#b:'bold' normal #b bold #b:off normal"`
`#d` | `off\|[text]` | use dim style | `"#d:'dim' normal #d dim #d:off normal"`
`#i` | `off\|[text]` | use italic style | `"#i:'italic' normal #i italic #i:off normal"`
`#u` | `off\|[text]` | use underline style | `"#u:'underline' normal #u underline #u:off normal"`
`#s` | `off\|[text]` | use strikethrogh style | `"#s:'strike' normal #s strike #s:off normal"`
`#du` | `off\|[text]` | use double underline style | `"#du:'double' normal #du double #du:off normal"`
`#blink` | `off\|[text]` | use blinking text | `"#blu#blink flashing eyes #blink:off#def"`
`#inverse` | `off\|[text]` | swap fg and bg colors | `"#fg:f00#bg:00f red on blue #inverse:'blue on red'"`
`#repeat` | `text,[count]` | print `text` `count` times, `count` defaults to 1 | `"#repeat:'hello ',5"`
`#rule` | `length` | print a horizontal rule at cursor with length `length` | `"#rule:34"`
`#box` | `w,h` | print a box at cursor with size `w`,`h` | `"#box:20,3 inside box"`
`#indent` | none | print a single indent | `"== HEADER ==\n #indent content"`
`#up` | `[amt]` | move cursor up `amt` or `1` | `"#up:3"`
`#down` | `[amt]` | move cursor down `amt` or `1` | `"#down:4"`
`#left` | `[amt]` | move cursor left `amt` or `1` | `"#left:10"`
`#right` | `[amt]` | move cursor right `amt` or `1` | `"hellp#right o"`

format args get resolved before macros so the following is possible

```zig
writer.fmt("\n#rule:{}", .{writer.getSize().width});
```

## custom macros

You can implement custom macros by providing a `zcon.MacroMap` called `macros` in your root source file.

```zig
const zcon = @import("zcon");

const macros = zcon.MacroMap.init(.{
    .{"name", nameMacro},
    .{"age", ageMacro},
});

fn nameMacro(writer: *zcon.Writer, params: *zcon.ParamIterator) !bool {
    writer.putRaw("patrick");
    return true;
}

fn ageMacro(writer: *zcon.Writer, params: *zcon.ParamIterator) !bool {
    writer.putRaw("26");
    return true;
}

pub fn main() !void {
    var out = zcon.Writer.init();
    defer out.flush();
    defer out.useDefaultColors();

    out.put("Yo, I'm ya boi #name;, #age; years ol'");
}
```

## usage

1. Add `zcon` as a dependency in your `build.zig.zon`.

    <details>

    <summary><code>build.zig.zon</code> example</summary>

    ```zig
    .{
        .name = "<name_of_your_package>",
        .version = "<version_of_your_package>",
        .dependencies = .{
            .zcon = .{
                .url = "https://github.com/PatrickTorgerson/zcon/archive/<git_tag_or_commit_hash>.tar.gz",
                .hash = "<package_hash>",
            },
        },
    }
    ```

    Set `<package_hash>` to `12200000000000000000000000000000000000000000000000000000000000000000`, and Zig will provide the correct found value in an error message.

    </details>

2. Add `zcon` as a module in your `build.zig`.

    <details>

    <summary><code>build.zig</code> example</summary>

    ```zig
    const zcon = b.lazyDependency("zcon", .{
        .optimize = optimize,
        .target = target,
    }).module("zcon");
    //...
    exe.root_module.addImport("zcon", zcon);
    ```

    </details>

## license

> MIT License
>
> Copyright (c) 2024 Patrick Torgerson
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
