//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Reset Draw Params CS";
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
	DynamicCombo( D_CLEAR_BLOCK_COUNTS, 0..1 );
	DynamicCombo( D_MULTI_DRAW_INDIRECT, 0..1 );
	
	RWBuffer<float4> g_drawCountsOutput < Attribute("DrawCountsOutput"); >;
	RWBuffer<float4> g_drawInstancedParamsOutput < Attribute("DrawParamsOutput"); >;
	int g_nDrawStride < Attribute("DrawStride"); UiType(Slider); >;
	int g_nMaxDraws < Attribute("MaxDraws"); UiType(Slider); >;
	RWStructuredBuffer g_occlusionCulledBlockCounts < Attribute("OcclusionCulledBlockCounts"); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	cbuffer _Globals_ : register(b0, space0)
	{
	    uint _Globals_1_g_nMaxDraws : packoffset(c0);
	    uint _Globals_1_g_nDrawStride : packoffset(c0.y);
	};
	
	RWBuffer<uint> g_drawInstancedParamsOutput : register(u158, space0);
	
	static uint3 gl_GlobalInvocationID;
	struct SPIRV_Cross_Input
	{
	    uint3 gl_GlobalInvocationID : SV_DispatchThreadID;
	};
	
	void MainCs_inner()
	{
	    if (gl_GlobalInvocationID.x < _Globals_1_g_nMaxDraws)
	    {
	        uint _10371;
	        InterlockedMin(g_drawInstancedParamsOutput[(gl_GlobalInvocationID.x * _Globals_1_g_nDrawStride) + 1u], 0u, _10371);
	    }
	}
	
	[numthreads(64, 1, 1)]
	void MainCs(SPIRV_Cross_Input stage_input)
	{
	    gl_GlobalInvocationID = stage_input.gl_GlobalInvocationID;
	    MainCs_inner();
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
}
