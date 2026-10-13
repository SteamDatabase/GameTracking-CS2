//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Standard shader you should use on everything for now";
	DevShader = false;
	Version = 0;
	
	// Platform: VULKAN_SM_50
	// Programs: ps, vs
}

MODES
{
	Depth("depth_only.vfx");
	ProjectionDepth("depth_only.vfx");
	Forward();
	ToolsWireframe(S_MODE_TOOLS_WIREFRAME);
}

FEATURES
{
	Feature( F_RENDER_BACKFACES, 0..1, "2-Sided Rendering" );
	Feature( F_SPECULAR, 0..1, "Specular" );
	Feature( F_SPECULAR_FRESNEL, 0..1, "Specular" );
}

COMMON
{
	#include "system.fxc"
}

struct VS_INPUT
{
	uint4  nPackedFrame               : NORMAL0    < Semantic( CompressedTangentFrame ); >;        // D_COMPRESSED_NORMALS_AND_TANGENTS=1
	float4 vNormalOs                  : NORMAL0    < Semantic( Normal ); >;                        // D_COMPRESSED_NORMALS_AND_TANGENTS=0
	float3 vPositionOs                : POSITION0  < Semantic( PosXyz ); >;                       
	float4 vTangentUOs_flTangentVSign : TANGENT0   < Semantic( TangentU_SignV ); >;                // D_COMPRESSED_NORMALS_AND_TANGENTS=0
	float2 nInstanceIdx               : TEXCOORD13 < Semantic( InstanceTransformUv ); >;          
};

VS
{
	StaticCombo( S_MODE_TOOLS_WIREFRAME, 0..1 );
	DynamicCombo( D_BLEND_WEIGHT_COUNT, 0..4 );
	DynamicCombo( D_COMPRESSED_NORMALS_AND_TANGENTS, 0..1 );
	DynamicComboRule( Allow0( D_BLEND_WEIGHT_COUNT ) );
	
	[[layer_constant]] StructuredBuffer g_instanceBuffer < Attribute("InstanceBuffer"); >;
	ExternalDescriptorSet g_lightBinnerCpuSet < Source(ExternalDescSet); Attribute("g_lightBinnerCpuSet"); >;
	[[layer_constant]] StructuredBuffer g_transformBuffer < Attribute("TransformBuffer"); >;
	
	// Texture Scrolling
	float g_flNormalTexCoordRotation0 < Range(0, 6.29); UiType(Slider); UiGroup("Texture Scrolling"); >;
	float g_flNormalTexCoordRotation1 < Range(0, 6.29); UiType(Slider); UiGroup("Texture Scrolling"); >;
	float g_flNormalTexCoordRotation2 < Range(0, 6.29); UiType(Slider); UiGroup("Texture Scrolling"); >;
	float g_flNormalTexCoordRotation3 < Range(0, 6.29); UiType(Slider); UiGroup("Texture Scrolling"); >;
	float g_flNormalTexCoordScale0 < Default(1); Range(0, 100); UiType(Slider); UiGroup("Texture Scrolling"); >;
	float g_flNormalTexCoordScale1 < Default(1); Range(0, 100); UiType(Slider); UiGroup("Texture Scrolling"); >;
	float g_flNormalTexCoordScale2 < Default(1); Range(0, 100); UiType(Slider); UiGroup("Texture Scrolling"); >;
	float g_flNormalTexCoordScale3 < Default(1); Range(0, 100); UiType(Slider); UiGroup("Texture Scrolling"); >;
	float g_flNormalTexCoordScrollSpeedX0 < Range(-100, 100); UiType(Slider); UiGroup("Texture Scrolling"); >;
	float g_flNormalTexCoordScrollSpeedX1 < Range(-100, 100); UiType(Slider); UiGroup("Texture Scrolling"); >;
	float g_flNormalTexCoordScrollSpeedX2 < Range(-100, 100); UiType(Slider); UiGroup("Texture Scrolling"); >;
	float g_flNormalTexCoordScrollSpeedX3 < Range(-100, 100); UiType(Slider); UiGroup("Texture Scrolling"); >;
	float g_flNormalTexCoordScrollSpeedY0 < Range(-100, 100); UiType(Slider); UiGroup("Texture Scrolling"); >;
	float g_flNormalTexCoordScrollSpeedY1 < Range(-100, 100); UiType(Slider); UiGroup("Texture Scrolling"); >;
	float g_flNormalTexCoordScrollSpeedY2 < Range(-100, 100); UiType(Slider); UiGroup("Texture Scrolling"); >;
	float g_flNormalTexCoordScrollSpeedY3 < Range(-100, 100); UiType(Slider); UiGroup("Texture Scrolling"); >;
	
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
	    float4 PerViewConstantBuffer_t_1_m1 : packoffset(c17);
	    float PerViewConstantBuffer_t_1_m2 : packoffset(c18.w);
	    float4 PerViewConstantBuffer_t_1_m3 : packoffset(c24);
	};
	
	cbuffer _Globals_ : register(b0, space0)
	{
	    float _Globals_1_g_flNormalTexCoordScale0 : packoffset(c0);
	    float _Globals_1_g_flNormalTexCoordScale1 : packoffset(c0.y);
	    float _Globals_1_g_flNormalTexCoordScale2 : packoffset(c0.z);
	    float _Globals_1_g_flNormalTexCoordScale3 : packoffset(c0.w);
	    float _Globals_1_g_flNormalTexCoordScrollSpeedX0 : packoffset(c1);
	    float _Globals_1_g_flNormalTexCoordScrollSpeedY0 : packoffset(c1.y);
	    float _Globals_1_g_flNormalTexCoordScrollSpeedX1 : packoffset(c1.z);
	    float _Globals_1_g_flNormalTexCoordScrollSpeedY1 : packoffset(c1.w);
	    float _Globals_1_g_flNormalTexCoordScrollSpeedX2 : packoffset(c2);
	    float _Globals_1_g_flNormalTexCoordScrollSpeedY2 : packoffset(c2.y);
	    float _Globals_1_g_flNormalTexCoordScrollSpeedX3 : packoffset(c2.z);
	    float _Globals_1_g_flNormalTexCoordScrollSpeedY3 : packoffset(c2.w);
	    float _Globals_1_g_flNormalTexCoordRotation0 : packoffset(c3);
	    float _Globals_1_g_flNormalTexCoordRotation1 : packoffset(c3.y);
	    float _Globals_1_g_flNormalTexCoordRotation2 : packoffset(c3.z);
	    float _Globals_1_g_flNormalTexCoordRotation3 : packoffset(c3.w);
	};
	
	
	static float4 gl_Position;
	static float gl_ClipDistance[1];
	static float3 vPositionOs;
	static float3 vNormalOs;
	static float4 vTangentUOs_flTangentVSign;
	static uint nInstanceIdx;
	static float3 output_0;
	static float2 output_1;
	static float4 output_2;
	static float4 output_3;
	static float3 output_4;
	static float4 output_5;
	
	struct VS_INPUT
	{
	    float3 vPositionOs : POSITION0;
	    float3 vNormalOs : NORMAL0;
	    float4 vTangentUOs_flTangentVSign : TANGENT0;
	    uint nInstanceIdx : TEXCOORD13;
	};
	
	struct PS_INPUT
	{
	    float3 output_0 : TEXCOORD0;
	    float2 output_1 : TEXCOORD1;
	    float4 output_2 : TEXCOORD2;
	    float4 output_3 : TEXCOORD3;
	    float3 output_4 : TEXCOORD4;
	    float4 output_5 : TEXCOORD5;
	    float4 gl_Position : SV_Position;
	    float gl_ClipDistance0 : SV_ClipDistance0;
	};
	
	void MainVs_inner()
	{
	    float3x4 _9216 = float3x4(g_transformBuffer.Load<float4>(g_instanceBuffer.Load<uint>(nInstanceIdx * 32 + 4) * 48 + 0), g_transformBuffer.Load<float4>(g_instanceBuffer.Load<uint>(nInstanceIdx * 32 + 4) * 48 + 16), g_transformBuffer.Load<float4>(g_instanceBuffer.Load<uint>(nInstanceIdx * 32 + 4) * 48 + 32));
	    float3 _14293 = normalize(mul(_9216, float4(vNormalOs.xyz, 0.0f)));
	    float3 _12861 = mul(_9216, float4(vTangentUOs_flTangentVSign.xyz, 0.0f)).xyz;
	    float3 _24912 = _14293.xyz;
	    float3 _19938 = mul(_9216, float4(vPositionOs.xyz, 1.0f));
	    float4 _18256 = mul(PerViewConstantBuffer_t_1_m0, (float4(_19938.xyz, 1.0f) + (PerViewConstantBuffer_t_1_m3 * 1.0f)).xyzw);
	    float2 _5599 = _19938.xy * 0.004999999888241291046142578125f;
	    float2 _16550 = _5599.xy;
	    float2 _24040 = _16550 + (float2(_Globals_1_g_flNormalTexCoordScrollSpeedX0, _Globals_1_g_flNormalTexCoordScrollSpeedY0) * PerViewConstantBuffer_t_1_m2);
	    float _7952 = cos(_Globals_1_g_flNormalTexCoordRotation0);
	    float _12144 = sin(_Globals_1_g_flNormalTexCoordRotation0);
	    float _11442 = _24040.x;
	    float _6460 = _24040.y;
	    float2 _24041 = _16550 + (float2(_Globals_1_g_flNormalTexCoordScrollSpeedX1, _Globals_1_g_flNormalTexCoordScrollSpeedY1) * PerViewConstantBuffer_t_1_m2);
	    float _7953 = cos(_Globals_1_g_flNormalTexCoordRotation1);
	    float _12145 = sin(_Globals_1_g_flNormalTexCoordRotation1);
	    float _11443 = _24041.x;
	    float _6461 = _24041.y;
	    float2 _24042 = _16550 + (float2(_Globals_1_g_flNormalTexCoordScrollSpeedX2, _Globals_1_g_flNormalTexCoordScrollSpeedY2) * PerViewConstantBuffer_t_1_m2);
	    float _7954 = cos(_Globals_1_g_flNormalTexCoordRotation2);
	    float _12146 = sin(_Globals_1_g_flNormalTexCoordRotation2);
	    float _11444 = _24042.x;
	    float _6462 = _24042.y;
	    float2 _24043 = _16550 + (float2(_Globals_1_g_flNormalTexCoordScrollSpeedX3, _Globals_1_g_flNormalTexCoordScrollSpeedY3) * PerViewConstantBuffer_t_1_m2);
	    float _7955 = cos(_Globals_1_g_flNormalTexCoordRotation3);
	    float _12147 = sin(_Globals_1_g_flNormalTexCoordRotation3);
	    float _11445 = _24043.x;
	    float _6463 = _24043.y;
	    output_0 = _14293;
	    output_1 = _5599;
	    output_2 = float4(float2((_11442 * _7952) + (_6460 * _12144), (_6460 * _7952) - (_11442 * _12144)).xy * _Globals_1_g_flNormalTexCoordScale0.xx.xy, float2((_11443 * _7953) + (_6461 * _12145), (_6461 * _7953) - (_11443 * _12145)).xy * _Globals_1_g_flNormalTexCoordScale1.xx.xy);
	    output_3 = float4(float2((_11444 * _7954) + (_6462 * _12146), (_6462 * _7954) - (_11444 * _12146)).xy * _Globals_1_g_flNormalTexCoordScale2.xx.xy, float2((_11445 * _7955) + (_6463 * _12147), (_6463 * _7955) - (_11445 * _12147)).xy * _Globals_1_g_flNormalTexCoordScale3.xx.xy);
	    output_4 = _19938;
	    output_5 = float4(normalize(_12861 - (_24912 * dot(_12861, _24912))), vTangentUOs_flTangentVSign.w);
	    _18256.y = -_18256.y;
	    gl_Position = _18256;
	    gl_ClipDistance[0] = dot(float4(_19938.xyz, 1.0f), PerViewConstantBuffer_t_1_m1.xyzw);
	}
	
	PS_INPUT MainVs(VS_INPUT stage_input)
	{
	    vPositionOs = stage_input.vPositionOs;
	    vNormalOs = stage_input.vNormalOs;
	    vTangentUOs_flTangentVSign = stage_input.vTangentUOs_flTangentVSign;
	    nInstanceIdx = stage_input.nInstanceIdx;
	    MainVs_inner();
	    PS_INPUT stage_output;
	    stage_output.gl_Position = gl_Position;
	    stage_output.gl_ClipDistance0.x = gl_ClipDistance[0];
	    stage_output.output_0 = output_0;
	    stage_output.output_1 = output_1;
	    stage_output.output_2 = output_2;
	    stage_output.output_3 = output_3;
	    stage_output.output_4 = output_4;
	    stage_output.output_5 = output_5;
	    return stage_output;
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
}

PS
{
	StaticCombo( S_TOOLS_ENABLED, 0, Sys( 1 ) );
	StaticCombo( S_MODE_TOOLS_WIREFRAME, 0..1 );
	StaticCombo( S_SPECULAR, F_SPECULAR );
	StaticCombo( S_SPECULAR_FRESNEL, F_SPECULAR_FRESNEL );
	StaticCombo( S_RENDER_BACKFACES, F_RENDER_BACKFACES );
	StaticComboRule( Allow1( S_MODE_TOOLS_WIREFRAME, S_SPECULAR ) );
	DynamicCombo( D_SUN_SHADOW_CASCADE_SIZE, 0..4 );
	DynamicCombo( D_ALPHATINT, 0..1 );
	DynamicComboRule( Allow1( S_MODE_TOOLS_WIREFRAME, D_SUN_SHADOW_CASCADE_SIZE ) );
	
	RenderState(StencilRef, 1);
	Texture2D g_tColor < Channel(RGB, Box(TextureColor), Srgb); OutputFormat(DXT1); SrgbRead(true); >;
	Texture2D g_tNormal < Channel(AG, MipNormal(TextureNormal), Linear); OutputFormat(DXT5); SrgbRead(false); >;
	Texture2D g_tReflection < Attribute("ReflectionMapTexture"); SrgbRead(true); >;
	
	// Color
	CreateInputTexture2D(TextureColor, Srgb, 8, "", "_color", "Color", Default4(1, 1, 1, 0));
	
	// Normal Map
	CreateInputTexture2D(TextureNormal, Linear, 8, "NormalizeNormals", "_normal", "Normal Map", Default4(0.5, 0.5, 1, 0));
	float g_flBumpStrength < Default(1); Range(0, 10); UiType(Slider); UiGroup("Normal Map"); >;
	
	// Reflection
	float g_flNormalMapStrength < Default(1); Range(0.001, 100); UiType(Slider); UiGroup("Reflection"); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	static float3 _2;
	static float4 _3;
	
	cbuffer PerViewConstantBuffer_t : register(b1, space1)
	{
	    float PerViewConstantBuffer_t_1_m0 : packoffset(c18);
	    float3 PerViewConstantBuffer_t_1_m1 : packoffset(c26);
	    float3 PerViewConstantBuffer_t_1_m2 : packoffset(c31);
	    float PerViewConstantBuffer_t_1_m3 : packoffset(c31.w);
	    float PerViewConstantBuffer_t_1_m4 : packoffset(c32);
	    float PerViewConstantBuffer_t_1_m5 : packoffset(c32.y);
	    float PerViewConstantBuffer_t_1_m6 : packoffset(c32.z);
	};
	
	cbuffer _Globals_ : register(b0, space1)
	{
	    float _Globals_1_g_flBumpStrength : packoffset(c0);
	    float _Globals_1_g_flNormalMapStrength : packoffset(c0.y);
	};
	
	cbuffer ReflectionMapDescriptor_t : register(b4, space1)
	{
	    column_major float4x4 ReflectionMapDescriptor_t_1_m0 : packoffset(c0);
	    float4 ReflectionMapDescriptor_t_1_m1 : packoffset(c4);
	    float4 ReflectionMapDescriptor_t_1_m2 : packoffset(c5);
	};
	
	Texture2D<float4> g_tNormal : register(t32, space1);
	SamplerState DefaultSamplerState_0 : register(s16, space1);
	Texture2D<float4> g_tReflection : register(t30, space1);
	SamplerState AddressU_Clamp_AddressV_Clamp_Filter_MinMagMipLinear : register(s14, space1);
	
	static float3 input_0;
	static float4 input_5;
	static float4 input_2;
	static float4 input_3;
	static float3 input_4;
	static float4 output_0;
	
	struct PS_INPUT
	{
	    float3 input_0 : TEXCOORD0;
	    float4 input_2 : TEXCOORD2;
	    float4 input_3 : TEXCOORD3;
	    float3 input_4 : TEXCOORD4;
	    float4 input_5 : TEXCOORD5;
	};
	
	struct PS_OUTPUT
	{
	    float4 output_0 : SV_Target0;
	};
	
	void MainPs_inner()
	{
	    float2 _7707 = (((((g_tNormal.Sample(DefaultSamplerState_0, input_2.xy) + g_tNormal.Sample(DefaultSamplerState_0, input_2.zw)) + g_tNormal.Sample(DefaultSamplerState_0, input_3.xy)) + g_tNormal.Sample(DefaultSamplerState_0, input_3.zw)) * 0.25f).wy * 2.0f) - 1.0f.xx;
	    float _9481 = _7707.x;
	    float3 _22101;
	    _22101.x = _9481;
	    float _21775 = _7707.y;
	    _22101.y = _21775;
	    float3 _19529 = float3(_9481, _21775, sqrt(saturate(1.0f - dot(_22101.xy, _22101.xy)))).xyz;
	    _19529.y = -_21775;
	    float3 _24157 = _19529.xyz;
	    float2 _11003 = _19529.xy * _Globals_1_g_flBumpStrength;
	    _24157.x = _11003.x;
	    _24157.y = _11003.y;
	    float3 _23712 = normalize(_24157.xyz);
	    float3 _6606 = normalize((((float3(input_5.xyz).xyz * _23712.x).xyz + ((cross(normalize(input_0.xyz).xyz, input_5.xyz) * input_5.w).xyz * _23712.y)).xyz + (input_0.xyz * _23712.z)).xyz).xyz;
	    float4 _19975 = mul(ReflectionMapDescriptor_t_1_m0, float4((input_4.xyz + ((_6606 - (_6606 * dot(ReflectionMapDescriptor_t_1_m1.xyz, _6606))) * _Globals_1_g_flNormalMapStrength)).xyz, 1.0f));
	    float2 _22180 = _19975.xy * (1.0f / _19975.w);
	    float4 _19391 = g_tReflection.Sample(AddressU_Clamp_AddressV_Clamp_Filter_MinMagMipLinear, float2((saturate((_22180.x - (-1.0f)) * 0.5f) * (ReflectionMapDescriptor_t_1_m2.z - ReflectionMapDescriptor_t_1_m2.x)) + ReflectionMapDescriptor_t_1_m2.x, (saturate((_22180.y - 1.0f) * (-0.5f)) * (ReflectionMapDescriptor_t_1_m2.w - ReflectionMapDescriptor_t_1_m2.y)) + ReflectionMapDescriptor_t_1_m2.y).xy);
	    float4 _18900;
	    _18900.x = _19391.x;
	    _18900.y = _19391.y;
	    _18900.z = _19391.z;
	    float3 _19800 = lerp(_18900.xyz, PerViewConstantBuffer_t_1_m2.xyz, saturate(min(PerViewConstantBuffer_t_1_m5, pow(saturate((distance(input_4.xyz, PerViewConstantBuffer_t_1_m1.xyz) * PerViewConstantBuffer_t_1_m4) + PerViewConstantBuffer_t_1_m3), PerViewConstantBuffer_t_1_m6))).xxx);
	    float4 _17842;
	    _17842.x = _19800.x;
	    _17842.y = _19800.y;
	    _17842.z = _19800.z;
	    output_0 = float4(_17842.xyz * PerViewConstantBuffer_t_1_m0, 1.0f);
	}
	
	PS_OUTPUT MainPs(PS_INPUT stage_input)
	{
	    input_0 = stage_input.input_0;
	    input_5 = stage_input.input_5;
	    input_2 = stage_input.input_2;
	    input_3 = stage_input.input_3;
	    input_4 = stage_input.input_4;
	    MainPs_inner();
	    PS_OUTPUT stage_output;
	    stage_output.output_0 = output_0;
	    return stage_output;
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
	
	TextureAttribute(LightSim_DiffuseAlbedoTexture, g_tColor);
	TextureAttribute(RepresentativeTexture, g_tColor);
	BoolAttribute(SupportsMappingDimensions, true);
	BoolAttribute(bNeedsDynamicReflectionMap, true);
	BoolAttribute(bWantsFBCopyTexture, true);
	
}
