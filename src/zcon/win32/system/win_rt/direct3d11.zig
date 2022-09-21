//! NOTE: this file is autogenerated, DO NOT MODIFY
//--------------------------------------------------------------------------------
// Section: Constants (0)
//--------------------------------------------------------------------------------

//--------------------------------------------------------------------------------
// Section: Types (1)
//--------------------------------------------------------------------------------
const IID_IDirect3DDxgiInterfaceAccess_Value = Guid.initString("a9b3d012-3df2-4ee3-b8d1-8695f457d3c1");
pub const IID_IDirect3DDxgiInterfaceAccess = &IID_IDirect3DDxgiInterfaceAccess_Value;
pub const IDirect3DDxgiInterfaceAccess = extern struct {
    pub const VTable = extern struct {
        base: IUnknown.VTable,
        GetInterface: fn(
            self: *const IDirect3DDxgiInterfaceAccess,
            iid: ?*const Guid,
            p: ?*?*anyopaque,
        ) callconv(@import("std").os.windows.WINAPI) HRESULT,
    };
    vtable: *const VTable,
    pub fn MethodMixin(comptime T: type) type { return struct {
        pub usingnamespace IUnknown.MethodMixin(T);
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn IDirect3DDxgiInterfaceAccess_GetInterface(self: *const T, iid: ?*const Guid, p: ?*?*anyopaque) callconv(.Inline) HRESULT {
            return @ptrCast(*const IDirect3DDxgiInterfaceAccess.VTable, self.vtable).GetInterface(@ptrCast(*const IDirect3DDxgiInterfaceAccess, self), iid, p);
        }
    };}
    pub usingnamespace MethodMixin(@This());
};


//--------------------------------------------------------------------------------
// Section: Functions (2)
//--------------------------------------------------------------------------------
pub extern "d3d11" fn CreateDirect3D11DeviceFromDXGIDevice(
    dxgiDevice: ?*IDXGIDevice,
    graphicsDevice: ?*?*IInspectable,
) callconv(@import("std").os.windows.WINAPI) HRESULT;

pub extern "d3d11" fn CreateDirect3D11SurfaceFromDXGISurface(
    dgxiSurface: ?*IDXGISurface,
    graphicsSurface: ?*?*IInspectable,
) callconv(@import("std").os.windows.WINAPI) HRESULT;


//--------------------------------------------------------------------------------
// Section: Unicode Aliases (0)
//--------------------------------------------------------------------------------
const thismodule = @This();
pub usingnamespace switch (@import("../../zig.zig").unicode_mode) {
    .ansi => struct {
    },
    .wide => struct {
    },
    .unspecified => if (@import("builtin").is_test) struct {
    } else struct {
    },
};
//--------------------------------------------------------------------------------
// Section: Imports (6)
//--------------------------------------------------------------------------------
const Guid = @import("../../zig.zig").Guid;
const HRESULT = @import("../../foundation.zig").HRESULT;
const IDXGIDevice = @import("../../graphics/dxgi.zig").IDXGIDevice;
const IDXGISurface = @import("../../graphics/dxgi.zig").IDXGISurface;
const IInspectable = @import("../../system/win_rt.zig").IInspectable;
const IUnknown = @import("../../system/com.zig").IUnknown;

test {
    @setEvalBranchQuota(
        comptime @import("std").meta.declarations(@This()).len * 3
    );

    // reference all the pub declarations
    if (!@import("builtin").is_test) return;
    inline for (comptime @import("std").meta.declarations(@This())) |decl| {
        if (decl.is_pub) {
            _ = decl;
        }
    }
}
