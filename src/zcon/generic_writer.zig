// ********************************************************************************
//! https://github.com/PatrickTorgerson
//! Copyright (c) 2022 Patrick Torgerson
//! MIT license, see LICENSE for more information
// ********************************************************************************

const std = @import("std");
const assert = std.debug.assert;

/// a type-erased Writer
pub const GenericWriter = struct {
    ptr: *const anyopaque,
    vtable: *const VTable,

    pub const Error = anyerror;

    ///
    pub const VTable = struct {
        write: fn (ptr: *const anyopaque, bytes: []const u8) Error!usize,
        writeAll: fn (ptr: *const anyopaque, bytes: []const u8) Error!void,
        writeByte: fn (ptr: *const anyopaque, byte: u8) Error!void,
        writeByteNTimes: fn (ptr: *const anyopaque, byte: u8, n: usize) Error!void,
    };

    ///
    pub fn init(pointer: anytype) GenericWriter {
        comptime var ptr_info = @typeInfo(@TypeOf(pointer));

        comptime assert(ptr_info == .Pointer); // Must be a pointer
        comptime assert(ptr_info.Pointer.size == .One); // Must be a single-item pointer

        ptr_info.Pointer.is_const = true;
        const Ptr = @Type(ptr_info);

        const alignment = ptr_info.Pointer.alignment;

        const Child = ptr_info.Pointer.child;
        const child_info = @typeInfo(ptr_info.Pointer.child);
        assert(child_info == .Struct);

        const gen = struct {
            fn write_impl(ptr: *const anyopaque, bytes: []const u8) !usize {
                const self = @ptrCast(Ptr, @alignCast(alignment, ptr));
                return @call(.{ .modifier = .always_inline }, @field(Child, "write"), .{ self.*, bytes });
            }
            fn writeAll_impl(ptr: *const anyopaque, bytes: []const u8) !void {
                const self = @ptrCast(Ptr, @alignCast(alignment, ptr));
                return @call(.{ .modifier = .always_inline }, @field(Child, "writeAll"), .{ self.*, bytes });
            }
            fn writeByte_impl(ptr: *const anyopaque, byte: u8) !void {
                const self = @ptrCast(Ptr, @alignCast(alignment, ptr));
                return @call(.{ .modifier = .always_inline }, @field(Child, "writeByte"), .{ self.*, byte });
            }
            fn writeByteNTimes_impl(ptr: *const anyopaque, byte: u8, n: usize) !void {
                const self = @ptrCast(Ptr, @alignCast(alignment, ptr));
                return @call(.{ .modifier = .always_inline }, @field(Child, "writeByteNTimes"), .{ self.*, byte, n });
            }

            const vtable = VTable{
                .write = write_impl,
                .writeAll = writeAll_impl,
                .writeByte = writeByte_impl,
                .writeByteNTimes = writeByteNTimes_impl,
            };
        };

        return .{
            .ptr = pointer,
            .vtable = &gen.vtable,
        };
    }

    ///
    pub fn write(self: GenericWriter, bytes: []const u8) !usize {
        return self.vtable.write(self.ptr, bytes);
    }

    ///
    pub fn writeAll(self: GenericWriter, bytes: []const u8) !void {
        return self.vtable.writeAll(self.ptr, bytes);
    }

    ///
    pub fn writeByte(self: GenericWriter, byte: u8) !void {
        return self.vtable.writeByte(self.ptr, byte);
    }

    ///
    pub fn writeByteNTimes(self: GenericWriter, byte: u8, n: usize) !void {
        return self.vtable.writeByteNTimes(self.ptr, byte, n);
    }

    ///
    pub fn print(self: GenericWriter, comptime format: []const u8, args: anytype) !void {
        return std.fmt.format(self, format, args);
    }

    /// Write a native-endian integer.
    /// TODO audit non-power-of-two int sizes
    pub fn writeIntNative(self: GenericWriter, comptime T: type, value: T) !void {
        var bytes: [(@typeInfo(T).Int.bits + 7) / 8]u8 = undefined;
        std.mem.writeIntNative(T, &bytes, value);
        return self.vtable.writeAll(self.ptr, &bytes);
    }

    /// Write a foreign-endian integer.
    /// TODO audit non-power-of-two int sizes
    pub fn writeIntForeign(self: GenericWriter, comptime T: type, value: T) !void {
        var bytes: [(@typeInfo(T).Int.bits + 7) / 8]u8 = undefined;
        std.mem.writeIntForeign(T, &bytes, value);
        return self.vtable.writeAll(self.ptr, &bytes);
    }

    /// TODO audit non-power-of-two int sizes
    pub fn writeIntLittle(self: GenericWriter, comptime T: type, value: T) !void {
        var bytes: [(@typeInfo(T).Int.bits + 7) / 8]u8 = undefined;
        std.mem.writeIntLittle(T, &bytes, value);
        return self.vtable.writeAll(self.ptr, &bytes);
    }

    /// TODO audit non-power-of-two int sizes
    pub fn writeIntBig(self: GenericWriter, comptime T: type, value: T) !void {
        var bytes: [(@typeInfo(T).Int.bits + 7) / 8]u8 = undefined;
        std.mem.writeIntBig(T, &bytes, value);
        return self.vtable.writeAll(self.ptr, &bytes);
    }

    /// TODO audit non-power-of-two int sizes
    pub fn writeInt(self: GenericWriter, comptime T: type, value: T, endian: std.builtin.Endian) !void {
        var bytes: [(@typeInfo(T).Int.bits + 7) / 8]u8 = undefined;
        std.mem.writeInt(T, &bytes, value, endian);
        return self.vtable.writeAll(self.ptr, &bytes);
    }

    pub fn writeStruct(self: GenericWriter, value: anytype) !void {
        // Only extern and packed structs have defined in-memory layout.
        comptime assert(@typeInfo(@TypeOf(value)).Struct.layout != std.builtin.TypeInfo.ContainerLayout.Auto);
        return self.vtable.writeAll(self.ptr, std.mem.asBytes(&value));
    }
};
