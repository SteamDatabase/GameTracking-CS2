//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Shader used form performing various 2d convolutions.";
	DevShader = true;
	Version = 0;
	
	// Platform: VULKAN_SM_50
	// Programs: ps, vs
}

MODES
{
	Default();
	Forward();
}

FEATURES
{
	Feature( F_ADDITIVE_BLENDING, 0..1, "Blending" );
	Feature( F_ALPHA_BLEND, 0..1, "Blending" );
	Feature( F_ALPHA_WEIGHTED, 0..1, "Filter parameters" );
	Feature( F_VERTEXTINT, 0..1, "Per vertex ARGB tint value" );
}

COMMON
{
	#include "system.fxc"
}

VS
{
	StaticCombo( S_VERTEXTINT, F_VERTEXTINT );
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	static float4 gl_Position;
	static float2 input_TEXCOORD0;
	static float3 input_POSITION0;
	static float2 output_0;
	
	struct VS_INPUT
	{
	    float3 input_POSITION0 : POSITION0;
	    float2 input_TEXCOORD0 : TEXCOORD0;
	};
	
	struct PS_INPUT
	{
	    float2 output_0 : TEXCOORD0;
	    float4 gl_Position : SV_Position;
	};
	
	void MainVs_inner()
	{
	    float4 _10551 = float4(input_POSITION0, 1.0f);
	    output_0 = input_TEXCOORD0;
	    _10551.y = -input_POSITION0.y;
	    gl_Position = _10551;
	}
	
	PS_INPUT MainVs(VS_INPUT stage_input)
	{
	    input_TEXCOORD0 = stage_input.input_TEXCOORD0;
	    input_POSITION0 = stage_input.input_POSITION0;
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
	StaticCombo( S_ALPHA_WEIGHTED, F_ALPHA_WEIGHTED );
	StaticCombo( S_VERTEXTINT, F_VERTEXTINT );
	StaticCombo( S_ALPHA_BLEND, F_ALPHA_BLEND );
	DynamicCombo( D_SRGBREADINPUT, 0..1 );
	DynamicCombo( D_CLAMPTEXTURECOORDS, 0..1 );
	
	RenderState(BlendEnable, F_ADDITIVE_BLENDING ? true : false);
	RenderState(DstBlend, F_ADDITIVE_BLENDING ? One : Zero);
	RenderState(SrcBlend, One);
	Texture2D g_tInputTexture < Attribute("inputTexture"); SrgbRead(false); >;
	Texture2D g_tInputTexture < Attribute("inputTexture"); SrgbRead(true); >;
	float4 g_vInvTexDim < Source(InvTextureDim); SourceArg(g_tInputTexture) UiType(VectorText); >;
	float4 g_vInvTexDim < Source(InvTextureDim); SourceArg(g_tInputTexture) UiType(VectorText); >;
	
	
	// Variant parameters
	Texture2D g_tInputTexture < Attribute("inputTexture"); SrgbRead(false); >;
	Texture2D g_tInputTexture < Attribute("inputTexture"); SrgbRead(true); >;
	float4 g_vInvTexDim < Source(InvTextureDim); SourceArg(g_tInputTexture) UiType(VectorText); >;
	float4 g_vInvTexDim < Source(InvTextureDim); SourceArg(g_tInputTexture) UiType(VectorText); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	struct _226
	{
	    float4 _m0[32];
	};
	
	cbuffer FilterTaps_t : register(b2, space1)
	{
	    float4 FilterTaps_t_1_m0 : packoffset(c0);
	    column_major float4x4 FilterTaps_t_1_m1 : packoffset(c2);
	    _226 FilterTaps_t_1_m2 : packoffset(c6);
	};
	
	Texture2D<float4> g_tInputTexture : register(t30, space1);
	SamplerState Filter_MinMagLinearMipPoint : register(s14, space1);
	
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
	    int _22525 = int(FilterTaps_t_1_m0.x);
	    float4 _13155;
	    _13155 = 0.0f.xxxx;
	    float4 _5680;
	    int _18752;
	    int _16208 = 0;
	    [loop]
	    for (;;)
	    {
	        if (!(_16208 < _22525))
	        {
	            break;
	        }
	        _5680 = _13155 + (g_tInputTexture.SampleLevel(Filter_MinMagLinearMipPoint, (input_0 + FilterTaps_t_1_m2._m0[_16208].xy).xy, 0.0f) * FilterTaps_t_1_m2._m0[_16208].z);
	        _18752 = _16208 + 1;
	        _13155 = _5680;
	        _16208 = _18752;
	        continue;
	    }
	    output_0 = mul(FilterTaps_t_1_m1, _13155);
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
