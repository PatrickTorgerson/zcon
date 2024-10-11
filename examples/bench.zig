// ********************************************************************************
//  https://github.com/PatrickTorgerson/zcon
//  Copyright (c) 2024 Patrick Torgerson
//  MIT license, see LICENSE for more information
// ********************************************************************************

const std = @import("std");
const zcon = @import("zcon");

pub fn main() !void {
    var out = zcon.Writer.init();
    defer out.flush();
    defer out.useDefaultColors();

    primeBuffer(&out, 20, 60);

    out.writeByteNTimes('=', 20) catch {};

    out.put("#inverse\n");
    out.put("#blk;  #gry;  #red;  #yel;  #grn;  #cyn;  #blu;  #mag;  \n");
    out.put("#dgry;  #wht;  #bred;  #byel;  #bgrn;  #bcyn;  #bblu;  #bmag;  \n");
    out.put("#d");
    out.put("#blk;  #gry;  #red;  #yel;  #grn;  #cyn;  #blu;  #mag;  \n");
    out.put("#dgry;  #wht;  #bred;  #byel;  #bgrn;  #bcyn;  #bblu;  #bmag;  #def");

    const cur = out.getCursor() catch |err| {
        out.fmt("err: {s}\n", .{@errorName(err)});
        return err;
    };
    out.put("\n");
    const cur2 = out.getCursor() catch |err| {
        out.fmt("err: {s}\n", .{@errorName(err)});
        return err;
    };

    out.fmt("#def\n\ncur: {},{}\n\n", .{ cur.x, cur.y });
    out.fmt("#def;cur: {},{}\n\n    ", .{ cur2.x, cur2.y });
    out.drawBox(.{ .width = 11, .height = 3 });
    out.put("  hello");
    out.setCursorX(1);
    out.cursorDown(3);

    const sz = out.getSize() catch |err| {
        out.fmt("err: {s}\n", .{@errorName(err)});
        return err;
    };
    out.fmt("#def;size: {},{}\n\n", .{ sz.width, sz.height });

    out.putRaw("Title:\n");
    out.indent(1);
    out.put("- a\n");
    out.put("- b\n");
    out.put("- c\n");
    out.indent(1);
    out.put("* a\n");
    out.put("* b\n");
    out.put("* c\n");
    out.indent(1);
    out.put("+ a\n");
    out.put("+ b\n");
    out.put("+ c\n");
    out.unindent(1);
    out.put("* d\n");
    out.put("* e\n");
    out.put("* f\n");
}

fn primeBuffer(writer: *zcon.Writer, comptime lines: comptime_int, comptime cols: comptime_int) void {
    inline for (0..lines) |_| {
        writer.fmt("{[s]s: <[w]}.\n", .{ .s = " ", .w = cols });
    }
    writer.cursorUp(lines);
    writer.flush();
}
