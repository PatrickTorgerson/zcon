// ********************************************************************************
//! https://github.com/PatrickTorgerson
//! Copyright (c) 2022 Patrick Torgerson
//! MIT license, see LICENSE for more information
// ********************************************************************************

const std = @import("std");
const root = @import("root");
const GenericWriter = @import("generic_writer.zig").GenericWriter;

///
pub const Macro = fn (GenericWriter, *ParamIterator) anyerror!bool;

/// maps macro names to macro functions
/// just a type-erased std.ComptimeStringMap(Macro, ...);
pub const MacroMap = struct {
    has: fn (str: []const u8) bool,
    get: fn (str: []const u8) ?Macro,

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
    pub const Writer = std.io.Writer(MacroWriter, Error, MacroWriter.write);

    macros: ?MacroMap,
    output: GenericWriter,

    pub fn write(this: MacroWriter, bytes: []const u8) Error!usize {
        return try expand_macros(this.macros, this.output, bytes);
    }

    pub fn init(macros: ?MacroMap, out_writer: anytype) Writer {
        return .{ .context = MacroWriter{ .macros = macros, .output = GenericWriter.init(&out_writer) } };
    }
};

///
pub fn expand_macro(macros: ?MacroMap, writer: anytype, name: []const u8, params: []const u8) !bool {
    if (macros) |m|
        if (m.get(name)) |macro| {
            return macro(GenericWriter.init(&writer), &ParamIterator{ .slice = params });
        };

    if (@hasDecl(root, "macros")) {
        if (@typeInfo(@TypeOf(root.macros)) != .Struct)
            return false;
        if (root.macros.get(name)) |macro| {
            return macro(GenericWriter.init(&writer), &ParamIterator{ .slice = params });
        } else return false;
    } else return false;
}

/// TODO: accept multiple maps? `?[]const MacroMap`
pub fn expand_macros(macros: ?MacroMap, writer: anytype, fmt: []const u8) !usize {
    var i: usize = 0;
    while (i < fmt.len) {
        const prefix_start = i;

        // locate next macro
        var escape_count: usize = 0;
        while (i < fmt.len) : (i += 1) {
            switch (fmt[i]) {
                '#' => {
                    if (escape_count % 2 == 0) {
                        break;
                    } else {
                        escape_count = 0;
                    }
                },
                '\\' => escape_count += 1,
                else => escape_count = 0,
            }
        }

        const prefix_end = i;

        // write prefix
        if (prefix_start != prefix_end)
            try writer.writeAll(fmt[prefix_start..prefix_end]);

        // no more macros
        if (i >= fmt.len) return i;

        // Get past the '#'
        i += 1;

        const tag = parse_tag(fmt[i..]);

        i += tag.len;

        if (!try expand_macro(macros, writer, tag.name, tag.params))
            return i;
    }

    return i;
}

///
fn parse_tag(fmt: []const u8) Tag {
    // name
    var name_end: usize = 0;
    while (name_end < fmt.len and (std.ascii.isAlpha(fmt[name_end]) or
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
                '#', ' ', '\t', '\n', '\r', ',' => {
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
            .len = if (param_end < fmt.len and fmt[param_end] == ' ') param_end + 1 else param_end,
        };
    }
    // return without params
    else return .{
        .name = fmt[0..name_end],
        .params = fmt[name_end..name_end],
        // +1 for courtesy space
        .len = if (name_end < fmt.len and fmt[name_end] == ' ') name_end + 1 else name_end,
    };
}

///
const Tag = struct {
    name: []const u8,
    params: []const u8,
    len: usize,
};
