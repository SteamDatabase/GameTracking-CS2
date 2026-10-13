//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "";
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
	float4 vNormalOs   : NORMAL0    < Semantic( Normal ); >;                                      
	float4 vPositionOs : POSITION0  < Semantic( Pos ); >;                                         
	float4 vUv0        : TEXCOORD0  < Semantic( TexCoord ); >;                                    
};

VS
{
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	static float4 gl_Position;
	static float3 vPositionOs;
	static float2 vUv0;
	static float4 vNormalOs;
	static float3 output_0;
	static float2 output_1;
	
	struct VS_INPUT
	{
	    float3 vPositionOs : POSITION0;
	    float4 vNormalOs : NORMAL0;
	    float2 vUv0 : TEXCOORD0;
	};
	
	struct PS_INPUT
	{
	    float3 output_0 : TEXCOORD0;
	    float2 output_1 : TEXCOORD1;
	    float4 gl_Position : SV_Position;
	};
	
	void MainVs_inner()
	{
	    float4 _14437 = float4(vPositionOs, 1.0f);
	    output_0 = float3(vNormalOs.xyz);
	    output_1 = vUv0;
	    _14437.y = -vPositionOs.y;
	    gl_Position = _14437;
	}
	
	PS_INPUT MainVs(VS_INPUT stage_input)
	{
	    vPositionOs = stage_input.vPositionOs;
	    vUv0 = stage_input.vUv0;
	    vNormalOs = stage_input.vNormalOs;
	    MainVs_inner();
	    PS_INPUT stage_output;
	    stage_output.gl_Position = gl_Position;
	    stage_output.output_0 = output_0;
	    stage_output.output_1 = output_1;
	    return stage_output;
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
}

PS
{
	
	Texture2D g_tColor < Attribute("OutputUAV"); SrgbRead(false); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	Texture2D<float4> g_tColor : register(t30, space1);
	SamplerState Filter_MinMagMipPoint : register(s14, space1);
	
	static float2 input_1;
	static float4 output_0;
	
	struct PS_INPUT
	{
	    float2 input_1 : TEXCOORD1;
	};
	
	struct PS_OUTPUT
	{
	    float4 output_0 : SV_Target0;
	};
	
	void MainPs_inner()
	{
	    output_0 = g_tColor.Sample(Filter_MinMagMipPoint, input_1.xy);
	}
	
	PS_OUTPUT MainPs(PS_INPUT stage_input)
	{
	    input_1 = stage_input.input_1;
	    MainPs_inner();
	    PS_OUTPUT stage_output;
	    stage_output.output_0 = output_0;
	    return stage_output;
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
}
