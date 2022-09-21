//! NOTE: this file is autogenerated, DO NOT MODIFY
//--------------------------------------------------------------------------------
// Section: Constants (2)
//--------------------------------------------------------------------------------
pub const WNV_API_MAJOR_VERSION_1 = @as(u32, 1);
pub const WNV_API_MINOR_VERSION_0 = @as(u32, 0);

//--------------------------------------------------------------------------------
// Section: Types (11)
//--------------------------------------------------------------------------------
pub const WNV_NOTIFICATION_TYPE = enum(i32) {
    PolicyMismatchType = 0,
    RedirectType = 1,
    ObjectChangeType = 2,
    NotificationTypeMax = 3,
};
pub const WnvPolicyMismatchType = WNV_NOTIFICATION_TYPE.PolicyMismatchType;
pub const WnvRedirectType = WNV_NOTIFICATION_TYPE.RedirectType;
pub const WnvObjectChangeType = WNV_NOTIFICATION_TYPE.ObjectChangeType;
pub const WnvNotificationTypeMax = WNV_NOTIFICATION_TYPE.NotificationTypeMax;

pub const WNV_OBJECT_TYPE = enum(i32) {
    ProviderAddressType = 0,
    CustomerAddressType = 1,
    ObjectTypeMax = 2,
};
pub const WnvProviderAddressType = WNV_OBJECT_TYPE.ProviderAddressType;
pub const WnvCustomerAddressType = WNV_OBJECT_TYPE.CustomerAddressType;
pub const WnvObjectTypeMax = WNV_OBJECT_TYPE.ObjectTypeMax;

pub const WNV_CA_NOTIFICATION_TYPE = enum(i32) {
    Added = 0,
    Deleted = 1,
    Moved = 2,
    Max = 3,
};
pub const WnvCustomerAddressAdded = WNV_CA_NOTIFICATION_TYPE.Added;
pub const WnvCustomerAddressDeleted = WNV_CA_NOTIFICATION_TYPE.Deleted;
pub const WnvCustomerAddressMoved = WNV_CA_NOTIFICATION_TYPE.Moved;
pub const WnvCustomerAddressMax = WNV_CA_NOTIFICATION_TYPE.Max;

pub const WNV_OBJECT_HEADER = extern struct {
    MajorVersion: u8,
    MinorVersion: u8,
    Size: u32,
};

pub const WNV_NOTIFICATION_PARAM = extern struct {
    Header: WNV_OBJECT_HEADER,
    NotificationType: WNV_NOTIFICATION_TYPE,
    PendingNotifications: u32,
    Buffer: ?*u8,
};

pub const WNV_IP_ADDRESS = extern struct {
    IP: extern union {
        v4: IN_ADDR,
        v6: IN6_ADDR,
        Addr: [16]u8,
    },
};

pub const WNV_POLICY_MISMATCH_PARAM = extern struct {
    CAFamily: u16,
    PAFamily: u16,
    VirtualSubnetId: u32,
    CA: WNV_IP_ADDRESS,
    PA: WNV_IP_ADDRESS,
};

pub const WNV_PROVIDER_ADDRESS_CHANGE_PARAM = extern struct {
    PAFamily: u16,
    PA: WNV_IP_ADDRESS,
    AddressState: NL_DAD_STATE,
};

pub const WNV_CUSTOMER_ADDRESS_CHANGE_PARAM = extern struct {
    MACAddress: DL_EUI48,
    CAFamily: u16,
    CA: WNV_IP_ADDRESS,
    VirtualSubnetId: u32,
    PAFamily: u16,
    PA: WNV_IP_ADDRESS,
    NotificationReason: WNV_CA_NOTIFICATION_TYPE,
};

pub const WNV_OBJECT_CHANGE_PARAM = extern struct {
    ObjectType: WNV_OBJECT_TYPE,
    ObjectParam: extern union {
        ProviderAddressChange: WNV_PROVIDER_ADDRESS_CHANGE_PARAM,
        CustomerAddressChange: WNV_CUSTOMER_ADDRESS_CHANGE_PARAM,
    },
};

pub const WNV_REDIRECT_PARAM = extern struct {
    CAFamily: u16,
    PAFamily: u16,
    NewPAFamily: u16,
    VirtualSubnetId: u32,
    CA: WNV_IP_ADDRESS,
    PA: WNV_IP_ADDRESS,
    NewPA: WNV_IP_ADDRESS,
};

//--------------------------------------------------------------------------------
// Section: Functions (2)
//--------------------------------------------------------------------------------
// TODO: this type is limited to platform 'windowsServer2012'
pub extern "wnvapi" fn WnvOpen() callconv(@import("std").os.windows.WINAPI) ?HANDLE;

// TODO: this type is limited to platform 'windowsServer2012'
pub extern "wnvapi" fn WnvRequestNotification(
    WnvHandle: ?HANDLE,
    NotificationParam: ?*WNV_NOTIFICATION_PARAM,
    Overlapped: ?*OVERLAPPED,
    BytesTransferred: ?*u32,
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
// Section: Imports (6)
//--------------------------------------------------------------------------------
const DL_EUI48 = @import("../network_management/windows_filtering_platform.zig").DL_EUI48;
const HANDLE = @import("../foundation.zig").HANDLE;
const IN6_ADDR = @import("../networking/win_sock.zig").IN6_ADDR;
const IN_ADDR = @import("../networking/win_sock.zig").IN_ADDR;
const NL_DAD_STATE = @import("../networking/win_sock.zig").NL_DAD_STATE;
const OVERLAPPED = @import("../system/io.zig").OVERLAPPED;

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
