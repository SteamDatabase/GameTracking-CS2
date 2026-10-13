//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Downsample/resolve depth buffer";
	DevShader = true;
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
	DynamicCombo( D_OUTPUT_MIP0, 0..1 );
	DynamicCombo( D_REVERSE_DEPTH, 0..1 );
	DynamicCombo( D_RESAMPLE, 0..1 );
	DynamicCombo( D_MIP_COUNT, 1..4 );
	DynamicCombo( D_MSAA_DEPTH, 0..3 );
	DynamicComboRule( Requires( D_MSAA_DEPTH, D_RESAMPLE ) );
	
	int g_nSrcHeight < Attribute("SrcHeight"); UiType(Slider); >;
	int g_nSrcWidth < Attribute("SrcWidth"); UiType(Slider); >;
	RWTexture2D<float4> g_tOutDepthMIP0 < Attribute("DepthMip0"); >;
	RWTexture2D<float4> g_tOutDepthMIP1 < Attribute("DepthMip1"); >;
	RWTexture2D<float4> g_tOutDepthMIP2 < Attribute("DepthMip2"); >;
	RWTexture2D<float4> g_tOutDepthMIP3 < Attribute("DepthMip3"); >;
	RWTexture2D<float4> g_tOutDepthMIP4 < Attribute("DepthMip4"); >;
	Texture2D g_tSrcDepth < Attribute("DepthBuffer"); SrgbRead(false); >;
	float2 g_vInvSrcSize < Attribute("InvSrcSize"); UiType(VectorText); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	cbuffer _Globals_ : register(b0, space0)
	{
	    int _Globals_1_g_nSrcWidth : packoffset(c0.w);
	    int _Globals_1_g_nSrcHeight : packoffset(c1);
	};
	
	Texture2D<float4> g_tSrcDepth : register(t30, space0);
	RWTexture2D<float4> g_tOutDepthMIP1 : register(u159, space0);
	
	static uint3 gl_GlobalInvocationID;
	struct SPIRV_Cross_Input
	{
	    uint3 gl_GlobalInvocationID : SV_DispatchThreadID;
	};
	
	void MainCs_inner()
	{
	    uint2 _3829 = gl_GlobalInvocationID.xy * uint2(2u, 2u);
	    uint2 _16426 = uint2(int2(_Globals_1_g_nSrcWidth - 1, _Globals_1_g_nSrcHeight - 1));
	    int3 _8201 = int3(uint3(min(_16426, _3829), 0u));
	    int3 _8202 = int3(uint3(min(_16426, (_3829 + uint2(1u, 0u))), 0u));
	    int3 _8203 = int3(uint3(min(_16426, (_3829 + uint2(0u, 1u))), 0u));
	    int3 _8204 = int3(uint3(min(_16426, (_3829 + uint2(1u, 1u))), 0u));
	    g_tOutDepthMIP1[gl_GlobalInvocationID.xy] = max(max(g_tSrcDepth.Load(int3(_8201.xy, _8201.z)).x, g_tSrcDepth.Load(int3(_8202.xy, _8202.z)).x), max(g_tSrcDepth.Load(int3(_8203.xy, _8203.z)).x, g_tSrcDepth.Load(int3(_8204.xy, _8204.z)).x)).xxxx;
	    GroupMemoryBarrierWithGroupSync();
	    GroupMemoryBarrierWithGroupSync();
	    GroupMemoryBarrierWithGroupSync();
	}
	
	[numthreads(8, 8, 1)]
	void MainCs(SPIRV_Cross_Input stage_input)
	{
	    gl_GlobalInvocationID = stage_input.gl_GlobalInvocationID;
	    MainCs_inner();
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
}
