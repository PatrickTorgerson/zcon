// ********************************************************************************
//  https://github.com/PatrickTorgerson
//  Copyright (c) 2024 Patrick Torgerson
//  MIT license, see LICENSE for more information
// ********************************************************************************

const std = @import("std");

/// fixed size buffer with stack-like operatins
/// pushes always succeed and overite oldest element when full
pub fn RingBuffer(comptime T: type, comptime capacity: usize) type {
    return struct {
        buffer: [capacity]T = undefined,
        /// next element to write to
        head: usize = 0,
        /// oldest element in buffer
        tail: usize = 0,
        /// empty flag, when head and tail are
        /// equal buffer could be full or empty
        empty: bool = true,

        const This = @This();

        pub fn init() This {
            return .{};
        }

        pub fn size(this: This) usize {
            return if (this.empty)
                0
            else if (this.tail < this.head)
                this.head - this.tail
            else
                capacity - (this.tail - this.head);
        }

        pub fn push(this: *This, val: T) void {
            this.buffer[this.head] = val;
            const old_head = this.head;
            this.head += 1;
            if (this.head >= capacity)
                this.head = 0;
            if (!this.empty and (this.tail == old_head or (this.tail == capacity and old_head == capacity - 1)))
                this.tail = this.head;
            if (this.empty)
                this.empty = false;
        }

        pub fn pop(this: *This) ?T {
            if (this.empty)
                return null;
            if (this.head == 0)
                this.head = capacity;
            this.head -= 1;
            if (this.head == this.tail)
                this.empty = true;
            return this.buffer[this.head];
        }

        pub fn get(this: This, at: usize) ?T {
            if (this.empty or at >= capacity)
                return null;
            const index = (this.tail + at) - capacity;
            return this.buffer[index];
        }

        pub fn top(this: This) ?T {
            if (this.empty)
                return null;
            const index = if (this.head == 0) capacity - 1 else this.head - 1;
            return this.buffer[index];
        }
    };
}
