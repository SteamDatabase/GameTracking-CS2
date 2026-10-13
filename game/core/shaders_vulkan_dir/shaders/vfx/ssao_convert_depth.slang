//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Scalable Ambient Obscurance Depth Conversion";
	DevShader = true;
	Version = 0;
	
	// Platform: VULKAN_SM_50
	// Programs: ps, vs
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

struct VS_INPUT
{
	float3 vPositionPs : POSITION0  < Semantic( PosXyz ); >;                                      
};

VS
{
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	static float4 gl_Position;
	static float2 vPositionPs;
	
	struct VS_INPUT
	{
	    float2 vPositionPs : POSITION0;
	};
	
	struct PS_INPUT
	{
	    float4 gl_Position : SV_Position;
	};
	
	void MainVs_inner()
	{
	    float4 _22489 = float4(vPositionPs, 0.0f, 1.0f);
	    _22489.y = -vPositionPs.y;
	    gl_Position = _22489;
	}
	
	PS_INPUT MainVs(VS_INPUT stage_input)
	{
	    vPositionPs = stage_input.vPositionPs;
	    MainVs_inner();
	    PS_INPUT stage_output;
	    stage_output.gl_Position = gl_Position;
	    return stage_output;
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
}

PS
{
	DynamicCombo( D_MSAA_DEPTH_BUFFER, 0..1 );
	
	Texture2D g_tGBufferDepth < Attribute("GBufferDepth"); SrgbRead(false); >;
	Texture2D g_tGBufferDepthMS < Attribute("GBufferDepth"); SrgbRead(false); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	cbuffer PerViewConstantBuffer_t : register(b0, space1)
	{
	    float PerViewConstantBuffer_t_1_m0 : packoffset(c23);
	    float PerViewConstantBuffer_t_1_m1 : packoffset(c23.y);
	    float3 PerViewConstantBuffer_t_1_m2 : packoffset(c29);
	};
	
	Texture2D<float4> g_tGBufferDepth : register(t30, space1);
	
	static float4 gl_FragCoord;
	static float4 output_0;
	
	struct PS_INPUT
	{
	    float4 gl_FragCoord : SV_Position;
	};
	
	struct PS_OUTPUT
	{
	    float4 output_0 : SV_Target0;
	};
	
	void MainPs_inner()
	{
	    output_0 = (PerViewConstantBuffer_t_1_m2.x / ((PerViewConstantBuffer_t_1_m2.y * saturate((g_tGBufferDepth.Load(int3(int3(int2(gl_FragCoord.xy).xy, 0).xy, 0)).x - PerViewConstantBuffer_t_1_m0) / (PerViewConstantBuffer_t_1_m1 - PerViewConstantBuffer_t_1_m0))) + PerViewConstantBuffer_t_1_m2.z)).xxxx;
	}
	
	PS_OUTPUT MainPs(PS_INPUT stage_input)
	{
	    gl_FragCoord = stage_input.gl_FragCoord;
	    gl_FragCoord.w = 1.0 / gl_FragCoord.w;
	    MainPs_inner();
	    PS_OUTPUT stage_output;
	    stage_output.output_0 = output_0;
	    return stage_output;
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
}
