//! NOTE: this file is autogenerated, DO NOT MODIFY
//--------------------------------------------------------------------------------
// Section: Constants (17)
//--------------------------------------------------------------------------------
pub const OBJ_HANDLE_TAGBITS = @as(i32, 3);
pub const RTL_BALANCED_NODE_RESERVED_PARENT_MASK = @as(u32, 3);
pub const OBJ_INHERIT = @as(i32, 2);
pub const OBJ_PERMANENT = @as(i32, 16);
pub const OBJ_EXCLUSIVE = @as(i32, 32);
pub const OBJ_CASE_INSENSITIVE = @as(i32, 64);
pub const OBJ_OPENIF = @as(i32, 128);
pub const OBJ_OPENLINK = @as(i32, 256);
pub const OBJ_KERNEL_HANDLE = @as(i32, 512);
pub const OBJ_FORCE_ACCESS_CHECK = @as(i32, 1024);
pub const OBJ_IGNORE_IMPERSONATED_DEVICEMAP = @as(i32, 2048);
pub const OBJ_DONT_REPARSE = @as(i32, 4096);
pub const OBJ_VALID_ATTRIBUTES = @as(i32, 8178);
pub const NULL64 = @as(u32, 0);
pub const MAXUCHAR = @as(u32, 255);
pub const MAXUSHORT = @as(u32, 65535);
pub const MAXULONG = @as(u32, 4294967295);

//--------------------------------------------------------------------------------
// Section: Types (32)
//--------------------------------------------------------------------------------
pub const EXCEPTION_DISPOSITION = enum(i32) {
    ContinueExecution = 0,
    ContinueSearch = 1,
    NestedException = 2,
    CollidedUnwind = 3,
};
pub const ExceptionContinueExecution = EXCEPTION_DISPOSITION.ContinueExecution;
pub const ExceptionContinueSearch = EXCEPTION_DISPOSITION.ContinueSearch;
pub const ExceptionNestedException = EXCEPTION_DISPOSITION.NestedException;
pub const ExceptionCollidedUnwind = EXCEPTION_DISPOSITION.CollidedUnwind;

pub const SLIST_ENTRY = extern struct {
    Next: ?*SLIST_ENTRY,
};

pub const QUAD = extern struct {
    Anonymous: extern union {
        UseThisFieldToCopy: i64,
        DoNotUseThisField: f64,
    },
};

pub const PROCESSOR_NUMBER = extern struct {
    Group: u16,
    Number: u8,
    Reserved: u8,
};

pub const EVENT_TYPE = enum(i32) {
    NotificationEvent = 0,
    SynchronizationEvent = 1,
};
pub const NotificationEvent = EVENT_TYPE.NotificationEvent;
pub const SynchronizationEvent = EVENT_TYPE.SynchronizationEvent;

pub const TIMER_TYPE = enum(i32) {
    NotificationTimer = 0,
    SynchronizationTimer = 1,
};
pub const NotificationTimer = TIMER_TYPE.NotificationTimer;
pub const SynchronizationTimer = TIMER_TYPE.SynchronizationTimer;

pub const WAIT_TYPE = enum(i32) {
    All = 0,
    Any = 1,
    Notification = 2,
    Dequeue = 3,
    Dpc = 4,
};
pub const WaitAll = WAIT_TYPE.All;
pub const WaitAny = WAIT_TYPE.Any;
pub const WaitNotification = WAIT_TYPE.Notification;
pub const WaitDequeue = WAIT_TYPE.Dequeue;
pub const WaitDpc = WAIT_TYPE.Dpc;

pub const STRING = extern struct {
    Length: u16,
    MaximumLength: u16,
    Buffer: ?[*]u8,
};

pub const CSTRING = extern struct {
    Length: u16,
    MaximumLength: u16,
    Buffer: ?[*:0]const u8,
};

pub const LIST_ENTRY = extern struct {
    Flink: ?*LIST_ENTRY,
    Blink: ?*LIST_ENTRY,
};

pub const SINGLE_LIST_ENTRY = extern struct {
    Next: ?*SINGLE_LIST_ENTRY,
};

pub const RTL_BALANCED_NODE = extern struct {
    Anonymous1: extern union {
        Children: [2]?*RTL_BALANCED_NODE,
        Anonymous: extern struct {
            Left: ?*RTL_BALANCED_NODE,
            Right: ?*RTL_BALANCED_NODE,
        },
    },
    Anonymous2: extern union {
        _bitfield: u8,
        ParentValue: usize,
    },
};

pub const LIST_ENTRY32 = extern struct {
    Flink: u32,
    Blink: u32,
};

pub const LIST_ENTRY64 = extern struct {
    Flink: u64,
    Blink: u64,
};

pub const SINGLE_LIST_ENTRY32 = extern struct {
    Next: u32,
};

pub const WNF_STATE_NAME = extern struct {
    Data: [2]u32,
};

pub const STRING32 = extern struct {
    Length: u16,
    MaximumLength: u16,
    Buffer: u32,
};

pub const STRING64 = extern struct {
    Length: u16,
    MaximumLength: u16,
    Buffer: u64,
};

pub const OBJECT_ATTRIBUTES64 = extern struct {
    Length: u32,
    RootDirectory: u64,
    ObjectName: u64,
    Attributes: u32,
    SecurityDescriptor: u64,
    SecurityQualityOfService: u64,
};

pub const OBJECT_ATTRIBUTES32 = extern struct {
    Length: u32,
    RootDirectory: u32,
    ObjectName: u32,
    Attributes: u32,
    SecurityDescriptor: u32,
    SecurityQualityOfService: u32,
};

pub const OBJECTID = extern struct {
    Lineage: Guid,
    Uniquifier: u32,
};

pub const EXCEPTION_ROUTINE = fn (
    ExceptionRecord: ?*EXCEPTION_RECORD,
    EstablisherFrame: ?*anyopaque,
    ContextRecord: ?*CONTEXT,
    DispatcherContext: ?*anyopaque,
) callconv(@import("std").os.windows.WINAPI) EXCEPTION_DISPOSITION;

pub const NT_PRODUCT_TYPE = enum(i32) {
    WinNt = 1,
    LanManNt = 2,
    Server = 3,
};
pub const NtProductWinNt = NT_PRODUCT_TYPE.WinNt;
pub const NtProductLanManNt = NT_PRODUCT_TYPE.LanManNt;
pub const NtProductServer = NT_PRODUCT_TYPE.Server;

pub const SUITE_TYPE = enum(i32) {
    SmallBusiness = 0,
    Enterprise = 1,
    BackOffice = 2,
    CommunicationServer = 3,
    TerminalServer = 4,
    SmallBusinessRestricted = 5,
    EmbeddedNT = 6,
    DataCenter = 7,
    SingleUserTS = 8,
    Personal = 9,
    Blade = 10,
    EmbeddedRestricted = 11,
    SecurityAppliance = 12,
    StorageServer = 13,
    ComputeServer = 14,
    WHServer = 15,
    PhoneNT = 16,
    MultiUserTS = 17,
    MaxSuiteType = 18,
};
pub const SmallBusiness = SUITE_TYPE.SmallBusiness;
pub const Enterprise = SUITE_TYPE.Enterprise;
pub const BackOffice = SUITE_TYPE.BackOffice;
pub const CommunicationServer = SUITE_TYPE.CommunicationServer;
pub const TerminalServer = SUITE_TYPE.TerminalServer;
pub const SmallBusinessRestricted = SUITE_TYPE.SmallBusinessRestricted;
pub const EmbeddedNT = SUITE_TYPE.EmbeddedNT;
pub const DataCenter = SUITE_TYPE.DataCenter;
pub const SingleUserTS = SUITE_TYPE.SingleUserTS;
pub const Personal = SUITE_TYPE.Personal;
pub const Blade = SUITE_TYPE.Blade;
pub const EmbeddedRestricted = SUITE_TYPE.EmbeddedRestricted;
pub const SecurityAppliance = SUITE_TYPE.SecurityAppliance;
pub const StorageServer = SUITE_TYPE.StorageServer;
pub const ComputeServer = SUITE_TYPE.ComputeServer;
pub const WHServer = SUITE_TYPE.WHServer;
pub const PhoneNT = SUITE_TYPE.PhoneNT;
pub const MultiUserTS = SUITE_TYPE.MultiUserTS;
pub const MaxSuiteType = SUITE_TYPE.MaxSuiteType;

pub const COMPARTMENT_ID = enum(i32) {
    UNSPECIFIED_COMPARTMENT_ID = 0,
    DEFAULT_COMPARTMENT_ID = 1,
};
pub const UNSPECIFIED_COMPARTMENT_ID = COMPARTMENT_ID.UNSPECIFIED_COMPARTMENT_ID;
pub const DEFAULT_COMPARTMENT_ID = COMPARTMENT_ID.DEFAULT_COMPARTMENT_ID;

pub const EXCEPTION_REGISTRATION_RECORD = extern struct {
    Next: ?*EXCEPTION_REGISTRATION_RECORD,
    Handler: ?EXCEPTION_ROUTINE,
};

pub const NT_TIB = extern struct {
    ExceptionList: ?*EXCEPTION_REGISTRATION_RECORD,
    StackBase: ?*anyopaque,
    StackLimit: ?*anyopaque,
    SubSystemTib: ?*anyopaque,
    Anonymous: extern union {
        FiberData: ?*anyopaque,
        Version: u32,
    },
    ArbitraryUserPointer: ?*anyopaque,
    Self: ?*NT_TIB,
};

pub const SLIST_HEADER = switch (@import("../zig.zig").arch) {
    .Arm64 => extern union {
        Anonymous: extern struct {
            Alignment: u64,
            Region: u64,
        },
        HeaderArm64: extern struct {
            _bitfield1: u64,
            _bitfield2: u64,
        },
    },
    .X64 => extern union {
        Anonymous: extern struct {
            Alignment: u64,
            Region: u64,
        },
        HeaderX64: extern struct {
            _bitfield1: u64,
            _bitfield2: u64,
        },
    },
    .X86 => extern union {
        Alignment: u64,
        Anonymous: extern struct {
            Next: SINGLE_LIST_ENTRY,
            Depth: u16,
            CpuId: u16,
        },
    },
};
pub const FLOATING_SAVE_AREA = switch (@import("../zig.zig").arch) {
    .X64, .Arm64 => extern struct {
        ControlWord: u32,
        StatusWord: u32,
        TagWord: u32,
        ErrorOffset: u32,
        ErrorSelector: u32,
        DataOffset: u32,
        DataSelector: u32,
        RegisterArea: [80]u8,
        Cr0NpxState: u32,
    },
    .X86 => extern struct {
        ControlWord: u32,
        StatusWord: u32,
        TagWord: u32,
        ErrorOffset: u32,
        ErrorSelector: u32,
        DataOffset: u32,
        DataSelector: u32,
        RegisterArea: [80]u8,
        Spare0: u32,
    },
};

//--------------------------------------------------------------------------------
// Section: Functions (7)
//--------------------------------------------------------------------------------
// TODO: this type is limited to platform 'windows5.1.2600'
pub extern "ntdll" fn RtlInitializeSListHead(
    ListHead: ?*SLIST_HEADER,
) callconv(@import("std").os.windows.WINAPI) void;

// TODO: this type is limited to platform 'windows5.1.2600'
pub extern "ntdll" fn RtlFirstEntrySList(
    ListHead: ?*const SLIST_HEADER,
) callconv(@import("std").os.windows.WINAPI) ?*SLIST_ENTRY;

// TODO: this type is limited to platform 'windows5.1.2600'
pub extern "ntdll" fn RtlInterlockedPopEntrySList(
    ListHead: ?*SLIST_HEADER,
) callconv(@import("std").os.windows.WINAPI) ?*SLIST_ENTRY;

// TODO: this type is limited to platform 'windows5.1.2600'
pub extern "ntdll" fn RtlInterlockedPushEntrySList(
    ListHead: ?*SLIST_HEADER,
    ListEntry: ?*SLIST_ENTRY,
) callconv(@import("std").os.windows.WINAPI) ?*SLIST_ENTRY;

pub extern "ntdll" fn RtlInterlockedPushListSListEx(
    ListHead: ?*SLIST_HEADER,
    List: ?*SLIST_ENTRY,
    ListEnd: ?*SLIST_ENTRY,
    Count: u32,
) callconv(@import("std").os.windows.WINAPI) ?*SLIST_ENTRY;

// TODO: this type is limited to platform 'windows5.1.2600'
pub extern "ntdll" fn RtlInterlockedFlushSList(
    ListHead: ?*SLIST_HEADER,
) callconv(@import("std").os.windows.WINAPI) ?*SLIST_ENTRY;

// TODO: this type is limited to platform 'windows5.1.2600'
pub extern "ntdll" fn RtlQueryDepthSList(
    ListHead: ?*SLIST_HEADER,
) callconv(@import("std").os.windows.WINAPI) u16;

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
// Section: Imports (4)
//--------------------------------------------------------------------------------
const Guid = @import("../zig.zig").Guid;
const CONTEXT = @import("../system/diagnostics/debug.zig").CONTEXT;
const EXCEPTION_RECORD = @import("../system/diagnostics/debug.zig").EXCEPTION_RECORD;
const PSTR = @import("../foundation.zig").PSTR;

test {
    // The following '_ = <FuncPtrType>' lines are a workaround for https://github.com/ziglang/zig/issues/4476
    if (@hasDecl(@This(), "EXCEPTION_ROUTINE")) {
        _ = EXCEPTION_ROUTINE;
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
