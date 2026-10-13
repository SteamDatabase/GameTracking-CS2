//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Update vis node visibility based on region visibility";
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
	
	RWBuffer<float4> g_RWVisBits < Attribute("VisBits"); >;
	StructuredBuffer g_VisRegions < Attribute("VisRegions"); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	struct _981
	{
	    uint _m0;
	};
	
	ByteAddressBuffer g_VisRegions : register(t33, space0);
	RWBuffer<uint> g_RWVisBits : register(u158, space0);
	
	static uint3 gl_WorkGroupID;
	static uint3 gl_LocalInvocationID;
	struct SPIRV_Cross_Input
	{
	    uint3 gl_WorkGroupID : SV_GroupID;
	    uint3 gl_LocalInvocationID : SV_GroupThreadID;
	};
	
	void MainCs_inner()
	{
	    uint _8548 = (gl_WorkGroupID.x * 128u) + gl_LocalInvocationID.x;
	    uint _4283;
	    uint _4901;
	    uint _13155 = _8548;
	    uint _16208 = 0u;
	    for (;;)
	    {
	        if (!(_16208 < 2u))
	        {
	            break;
	        }
	        uint _25020 = g_VisRegions.Load<uint>(_13155 * 4 + 0) & 4095u;
	        if ((g_RWVisBits[int(_25020 / 32u)].xxxx.x & (1u << (_25020 % 32u))) != 0u)
	        {
	            uint _13532 = g_VisRegions.Load<uint>(_13155 * 4 + 0) >> uint(12);
	            uint _6313;
	            InterlockedOr(g_RWVisBits[_13532 / 32u], 1u << (_13532 % 32u), _6313);
	        }
	        _4901 = _13155 + 64u;
	        _4283 = _16208 + 1u;
	        _13155 = _4901;
	        _16208 = _4283;
	        continue;
	    }
	}
	
	[numthreads(64, 1, 1)]
	void MainCs(SPIRV_Cross_Input stage_input)
	{
	    gl_WorkGroupID = stage_input.gl_WorkGroupID;
	    gl_LocalInvocationID = stage_input.gl_LocalInvocationID;
	    MainCs_inner();
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
}
