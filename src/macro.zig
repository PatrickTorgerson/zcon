// ********************************************************************************
//  https://github.com/PatrickTorgerson
//  Copyright (c) 2024 Patrick Torgerson
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
const ZconWriter = @import("Writer.zig");

pub const MacroFn = *const fn (*ZconWriter, *ParamIterator) anyerror!bool;
pub const Error = error{macro_returned_error};
pub const MacroMap = std.StaticStringMap(MacroFn);

/// helper to iterate over parameters supplied to a macro.
/// with the macro "#hello:a,b,c"
/// ParamIterator.next() will return; "a", "b", "c", then null
pub const ParamIterator = struct {
    slice: []const u8,
    index: usize = 0,

    /// returns the next parameter in the macro's parameter list,
    /// null if no parameters remain.
    /// with the macro "#hello:a,b,c"
    /// ParamIterator.next() will return; "a", "b", "c", then null
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

// pub const MacroWriter = struct {
//     pub const Error = anyerror;
//
//     macros: ?MacroMap,
//     output: std.io.AnyWriter,
//     zcon_writer: *ZconWriter,
//
//     pub fn init(macros: ?MacroMap, zcon_writer: *ZconWriter, out_writer: std.io.AnyWriter) MacroWriter {
//         return .{
//             .macros = macros,
//             .output = out_writer,
//             .zcon_writer = zcon_writer,
//         };
//     }
//
//     pub fn write(this: *const MacroWriter, bytes: []const u8) MacroWriter.Error!usize {
//         return try expandMacros(this.macros, this.zcon_writer, this.output, bytes);
//     }
//
//     pub fn any(this: *const MacroWriter) std.io.AnyWriter {
//         return .{
//             .context = @ptrCast(this),
//             .writeFn = typeErasedWriteFn,
//         };
//     }
//
//     fn typeErasedWriteFn(context: *const anyopaque, bytes: []const u8) anyerror!usize {
//         const ptr: *const MacroWriter = @alignCast(@ptrCast(context));
//         return ptr.write(bytes);
//     }
// };

pub fn MacroWriter(comptime writer: type) type {
    return struct {
        const ThisMacroWriter = @This();
        macros: ?MacroMap,
        output: writer,
        zcon_writer: *ZconWriter,

        pub fn init(macros: ?MacroMap, zcon_writer: *ZconWriter, out_writer: writer) ThisMacroWriter {
            return .{
                .macros = macros,
                .output = out_writer,
                .zcon_writer = zcon_writer,
            };
        }

        pub fn write(this: *const ThisMacroWriter, bytes: []const u8) anyerror!usize {
            return try expandMacros(this.macros, this.zcon_writer, this.output, bytes);
        }

        pub fn any(this: *const ThisMacroWriter) std.io.AnyWriter {
            return .{
                .context = @ptrCast(this),
                .writeFn = typeErasedWriteFn,
            };
        }

        fn typeErasedWriteFn(context: *const anyopaque, bytes: []const u8) anyerror!usize {
            const ptr: *const ThisMacroWriter = @alignCast(@ptrCast(context));
            return ptr.write(bytes);
        }
    };
}

pub fn macroWriter(macros: ?MacroMap, zcon_writer: *ZconWriter, out_writer: anytype) MacroWriter(@TypeOf(out_writer)) {
    return MacroWriter(@TypeOf(out_writer)).init(macros, zcon_writer, out_writer);
}

/// todo: accept multiple maps? `?[]const MacroMap`
pub fn expandMacros(
    macros: ?MacroMap,
    writer: *ZconWriter,
    out: anytype,
    str: []const u8,
) !usize {
    // todo: accept multiple maps? `?[]const MacroMap`
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

fn expandMacro(
    macros: ?MacroMap,
    writer: *ZconWriter,
    name: []const u8,
    params: []const u8,
) Error!bool {
    if (macros) |m| {
        if (m.get(name)) |macro| {
            var param_iter = ParamIterator{ .slice = params };
            return macro(writer, &param_iter) catch return Error.macro_returned_error;
        }
    }
    if (@hasDecl(root, "macros")) {
        if (@typeInfo(@TypeOf(root.macros)) != .Struct)
            return false;
        if (root.macros.get(name)) |macro| {
            var param_iter = ParamIterator{ .slice = params };
            return macro(writer, &param_iter) catch return Error.macro_returned_error;
        } else return false;
    } else return false;
}

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

const Tag = struct {
    name: []const u8,
    params: []const u8,
    len: usize,
};
