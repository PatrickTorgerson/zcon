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

const Option = struct {
    alias_long: []const u8,
    alias_short: []const u8,
    desc: []const u8,
    help: []const u8,
    count: i32 = 0,
};

const Error = error{
    missing_alias,
    no_such_alias,
    invalid_arg_type,
};

const This = @This();

allocator: std.mem.Allocator,

args: std.process.ArgIterator,
options: std.ArrayList(Option),
current_arg: []const u8,

option_callback: *const fn (*This) anyerror!bool,
input_callback: *const fn (*This) anyerror!bool,
help_callback: ?*const fn (*This) anyerror!bool,

exe_path: ?[]const u8,

/// must be deinited with @This().deinit();
pub fn init(allocator: std.mem.Allocator, option_callback: *const fn (*This) anyerror!bool, input_callback: *const fn (*This) anyerror!bool) !This {
    return .{
        .allocator = allocator,
        .args = try std.process.argsWithAllocator(allocator),
        .options = std.ArrayList(Option).init(allocator),
        .current_arg = "",
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
pub fn add_option(this: *This, opt: Option) !void {
    try this.options.append(opt);
}

///
pub fn add_options(this: *This, opts: []const Option) !void {
    try this.options.appendSlice(opts);
}

///
pub fn is_arg(this: *This, arg: []const u8) bool {
    return std.mem.eql(u8, this.current_arg, arg);
}

///
pub fn get_count(this: This, option: []const u8) Error!i32 {
    for (this.options.items) |opt| {
        if (std.mem.eql(u8, opt.alias_long, option) or std.mem.eql(u8, opt.alias_short, option))
            return opt.count;
    }
    return Error.no_such_alias;
}

///
pub fn read_string(this: *This) ?[]const u8 {
    return this.args.next();
}

///
pub fn read_arg(this: *This, comptime T: type) !?T {
    const arg_or = this.read_string();
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
pub fn print_help(this: This) bool {
    // TODO: possibly generate usage statement
    for (this.options.items) |option| {
        if (option.alias_long.len > 0 and option.alias_short.len > 0)
            print("  --{s}, -{s}", .{ option.alias_long, option.alias_short })
        else if (option.alias_long.len > 0)
            print("  --{s}", .{option.alias_long})
        else if (option.alias_short.len > 0)
            print("  -{s}", .{option.alias_short});
        print("\n      {s}\n", .{option.desc});
    }
    return true;
}

///
pub fn parse(this: *This) !bool {
    // first arg is exe path
    this.exe_path = this.read_string().?;

    while (this.read_string()) |arg| {
        if (arg.len <= 0) break;

        if (help_arg(arg)) {
            if (this.help_callback) |help_callback| {
                return try help_callback(this);
            } else return this.print_help();
        }

        if (arg[0] == '-') {
            if (arg.len >= 2 and arg[1] == '-') {
                if (!try this.do_option_from_long(arg[2..]))
                    return false;
            } else if (!try this.do_option_from_short(arg[1..]))
                return false;
        } else {
            this.current_arg = arg;
            if (!try this.input_callback(this))
                return false;
        }
    }

    return true;
}

///
fn do_option_from_short(this: *This, short: []const u8) !bool {
    for (this.options.items) |*option| {
        if (std.mem.eql(u8, option.alias_short, short)) {
            option.count += 1;
            this.current_arg = try primary_alias(option.*);
            return try this.option_callback(this);
        }
    }

    print("Unrecognized option '{s}'\n", .{short});
    return false;
}

///
fn do_option_from_long(this: *This, long: []const u8) !bool {
    for (this.options.items) |*option| {
        if (std.mem.eql(u8, option.alias_long, long)) {
            option.count += 1;
            this.current_arg = try primary_alias(option.*);
            return try this.option_callback(this);
        }
    }

    print("Unrecognized option '{s}'\n", .{long});
    return false;
}

///
fn help_arg(arg: []const u8) bool {
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
fn primary_alias(option: Option) Error![]const u8 {
    return if (option.alias_long.len > 0)
        option.alias_long
    else if (option.alias_short.len > 0)
        option.alias_short
    else
        Error.missing_alias;
}
