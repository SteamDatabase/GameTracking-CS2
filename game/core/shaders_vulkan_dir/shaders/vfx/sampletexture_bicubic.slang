//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Shader that scales input texture using bicubic filtering";
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
	Feature( F_INVERT_ALPHA, 0..1, "Blending" );
	FeatureRule( Requires( F_INVERT_ALPHA, F_ALPHA_BLEND ), "Inverted alpha requires alpha blend" );
}

COMMON
{
	#include "system.fxc"
}

VS
{
	
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
	StaticCombo( S_ALPHA_BLEND, F_ALPHA_BLEND );
	StaticCombo( S_ADDITIVE_BLENDING, F_ADDITIVE_BLENDING );
	DynamicCombo( D_SRGBREADINPUT, 0..1 );
	DynamicCombo( D_CLAMPTEXTURECOORDS, 0..1 );
	DynamicCombo( D_DISABLE_ALPHA_WRITE, 0..1 );
	
	RenderState(BlendEnable, (F_ADDITIVE_BLENDING || F_ALPHA_BLEND) ? true : false);
	RenderState(ColorWriteEnable0, R|G|B);
	RenderState(DstBlend, F_ADDITIVE_BLENDING ? One : Zero);
	RenderState(DstBlend, F_INVERT_ALPHA ? SrcAlpha : InvSrcAlpha);
	RenderState(SrcBlend, One);
	Texture2D g_tInputTexture < Attribute("inputTexture"); SrgbRead(false); >;
	Texture2D g_tInputTexture < Attribute("inputTexture"); SrgbRead(true); >;
	
	#if (S_ALPHA_BLEND == 0)
		Texture2D g_tInputTexture < Attribute("inputTexture"); SrgbRead(false); >;
		Texture2D g_tInputTexture < Attribute("inputTexture"); SrgbRead(true); >;
	#endif
	#if (S_ALPHA_BLEND == 1)
		Texture2D g_tInputTexture < Attribute("inputTexture"); SrgbRead(false); >;
		Texture2D g_tInputTexture < Attribute("inputTexture"); SrgbRead(true); >;
		RenderState(DstBlend, F_INVERT_ALPHA ? SrcAlpha : InvSrcAlpha);
	#endif
	
	// Variant parameters
	RenderState(DstBlend, F_ADDITIVE_BLENDING ? One : Zero);
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
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
	
	uint2 spvTextureSize(Texture2D<float4> Tex, uint Level, out uint Param)
	{
	    uint2 ret;
	    Tex.GetDimensions(Level, ret.x, ret.y, Param);
	    return ret;
	}
	
	void MainPs_inner()
	{
	    uint _10352_dummy_parameter;
	    uint2 _10352 = spvTextureSize(g_tInputTexture, 0u, _10352_dummy_parameter);
	    float2 _15674 = float2(int2(int(_10352.x), int(_10352.y)));
	    float2 _18768 = 1.0f.xx / _15674;
	    float2 _13560 = (input_0 * _15674) - 0.5f.xx;
	    float2 _11204 = floor(_13560);
	    float2 _24976 = _13560 - _11204;
	    float _9202 = _24976.x;
	    float _14786 = _9202 * _9202;
	    float4 _23690 = mul(float4(_14786 * _9202, _14786, _9202, 1.0f), float4x4(float4(-0.16666667163372039794921875f, 0.5f, -0.5f, 0.16666667163372039794921875f), float4(0.5f, -1.0f, 0.5f, 0.0f), float4(-0.5f, 0.0f, 0.5f, 0.0f), float4(0.16666667163372039794921875f, 0.666666686534881591796875f, 0.16666667163372039794921875f, 0.0f)));
	    float _24741 = _24976.y;
	    float _13163 = _24741 * _24741;
	    float4 _22702 = mul(float4(_13163 * _24741, _13163, _24741, 1.0f), float4x4(float4(-0.16666667163372039794921875f, 0.5f, -0.5f, 0.16666667163372039794921875f), float4(0.5f, -1.0f, 0.5f, 0.0f), float4(-0.5f, 0.0f, 0.5f, 0.0f), float4(0.16666667163372039794921875f, 0.666666686534881591796875f, 0.16666667163372039794921875f, 0.0f)));
	    float2 _11358 = float2(_23690.y, _22702.y);
	    float2 _23036 = float2(_23690.w, _22702.w);
	    float2 _22452 = float2(_23690.x, _22702.x) + _11358;
	    float2 _15076 = (_11358 / _22452) - 1.0f.xx;
	    float2 _14303 = (_23036 / (float2(_23690.z, _22702.z) + _23036)) + 1.0f.xx;
	    float4 _17001 = _22452.y.xxxx;
	    output_0 = lerp(lerp(g_tInputTexture.SampleLevel(Filter_MinMagLinearMipPoint, (((_11204 + _14303) + 0.5f.xx) * _18768).xy, 0.0f), g_tInputTexture.SampleLevel(Filter_MinMagLinearMipPoint, (((_11204 + float2(_14303.x, _15076.y)) + 0.5f.xx) * _18768).xy, 0.0f), _17001), lerp(g_tInputTexture.SampleLevel(Filter_MinMagLinearMipPoint, (((_11204 + float2(_15076.x, _14303.y)) + 0.5f.xx) * _18768).xy, 0.0f), g_tInputTexture.SampleLevel(Filter_MinMagLinearMipPoint, (((_11204 + _15076) + 0.5f.xx) * _18768).xy, 0.0f), _17001), _22452.x.xxxx);
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
