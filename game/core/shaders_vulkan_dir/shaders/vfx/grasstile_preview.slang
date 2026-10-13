//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Standard shader for all non-blend surfaces";
	DevShader = false;
	Version = 0;
	
	// Platform: VULKAN_SM_50
	// Programs: ps, vs
}

MODES
{
	Forward();
}

FEATURES
{
	Feature( F_DISABLE_TEXTURE_MIRRORING, 0..1, "Disable Texture Mirroring" );
}

COMMON
{
	#include "system.fxc"
}

struct VS_INPUT
{
	float4 vPositionOs   : POSITION0      < Semantic( PosXy ); >;                                 
	uint4  nPackedFrame  : NORMAL0        < Semantic( CompressedTangentFrame ); >;                
	float4 vBlendIndices : BLENDINDICES0  < Semantic( BlendIndices ); >;                          
	float4 vBlendWeight  : BLENDWEIGHT0   < Semantic( BlendWeight ); >;                           
	float4 vNormalOs     : NORMAL0        < Semantic( Normal ); >;                                
	float3 vPositionOs   : POSITION0      < Semantic( PosXyz ); >;                                
	float2 vTexCoord     : TEXCOORD0      < Semantic( LowPrecisionUv ); >;                        
	float2 nInstanceIdx  : TEXCOORD13     < Semantic( InstanceTransformUv ); >;                   
};

VS
{
	DynamicCombo( D_BLEND_WEIGHT_COUNT, 0..4 );
	DynamicCombo( D_COMPRESSED_NORMALS_AND_TANGENTS, 0..1 );
	DynamicCombo( D_BAKE_GRASS, 0..1 );
	
	[[layer_constant]] StructuredBuffer g_instanceBuffer < Attribute("InstanceBuffer"); >;
	[[layer_constant]] StructuredBuffer g_transformBuffer < Attribute("TransformBuffer"); >;
	
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
	cbuffer PerViewConstantBuffer_t : register(b0, space0)
	{
	    column_major float4x4 PerViewConstantBuffer_t_1_m0 : packoffset(c0);
	    float4 PerViewConstantBuffer_t_1_m1 : packoffset(c24);
	};
	
	
	static float4 gl_Position;
	static float3 vPositionOs;
	static float2 vTexCoord;
	static float3 vNormalOs;
	static uint nInstanceIdx;
	static float3 output_0;
	static float2 output_1;
	static float3 output_2;
	
	struct VS_INPUT
	{
	    float3 vPositionOs : POSITION0;
	    float2 vTexCoord : TEXCOORD0;
	    float3 vNormalOs : NORMAL0;
	    uint nInstanceIdx : TEXCOORD13;
	};
	
	struct PS_INPUT
	{
	    float3 output_0 : TEXCOORD0;
	    float2 output_1 : TEXCOORD1;
	    float3 output_2 : TEXCOORD2;
	    float4 gl_Position : SV_Position;
	};
	
	void MainVs_inner()
	{
	    float3x4 _6463 = float3x4(g_transformBuffer.Load<float4>(g_instanceBuffer.Load<uint>(nInstanceIdx * 32 + 4) * 48 + 0), g_transformBuffer.Load<float4>(g_instanceBuffer.Load<uint>(nInstanceIdx * 32 + 4) * 48 + 16), g_transformBuffer.Load<float4>(g_instanceBuffer.Load<uint>(nInstanceIdx * 32 + 4) * 48 + 32));
	    float3 _19956 = mul(_6463, float4(vPositionOs.xyz, 1.0f));
	    float4 _17914 = mul(PerViewConstantBuffer_t_1_m0, (float4(_19956.xyz, 1.0f) + (PerViewConstantBuffer_t_1_m1 * 1.0f)).xyzw);
	    output_0 = normalize(mul(_6463, float4(vNormalOs.xyz, 0.0f)));
	    output_1 = vTexCoord;
	    output_2 = _19956;
	    _17914.y = -_17914.y;
	    gl_Position = _17914;
	}
	
	PS_INPUT MainVs(VS_INPUT stage_input)
	{
	    vPositionOs = stage_input.vPositionOs;
	    vTexCoord = stage_input.vTexCoord;
	    vNormalOs = stage_input.vNormalOs;
	    nInstanceIdx = stage_input.nInstanceIdx;
	    MainVs_inner();
	    PS_INPUT stage_output;
	    stage_output.gl_Position = gl_Position;
	    stage_output.output_0 = output_0;
	    stage_output.output_1 = output_1;
	    stage_output.output_2 = output_2;
	    return stage_output;
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
}

PS
{
	StaticCombo( S_TOOLS_ENABLED, 0, Sys( 1 ) );
	StaticCombo( S_DISABLE_TEXTURE_MIRRORING, F_DISABLE_TEXTURE_MIRRORING );
	DynamicCombo( D_BAKE_GRASS, 0..1 );
	
	Texture2D g_tColor < Channel(RGB, AlphaWeighted(TextureColor, TextureTranslucency), Srgb); Channel(A, Box(TextureTranslucency), Linear); OutputFormat(DXT5); SrgbRead(true); >;
	
	// Color
	CreateInputTexture2D(TextureColor, Srgb, 8, "", "_color", "Color/10", Default4(1, 1, 1, 0));
	float3 g_vColorTint < Default3(1, 1, 1); UiType(Color); UiGroup("Color,10/20"); Expression(SrgbGammaToLinear(this)); >;
	
	// Translucent
	CreateInputTexture2D(TextureTranslucency, Linear, 8, "", "_trans", "Translucent", Default4(1, 1, 1, 0));
	
	// GrassSize
	float g_flGrassWidth < Default(35); Range(1, 256); UiType(Slider); UiGroup("GrassSize/10"); >;
	float g_flGrassHeightMin < Default(35); Range(1, 256); UiType(Slider); UiGroup("GrassSize/20"); >;
	float g_flGrassHeightMax < Default(55); Range(1, 256); UiType(Slider); UiGroup("GrassSize/30"); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	static float4 _3;
	
	cbuffer _Globals_ : register(b0, space1)
	{
	    float3 _Globals_1_g_vColorTint : packoffset(c0);
	};
	
	cbuffer RoughnessLightingGlobalsCB_t : register(b2, space1)
	{
	    float4 RoughnessLightingGlobalsCB_t_1_m0 : packoffset(c0);
	};
	
	cbuffer SunLightShaderParamsCB_t : register(b3, space1)
	{
	    float3 SunLightShaderParamsCB_t_1_m0 : packoffset(c0);
	    float3 SunLightShaderParamsCB_t_1_m1 : packoffset(c1);
	};
	
	Texture2D<float4> g_tColor : register(t30, space1);
	SamplerState DefaultSamplerState_0 : register(s14, space1);
	
	static bool gl_FrontFacing;
	static float3 input_0;
	static float2 input_1;
	static float4 output_0;
	
	struct PS_INPUT
	{
	    float3 input_0 : TEXCOORD0;
	    float2 input_1 : TEXCOORD1;
	    bool gl_FrontFacing : SV_IsFrontFace;
	};
	
	struct PS_OUTPUT
	{
	    float4 output_0 : SV_Target0;
	};
	
	void MainPs_inner()
	{
	    float4 _3300 = g_tColor.Sample(DefaultSamplerState_0, input_1.xy);
	    float3 _13062 = _3300.xyz * _Globals_1_g_vColorTint.xyz;
	    float4 _23714;
	    _23714.x = _13062.x;
	    _23714.y = _13062.y;
	    _23714.z = _13062.z;
	    float3 _14744 = normalize((input_0.xyz * (gl_FrontFacing ? 1.0f : (-1.0f))).xyz).xyz;
	    float3 _23378 = clamp(_14744, 0.0f.xxx, 1.0f.xxx);
	    float3 _23904 = clamp(-_14744, 0.0f.xxx, 1.0f.xxx);
	    output_0 = float4(((RoughnessLightingGlobalsCB_t_1_m0.xyz * (dot(float3(0.60000002384185791015625f, 0.4000000059604644775390625f, 1.0f), _23378 * _23378) + dot(float3(0.60000002384185791015625f, 0.4000000059604644775390625f, 0.20000000298023223876953125f), _23904 * _23904))).xyz + ((SunLightShaderParamsCB_t_1_m0.xyz * (pow(saturate(dot(_14744, SunLightShaderParamsCB_t_1_m1.xyz)), 0.60000002384185791015625f) * 0.800000011920928955078125f)) * 1.0f)).xyz * _23714.xyz, _3300.w);
	}
	
	PS_OUTPUT MainPs(PS_INPUT stage_input)
	{
	    gl_FrontFacing = stage_input.gl_FrontFacing;
	    input_0 = stage_input.input_0;
	    input_1 = stage_input.input_1;
	    MainPs_inner();
	    PS_OUTPUT stage_output;
	    stage_output.output_0 = output_0;
	    return stage_output;
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
	
	BoolAttribute(translucent, true);
	TextureAttribute(RepresentativeTexture, g_tColor);
	FloatAttribute(GrassWidth, g_flGrassWidth);
	FloatAttribute(GrassHeightMin, g_flGrassHeightMin);
	FloatAttribute(GrassHeightMax, g_flGrassHeightMax);
	
	#if (S_TOOLS_ENABLED == 0)
		BoolAttribute(GrassNoMirroring, true);
	#endif
	#if (S_DISABLE_TEXTURE_MIRRORING == 1)
		BoolAttribute(GrassNoMirroring, true);
	#endif
}
