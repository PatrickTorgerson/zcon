// ********************************************************************************
//  https://github.com/PatrickTorgerson
//  Copyright (c) 2022 Patrick Torgerson
//  MIT license, see LICENSE for more information
// ********************************************************************************

//!
//! Utility to resolve macros in strings
//! the macros take the form `#macro-name:param1,param2...`
//! define macros by constructing a macro.MacroMap, mapping macro names to callback functions
//! callbacks take the form `fn (WriterProxy, *macro.ParamIterator) anyerror!bool`
//! you can also provide a MacroMap declaration named `macros` in your root file
//! these macros will be resolved in adition to the provided map, with priority given to
//! the provided map
//!

const std = @import("std");
const root = @import("root");
const WriterProxy = @import("WriterProxy.zig");
const Writer = @import("Writer.zig");

///
pub const Macro = *const fn (*Writer, *ParamIterator) anyerror!bool;
pub const Error = error{macro_returned_error};

/// maps macro names to macro functions
/// just a type-erased std.ComptimeStringMap(Macro, ...);
pub const MacroMap = struct {
    has: *const fn (str: []const u8) bool,
    get: *const fn (str: []const u8) ?Macro,

    /// `kvs_list` expects a list literal containing list literals or an array/slice of structs
    /// where .@"0" is the macro name and .@"1" is the associated macro function
    pub fn init(comptime kvs_list: anytype) MacroMap {
        const map = std.ComptimeStringMap(Macro, kvs_list);

        return .{
            .has = map.has,
            .get = map.get,
        };
    }

    pub fn has(this: MacroMap, macro: []const u8) bool {
        return this.vtable.has(macro);
    }

    pub fn get(this: MacroMap, macro: []const u8) ?Macro {
        return this.vtable.get(macro);
    }
};

///
pub const ParamIterator = struct {
    slice: []const u8,
    index: usize = 0,

    pub fn next(this: *ParamIterator) ?[]const u8 {
        // skip white
        while (this.index < this.slice.len and this.slice[this.index] == ' ')
            this.index += 1;

        if (this.index >= this.slice.len)
            return null;

        // locate end
        const in_quote = this.slice[this.index] == '\'';
        if (in_quote) this.index += 1;
        var end = this.index;
        var escape_count: usize = 0;
        while (end < this.slice.len) : (end += 1) {
            switch (this.slice[end]) {
                ' ', '\t', '\n', '\r', ',' => {
                    if (!in_quote) break;
                },
                '\'' => {
                    if (in_quote and escape_count % 2 == 0) {
                        break;
                    }
                },
                else => {},
            }

            if (this.slice[end] == '\\')
                escape_count += 1
            else
                escape_count = 0;
        }

        defer {
            if (end < this.slice.len and this.slice[end] == '\'')
                end += 1;
            if (end < this.slice.len and this.slice[end] == ',')
                end += 1;
            this.index = end;
        }
        // return slice
        return this.slice[this.index..end];
    }
};

///
pub const MacroWriter = struct {
    pub const Error = anyerror;
    pub const WriterInterface = std.io.Writer(MacroWriter, MacroWriter.Error, MacroWriter.write);

    macros: ?MacroMap,
    output: WriterProxy,
    zcon_writer: *Writer,

    pub fn write(this: MacroWriter, bytes: []const u8) MacroWriter.Error!usize {
        return try expandMacros(this.macros, this.zcon_writer, this.output, bytes);
    }

    pub fn init(macros: ?MacroMap, zcon_writer: *Writer, out_writer: WriterProxy) WriterInterface {
        return .{ .context = MacroWriter{
            .macros = macros,
            .output = out_writer,
            .zcon_writer = zcon_writer,
        } };
    }
};

///
pub fn expandMacro(macros: ?MacroMap, writer: *Writer, name: []const u8, params: []const u8) Error!bool {
    if (macros) |m|
        if (m.get(name)) |macro| {
            var param_iter = ParamIterator{ .slice = params };
            return macro(writer, &param_iter) catch return Error.macro_returned_error;
        };

    if (@hasDecl(root, "macros")) {
        if (@typeInfo(@TypeOf(root.macros)) != .Struct)
            return false;
        if (root.macros.get(name)) |macro| {
            var param_iter = ParamIterator{ .slice = params };
            return macro(writer, &param_iter) catch return Error.macro_returned_error;
        } else return false;
    } else return false;
}

/// TODO: accept multiple maps? `?[]const MacroMap`
pub fn expandMacros(macros: ?MacroMap, writer: *Writer, out: WriterProxy, str: []const u8) !usize {
    var i: usize = 0;
    while (i < str.len) {
        var prefix_start = i;

        // locate next macro
        var escape_count: usize = 0;
        while (i < str.len) : (i += 1) {
            switch (str[i]) {
                '#' => {
                    if (escape_count % 2 == 0) {
                        break;
                    } else {
                        // write back slashes
                        try out.writeAll(str[prefix_start .. i - 1 - (escape_count - 1) / 2]);
                        prefix_start = i;
                        escape_count = 0;
                    }
                },
                '\\' => escape_count += 1,
                else => escape_count = 0,
            }
        }

        const prefix_end = i - escape_count / 2;

        // write prefix
        if (prefix_start != prefix_end)
            try out.writeAll(str[prefix_start..prefix_end]);

        // no more macros
        if (i >= str.len) return i;

        // Get past the '#'
        i += 1;

        const tag = parseTag(str[i..]);

        i += tag.len;

        if (!try expandMacro(macros, writer, tag.name, tag.params))
            try out.print("<ERR:{s}>", .{tag.name});
    }

    return i;
}

///
fn parseTag(fmt: []const u8) Tag {
    // name
    var name_end: usize = 0;
    while (name_end < fmt.len and (std.ascii.isAlphabetic(fmt[name_end]) or
        fmt[name_end] == '-' or
        fmt[name_end] == '_'))
    {
        name_end += 1;
    }

    // params
    if (name_end < fmt.len and fmt[name_end] == ':') {
        var param_start = name_end + 1;
        while (param_start < fmt.len and fmt[param_start] == ' ')
            param_start += 1;

        var param_end = param_start;
        var escape_count: usize = 0;
        var in_quote: bool = false;
        var first_char: bool = true;
        var end_param: bool = false;

        while (param_end < fmt.len) : (param_end += 1) {
            switch (fmt[param_end]) {
                '\'' => {
                    if (first_char) {
                        in_quote = true;
                    } else if (in_quote) {
                        if (escape_count % 2 == 0) {
                            in_quote = false;
                            end_param = true;
                            param_end += 1;
                        }
                    }
                },
                '#', ' ', '\t', '\n', '\r', ',', ';' => {
                    if (!in_quote)
                        end_param = true;
                },
                else => {},
            }

            if (param_end < fmt.len and fmt[param_end] == '\\')
                escape_count += 1
            else
                escape_count = 0;

            first_char = false;

            if (end_param) {
                if (param_end < fmt.len and fmt[param_end] == ',') {
                    param_end += 1;
                    while (param_end < fmt.len and fmt[param_end] == ' ')
                        param_end += 1;
                    param_end -= 1;
                    first_char = true;
                    end_param = false;
                } else break;
            }
        }

        return .{
            .name = fmt[0..name_end],
            .params = fmt[param_start..param_end],
            // +1 for courtesy space
            .len = if ((param_end < fmt.len and fmt[param_end] == ' ') or (param_end < fmt.len and fmt[param_end] == ';'))
                param_end + 1
            else
                param_end,
        };
    }
    // return without params
    else return .{
        .name = fmt[0..name_end],
        .params = fmt[name_end..name_end],
        // +1 for courtesy space
        .len = if ((name_end < fmt.len and fmt[name_end] == ' ') or (name_end < fmt.len and fmt[name_end] == ';'))
            name_end + 1
        else
            name_end,
    };
}

///
const Tag = struct {
    name: []const u8,
    params: []const u8,
    len: usize,
};
