//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Shader used by the SFM's accumumation buffer";
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
	float3 vPositionSs : POSITION0  < Semantic( PosXyz ); >;                                      
	float2 vTexCoords  : TEXCOORD0  < Semantic( LowPrecisionUv ); >;                              
};

VS
{
	
	float4 g_vViewport < Source(Viewport); UiType(VectorText); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	static float _2;
	
	cbuffer _Globals_ : register(b0, space0)
	{
	    float4 _Globals_1_g_vViewport : packoffset(c0);
	};
	
	
	static float4 gl_Position;
	static float3 vPositionSs;
	static float2 vTexCoords;
	static float2 output_0;
	
	struct VS_INPUT
	{
	    float3 vPositionSs : POSITION0;
	    float2 vTexCoords : TEXCOORD0;
	};
	
	struct PS_INPUT
	{
	    float2 output_0 : TEXCOORD0;
	    float4 gl_Position : SV_Position;
	};
	
	void MainVs_inner()
	{
	    float2 _15639 = (((vPositionSs.xy - _Globals_1_g_vViewport.xy) * 2.0f) / _Globals_1_g_vViewport.zw) - 1.0f.xx;
	    float4 _14456 = float4(_15639.x, _2, 1.0f, 1.0f);
	    output_0 = vTexCoords;
	    _14456.y = _15639.y;
	    gl_Position = _14456;
	}
	
	PS_INPUT MainVs(VS_INPUT stage_input)
	{
	    vPositionSs = stage_input.vPositionSs;
	    vTexCoords = stage_input.vTexCoords;
	    MainVs_inner();
	    PS_INPUT stage_output;
	    stage_output.gl_Position = gl_Position;
	    stage_output.output_0 = output_0;
	    return stage_output;
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
	
	BoolAttribute(ui, true);
	
}

PS
{
	DynamicCombo( D_WRITE_COLOR_TO_ALPHA, 0..1 );
	DynamicCombo( D_WRITE_RED_TO_RGB, 0..1 );
	DynamicCombo( D_ADDITIVE_BLEND, 0..1 );
	
	Texture2D g_texture < Attribute("InputTexture"); SrgbRead(false); >;
	float4 g_vTextureDims < Source(TextureDim); SourceArg(g_texture) UiType(VectorText); >;
	float4 g_vViewport < Source(Viewport); UiType(VectorText); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	cbuffer _Globals_ : register(b0, space1)
	{
	    float4 _Globals_1_g_vViewport : packoffset(c0);
	    float4 _Globals_1_g_vTextureDims : packoffset(c1);
	};
	
	Texture2D<float4> g_texture : register(t30, space1);
	SamplerState Filter_MinMagMipPoint : register(s14, space1);
	
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
	    output_0 = float4(g_texture.Sample(Filter_MinMagMipPoint, ((input_0.xy * _Globals_1_g_vViewport.zw) / _Globals_1_g_vTextureDims.xy).xy).xyz, 0.0f);
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
