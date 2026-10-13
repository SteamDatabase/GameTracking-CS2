//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "RGB blur using one of 4 Gaussian kernels";
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
	Feature( F_GAUSSIAN_KERNEL, 0..4 (0="No Blur", 1="7 pixels wide", 2="9 pixels wide", 3="13 pixels wide", 4="25 pixels wide"), "Gaussian Kernel" );
	Feature( F_SRGB_READ, 0..1, "SRGB Read" );
}

COMMON
{
	#include "system.fxc"
}

struct VS_INPUT
{
	float4 vPositionPs : POSITION0  < Semantic( position ); >;                                    
	float4 vTexCoord   : TEXCOORD0  < Semantic( texcoord ); >;                                    
};

VS
{
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	static float4 gl_Position;
	static float3 vPositionPs;
	static float2 vTexCoord;
	static float2 output_0;
	
	struct VS_INPUT
	{
	    float3 vPositionPs : POSITION0;
	    float2 vTexCoord : TEXCOORD0;
	};
	
	struct PS_INPUT
	{
	    float2 output_0 : TEXCOORD0;
	    float4 gl_Position : SV_Position;
	};
	
	void MainVs_inner()
	{
	    float4 _14456 = float4(vPositionPs, 1.0f);
	    output_0 = vTexCoord;
	    _14456.y = -vPositionPs.y;
	    gl_Position = _14456;
	}
	
	PS_INPUT MainVs(VS_INPUT stage_input)
	{
	    vPositionPs = stage_input.vPositionPs;
	    vTexCoord = stage_input.vTexCoord;
	    MainVs_inner();
	    PS_INPUT stage_output;
	    stage_output.gl_Position = gl_Position;
	    stage_output.output_0 = output_0;
	    return stage_output;
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
}

PS
{
	StaticCombo( S_GAUSSIAN_KERNEL, F_GAUSSIAN_KERNEL );
	StaticCombo( S_SRGB_READ, F_SRGB_READ );
	DynamicCombo( D_BLUR_Y, 0..1 );
	
	Texture2D g_tInputTexture < Attribute("InputTexture"); SrgbRead(false); >;
	Texture2D g_tInputTexture < Attribute("InputTexture"); SrgbRead(true); >;
	float4 g_vInvTextureDim < Source(InvTextureDim); SourceArg(g_tInputTexture) UiType(VectorText); >;
	float4 g_vInvTextureDim < Source(InvTextureDim); SourceArg(g_tInputTexture) UiType(VectorText); >;
	
	#if (S_SRGB_READ == 1)
		Texture2D g_tInputTexture < Attribute("InputTexture"); SrgbRead(true); >;
	#endif
	
	// Variant parameters
	Texture2D g_tInputTexture < Attribute("InputTexture"); SrgbRead(false); >;
	float4 g_vInvTextureDim < Source(InvTextureDim); SourceArg(g_tInputTexture) UiType(VectorText); >;
	float4 g_vInvTextureDim < Source(InvTextureDim); SourceArg(g_tInputTexture) UiType(VectorText); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	Texture2D<float4> g_tInputTexture : register(t30, space1);
	SamplerState AddressU_Clamp_AddressV_Clamp_Filter_MinMagLinearMipPoint : register(s14, space1);
	
	static float2 input_0;
	static float4 output_0;
	
	struct PS_INPUT
	{
	    float2 input_0 : TEXCOORD0;
	};
	
	struct PS_OUTPUT
	{
	    float4 output_0 : SV_Target0;
	};
	
	void MainPs_inner()
	{
	    output_0 = g_tInputTexture.SampleLevel(AddressU_Clamp_AddressV_Clamp_Filter_MinMagLinearMipPoint, input_0.xy, 0.0f);
	}
	
	PS_OUTPUT MainPs(PS_INPUT stage_input)
	{
	    input_0 = stage_input.input_0;
	    MainPs_inner();
	    PS_OUTPUT stage_output;
	    stage_output.output_0 = output_0;
	    return stage_output;
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
}
