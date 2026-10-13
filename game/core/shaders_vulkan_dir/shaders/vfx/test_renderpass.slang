//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Used for rendersystemtest renderpass test";
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
	float3 vPositionSs : POSITION0  < Semantic( PosXyz ); >;                                      
	float2 vTexCoord   : TEXCOORD0  < Semantic( LowPrecisionUv ); >;                              
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
	static float2 vPositionSs;
	static float4 vColor;
	static float2 vTexCoord;
	static float4 output_0;
	static float2 output_1;
	
	struct VS_INPUT
	{
	    float2 vPositionSs : POSITION0;
	    float4 vColor : COLOR0;
	    float2 vTexCoord : TEXCOORD0;
	};
	
	struct PS_INPUT
	{
	    float4 output_0 : TEXCOORD0;
	    float2 output_1 : TEXCOORD1;
	    float4 gl_Position : SV_Position;
	};
	
	void MainVs_inner()
	{
	    float2 _15639 = (((vPositionSs.xy - _Globals_1_g_vViewport.xy) * 2.0f) / _Globals_1_g_vViewport.zw) - 1.0f.xx;
	    float4 _14437 = float4(_15639.x, _2, 1.0f, 1.0f);
	    output_0 = vColor;
	    output_1 = vTexCoord;
	    _14437.y = _15639.y;
	    gl_Position = _14437;
	}
	
	PS_INPUT MainVs(VS_INPUT stage_input)
	{
	    vPositionSs = stage_input.vPositionSs;
	    vColor = stage_input.vColor;
	    vTexCoord = stage_input.vTexCoord;
	    MainVs_inner();
	    PS_INPUT stage_output;
	    stage_output.gl_Position = gl_Position;
	    stage_output.output_0 = output_0;
	    stage_output.output_1 = output_1;
	    return stage_output;
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
	
	BoolAttribute(ScreenSpaceVertices, true);
	
}

PS
{
	DynamicCombo( D_RENDER_PASS, 0..2 );
	
	Texture2D g_tColor < Channel(RGBA, None(Texture), Srgb); OutputFormat(DXT5); SrgbRead(true); >;
	Texture2D g_tGBufferAlbedo < Attribute("GBufferAlbedo"); SrgbRead(false); >;
	Texture2D g_tGBufferDepth < Attribute("GBufferDepth"); SrgbRead(false); >;
	Texture2D g_tGBufferLightingTerms < Attribute("GBufferLightingTerms"); SrgbRead(false); >;
	Texture2D g_tGBufferNormalWs < Attribute("GBufferNormalWs"); SrgbRead(false); >;
	
	// Color
	CreateInputTexture2D(Texture, Srgb, 8, "", "", "Color", Default4(1, 1, 1, 0));
	
	
	// Variant parameters
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	Texture2D<float4> g_tColor : register(t30, space1);
	SamplerState Filter_MinMagMipPoint : register(s14, space1);
	
	static float2 input_1;
	static float4 output_0;
	static float4 output_1;
	static float4 output_2;
	static float4 output_3;
	
	struct PS_INPUT
	{
	    float2 input_1 : TEXCOORD1;
	};
	
	struct PS_OUTPUT
	{
	    float4 output_0 : SV_Target0;
	    float4 output_1 : SV_Target1;
	    float4 output_2 : SV_Target2;
	    float4 output_3 : SV_Target3;
	};
	
	void MainPs_inner()
	{
	    float4 _3300 = g_tColor.Sample(Filter_MinMagMipPoint, input_1.xy);
	    output_0 = float4(_3300.x, 0.0f, 0.0f, 1.0f);
	    output_1 = float4(0.0f, _3300.y, 0.0f, 1.0f);
	    output_2 = _3300.xxxx;
	    output_3 = float4(0.0f, 0.0f, _3300.z, 1.0f);
	}
	
	PS_OUTPUT MainPs(PS_INPUT stage_input)
	{
	    input_1 = stage_input.input_1;
	    MainPs_inner();
	    PS_OUTPUT stage_output;
	    stage_output.output_0 = output_0;
	    stage_output.output_1 = output_1;
	    stage_output.output_2 = output_2;
	    stage_output.output_3 = output_3;
	    return stage_output;
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
	
	TextureAttribute(RepresentativeTexture, g_tColor);
	
}
