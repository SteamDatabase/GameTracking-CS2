//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Used to draw UI elements";
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
	Feature( F_ASPECT_FILL_FROM_CENTER, 0..1, "Aspect Fill" );
	Feature( F_TRANSLUCENT, 0..1, "Translucent" );
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
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	static float _2;
	
	static float4 gl_Position;
	static float3 vPositionSs;
	static float4 vColor;
	static float2 vTexCoord;
	static float4 output_0;
	static float2 output_1;
	
	struct VS_INPUT
	{
	    float3 vPositionSs : POSITION0;
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
	    float4 _14437 = float4(vPositionSs.x, _2, 1.0f, 1.0f);
	    output_0 = vColor;
	    output_1 = vTexCoord;
	    _14437.y = vPositionSs.y;
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
	
	
}

PS
{
	StaticCombo( S_ASPECT_FILL_FROM_CENTER, F_ASPECT_FILL_FROM_CENTER );
	StaticCombo( S_TRANSLUCENT, F_TRANSLUCENT );
	
	Texture2D g_tColor < Channel(RGB, Box(TextureColor), Srgb); OutputFormat(DXT1); SrgbRead(true); >;
	Texture2D g_tColor < Channel(RGBA, Box(TextureColor), Srgb); OutputFormat(DXT5); SrgbRead(true); >;
	float4 g_vViewport < Source(Viewport); UiType(VectorText); >;
	
	// Color
	CreateInputTexture2D(TextureColor, Srgb, 8, "", "_color", "Color", Default4(1, 1, 1, 1));
	
	// Aspect Fill
	float2 g_vImageAspectRatio < Default2(16, 9); Range2(1, 1, 16, 16); UiType(VectorText); UiGroup("Aspect Fill"); >;
	
	#if (S_TRANSLUCENT == 1)
		Texture2D g_tColor < Channel(RGBA, Box(TextureColor), Srgb); OutputFormat(DXT5); SrgbRead(true); >;
	#endif
	
	// Variant parameters
	Texture2D g_tColor < Channel(RGB, Box(TextureColor), Srgb); OutputFormat(DXT1); SrgbRead(true); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	Texture2D<float4> g_tColor : register(t30, space1);
	SamplerState DefaultSamplerState_0 : register(s14, space1);
	
	static float2 input_1;
	static float4 input_0;
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
	    output_0 = input_0.xyzw * g_tColor.Sample(DefaultSamplerState_0, input_1.xy);
	}
	
	PS_OUTPUT MainPs(PS_INPUT stage_input)
	{
	    input_1 = stage_input.input_1;
	    input_0 = stage_input.input_0;
	    MainPs_inner();
	    PS_OUTPUT stage_output;
	    stage_output.output_0 = output_0;
	    return stage_output;
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
	
	TextureAttribute(RepresentativeTexture, g_tColor);
	
}
