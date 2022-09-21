//! NOTE: this file is autogenerated, DO NOT MODIFY
//--------------------------------------------------------------------------------
// Section: Constants (92)
//--------------------------------------------------------------------------------
pub const ASN_UNIVERSAL = @as(u32, 0);
pub const ASN_APPLICATION = @as(u32, 64);
pub const ASN_CONTEXT = @as(u32, 128);
pub const ASN_PRIVATE = @as(u32, 192);
pub const ASN_PRIMITIVE = @as(u32, 0);
pub const ASN_CONSTRUCTOR = @as(u32, 32);
pub const SNMP_ACCESS_NONE = @as(u32, 0);
pub const SNMP_ACCESS_NOTIFY = @as(u32, 1);
pub const SNMP_ACCESS_READ_ONLY = @as(u32, 2);
pub const SNMP_ACCESS_READ_WRITE = @as(u32, 3);
pub const SNMP_ACCESS_READ_CREATE = @as(u32, 4);
pub const SNMPAPI_NOERROR = @as(u32, 1);
pub const SNMPAPI_ERROR = @as(u32, 0);
pub const SNMP_OUTPUT_TO_EVENTLOG = @as(u32, 4);
pub const DEFAULT_SNMP_PORT_UDP = @as(u32, 161);
pub const DEFAULT_SNMP_PORT_IPX = @as(u32, 36879);
pub const DEFAULT_SNMPTRAP_PORT_UDP = @as(u32, 162);
pub const DEFAULT_SNMPTRAP_PORT_IPX = @as(u32, 36880);
pub const SNMP_MAX_OID_LEN = @as(u32, 128);
pub const SNMP_MEM_ALLOC_ERROR = @as(u32, 1);
pub const SNMP_BERAPI_INVALID_LENGTH = @as(u32, 10);
pub const SNMP_BERAPI_INVALID_TAG = @as(u32, 11);
pub const SNMP_BERAPI_OVERFLOW = @as(u32, 12);
pub const SNMP_BERAPI_SHORT_BUFFER = @as(u32, 13);
pub const SNMP_BERAPI_INVALID_OBJELEM = @as(u32, 14);
pub const SNMP_PDUAPI_UNRECOGNIZED_PDU = @as(u32, 20);
pub const SNMP_PDUAPI_INVALID_ES = @as(u32, 21);
pub const SNMP_PDUAPI_INVALID_GT = @as(u32, 22);
pub const SNMP_AUTHAPI_INVALID_VERSION = @as(u32, 30);
pub const SNMP_AUTHAPI_INVALID_MSG_TYPE = @as(u32, 31);
pub const SNMP_AUTHAPI_TRIV_AUTH_FAILED = @as(u32, 32);
pub const ASN_CONTEXTSPECIFIC = @as(u32, 128);
pub const ASN_PRIMATIVE = @as(u32, 0);
pub const SNMP_MGMTAPI_TIMEOUT = @as(u32, 40);
pub const SNMP_MGMTAPI_SELECT_FDERRORS = @as(u32, 41);
pub const SNMP_MGMTAPI_TRAP_ERRORS = @as(u32, 42);
pub const SNMP_MGMTAPI_TRAP_DUPINIT = @as(u32, 43);
pub const SNMP_MGMTAPI_NOTRAPS = @as(u32, 44);
pub const SNMP_MGMTAPI_AGAIN = @as(u32, 45);
pub const SNMP_MGMTAPI_INVALID_CTL = @as(u32, 46);
pub const SNMP_MGMTAPI_INVALID_SESSION = @as(u32, 47);
pub const SNMP_MGMTAPI_INVALID_BUFFER = @as(u32, 48);
pub const MGMCTL_SETAGENTPORT = @as(u32, 1);
pub const MAXOBJIDSIZE = @as(u32, 128);
pub const MAXOBJIDSTRSIZE = @as(u32, 1408);
pub const SNMPLISTEN_USEENTITY_ADDR = @as(u32, 0);
pub const SNMPLISTEN_ALL_ADDR = @as(u32, 1);
pub const SNMP_TRAP_COLDSTART = @as(u32, 0);
pub const SNMP_TRAP_WARMSTART = @as(u32, 1);
pub const SNMP_TRAP_LINKDOWN = @as(u32, 2);
pub const SNMP_TRAP_LINKUP = @as(u32, 3);
pub const SNMP_TRAP_AUTHFAIL = @as(u32, 4);
pub const SNMP_TRAP_EGPNEIGHBORLOSS = @as(u32, 5);
pub const SNMP_TRAP_ENTERPRISESPECIFIC = @as(u32, 6);
pub const SNMPAPI_NO_SUPPORT = @as(u32, 0);
pub const SNMPAPI_V1_SUPPORT = @as(u32, 1);
pub const SNMPAPI_V2_SUPPORT = @as(u32, 2);
pub const SNMPAPI_M2M_SUPPORT = @as(u32, 3);
pub const SNMPAPI_FAILURE = @as(u32, 0);
pub const SNMPAPI_SUCCESS = @as(u32, 1);
pub const SNMPAPI_ALLOC_ERROR = @as(u32, 2);
pub const SNMPAPI_CONTEXT_INVALID = @as(u32, 3);
pub const SNMPAPI_CONTEXT_UNKNOWN = @as(u32, 4);
pub const SNMPAPI_ENTITY_INVALID = @as(u32, 5);
pub const SNMPAPI_ENTITY_UNKNOWN = @as(u32, 6);
pub const SNMPAPI_INDEX_INVALID = @as(u32, 7);
pub const SNMPAPI_NOOP = @as(u32, 8);
pub const SNMPAPI_OID_INVALID = @as(u32, 9);
pub const SNMPAPI_OPERATION_INVALID = @as(u32, 10);
pub const SNMPAPI_OUTPUT_TRUNCATED = @as(u32, 11);
pub const SNMPAPI_PDU_INVALID = @as(u32, 12);
pub const SNMPAPI_SESSION_INVALID = @as(u32, 13);
pub const SNMPAPI_SYNTAX_INVALID = @as(u32, 14);
pub const SNMPAPI_VBL_INVALID = @as(u32, 15);
pub const SNMPAPI_MODE_INVALID = @as(u32, 16);
pub const SNMPAPI_SIZE_INVALID = @as(u32, 17);
pub const SNMPAPI_NOT_INITIALIZED = @as(u32, 18);
pub const SNMPAPI_MESSAGE_INVALID = @as(u32, 19);
pub const SNMPAPI_HWND_INVALID = @as(u32, 20);
pub const SNMPAPI_OTHER_ERROR = @as(u32, 99);
pub const SNMPAPI_TL_NOT_INITIALIZED = @as(u32, 100);
pub const SNMPAPI_TL_NOT_SUPPORTED = @as(u32, 101);
pub const SNMPAPI_TL_NOT_AVAILABLE = @as(u32, 102);
pub const SNMPAPI_TL_RESOURCE_ERROR = @as(u32, 103);
pub const SNMPAPI_TL_UNDELIVERABLE = @as(u32, 104);
pub const SNMPAPI_TL_SRC_INVALID = @as(u32, 105);
pub const SNMPAPI_TL_INVALID_PARAM = @as(u32, 106);
pub const SNMPAPI_TL_IN_USE = @as(u32, 107);
pub const SNMPAPI_TL_TIMEOUT = @as(u32, 108);
pub const SNMPAPI_TL_PDU_TOO_BIG = @as(u32, 109);
pub const SNMPAPI_TL_OTHER = @as(u32, 199);
pub const MAXVENDORINFO = @as(u32, 32);

//--------------------------------------------------------------------------------
// Section: Types (29)
//--------------------------------------------------------------------------------
pub const SNMP_PDU_TYPE = enum(u32) {
    GET = 160,
    GETNEXT = 161,
    RESPONSE = 162,
    SET = 163,
    GETBULK = 165,
    TRAP = 167,
};
pub const SNMP_PDU_GET = SNMP_PDU_TYPE.GET;
pub const SNMP_PDU_GETNEXT = SNMP_PDU_TYPE.GETNEXT;
pub const SNMP_PDU_RESPONSE = SNMP_PDU_TYPE.RESPONSE;
pub const SNMP_PDU_SET = SNMP_PDU_TYPE.SET;
pub const SNMP_PDU_GETBULK = SNMP_PDU_TYPE.GETBULK;
pub const SNMP_PDU_TRAP = SNMP_PDU_TYPE.TRAP;

pub const SNMP_EXTENSION_REQUEST_TYPE = enum(u32) {
    GET = 160,
    GET_NEXT = 161,
    SET_TEST = 224,
    SET_COMMIT = 163,
    SET_UNDO = 225,
    SET_CLEANUP = 226,
};
pub const SNMP_EXTENSION_GET = SNMP_EXTENSION_REQUEST_TYPE.GET;
pub const SNMP_EXTENSION_GET_NEXT = SNMP_EXTENSION_REQUEST_TYPE.GET_NEXT;
pub const SNMP_EXTENSION_SET_TEST = SNMP_EXTENSION_REQUEST_TYPE.SET_TEST;
pub const SNMP_EXTENSION_SET_COMMIT = SNMP_EXTENSION_REQUEST_TYPE.SET_COMMIT;
pub const SNMP_EXTENSION_SET_UNDO = SNMP_EXTENSION_REQUEST_TYPE.SET_UNDO;
pub const SNMP_EXTENSION_SET_CLEANUP = SNMP_EXTENSION_REQUEST_TYPE.SET_CLEANUP;

pub const SNMP_API_TRANSLATE_MODE = enum(u32) {
    TRANSLATED = 0,
    UNTRANSLATED_V1 = 1,
    UNTRANSLATED_V2 = 2,
};
pub const SNMPAPI_TRANSLATED = SNMP_API_TRANSLATE_MODE.TRANSLATED;
pub const SNMPAPI_UNTRANSLATED_V1 = SNMP_API_TRANSLATE_MODE.UNTRANSLATED_V1;
pub const SNMPAPI_UNTRANSLATED_V2 = SNMP_API_TRANSLATE_MODE.UNTRANSLATED_V2;

pub const SNMP_GENERICTRAP = enum(u32) {
    COLDSTART = 0,
    WARMSTART = 1,
    LINKDOWN = 2,
    LINKUP = 3,
    AUTHFAILURE = 4,
    EGPNEIGHLOSS = 5,
    ENTERSPECIFIC = 6,
};
pub const SNMP_GENERICTRAP_COLDSTART = SNMP_GENERICTRAP.COLDSTART;
pub const SNMP_GENERICTRAP_WARMSTART = SNMP_GENERICTRAP.WARMSTART;
pub const SNMP_GENERICTRAP_LINKDOWN = SNMP_GENERICTRAP.LINKDOWN;
pub const SNMP_GENERICTRAP_LINKUP = SNMP_GENERICTRAP.LINKUP;
pub const SNMP_GENERICTRAP_AUTHFAILURE = SNMP_GENERICTRAP.AUTHFAILURE;
pub const SNMP_GENERICTRAP_EGPNEIGHLOSS = SNMP_GENERICTRAP.EGPNEIGHLOSS;
pub const SNMP_GENERICTRAP_ENTERSPECIFIC = SNMP_GENERICTRAP.ENTERSPECIFIC;

pub const SNMP_ERROR_STATUS = enum(u32) {
    NOERROR = 0,
    TOOBIG = 1,
    NOSUCHNAME = 2,
    BADVALUE = 3,
    READONLY = 4,
    GENERR = 5,
    NOACCESS = 6,
    WRONGTYPE = 7,
    WRONGLENGTH = 8,
    WRONGENCODING = 9,
    WRONGVALUE = 10,
    NOCREATION = 11,
    INCONSISTENTVALUE = 12,
    RESOURCEUNAVAILABLE = 13,
    COMMITFAILED = 14,
    UNDOFAILED = 15,
    AUTHORIZATIONERROR = 16,
    NOTWRITABLE = 17,
    INCONSISTENTNAME = 18,
};
pub const SNMP_ERRORSTATUS_NOERROR = SNMP_ERROR_STATUS.NOERROR;
pub const SNMP_ERRORSTATUS_TOOBIG = SNMP_ERROR_STATUS.TOOBIG;
pub const SNMP_ERRORSTATUS_NOSUCHNAME = SNMP_ERROR_STATUS.NOSUCHNAME;
pub const SNMP_ERRORSTATUS_BADVALUE = SNMP_ERROR_STATUS.BADVALUE;
pub const SNMP_ERRORSTATUS_READONLY = SNMP_ERROR_STATUS.READONLY;
pub const SNMP_ERRORSTATUS_GENERR = SNMP_ERROR_STATUS.GENERR;
pub const SNMP_ERRORSTATUS_NOACCESS = SNMP_ERROR_STATUS.NOACCESS;
pub const SNMP_ERRORSTATUS_WRONGTYPE = SNMP_ERROR_STATUS.WRONGTYPE;
pub const SNMP_ERRORSTATUS_WRONGLENGTH = SNMP_ERROR_STATUS.WRONGLENGTH;
pub const SNMP_ERRORSTATUS_WRONGENCODING = SNMP_ERROR_STATUS.WRONGENCODING;
pub const SNMP_ERRORSTATUS_WRONGVALUE = SNMP_ERROR_STATUS.WRONGVALUE;
pub const SNMP_ERRORSTATUS_NOCREATION = SNMP_ERROR_STATUS.NOCREATION;
pub const SNMP_ERRORSTATUS_INCONSISTENTVALUE = SNMP_ERROR_STATUS.INCONSISTENTVALUE;
pub const SNMP_ERRORSTATUS_RESOURCEUNAVAILABLE = SNMP_ERROR_STATUS.RESOURCEUNAVAILABLE;
pub const SNMP_ERRORSTATUS_COMMITFAILED = SNMP_ERROR_STATUS.COMMITFAILED;
pub const SNMP_ERRORSTATUS_UNDOFAILED = SNMP_ERROR_STATUS.UNDOFAILED;
pub const SNMP_ERRORSTATUS_AUTHORIZATIONERROR = SNMP_ERROR_STATUS.AUTHORIZATIONERROR;
pub const SNMP_ERRORSTATUS_NOTWRITABLE = SNMP_ERROR_STATUS.NOTWRITABLE;
pub const SNMP_ERRORSTATUS_INCONSISTENTNAME = SNMP_ERROR_STATUS.INCONSISTENTNAME;

pub const SNMP_STATUS = enum(u32) {
    N = 1,
    FF = 0,
};
pub const SNMPAPI_ON = SNMP_STATUS.N;
pub const SNMPAPI_OFF = SNMP_STATUS.FF;

pub const SNMP_OUTPUT_LOG_TYPE = enum(u32) {
    CONSOLE = 1,
    LOGFILE = 2,
    DEBUGGER = 8,
};
pub const SNMP_OUTPUT_TO_CONSOLE = SNMP_OUTPUT_LOG_TYPE.CONSOLE;
pub const SNMP_OUTPUT_TO_LOGFILE = SNMP_OUTPUT_LOG_TYPE.LOGFILE;
pub const SNMP_OUTPUT_TO_DEBUGGER = SNMP_OUTPUT_LOG_TYPE.DEBUGGER;

pub const SNMP_LOG = enum(u32) {
    SILENT = 0,
    FATAL = 1,
    ERROR = 2,
    WARNING = 3,
    TRACE = 4,
    VERBOSE = 5,
};
pub const SNMP_LOG_SILENT = SNMP_LOG.SILENT;
pub const SNMP_LOG_FATAL = SNMP_LOG.FATAL;
pub const SNMP_LOG_ERROR = SNMP_LOG.ERROR;
pub const SNMP_LOG_WARNING = SNMP_LOG.WARNING;
pub const SNMP_LOG_TRACE = SNMP_LOG.TRACE;
pub const SNMP_LOG_VERBOSE = SNMP_LOG.VERBOSE;

pub const SNMP_ERROR = enum(u32) {
    NOERROR = 0,
    TOOBIG = 1,
    NOSUCHNAME = 2,
    BADVALUE = 3,
    READONLY = 4,
    GENERR = 5,
    NOACCESS = 6,
    WRONGTYPE = 7,
    WRONGLENGTH = 8,
    WRONGENCODING = 9,
    WRONGVALUE = 10,
    NOCREATION = 11,
    INCONSISTENTVALUE = 12,
    RESOURCEUNAVAILABLE = 13,
    COMMITFAILED = 14,
    UNDOFAILED = 15,
    AUTHORIZATIONERROR = 16,
    NOTWRITABLE = 17,
    INCONSISTENTNAME = 18,
};
pub const SNMP_ERROR_NOERROR = SNMP_ERROR.NOERROR;
pub const SNMP_ERROR_TOOBIG = SNMP_ERROR.TOOBIG;
pub const SNMP_ERROR_NOSUCHNAME = SNMP_ERROR.NOSUCHNAME;
pub const SNMP_ERROR_BADVALUE = SNMP_ERROR.BADVALUE;
pub const SNMP_ERROR_READONLY = SNMP_ERROR.READONLY;
pub const SNMP_ERROR_GENERR = SNMP_ERROR.GENERR;
pub const SNMP_ERROR_NOACCESS = SNMP_ERROR.NOACCESS;
pub const SNMP_ERROR_WRONGTYPE = SNMP_ERROR.WRONGTYPE;
pub const SNMP_ERROR_WRONGLENGTH = SNMP_ERROR.WRONGLENGTH;
pub const SNMP_ERROR_WRONGENCODING = SNMP_ERROR.WRONGENCODING;
pub const SNMP_ERROR_WRONGVALUE = SNMP_ERROR.WRONGVALUE;
pub const SNMP_ERROR_NOCREATION = SNMP_ERROR.NOCREATION;
pub const SNMP_ERROR_INCONSISTENTVALUE = SNMP_ERROR.INCONSISTENTVALUE;
pub const SNMP_ERROR_RESOURCEUNAVAILABLE = SNMP_ERROR.RESOURCEUNAVAILABLE;
pub const SNMP_ERROR_COMMITFAILED = SNMP_ERROR.COMMITFAILED;
pub const SNMP_ERROR_UNDOFAILED = SNMP_ERROR.UNDOFAILED;
pub const SNMP_ERROR_AUTHORIZATIONERROR = SNMP_ERROR.AUTHORIZATIONERROR;
pub const SNMP_ERROR_NOTWRITABLE = SNMP_ERROR.NOTWRITABLE;
pub const SNMP_ERROR_INCONSISTENTNAME = SNMP_ERROR.INCONSISTENTNAME;

pub const AsnOctetString = extern struct {
    // WARNING: unable to add field alignment because it's causing a compiler bug
    stream: ?*u8,
    length: u32,
    dynamic: BOOL,
};

pub const AsnObjectIdentifier = extern struct {
    // WARNING: unable to add field alignment because it's causing a compiler bug
    idLength: u32,
    ids: ?*u32,
};

pub const AsnAny = extern struct {
    asnType: u8,
    asnValue: extern union {
        // WARNING: unable to add field alignment because it's not implemented for unions
        number: i32,
        unsigned32: u32,
        counter64: ULARGE_INTEGER,
        string: AsnOctetString,
        bits: AsnOctetString,
        object: AsnObjectIdentifier,
        sequence: AsnOctetString,
        address: AsnOctetString,
        counter: u32,
        gauge: u32,
        ticks: u32,
        arbitrary: AsnOctetString,
    },
};

pub const SnmpVarBind = extern struct {
    name: AsnObjectIdentifier,
    value: AsnAny,
};

pub const SnmpVarBindList = extern struct {
    // WARNING: unable to add field alignment because it's causing a compiler bug
    list: ?*SnmpVarBind,
    len: u32,
};

pub const PFNSNMPEXTENSIONINIT = fn (
    dwUpTimeReference: u32,
    phSubagentTrapEvent: ?*?HANDLE,
    pFirstSupportedRegion: ?*AsnObjectIdentifier,
) callconv(@import("std").os.windows.WINAPI) BOOL;

pub const PFNSNMPEXTENSIONINITEX = fn (
    pNextSupportedRegion: ?*AsnObjectIdentifier,
) callconv(@import("std").os.windows.WINAPI) BOOL;

pub const PFNSNMPEXTENSIONMONITOR = fn (
    pAgentMgmtData: ?*anyopaque,
) callconv(@import("std").os.windows.WINAPI) BOOL;

pub const PFNSNMPEXTENSIONQUERY = fn (
    bPduType: u8,
    pVarBindList: ?*SnmpVarBindList,
    pErrorStatus: ?*i32,
    pErrorIndex: ?*i32,
) callconv(@import("std").os.windows.WINAPI) BOOL;

pub const PFNSNMPEXTENSIONQUERYEX = fn (
    nRequestType: u32,
    nTransactionId: u32,
    pVarBindList: ?*SnmpVarBindList,
    pContextInfo: ?*AsnOctetString,
    pErrorStatus: ?*i32,
    pErrorIndex: ?*i32,
) callconv(@import("std").os.windows.WINAPI) BOOL;

pub const PFNSNMPEXTENSIONTRAP = fn (
    pEnterpriseOid: ?*AsnObjectIdentifier,
    pGenericTrapId: ?*i32,
    pSpecificTrapId: ?*i32,
    pTimeStamp: ?*u32,
    pVarBindList: ?*SnmpVarBindList,
) callconv(@import("std").os.windows.WINAPI) BOOL;

pub const PFNSNMPEXTENSIONCLOSE = fn () callconv(@import("std").os.windows.WINAPI) void;

pub const smiOCTETS = extern struct {
    len: u32,
    ptr: ?*u8,
};

pub const smiOID = extern struct {
    len: u32,
    ptr: ?*u32,
};

pub const smiCNTR64 = extern struct {
    hipart: u32,
    lopart: u32,
};

pub const smiVALUE = extern struct {
    syntax: u32,
    value: extern union {
        sNumber: i32,
        uNumber: u32,
        hNumber: smiCNTR64,
        string: smiOCTETS,
        oid: smiOID,
        empty: u8,
    },
};

pub const smiVENDORINFO = extern struct {
    vendorName: [64]CHAR,
    vendorContact: [64]CHAR,
    vendorVersionId: [32]CHAR,
    vendorVersionDate: [32]CHAR,
    vendorEnterprise: u32,
};

pub const SNMPAPI_CALLBACK = fn (
    hSession: isize,
    hWnd: ?HWND,
    wMsg: u32,
    wParam: WPARAM,
    lParam: LPARAM,
    lpClientData: ?*anyopaque,
) callconv(@import("std").os.windows.WINAPI) u32;

pub const PFNSNMPSTARTUPEX = fn (
    param0: ?*u32,
    param1: ?*u32,
    param2: ?*u32,
    param3: ?*u32,
    param4: ?*u32,
) callconv(@import("std").os.windows.WINAPI) u32;

pub const PFNSNMPCLEANUPEX = fn () callconv(@import("std").os.windows.WINAPI) u32;

//--------------------------------------------------------------------------------
// Section: Functions (84)
//--------------------------------------------------------------------------------
// TODO: this type is limited to platform 'windows5.0'
pub extern "snmpapi" fn SnmpUtilOidCpy(
    pOidDst: ?*AsnObjectIdentifier,
    pOidSrc: ?*AsnObjectIdentifier,
) callconv(@import("std").os.windows.WINAPI) i32;

// TODO: this type is limited to platform 'windows5.0'
pub extern "snmpapi" fn SnmpUtilOidAppend(
    pOidDst: ?*AsnObjectIdentifier,
    pOidSrc: ?*AsnObjectIdentifier,
) callconv(@import("std").os.windows.WINAPI) i32;

// TODO: this type is limited to platform 'windows5.0'
pub extern "snmpapi" fn SnmpUtilOidNCmp(
    pOid1: ?*AsnObjectIdentifier,
    pOid2: ?*AsnObjectIdentifier,
    nSubIds: u32,
) callconv(@import("std").os.windows.WINAPI) i32;

// TODO: this type is limited to platform 'windows5.0'
pub extern "snmpapi" fn SnmpUtilOidCmp(
    pOid1: ?*AsnObjectIdentifier,
    pOid2: ?*AsnObjectIdentifier,
) callconv(@import("std").os.windows.WINAPI) i32;

// TODO: this type is limited to platform 'windows5.0'
pub extern "snmpapi" fn SnmpUtilOidFree(
    pOid: ?*AsnObjectIdentifier,
) callconv(@import("std").os.windows.WINAPI) void;

// TODO: this type is limited to platform 'windows5.0'
pub extern "snmpapi" fn SnmpUtilOctetsCmp(
    pOctets1: ?*AsnOctetString,
    pOctets2: ?*AsnOctetString,
) callconv(@import("std").os.windows.WINAPI) i32;

// TODO: this type is limited to platform 'windows5.0'
pub extern "snmpapi" fn SnmpUtilOctetsNCmp(
    pOctets1: ?*AsnOctetString,
    pOctets2: ?*AsnOctetString,
    nChars: u32,
) callconv(@import("std").os.windows.WINAPI) i32;

// TODO: this type is limited to platform 'windows5.0'
pub extern "snmpapi" fn SnmpUtilOctetsCpy(
    pOctetsDst: ?*AsnOctetString,
    pOctetsSrc: ?*AsnOctetString,
) callconv(@import("std").os.windows.WINAPI) i32;

// TODO: this type is limited to platform 'windows5.0'
pub extern "snmpapi" fn SnmpUtilOctetsFree(
    pOctets: ?*AsnOctetString,
) callconv(@import("std").os.windows.WINAPI) void;

// TODO: this type is limited to platform 'windows5.0'
pub extern "snmpapi" fn SnmpUtilAsnAnyCpy(
    pAnyDst: ?*AsnAny,
    pAnySrc: ?*AsnAny,
) callconv(@import("std").os.windows.WINAPI) i32;

// TODO: this type is limited to platform 'windows5.0'
pub extern "snmpapi" fn SnmpUtilAsnAnyFree(
    pAny: ?*AsnAny,
) callconv(@import("std").os.windows.WINAPI) void;

// TODO: this type is limited to platform 'windows5.0'
pub extern "snmpapi" fn SnmpUtilVarBindCpy(
    pVbDst: ?*SnmpVarBind,
    pVbSrc: ?*SnmpVarBind,
) callconv(@import("std").os.windows.WINAPI) i32;

// TODO: this type is limited to platform 'windows5.0'
pub extern "snmpapi" fn SnmpUtilVarBindFree(
    pVb: ?*SnmpVarBind,
) callconv(@import("std").os.windows.WINAPI) void;

// TODO: this type is limited to platform 'windows5.0'
pub extern "snmpapi" fn SnmpUtilVarBindListCpy(
    pVblDst: ?*SnmpVarBindList,
    pVblSrc: ?*SnmpVarBindList,
) callconv(@import("std").os.windows.WINAPI) i32;

// TODO: this type is limited to platform 'windows5.0'
pub extern "snmpapi" fn SnmpUtilVarBindListFree(
    pVbl: ?*SnmpVarBindList,
) callconv(@import("std").os.windows.WINAPI) void;

// TODO: this type is limited to platform 'windows5.0'
pub extern "snmpapi" fn SnmpUtilMemFree(
    pMem: ?*anyopaque,
) callconv(@import("std").os.windows.WINAPI) void;

// TODO: this type is limited to platform 'windows5.0'
pub extern "snmpapi" fn SnmpUtilMemAlloc(
    nBytes: u32,
) callconv(@import("std").os.windows.WINAPI) ?*anyopaque;

// TODO: this type is limited to platform 'windows5.0'
pub extern "snmpapi" fn SnmpUtilMemReAlloc(
    pMem: ?*anyopaque,
    nBytes: u32,
) callconv(@import("std").os.windows.WINAPI) ?*anyopaque;

// TODO: this type is limited to platform 'windows5.0'
pub extern "snmpapi" fn SnmpUtilOidToA(
    Oid: ?*AsnObjectIdentifier,
) callconv(@import("std").os.windows.WINAPI) ?PSTR;

// TODO: this type is limited to platform 'windows5.0'
pub extern "snmpapi" fn SnmpUtilIdsToA(
    Ids: ?*u32,
    IdLength: u32,
) callconv(@import("std").os.windows.WINAPI) ?PSTR;

// TODO: this type is limited to platform 'windows5.0'
pub extern "snmpapi" fn SnmpUtilPrintOid(
    Oid: ?*AsnObjectIdentifier,
) callconv(@import("std").os.windows.WINAPI) void;

// TODO: this type is limited to platform 'windows5.0'
pub extern "snmpapi" fn SnmpUtilPrintAsnAny(
    pAny: ?*AsnAny,
) callconv(@import("std").os.windows.WINAPI) void;

// TODO: this type is limited to platform 'windows5.0'
pub extern "snmpapi" fn SnmpSvcGetUptime() callconv(@import("std").os.windows.WINAPI) u32;

// TODO: this type is limited to platform 'windows5.0'
pub extern "snmpapi" fn SnmpSvcSetLogLevel(
    nLogLevel: SNMP_LOG,
) callconv(@import("std").os.windows.WINAPI) void;

// TODO: this type is limited to platform 'windows5.0'
pub extern "snmpapi" fn SnmpSvcSetLogType(
    nLogType: SNMP_OUTPUT_LOG_TYPE,
) callconv(@import("std").os.windows.WINAPI) void;

// TODO: this type is limited to platform 'windows5.0'
pub extern "snmpapi" fn SnmpUtilDbgPrint(
    nLogLevel: SNMP_LOG,
    szFormat: ?PSTR,
) callconv(@import("std").os.windows.WINAPI) void;

// TODO: this type is limited to platform 'windows5.0'
pub extern "mgmtapi" fn SnmpMgrOpen(
    lpAgentAddress: ?PSTR,
    lpAgentCommunity: ?PSTR,
    nTimeOut: i32,
    nRetries: i32,
) callconv(@import("std").os.windows.WINAPI) ?*anyopaque;

// TODO: this type is limited to platform 'windows5.0'
pub extern "mgmtapi" fn SnmpMgrCtl(
    session: ?*anyopaque,
    dwCtlCode: u32,
    lpvInBuffer: ?*anyopaque,
    cbInBuffer: u32,
    lpvOUTBuffer: ?*anyopaque,
    cbOUTBuffer: u32,
    lpcbBytesReturned: ?*u32,
) callconv(@import("std").os.windows.WINAPI) BOOL;

// TODO: this type is limited to platform 'windows5.0'
pub extern "mgmtapi" fn SnmpMgrClose(
    session: ?*anyopaque,
) callconv(@import("std").os.windows.WINAPI) BOOL;

// TODO: this type is limited to platform 'windows5.0'
pub extern "mgmtapi" fn SnmpMgrRequest(
    session: ?*anyopaque,
    requestType: u8,
    variableBindings: ?*SnmpVarBindList,
    errorStatus: ?*SNMP_ERROR_STATUS,
    errorIndex: ?*i32,
) callconv(@import("std").os.windows.WINAPI) i32;

// TODO: this type is limited to platform 'windows5.0'
pub extern "mgmtapi" fn SnmpMgrStrToOid(
    string: ?PSTR,
    oid: ?*AsnObjectIdentifier,
) callconv(@import("std").os.windows.WINAPI) BOOL;

// TODO: this type is limited to platform 'windows5.0'
pub extern "mgmtapi" fn SnmpMgrOidToStr(
    oid: ?*AsnObjectIdentifier,
    string: ?*?PSTR,
) callconv(@import("std").os.windows.WINAPI) BOOL;

// TODO: this type is limited to platform 'windows5.0'
pub extern "mgmtapi" fn SnmpMgrTrapListen(
    phTrapAvailable: ?*?HANDLE,
) callconv(@import("std").os.windows.WINAPI) BOOL;

// TODO: this type is limited to platform 'windows5.0'
pub extern "mgmtapi" fn SnmpMgrGetTrap(
    enterprise: ?*AsnObjectIdentifier,
    IPAddress: ?*AsnOctetString,
    genericTrap: ?*SNMP_GENERICTRAP,
    specificTrap: ?*i32,
    timeStamp: ?*u32,
    variableBindings: ?*SnmpVarBindList,
) callconv(@import("std").os.windows.WINAPI) BOOL;

// TODO: this type is limited to platform 'windows5.0'
pub extern "mgmtapi" fn SnmpMgrGetTrapEx(
    enterprise: ?*AsnObjectIdentifier,
    agentAddress: ?*AsnOctetString,
    sourceAddress: ?*AsnOctetString,
    genericTrap: ?*SNMP_GENERICTRAP,
    specificTrap: ?*i32,
    community: ?*AsnOctetString,
    timeStamp: ?*u32,
    variableBindings: ?*SnmpVarBindList,
) callconv(@import("std").os.windows.WINAPI) BOOL;

// TODO: this type is limited to platform 'windows5.0'
pub extern "wsnmp32" fn SnmpGetTranslateMode(
    nTranslateMode: ?*SNMP_API_TRANSLATE_MODE,
) callconv(@import("std").os.windows.WINAPI) u32;

// TODO: this type is limited to platform 'windows5.0'
pub extern "wsnmp32" fn SnmpSetTranslateMode(
    nTranslateMode: SNMP_API_TRANSLATE_MODE,
) callconv(@import("std").os.windows.WINAPI) u32;

// TODO: this type is limited to platform 'windows5.0'
pub extern "wsnmp32" fn SnmpGetRetransmitMode(
    nRetransmitMode: ?*SNMP_STATUS,
) callconv(@import("std").os.windows.WINAPI) u32;

// TODO: this type is limited to platform 'windows5.0'
pub extern "wsnmp32" fn SnmpSetRetransmitMode(
    nRetransmitMode: SNMP_STATUS,
) callconv(@import("std").os.windows.WINAPI) u32;

// TODO: this type is limited to platform 'windows5.0'
pub extern "wsnmp32" fn SnmpGetTimeout(
    hEntity: isize,
    nPolicyTimeout: ?*u32,
    nActualTimeout: ?*u32,
) callconv(@import("std").os.windows.WINAPI) u32;

// TODO: this type is limited to platform 'windows5.0'
pub extern "wsnmp32" fn SnmpSetTimeout(
    hEntity: isize,
    nPolicyTimeout: u32,
) callconv(@import("std").os.windows.WINAPI) u32;

// TODO: this type is limited to platform 'windows5.0'
pub extern "wsnmp32" fn SnmpGetRetry(
    hEntity: isize,
    nPolicyRetry: ?*u32,
    nActualRetry: ?*u32,
) callconv(@import("std").os.windows.WINAPI) u32;

// TODO: this type is limited to platform 'windows5.0'
pub extern "wsnmp32" fn SnmpSetRetry(
    hEntity: isize,
    nPolicyRetry: u32,
) callconv(@import("std").os.windows.WINAPI) u32;

// TODO: this type is limited to platform 'windows5.0'
pub extern "wsnmp32" fn SnmpGetVendorInfo(
    vendorInfo: ?*smiVENDORINFO,
) callconv(@import("std").os.windows.WINAPI) u32;

// TODO: this type is limited to platform 'windows5.0'
pub extern "wsnmp32" fn SnmpStartup(
    nMajorVersion: ?*u32,
    nMinorVersion: ?*u32,
    nLevel: ?*u32,
    nTranslateMode: ?*SNMP_API_TRANSLATE_MODE,
    nRetransmitMode: ?*SNMP_STATUS,
) callconv(@import("std").os.windows.WINAPI) u32;

// TODO: this type is limited to platform 'windows5.0'
pub extern "wsnmp32" fn SnmpCleanup() callconv(@import("std").os.windows.WINAPI) u32;

// TODO: this type is limited to platform 'windows5.0'
pub extern "wsnmp32" fn SnmpOpen(
    hWnd: ?HWND,
    wMsg: u32,
) callconv(@import("std").os.windows.WINAPI) isize;

// TODO: this type is limited to platform 'windows5.0'
pub extern "wsnmp32" fn SnmpClose(
    session: isize,
) callconv(@import("std").os.windows.WINAPI) u32;

// TODO: this type is limited to platform 'windows5.0'
pub extern "wsnmp32" fn SnmpSendMsg(
    session: isize,
    srcEntity: isize,
    dstEntity: isize,
    context: isize,
    PDU: isize,
) callconv(@import("std").os.windows.WINAPI) u32;

// TODO: this type is limited to platform 'windows5.0'
pub extern "wsnmp32" fn SnmpRecvMsg(
    session: isize,
    srcEntity: ?*isize,
    dstEntity: ?*isize,
    context: ?*isize,
    PDU: ?*isize,
) callconv(@import("std").os.windows.WINAPI) u32;

// TODO: this type is limited to platform 'windows5.0'
pub extern "wsnmp32" fn SnmpRegister(
    session: isize,
    srcEntity: isize,
    dstEntity: isize,
    context: isize,
    notification: ?*smiOID,
    state: SNMP_STATUS,
) callconv(@import("std").os.windows.WINAPI) u32;

// TODO: this type is limited to platform 'windows5.0'
pub extern "wsnmp32" fn SnmpCreateSession(
    hWnd: ?HWND,
    wMsg: u32,
    fCallBack: ?SNMPAPI_CALLBACK,
    lpClientData: ?*anyopaque,
) callconv(@import("std").os.windows.WINAPI) isize;

// TODO: this type is limited to platform 'windows5.0'
pub extern "wsnmp32" fn SnmpListen(
    hEntity: isize,
    lStatus: SNMP_STATUS,
) callconv(@import("std").os.windows.WINAPI) u32;

pub extern "wsnmp32" fn SnmpListenEx(
    hEntity: isize,
    lStatus: u32,
    nUseEntityAddr: u32,
) callconv(@import("std").os.windows.WINAPI) u32;

// TODO: this type is limited to platform 'windows5.0'
pub extern "wsnmp32" fn SnmpCancelMsg(
    session: isize,
    reqId: i32,
) callconv(@import("std").os.windows.WINAPI) u32;

// TODO: this type is limited to platform 'windows5.0'
pub extern "wsnmp32" fn SnmpStartupEx(
    nMajorVersion: ?*u32,
    nMinorVersion: ?*u32,
    nLevel: ?*u32,
    nTranslateMode: ?*SNMP_API_TRANSLATE_MODE,
    nRetransmitMode: ?*SNMP_STATUS,
) callconv(@import("std").os.windows.WINAPI) u32;

// TODO: this type is limited to platform 'windows5.0'
pub extern "wsnmp32" fn SnmpCleanupEx() callconv(@import("std").os.windows.WINAPI) u32;

// TODO: this type is limited to platform 'windows5.0'
pub extern "wsnmp32" fn SnmpStrToEntity(
    session: isize,
    string: ?[*:0]const u8,
) callconv(@import("std").os.windows.WINAPI) isize;

// TODO: this type is limited to platform 'windows5.0'
pub extern "wsnmp32" fn SnmpEntityToStr(
    entity: isize,
    size: u32,
    string: [*:0]u8,
) callconv(@import("std").os.windows.WINAPI) u32;

// TODO: this type is limited to platform 'windows5.0'
pub extern "wsnmp32" fn SnmpFreeEntity(
    entity: isize,
) callconv(@import("std").os.windows.WINAPI) u32;

// TODO: this type is limited to platform 'windows5.0'
pub extern "wsnmp32" fn SnmpStrToContext(
    session: isize,
    string: ?*smiOCTETS,
) callconv(@import("std").os.windows.WINAPI) isize;

// TODO: this type is limited to platform 'windows5.0'
pub extern "wsnmp32" fn SnmpContextToStr(
    context: isize,
    string: ?*smiOCTETS,
) callconv(@import("std").os.windows.WINAPI) u32;

// TODO: this type is limited to platform 'windows5.0'
pub extern "wsnmp32" fn SnmpFreeContext(
    context: isize,
) callconv(@import("std").os.windows.WINAPI) u32;

// TODO: this type is limited to platform 'windows5.0'
pub extern "wsnmp32" fn SnmpSetPort(
    hEntity: isize,
    nPort: u32,
) callconv(@import("std").os.windows.WINAPI) u32;

// TODO: this type is limited to platform 'windows5.0'
pub extern "wsnmp32" fn SnmpCreatePdu(
    session: isize,
    PDU_type: SNMP_PDU_TYPE,
    request_id: i32,
    error_status: i32,
    error_index: i32,
    varbindlist: isize,
) callconv(@import("std").os.windows.WINAPI) isize;

// TODO: this type is limited to platform 'windows5.0'
pub extern "wsnmp32" fn SnmpGetPduData(
    PDU: isize,
    PDU_type: ?*SNMP_PDU_TYPE,
    request_id: ?*i32,
    error_status: ?*SNMP_ERROR,
    error_index: ?*i32,
    varbindlist: ?*isize,
) callconv(@import("std").os.windows.WINAPI) u32;

// TODO: this type is limited to platform 'windows5.0'
pub extern "wsnmp32" fn SnmpSetPduData(
    PDU: isize,
    PDU_type: ?*const i32,
    request_id: ?*const i32,
    non_repeaters: ?*const i32,
    max_repetitions: ?*const i32,
    varbindlist: ?*const isize,
) callconv(@import("std").os.windows.WINAPI) u32;

// TODO: this type is limited to platform 'windows5.0'
pub extern "wsnmp32" fn SnmpDuplicatePdu(
    session: isize,
    PDU: isize,
) callconv(@import("std").os.windows.WINAPI) isize;

// TODO: this type is limited to platform 'windows5.0'
pub extern "wsnmp32" fn SnmpFreePdu(
    PDU: isize,
) callconv(@import("std").os.windows.WINAPI) u32;

// TODO: this type is limited to platform 'windows5.0'
pub extern "wsnmp32" fn SnmpCreateVbl(
    session: isize,
    name: ?*smiOID,
    value: ?*smiVALUE,
) callconv(@import("std").os.windows.WINAPI) isize;

// TODO: this type is limited to platform 'windows5.0'
pub extern "wsnmp32" fn SnmpDuplicateVbl(
    session: isize,
    vbl: isize,
) callconv(@import("std").os.windows.WINAPI) isize;

// TODO: this type is limited to platform 'windows5.0'
pub extern "wsnmp32" fn SnmpFreeVbl(
    vbl: isize,
) callconv(@import("std").os.windows.WINAPI) u32;

// TODO: this type is limited to platform 'windows5.0'
pub extern "wsnmp32" fn SnmpCountVbl(
    vbl: isize,
) callconv(@import("std").os.windows.WINAPI) u32;

// TODO: this type is limited to platform 'windows5.0'
pub extern "wsnmp32" fn SnmpGetVb(
    vbl: isize,
    index: u32,
    name: ?*smiOID,
    value: ?*smiVALUE,
) callconv(@import("std").os.windows.WINAPI) u32;

// TODO: this type is limited to platform 'windows5.0'
pub extern "wsnmp32" fn SnmpSetVb(
    vbl: isize,
    index: u32,
    name: ?*smiOID,
    value: ?*smiVALUE,
) callconv(@import("std").os.windows.WINAPI) u32;

// TODO: this type is limited to platform 'windows5.0'
pub extern "wsnmp32" fn SnmpDeleteVb(
    vbl: isize,
    index: u32,
) callconv(@import("std").os.windows.WINAPI) u32;

// TODO: this type is limited to platform 'windows5.0'
pub extern "wsnmp32" fn SnmpGetLastError(
    session: isize,
) callconv(@import("std").os.windows.WINAPI) u32;

// TODO: this type is limited to platform 'windows5.0'
pub extern "wsnmp32" fn SnmpStrToOid(
    string: ?[*:0]const u8,
    dstOID: ?*smiOID,
) callconv(@import("std").os.windows.WINAPI) u32;

// TODO: this type is limited to platform 'windows5.0'
pub extern "wsnmp32" fn SnmpOidToStr(
    srcOID: ?*smiOID,
    size: u32,
    string: [*:0]u8,
) callconv(@import("std").os.windows.WINAPI) u32;

// TODO: this type is limited to platform 'windows5.0'
pub extern "wsnmp32" fn SnmpOidCopy(
    srcOID: ?*smiOID,
    dstOID: ?*smiOID,
) callconv(@import("std").os.windows.WINAPI) u32;

// TODO: this type is limited to platform 'windows5.0'
pub extern "wsnmp32" fn SnmpOidCompare(
    xOID: ?*smiOID,
    yOID: ?*smiOID,
    maxlen: u32,
    result: ?*i32,
) callconv(@import("std").os.windows.WINAPI) u32;

// TODO: this type is limited to platform 'windows5.0'
pub extern "wsnmp32" fn SnmpEncodeMsg(
    session: isize,
    srcEntity: isize,
    dstEntity: isize,
    context: isize,
    pdu: isize,
    msgBufDesc: ?*smiOCTETS,
) callconv(@import("std").os.windows.WINAPI) u32;

// TODO: this type is limited to platform 'windows5.0'
pub extern "wsnmp32" fn SnmpDecodeMsg(
    session: isize,
    srcEntity: ?*isize,
    dstEntity: ?*isize,
    context: ?*isize,
    pdu: ?*isize,
    msgBufDesc: ?*smiOCTETS,
) callconv(@import("std").os.windows.WINAPI) u32;

// TODO: this type is limited to platform 'windows5.0'
pub extern "wsnmp32" fn SnmpFreeDescriptor(
    syntax: u32,
    descriptor: ?*smiOCTETS,
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
// Section: Imports (8)
//--------------------------------------------------------------------------------
const BOOL = @import("../foundation.zig").BOOL;
const CHAR = @import("../foundation.zig").CHAR;
const HANDLE = @import("../foundation.zig").HANDLE;
const HWND = @import("../foundation.zig").HWND;
const LPARAM = @import("../foundation.zig").LPARAM;
const PSTR = @import("../foundation.zig").PSTR;
const ULARGE_INTEGER = @import("../foundation.zig").ULARGE_INTEGER;
const WPARAM = @import("../foundation.zig").WPARAM;

test {
    // The following '_ = <FuncPtrType>' lines are a workaround for https://github.com/ziglang/zig/issues/4476
    if (@hasDecl(@This(), "PFNSNMPEXTENSIONINIT")) {
        _ = PFNSNMPEXTENSIONINIT;
    }
    if (@hasDecl(@This(), "PFNSNMPEXTENSIONINITEX")) {
        _ = PFNSNMPEXTENSIONINITEX;
    }
    if (@hasDecl(@This(), "PFNSNMPEXTENSIONMONITOR")) {
        _ = PFNSNMPEXTENSIONMONITOR;
    }
    if (@hasDecl(@This(), "PFNSNMPEXTENSIONQUERY")) {
        _ = PFNSNMPEXTENSIONQUERY;
    }
    if (@hasDecl(@This(), "PFNSNMPEXTENSIONQUERYEX")) {
        _ = PFNSNMPEXTENSIONQUERYEX;
    }
    if (@hasDecl(@This(), "PFNSNMPEXTENSIONTRAP")) {
        _ = PFNSNMPEXTENSIONTRAP;
    }
    if (@hasDecl(@This(), "PFNSNMPEXTENSIONCLOSE")) {
        _ = PFNSNMPEXTENSIONCLOSE;
    }
    if (@hasDecl(@This(), "SNMPAPI_CALLBACK")) {
        _ = SNMPAPI_CALLBACK;
    }
    if (@hasDecl(@This(), "PFNSNMPSTARTUPEX")) {
        _ = PFNSNMPSTARTUPEX;
    }
    if (@hasDecl(@This(), "PFNSNMPCLEANUPEX")) {
        _ = PFNSNMPCLEANUPEX;
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
