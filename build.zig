const std = @import("std");
const builtin = @import("builtin");

const examples = [_]struct { name: []const u8, source: []const u8 }{
    .{ .name = "bench", .source = "examples/bench.zig" },
};

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const zcon = b.addModule("zcon", .{
        .source_file = .{ .path = sdkPath("/src/zcon.zig") },
        .dependencies = if (builtin.os.tag == .windows)
            &[_]std.Build.ModuleDependency{.{
                .name = "zigwin32",
                .module = b.dependency("zigwin32", .{}).module("zigwin32"),
            }}
        else
            &[_]std.Build.ModuleDependency{},
    });

    // -- examples

    const example_step = b.step("examples", "Build all examples");

    inline for (examples) |example| {
        const exe = b.addExecutable(.{
            .name = example.name,
            .root_source_file = .{ .path = example.source },
            .target = target,
            .optimize = optimize,
        });
        exe.addModule("zcon", zcon);
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

    // -- tests

    const exe_tests = b.addTest(.{
        .root_source_file = zcon.source_file,
        .target = target,
        .optimize = optimize,
    });
    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&exe_tests.step);
}

fn sdkPath(comptime suffix: []const u8) []const u8 {
    if (suffix[0] != '/') @compileError("suffix must be an absolute path");
    return comptime blk: {
        const root_dir = std.fs.path.dirname(@src().file) orelse ".";
        break :blk root_dir ++ suffix;
    };
}
