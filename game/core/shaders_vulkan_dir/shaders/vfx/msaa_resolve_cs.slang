//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "MSAA Resolve";
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
	DynamicCombo( D_MSAA_SAMPLES, 0..2 );
	DynamicCombo( D_4X_DOWNSAMPLE, 0..1 );
	
	RWTexture2D<float4> OutputTexture < Attribute("OutputTexture"); >;
	RWTexture2D<float4> QuarterResOutputTexture < Attribute("QuarterResOutputTexture"); >;
	Texture2D g_tSourceMsaa < Attribute("InputTexture"); SrgbRead(false); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	Texture2DMS<float4> g_tSourceMsaa : register(t30, space0);
	RWTexture2D<float4> OutputTexture : register(u158, space0);
	
	static uint3 gl_GlobalInvocationID;
	struct SPIRV_Cross_Input
	{
	    uint3 gl_GlobalInvocationID : SV_DispatchThreadID;
	};
	
	void MainCs_inner()
	{
	    float3 _13155;
	    _13155 = 0.0f.xxx;
	    uint _9913;
	    float3 _10794;
	    uint _16208 = 0u;
	    for (;;)
	    {
	        if (!(_16208 < 2u))
	        {
	            break;
	        }
	        float4 _3300 = g_tSourceMsaa.Load(int2(gl_GlobalInvocationID.xy), int(_16208));
	        _10794 = _13155.xyz + (_3300.xyz * (0.5f / (max(_3300.x, max(_3300.y, _3300.z)) + 1.0f))).xyz;
	        _9913 = _16208 + 1u;
	        _13155 = _10794;
	        _16208 = _9913;
	        continue;
	    }
	    OutputTexture[gl_GlobalInvocationID.xy] = float4((_13155.xyz * (1.0f / (1.0f - max(_13155.x, max(_13155.y, _13155.z))))).xyz, 1.0f);
	}
	
	[numthreads(8, 8, 1)]
	void MainCs(SPIRV_Cross_Input stage_input)
	{
	    gl_GlobalInvocationID = stage_input.gl_GlobalInvocationID;
	    MainCs_inner();
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
}
