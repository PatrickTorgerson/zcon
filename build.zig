const std = @import("std");
const Pkg = std.build.Pkg;

const zcon = Pkg{
    .name = "zcon",
    .source = .{ .path = "src/zcon.zig" },
    .dependencies = &[_]Pkg{},
};

const win32 = Pkg{
    .name = "win32",
    .source = .{ .path = "src/zigwin32/win32.zig" },
    .dependencies = &[_]Pkg{},
};

const examples = [_]struct { name: []const u8, source: []const u8 }{
    .{ .name = "paint", .source = "examples/paint.zig" },
    // .{ .name = "todo", .source = "examples/todo.zig"},
    .{ .name = "cli", .source = "examples/cli.zig" },
    .{ .name = "bench", .source = "examples/bench.zig" },
};

pub fn build(b: *std.build.Builder) void {
    // Standard target options allows the person running `zig build` to choose
    // what target to build for. Here we do not override the defaults, which
    // means any target is allowed, and the default is native. Other options
    // for restricting supported target set are available.
    const target = b.standardTargetOptions(.{});

    // Standard release options allow the person running `zig build` to select
    // between Debug, ReleaseSafe, ReleaseFast, and ReleaseSmall.
    const mode = b.standardReleaseOptions();

    // -- examples

    const example_step = b.step("examples", "Build all examples");

    inline for (examples) |example| {
        const exe = b.addExecutable(example.name, example.source);
        exe.setBuildMode(mode);
        exe.setTarget(target);
        exe.addPackage(zcon);
        exe.addPackage(win32);
        const instal_step = &b.addInstallArtifact(exe).step;

        example_step.dependOn(instal_step);

        const run_example_step = b.step(example.name, "Run example '" ++ example.name ++ "'");
        run_example_step.dependOn(example_step);

        const run_example_cmd = exe.run();
        run_example_cmd.step.dependOn(instal_step);
        if (b.args) |args| {
            run_example_cmd.addArgs(args);
        }

        run_example_step.dependOn(&run_example_cmd.step);
    }
}
