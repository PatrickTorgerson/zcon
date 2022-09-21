//! NOTE: this file is autogenerated, DO NOT MODIFY
//--------------------------------------------------------------------------------
// Section: Constants (4)
//--------------------------------------------------------------------------------
pub const COMDB_MIN_PORTS_ARBITRATED = @as(u32, 256);
pub const COMDB_MAX_PORTS_ARBITRATED = @as(u32, 4096);
pub const CDB_REPORT_BITS = @as(u32, 0);
pub const CDB_REPORT_BYTES = @as(u32, 1);

//--------------------------------------------------------------------------------
// Section: Types (1)
//--------------------------------------------------------------------------------
pub const HCOMDB = *opaque {};

//--------------------------------------------------------------------------------
// Section: Functions (7)
//--------------------------------------------------------------------------------
pub extern "msports" fn ComDBOpen(
    PHComDB: ?*isize,
) callconv(@import("std").os.windows.WINAPI) i32;

pub extern "msports" fn ComDBClose(
    HComDB: ?HCOMDB,
) callconv(@import("std").os.windows.WINAPI) i32;

pub extern "msports" fn ComDBGetCurrentPortUsage(
    HComDB: ?HCOMDB,
    // TODO: what to do with BytesParamIndex 2?
    Buffer: ?*u8,
    BufferSize: u32,
    ReportType: u32,
    MaxPortsReported: ?*u32,
) callconv(@import("std").os.windows.WINAPI) i32;

pub extern "msports" fn ComDBClaimNextFreePort(
    HComDB: ?HCOMDB,
    ComNumber: ?*u32,
) callconv(@import("std").os.windows.WINAPI) i32;

pub extern "msports" fn ComDBClaimPort(
    HComDB: ?HCOMDB,
    ComNumber: u32,
    ForceClaim: BOOL,
    Forced: ?*BOOL,
) callconv(@import("std").os.windows.WINAPI) i32;

pub extern "msports" fn ComDBReleasePort(
    HComDB: ?HCOMDB,
    ComNumber: u32,
) callconv(@import("std").os.windows.WINAPI) i32;

pub extern "msports" fn ComDBResizeDatabase(
    HComDB: ?HCOMDB,
    NewSize: u32,
) callconv(@import("std").os.windows.WINAPI) i32;

//--------------------------------------------------------------------------------
// Section: Unicode Aliases (0)
//--------------------------------------------------------------------------------
const thismodule = @This();
pub usingnamespace switch (@import("../zig.zig").unicode_mode) {
    .ansi => struct {},
    .wide => struct {},
    .unspecified => if (@import("builtin").is_test) struct {} else struct {},
};
//--------------------------------------------------------------------------------
// Section: Imports (1)
//--------------------------------------------------------------------------------
const BOOL = @import("../foundation.zig").BOOL;

test {
    @setEvalBranchQuota(comptime @import("std").meta.declarations(@This()).len * 3);

    // reference all the pub declarations
    if (!@import("builtin").is_test) return;
    inline for (comptime @import("std").meta.declarations(@This())) |decl| {
        if (decl.is_pub) {
            _ = decl;
        }
    }
}
