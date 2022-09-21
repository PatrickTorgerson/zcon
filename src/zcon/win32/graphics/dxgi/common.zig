//! NOTE: this file is autogenerated, DO NOT MODIFY
//--------------------------------------------------------------------------------
// Section: Constants (9)
//--------------------------------------------------------------------------------
pub const _FACDXGI = @as(u32, 2170);
pub const DXGI_CPU_ACCESS_NONE = @as(u32, 0);
pub const DXGI_CPU_ACCESS_DYNAMIC = @as(u32, 1);
pub const DXGI_CPU_ACCESS_READ_WRITE = @as(u32, 2);
pub const DXGI_CPU_ACCESS_SCRATCH = @as(u32, 3);
pub const DXGI_CPU_ACCESS_FIELD = @as(u32, 15);
pub const DXGI_FORMAT_DEFINED = @as(u32, 1);
pub const DXGI_STANDARD_MULTISAMPLE_QUALITY_PATTERN = @as(u32, 4294967295);
pub const DXGI_CENTER_MULTISAMPLE_QUALITY_PATTERN = @as(u32, 4294967294);

//--------------------------------------------------------------------------------
// Section: Types (15)
//--------------------------------------------------------------------------------
pub const DXGI_RATIONAL = extern struct {
    Numerator: u32,
    Denominator: u32,
};

pub const DXGI_SAMPLE_DESC = extern struct {
    Count: u32,
    Quality: u32,
};

pub const DXGI_COLOR_SPACE_TYPE = enum(i32) {
    RGB_FULL_G22_NONE_P709 = 0,
    RGB_FULL_G10_NONE_P709 = 1,
    RGB_STUDIO_G22_NONE_P709 = 2,
    RGB_STUDIO_G22_NONE_P2020 = 3,
    RESERVED = 4,
    YCBCR_FULL_G22_NONE_P709_X601 = 5,
    YCBCR_STUDIO_G22_LEFT_P601 = 6,
    YCBCR_FULL_G22_LEFT_P601 = 7,
    YCBCR_STUDIO_G22_LEFT_P709 = 8,
    YCBCR_FULL_G22_LEFT_P709 = 9,
    YCBCR_STUDIO_G22_LEFT_P2020 = 10,
    YCBCR_FULL_G22_LEFT_P2020 = 11,
    RGB_FULL_G2084_NONE_P2020 = 12,
    YCBCR_STUDIO_G2084_LEFT_P2020 = 13,
    RGB_STUDIO_G2084_NONE_P2020 = 14,
    YCBCR_STUDIO_G22_TOPLEFT_P2020 = 15,
    YCBCR_STUDIO_G2084_TOPLEFT_P2020 = 16,
    RGB_FULL_G22_NONE_P2020 = 17,
    YCBCR_STUDIO_GHLG_TOPLEFT_P2020 = 18,
    YCBCR_FULL_GHLG_TOPLEFT_P2020 = 19,
    RGB_STUDIO_G24_NONE_P709 = 20,
    RGB_STUDIO_G24_NONE_P2020 = 21,
    YCBCR_STUDIO_G24_LEFT_P709 = 22,
    YCBCR_STUDIO_G24_LEFT_P2020 = 23,
    YCBCR_STUDIO_G24_TOPLEFT_P2020 = 24,
    CUSTOM = -1,
};
pub const DXGI_COLOR_SPACE_RGB_FULL_G22_NONE_P709 = DXGI_COLOR_SPACE_TYPE.RGB_FULL_G22_NONE_P709;
pub const DXGI_COLOR_SPACE_RGB_FULL_G10_NONE_P709 = DXGI_COLOR_SPACE_TYPE.RGB_FULL_G10_NONE_P709;
pub const DXGI_COLOR_SPACE_RGB_STUDIO_G22_NONE_P709 = DXGI_COLOR_SPACE_TYPE.RGB_STUDIO_G22_NONE_P709;
pub const DXGI_COLOR_SPACE_RGB_STUDIO_G22_NONE_P2020 = DXGI_COLOR_SPACE_TYPE.RGB_STUDIO_G22_NONE_P2020;
pub const DXGI_COLOR_SPACE_RESERVED = DXGI_COLOR_SPACE_TYPE.RESERVED;
pub const DXGI_COLOR_SPACE_YCBCR_FULL_G22_NONE_P709_X601 = DXGI_COLOR_SPACE_TYPE.YCBCR_FULL_G22_NONE_P709_X601;
pub const DXGI_COLOR_SPACE_YCBCR_STUDIO_G22_LEFT_P601 = DXGI_COLOR_SPACE_TYPE.YCBCR_STUDIO_G22_LEFT_P601;
pub const DXGI_COLOR_SPACE_YCBCR_FULL_G22_LEFT_P601 = DXGI_COLOR_SPACE_TYPE.YCBCR_FULL_G22_LEFT_P601;
pub const DXGI_COLOR_SPACE_YCBCR_STUDIO_G22_LEFT_P709 = DXGI_COLOR_SPACE_TYPE.YCBCR_STUDIO_G22_LEFT_P709;
pub const DXGI_COLOR_SPACE_YCBCR_FULL_G22_LEFT_P709 = DXGI_COLOR_SPACE_TYPE.YCBCR_FULL_G22_LEFT_P709;
pub const DXGI_COLOR_SPACE_YCBCR_STUDIO_G22_LEFT_P2020 = DXGI_COLOR_SPACE_TYPE.YCBCR_STUDIO_G22_LEFT_P2020;
pub const DXGI_COLOR_SPACE_YCBCR_FULL_G22_LEFT_P2020 = DXGI_COLOR_SPACE_TYPE.YCBCR_FULL_G22_LEFT_P2020;
pub const DXGI_COLOR_SPACE_RGB_FULL_G2084_NONE_P2020 = DXGI_COLOR_SPACE_TYPE.RGB_FULL_G2084_NONE_P2020;
pub const DXGI_COLOR_SPACE_YCBCR_STUDIO_G2084_LEFT_P2020 = DXGI_COLOR_SPACE_TYPE.YCBCR_STUDIO_G2084_LEFT_P2020;
pub const DXGI_COLOR_SPACE_RGB_STUDIO_G2084_NONE_P2020 = DXGI_COLOR_SPACE_TYPE.RGB_STUDIO_G2084_NONE_P2020;
pub const DXGI_COLOR_SPACE_YCBCR_STUDIO_G22_TOPLEFT_P2020 = DXGI_COLOR_SPACE_TYPE.YCBCR_STUDIO_G22_TOPLEFT_P2020;
pub const DXGI_COLOR_SPACE_YCBCR_STUDIO_G2084_TOPLEFT_P2020 = DXGI_COLOR_SPACE_TYPE.YCBCR_STUDIO_G2084_TOPLEFT_P2020;
pub const DXGI_COLOR_SPACE_RGB_FULL_G22_NONE_P2020 = DXGI_COLOR_SPACE_TYPE.RGB_FULL_G22_NONE_P2020;
pub const DXGI_COLOR_SPACE_YCBCR_STUDIO_GHLG_TOPLEFT_P2020 = DXGI_COLOR_SPACE_TYPE.YCBCR_STUDIO_GHLG_TOPLEFT_P2020;
pub const DXGI_COLOR_SPACE_YCBCR_FULL_GHLG_TOPLEFT_P2020 = DXGI_COLOR_SPACE_TYPE.YCBCR_FULL_GHLG_TOPLEFT_P2020;
pub const DXGI_COLOR_SPACE_RGB_STUDIO_G24_NONE_P709 = DXGI_COLOR_SPACE_TYPE.RGB_STUDIO_G24_NONE_P709;
pub const DXGI_COLOR_SPACE_RGB_STUDIO_G24_NONE_P2020 = DXGI_COLOR_SPACE_TYPE.RGB_STUDIO_G24_NONE_P2020;
pub const DXGI_COLOR_SPACE_YCBCR_STUDIO_G24_LEFT_P709 = DXGI_COLOR_SPACE_TYPE.YCBCR_STUDIO_G24_LEFT_P709;
pub const DXGI_COLOR_SPACE_YCBCR_STUDIO_G24_LEFT_P2020 = DXGI_COLOR_SPACE_TYPE.YCBCR_STUDIO_G24_LEFT_P2020;
pub const DXGI_COLOR_SPACE_YCBCR_STUDIO_G24_TOPLEFT_P2020 = DXGI_COLOR_SPACE_TYPE.YCBCR_STUDIO_G24_TOPLEFT_P2020;
pub const DXGI_COLOR_SPACE_CUSTOM = DXGI_COLOR_SPACE_TYPE.CUSTOM;

pub const DXGI_FORMAT = enum(u32) {
    UNKNOWN = 0,
    R32G32B32A32_TYPELESS = 1,
    R32G32B32A32_FLOAT = 2,
    R32G32B32A32_UINT = 3,
    R32G32B32A32_SINT = 4,
    R32G32B32_TYPELESS = 5,
    R32G32B32_FLOAT = 6,
    R32G32B32_UINT = 7,
    R32G32B32_SINT = 8,
    R16G16B16A16_TYPELESS = 9,
    R16G16B16A16_FLOAT = 10,
    R16G16B16A16_UNORM = 11,
    R16G16B16A16_UINT = 12,
    R16G16B16A16_SNORM = 13,
    R16G16B16A16_SINT = 14,
    R32G32_TYPELESS = 15,
    R32G32_FLOAT = 16,
    R32G32_UINT = 17,
    R32G32_SINT = 18,
    R32G8X24_TYPELESS = 19,
    D32_FLOAT_S8X24_UINT = 20,
    R32_FLOAT_X8X24_TYPELESS = 21,
    X32_TYPELESS_G8X24_UINT = 22,
    R10G10B10A2_TYPELESS = 23,
    R10G10B10A2_UNORM = 24,
    R10G10B10A2_UINT = 25,
    R11G11B10_FLOAT = 26,
    R8G8B8A8_TYPELESS = 27,
    R8G8B8A8_UNORM = 28,
    R8G8B8A8_UNORM_SRGB = 29,
    R8G8B8A8_UINT = 30,
    R8G8B8A8_SNORM = 31,
    R8G8B8A8_SINT = 32,
    R16G16_TYPELESS = 33,
    R16G16_FLOAT = 34,
    R16G16_UNORM = 35,
    R16G16_UINT = 36,
    R16G16_SNORM = 37,
    R16G16_SINT = 38,
    R32_TYPELESS = 39,
    D32_FLOAT = 40,
    R32_FLOAT = 41,
    R32_UINT = 42,
    R32_SINT = 43,
    R24G8_TYPELESS = 44,
    D24_UNORM_S8_UINT = 45,
    R24_UNORM_X8_TYPELESS = 46,
    X24_TYPELESS_G8_UINT = 47,
    R8G8_TYPELESS = 48,
    R8G8_UNORM = 49,
    R8G8_UINT = 50,
    R8G8_SNORM = 51,
    R8G8_SINT = 52,
    R16_TYPELESS = 53,
    R16_FLOAT = 54,
    D16_UNORM = 55,
    R16_UNORM = 56,
    R16_UINT = 57,
    R16_SNORM = 58,
    R16_SINT = 59,
    R8_TYPELESS = 60,
    R8_UNORM = 61,
    R8_UINT = 62,
    R8_SNORM = 63,
    R8_SINT = 64,
    A8_UNORM = 65,
    R1_UNORM = 66,
    R9G9B9E5_SHAREDEXP = 67,
    R8G8_B8G8_UNORM = 68,
    G8R8_G8B8_UNORM = 69,
    BC1_TYPELESS = 70,
    BC1_UNORM = 71,
    BC1_UNORM_SRGB = 72,
    BC2_TYPELESS = 73,
    BC2_UNORM = 74,
    BC2_UNORM_SRGB = 75,
    BC3_TYPELESS = 76,
    BC3_UNORM = 77,
    BC3_UNORM_SRGB = 78,
    BC4_TYPELESS = 79,
    BC4_UNORM = 80,
    BC4_SNORM = 81,
    BC5_TYPELESS = 82,
    BC5_UNORM = 83,
    BC5_SNORM = 84,
    B5G6R5_UNORM = 85,
    B5G5R5A1_UNORM = 86,
    B8G8R8A8_UNORM = 87,
    B8G8R8X8_UNORM = 88,
    R10G10B10_XR_BIAS_A2_UNORM = 89,
    B8G8R8A8_TYPELESS = 90,
    B8G8R8A8_UNORM_SRGB = 91,
    B8G8R8X8_TYPELESS = 92,
    B8G8R8X8_UNORM_SRGB = 93,
    BC6H_TYPELESS = 94,
    BC6H_UF16 = 95,
    BC6H_SF16 = 96,
    BC7_TYPELESS = 97,
    BC7_UNORM = 98,
    BC7_UNORM_SRGB = 99,
    AYUV = 100,
    Y410 = 101,
    Y416 = 102,
    NV12 = 103,
    P010 = 104,
    P016 = 105,
    @"420_OPAQUE" = 106,
    YUY2 = 107,
    Y210 = 108,
    Y216 = 109,
    NV11 = 110,
    AI44 = 111,
    IA44 = 112,
    P8 = 113,
    A8P8 = 114,
    B4G4R4A4_UNORM = 115,
    P208 = 130,
    V208 = 131,
    V408 = 132,
    SAMPLER_FEEDBACK_MIN_MIP_OPAQUE = 189,
    SAMPLER_FEEDBACK_MIP_REGION_USED_OPAQUE = 190,
    FORCE_UINT = 4294967295,
};
pub const DXGI_FORMAT_UNKNOWN = DXGI_FORMAT.UNKNOWN;
pub const DXGI_FORMAT_R32G32B32A32_TYPELESS = DXGI_FORMAT.R32G32B32A32_TYPELESS;
pub const DXGI_FORMAT_R32G32B32A32_FLOAT = DXGI_FORMAT.R32G32B32A32_FLOAT;
pub const DXGI_FORMAT_R32G32B32A32_UINT = DXGI_FORMAT.R32G32B32A32_UINT;
pub const DXGI_FORMAT_R32G32B32A32_SINT = DXGI_FORMAT.R32G32B32A32_SINT;
pub const DXGI_FORMAT_R32G32B32_TYPELESS = DXGI_FORMAT.R32G32B32_TYPELESS;
pub const DXGI_FORMAT_R32G32B32_FLOAT = DXGI_FORMAT.R32G32B32_FLOAT;
pub const DXGI_FORMAT_R32G32B32_UINT = DXGI_FORMAT.R32G32B32_UINT;
pub const DXGI_FORMAT_R32G32B32_SINT = DXGI_FORMAT.R32G32B32_SINT;
pub const DXGI_FORMAT_R16G16B16A16_TYPELESS = DXGI_FORMAT.R16G16B16A16_TYPELESS;
pub const DXGI_FORMAT_R16G16B16A16_FLOAT = DXGI_FORMAT.R16G16B16A16_FLOAT;
pub const DXGI_FORMAT_R16G16B16A16_UNORM = DXGI_FORMAT.R16G16B16A16_UNORM;
pub const DXGI_FORMAT_R16G16B16A16_UINT = DXGI_FORMAT.R16G16B16A16_UINT;
pub const DXGI_FORMAT_R16G16B16A16_SNORM = DXGI_FORMAT.R16G16B16A16_SNORM;
pub const DXGI_FORMAT_R16G16B16A16_SINT = DXGI_FORMAT.R16G16B16A16_SINT;
pub const DXGI_FORMAT_R32G32_TYPELESS = DXGI_FORMAT.R32G32_TYPELESS;
pub const DXGI_FORMAT_R32G32_FLOAT = DXGI_FORMAT.R32G32_FLOAT;
pub const DXGI_FORMAT_R32G32_UINT = DXGI_FORMAT.R32G32_UINT;
pub const DXGI_FORMAT_R32G32_SINT = DXGI_FORMAT.R32G32_SINT;
pub const DXGI_FORMAT_R32G8X24_TYPELESS = DXGI_FORMAT.R32G8X24_TYPELESS;
pub const DXGI_FORMAT_D32_FLOAT_S8X24_UINT = DXGI_FORMAT.D32_FLOAT_S8X24_UINT;
pub const DXGI_FORMAT_R32_FLOAT_X8X24_TYPELESS = DXGI_FORMAT.R32_FLOAT_X8X24_TYPELESS;
pub const DXGI_FORMAT_X32_TYPELESS_G8X24_UINT = DXGI_FORMAT.X32_TYPELESS_G8X24_UINT;
pub const DXGI_FORMAT_R10G10B10A2_TYPELESS = DXGI_FORMAT.R10G10B10A2_TYPELESS;
pub const DXGI_FORMAT_R10G10B10A2_UNORM = DXGI_FORMAT.R10G10B10A2_UNORM;
pub const DXGI_FORMAT_R10G10B10A2_UINT = DXGI_FORMAT.R10G10B10A2_UINT;
pub const DXGI_FORMAT_R11G11B10_FLOAT = DXGI_FORMAT.R11G11B10_FLOAT;
pub const DXGI_FORMAT_R8G8B8A8_TYPELESS = DXGI_FORMAT.R8G8B8A8_TYPELESS;
pub const DXGI_FORMAT_R8G8B8A8_UNORM = DXGI_FORMAT.R8G8B8A8_UNORM;
pub const DXGI_FORMAT_R8G8B8A8_UNORM_SRGB = DXGI_FORMAT.R8G8B8A8_UNORM_SRGB;
pub const DXGI_FORMAT_R8G8B8A8_UINT = DXGI_FORMAT.R8G8B8A8_UINT;
pub const DXGI_FORMAT_R8G8B8A8_SNORM = DXGI_FORMAT.R8G8B8A8_SNORM;
pub const DXGI_FORMAT_R8G8B8A8_SINT = DXGI_FORMAT.R8G8B8A8_SINT;
pub const DXGI_FORMAT_R16G16_TYPELESS = DXGI_FORMAT.R16G16_TYPELESS;
pub const DXGI_FORMAT_R16G16_FLOAT = DXGI_FORMAT.R16G16_FLOAT;
pub const DXGI_FORMAT_R16G16_UNORM = DXGI_FORMAT.R16G16_UNORM;
pub const DXGI_FORMAT_R16G16_UINT = DXGI_FORMAT.R16G16_UINT;
pub const DXGI_FORMAT_R16G16_SNORM = DXGI_FORMAT.R16G16_SNORM;
pub const DXGI_FORMAT_R16G16_SINT = DXGI_FORMAT.R16G16_SINT;
pub const DXGI_FORMAT_R32_TYPELESS = DXGI_FORMAT.R32_TYPELESS;
pub const DXGI_FORMAT_D32_FLOAT = DXGI_FORMAT.D32_FLOAT;
pub const DXGI_FORMAT_R32_FLOAT = DXGI_FORMAT.R32_FLOAT;
pub const DXGI_FORMAT_R32_UINT = DXGI_FORMAT.R32_UINT;
pub const DXGI_FORMAT_R32_SINT = DXGI_FORMAT.R32_SINT;
pub const DXGI_FORMAT_R24G8_TYPELESS = DXGI_FORMAT.R24G8_TYPELESS;
pub const DXGI_FORMAT_D24_UNORM_S8_UINT = DXGI_FORMAT.D24_UNORM_S8_UINT;
pub const DXGI_FORMAT_R24_UNORM_X8_TYPELESS = DXGI_FORMAT.R24_UNORM_X8_TYPELESS;
pub const DXGI_FORMAT_X24_TYPELESS_G8_UINT = DXGI_FORMAT.X24_TYPELESS_G8_UINT;
pub const DXGI_FORMAT_R8G8_TYPELESS = DXGI_FORMAT.R8G8_TYPELESS;
pub const DXGI_FORMAT_R8G8_UNORM = DXGI_FORMAT.R8G8_UNORM;
pub const DXGI_FORMAT_R8G8_UINT = DXGI_FORMAT.R8G8_UINT;
pub const DXGI_FORMAT_R8G8_SNORM = DXGI_FORMAT.R8G8_SNORM;
pub const DXGI_FORMAT_R8G8_SINT = DXGI_FORMAT.R8G8_SINT;
pub const DXGI_FORMAT_R16_TYPELESS = DXGI_FORMAT.R16_TYPELESS;
pub const DXGI_FORMAT_R16_FLOAT = DXGI_FORMAT.R16_FLOAT;
pub const DXGI_FORMAT_D16_UNORM = DXGI_FORMAT.D16_UNORM;
pub const DXGI_FORMAT_R16_UNORM = DXGI_FORMAT.R16_UNORM;
pub const DXGI_FORMAT_R16_UINT = DXGI_FORMAT.R16_UINT;
pub const DXGI_FORMAT_R16_SNORM = DXGI_FORMAT.R16_SNORM;
pub const DXGI_FORMAT_R16_SINT = DXGI_FORMAT.R16_SINT;
pub const DXGI_FORMAT_R8_TYPELESS = DXGI_FORMAT.R8_TYPELESS;
pub const DXGI_FORMAT_R8_UNORM = DXGI_FORMAT.R8_UNORM;
pub const DXGI_FORMAT_R8_UINT = DXGI_FORMAT.R8_UINT;
pub const DXGI_FORMAT_R8_SNORM = DXGI_FORMAT.R8_SNORM;
pub const DXGI_FORMAT_R8_SINT = DXGI_FORMAT.R8_SINT;
pub const DXGI_FORMAT_A8_UNORM = DXGI_FORMAT.A8_UNORM;
pub const DXGI_FORMAT_R1_UNORM = DXGI_FORMAT.R1_UNORM;
pub const DXGI_FORMAT_R9G9B9E5_SHAREDEXP = DXGI_FORMAT.R9G9B9E5_SHAREDEXP;
pub const DXGI_FORMAT_R8G8_B8G8_UNORM = DXGI_FORMAT.R8G8_B8G8_UNORM;
pub const DXGI_FORMAT_G8R8_G8B8_UNORM = DXGI_FORMAT.G8R8_G8B8_UNORM;
pub const DXGI_FORMAT_BC1_TYPELESS = DXGI_FORMAT.BC1_TYPELESS;
pub const DXGI_FORMAT_BC1_UNORM = DXGI_FORMAT.BC1_UNORM;
pub const DXGI_FORMAT_BC1_UNORM_SRGB = DXGI_FORMAT.BC1_UNORM_SRGB;
pub const DXGI_FORMAT_BC2_TYPELESS = DXGI_FORMAT.BC2_TYPELESS;
pub const DXGI_FORMAT_BC2_UNORM = DXGI_FORMAT.BC2_UNORM;
pub const DXGI_FORMAT_BC2_UNORM_SRGB = DXGI_FORMAT.BC2_UNORM_SRGB;
pub const DXGI_FORMAT_BC3_TYPELESS = DXGI_FORMAT.BC3_TYPELESS;
pub const DXGI_FORMAT_BC3_UNORM = DXGI_FORMAT.BC3_UNORM;
pub const DXGI_FORMAT_BC3_UNORM_SRGB = DXGI_FORMAT.BC3_UNORM_SRGB;
pub const DXGI_FORMAT_BC4_TYPELESS = DXGI_FORMAT.BC4_TYPELESS;
pub const DXGI_FORMAT_BC4_UNORM = DXGI_FORMAT.BC4_UNORM;
pub const DXGI_FORMAT_BC4_SNORM = DXGI_FORMAT.BC4_SNORM;
pub const DXGI_FORMAT_BC5_TYPELESS = DXGI_FORMAT.BC5_TYPELESS;
pub const DXGI_FORMAT_BC5_UNORM = DXGI_FORMAT.BC5_UNORM;
pub const DXGI_FORMAT_BC5_SNORM = DXGI_FORMAT.BC5_SNORM;
pub const DXGI_FORMAT_B5G6R5_UNORM = DXGI_FORMAT.B5G6R5_UNORM;
pub const DXGI_FORMAT_B5G5R5A1_UNORM = DXGI_FORMAT.B5G5R5A1_UNORM;
pub const DXGI_FORMAT_B8G8R8A8_UNORM = DXGI_FORMAT.B8G8R8A8_UNORM;
pub const DXGI_FORMAT_B8G8R8X8_UNORM = DXGI_FORMAT.B8G8R8X8_UNORM;
pub const DXGI_FORMAT_R10G10B10_XR_BIAS_A2_UNORM = DXGI_FORMAT.R10G10B10_XR_BIAS_A2_UNORM;
pub const DXGI_FORMAT_B8G8R8A8_TYPELESS = DXGI_FORMAT.B8G8R8A8_TYPELESS;
pub const DXGI_FORMAT_B8G8R8A8_UNORM_SRGB = DXGI_FORMAT.B8G8R8A8_UNORM_SRGB;
pub const DXGI_FORMAT_B8G8R8X8_TYPELESS = DXGI_FORMAT.B8G8R8X8_TYPELESS;
pub const DXGI_FORMAT_B8G8R8X8_UNORM_SRGB = DXGI_FORMAT.B8G8R8X8_UNORM_SRGB;
pub const DXGI_FORMAT_BC6H_TYPELESS = DXGI_FORMAT.BC6H_TYPELESS;
pub const DXGI_FORMAT_BC6H_UF16 = DXGI_FORMAT.BC6H_UF16;
pub const DXGI_FORMAT_BC6H_SF16 = DXGI_FORMAT.BC6H_SF16;
pub const DXGI_FORMAT_BC7_TYPELESS = DXGI_FORMAT.BC7_TYPELESS;
pub const DXGI_FORMAT_BC7_UNORM = DXGI_FORMAT.BC7_UNORM;
pub const DXGI_FORMAT_BC7_UNORM_SRGB = DXGI_FORMAT.BC7_UNORM_SRGB;
pub const DXGI_FORMAT_AYUV = DXGI_FORMAT.AYUV;
pub const DXGI_FORMAT_Y410 = DXGI_FORMAT.Y410;
pub const DXGI_FORMAT_Y416 = DXGI_FORMAT.Y416;
pub const DXGI_FORMAT_NV12 = DXGI_FORMAT.NV12;
pub const DXGI_FORMAT_P010 = DXGI_FORMAT.P010;
pub const DXGI_FORMAT_P016 = DXGI_FORMAT.P016;
pub const DXGI_FORMAT_420_OPAQUE = DXGI_FORMAT.@"420_OPAQUE";
pub const DXGI_FORMAT_YUY2 = DXGI_FORMAT.YUY2;
pub const DXGI_FORMAT_Y210 = DXGI_FORMAT.Y210;
pub const DXGI_FORMAT_Y216 = DXGI_FORMAT.Y216;
pub const DXGI_FORMAT_NV11 = DXGI_FORMAT.NV11;
pub const DXGI_FORMAT_AI44 = DXGI_FORMAT.AI44;
pub const DXGI_FORMAT_IA44 = DXGI_FORMAT.IA44;
pub const DXGI_FORMAT_P8 = DXGI_FORMAT.P8;
pub const DXGI_FORMAT_A8P8 = DXGI_FORMAT.A8P8;
pub const DXGI_FORMAT_B4G4R4A4_UNORM = DXGI_FORMAT.B4G4R4A4_UNORM;
pub const DXGI_FORMAT_P208 = DXGI_FORMAT.P208;
pub const DXGI_FORMAT_V208 = DXGI_FORMAT.V208;
pub const DXGI_FORMAT_V408 = DXGI_FORMAT.V408;
pub const DXGI_FORMAT_SAMPLER_FEEDBACK_MIN_MIP_OPAQUE = DXGI_FORMAT.SAMPLER_FEEDBACK_MIN_MIP_OPAQUE;
pub const DXGI_FORMAT_SAMPLER_FEEDBACK_MIP_REGION_USED_OPAQUE = DXGI_FORMAT.SAMPLER_FEEDBACK_MIP_REGION_USED_OPAQUE;
pub const DXGI_FORMAT_FORCE_UINT = DXGI_FORMAT.FORCE_UINT;

pub const DXGI_RGB = extern struct {
    Red: f32,
    Green: f32,
    Blue: f32,
};

pub const DXGI_GAMMA_CONTROL = extern struct {
    Scale: DXGI_RGB,
    Offset: DXGI_RGB,
    GammaCurve: [1025]DXGI_RGB,
};

pub const DXGI_GAMMA_CONTROL_CAPABILITIES = extern struct {
    ScaleAndOffsetSupported: BOOL,
    MaxConvertedValue: f32,
    MinConvertedValue: f32,
    NumGammaControlPoints: u32,
    ControlPointPositions: [1025]f32,
};

pub const DXGI_MODE_SCANLINE_ORDER = enum(i32) {
    UNSPECIFIED = 0,
    PROGRESSIVE = 1,
    UPPER_FIELD_FIRST = 2,
    LOWER_FIELD_FIRST = 3,
};
pub const DXGI_MODE_SCANLINE_ORDER_UNSPECIFIED = DXGI_MODE_SCANLINE_ORDER.UNSPECIFIED;
pub const DXGI_MODE_SCANLINE_ORDER_PROGRESSIVE = DXGI_MODE_SCANLINE_ORDER.PROGRESSIVE;
pub const DXGI_MODE_SCANLINE_ORDER_UPPER_FIELD_FIRST = DXGI_MODE_SCANLINE_ORDER.UPPER_FIELD_FIRST;
pub const DXGI_MODE_SCANLINE_ORDER_LOWER_FIELD_FIRST = DXGI_MODE_SCANLINE_ORDER.LOWER_FIELD_FIRST;

pub const DXGI_MODE_SCALING = enum(i32) {
    UNSPECIFIED = 0,
    CENTERED = 1,
    STRETCHED = 2,
};
pub const DXGI_MODE_SCALING_UNSPECIFIED = DXGI_MODE_SCALING.UNSPECIFIED;
pub const DXGI_MODE_SCALING_CENTERED = DXGI_MODE_SCALING.CENTERED;
pub const DXGI_MODE_SCALING_STRETCHED = DXGI_MODE_SCALING.STRETCHED;

pub const DXGI_MODE_ROTATION = enum(i32) {
    UNSPECIFIED = 0,
    IDENTITY = 1,
    ROTATE90 = 2,
    ROTATE180 = 3,
    ROTATE270 = 4,
};
pub const DXGI_MODE_ROTATION_UNSPECIFIED = DXGI_MODE_ROTATION.UNSPECIFIED;
pub const DXGI_MODE_ROTATION_IDENTITY = DXGI_MODE_ROTATION.IDENTITY;
pub const DXGI_MODE_ROTATION_ROTATE90 = DXGI_MODE_ROTATION.ROTATE90;
pub const DXGI_MODE_ROTATION_ROTATE180 = DXGI_MODE_ROTATION.ROTATE180;
pub const DXGI_MODE_ROTATION_ROTATE270 = DXGI_MODE_ROTATION.ROTATE270;

pub const DXGI_MODE_DESC = extern struct {
    Width: u32,
    Height: u32,
    RefreshRate: DXGI_RATIONAL,
    Format: DXGI_FORMAT,
    ScanlineOrdering: DXGI_MODE_SCANLINE_ORDER,
    Scaling: DXGI_MODE_SCALING,
};

pub const DXGI_JPEG_DC_HUFFMAN_TABLE = extern struct {
    CodeCounts: [12]u8,
    CodeValues: [12]u8,
};

pub const DXGI_JPEG_AC_HUFFMAN_TABLE = extern struct {
    CodeCounts: [16]u8,
    CodeValues: [162]u8,
};

pub const DXGI_JPEG_QUANTIZATION_TABLE = extern struct {
    Elements: [64]u8,
};

pub const DXGI_ALPHA_MODE = enum(u32) {
    UNSPECIFIED = 0,
    PREMULTIPLIED = 1,
    STRAIGHT = 2,
    IGNORE = 3,
    FORCE_DWORD = 4294967295,
};
pub const DXGI_ALPHA_MODE_UNSPECIFIED = DXGI_ALPHA_MODE.UNSPECIFIED;
pub const DXGI_ALPHA_MODE_PREMULTIPLIED = DXGI_ALPHA_MODE.PREMULTIPLIED;
pub const DXGI_ALPHA_MODE_STRAIGHT = DXGI_ALPHA_MODE.STRAIGHT;
pub const DXGI_ALPHA_MODE_IGNORE = DXGI_ALPHA_MODE.IGNORE;
pub const DXGI_ALPHA_MODE_FORCE_DWORD = DXGI_ALPHA_MODE.FORCE_DWORD;


//--------------------------------------------------------------------------------
// Section: Functions (0)
//--------------------------------------------------------------------------------

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
// Section: Imports (1)
//--------------------------------------------------------------------------------
const BOOL = @import("../../foundation.zig").BOOL;

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
