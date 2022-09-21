//! NOTE: this file is autogenerated, DO NOT MODIFY
//--------------------------------------------------------------------------------
// Section: Constants (86)
//--------------------------------------------------------------------------------
pub const FILTER_NAME_MAX_CHARS = @as(u32, 255);
pub const VOLUME_NAME_MAX_CHARS = @as(u32, 1024);
pub const INSTANCE_NAME_MAX_CHARS = @as(u32, 255);
pub const FLTFL_AGGREGATE_INFO_IS_MINIFILTER = @as(u32, 1);
pub const FLTFL_AGGREGATE_INFO_IS_LEGACYFILTER = @as(u32, 2);
pub const FLTFL_ASI_IS_MINIFILTER = @as(u32, 1);
pub const FLTFL_ASI_IS_LEGACYFILTER = @as(u32, 2);
pub const FLTFL_VSI_DETACHED_VOLUME = @as(u32, 1);
pub const FLTFL_IASI_IS_MINIFILTER = @as(u32, 1);
pub const FLTFL_IASI_IS_LEGACYFILTER = @as(u32, 2);
pub const FLTFL_IASIM_DETACHED_VOLUME = @as(u32, 1);
pub const FLTFL_IASIL_DETACHED_VOLUME = @as(u32, 1);
pub const FLT_PORT_FLAG_SYNC_HANDLE = @as(u32, 1);
pub const WNNC_NET_MSNET = @as(u32, 65536);
pub const WNNC_NET_SMB = @as(u32, 131072);
pub const WNNC_NET_NETWARE = @as(u32, 196608);
pub const WNNC_NET_VINES = @as(u32, 262144);
pub const WNNC_NET_10NET = @as(u32, 327680);
pub const WNNC_NET_LOCUS = @as(u32, 393216);
pub const WNNC_NET_SUN_PC_NFS = @as(u32, 458752);
pub const WNNC_NET_LANSTEP = @as(u32, 524288);
pub const WNNC_NET_9TILES = @as(u32, 589824);
pub const WNNC_NET_LANTASTIC = @as(u32, 655360);
pub const WNNC_NET_AS400 = @as(u32, 720896);
pub const WNNC_NET_FTP_NFS = @as(u32, 786432);
pub const WNNC_NET_PATHWORKS = @as(u32, 851968);
pub const WNNC_NET_LIFENET = @as(u32, 917504);
pub const WNNC_NET_POWERLAN = @as(u32, 983040);
pub const WNNC_NET_BWNFS = @as(u32, 1048576);
pub const WNNC_NET_COGENT = @as(u32, 1114112);
pub const WNNC_NET_FARALLON = @as(u32, 1179648);
pub const WNNC_NET_APPLETALK = @as(u32, 1245184);
pub const WNNC_NET_INTERGRAPH = @as(u32, 1310720);
pub const WNNC_NET_SYMFONET = @as(u32, 1376256);
pub const WNNC_NET_CLEARCASE = @as(u32, 1441792);
pub const WNNC_NET_FRONTIER = @as(u32, 1507328);
pub const WNNC_NET_BMC = @as(u32, 1572864);
pub const WNNC_NET_DCE = @as(u32, 1638400);
pub const WNNC_NET_AVID = @as(u32, 1703936);
pub const WNNC_NET_DOCUSPACE = @as(u32, 1769472);
pub const WNNC_NET_MANGOSOFT = @as(u32, 1835008);
pub const WNNC_NET_SERNET = @as(u32, 1900544);
pub const WNNC_NET_RIVERFRONT1 = @as(u32, 1966080);
pub const WNNC_NET_RIVERFRONT2 = @as(u32, 2031616);
pub const WNNC_NET_DECORB = @as(u32, 2097152);
pub const WNNC_NET_PROTSTOR = @as(u32, 2162688);
pub const WNNC_NET_FJ_REDIR = @as(u32, 2228224);
pub const WNNC_NET_DISTINCT = @as(u32, 2293760);
pub const WNNC_NET_TWINS = @as(u32, 2359296);
pub const WNNC_NET_RDR2SAMPLE = @as(u32, 2424832);
pub const WNNC_NET_CSC = @as(u32, 2490368);
pub const WNNC_NET_3IN1 = @as(u32, 2555904);
pub const WNNC_NET_EXTENDNET = @as(u32, 2686976);
pub const WNNC_NET_STAC = @as(u32, 2752512);
pub const WNNC_NET_FOXBAT = @as(u32, 2818048);
pub const WNNC_NET_YAHOO = @as(u32, 2883584);
pub const WNNC_NET_EXIFS = @as(u32, 2949120);
pub const WNNC_NET_DAV = @as(u32, 3014656);
pub const WNNC_NET_KNOWARE = @as(u32, 3080192);
pub const WNNC_NET_OBJECT_DIRE = @as(u32, 3145728);
pub const WNNC_NET_MASFAX = @as(u32, 3211264);
pub const WNNC_NET_HOB_NFS = @as(u32, 3276800);
pub const WNNC_NET_SHIVA = @as(u32, 3342336);
pub const WNNC_NET_IBMAL = @as(u32, 3407872);
pub const WNNC_NET_LOCK = @as(u32, 3473408);
pub const WNNC_NET_TERMSRV = @as(u32, 3538944);
pub const WNNC_NET_SRT = @as(u32, 3604480);
pub const WNNC_NET_QUINCY = @as(u32, 3670016);
pub const WNNC_NET_OPENAFS = @as(u32, 3735552);
pub const WNNC_NET_AVID1 = @as(u32, 3801088);
pub const WNNC_NET_DFS = @as(u32, 3866624);
pub const WNNC_NET_KWNP = @as(u32, 3932160);
pub const WNNC_NET_ZENWORKS = @as(u32, 3997696);
pub const WNNC_NET_DRIVEONWEB = @as(u32, 4063232);
pub const WNNC_NET_VMWARE = @as(u32, 4128768);
pub const WNNC_NET_RSFX = @as(u32, 4194304);
pub const WNNC_NET_MFILES = @as(u32, 4259840);
pub const WNNC_NET_MS_NFS = @as(u32, 4325376);
pub const WNNC_NET_GOOGLE = @as(u32, 4390912);
pub const WNNC_NET_NDFS = @as(u32, 4456448);
pub const WNNC_NET_DOCUSHARE = @as(u32, 4521984);
pub const WNNC_NET_AURISTOR_FS = @as(u32, 4587520);
pub const WNNC_NET_SECUREAGENT = @as(u32, 4653056);
pub const WNNC_NET_9P = @as(u32, 4718592);
pub const WNNC_CRED_MANAGER = @as(u32, 4294901760);
pub const WNNC_NET_LANMAN = @as(u32, 131072);

//--------------------------------------------------------------------------------
// Section: Types (21)
//--------------------------------------------------------------------------------
// TODO: this type has a FreeFunc 'FilterClose', what can Zig do with this information?
pub const HFILTER = *opaque{};

// TODO: this type has a FreeFunc 'FilterInstanceClose', what can Zig do with this information?
pub const HFILTER_INSTANCE = isize;

// TODO: this type has a FreeFunc 'FilterFindClose', what can Zig do with this information?
pub const FilterFindHandle = isize;

// TODO: this type has a FreeFunc 'FilterVolumeFindClose', what can Zig do with this information?
pub const FilterVolumeFindHandle = isize;

// TODO: this type has a FreeFunc 'FilterInstanceFindClose', what can Zig do with this information?
pub const FilterInstanceFindHandle = isize;

// TODO: this type has a FreeFunc 'FilterVolumeInstanceFindClose', what can Zig do with this information?
pub const FilterVolumeInstanceFindHandle = isize;

pub const FLT_FILESYSTEM_TYPE = enum(i32) {
    UNKNOWN = 0,
    RAW = 1,
    NTFS = 2,
    FAT = 3,
    CDFS = 4,
    UDFS = 5,
    LANMAN = 6,
    WEBDAV = 7,
    RDPDR = 8,
    NFS = 9,
    MS_NETWARE = 10,
    NETWARE = 11,
    BSUDF = 12,
    MUP = 13,
    RSFX = 14,
    ROXIO_UDF1 = 15,
    ROXIO_UDF2 = 16,
    ROXIO_UDF3 = 17,
    TACIT = 18,
    FS_REC = 19,
    INCD = 20,
    INCD_FAT = 21,
    EXFAT = 22,
    PSFS = 23,
    GPFS = 24,
    NPFS = 25,
    MSFS = 26,
    CSVFS = 27,
    REFS = 28,
    OPENAFS = 29,
    CIMFS = 30,
};
pub const FLT_FSTYPE_UNKNOWN = FLT_FILESYSTEM_TYPE.UNKNOWN;
pub const FLT_FSTYPE_RAW = FLT_FILESYSTEM_TYPE.RAW;
pub const FLT_FSTYPE_NTFS = FLT_FILESYSTEM_TYPE.NTFS;
pub const FLT_FSTYPE_FAT = FLT_FILESYSTEM_TYPE.FAT;
pub const FLT_FSTYPE_CDFS = FLT_FILESYSTEM_TYPE.CDFS;
pub const FLT_FSTYPE_UDFS = FLT_FILESYSTEM_TYPE.UDFS;
pub const FLT_FSTYPE_LANMAN = FLT_FILESYSTEM_TYPE.LANMAN;
pub const FLT_FSTYPE_WEBDAV = FLT_FILESYSTEM_TYPE.WEBDAV;
pub const FLT_FSTYPE_RDPDR = FLT_FILESYSTEM_TYPE.RDPDR;
pub const FLT_FSTYPE_NFS = FLT_FILESYSTEM_TYPE.NFS;
pub const FLT_FSTYPE_MS_NETWARE = FLT_FILESYSTEM_TYPE.MS_NETWARE;
pub const FLT_FSTYPE_NETWARE = FLT_FILESYSTEM_TYPE.NETWARE;
pub const FLT_FSTYPE_BSUDF = FLT_FILESYSTEM_TYPE.BSUDF;
pub const FLT_FSTYPE_MUP = FLT_FILESYSTEM_TYPE.MUP;
pub const FLT_FSTYPE_RSFX = FLT_FILESYSTEM_TYPE.RSFX;
pub const FLT_FSTYPE_ROXIO_UDF1 = FLT_FILESYSTEM_TYPE.ROXIO_UDF1;
pub const FLT_FSTYPE_ROXIO_UDF2 = FLT_FILESYSTEM_TYPE.ROXIO_UDF2;
pub const FLT_FSTYPE_ROXIO_UDF3 = FLT_FILESYSTEM_TYPE.ROXIO_UDF3;
pub const FLT_FSTYPE_TACIT = FLT_FILESYSTEM_TYPE.TACIT;
pub const FLT_FSTYPE_FS_REC = FLT_FILESYSTEM_TYPE.FS_REC;
pub const FLT_FSTYPE_INCD = FLT_FILESYSTEM_TYPE.INCD;
pub const FLT_FSTYPE_INCD_FAT = FLT_FILESYSTEM_TYPE.INCD_FAT;
pub const FLT_FSTYPE_EXFAT = FLT_FILESYSTEM_TYPE.EXFAT;
pub const FLT_FSTYPE_PSFS = FLT_FILESYSTEM_TYPE.PSFS;
pub const FLT_FSTYPE_GPFS = FLT_FILESYSTEM_TYPE.GPFS;
pub const FLT_FSTYPE_NPFS = FLT_FILESYSTEM_TYPE.NPFS;
pub const FLT_FSTYPE_MSFS = FLT_FILESYSTEM_TYPE.MSFS;
pub const FLT_FSTYPE_CSVFS = FLT_FILESYSTEM_TYPE.CSVFS;
pub const FLT_FSTYPE_REFS = FLT_FILESYSTEM_TYPE.REFS;
pub const FLT_FSTYPE_OPENAFS = FLT_FILESYSTEM_TYPE.OPENAFS;
pub const FLT_FSTYPE_CIMFS = FLT_FILESYSTEM_TYPE.CIMFS;

pub const FILTER_INFORMATION_CLASS = enum(i32) {
    FullInformation = 0,
    AggregateBasicInformation = 1,
    AggregateStandardInformation = 2,
};
pub const FilterFullInformation = FILTER_INFORMATION_CLASS.FullInformation;
pub const FilterAggregateBasicInformation = FILTER_INFORMATION_CLASS.AggregateBasicInformation;
pub const FilterAggregateStandardInformation = FILTER_INFORMATION_CLASS.AggregateStandardInformation;

pub const FILTER_FULL_INFORMATION = extern struct {
    NextEntryOffset: u32,
    FrameID: u32,
    NumberOfInstances: u32,
    FilterNameLength: u16,
    FilterNameBuffer: [1]u16,
};

pub const FILTER_AGGREGATE_BASIC_INFORMATION = extern struct {
    NextEntryOffset: u32,
    Flags: u32,
    Type: extern union {
        MiniFilter: extern struct {
            FrameID: u32,
            NumberOfInstances: u32,
            FilterNameLength: u16,
            FilterNameBufferOffset: u16,
            FilterAltitudeLength: u16,
            FilterAltitudeBufferOffset: u16,
        },
        LegacyFilter: extern struct {
            FilterNameLength: u16,
            FilterNameBufferOffset: u16,
        },
    },
};

pub const FILTER_AGGREGATE_STANDARD_INFORMATION = extern struct {
    NextEntryOffset: u32,
    Flags: u32,
    Type: extern union {
        MiniFilter: extern struct {
            Flags: u32,
            FrameID: u32,
            NumberOfInstances: u32,
            FilterNameLength: u16,
            FilterNameBufferOffset: u16,
            FilterAltitudeLength: u16,
            FilterAltitudeBufferOffset: u16,
        },
        LegacyFilter: extern struct {
            Flags: u32,
            FilterNameLength: u16,
            FilterNameBufferOffset: u16,
            FilterAltitudeLength: u16,
            FilterAltitudeBufferOffset: u16,
        },
    },
};

pub const FILTER_VOLUME_INFORMATION_CLASS = enum(i32) {
    BasicInformation = 0,
    StandardInformation = 1,
};
pub const FilterVolumeBasicInformation = FILTER_VOLUME_INFORMATION_CLASS.BasicInformation;
pub const FilterVolumeStandardInformation = FILTER_VOLUME_INFORMATION_CLASS.StandardInformation;

pub const FILTER_VOLUME_BASIC_INFORMATION = extern struct {
    FilterVolumeNameLength: u16,
    FilterVolumeName: [1]u16,
};

pub const FILTER_VOLUME_STANDARD_INFORMATION = extern struct {
    NextEntryOffset: u32,
    Flags: u32,
    FrameID: u32,
    FileSystemType: FLT_FILESYSTEM_TYPE,
    FilterVolumeNameLength: u16,
    FilterVolumeName: [1]u16,
};

pub const INSTANCE_INFORMATION_CLASS = enum(i32) {
    BasicInformation = 0,
    PartialInformation = 1,
    FullInformation = 2,
    AggregateStandardInformation = 3,
};
pub const InstanceBasicInformation = INSTANCE_INFORMATION_CLASS.BasicInformation;
pub const InstancePartialInformation = INSTANCE_INFORMATION_CLASS.PartialInformation;
pub const InstanceFullInformation = INSTANCE_INFORMATION_CLASS.FullInformation;
pub const InstanceAggregateStandardInformation = INSTANCE_INFORMATION_CLASS.AggregateStandardInformation;

pub const INSTANCE_BASIC_INFORMATION = extern struct {
    NextEntryOffset: u32,
    InstanceNameLength: u16,
    InstanceNameBufferOffset: u16,
};

pub const INSTANCE_PARTIAL_INFORMATION = extern struct {
    NextEntryOffset: u32,
    InstanceNameLength: u16,
    InstanceNameBufferOffset: u16,
    AltitudeLength: u16,
    AltitudeBufferOffset: u16,
};

pub const INSTANCE_FULL_INFORMATION = extern struct {
    NextEntryOffset: u32,
    InstanceNameLength: u16,
    InstanceNameBufferOffset: u16,
    AltitudeLength: u16,
    AltitudeBufferOffset: u16,
    VolumeNameLength: u16,
    VolumeNameBufferOffset: u16,
    FilterNameLength: u16,
    FilterNameBufferOffset: u16,
};

pub const INSTANCE_AGGREGATE_STANDARD_INFORMATION = extern struct {
    NextEntryOffset: u32,
    Flags: u32,
    Type: extern union {
        MiniFilter: extern struct {
            Flags: u32,
            FrameID: u32,
            VolumeFileSystemType: FLT_FILESYSTEM_TYPE,
            InstanceNameLength: u16,
            InstanceNameBufferOffset: u16,
            AltitudeLength: u16,
            AltitudeBufferOffset: u16,
            VolumeNameLength: u16,
            VolumeNameBufferOffset: u16,
            FilterNameLength: u16,
            FilterNameBufferOffset: u16,
            SupportedFeatures: u32,
        },
        LegacyFilter: extern struct {
            Flags: u32,
            AltitudeLength: u16,
            AltitudeBufferOffset: u16,
            VolumeNameLength: u16,
            VolumeNameBufferOffset: u16,
            FilterNameLength: u16,
            FilterNameBufferOffset: u16,
            SupportedFeatures: u32,
        },
    },
};

pub const FILTER_MESSAGE_HEADER = extern struct {
    ReplyLength: u32,
    MessageId: u64,
};

pub const FILTER_REPLY_HEADER = extern struct {
    Status: NTSTATUS,
    MessageId: u64,
};


//--------------------------------------------------------------------------------
// Section: Functions (28)
//--------------------------------------------------------------------------------
pub extern "fltlib" fn FilterLoad(
    lpFilterName: ?[*:0]const u16,
) callconv(@import("std").os.windows.WINAPI) HRESULT;

pub extern "fltlib" fn FilterUnload(
    lpFilterName: ?[*:0]const u16,
) callconv(@import("std").os.windows.WINAPI) HRESULT;

pub extern "fltlib" fn FilterCreate(
    lpFilterName: ?[*:0]const u16,
    hFilter: ?*?HFILTER,
) callconv(@import("std").os.windows.WINAPI) HRESULT;

pub extern "fltlib" fn FilterClose(
    hFilter: ?HFILTER,
) callconv(@import("std").os.windows.WINAPI) HRESULT;

pub extern "fltlib" fn FilterInstanceCreate(
    lpFilterName: ?[*:0]const u16,
    lpVolumeName: ?[*:0]const u16,
    lpInstanceName: ?[*:0]const u16,
    hInstance: ?*HFILTER_INSTANCE,
) callconv(@import("std").os.windows.WINAPI) HRESULT;

pub extern "fltlib" fn FilterInstanceClose(
    hInstance: HFILTER_INSTANCE,
) callconv(@import("std").os.windows.WINAPI) HRESULT;

pub extern "fltlib" fn FilterAttach(
    lpFilterName: ?[*:0]const u16,
    lpVolumeName: ?[*:0]const u16,
    lpInstanceName: ?[*:0]const u16,
    dwCreatedInstanceNameLength: u32,
    // TODO: what to do with BytesParamIndex 3?
    lpCreatedInstanceName: ?PWSTR,
) callconv(@import("std").os.windows.WINAPI) HRESULT;

pub extern "fltlib" fn FilterAttachAtAltitude(
    lpFilterName: ?[*:0]const u16,
    lpVolumeName: ?[*:0]const u16,
    lpAltitude: ?[*:0]const u16,
    lpInstanceName: ?[*:0]const u16,
    dwCreatedInstanceNameLength: u32,
    // TODO: what to do with BytesParamIndex 4?
    lpCreatedInstanceName: ?PWSTR,
) callconv(@import("std").os.windows.WINAPI) HRESULT;

pub extern "fltlib" fn FilterDetach(
    lpFilterName: ?[*:0]const u16,
    lpVolumeName: ?[*:0]const u16,
    lpInstanceName: ?[*:0]const u16,
) callconv(@import("std").os.windows.WINAPI) HRESULT;

pub extern "fltlib" fn FilterFindFirst(
    dwInformationClass: FILTER_INFORMATION_CLASS,
    // TODO: what to do with BytesParamIndex 2?
    lpBuffer: ?*anyopaque,
    dwBufferSize: u32,
    lpBytesReturned: ?*u32,
    lpFilterFind: ?*FilterFindHandle,
) callconv(@import("std").os.windows.WINAPI) HRESULT;

pub extern "fltlib" fn FilterFindNext(
    hFilterFind: ?HANDLE,
    dwInformationClass: FILTER_INFORMATION_CLASS,
    // TODO: what to do with BytesParamIndex 3?
    lpBuffer: ?*anyopaque,
    dwBufferSize: u32,
    lpBytesReturned: ?*u32,
) callconv(@import("std").os.windows.WINAPI) HRESULT;

pub extern "fltlib" fn FilterFindClose(
    hFilterFind: ?HANDLE,
) callconv(@import("std").os.windows.WINAPI) HRESULT;

pub extern "fltlib" fn FilterVolumeFindFirst(
    dwInformationClass: FILTER_VOLUME_INFORMATION_CLASS,
    // TODO: what to do with BytesParamIndex 2?
    lpBuffer: ?*anyopaque,
    dwBufferSize: u32,
    lpBytesReturned: ?*u32,
    lpVolumeFind: ?*FilterVolumeFindHandle,
) callconv(@import("std").os.windows.WINAPI) HRESULT;

pub extern "fltlib" fn FilterVolumeFindNext(
    hVolumeFind: ?HANDLE,
    dwInformationClass: FILTER_VOLUME_INFORMATION_CLASS,
    // TODO: what to do with BytesParamIndex 3?
    lpBuffer: ?*anyopaque,
    dwBufferSize: u32,
    lpBytesReturned: ?*u32,
) callconv(@import("std").os.windows.WINAPI) HRESULT;

pub extern "fltlib" fn FilterVolumeFindClose(
    hVolumeFind: ?HANDLE,
) callconv(@import("std").os.windows.WINAPI) HRESULT;

pub extern "fltlib" fn FilterInstanceFindFirst(
    lpFilterName: ?[*:0]const u16,
    dwInformationClass: INSTANCE_INFORMATION_CLASS,
    // TODO: what to do with BytesParamIndex 3?
    lpBuffer: ?*anyopaque,
    dwBufferSize: u32,
    lpBytesReturned: ?*u32,
    lpFilterInstanceFind: ?*FilterInstanceFindHandle,
) callconv(@import("std").os.windows.WINAPI) HRESULT;

pub extern "fltlib" fn FilterInstanceFindNext(
    hFilterInstanceFind: ?HANDLE,
    dwInformationClass: INSTANCE_INFORMATION_CLASS,
    // TODO: what to do with BytesParamIndex 3?
    lpBuffer: ?*anyopaque,
    dwBufferSize: u32,
    lpBytesReturned: ?*u32,
) callconv(@import("std").os.windows.WINAPI) HRESULT;

pub extern "fltlib" fn FilterInstanceFindClose(
    hFilterInstanceFind: ?HANDLE,
) callconv(@import("std").os.windows.WINAPI) HRESULT;

pub extern "fltlib" fn FilterVolumeInstanceFindFirst(
    lpVolumeName: ?[*:0]const u16,
    dwInformationClass: INSTANCE_INFORMATION_CLASS,
    // TODO: what to do with BytesParamIndex 3?
    lpBuffer: ?*anyopaque,
    dwBufferSize: u32,
    lpBytesReturned: ?*u32,
    lpVolumeInstanceFind: ?*FilterVolumeInstanceFindHandle,
) callconv(@import("std").os.windows.WINAPI) HRESULT;

pub extern "fltlib" fn FilterVolumeInstanceFindNext(
    hVolumeInstanceFind: ?HANDLE,
    dwInformationClass: INSTANCE_INFORMATION_CLASS,
    // TODO: what to do with BytesParamIndex 3?
    lpBuffer: ?*anyopaque,
    dwBufferSize: u32,
    lpBytesReturned: ?*u32,
) callconv(@import("std").os.windows.WINAPI) HRESULT;

pub extern "fltlib" fn FilterVolumeInstanceFindClose(
    hVolumeInstanceFind: ?HANDLE,
) callconv(@import("std").os.windows.WINAPI) HRESULT;

pub extern "fltlib" fn FilterGetInformation(
    hFilter: ?HFILTER,
    dwInformationClass: FILTER_INFORMATION_CLASS,
    // TODO: what to do with BytesParamIndex 3?
    lpBuffer: ?*anyopaque,
    dwBufferSize: u32,
    lpBytesReturned: ?*u32,
) callconv(@import("std").os.windows.WINAPI) HRESULT;

pub extern "fltlib" fn FilterInstanceGetInformation(
    hInstance: HFILTER_INSTANCE,
    dwInformationClass: INSTANCE_INFORMATION_CLASS,
    // TODO: what to do with BytesParamIndex 3?
    lpBuffer: ?*anyopaque,
    dwBufferSize: u32,
    lpBytesReturned: ?*u32,
) callconv(@import("std").os.windows.WINAPI) HRESULT;

pub extern "fltlib" fn FilterConnectCommunicationPort(
    lpPortName: ?[*:0]const u16,
    dwOptions: u32,
    // TODO: what to do with BytesParamIndex 3?
    lpContext: ?*const anyopaque,
    wSizeOfContext: u16,
    lpSecurityAttributes: ?*SECURITY_ATTRIBUTES,
    hPort: ?*?HANDLE,
) callconv(@import("std").os.windows.WINAPI) HRESULT;

pub extern "fltlib" fn FilterSendMessage(
    hPort: ?HANDLE,
    // TODO: what to do with BytesParamIndex 2?
    lpInBuffer: ?*anyopaque,
    dwInBufferSize: u32,
    // TODO: what to do with BytesParamIndex 4?
    lpOutBuffer: ?*anyopaque,
    dwOutBufferSize: u32,
    lpBytesReturned: ?*u32,
) callconv(@import("std").os.windows.WINAPI) HRESULT;

pub extern "fltlib" fn FilterGetMessage(
    hPort: ?HANDLE,
    // TODO: what to do with BytesParamIndex 2?
    lpMessageBuffer: ?*FILTER_MESSAGE_HEADER,
    dwMessageBufferSize: u32,
    lpOverlapped: ?*OVERLAPPED,
) callconv(@import("std").os.windows.WINAPI) HRESULT;

// TODO: this type is limited to platform 'windows5.0'
pub extern "fltlib" fn FilterReplyMessage(
    hPort: ?HANDLE,
    // TODO: what to do with BytesParamIndex 2?
    lpReplyBuffer: ?*FILTER_REPLY_HEADER,
    dwReplyBufferSize: u32,
) callconv(@import("std").os.windows.WINAPI) HRESULT;

pub extern "fltlib" fn FilterGetDosName(
    lpVolumeName: ?[*:0]const u16,
    lpDosName: [*:0]u16,
    dwDosNameBufferSize: u32,
) callconv(@import("std").os.windows.WINAPI) HRESULT;


//--------------------------------------------------------------------------------
// Section: Unicode Aliases (0)
//--------------------------------------------------------------------------------
const thismodule = @This();
pub usingnamespace switch (@import("../zig.zig").unicode_mode) {
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
const HANDLE = @import("../foundation.zig").HANDLE;
const HRESULT = @import("../foundation.zig").HRESULT;
const NTSTATUS = @import("../foundation.zig").NTSTATUS;
const OVERLAPPED = @import("../system/io.zig").OVERLAPPED;
const PWSTR = @import("../foundation.zig").PWSTR;
const SECURITY_ATTRIBUTES = @import("../security.zig").SECURITY_ATTRIBUTES;

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
