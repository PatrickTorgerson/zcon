// ********************************************************************************
//  https://github.com/PatrickTorgerson
//  Copyright (c) 2022 Patrick Torgerson
//  MIT license, see LICENSE for more information
// ********************************************************************************

//!
//! Parses command line calling provided callbacks
//! Use Cli.addOption() to add cli options
//! set Cli.help_callback to handle help options
//! Use Cli.printHelpOptions() to print options and their descriptions
//! TODO: OptionList
//! TODO: Cli.parse takes OptionList
//!

const std = @import("std");
const Writer = @import("Writer.zig");

const Option = struct {
    alias_long: []const u8,
    alias_short: []const u8,
    desc: []const u8,
    help: []const u8,
    arguments: []const u8 = "",
    count: i32 = 0,
};

const Error = error{
    missing_alias,
    no_such_alias,
    invalid_arg_type,
    unrecognized_option,
    unexpected_input,
};

const This = @This();

allocator: std.mem.Allocator,

args: std.process.ArgIterator,
options: std.ArrayList(Option),
current_arg: []const u8,

writer: *Writer,

option_callback: *const fn (*This) anyerror!bool,
input_callback: *const fn (*This) anyerror!bool,
help_callback: ?*const fn (*This) anyerror!bool,

exe_path: ?[]const u8,

/// must be deinited with @This().deinit();
pub fn init(allocator: std.mem.Allocator, writer: *Writer, option_callback: *const fn (*This) anyerror!bool, input_callback: *const fn (*This) anyerror!bool) !This {
    return .{
        .allocator = allocator,
        .args = try std.process.argsWithAllocator(allocator),
        .options = std.ArrayList(Option).init(allocator),
        .current_arg = "",
        .writer = writer,
        .option_callback = option_callback,
        .input_callback = input_callback,
        .help_callback = null,
        .exe_path = null,
    };
}

///
pub fn deinit(this: *This) void {
    this.args.deinit();
    this.options.deinit();
}

///
pub fn addOption(this: *This, opt: Option) !void {
    try this.options.append(opt);
}

///
pub fn addOptions(this: *This, opts: []const Option) !void {
    try this.options.appendSlice(opts);
}

///
pub fn isArg(this: *This, arg: []const u8) bool {
    return std.mem.eql(u8, this.current_arg, arg);
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
    return this.args.next();
}

///
pub fn readArg(this: *This, comptime T: type) !?T {
    const arg_or = this.readString();
    if (arg_or) |arg| {
        switch (@typeInfo(T)) {
            .Bool => {
                // TODO: case insensitive
                if (std.mem.eql(u8, arg, "true"))
                    return true
                else if (std.mem.eql(u8, arg, "false"))
                    return false
                else
                    return null;
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
                } else return Error.invalid_arg_type;
            },
            else => return Error.invalid_arg_type,
        }
    } else return null;
}

///
pub fn printOptionHelp(this: This) void {
    for (this.options.items) |option| {
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
pub fn parse(this: *This) !bool {
    // first arg is exe path
    this.exe_path = this.readString().?;

    while (this.readString()) |arg| {
        if (arg.len <= 0) break;

        if (helpArg(arg)) {
            if (this.help_callback) |help_callback| {
                return try help_callback(this);
            } else return Error.unrecognized_option;
        }

        if (arg[0] == '-') {
            if (arg.len >= 2 and arg[1] == '-') {
                if (!try this.handleOptionLong(arg[2..]))
                    return false;
            } else if (!try this.handleOptionShort(arg[1..]))
                return false;
        } else {
            this.current_arg = arg;
            if (!try this.input_callback(this))
                return false;
        }
    }

    return true;
}

/// attempts to call option_callback with short alias
fn handleOptionShort(this: *This, short: []const u8) !bool {
    for (this.options.items) |*option| {
        if (std.mem.eql(u8, option.alias_short, short)) {
            option.count += 1;
            this.current_arg = try primaryAlias(option.*);
            return try this.option_callback(this);
        }
    }
    return Error.unrecognized_option;
}

/// attempts to call option_callback with short alias
fn handleOptionLong(this: *This, long: []const u8) !bool {
    for (this.options.items) |*option| {
        if (std.mem.eql(u8, option.alias_long, long)) {
            option.count += 1;
            this.current_arg = try primaryAlias(option.*);
            return try this.option_callback(this);
        }
    }
    return Error.unrecognized_option;
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
