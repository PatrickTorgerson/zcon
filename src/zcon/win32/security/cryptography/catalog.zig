//! NOTE: this file is autogenerated, DO NOT MODIFY
//--------------------------------------------------------------------------------
// Section: Constants (24)
//--------------------------------------------------------------------------------
pub const CRYPTCAT_MAX_MEMBERTAG = @as(u32, 64);
pub const CRYPTCAT_MEMBER_SORTED = @as(u32, 1073741824);
pub const CRYPTCAT_ATTR_AUTHENTICATED = @as(u32, 268435456);
pub const CRYPTCAT_ATTR_UNAUTHENTICATED = @as(u32, 536870912);
pub const CRYPTCAT_ATTR_NAMEASCII = @as(u32, 1);
pub const CRYPTCAT_ATTR_NAMEOBJID = @as(u32, 2);
pub const CRYPTCAT_ATTR_DATAASCII = @as(u32, 65536);
pub const CRYPTCAT_ATTR_DATABASE64 = @as(u32, 131072);
pub const CRYPTCAT_ATTR_DATAREPLACE = @as(u32, 262144);
pub const CRYPTCAT_ATTR_NO_AUTO_COMPAT_ENTRY = @as(u32, 16777216);
pub const CRYPTCAT_E_AREA_HEADER = @as(u32, 0);
pub const CRYPTCAT_E_AREA_MEMBER = @as(u32, 65536);
pub const CRYPTCAT_E_AREA_ATTRIBUTE = @as(u32, 131072);
pub const CRYPTCAT_E_CDF_UNSUPPORTED = @as(u32, 1);
pub const CRYPTCAT_E_CDF_DUPLICATE = @as(u32, 2);
pub const CRYPTCAT_E_CDF_TAGNOTFOUND = @as(u32, 4);
pub const CRYPTCAT_E_CDF_MEMBER_FILE_PATH = @as(u32, 65537);
pub const CRYPTCAT_E_CDF_MEMBER_INDIRECTDATA = @as(u32, 65538);
pub const CRYPTCAT_E_CDF_MEMBER_FILENOTFOUND = @as(u32, 65540);
pub const CRYPTCAT_E_CDF_BAD_GUID_CONV = @as(u32, 131073);
pub const CRYPTCAT_E_CDF_ATTR_TOOFEWVALUES = @as(u32, 131074);
pub const CRYPTCAT_E_CDF_ATTR_TYPECOMBO = @as(u32, 131076);
pub const CRYPTCAT_ADDCATALOG_NONE = @as(u32, 0);
pub const CRYPTCAT_ADDCATALOG_HARDLINK = @as(u32, 1);

//--------------------------------------------------------------------------------
// Section: Types (8)
//--------------------------------------------------------------------------------
pub const CRYPTCAT_VERSION = enum(u32) {
    @"1" = 256,
    @"2" = 512,
};
pub const CRYPTCAT_VERSION_1 = CRYPTCAT_VERSION.@"1";
pub const CRYPTCAT_VERSION_2 = CRYPTCAT_VERSION.@"2";

pub const CRYPTCAT_OPEN_FLAGS = enum(u32) {
    ALWAYS = 2,
    CREATENEW = 1,
    EXISTING = 4,
    EXCLUDE_PAGE_HASHES = 65536,
    INCLUDE_PAGE_HASHES = 131072,
    VERIFYSIGHASH = 268435456,
    NO_CONTENT_HCRYPTMSG = 536870912,
    SORTED = 1073741824,
    FLAGS_MASK = 4294901760,
    _,
    pub fn initFlags(o: struct {
        ALWAYS: u1 = 0,
        CREATENEW: u1 = 0,
        EXISTING: u1 = 0,
        EXCLUDE_PAGE_HASHES: u1 = 0,
        INCLUDE_PAGE_HASHES: u1 = 0,
        VERIFYSIGHASH: u1 = 0,
        NO_CONTENT_HCRYPTMSG: u1 = 0,
        SORTED: u1 = 0,
        FLAGS_MASK: u1 = 0,
    }) CRYPTCAT_OPEN_FLAGS {
        return @intToEnum(CRYPTCAT_OPEN_FLAGS,
              (if (o.ALWAYS == 1) @enumToInt(CRYPTCAT_OPEN_FLAGS.ALWAYS) else 0)
            | (if (o.CREATENEW == 1) @enumToInt(CRYPTCAT_OPEN_FLAGS.CREATENEW) else 0)
            | (if (o.EXISTING == 1) @enumToInt(CRYPTCAT_OPEN_FLAGS.EXISTING) else 0)
            | (if (o.EXCLUDE_PAGE_HASHES == 1) @enumToInt(CRYPTCAT_OPEN_FLAGS.EXCLUDE_PAGE_HASHES) else 0)
            | (if (o.INCLUDE_PAGE_HASHES == 1) @enumToInt(CRYPTCAT_OPEN_FLAGS.INCLUDE_PAGE_HASHES) else 0)
            | (if (o.VERIFYSIGHASH == 1) @enumToInt(CRYPTCAT_OPEN_FLAGS.VERIFYSIGHASH) else 0)
            | (if (o.NO_CONTENT_HCRYPTMSG == 1) @enumToInt(CRYPTCAT_OPEN_FLAGS.NO_CONTENT_HCRYPTMSG) else 0)
            | (if (o.SORTED == 1) @enumToInt(CRYPTCAT_OPEN_FLAGS.SORTED) else 0)
            | (if (o.FLAGS_MASK == 1) @enumToInt(CRYPTCAT_OPEN_FLAGS.FLAGS_MASK) else 0)
        );
    }
};
pub const CRYPTCAT_OPEN_ALWAYS = CRYPTCAT_OPEN_FLAGS.ALWAYS;
pub const CRYPTCAT_OPEN_CREATENEW = CRYPTCAT_OPEN_FLAGS.CREATENEW;
pub const CRYPTCAT_OPEN_EXISTING = CRYPTCAT_OPEN_FLAGS.EXISTING;
pub const CRYPTCAT_OPEN_EXCLUDE_PAGE_HASHES = CRYPTCAT_OPEN_FLAGS.EXCLUDE_PAGE_HASHES;
pub const CRYPTCAT_OPEN_INCLUDE_PAGE_HASHES = CRYPTCAT_OPEN_FLAGS.INCLUDE_PAGE_HASHES;
pub const CRYPTCAT_OPEN_VERIFYSIGHASH = CRYPTCAT_OPEN_FLAGS.VERIFYSIGHASH;
pub const CRYPTCAT_OPEN_NO_CONTENT_HCRYPTMSG = CRYPTCAT_OPEN_FLAGS.NO_CONTENT_HCRYPTMSG;
pub const CRYPTCAT_OPEN_SORTED = CRYPTCAT_OPEN_FLAGS.SORTED;
pub const CRYPTCAT_OPEN_FLAGS_MASK = CRYPTCAT_OPEN_FLAGS.FLAGS_MASK;

pub const CRYPTCATSTORE = extern struct {
    cbStruct: u32,
    dwPublicVersion: u32,
    pwszP7File: ?PWSTR,
    hProv: usize,
    dwEncodingType: u32,
    fdwStoreFlags: CRYPTCAT_OPEN_FLAGS,
    hReserved: ?HANDLE,
    hAttrs: ?HANDLE,
    hCryptMsg: ?*anyopaque,
    hSorted: ?HANDLE,
};

pub const CRYPTCATMEMBER = extern struct {
    cbStruct: u32,
    pwszReferenceTag: ?PWSTR,
    pwszFileName: ?PWSTR,
    gSubjectType: Guid,
    fdwMemberFlags: u32,
    pIndirectData: ?*SIP_INDIRECT_DATA,
    dwCertVersion: u32,
    dwReserved: u32,
    hReserved: ?HANDLE,
    sEncodedIndirectData: CRYPTOAPI_BLOB,
    sEncodedMemberInfo: CRYPTOAPI_BLOB,
};

pub const CRYPTCATATTRIBUTE = extern struct {
    cbStruct: u32,
    pwszReferenceTag: ?PWSTR,
    dwAttrTypeAndAction: u32,
    cbValue: u32,
    pbValue: ?*u8,
    dwReserved: u32,
};

pub const CRYPTCATCDF = extern struct {
    cbStruct: u32,
    hFile: ?HANDLE,
    dwCurFilePos: u32,
    dwLastMemberOffset: u32,
    fEOF: BOOL,
    pwszResultDir: ?PWSTR,
    hCATStore: ?HANDLE,
};

pub const CATALOG_INFO = extern struct {
    cbStruct: u32,
    wszCatalogFile: [260]u16,
};

pub const PFN_CDF_PARSE_ERROR_CALLBACK = fn(
    dwErrorArea: u32,
    dwLocalError: u32,
    pwszLine: ?PWSTR,
) callconv(@import("std").os.windows.WINAPI) void;


//--------------------------------------------------------------------------------
// Section: Functions (34)
//--------------------------------------------------------------------------------
// TODO: this type is limited to platform 'windows5.1.2600'
pub extern "wintrust" fn CryptCATOpen(
    pwszFileName: ?PWSTR,
    fdwOpenFlags: CRYPTCAT_OPEN_FLAGS,
    hProv: usize,
    dwPublicVersion: CRYPTCAT_VERSION,
    dwEncodingType: u32,
) callconv(@import("std").os.windows.WINAPI) ?HANDLE;

// TODO: this type is limited to platform 'windows5.1.2600'
pub extern "wintrust" fn CryptCATClose(
    hCatalog: ?HANDLE,
) callconv(@import("std").os.windows.WINAPI) BOOL;

// TODO: this type is limited to platform 'windows5.1.2600'
pub extern "wintrust" fn CryptCATStoreFromHandle(
    hCatalog: ?HANDLE,
) callconv(@import("std").os.windows.WINAPI) ?*CRYPTCATSTORE;

// TODO: this type is limited to platform 'windows5.1.2600'
pub extern "wintrust" fn CryptCATHandleFromStore(
    pCatStore: ?*CRYPTCATSTORE,
) callconv(@import("std").os.windows.WINAPI) ?HANDLE;

// TODO: this type is limited to platform 'windows5.1.2600'
pub extern "wintrust" fn CryptCATPersistStore(
    hCatalog: ?HANDLE,
) callconv(@import("std").os.windows.WINAPI) BOOL;

pub extern "wintrust" fn CryptCATGetCatAttrInfo(
    hCatalog: ?HANDLE,
    pwszReferenceTag: ?PWSTR,
) callconv(@import("std").os.windows.WINAPI) ?*CRYPTCATATTRIBUTE;

// TODO: this type is limited to platform 'windows5.1.2600'
pub extern "wintrust" fn CryptCATPutCatAttrInfo(
    hCatalog: ?HANDLE,
    pwszReferenceTag: ?PWSTR,
    dwAttrTypeAndAction: u32,
    cbData: u32,
    pbData: ?*u8,
) callconv(@import("std").os.windows.WINAPI) ?*CRYPTCATATTRIBUTE;

// TODO: this type is limited to platform 'windows5.1.2600'
pub extern "wintrust" fn CryptCATEnumerateCatAttr(
    hCatalog: ?HANDLE,
    pPrevAttr: ?*CRYPTCATATTRIBUTE,
) callconv(@import("std").os.windows.WINAPI) ?*CRYPTCATATTRIBUTE;

// TODO: this type is limited to platform 'windows5.1.2600'
pub extern "wintrust" fn CryptCATGetMemberInfo(
    hCatalog: ?HANDLE,
    pwszReferenceTag: ?PWSTR,
) callconv(@import("std").os.windows.WINAPI) ?*CRYPTCATMEMBER;

pub extern "wintrust" fn CryptCATAllocSortedMemberInfo(
    hCatalog: ?HANDLE,
    pwszReferenceTag: ?PWSTR,
) callconv(@import("std").os.windows.WINAPI) ?*CRYPTCATMEMBER;

pub extern "wintrust" fn CryptCATFreeSortedMemberInfo(
    hCatalog: ?HANDLE,
    pCatMember: ?*CRYPTCATMEMBER,
) callconv(@import("std").os.windows.WINAPI) void;

// TODO: this type is limited to platform 'windows5.1.2600'
pub extern "wintrust" fn CryptCATGetAttrInfo(
    hCatalog: ?HANDLE,
    pCatMember: ?*CRYPTCATMEMBER,
    pwszReferenceTag: ?PWSTR,
) callconv(@import("std").os.windows.WINAPI) ?*CRYPTCATATTRIBUTE;

// TODO: this type is limited to platform 'windows5.1.2600'
pub extern "wintrust" fn CryptCATPutMemberInfo(
    hCatalog: ?HANDLE,
    pwszFileName: ?PWSTR,
    pwszReferenceTag: ?PWSTR,
    pgSubjectType: ?*Guid,
    dwCertVersion: u32,
    cbSIPIndirectData: u32,
    pbSIPIndirectData: ?*u8,
) callconv(@import("std").os.windows.WINAPI) ?*CRYPTCATMEMBER;

// TODO: this type is limited to platform 'windows5.1.2600'
pub extern "wintrust" fn CryptCATPutAttrInfo(
    hCatalog: ?HANDLE,
    pCatMember: ?*CRYPTCATMEMBER,
    pwszReferenceTag: ?PWSTR,
    dwAttrTypeAndAction: u32,
    cbData: u32,
    pbData: ?*u8,
) callconv(@import("std").os.windows.WINAPI) ?*CRYPTCATATTRIBUTE;

// TODO: this type is limited to platform 'windows5.1.2600'
pub extern "wintrust" fn CryptCATEnumerateMember(
    hCatalog: ?HANDLE,
    pPrevMember: ?*CRYPTCATMEMBER,
) callconv(@import("std").os.windows.WINAPI) ?*CRYPTCATMEMBER;

// TODO: this type is limited to platform 'windows5.1.2600'
pub extern "wintrust" fn CryptCATEnumerateAttr(
    hCatalog: ?HANDLE,
    pCatMember: ?*CRYPTCATMEMBER,
    pPrevAttr: ?*CRYPTCATATTRIBUTE,
) callconv(@import("std").os.windows.WINAPI) ?*CRYPTCATATTRIBUTE;

// TODO: this type is limited to platform 'windows5.1.2600'
pub extern "wintrust" fn CryptCATCDFOpen(
    pwszFilePath: ?PWSTR,
    pfnParseError: ?PFN_CDF_PARSE_ERROR_CALLBACK,
) callconv(@import("std").os.windows.WINAPI) ?*CRYPTCATCDF;

// TODO: this type is limited to platform 'windows5.1.2600'
pub extern "wintrust" fn CryptCATCDFClose(
    pCDF: ?*CRYPTCATCDF,
) callconv(@import("std").os.windows.WINAPI) BOOL;

// TODO: this type is limited to platform 'windows5.1.2600'
pub extern "wintrust" fn CryptCATCDFEnumCatAttributes(
    pCDF: ?*CRYPTCATCDF,
    pPrevAttr: ?*CRYPTCATATTRIBUTE,
    pfnParseError: ?PFN_CDF_PARSE_ERROR_CALLBACK,
) callconv(@import("std").os.windows.WINAPI) ?*CRYPTCATATTRIBUTE;

pub extern "wintrust" fn CryptCATCDFEnumMembers(
    pCDF: ?*CRYPTCATCDF,
    pPrevMember: ?*CRYPTCATMEMBER,
    pfnParseError: ?PFN_CDF_PARSE_ERROR_CALLBACK,
) callconv(@import("std").os.windows.WINAPI) ?*CRYPTCATMEMBER;

pub extern "wintrust" fn CryptCATCDFEnumAttributes(
    pCDF: ?*CRYPTCATCDF,
    pMember: ?*CRYPTCATMEMBER,
    pPrevAttr: ?*CRYPTCATATTRIBUTE,
    pfnParseError: ?PFN_CDF_PARSE_ERROR_CALLBACK,
) callconv(@import("std").os.windows.WINAPI) ?*CRYPTCATATTRIBUTE;

// TODO: this type is limited to platform 'windows5.1.2600'
pub extern "wintrust" fn IsCatalogFile(
    hFile: ?HANDLE,
    pwszFileName: ?PWSTR,
) callconv(@import("std").os.windows.WINAPI) BOOL;

// TODO: this type is limited to platform 'windows5.1.2600'
pub extern "wintrust" fn CryptCATAdminAcquireContext(
    phCatAdmin: ?*isize,
    pgSubsystem: ?*const Guid,
    dwFlags: u32,
) callconv(@import("std").os.windows.WINAPI) BOOL;

// TODO: this type is limited to platform 'windows8.0'
pub extern "wintrust" fn CryptCATAdminAcquireContext2(
    phCatAdmin: ?*isize,
    pgSubsystem: ?*const Guid,
    pwszHashAlgorithm: ?[*:0]const u16,
    pStrongHashPolicy: ?*CERT_STRONG_SIGN_PARA,
    dwFlags: u32,
) callconv(@import("std").os.windows.WINAPI) BOOL;

// TODO: this type is limited to platform 'windows5.1.2600'
pub extern "wintrust" fn CryptCATAdminReleaseContext(
    hCatAdmin: isize,
    dwFlags: u32,
) callconv(@import("std").os.windows.WINAPI) BOOL;

// TODO: this type is limited to platform 'windows5.1.2600'
pub extern "wintrust" fn CryptCATAdminReleaseCatalogContext(
    hCatAdmin: isize,
    hCatInfo: isize,
    dwFlags: u32,
) callconv(@import("std").os.windows.WINAPI) BOOL;

// TODO: this type is limited to platform 'windows5.1.2600'
pub extern "wintrust" fn CryptCATAdminEnumCatalogFromHash(
    hCatAdmin: isize,
    // TODO: what to do with BytesParamIndex 2?
    pbHash: ?*u8,
    cbHash: u32,
    dwFlags: u32,
    phPrevCatInfo: ?*isize,
) callconv(@import("std").os.windows.WINAPI) isize;

// TODO: this type is limited to platform 'windows5.1.2600'
pub extern "wintrust" fn CryptCATAdminCalcHashFromFileHandle(
    hFile: ?HANDLE,
    pcbHash: ?*u32,
    // TODO: what to do with BytesParamIndex 1?
    pbHash: ?*u8,
    dwFlags: u32,
) callconv(@import("std").os.windows.WINAPI) BOOL;

// TODO: this type is limited to platform 'windows8.0'
pub extern "wintrust" fn CryptCATAdminCalcHashFromFileHandle2(
    hCatAdmin: isize,
    hFile: ?HANDLE,
    pcbHash: ?*u32,
    // TODO: what to do with BytesParamIndex 2?
    pbHash: ?*u8,
    dwFlags: u32,
) callconv(@import("std").os.windows.WINAPI) BOOL;

// TODO: this type is limited to platform 'windows5.1.2600'
pub extern "wintrust" fn CryptCATAdminAddCatalog(
    hCatAdmin: isize,
    pwszCatalogFile: ?PWSTR,
    pwszSelectBaseName: ?PWSTR,
    dwFlags: u32,
) callconv(@import("std").os.windows.WINAPI) isize;

// TODO: this type is limited to platform 'windows5.1.2600'
pub extern "wintrust" fn CryptCATAdminRemoveCatalog(
    hCatAdmin: isize,
    pwszCatalogFile: ?[*:0]const u16,
    dwFlags: u32,
) callconv(@import("std").os.windows.WINAPI) BOOL;

// TODO: this type is limited to platform 'windows5.1.2600'
pub extern "wintrust" fn CryptCATCatalogInfoFromContext(
    hCatInfo: isize,
    psCatInfo: ?*CATALOG_INFO,
    dwFlags: u32,
) callconv(@import("std").os.windows.WINAPI) BOOL;

// TODO: this type is limited to platform 'windows5.1.2600'
pub extern "wintrust" fn CryptCATAdminResolveCatalogPath(
    hCatAdmin: isize,
    pwszCatalogFile: ?PWSTR,
    psCatInfo: ?*CATALOG_INFO,
    dwFlags: u32,
) callconv(@import("std").os.windows.WINAPI) BOOL;

pub extern "wintrust" fn CryptCATAdminPauseServiceForBackup(
    dwFlags: u32,
    fResume: BOOL,
) callconv(@import("std").os.windows.WINAPI) BOOL;


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
// Section: Imports (7)
//--------------------------------------------------------------------------------
const Guid = @import("../../zig.zig").Guid;
const BOOL = @import("../../foundation.zig").BOOL;
const CERT_STRONG_SIGN_PARA = @import("../../security/cryptography.zig").CERT_STRONG_SIGN_PARA;
const CRYPTOAPI_BLOB = @import("../../security/cryptography.zig").CRYPTOAPI_BLOB;
const HANDLE = @import("../../foundation.zig").HANDLE;
const PWSTR = @import("../../foundation.zig").PWSTR;
const SIP_INDIRECT_DATA = @import("../../security/cryptography/sip.zig").SIP_INDIRECT_DATA;

test {
    // The following '_ = <FuncPtrType>' lines are a workaround for https://github.com/ziglang/zig/issues/4476
    if (@hasDecl(@This(), "PFN_CDF_PARSE_ERROR_CALLBACK")) { _ = PFN_CDF_PARSE_ERROR_CALLBACK; }

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
