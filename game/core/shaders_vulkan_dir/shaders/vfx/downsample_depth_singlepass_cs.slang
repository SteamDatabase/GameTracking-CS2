//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Single pass WaveOp Downsample/resolve depth buffer";
	DevShader = false;
	Version = 0;
	
	// Platform: VULKAN_SM_50
	// Programs: cs
}

MODES
{
	Default();
}

FEATURES
{
}

COMMON
{
	#include "system.fxc"
}

CS
{
	DynamicCombo( D_REVERSE_DEPTH, 0..1 );
	DynamicCombo( D_MIP_COUNT, 0..12 );
	
	RWBuffer<float4> g_hWorkgroupCounterBuffer < Attribute("WorkgroupCounterBuffer"); >;
	int g_nGroupCount < Attribute("GroupCount"); UiType(Slider); >;
	int g_nSrcHeight < Attribute("SrcHeight"); UiType(Slider); >;
	int g_nSrcWidth < Attribute("SrcWidth"); UiType(Slider); >;
	RWTexture2D<float4> g_tDstMip1 < Attribute("Mip1"); >;
	RWTexture2D<float4> g_tDstMip10 < Attribute("Mip10"); >;
	RWTexture2D<float4> g_tDstMip11 < Attribute("Mip11"); >;
	RWTexture2D<float4> g_tDstMip2 < Attribute("Mip2"); >;
	RWTexture2D<float4> g_tDstMip3 < Attribute("Mip3"); >;
	RWTexture2D<float4> g_tDstMip4 < Attribute("Mip4"); >;
	RWTexture2D<float4> g_tDstMip5 < Attribute("Mip5"); >;
	RWTexture2D<float4> g_tDstMip6 < Attribute("Mip6"); >;
	RWTexture2D<float4> g_tDstMip7 < Attribute("Mip7"); >;
	RWTexture2D<float4> g_tDstMip8 < Attribute("Mip8"); >;
	RWTexture2D<float4> g_tDstMip9 < Attribute("Mip9"); >;
	Texture2D g_tSrcMip0 < Attribute("Mip0"); SrgbRead(false); >;
	float2 g_vInvSrcSize < Attribute("InvSrcSize"); UiType(VectorText); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	cbuffer _Globals_ : register(b0, space0)
	{
	    float2 _Globals_1_g_vInvSrcSize : packoffset(c0);
	};
	
	Texture2D<float4> g_tSrcMip0 : register(t30, space0);
	SamplerState AddressU_Clamp_AddressV_Clamp_AllowGlobalMipBiasOverride_0_Filter_MinMagMipPoint : register(s14, space0);
	RWTexture2D<float4> g_tDstMip1 : register(u158, space0);
	
	static uint3 gl_WorkGroupID;
	static uint3 gl_LocalInvocationID;
	struct SPIRV_Cross_Input
	{
	    uint3 gl_WorkGroupID : SV_GroupID;
	    uint3 gl_LocalInvocationID : SV_GroupThreadID;
	};
	
	void MainCs_inner()
	{
	    int2 _7101 = (int2(uint2(((gl_LocalInvocationID.x & 1u) | (((gl_LocalInvocationID.x >> uint(3)) & 3u) << uint(1))) | (((gl_LocalInvocationID.x >> uint(7)) & 1u) << uint(3)), ((gl_LocalInvocationID.x >> uint(1)) & 3u) | (((gl_LocalInvocationID.x >> uint(5)) & 3u) << uint(2)))) * int2(4, 4)) + int2(gl_WorkGroupID.xy * uint2(64u, 64u));
	    float2 _11517 = float2(_7101) * _Globals_1_g_vInvSrcSize;
	    float4 _24999 = g_tSrcMip0.GatherRed(AddressU_Clamp_AddressV_Clamp_AllowGlobalMipBiasOverride_0_Filter_MinMagMipPoint, _11517, int2(1, 1));
	    float4 _25000 = g_tSrcMip0.GatherRed(AddressU_Clamp_AddressV_Clamp_AllowGlobalMipBiasOverride_0_Filter_MinMagMipPoint, _11517, int2(3, 1));
	    float4 _25001 = g_tSrcMip0.GatherRed(AddressU_Clamp_AddressV_Clamp_AllowGlobalMipBiasOverride_0_Filter_MinMagMipPoint, _11517, int2(1, 3));
	    float4 _21268 = g_tSrcMip0.GatherRed(AddressU_Clamp_AddressV_Clamp_AllowGlobalMipBiasOverride_0_Filter_MinMagMipPoint, _11517, int2(3, 3));
	    int2 _13024 = _7101 >> int2(1, 1);
	    g_tDstMip1[uint2(_13024)] = max(max(_24999.w, _24999.z), max(_24999.x, _24999.y)).xxxx;
	    g_tDstMip1[uint2(_13024 + int2(1, 0))] = max(max(_25000.w, _25000.z), max(_25000.x, _25000.y)).xxxx;
	    g_tDstMip1[uint2(_13024 + int2(0, 1))] = max(max(_25001.w, _25001.z), max(_25001.x, _25001.y)).xxxx;
	    g_tDstMip1[uint2(_13024 + int2(1, 1))] = max(max(_21268.w, _21268.z), max(_21268.x, _21268.y)).xxxx;
	}
	
	[numthreads(256, 1, 1)]
	void MainCs(SPIRV_Cross_Input stage_input)
	{
	    gl_WorkGroupID = stage_input.gl_WorkGroupID;
	    gl_LocalInvocationID = stage_input.gl_LocalInvocationID;
	    MainCs_inner();
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
}
