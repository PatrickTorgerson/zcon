// ********************************************************************************
//  https://github.com/PatrickTorgerson/zcon
//  Copyright (c) 2022 Patrick Torgerson
//  MIT license, see LICENSE for more information
// ********************************************************************************

const std = @import("std");
const zcon = @import("zcon");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    var allocator = gpa.allocator();

    var out = zcon.Writer.init();
    defer out.flush();
    out.setIndentStr("#dgry  |   #prv");

    var cli = try zcon.Cli.init(allocator, &out, option, input);
    defer cli.deinit();

    cli.help_callback = help;

    try cli.addOption(.{
        .alias_long = "draw-box",
        .alias_short = "b",
        .desc = "draws a box with width #dgry<W>#prv, and height #dgry<H>#prv",
        .help = "RIP",
        .arguments = "#dgry<W> <H>#prv",
    });

    try cli.addOption(.{
        .alias_long = "echo",
        .alias_short = "",
        .desc = "prints #dgry<STR>#prv  to console",
        .help = "RIP",
        .arguments = "#dgry<STR>#prv",
    });

    if (!try cli.parse()) {
        out.putRaw("\n  Could not parse cammand line\n");
    }
}

fn option(cli: *zcon.Cli) !bool {
    if (cli.isArg("draw-box")) {
        const width = try cli.readArg(i16) orelse return false;
        const height = try cli.readArg(i16) orelse return false;
        cli.writer.drawBox(.{ .width = width, .height = height });
        cli.writer.cursorDown(height);
        cli.writer.putChar('\n');
    } else if (cli.isArg("echo")) {
        if (try cli.readArg([]const u8)) |str| {
            cli.writer.fmt("{s}\n", .{str});
        }
    }
    return true;
}

fn input(cli: *zcon.Cli) !bool {
    cli.writer.fmt("Oops, you dropped this useless garbage; '{s}'\n", .{cli.current_arg});
    return true;
}

fn help(cli: *zcon.Cli) !bool {
    cli.writer.put("\nTest program for zcon.Cli\n\n#yel Options#prv\n");
    cli.writer.indent(1);
    cli.printOptionHelp();
    cli.writer.unindent(1);
    cli.writer.putChar('\n');
    return true;
}
