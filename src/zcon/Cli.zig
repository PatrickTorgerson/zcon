// ********************************************************************************
//  https://github.com/PatrickTorgerson
//  Copyright (c) 2022 Patrick Torgerson
//  MIT license, see LICENSE for more information
// ********************************************************************************

//!
//! Parses command line calling provided callbacks
//! Use Cli.addOption() to add cli options
//! set Cli.help_callback to handle help options
//! set Cli.option_callback to handle options (prefixed with `-` or `--`)
//! set Cli.input_callback to handle input args that arent options
//! Use Cli.printHelpOptions() to print options and their descriptions
//! see examples/cli.zig for an example
//!

const std = @import("std");
const Writer = @import("Writer.zig");

pub const Option = struct {
    alias_long: []const u8,
    alias_short: []const u8,
    desc: []const u8,
    help: []const u8,
    arguments: []const u8 = "",
};

///
pub fn OptionList(comptime list: anytype) type {
    const LEN = list.len;
    const MAP_LEN = @floatToInt(usize, @intToFloat(f64, LEN + 1) * 1.25);

    const precomputed = comptime blk: {
        @setEvalBranchQuota(2000);
        var options: [LEN]Option = undefined;

        var long_map: [MAP_LEN]usize = [_]usize{LEN} ** MAP_LEN;
        var short_map: [MAP_LEN]usize = [_]usize{LEN} ** MAP_LEN;

        for (list, 0..) |opt, i| {
            options[i] = opt;

            if (opt.alias_long.len > 0) {
                const hash = std.hash.Wyhash.hash(0, opt.alias_long);
                var index = hash % MAP_LEN;
                while (true) {
                    if (long_map[index] == LEN) {
                        long_map[index] = i;
                        break;
                    }
                    index += 1;
                    if (index >= MAP_LEN)
                        index = 0;
                }
            }

            if (opt.alias_short.len > 0) {
                const hash = std.hash.Wyhash.hash(0, opt.alias_short);
                var index = hash % MAP_LEN;
                while (true) {
                    if (short_map[index] == LEN) {
                        short_map[index] = i;
                        break;
                    }
                    index += 1;
                    if (index >= MAP_LEN)
                        index = 0;
                }
            }
        }

        break :blk .{
            .options = options,
            .short_map = short_map,
            .long_map = long_map,
        };
    };

    return struct {
        pub const options = precomputed.options;

        pub fn has(str: []const u8) bool {
            return get(str) != null;
        }

        pub fn get(str: []const u8) ?*const Option {
            if (str.len <= 1) return null;
            if (str[0] != '-') return null;
            if (str[1] == '-')
                return get_impl(str[2..], precomputed.long_map, "alias_long")
            else
                return get_impl(str[1..], precomputed.short_map, "alias_short");
        }

        pub fn get_long(str: []const u8) ?*const Option {
            return get_impl(str, precomputed.long_map, "alias_long");
        }

        pub fn get_short(str: []const u8) ?*const Option {
            return get_impl(str, precomputed.short_map, "alias_short");
        }

        fn get_impl(str: []const u8, map: anytype, comptime alias: []const u8) ?*const Option {
            const hash = std.hash.Wyhash.hash(0, str);
            var i = hash % MAP_LEN;
            while (true) {
                if (map[i] == LEN) return null;
                const option = &options[map[i]];
                if (std.mem.eql(u8, str, @field(option.*, alias)))
                    return option;
                i += 1;
                if (i >= MAP_LEN)
                    i = 0;
            }
        }
    };
}

const Error = error{
    missing_alias,
    no_such_alias,
    invalid_arg_type,
    unrecognized_option,
    unexpected_input,
};

const This = @This();

args: std.process.ArgIterator,
current_arg: []const u8,
peeked_arg: ?[]const u8 = null,
current_option: ?*const Option = null,

writer: *Writer,

option_callback: *const fn (*This) anyerror!bool,
input_callback: *const fn (*This) anyerror!bool,
help_callback: ?*const fn (*This) anyerror!bool,

exe_path: ?[]const u8,

/// must be deinited with @This().deinit();
pub fn init(allocator: std.mem.Allocator, writer: *Writer) !This {
    var this = This{
        .args = try std.process.argsWithAllocator(allocator),
        .current_arg = "",
        .writer = writer,
        .option_callback = defaultOptionCallback,
        .input_callback = defaultInputCallback,
        .help_callback = null,
        .exe_path = null,
    };

    // first arg is exe path
    this.exe_path = this.readString().?;
    return this;
}

///
pub fn deinit(this: *This) void {
    this.args.deinit();
}

///
pub fn isArg(this: *This, arg: []const u8) bool {
    return std.mem.eql(u8, this.current_arg, arg);
}

pub fn isOption(this: *This, arg: []const u8) bool {
    if (this.current_option == null) return false;
    return std.mem.eql(u8, this.current_option.?.alias_long, arg) or
        std.mem.eql(u8, this.current_option.?.alias_short, arg);
}

///
pub fn getCount(this: This, option: []const u8) Error!i32 {
    for (this.options.items) |opt| {
        if (std.mem.eql(u8, opt.alias_long, option) or std.mem.eql(u8, opt.alias_short, option))
            return opt.count;
    }
    return Error.no_such_alias;
}

///
pub fn readString(this: *This) ?[]const u8 {
    if (this.peeked_arg) |arg| {
        this.peeked_arg = null;
        return arg;
    } else return this.args.next();
}

pub fn peekString(this: *This) ?[]const u8 {
    if (this.peeked_arg) |arg|
        return arg
    else {
        this.peeked_arg = this.readString();
        return this.peeked_arg;
    }
}

///
pub fn readArg(this: *This, comptime T: type) !?T {
    if (this.readString()) |arg| {
        return try asType(arg, T);
    } else return null;
}

pub fn peekArg(this: *This, comptime T: type) !?T {
    if (this.peekString()) |arg| {
        return try asType(arg, T);
    } else return null;
}

pub fn consumePeeked(this: *This) void {
    this.peeked_arg = null;
}

fn asType(arg: []const u8, comptime T: type) !T {
    switch (@typeInfo(T)) {
        .Bool => {
            // TODO: case insensitive
            if (std.mem.eql(u8, arg, "true"))
                return true
            else if (std.mem.eql(u8, arg, "false"))
                return false
            else
                return error.not_boolean;
        },
        .Int => {
            return try std.fmt.parseInt(T, arg, 0);
        },
        .Float => {
            return try std.fmt.parseFloat(T, arg);
        },
        .Pointer => |ptr| {
            if (ptr.size == .Slice and ptr.child == u8 and ptr.is_const) {
                return arg;
            } else return error.invalid_arg_type;
        },
        else => return error.invalid_arg_type,
    }
}

///
pub fn printOptionHelp(this: This, option_list: anytype) void {
    for (option_list.options[0..]) |option| {
        if (option.alias_long.len > 0 and option.alias_short.len > 0)
            this.writer.fmt("--{s}, -{s}", .{ option.alias_long, option.alias_short })
        else if (option.alias_long.len > 0)
            this.writer.fmt("--{s}", .{option.alias_long})
        else if (option.alias_short.len > 0)
            this.writer.fmt("-{s}", .{option.alias_short});

        this.writer.fmt("   {s}", .{option.arguments});

        this.writer.indent(1);
        this.writer.fmt("\n{s}\n", .{option.desc});
        this.writer.unindent(1);
        this.writer.useDefaultColors();
    }
}

///
pub fn parse(this: *This, option_list: anytype) !bool {
    std.debug.assert(std.meta.trait.hasDecls(option_list, .{ "options", "has", "get" })); // invalid option list type

    while (this.readString()) |arg| {
        if (arg.len <= 0) break;

        if (helpArg(arg)) {
            if (this.help_callback) |help_callback| {
                return try help_callback(this);
            } else {
                this.writer.fmt("  unrecognized option `{s}`\n", .{arg});
                return false;
            }
        }

        this.current_arg = arg;
        if (arg[0] == '-') {
            if (option_list.get(arg)) |option| {
                this.current_option = option;
                if (!try this.option_callback(this))
                    return false;
            } else {
                this.current_option = null;
                this.writer.fmt("  unrecognized option `{s}`\n", .{arg});
                return false;
            }
        } else {
            if (!try this.input_callback(this))
                return false;
        }
    }

    return true;
}

///
fn helpArg(arg: []const u8) bool {
    if (std.mem.eql(u8, arg, "help")) return true;
    if (std.mem.eql(u8, arg, "-help")) return true;
    if (std.mem.eql(u8, arg, "--help")) return true;
    if (std.mem.eql(u8, arg, "-h")) return true;
    if (std.mem.eql(u8, arg, "--h")) return true;
    if (std.mem.eql(u8, arg, "-?")) return true;
    if (std.mem.eql(u8, arg, "--?")) return true;

    return false;
}

///
fn primaryAlias(option: Option) Error![]const u8 {
    return if (option.alias_long.len > 0)
        option.alias_long
    else if (option.alias_short.len > 0)
        option.alias_short
    else
        Error.missing_alias;
}

fn defaultOptionCallback(cli: *This) !bool {
    cli.writer.putRaw("no option callback set\n");
    return false;
}

fn defaultInputCallback(cli: *This) !bool {
    cli.writer.putRaw("no input callback set\n");
    return false;
}
