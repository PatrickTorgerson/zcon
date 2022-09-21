//! NOTE: this file is autogenerated, DO NOT MODIFY
//--------------------------------------------------------------------------------
// Section: Constants (5)
//--------------------------------------------------------------------------------
pub const CCH_RM_SESSION_KEY = @as(u32, 32);
pub const CCH_RM_MAX_APP_NAME = @as(u32, 255);
pub const CCH_RM_MAX_SVC_NAME = @as(u32, 63);
pub const RM_INVALID_TS_SESSION = @as(i32, -1);
pub const RM_INVALID_PROCESS = @as(i32, -1);

//--------------------------------------------------------------------------------
// Section: Types (10)
//--------------------------------------------------------------------------------
pub const RM_APP_TYPE = enum(i32) {
    UnknownApp = 0,
    MainWindow = 1,
    OtherWindow = 2,
    Service = 3,
    Explorer = 4,
    Console = 5,
    Critical = 1000,
};
pub const RmUnknownApp = RM_APP_TYPE.UnknownApp;
pub const RmMainWindow = RM_APP_TYPE.MainWindow;
pub const RmOtherWindow = RM_APP_TYPE.OtherWindow;
pub const RmService = RM_APP_TYPE.Service;
pub const RmExplorer = RM_APP_TYPE.Explorer;
pub const RmConsole = RM_APP_TYPE.Console;
pub const RmCritical = RM_APP_TYPE.Critical;

pub const RM_SHUTDOWN_TYPE = enum(i32) {
    ForceShutdown = 1,
    ShutdownOnlyRegistered = 16,
};
pub const RmForceShutdown = RM_SHUTDOWN_TYPE.ForceShutdown;
pub const RmShutdownOnlyRegistered = RM_SHUTDOWN_TYPE.ShutdownOnlyRegistered;

pub const RM_APP_STATUS = enum(i32) {
    Unknown = 0,
    Running = 1,
    Stopped = 2,
    StoppedOther = 4,
    Restarted = 8,
    ErrorOnStop = 16,
    ErrorOnRestart = 32,
    ShutdownMasked = 64,
    RestartMasked = 128,
};
pub const RmStatusUnknown = RM_APP_STATUS.Unknown;
pub const RmStatusRunning = RM_APP_STATUS.Running;
pub const RmStatusStopped = RM_APP_STATUS.Stopped;
pub const RmStatusStoppedOther = RM_APP_STATUS.StoppedOther;
pub const RmStatusRestarted = RM_APP_STATUS.Restarted;
pub const RmStatusErrorOnStop = RM_APP_STATUS.ErrorOnStop;
pub const RmStatusErrorOnRestart = RM_APP_STATUS.ErrorOnRestart;
pub const RmStatusShutdownMasked = RM_APP_STATUS.ShutdownMasked;
pub const RmStatusRestartMasked = RM_APP_STATUS.RestartMasked;

pub const RM_REBOOT_REASON = enum(i32) {
    None = 0,
    PermissionDenied = 1,
    SessionMismatch = 2,
    CriticalProcess = 4,
    CriticalService = 8,
    DetectedSelf = 16,
};
pub const RmRebootReasonNone = RM_REBOOT_REASON.None;
pub const RmRebootReasonPermissionDenied = RM_REBOOT_REASON.PermissionDenied;
pub const RmRebootReasonSessionMismatch = RM_REBOOT_REASON.SessionMismatch;
pub const RmRebootReasonCriticalProcess = RM_REBOOT_REASON.CriticalProcess;
pub const RmRebootReasonCriticalService = RM_REBOOT_REASON.CriticalService;
pub const RmRebootReasonDetectedSelf = RM_REBOOT_REASON.DetectedSelf;

pub const RM_UNIQUE_PROCESS = extern struct {
    dwProcessId: u32,
    ProcessStartTime: FILETIME,
};

pub const RM_PROCESS_INFO = extern struct {
    Process: RM_UNIQUE_PROCESS,
    strAppName: [256]u16,
    strServiceShortName: [64]u16,
    ApplicationType: RM_APP_TYPE,
    AppStatus: u32,
    TSSessionId: u32,
    bRestartable: BOOL,
};

pub const RM_FILTER_TRIGGER = enum(i32) {
    Invalid = 0,
    File = 1,
    Process = 2,
    Service = 3,
};
pub const RmFilterTriggerInvalid = RM_FILTER_TRIGGER.Invalid;
pub const RmFilterTriggerFile = RM_FILTER_TRIGGER.File;
pub const RmFilterTriggerProcess = RM_FILTER_TRIGGER.Process;
pub const RmFilterTriggerService = RM_FILTER_TRIGGER.Service;

pub const RM_FILTER_ACTION = enum(i32) {
    InvalidFilterAction = 0,
    NoRestart = 1,
    NoShutdown = 2,
};
pub const RmInvalidFilterAction = RM_FILTER_ACTION.InvalidFilterAction;
pub const RmNoRestart = RM_FILTER_ACTION.NoRestart;
pub const RmNoShutdown = RM_FILTER_ACTION.NoShutdown;

pub const RM_FILTER_INFO = extern struct {
    FilterAction: RM_FILTER_ACTION,
    FilterTrigger: RM_FILTER_TRIGGER,
    cbNextOffset: u32,
    Anonymous: extern union {
        strFilename: ?PWSTR,
        Process: RM_UNIQUE_PROCESS,
        strServiceShortName: ?PWSTR,
    },
};

pub const RM_WRITE_STATUS_CALLBACK = fn (
    nPercentComplete: u32,
) callconv(@import("std").os.windows.WINAPI) void;

//--------------------------------------------------------------------------------
// Section: Functions (11)
//--------------------------------------------------------------------------------
// TODO: this type is limited to platform 'windows6.0.6000'
pub extern "rstrtmgr" fn RmStartSession(
    pSessionHandle: ?*u32,
    dwSessionFlags: u32,
    strSessionKey: ?PWSTR,
) callconv(@import("std").os.windows.WINAPI) u32;

// TODO: this type is limited to platform 'windows6.0.6000'
pub extern "rstrtmgr" fn RmJoinSession(
    pSessionHandle: ?*u32,
    strSessionKey: ?[*:0]const u16,
) callconv(@import("std").os.windows.WINAPI) u32;

// TODO: this type is limited to platform 'windows6.0.6000'
pub extern "rstrtmgr" fn RmEndSession(
    dwSessionHandle: u32,
) callconv(@import("std").os.windows.WINAPI) u32;

// TODO: this type is limited to platform 'windows6.0.6000'
pub extern "rstrtmgr" fn RmRegisterResources(
    dwSessionHandle: u32,
    nFiles: u32,
    rgsFileNames: ?[*]?PWSTR,
    nApplications: u32,
    rgApplications: ?[*]RM_UNIQUE_PROCESS,
    nServices: u32,
    rgsServiceNames: ?[*]?PWSTR,
) callconv(@import("std").os.windows.WINAPI) u32;

// TODO: this type is limited to platform 'windows6.0.6000'
pub extern "rstrtmgr" fn RmGetList(
    dwSessionHandle: u32,
    pnProcInfoNeeded: ?*u32,
    pnProcInfo: ?*u32,
    rgAffectedApps: ?[*]RM_PROCESS_INFO,
    lpdwRebootReasons: ?*u32,
) callconv(@import("std").os.windows.WINAPI) u32;

// TODO: this type is limited to platform 'windows6.0.6000'
pub extern "rstrtmgr" fn RmShutdown(
    dwSessionHandle: u32,
    lActionFlags: u32,
    fnStatus: ?RM_WRITE_STATUS_CALLBACK,
) callconv(@import("std").os.windows.WINAPI) u32;

// TODO: this type is limited to platform 'windows6.0.6000'
pub extern "rstrtmgr" fn RmRestart(
    dwSessionHandle: u32,
    dwRestartFlags: u32,
    fnStatus: ?RM_WRITE_STATUS_CALLBACK,
) callconv(@import("std").os.windows.WINAPI) u32;

// TODO: this type is limited to platform 'windows6.0.6000'
pub extern "rstrtmgr" fn RmCancelCurrentTask(
    dwSessionHandle: u32,
) callconv(@import("std").os.windows.WINAPI) u32;

// TODO: this type is limited to platform 'windows6.0.6000'
pub extern "rstrtmgr" fn RmAddFilter(
    dwSessionHandle: u32,
    strModuleName: ?[*:0]const u16,
    pProcess: ?*RM_UNIQUE_PROCESS,
    strServiceShortName: ?[*:0]const u16,
    FilterAction: RM_FILTER_ACTION,
) callconv(@import("std").os.windows.WINAPI) u32;

// TODO: this type is limited to platform 'windows6.0.6000'
pub extern "rstrtmgr" fn RmRemoveFilter(
    dwSessionHandle: u32,
    strModuleName: ?[*:0]const u16,
    pProcess: ?*RM_UNIQUE_PROCESS,
    strServiceShortName: ?[*:0]const u16,
) callconv(@import("std").os.windows.WINAPI) u32;

// TODO: this type is limited to platform 'windows6.0.6000'
pub extern "rstrtmgr" fn RmGetFilterList(
    dwSessionHandle: u32,
    // TODO: what to do with BytesParamIndex 2?
    pbFilterBuf: ?*u8,
    cbFilterBuf: u32,
    cbFilterBufNeeded: ?*u32,
) callconv(@import("std").os.windows.WINAPI) u32;

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
// Section: Imports (3)
//--------------------------------------------------------------------------------
const BOOL = @import("../foundation.zig").BOOL;
const FILETIME = @import("../foundation.zig").FILETIME;
const PWSTR = @import("../foundation.zig").PWSTR;

test {
    // The following '_ = <FuncPtrType>' lines are a workaround for https://github.com/ziglang/zig/issues/4476
    if (@hasDecl(@This(), "RM_WRITE_STATUS_CALLBACK")) {
        _ = RM_WRITE_STATUS_CALLBACK;
    }

    @setEvalBranchQuota(comptime @import("std").meta.declarations(@This()).len * 3);

    // reference all the pub declarations
    if (!@import("builtin").is_test) return;
    inline for (comptime @import("std").meta.declarations(@This())) |decl| {
        if (decl.is_pub) {
            _ = decl;
        }
    }
}
