//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Tools Generic";
	DevShader = true;
	Version = 0;
	
	// Platform: VULKAN_SM_50
	// Programs: ps, vs
}

MODES
{
	ToolsUtil();
}

FEATURES
{
	Feature( F_TRANSLUCENT, 0..1, "Translucent" );
	Feature( F_ADDITIVE_BLEND, 0..1, "Translucent" );
	Feature( F_RENDER_BACKFACES, 0..1, "2-Sided Rendering" );
	Feature( F_CODE_SUPPLIED_TEXTURE, 0..1, "Color Texture" );
	Feature( F_DISABLE_DEPTH_TEST, 0..1, "Z-Buffering" );
	Feature( F_VERTEX_COLOR_TINT, 0..1, "Enable tinting by vertex color stream" );
	FeatureRule( Requires( F_ADDITIVE_BLEND, F_TRANSLUCENT ), "Requires translucency" );
}

COMMON
{
	#include "system.fxc"
}

struct VS_INPUT
{
	float4 vColor        : COLOR0         < Semantic( Color ); >;                                  // S_VERTEX_COLOR_TINT=1
	float4 vBlendIndices : BLENDINDICES0  < Semantic( BlendIndices ); >;                           // D_BLEND_WEIGHT_COUNT=1, D_BLEND_WEIGHT_COUNT=2, D_BLEND_WEIGHT_COUNT=3, D_BLEND_WEIGHT_COUNT=4
	float4 vBlendWeight  : BLENDWEIGHT0   < Semantic( BlendWeight ); >;                            // D_BLEND_WEIGHT_COUNT=2, D_BLEND_WEIGHT_COUNT=3, D_BLEND_WEIGHT_COUNT=4
	float4 vNormalOs     : NORMAL0        < Semantic( Normal ); >;                                
	float3 vPositionOs   : POSITION0      < Semantic( PosXyz ); >;                                
	float2 vTexCoord     : TEXCOORD0      < Semantic( LowPrecisionUv ); >;                        
	float2 nInstanceIdx  : TEXCOORD13     < Semantic( InstanceTransformUv ); >;                   
};

VS
{
	StaticCombo( S_TRANSLUCENT, F_TRANSLUCENT );
	StaticCombo( S_VERTEX_COLOR_TINT, F_VERTEX_COLOR_TINT );
	DynamicCombo( D_BLEND_WEIGHT_COUNT, 0..4 );
	
	[[layer_constant]] StructuredBuffer g_instanceBuffer < Attribute("InstanceBuffer"); >;
	[[layer_constant]] StructuredBuffer g_transformBuffer < Attribute("TransformBuffer"); >;
	
	// Color
	float2 g_vTexCoordScale < Default2(1, 1); Range2(0, 0, 8, 8); UiType(VectorText); UiGroup("Color/30"); >;
	float2 g_vTexCoordOffset < Range2(-1, -1, 1, 1); UiType(VectorText); UiGroup("Color/40"); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	struct _1125
	{
	    uint _m0;
	    uint _m1;
	    uint _m2;
	    uint _m3;
	    uint _m4;
	    uint _m5;
	    uint _m6;
	    float _m7;
	};
	
	struct _1119
	{
	    row_major float3x4 _m0;
	};
	
	ByteAddressBuffer g_instanceBuffer : register(t32, space0);
	ByteAddressBuffer g_transformBuffer : register(t30, space0);
	cbuffer PerViewConstantBuffer_t : register(b1, space0)
	{
	    column_major float4x4 PerViewConstantBuffer_t_1_m0 : packoffset(c0);
	    float4 PerViewConstantBuffer_t_1_m1 : packoffset(c24);
	};
	
	cbuffer _Globals_ : register(b0, space0)
	{
	    float2 _Globals_1_g_vTexCoordScale : packoffset(c0);
	    float2 _Globals_1_g_vTexCoordOffset : packoffset(c0.z);
	};
	
	
	static float4 gl_Position;
	static float3 vPositionOs;
	static float3 vNormalOs;
	static float2 vTexCoord;
	static uint nInstanceIdx;
	static float3 output_0;
	static float2 output_1;
	
	struct VS_INPUT
	{
	    float3 vPositionOs : POSITION0;
	    float3 vNormalOs : NORMAL0;
	    float2 vTexCoord : TEXCOORD0;
	    uint nInstanceIdx : TEXCOORD13;
	};
	
	struct PS_INPUT
	{
	    float3 output_0 : TEXCOORD0;
	    float2 output_1 : TEXCOORD1;
	    float4 gl_Position : SV_Position;
	};
	
	void MainVs_inner()
	{
	    float3x4 _9558 = float3x4(g_transformBuffer.Load<float4>(g_instanceBuffer.Load<uint>(nInstanceIdx * 32 + 4) * 48 + 0), g_transformBuffer.Load<float4>(g_instanceBuffer.Load<uint>(nInstanceIdx * 32 + 4) * 48 + 16), g_transformBuffer.Load<float4>(g_instanceBuffer.Load<uint>(nInstanceIdx * 32 + 4) * 48 + 32));
	    float4 _17895 = mul(PerViewConstantBuffer_t_1_m0, (float4(mul(_9558, float4(vPositionOs.xyz, 1.0f)).xyz, 1.0f) + (PerViewConstantBuffer_t_1_m1 * 1.0f)).xyzw);
	    output_0 = normalize(mul(_9558, float4(vNormalOs.xyz, 0.0f)));
	    output_1 = (vTexCoord.xy * _Globals_1_g_vTexCoordScale.xy) + _Globals_1_g_vTexCoordOffset.xy;
	    _17895.y = -_17895.y;
	    gl_Position = _17895;
	}
	
	PS_INPUT MainVs(VS_INPUT stage_input)
	{
	    vPositionOs = stage_input.vPositionOs;
	    vNormalOs = stage_input.vNormalOs;
	    vTexCoord = stage_input.vTexCoord;
	    nInstanceIdx = stage_input.nInstanceIdx;
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
	StaticCombo( S_CODE_SUPPLIED_TEXTURE, F_CODE_SUPPLIED_TEXTURE );
	StaticCombo( S_TRANSLUCENT, F_TRANSLUCENT );
	StaticCombo( S_RENDER_BACKFACES, F_RENDER_BACKFACES );
	StaticCombo( S_VERTEX_COLOR_TINT, F_VERTEX_COLOR_TINT );
	
	RenderState(BlendEnable, true);
	RenderState(DepthFunc, F_DISABLE_DEPTH_TEST ? Always : Less);
	RenderState(DepthWriteEnable, false);
	RenderState(DstBlend, F_ADDITIVE_BLEND ? One : InvSrcAlpha);
	Texture2D g_tCodeSuppliedColor < Attribute("ColorTexture"); SrgbRead(false); >;
	Texture2D g_tColor < Channel(RGB, Box(TextureColor), Srgb); OutputFormat(DXT1); SrgbRead(true); >;
	Texture2D g_tColor < Channel(RGB, Box(TextureColor), Srgb); Channel(A, Box(TextureTranslucency), Linear); OutputFormat(DXT5); SrgbRead(true); >;
	
	// Color
	CreateInputTexture2D(TextureColor, Srgb, 8, "", "_color", "Color/10", Default4(1, 1, 1, 0));
	float3 g_vColorTint < Default3(1, 1, 1); UiType(Color); UiGroup("Color,10/20"); >;
	
	// Translucent
	CreateInputTexture2D(TextureTranslucency, Linear, 8, "", "_trans", "Translucent", Default4(1, 1, 1, 0));
	float g_flOpacityScale < Default(1); UiType(Slider); UiGroup("Translucent"); >;
	
	
	// Variant parameters
	Texture2D g_tColor < Channel(RGB, Box(TextureColor), Srgb); OutputFormat(DXT1); SrgbRead(true); >;
	Texture2D g_tColor < Channel(RGB, Box(TextureColor), Srgb); Channel(A, Box(TextureTranslucency), Linear); OutputFormat(DXT5); SrgbRead(true); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	cbuffer _Globals_ : register(b0, space1)
	{
	    float3 _Globals_1_g_vColorTint : packoffset(c0);
	};
	
	Texture2D<float4> g_tColor : register(t30, space1);
	SamplerState DefaultSamplerState_0 : register(s14, space1);
	
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
	    output_0 = float4(g_tColor.Sample(DefaultSamplerState_0, input_1.xy).xyz * _Globals_1_g_vColorTint.xyz, 1.0f);
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
	
	
	#if (S_TRANSLUCENT == 1)
		BoolAttribute(translucent, true);
	#endif
}
