const std = @import("std");
const win32 = @import("src/zigwin32/build.zig");

const examples = [_]struct { name: []const u8, source: []const u8 }{
    .{ .name = "paint", .source = "examples/paint.zig" },
    // .{ .name = "todo", .source = "examples/todo.zig"},
    .{ .name = "cli", .source = "examples/cli.zig" },
    .{ .name = "bench", .source = "examples/bench.zig" },
};

pub fn module(b: *std.Build) *std.Build.Module {
    const zigwin32 = b.addModule("zigwin32", .{
        .source_file = .{ .path = sdkPath("/src/zigwin32/win32.zig") },
    });
    return b.addModule("zcon", .{
        .source_file = .{ .path = sdkPath("/src/zcon.zig") },
        .dependencies = &[_]std.Build.ModuleDependency{
            .{
                .name = "zigwin32",
                .module = zigwin32,
            },
        },
    });
}

pub fn build(b: *std.Build) void {
    // Standard target options allows the person running `zig build` to choose
    // what target to build for. Here we do not override the defaults, which
    // means any target is allowed, and the default is native. Other options
    // for restricting supported target set are available.
    const target = b.standardTargetOptions(.{});

    // Standard optimization options allow the person running `zig build` to select
    // between Debug, ReleaseSafe, ReleaseFast, and ReleaseSmall. Here we do not
    // set a preferred release mode, allowing the user to decide how to optimize.
    const optimize = b.standardOptimizeOption(.{});

    const zcon = module(b);

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

        const instal_step = &b.addInstallArtifact(exe).step;

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
