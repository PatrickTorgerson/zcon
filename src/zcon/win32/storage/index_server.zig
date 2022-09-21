//! NOTE: this file is autogenerated, DO NOT MODIFY
//--------------------------------------------------------------------------------
// Section: Constants (137)
//--------------------------------------------------------------------------------
pub const CI_VERSION_WDS30 = @as(u32, 258);
pub const CI_VERSION_WDS40 = @as(u32, 265);
pub const CI_VERSION_WIN70 = @as(u32, 1792);
pub const LIFF_LOAD_DEFINED_FILTER = @as(u32, 1);
pub const LIFF_IMPLEMENT_TEXT_FILTER_FALLBACK_POLICY = @as(u32, 2);
pub const LIFF_FORCE_TEXT_FILTER_FALLBACK = @as(u32, 3);
pub const PID_FILENAME = @as(u32, 100);
pub const DBPROP_CI_CATALOG_NAME = @as(u32, 2);
pub const DBPROP_CI_INCLUDE_SCOPES = @as(u32, 3);
pub const DBPROP_CI_DEPTHS = @as(u32, 4);
pub const DBPROP_CI_SCOPE_FLAGS = @as(u32, 4);
pub const DBPROP_CI_EXCLUDE_SCOPES = @as(u32, 5);
pub const DBPROP_CI_SECURITY_ID = @as(u32, 6);
pub const DBPROP_CI_QUERY_TYPE = @as(u32, 7);
pub const DBPROP_CI_PROVIDER = @as(u32, 8);
pub const CI_PROVIDER_MSSEARCH = @as(u32, 1);
pub const CI_PROVIDER_INDEXING_SERVICE = @as(u32, 2);
pub const CI_PROVIDER_ALL = @as(u32, 4294967295);
pub const DBPROP_DEFAULT_EQUALS_BEHAVIOR = @as(u32, 2);
pub const DBPROP_USECONTENTINDEX = @as(u32, 2);
pub const DBPROP_DEFERNONINDEXEDTRIMMING = @as(u32, 3);
pub const DBPROP_USEEXTENDEDDBTYPES = @as(u32, 4);
pub const DBPROP_IGNORENOISEONLYCLAUSES = @as(u32, 5);
pub const DBPROP_GENERICOPTIONS_STRING = @as(u32, 6);
pub const DBPROP_FIRSTROWS = @as(u32, 7);
pub const DBPROP_DEFERCATALOGVERIFICATION = @as(u32, 8);
pub const DBPROP_CATALOGLISTID = @as(u32, 9);
pub const DBPROP_GENERATEPARSETREE = @as(u32, 10);
pub const DBPROP_APPLICATION_NAME = @as(u32, 11);
pub const DBPROP_FREETEXTANYTERM = @as(u32, 12);
pub const DBPROP_FREETEXTUSESTEMMING = @as(u32, 13);
pub const DBPROP_IGNORESBRI = @as(u32, 14);
pub const DBPROP_DONOTCOMPUTEEXPENSIVEPROPS = @as(u32, 15);
pub const DBPROP_ENABLEROWSETEVENTS = @as(u32, 16);
pub const DBPROP_MACHINE = @as(u32, 2);
pub const DBPROP_CLIENT_CLSID = @as(u32, 3);
pub const MSIDXSPROP_ROWSETQUERYSTATUS = @as(u32, 2);
pub const MSIDXSPROP_COMMAND_LOCALE_STRING = @as(u32, 3);
pub const MSIDXSPROP_QUERY_RESTRICTION = @as(u32, 4);
pub const MSIDXSPROP_PARSE_TREE = @as(u32, 5);
pub const MSIDXSPROP_MAX_RANK = @as(u32, 6);
pub const MSIDXSPROP_RESULTS_FOUND = @as(u32, 7);
pub const MSIDXSPROP_WHEREID = @as(u32, 8);
pub const MSIDXSPROP_SERVER_VERSION = @as(u32, 9);
pub const MSIDXSPROP_SERVER_WINVER_MAJOR = @as(u32, 10);
pub const MSIDXSPROP_SERVER_WINVER_MINOR = @as(u32, 11);
pub const MSIDXSPROP_SERVER_NLSVERSION = @as(u32, 12);
pub const MSIDXSPROP_SERVER_NLSVER_DEFINED = @as(u32, 13);
pub const MSIDXSPROP_SAME_SORTORDER_USED = @as(u32, 14);
pub const STAT_BUSY = @as(u32, 0);
pub const STAT_ERROR = @as(u32, 1);
pub const STAT_DONE = @as(u32, 2);
pub const STAT_REFRESH = @as(u32, 3);
pub const STAT_PARTIAL_SCOPE = @as(u32, 8);
pub const STAT_NOISE_WORDS = @as(u32, 16);
pub const STAT_CONTENT_OUT_OF_DATE = @as(u32, 32);
pub const STAT_REFRESH_INCOMPLETE = @as(u32, 64);
pub const STAT_CONTENT_QUERY_INCOMPLETE = @as(u32, 128);
pub const STAT_TIME_LIMIT_EXCEEDED = @as(u32, 256);
pub const STAT_SHARING_VIOLATION = @as(u32, 512);
pub const STAT_MISSING_RELDOC = @as(u32, 1024);
pub const STAT_MISSING_PROP_IN_RELDOC = @as(u32, 2048);
pub const STAT_RELDOC_ACCESS_DENIED = @as(u32, 4096);
pub const STAT_COALESCE_COMP_ALL_NOISE = @as(u32, 8192);
pub const QUERY_SHALLOW = @as(u32, 0);
pub const QUERY_DEEP = @as(u32, 1);
pub const QUERY_PHYSICAL_PATH = @as(u32, 0);
pub const QUERY_VIRTUAL_PATH = @as(u32, 2);
pub const PROPID_QUERY_WORKID = @as(u32, 5);
pub const PROPID_QUERY_UNFILTERED = @as(u32, 7);
pub const PROPID_QUERY_VIRTUALPATH = @as(u32, 9);
pub const PROPID_QUERY_LASTSEENTIME = @as(u32, 10);
pub const CICAT_STOPPED = @as(u32, 1);
pub const CICAT_READONLY = @as(u32, 2);
pub const CICAT_WRITABLE = @as(u32, 4);
pub const CICAT_NO_QUERY = @as(u32, 8);
pub const CICAT_GET_STATE = @as(u32, 16);
pub const CICAT_ALL_OPENED = @as(u32, 32);
pub const CI_STATE_SHADOW_MERGE = @as(u32, 1);
pub const CI_STATE_MASTER_MERGE = @as(u32, 2);
pub const CI_STATE_CONTENT_SCAN_REQUIRED = @as(u32, 4);
pub const CI_STATE_ANNEALING_MERGE = @as(u32, 8);
pub const CI_STATE_SCANNING = @as(u32, 16);
pub const CI_STATE_RECOVERING = @as(u32, 32);
pub const CI_STATE_INDEX_MIGRATION_MERGE = @as(u32, 64);
pub const CI_STATE_LOW_MEMORY = @as(u32, 128);
pub const CI_STATE_HIGH_IO = @as(u32, 256);
pub const CI_STATE_MASTER_MERGE_PAUSED = @as(u32, 512);
pub const CI_STATE_READ_ONLY = @as(u32, 1024);
pub const CI_STATE_BATTERY_POWER = @as(u32, 2048);
pub const CI_STATE_USER_ACTIVE = @as(u32, 4096);
pub const CI_STATE_STARTING = @as(u32, 8192);
pub const CI_STATE_READING_USNS = @as(u32, 16384);
pub const CI_STATE_DELETION_MERGE = @as(u32, 32768);
pub const CI_STATE_LOW_DISK = @as(u32, 65536);
pub const CI_STATE_HIGH_CPU = @as(u32, 131072);
pub const CI_STATE_BATTERY_POLICY = @as(u32, 262144);
pub const GENERATE_METHOD_EXACT = @as(u32, 0);
pub const GENERATE_METHOD_PREFIX = @as(u32, 1);
pub const GENERATE_METHOD_INFLECT = @as(u32, 2);
pub const SCOPE_FLAG_MASK = @as(u32, 255);
pub const SCOPE_FLAG_INCLUDE = @as(u32, 1);
pub const SCOPE_FLAG_DEEP = @as(u32, 2);
pub const SCOPE_TYPE_MASK = @as(u32, 4294967040);
pub const SCOPE_TYPE_WINPATH = @as(u32, 256);
pub const SCOPE_TYPE_VPATH = @as(u32, 512);
pub const PROPID_QUERY_RANKVECTOR = @as(u32, 2);
pub const PROPID_QUERY_RANK = @as(u32, 3);
pub const PROPID_QUERY_HITCOUNT = @as(u32, 4);
pub const PROPID_QUERY_ALL = @as(u32, 6);
pub const PROPID_STG_CONTENTS = @as(u32, 19);
pub const VECTOR_RANK_MIN = @as(u32, 0);
pub const VECTOR_RANK_MAX = @as(u32, 1);
pub const VECTOR_RANK_INNER = @as(u32, 2);
pub const VECTOR_RANK_DICE = @as(u32, 3);
pub const VECTOR_RANK_JACCARD = @as(u32, 4);
pub const DBSETFUNC_NONE = @as(u32, 0);
pub const DBSETFUNC_ALL = @as(u32, 1);
pub const DBSETFUNC_DISTINCT = @as(u32, 2);
pub const PROXIMITY_UNIT_WORD = @as(u32, 0);
pub const PROXIMITY_UNIT_SENTENCE = @as(u32, 1);
pub const PROXIMITY_UNIT_PARAGRAPH = @as(u32, 2);
pub const PROXIMITY_UNIT_CHAPTER = @as(u32, 3);
pub const NOT_AN_ERROR = @import("../zig.zig").typedConst(HRESULT, @as(i32, 524288));
pub const FILTER_E_END_OF_CHUNKS = @import("../zig.zig").typedConst(HRESULT, @as(i32, -2147215616));
pub const FILTER_E_NO_MORE_TEXT = @import("../zig.zig").typedConst(HRESULT, @as(i32, -2147215615));
pub const FILTER_E_NO_MORE_VALUES = @import("../zig.zig").typedConst(HRESULT, @as(i32, -2147215614));
pub const FILTER_E_ACCESS = @import("../zig.zig").typedConst(HRESULT, @as(i32, -2147215613));
pub const FILTER_W_MONIKER_CLIPPED = @import("../zig.zig").typedConst(HRESULT, @as(i32, 268036));
pub const FILTER_E_NO_TEXT = @import("../zig.zig").typedConst(HRESULT, @as(i32, -2147215611));
pub const FILTER_E_NO_VALUES = @import("../zig.zig").typedConst(HRESULT, @as(i32, -2147215610));
pub const FILTER_E_EMBEDDING_UNAVAILABLE = @import("../zig.zig").typedConst(HRESULT, @as(i32, -2147215609));
pub const FILTER_E_LINK_UNAVAILABLE = @import("../zig.zig").typedConst(HRESULT, @as(i32, -2147215608));
pub const FILTER_S_LAST_TEXT = @import("../zig.zig").typedConst(HRESULT, @as(i32, 268041));
pub const FILTER_S_LAST_VALUES = @import("../zig.zig").typedConst(HRESULT, @as(i32, 268042));
pub const FILTER_E_PASSWORD = @import("../zig.zig").typedConst(HRESULT, @as(i32, -2147215605));
pub const FILTER_E_UNKNOWNFORMAT = @import("../zig.zig").typedConst(HRESULT, @as(i32, -2147215604));

//--------------------------------------------------------------------------------
// Section: Types (14)
//--------------------------------------------------------------------------------
pub const CI_STATE = extern struct {
    cbStruct: u32,
    cWordList: u32,
    cPersistentIndex: u32,
    cQueries: u32,
    cDocuments: u32,
    cFreshTest: u32,
    dwMergeProgress: u32,
    eState: u32,
    cFilteredDocuments: u32,
    cTotalDocuments: u32,
    cPendingScans: u32,
    dwIndexSize: u32,
    cUniqueKeys: u32,
    cSecQDocuments: u32,
    dwPropCacheSize: u32,
};

pub const FULLPROPSPEC = extern struct {
    guidPropSet: Guid,
    psProperty: PROPSPEC,
};

pub const IFILTER_INIT = enum(i32) {
    CANON_PARAGRAPHS = 1,
    HARD_LINE_BREAKS = 2,
    CANON_HYPHENS = 4,
    CANON_SPACES = 8,
    APPLY_INDEX_ATTRIBUTES = 16,
    APPLY_OTHER_ATTRIBUTES = 32,
    APPLY_CRAWL_ATTRIBUTES = 256,
    INDEXING_ONLY = 64,
    SEARCH_LINKS = 128,
    FILTER_OWNED_VALUE_OK = 512,
    FILTER_AGGRESSIVE_BREAK = 1024,
    DISABLE_EMBEDDED = 2048,
    EMIT_FORMATTING = 4096,
};
pub const IFILTER_INIT_CANON_PARAGRAPHS = IFILTER_INIT.CANON_PARAGRAPHS;
pub const IFILTER_INIT_HARD_LINE_BREAKS = IFILTER_INIT.HARD_LINE_BREAKS;
pub const IFILTER_INIT_CANON_HYPHENS = IFILTER_INIT.CANON_HYPHENS;
pub const IFILTER_INIT_CANON_SPACES = IFILTER_INIT.CANON_SPACES;
pub const IFILTER_INIT_APPLY_INDEX_ATTRIBUTES = IFILTER_INIT.APPLY_INDEX_ATTRIBUTES;
pub const IFILTER_INIT_APPLY_OTHER_ATTRIBUTES = IFILTER_INIT.APPLY_OTHER_ATTRIBUTES;
pub const IFILTER_INIT_APPLY_CRAWL_ATTRIBUTES = IFILTER_INIT.APPLY_CRAWL_ATTRIBUTES;
pub const IFILTER_INIT_INDEXING_ONLY = IFILTER_INIT.INDEXING_ONLY;
pub const IFILTER_INIT_SEARCH_LINKS = IFILTER_INIT.SEARCH_LINKS;
pub const IFILTER_INIT_FILTER_OWNED_VALUE_OK = IFILTER_INIT.FILTER_OWNED_VALUE_OK;
pub const IFILTER_INIT_FILTER_AGGRESSIVE_BREAK = IFILTER_INIT.FILTER_AGGRESSIVE_BREAK;
pub const IFILTER_INIT_DISABLE_EMBEDDED = IFILTER_INIT.DISABLE_EMBEDDED;
pub const IFILTER_INIT_EMIT_FORMATTING = IFILTER_INIT.EMIT_FORMATTING;

pub const IFILTER_FLAGS = enum(i32) {
    S = 1,
};
pub const IFILTER_FLAGS_OLE_PROPERTIES = IFILTER_FLAGS.S;

pub const CHUNKSTATE = enum(i32) {
    TEXT = 1,
    VALUE = 2,
    FILTER_OWNED_VALUE = 4,
};
pub const CHUNK_TEXT = CHUNKSTATE.TEXT;
pub const CHUNK_VALUE = CHUNKSTATE.VALUE;
pub const CHUNK_FILTER_OWNED_VALUE = CHUNKSTATE.FILTER_OWNED_VALUE;

pub const CHUNK_BREAKTYPE = enum(i32) {
    NO_BREAK = 0,
    EOW = 1,
    EOS = 2,
    EOP = 3,
    EOC = 4,
};
pub const CHUNK_NO_BREAK = CHUNK_BREAKTYPE.NO_BREAK;
pub const CHUNK_EOW = CHUNK_BREAKTYPE.EOW;
pub const CHUNK_EOS = CHUNK_BREAKTYPE.EOS;
pub const CHUNK_EOP = CHUNK_BREAKTYPE.EOP;
pub const CHUNK_EOC = CHUNK_BREAKTYPE.EOC;

pub const FILTERREGION = extern struct {
    idChunk: u32,
    cwcStart: u32,
    cwcExtent: u32,
};

pub const STAT_CHUNK = extern struct {
    idChunk: u32,
    breakType: CHUNK_BREAKTYPE,
    flags: CHUNKSTATE,
    locale: u32,
    attribute: FULLPROPSPEC,
    idChunkSource: u32,
    cwcStartSource: u32,
    cwcLenSource: u32,
};

// TODO: this type is limited to platform 'windows5.0'
const IID_IFilter_Value = Guid.initString("89bcb740-6119-101a-bcb7-00dd010655af");
pub const IID_IFilter = &IID_IFilter_Value;
pub const IFilter = extern struct {
    pub const VTable = extern struct {
        base: IUnknown.VTable,
        Init: fn (
            self: *const IFilter,
            grfFlags: u32,
            cAttributes: u32,
            aAttributes: [*]const FULLPROPSPEC,
            pFlags: ?*u32,
        ) callconv(@import("std").os.windows.WINAPI) i32,
        GetChunk: fn (
            self: *const IFilter,
            pStat: ?*STAT_CHUNK,
        ) callconv(@import("std").os.windows.WINAPI) i32,
        GetText: fn (
            self: *const IFilter,
            pcwcBuffer: ?*u32,
            awcBuffer: [*:0]u16,
        ) callconv(@import("std").os.windows.WINAPI) i32,
        GetValue: fn (
            self: *const IFilter,
            ppPropValue: ?*?*PROPVARIANT,
        ) callconv(@import("std").os.windows.WINAPI) i32,
        BindRegion: fn (
            self: *const IFilter,
            origPos: FILTERREGION,
            riid: ?*const Guid,
            ppunk: ?*?*anyopaque,
        ) callconv(@import("std").os.windows.WINAPI) i32,
    };
    vtable: *const VTable,
    pub fn MethodMixin(comptime T: type) type {
        return struct {
            pub usingnamespace IUnknown.MethodMixin(T);
            // NOTE: method is namespaced with interface name to avoid conflicts for now
            pub inline fn IFilter_Init(self: *const T, grfFlags: u32, cAttributes: u32, aAttributes: [*]const FULLPROPSPEC, pFlags: ?*u32) i32 {
                return @ptrCast(*const IFilter.VTable, self.vtable).Init(@ptrCast(*const IFilter, self), grfFlags, cAttributes, aAttributes, pFlags);
            }
            // NOTE: method is namespaced with interface name to avoid conflicts for now
            pub inline fn IFilter_GetChunk(self: *const T, pStat: ?*STAT_CHUNK) i32 {
                return @ptrCast(*const IFilter.VTable, self.vtable).GetChunk(@ptrCast(*const IFilter, self), pStat);
            }
            // NOTE: method is namespaced with interface name to avoid conflicts for now
            pub inline fn IFilter_GetText(self: *const T, pcwcBuffer: ?*u32, awcBuffer: [*:0]u16) i32 {
                return @ptrCast(*const IFilter.VTable, self.vtable).GetText(@ptrCast(*const IFilter, self), pcwcBuffer, awcBuffer);
            }
            // NOTE: method is namespaced with interface name to avoid conflicts for now
            pub inline fn IFilter_GetValue(self: *const T, ppPropValue: ?*?*PROPVARIANT) i32 {
                return @ptrCast(*const IFilter.VTable, self.vtable).GetValue(@ptrCast(*const IFilter, self), ppPropValue);
            }
            // NOTE: method is namespaced with interface name to avoid conflicts for now
            pub inline fn IFilter_BindRegion(self: *const T, origPos: FILTERREGION, riid: ?*const Guid, ppunk: ?*?*anyopaque) i32 {
                return @ptrCast(*const IFilter.VTable, self.vtable).BindRegion(@ptrCast(*const IFilter, self), origPos, riid, ppunk);
            }
        };
    }
    pub usingnamespace MethodMixin(@This());
};

// TODO: this type is limited to platform 'windows5.0'
const IID_IPhraseSink_Value = Guid.initString("cc906ff0-c058-101a-b554-08002b33b0e6");
pub const IID_IPhraseSink = &IID_IPhraseSink_Value;
pub const IPhraseSink = extern struct {
    pub const VTable = extern struct {
        base: IUnknown.VTable,
        PutSmallPhrase: fn (
            self: *const IPhraseSink,
            pwcNoun: ?[*:0]const u16,
            cwcNoun: u32,
            pwcModifier: ?[*:0]const u16,
            cwcModifier: u32,
            ulAttachmentType: u32,
        ) callconv(@import("std").os.windows.WINAPI) HRESULT,
        PutPhrase: fn (
            self: *const IPhraseSink,
            pwcPhrase: ?[*:0]const u16,
            cwcPhrase: u32,
        ) callconv(@import("std").os.windows.WINAPI) HRESULT,
    };
    vtable: *const VTable,
    pub fn MethodMixin(comptime T: type) type {
        return struct {
            pub usingnamespace IUnknown.MethodMixin(T);
            // NOTE: method is namespaced with interface name to avoid conflicts for now
            pub inline fn IPhraseSink_PutSmallPhrase(self: *const T, pwcNoun: ?[*:0]const u16, cwcNoun: u32, pwcModifier: ?[*:0]const u16, cwcModifier: u32, ulAttachmentType: u32) HRESULT {
                return @ptrCast(*const IPhraseSink.VTable, self.vtable).PutSmallPhrase(@ptrCast(*const IPhraseSink, self), pwcNoun, cwcNoun, pwcModifier, cwcModifier, ulAttachmentType);
            }
            // NOTE: method is namespaced with interface name to avoid conflicts for now
            pub inline fn IPhraseSink_PutPhrase(self: *const T, pwcPhrase: ?[*:0]const u16, cwcPhrase: u32) HRESULT {
                return @ptrCast(*const IPhraseSink.VTable, self.vtable).PutPhrase(@ptrCast(*const IPhraseSink, self), pwcPhrase, cwcPhrase);
            }
        };
    }
    pub usingnamespace MethodMixin(@This());
};

pub const WORDREP_BREAK_TYPE = enum(i32) {
    W = 0,
    S = 1,
    P = 2,
    C = 3,
};
pub const WORDREP_BREAK_EOW = WORDREP_BREAK_TYPE.W;
pub const WORDREP_BREAK_EOS = WORDREP_BREAK_TYPE.S;
pub const WORDREP_BREAK_EOP = WORDREP_BREAK_TYPE.P;
pub const WORDREP_BREAK_EOC = WORDREP_BREAK_TYPE.C;

pub const DBKINDENUM = enum(i32) {
    GUID_NAME = 0,
    GUID_PROPID = 1,
    NAME = 2,
    PGUID_NAME = 3,
    PGUID_PROPID = 4,
    PROPID = 5,
    GUID = 6,
};
pub const DBKIND_GUID_NAME = DBKINDENUM.GUID_NAME;
pub const DBKIND_GUID_PROPID = DBKINDENUM.GUID_PROPID;
pub const DBKIND_NAME = DBKINDENUM.NAME;
pub const DBKIND_PGUID_NAME = DBKINDENUM.PGUID_NAME;
pub const DBKIND_PGUID_PROPID = DBKINDENUM.PGUID_PROPID;
pub const DBKIND_PROPID = DBKINDENUM.PROPID;
pub const DBKIND_GUID = DBKINDENUM.GUID;

pub const DBID = switch (@import("../zig.zig").arch) {
    .X64, .Arm64 => extern struct {
        uGuid: extern union {
            guid: Guid,
            pguid: ?*Guid,
        },
        eKind: u32,
        uName: extern union {
            pwszName: ?PWSTR,
            ulPropid: u32,
        },
    },
    .X86 => extern struct {
        // WARNING: unable to add field alignment because it's causing a compiler bug
        uGuid: extern union {
            // WARNING: unable to add field alignment because it's not implemented for unions
            guid: Guid,
            pguid: ?*Guid,
        },
        eKind: u32,
        uName: extern union {
            // WARNING: unable to add field alignment because it's not implemented for unions
            pwszName: ?PWSTR,
            ulPropid: u32,
        },
    },
};

//--------------------------------------------------------------------------------
// Section: Functions (4)
//--------------------------------------------------------------------------------
// TODO: this type is limited to platform 'windows5.0'
pub extern "query" fn LoadIFilter(
    pwcsPath: ?[*:0]const u16,
    pUnkOuter: ?*IUnknown,
    ppIUnk: ?*?*anyopaque,
) callconv(@import("std").os.windows.WINAPI) HRESULT;

pub extern "query" fn LoadIFilterEx(
    pwcsPath: ?[*:0]const u16,
    dwFlags: u32,
    riid: ?*const Guid,
    ppIUnk: ?*?*anyopaque,
) callconv(@import("std").os.windows.WINAPI) HRESULT;

// TODO: this type is limited to platform 'windows5.0'
pub extern "query" fn BindIFilterFromStorage(
    pStg: ?*IStorage,
    pUnkOuter: ?*IUnknown,
    ppIUnk: ?*?*anyopaque,
) callconv(@import("std").os.windows.WINAPI) HRESULT;

// TODO: this type is limited to platform 'windows5.0'
pub extern "query" fn BindIFilterFromStream(
    pStm: ?*IStream,
    pUnkOuter: ?*IUnknown,
    ppIUnk: ?*?*anyopaque,
) callconv(@import("std").os.windows.WINAPI) HRESULT;

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
// Section: Imports (8)
//--------------------------------------------------------------------------------
const Guid = @import("../zig.zig").Guid;
const HRESULT = @import("../foundation.zig").HRESULT;
const IStorage = @import("../system/com/structured_storage.zig").IStorage;
const IStream = @import("../system/com.zig").IStream;
const IUnknown = @import("../system/com.zig").IUnknown;
const PROPSPEC = @import("../system/com/structured_storage.zig").PROPSPEC;
const PROPVARIANT = @import("../system/com/structured_storage.zig").PROPVARIANT;
const PWSTR = @import("../foundation.zig").PWSTR;

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
