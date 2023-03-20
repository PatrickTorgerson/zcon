// ********************************************************************************
//  https://github.com/PatrickTorgerson/zcon
//  Copyright (c) 2022 Patrick Torgerson
//  MIT license, see LICENSE for more information
// ********************************************************************************

const std = @import("std");
const zcon = @import("zcon");

/// options available when no command is specified
const base_options = zcon.Cli.OptionList(.{
    .{
        .alias_long = "draw-box",
        .alias_short = "b",
        .desc = "draws a box with width #dgry<W>#prv, and height #dgry<H>#prv",
        .help = "RIP",
        .arguments = "#dgry<W> <H>#prv",
    },
    .{
        .alias_long = "echo",
        .alias_short = "",
        .desc = "prints #dgry<STR>#prv; to console",
        .help = "RIP",
        .arguments = "#dgry<STR>#prv",
    },
    .{
        .alias_long = "",
        .alias_short = "x",
        .desc = "prints a secret message",
        .help = "RIP",
        .arguments = "",
    },
});

/// options available to the 'special' command
const special_options = zcon.Cli.OptionList(.{
    .{
        .alias_long = "optional-arg",
        .alias_short = "",
        .desc = "accepts an arg #dgry[optional]#prv; or not",
        .help = "RIP",
        .arguments = "#dgry[optional]#prv",
    },
    .{
        .alias_long = "mandatory-arg",
        .alias_short = "",
        .desc = "accepts an arg #dgry<mandatory>#prv",
        .help = "RIP",
        .arguments = "#dgry<mandatory>#prv",
    },
});

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    var allocator = gpa.allocator();

    var out = zcon.Writer.init();
    defer out.flush();
    out.setIndentStr("#dgry; |   #prv");

    var cli = try zcon.Cli.init(allocator, &out);
    defer cli.deinit();

    cli.help_callback = help;
    cli.option_callback = option;
    cli.input_callback = input;

    const command = cli.peekString() orelse "";
    if (std.mem.eql(u8, command, "special")) {
        cli.consumePeeked(); // prevents future peeks and reads from returning peeked arg
        // if different command have the same options but need to be handled differently
        // you could also set the option callback here
        if (!try cli.parse(special_options))
            return;
    } else if (!try cli.parse(base_options))
        return;

    // parse retuning false is not necesaraly an error
    // if it is, the failing option or input should log reason
}

fn option(cli: *zcon.Cli) !bool {
    if (cli.isOption("optional-arg")) {
        const maybe_arg = cli.peekArg(i32) catch null orelse null;
        if (maybe_arg) |arg| {
            // decide if we want it
            // we do
            cli.consumePeeked();
            cli.writer.fmt("consumed {}\n", .{arg});
        } else cli.writer.put("no food today\n");
    } else if (cli.isOption("mandatory-arg")) {
        const arg = cli.readArg(i32) catch {
            // error, means arg did not match dest type
            cli.writer.put("  expected integer\n");
            return false;
        } orelse {
            // null, means no more args on commandline
            cli.writer.put("  expected arg\n");
            return false;
        };
        cli.writer.fmt("consumed {}\n", .{arg});
    } else if (cli.isOption("draw-box")) {
        const width = cli.readArg(i16) catch {
            cli.writer.put("  expected width to be an int\n");
            return false;
        } orelse {
            cli.writer.put("  expected width\n");
            return false;
        };
        const height = cli.readArg(i16) catch {
            cli.writer.put("  expected height to be an int\n");
            return false;
        } orelse {
            cli.writer.put("  expected height\n");
            return false;
        };
        cli.writer.drawBox(.{ .width = width, .height = height });
        cli.writer.cursorDown(height);
        cli.writer.putChar('\n');
    } else if (cli.isOption("echo")) {
        if (cli.peekString()) |str| {
            // make sure it's not another option
            if (str.len > 0 and str[0] == '-') {
                cli.writer.put("echo\n");
                return true;
            }
            cli.consumePeeked();
            cli.writer.fmt("{s}\n", .{str});
        } else cli.writer.put("echo\n");
    } else if (cli.isOption("x")) {
        cli.writer.put("this is a secret\n");
    }
    return true;
}

fn input(cli: *zcon.Cli) !bool {
    cli.writer.fmt("Oops, you dropped this useless garbage; '{s}'\n", .{cli.current_arg});
    return true;
}

fn help(cli: *zcon.Cli) !bool {
    cli.writer.put("\nExample program for zcon.Cli\n\n#yel Usage#prv\n #dgry;|#prv   cli (special [special options] | [base options])\n\n#yel base options#prv\n");
    cli.writer.indent(1);
    cli.printOptionHelp(base_options);
    cli.writer.unindent(1);

    cli.writer.put("\n\n#yel special options#prv\n");
    cli.writer.indent(1);
    cli.printOptionHelp(special_options);
    cli.writer.unindent(1);

    cli.writer.putChar('\n');
    return true;
}
