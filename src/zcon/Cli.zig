// ********************************************************************************
//! https://github.com/PatrickTorgerson
//! Copyright (c) 2022 Patrick Torgerson
//! MIT license, see LICENSE for more information
// ********************************************************************************

const std = @import("std");

fn print(comptime fmt: []const u8, args: anytype) void {
    const out = std.io.getStdOut().writer();
    std.fmt.format(out, fmt, args) catch return;
}

const Option = struct
{
    alias_long: []const u8,
    alias_short: []const u8,
    desc: []const u8,
    help: []const u8,

    count: i32 = 0
};

const Error = error
{
    missing_alias,
    no_such_alias,
    invalid_arg_type,
} || std.process.ArgIterator.NextError;

const This = @This();
const Callback = fn(*This) anyerror!bool;

allocator: std.mem.Allocator,
arena: std.heap.ArenaAllocator,

args: std.process.ArgIterator,
options: std.ArrayList(Option),
current_arg: []const u8,

option_callback: Callback,
input_callback: Callback,
help_callback: ?Callback,

exe_path: ?[]const u8,

/// must be deinited with @This().deinit();
pub fn init(allocator: std.mem.Allocator, option_callback: Callback, input_callback: Callback) @This()
{
    return .{
        .allocator = allocator,
        .arena = std.heap.ArenaAllocator.init(allocator),
        .args = std.process.args(),
        .options = std.ArrayList(Option).init(allocator),
        .current_arg = "",
        .option_callback = option_callback,
        .input_callback = input_callback,
        .help_callback = null,
        .exe_path = null,
    };
}

///
pub fn deinit(this: *This) void
{
    this.arena.deinit();
}

///
pub fn add_option(this: *This, opt: Option) !void
{
    try this.options.append(opt);
}

///
pub fn add_options(this: *This, opts: []const Option) !void
{
    try this.options.appendSlice(opts);
}

///
pub fn is_arg(this: *This, arg: []const u8) bool
{
    return std.mem.eql(u8, this.current_arg, arg);
}

///
pub fn get_count(this: This, option: []const u8) Error!i32
{
    for(this.options.items) |opt| {
        if(std.mem.eql(u8, opt.alias_long, option) or std.mem.eql(u8, opt.alias_short, option))
            return opt.count;
    }

    return Error.no_such_alias;
}

///
pub fn read_string(this: *This) Error!?[]const u8
{
    const next_arg = this.args.next(this.allocator);
    if(next_arg) |arg|
        return try arg
    else return null;
}

///
pub fn read_arg(this: *This, comptime T: type) !?T
{
    const arg_or = try this.read_string();
    if(arg_or) |arg| {
        switch(@typeInfo(T)) {
            .Bool => {
                // TODO: case insensitive
                if(std.mem.eql(u8, arg, "true"))
                    return true
                else if(std.mem.eql(u8, arg, "false"))
                    return false
                else return null;
            },
            .Int => {
                return try std.fmt.parseInt(T, arg, 0);
            },
            .Float => {
                return try std.fmt.parseFloat(T, arg);
            },
            else => return Error.invalid_arg_type,
        }
    }
    else return null;
}

///
pub fn print_help(this: This) void
{
    for(this.options.items) |option|
    {
        if(option.alias_long.len > 0 and option.alias_short.len > 0)
            print("  --{s}, -{s}", .{option.alias_long, option.alias_short})
        else if(option.alias_long.len > 0)
            print("  --{s}", .{option.alias_long})
        else if(option.alias_short.len > 0)
            print("  -{s}", .{option.alias_short});

        print("\n      {s}\n", .{option.desc});
    }
}

///
pub fn parse(this: *This) !bool
{
    var next_arg = try this.read_string();

    // first arg is exe path
    this.exe_path = next_arg.?;

    next_arg = try this.read_string();
    while(next_arg) |arg| : (next_arg = try this.read_string())
    {
        if(arg.len <= 0) break;

        if(help_arg(arg)) {
            if(this.help_callback) |help_callback| {
                return try help_callback(this);
            }
            else this.print_help();
        }

        if(arg[0] == '-') {
            if(arg.len >= 2 and arg[1] == '-') {
                if(!try this.do_option_from_long(arg[2..]))
                    return false;
            }
            else if(!try this.do_option_from_short(arg[1..]))
                return false;
        }
        else {
            this.current_arg = arg;
            if(!try this.input_callback(this))
                return false;
        }
    }

    return true;
}

///
fn do_option_from_short(this: *This, short: []const u8) !bool
{
    for(this.options.items) |*option|
    {
        if(std.mem.eql(u8, option.alias_short, short))
        {
            option.count += 1;
            this.current_arg = try primary_alias(option.*);
            return try this.option_callback(this);
        }
    }

    print("Unrecognized option '{s}'\n", .{short});
    return false;
}

///
fn do_option_from_long(this: *This, long: []const u8) !bool
{
    for(this.options.items) |*option|
    {
        if(std.mem.eql(u8, option.alias_long, long))
        {
            option.count += 1;
            this.current_arg = try primary_alias(option.*);
            return try this.option_callback(this);
        }
    }

    print("Unrecognized option '{s}'\n", .{long});
    return false;
}

///
fn help_arg(arg: []const u8) bool
{
    if(std.mem.eql(u8, arg, "help")) return true;
    if(std.mem.eql(u8, arg, "-help")) return true;
    if(std.mem.eql(u8, arg, "--help")) return true;
    if(std.mem.eql(u8, arg, "-h")) return true;
    if(std.mem.eql(u8, arg, "--h")) return true;
    if(std.mem.eql(u8, arg, "-?")) return true;
    if(std.mem.eql(u8, arg, "--?")) return true;

    return false;
}

///
fn primary_alias(option: Option) Error![]const u8
{
    if(option.alias_long.len > 0) return option.alias_long
    else if(option.alias_short.len > 0) return option.alias_short
    else return Error.missing_alias;
}
