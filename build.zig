// ********************************************************************************
//  https://github.com/PatrickTorgerson
//  Copyright (c) 2024 Patrick Torgerson
//  MIT license, see LICENSE for more information
// ********************************************************************************

const std = @import("std");
const builtin = @import("builtin");

const examples = [_]struct { name: []const u8, source: []const u8 }{
    .{ .name = "bench", .source = "examples/bench.zig" },
};

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const zcon = b.addModule("zcon", .{
        .root_source_file = b.path("src/zcon.zig"),
    });

    const example_step = b.step("examples", "Build all examples");
    inline for (examples) |example| {
        const exe = b.addExecutable(.{
            .name = example.name,
            .root_module = b.createModule(.{
                .root_source_file = b.path(example.source),
                .target = target,
                .optimize = optimize,
            }),
        });
        exe.root_module.addImport("zcon", zcon);
        if (builtin.os.tag != .windows) {
            exe.linkSystemLibrary("c");
        }
        const instal_step = &b.addInstallArtifact(exe, .{}).step;
        example_step.dependOn(instal_step);
        const run_example_step = b.step(example.name, "Run example '" ++ example.name ++ "'");
        run_example_step.dependOn(example_step);
        const run_example_cmd = b.addRunArtifact(exe);
        run_example_cmd.step.dependOn(instal_step);
        if (b.args) |args| {
            run_example_cmd.addArgs(args);
        }
        run_example_step.dependOn(&run_example_cmd.step);
    }

    const exe_tests = b.addTest(.{
        .root_source_file = zcon.root_source_file.?,
        .target = target,
        .optimize = optimize,
    });
    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&exe_tests.step);

    const fmt_step = b.step("fmt", "Run formatter");
    const fmt = b.addFmt(.{
        .paths = &.{ "src", "examples", "build.zig" },
        .check = true,
    });
    fmt_step.dependOn(&fmt.step);
    b.default_step.dependOn(fmt_step);
}
