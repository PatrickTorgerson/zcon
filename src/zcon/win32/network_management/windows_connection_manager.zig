//! NOTE: this file is autogenerated, DO NOT MODIFY
//--------------------------------------------------------------------------------
// Section: Constants (6)
//--------------------------------------------------------------------------------
pub const WCM_API_VERSION_1_0 = @as(u32, 1);
pub const WCM_API_VERSION = @as(u32, 1);
pub const WCM_UNKNOWN_DATAPLAN_STATUS = @as(u32, 4294967295);
pub const WCM_MAX_PROFILE_NAME = @as(u32, 256);
pub const NET_INTERFACE_FLAG_NONE = @as(u32, 0);
pub const NET_INTERFACE_FLAG_CONNECT_IF_NEEDED = @as(u32, 1);

//--------------------------------------------------------------------------------
// Section: Types (15)
//--------------------------------------------------------------------------------
pub const WCM_PROPERTY = enum(i32) {
    global_property_domain_policy = 0,
    global_property_minimize_policy = 1,
    global_property_roaming_policy = 2,
    global_property_powermanagement_policy = 3,
    intf_property_connection_cost = 4,
    intf_property_dataplan_status = 5,
    intf_property_hotspot_profile = 6,
};
pub const wcm_global_property_domain_policy = WCM_PROPERTY.global_property_domain_policy;
pub const wcm_global_property_minimize_policy = WCM_PROPERTY.global_property_minimize_policy;
pub const wcm_global_property_roaming_policy = WCM_PROPERTY.global_property_roaming_policy;
pub const wcm_global_property_powermanagement_policy = WCM_PROPERTY.global_property_powermanagement_policy;
pub const wcm_intf_property_connection_cost = WCM_PROPERTY.intf_property_connection_cost;
pub const wcm_intf_property_dataplan_status = WCM_PROPERTY.intf_property_dataplan_status;
pub const wcm_intf_property_hotspot_profile = WCM_PROPERTY.intf_property_hotspot_profile;

pub const WCM_MEDIA_TYPE = enum(i32) {
    unknown = 0,
    ethernet = 1,
    wlan = 2,
    mbn = 3,
    invalid = 4,
    max = 5,
};
pub const wcm_media_unknown = WCM_MEDIA_TYPE.unknown;
pub const wcm_media_ethernet = WCM_MEDIA_TYPE.ethernet;
pub const wcm_media_wlan = WCM_MEDIA_TYPE.wlan;
pub const wcm_media_mbn = WCM_MEDIA_TYPE.mbn;
pub const wcm_media_invalid = WCM_MEDIA_TYPE.invalid;
pub const wcm_media_max = WCM_MEDIA_TYPE.max;

pub const WCM_POLICY_VALUE = extern struct {
    fValue: BOOL,
    fIsGroupPolicy: BOOL,
};

pub const WCM_PROFILE_INFO = extern struct {
    strProfileName: [256]u16,
    AdapterGUID: Guid,
    Media: WCM_MEDIA_TYPE,
};

pub const WCM_PROFILE_INFO_LIST = extern struct {
    dwNumberOfItems: u32,
    ProfileInfo: [1]WCM_PROFILE_INFO,
};

pub const WCM_CONNECTION_COST = enum(i32) {
    UNKNOWN = 0,
    UNRESTRICTED = 1,
    FIXED = 2,
    VARIABLE = 4,
    OVERDATALIMIT = 65536,
    CONGESTED = 131072,
    ROAMING = 262144,
    APPROACHINGDATALIMIT = 524288,
};
pub const WCM_CONNECTION_COST_UNKNOWN = WCM_CONNECTION_COST.UNKNOWN;
pub const WCM_CONNECTION_COST_UNRESTRICTED = WCM_CONNECTION_COST.UNRESTRICTED;
pub const WCM_CONNECTION_COST_FIXED = WCM_CONNECTION_COST.FIXED;
pub const WCM_CONNECTION_COST_VARIABLE = WCM_CONNECTION_COST.VARIABLE;
pub const WCM_CONNECTION_COST_OVERDATALIMIT = WCM_CONNECTION_COST.OVERDATALIMIT;
pub const WCM_CONNECTION_COST_CONGESTED = WCM_CONNECTION_COST.CONGESTED;
pub const WCM_CONNECTION_COST_ROAMING = WCM_CONNECTION_COST.ROAMING;
pub const WCM_CONNECTION_COST_APPROACHINGDATALIMIT = WCM_CONNECTION_COST.APPROACHINGDATALIMIT;

pub const WCM_CONNECTION_COST_SOURCE = enum(i32) {
    DEFAULT = 0,
    GP = 1,
    USER = 2,
    OPERATOR = 3,
};
pub const WCM_CONNECTION_COST_SOURCE_DEFAULT = WCM_CONNECTION_COST_SOURCE.DEFAULT;
pub const WCM_CONNECTION_COST_SOURCE_GP = WCM_CONNECTION_COST_SOURCE.GP;
pub const WCM_CONNECTION_COST_SOURCE_USER = WCM_CONNECTION_COST_SOURCE.USER;
pub const WCM_CONNECTION_COST_SOURCE_OPERATOR = WCM_CONNECTION_COST_SOURCE.OPERATOR;

pub const WCM_CONNECTION_COST_DATA = extern struct {
    ConnectionCost: u32,
    CostSource: WCM_CONNECTION_COST_SOURCE,
};

pub const WCM_TIME_INTERVAL = extern struct {
    wYear: u16,
    wMonth: u16,
    wDay: u16,
    wHour: u16,
    wMinute: u16,
    wSecond: u16,
    wMilliseconds: u16,
};

pub const WCM_USAGE_DATA = extern struct {
    UsageInMegabytes: u32,
    LastSyncTime: FILETIME,
};

pub const WCM_BILLING_CYCLE_INFO = extern struct {
    StartDate: FILETIME,
    Duration: WCM_TIME_INTERVAL,
    Reset: BOOL,
};

pub const WCM_DATAPLAN_STATUS = extern struct {
    UsageData: WCM_USAGE_DATA,
    DataLimitInMegabytes: u32,
    InboundBandwidthInKbps: u32,
    OutboundBandwidthInKbps: u32,
    BillingCycle: WCM_BILLING_CYCLE_INFO,
    MaxTransferSizeInMegabytes: u32,
    Reserved: u32,
};

pub const ONDEMAND_NOTIFICATION_CALLBACK = fn (
    param0: ?*anyopaque,
) callconv(@import("std").os.windows.WINAPI) void;

pub const NET_INTERFACE_CONTEXT = extern struct {
    InterfaceIndex: u32,
    ConfigurationName: ?PWSTR,
};

pub const NET_INTERFACE_CONTEXT_TABLE = extern struct {
    InterfaceContextHandle: ?HANDLE,
    NumberOfEntries: u32,
    InterfaceContextArray: ?*NET_INTERFACE_CONTEXT,
};

//--------------------------------------------------------------------------------
// Section: Functions (10)
//--------------------------------------------------------------------------------
// TODO: this type is limited to platform 'windows8.0'
pub extern "wcmapi" fn WcmQueryProperty(
    pInterface: ?*const Guid,
    strProfileName: ?[*:0]const u16,
    Property: WCM_PROPERTY,
    pReserved: ?*anyopaque,
    pdwDataSize: ?*u32,
    ppData: ?*?*u8,
) callconv(@import("std").os.windows.WINAPI) u32;

// TODO: this type is limited to platform 'windows8.0'
pub extern "wcmapi" fn WcmSetProperty(
    pInterface: ?*const Guid,
    strProfileName: ?[*:0]const u16,
    Property: WCM_PROPERTY,
    pReserved: ?*anyopaque,
    dwDataSize: u32,
    pbData: ?[*:0]const u8,
) callconv(@import("std").os.windows.WINAPI) u32;

// TODO: this type is limited to platform 'windows8.0'
pub extern "wcmapi" fn WcmGetProfileList(
    pReserved: ?*anyopaque,
    ppProfileList: ?*?*WCM_PROFILE_INFO_LIST,
) callconv(@import("std").os.windows.WINAPI) u32;

// TODO: this type is limited to platform 'windows8.0'
pub extern "wcmapi" fn WcmSetProfileList(
    pProfileList: ?*WCM_PROFILE_INFO_LIST,
    dwPosition: u32,
    fIgnoreUnknownProfiles: BOOL,
    pReserved: ?*anyopaque,
) callconv(@import("std").os.windows.WINAPI) u32;

// TODO: this type is limited to platform 'windows8.0'
pub extern "wcmapi" fn WcmFreeMemory(
    pMemory: ?*anyopaque,
) callconv(@import("std").os.windows.WINAPI) void;

// TODO: this type is limited to platform 'windows8.1'
pub extern "ondemandconnroutehelper" fn OnDemandGetRoutingHint(
    destinationHostName: ?[*:0]const u16,
    interfaceIndex: ?*u32,
) callconv(@import("std").os.windows.WINAPI) HRESULT;

// TODO: this type is limited to platform 'windows8.1'
pub extern "ondemandconnroutehelper" fn OnDemandRegisterNotification(
    callback: ?ONDEMAND_NOTIFICATION_CALLBACK,
    callbackContext: ?*anyopaque,
    registrationHandle: ?*?HANDLE,
) callconv(@import("std").os.windows.WINAPI) HRESULT;

// TODO: this type is limited to platform 'windows8.1'
pub extern "ondemandconnroutehelper" fn OnDemandUnRegisterNotification(
    registrationHandle: ?HANDLE,
) callconv(@import("std").os.windows.WINAPI) HRESULT;

// TODO: this type is limited to platform 'windows10.0.10240'
pub extern "ondemandconnroutehelper" fn GetInterfaceContextTableForHostName(
    HostName: ?[*:0]const u16,
    ProxyName: ?[*:0]const u16,
    Flags: u32,
    // TODO: what to do with BytesParamIndex 4?
    ConnectionProfileFilterRawData: ?*u8,
    ConnectionProfileFilterRawDataSize: u32,
    InterfaceContextTable: ?*?*NET_INTERFACE_CONTEXT_TABLE,
) callconv(@import("std").os.windows.WINAPI) HRESULT;

// TODO: this type is limited to platform 'windows10.0.10240'
pub extern "ondemandconnroutehelper" fn FreeInterfaceContextTable(
    InterfaceContextTable: ?*NET_INTERFACE_CONTEXT_TABLE,
) callconv(@import("std").os.windows.WINAPI) void;

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
// Section: Imports (6)
//--------------------------------------------------------------------------------
const Guid = @import("../zig.zig").Guid;
const BOOL = @import("../foundation.zig").BOOL;
const FILETIME = @import("../foundation.zig").FILETIME;
const HANDLE = @import("../foundation.zig").HANDLE;
const HRESULT = @import("../foundation.zig").HRESULT;
const PWSTR = @import("../foundation.zig").PWSTR;

test {
    // The following '_ = <FuncPtrType>' lines are a workaround for https://github.com/ziglang/zig/issues/4476
    if (@hasDecl(@This(), "ONDEMAND_NOTIFICATION_CALLBACK")) {
        _ = ONDEMAND_NOTIFICATION_CALLBACK;
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
