//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Screenspace, per-vertex color, (optionally) textured";
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
	float4 vColor      : COLOR0     < Semantic( Color ); >;                                       
	float3 vPositionPs : POSITION0  < Semantic( PosXyz ); >;                                      
	float2 vUVs        : TEXCOORD0  < Semantic( LowPrecisionUv ); >;                              
};

VS
{
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	static float4 gl_Position;
	static float4 vPositionPs;
	static float4 vColor;
	static float2 vUVs;
	static float4 output_0;
	static float2 output_1;
	
	struct VS_INPUT
	{
	    float4 vPositionPs : POSITION0;
	    float4 vColor : COLOR0;
	    float2 vUVs : TEXCOORD0;
	};
	
	struct PS_INPUT
	{
	    float4 output_0 : TEXCOORD0;
	    float2 output_1 : TEXCOORD1;
	    float4 gl_Position : SV_Position;
	};
	
	void MainVs_inner()
	{
	    float4 _22883 = vPositionPs;
	    output_0 = vColor;
	    output_1 = vUVs;
	    _22883.y = -_22883.y;
	    gl_Position = _22883;
	}
	
	PS_INPUT MainVs(VS_INPUT stage_input)
	{
	    vPositionPs = stage_input.vPositionPs;
	    vColor = stage_input.vColor;
	    vUVs = stage_input.vUVs;
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
	
	Texture2D g_tColorTexture < Attribute("ColorTexture"); SrgbRead(true); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	Texture2D<float4> g_tColorTexture : register(t30, space1);
	SamplerState AddressU_Clamp_AddressV_Clamp_Filter_MinMagMipLinear : register(s14, space1);
	
	static float4 input_0;
	static float2 input_1;
	static float4 output_0;
	
	struct PS_INPUT
	{
	    float4 input_0 : TEXCOORD0;
	    float2 input_1 : TEXCOORD1;
	};
	
	struct PS_OUTPUT
	{
	    float4 output_0 : SV_Target0;
	};
	
	void MainPs_inner()
	{
	    output_0 = input_0 * g_tColorTexture.Sample(AddressU_Clamp_AddressV_Clamp_Filter_MinMagMipLinear, input_1.xy);
	}
	
	PS_OUTPUT MainPs(PS_INPUT stage_input)
	{
	    input_0 = stage_input.input_0;
	    input_1 = stage_input.input_1;
	    MainPs_inner();
	    PS_OUTPUT stage_output;
	    stage_output.output_0 = output_0;
	    return stage_output;
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
}
