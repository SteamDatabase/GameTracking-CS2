//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Simple 2-way blending shader";
	DevShader = false;
	Version = 1;
	
	// Platform: VULKAN_SM_60
	// Programs: ps, vs, rtx, psrs
}

MODES
{
	CsgoForward();
	RayTrace();
	Depth("csgo_depth_only.vfx");
	ToolsVis(S_MODE_TOOLS_VIS);
	ToolsWireframe("csgo_tools_wireframe.vfx");
	ToolsShadingComplexity("csgo_tools_shading_complexity.vfx");
}

FEATURES
{
	Feature( F_DO_NOT_CAST_SHADOWS, 0..1, "Shadows" );
	Feature( F_RENDER_BACKFACES, 0..1, "2-Sided Rendering" );
	Feature( F_DONT_FLIP_BACKFACE_NORMALS, 0..1, "2-Sided Rendering" );
	Feature( F_DISABLE_Z_BUFFERING, 0..1, "Z-Buffering" );
	Feature( F_DISABLE_Z_PREPASS, 0..1, "Z-Prepass" );
	Feature( F_ENABLE_TINT_MASKS, 0..1, "Enable Tint Masks" );
	Feature( F_ENABLE_AMBIENT_OCCLUSION, 0..1, "Enable Ambient Occlusion" );
	Feature( F_PAINT_VERTEX_COLORS, 0..1, "Vertex Color" );
	FeatureRule( Requires( F_DONT_FLIP_BACKFACE_NORMALS, F_RENDER_BACKFACES ), "Only applies to backfaces" );
}

COMMON
{
	#include "system.fxc"
}

struct VS_INPUT
{
	float4 vBlendIndices              : BLENDINDICES0  < Semantic( BlendIndices ); >;              // D_CS_VERTEX_ANIMATION=0, S_MODE_TOOLS_VIS=1
	float4 vBlendColorTint            : COLOR0         < Semantic( VertexPaintTintColor ); >;      // S_PAINT_VERTEX_COLORS=1
	float4 vPerVertexLighting         : COLOR1         < Semantic( PerVertexLighting ); >;         // D_BAKED_LIGHTING_FROM_VERTEX_STREAM=1
	uint4  nPackedFrame               : NORMAL0        < Semantic( CompressedTangentFrame ); >;   
	float4 vNormalOs                  : NORMAL0        < Semantic( Normal ); >;                   
	float3 vPositionOs                : POSITION0      < Semantic( PosXyz ); >;                    // D_CS_VERTEX_ANIMATION=0
	float2 vLightmapUV                : TEXCOORD3      < Semantic( LightmapUV ); >;                // D_BAKED_LIGHTING_FROM_LIGHTMAP=1
	float4 vTangentUOs_flTangentVSign : TANGENT0       < Semantic( TangentU_SignV ); >;           
	float2 vTexCoord                  : TEXCOORD0      < Semantic( LowPrecisionUv ); >;           
	float4 vBlendValues               : TEXCOORD4      < Semantic( VertexPaintBlendParams ); >;   
	float2 nInstanceIdx               : TEXCOORD13     < Semantic( InstanceTransformUv ); >;      
};

VS
{
	StaticCombo( S_MODE_TOOLS_VIS, 0..1 );
	StaticCombo( S_PAINT_VERTEX_COLORS, F_PAINT_VERTEX_COLORS );
	DynamicCombo( D_COMPRESSED_NORMALS_AND_TANGENTS, 0..1 );
	DynamicCombo( D_CS_VERTEX_ANIMATION, 0..1 );
	DynamicCombo( D_BAKED_LIGHTING_FROM_VERTEX_STREAM, 0..1 );
	DynamicCombo( D_BAKED_LIGHTING_FROM_LIGHTMAP, 0..1 );
	DynamicComboRule( Allow1( D_BAKED_LIGHTING_FROM_VERTEX_STREAM, D_BAKED_LIGHTING_FROM_LIGHTMAP ) );
	
	ByteAddressBuffer g_animatedVertexCache < Attribute("AnimatedVertexCache"); >;
	bool g_bTexCoordScaleByModel < UiType(CheckBox); Expression(g_nScaleTexCoordUByModelScaleAxis!=0 || g_nScaleTexCoordVByModelScaleAxis!=0); >;
	[[layer_constant]] ExternalDescriptorSet g_globalLateBoundBindlessSet < Source(ExternalDescSet); Attribute("g_globalLateBoundBindlessSet"); >;
	[[layer_constant]] StructuredBuffer g_instanceBuffer < Attribute("InstanceBuffer"); >;
	[[layer_constant]] ExternalDescriptorSet g_lightBinnerGpuSet < Source(ExternalDescSet); Attribute("g_lightBinnerGpuSet"); >;
	[[layer_constant]] StructuredBuffer g_transformBuffer < Attribute("TransformBuffer"); >;
	float4 g_vTexCoordScaleByModelU < UiType(VectorText); Expression(float4((g_nScaleTexCoordUByModelScaleAxis==1) ? 1 : 0,(g_nScaleTexCoordUByModelScaleAxis==2) ? 1 : 0,(g_nScaleTexCoordUByModelScaleAxis==3) ? 1 : 0,(g_nScaleTexCoordUByModelScaleAxis==0) ? 1 : 0)); >;
	float4 g_vTexCoordScaleByModelV < UiType(VectorText); Expression(float4((g_nScaleTexCoordVByModelScaleAxis==1) ? 1 : 0,(g_nScaleTexCoordVByModelScaleAxis==2) ? 1 : 0,(g_nScaleTexCoordVByModelScaleAxis==3) ? 1 : 0,(g_nScaleTexCoordVByModelScaleAxis==0) ? 1 : 0)); >;
	float4 g_vTexCoordXform0 < UiType(VectorText); Expression(v0 = g_flTexCoordRotation*3.1415927/180;
		v1 = cos(v0);
		v2 = sin(v0);
		float4(v1*g_vTexCoordScale.x,-v2*g_vTexCoordScale.y,0,g_vTexCoordCenter.x+g_vTexCoordOffset.x+v2*g_vTexCoordCenter.y-v1*g_vTexCoordCenter.x)); >;
	float4 g_vTexCoordXform1 < UiType(VectorText); Expression(v0 = g_flTexCoordRotation*3.1415927/180;
		v1 = cos(v0);
		v2 = sin(v0);
		float4(v2*g_vTexCoordScale.x,v1*g_vTexCoordScale.y,0,g_vTexCoordCenter.y+g_vTexCoordOffset.y-(v2*g_vTexCoordCenter.x+v1*g_vTexCoordCenter.y))); >;
	
	// Color
	float3 g_vColorTint < Default3(1, 1, 1); UiType(Color); UiGroup("Color,10/20"); Expression(SrgbGammaToLinear(this)); >;
	float g_flModelTintAmount < Default(1); UiType(Slider); UiGroup("Color,10/30"); >;
	float2 g_vTexCoordCenter < Default2(0.5, 0.5); UiType(VectorText); UiGroup("Color/30"); >;
	float2 g_vTexCoordScale < Default2(1, 1); Range2(0, 0, 100, 100); UiType(VectorText); UiGroup("Color/40"); >;
	float g_flTexCoordRotation < Range(-360, 360); UiType(Slider); UiGroup("Color/50"); >;
	float2 g_vTexCoordOffset < Range2(-1, -1, 1, 1); UiType(VectorText); UiGroup("Color/60"); >;
	float2 g_vTexCoordScrollSpeed < Range2(-10, -10, 10, 10); UiType(VectorText); UiGroup("Color/70"); >;
	int g_nScaleTexCoordUByModelScaleAxis < Range4(0, 0, 0, 0, 3, 3, 3, 3); UiOptions("0=None,1=UV.u * model.x,2=UV.u * model.y,3=UV.u * model.z"); UiType(Enum); UiGroup("Color/80"); >;
	int g_nScaleTexCoordVByModelScaleAxis < Range4(0, 0, 0, 0, 3, 3, 3, 3); UiOptions("0=None,1=UV.v * model.x,2=UV.v * model.y,3=UV.v * model.z"); UiType(Enum); UiGroup("Color/90"); >;
	
	// SPIR-V reflection failed for backend HLSL:
	// cbuffer ID 5618 (name: _Globals_), member index 0 (name: g_vTexCoordXform0) cannot be expressed with either HLSL packing layout or packoffset.
	//
	// Re-attempting reflection with the GLSL backend.
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, GLSL reflection with SPIRV-Cross by KhronosGroup
	
	#version 460
	
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
	    mat3x4 _m0;
	};
	
	layout(set = 4, binding = 32, std430) readonly buffer g_instanceBuffer
	{
	    _1125 _m0[];
	} g_instanceBuffer_1;
	
	layout(set = 4, binding = 30, std430) readonly buffer g_transformBuffer
	{
	    _1119 _m0[];
	} g_transformBuffer_1;
	
	struct _1260
	{
	    mat4 _m0;
	    float _m1;
	    vec4 _m2;
	};
	
	layout(set = 0) uniform _1260 PerViewConstantBuffer_t;
	
	struct _1234
	{
	    vec4 g_vTexCoordXform0;
	    vec4 g_vTexCoordXform1;
	    vec2 g_vTexCoordScrollSpeed;
	    vec3 g_vColorTint;
	    float g_flModelTintAmount;
	};
	
	layout(set = 0) uniform _1234 _Globals_;
	
	struct _1017
	{
	    vec4 _m0;
	};
	
	layout(set = 0) uniform _1017 PerViewConstantBufferCsgo_t;
	
	layout(location = 0) in vec3 vPositionOs;
	layout(location = 1) in vec2 vTexCoord;
	layout(location = 2) in vec3 vNormalOs;
	layout(location = 3) in vec4 vTangentUOs_flTangentVSign;
	layout(location = 4) in uvec4 vBlendIndices;
	layout(location = 5) in uint nInstanceIdx;
	layout(location = 6) in vec4 vBlendValues;
	layout(location = 0) out vec4 output_0;
	layout(location = 1) out vec3 output_1;
	layout(location = 2) out vec3 output_2;
	layout(location = 3) out vec4 output_3;
	layout(location = 4) centroid out vec4 output_4;
	layout(location = 5) centroid out vec3 output_5;
	layout(location = 6) out vec4 output_6;
	layout(location = 7) flat out uint output_7;
	
	void main()
	{
	    uint _13771 = (g_instanceBuffer_1._m0[nInstanceIdx]._m5 >> uint(16)) & 15u;
	    uint _21785;
	    if (_13771 == 1u)
	    {
	        _21785 = g_instanceBuffer_1._m0[nInstanceIdx]._m1 + (2u + vBlendIndices.x);
	    }
	    else
	    {
	        _21785 = g_instanceBuffer_1._m0[nInstanceIdx]._m1;
	    }
	    vec3 _21709;
	    if (_13771 > 0u)
	    {
	        _21709 = vec3(g_transformBuffer_1._m0[g_instanceBuffer_1._m0[nInstanceIdx]._m1]._m0[0].z);
	    }
	    else
	    {
	        _21709 = vec3(1.0);
	    }
	    vec4 _23812 = vec4(uvec4(g_instanceBuffer_1._m0[nInstanceIdx]._m0 & 255u, (g_instanceBuffer_1._m0[nInstanceIdx]._m0 & 65280u) >> uint(8), (g_instanceBuffer_1._m0[nInstanceIdx]._m0 & 16711680u) >> uint(16), (g_instanceBuffer_1._m0[nInstanceIdx]._m0 & 4278190080u) >> uint(24))) * vec4(0.0039215688593685626983642578125);
	    vec3 _6253 = _23812.xyz;
	    vec3 _17828 = _6253 * vec3(0.077399380505084991455078125);
	    vec3 _7676 = pow((_6253 * vec3(0.947867333889007568359375)) + vec3(0.052132703363895416259765625), vec3(2.400000095367431640625));
	    float _21354;
	    if (_23812.x <= 0.040449999272823333740234375)
	    {
	        _21354 = _17828.x;
	    }
	    else
	    {
	        _21354 = _7676.x;
	    }
	    float _21355;
	    if (_23812.y <= 0.040449999272823333740234375)
	    {
	        _21355 = _17828.y;
	    }
	    else
	    {
	        _21355 = _7676.y;
	    }
	    float _17978;
	    if (_23812.z <= 0.040449999272823333740234375)
	    {
	        _17978 = _17828.z;
	    }
	    else
	    {
	        _17978 = _7676.z;
	    }
	    float _7654 = _23812.w;
	    vec3 _11179 = normalize(vec4(vNormalOs.xyz, 0.0) * g_transformBuffer_1._m0[_21785]._m0);
	    vec3 _12151 = vec4(vPositionOs.xyz * _21709.xyz, 1.0) * g_transformBuffer_1._m0[_21785]._m0;
	    vec4 _18237 = (vec4(_12151.xyz, 1.0) + (PerViewConstantBuffer_t._m2 * 1.0)).xyzw * PerViewConstantBuffer_t._m0;
	    vec4 _9360 = vTexCoord.xyxy;
	    _9360.x = dot(vTexCoord.xy, _Globals_.g_vTexCoordXform0.xy) + _Globals_.g_vTexCoordXform0.w;
	    _9360.y = dot(vTexCoord.xy, _Globals_.g_vTexCoordXform1.xy) + _Globals_.g_vTexCoordXform1.w;
	    vec2 _22490 = _9360.xy + (_Globals_.g_vTexCoordScrollSpeed.xy * PerViewConstantBuffer_t._m1);
	    vec4 _20488 = _9360;
	    _20488.x = _22490.x;
	    _20488.y = _22490.y;
	    vec4 _11399 = vec4(mix(vec3(1.0), vec4(_21354, _21355, _17978, _7654).xyz, vec3(_Globals_.g_flModelTintAmount)), _7654 * g_instanceBuffer_1._m0[nInstanceIdx]._m7);
	    vec3 _13062 = _11399.xyz * _Globals_.g_vColorTint.xyz;
	    vec4 _23714 = _11399;
	    _23714.x = _13062.x;
	    _23714.y = _13062.y;
	    _23714.z = _13062.z;
	    output_0 = vec4(vBlendValues.xyz, max(vBlendValues.w, 0.100000001490116119384765625));
	    output_1 = _12151.xyz - PerViewConstantBufferCsgo_t._m0.xyz;
	    output_2 = _11179;
	    output_3 = _20488;
	    output_4 = _23714;
	    output_5 = _11179;
	    output_6 = vec4(normalize(vec4(vTangentUOs_flTangentVSign.xyz, 0.0) * g_transformBuffer_1._m0[_21785]._m0), vTangentUOs_flTangentVSign.w);
	    output_7 = g_instanceBuffer_1._m0[nInstanceIdx]._m5 & 65535u;
	    _18237.y = -_18237.y;
	    gl_Position = _18237;
	}
	
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
	
	BoolAttribute(BindlessResources, true);
	BoolAttribute(environmentmapped, true);
	BoolAttribute(environmentmappeddynamic, true);
	BoolAttribute(CanBatchWithDynamicShaderConstants, true);
	IntAttribute(TexCoordScaleByModelU, g_nScaleTexCoordUByModelScaleAxis-1);
	IntAttribute(TexCoordScaleByModelV, g_nScaleTexCoordVByModelScaleAxis-1);
	Float3Attribute(LightSim_MaterialTint, g_vColorTint);
	BoolAttribute(VertexPaintUI2Layer, true);
	BoolAttribute(VertexPaintUIAlphaBlendFactor, true);
	BoolAttribute(SupportsAggregateInstancing, true);
	
	#if (S_PAINT_VERTEX_COLORS == 1)
		BoolAttribute(VertexPaintUIPickColor, true);
	#endif
}

PS
{
	StaticCombo( S_ENABLE_TINT_MASKS, F_ENABLE_TINT_MASKS );
	StaticCombo( S_SHADER_QUALITY, 0..1 );
	StaticCombo( S_MODE_TOOLS_VIS, 0..1 );
	StaticCombo( S_ENABLE_AO, F_ENABLE_AMBIENT_OCCLUSION );
	StaticComboRule( Requires( S_MODE_TOOLS_VIS, S_SHADER_QUALITY ) );
	DynamicCombo( D_BAKED_LIGHTING_FROM_VERTEX_STREAM, 0..1 );
	DynamicCombo( D_BAKED_LIGHTING_FROM_PROBE, 0..1 );
	DynamicCombo( D_BAKED_LIGHTING_FROM_LIGHTMAP, 0..1 );
	DynamicCombo( D_OPAQUE_FADE, 0..1 );
	DynamicCombo( D_SPECULAR_CUBE_MAP_STATIC, 0..1 );
	DynamicComboRule( Allow1( D_BAKED_LIGHTING_FROM_PROBE, D_BAKED_LIGHTING_FROM_VERTEX_STREAM, D_BAKED_LIGHTING_FROM_LIGHTMAP ) );
	DynamicComboRule( Requires( D_SPECULAR_CUBE_MAP_STATIC, S_SHADER_QUALITY ) );
	
	[[layer_constant]] StructuredBuffer g_BarnLights < Attribute("BarnLights"); >;
	[[layer_constant]] StructuredBuffer g_CullBits < Attribute("CullBits"); >;
	bool g_bCubemapNormalization < Attribute("g_bCubemapNormalization"); UiType(CheckBox); >;
	bool g_bDisableNormalMapping < Attribute("g_bDisableNormalMapping"); UiType(CheckBox); >;
	bool g_bHighlightDeprecated < Attribute("g_bHighlightDeprecated"); UiType(CheckBox); >;
	bool g_bIsDeprecated < Attribute("bIsDeprecated"); UiType(CheckBox); >;
	bool g_bRenderingToCubemaps < Attribute("g_bRenderingToCubemaps"); UiType(CheckBox); >;
	bool g_bShowLPVVoxels < Attribute("g_bShowLPVVoxels"); UiType(CheckBox); >;
	bool g_bShowLightmapTexels < Attribute("g_bShowLightmapTexels"); UiType(CheckBox); >;
	float g_fToolsVisHeightTint < Default(0.9); Attribute("g_fToolsVisHeightTint"); UiType(Slider); >;
	float g_fToolsVisMaxHeightRange < Default(1); Attribute("g_fToolsVisMaxHeightRange"); UiType(Slider); >;
	float g_fToolsVisMaxLightingComplexity < Default(8); Attribute("g_fToolsVisMaxLightingComplexity"); UiType(Slider); >;
	float g_flReflectance < UiType(Slider); Expression(pow((1.5-1)/(1.5+1),2)); >;
	[[layer_constant]] ExternalDescriptorSet g_globalLateBoundBindlessSet < Source(ExternalDescSet); Attribute("g_globalLateBoundBindlessSet"); >;
	[[layer_constant]] ExternalDescriptorSet g_lightBinnerGpuSet < Source(ExternalDescSet); Attribute("g_lightBinnerGpuSet"); >;
	int g_nToolsVisMode < Attribute("g_nToolsVisMode"); UiType(Slider); >;
	Texture2D g_tColorA < Channel(RGB, Box(TextureColorA), Srgb); OutputFormat(DXT1); SrgbRead(true); >;
	Texture2D g_tColorA < Channel(RGB, Box(TextureColorA), Srgb); Channel(A, Box(TextureAmbientOcclusionA), Linear); OutputFormat(BC7); SrgbRead(true); >;
	Texture2D g_tColorB < Channel(RGB, Box(TextureColorB), Srgb); OutputFormat(DXT1); SrgbRead(true); >;
	Texture2D g_tColorB < Channel(RGB, Box(TextureColorB), Srgb); Channel(A, Box(TextureAmbientOcclusionB), Linear); OutputFormat(BC7); SrgbRead(true); >;
	Texture2D g_tMask < Channel(R, Box(TextureMask), Linear); OutputFormat(ATI1N); SrgbRead(false); >;
	Texture2D g_tNormalA < Channel(RGBA, HemiOctIsoRoughness_RG_B(TextureNormalA, TextureRoughnessA), Linear); OutputFormat(BC7); SrgbRead(false); >;
	Texture2D g_tNormalB < Channel(RGBA, HemiOctIsoRoughness_RG_B(TextureNormalB, TextureRoughnessB), Linear); OutputFormat(BC7); SrgbRead(false); >;
	Texture2D g_tTintMask < Channel(R, Box(TextureTintMaskA), Linear); Channel(G, Box(TextureTintMaskB), Linear); OutputFormat(ATI2N); SrgbRead(false); >;
	float3 g_vFlatOverlayColor < Default2(1, 0); Attribute("FlatOverlayColor"); UiType(VectorText); >;
	float4 g_vShaderIDColor < Source(ShaderIDColor); UiType(VectorText); >;
	
	// Material A
	CreateInputTexture2D(TextureColorA, Srgb, 8, "", "_color", "Material A,10/10", Default4(1, 1, 1, 0));
	CreateInputTexture2D(TextureNormalA, Linear, 8, "NormalizeNormals", "_normal", "Material A,10/20", Default4(0.5, 0.5, 1, 0));
	CreateInputTexture2D(TextureRoughnessA, Linear, 8, "Inverse", "_rough", "Material A,10/30", Default4(0.5, 0.5, 0.5, 0));
	CreateInputTexture2D(TextureAmbientOcclusionA, Linear, 8, "", "_ao", "Material A,10/40", Default4(1, 1, 1, 0));
	CreateInputTexture2D(TextureTintMaskA, Linear, 8, "", "_mask", "Material A,10/50", Default4(1, 1, 1, 0));
	float g_flMetalnessA < UiType(Slider); UiGroup("Material A,10/60"); >;
	
	// Material B
	float2 g_vTexCoordScale2 < Default2(1, 1); Range2(0, 0, 100, 100); UiType(VectorText); UiGroup("Material B,100"); >;
	CreateInputTexture2D(TextureColorB, Srgb, 8, "", "_color", "Material B,20/10", Default4(1, 1, 1, 0));
	CreateInputTexture2D(TextureNormalB, Linear, 8, "NormalizeNormals", "_normal", "Material B,20/20", Default4(0.5, 0.5, 1, 0));
	CreateInputTexture2D(TextureRoughnessB, Linear, 8, "Inverse", "_rough", "Material B,20/30", Default4(0.5, 0.5, 0.5, 0));
	CreateInputTexture2D(TextureAmbientOcclusionB, Linear, 8, "", "_ao", "Material B,20/40", Default4(1, 1, 1, 0));
	CreateInputTexture2D(TextureTintMaskB, Linear, 8, "", "_mask", "Material B,10/50", Default4(1, 1, 1, 0));
	float g_flMetalnessB < UiType(Slider); UiGroup("Material B,20/60"); >;
	
	// Mask
	CreateInputTexture2D(TextureMask, Linear, 8, "", "_mask", "Mask,30/10", Default4(1, 1, 1, 0));
	
	// Fog
	bool g_bFogEnabled < Default(1); UiType(CheckBox); UiGroup("Fog"); >;
	
	// Texture Address Mode
	int g_nTextureAddressModeU < UiOption("RsTextureAddressMode_t"); UiType(Enum); UiGroup("Texture Address Mode"); >;
	int g_nTextureAddressModeV < UiOption("RsTextureAddressMode_t"); UiType(Enum); UiGroup("Texture Address Mode"); >;
	
	#if (S_ENABLE_AO == 1)
		Texture2D g_tColorA < Channel(RGB, Box(TextureColorA), Srgb); Channel(A, Box(TextureAmbientOcclusionA), Linear); OutputFormat(BC7); SrgbRead(true); >;
		Texture2D g_tColorB < Channel(RGB, Box(TextureColorB), Srgb); Channel(A, Box(TextureAmbientOcclusionB), Linear); OutputFormat(BC7); SrgbRead(true); >;
	#endif
	
	// Variant parameters
	Texture2D g_tColorA < Channel(RGB, Box(TextureColorA), Srgb); OutputFormat(DXT1); SrgbRead(true); >;
	Texture2D g_tColorB < Channel(RGB, Box(TextureColorB), Srgb); OutputFormat(DXT1); SrgbRead(true); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	struct _2242
	{
	    float4 _m0[3];
	};
	
	struct _2452
	{
	    float4 _m0[4];
	};
	
	struct _2360
	{
	    column_major float4x4 _m0[4];
	};
	
	struct _200
	{
	    column_major float4x4 _m0;
	    column_major float4x4 _m1;
	    float4 _m2;
	    float4 _m3;
	    float4 _m4;
	    float4 _m5;
	    float3 _m6;
	    uint _m7;
	    float4 _m8;
	    float4 _m9;
	    float4 _m10;
	    float _m11;
	    float _m12;
	    uint _m13;
	    int _m14;
	    column_major float4x3 _m15;
	    float4 _m16;
	    float4 _m17;
	    float4 _m18;
	    float4 _m19;
	    float4 _m20;
	    float3 _m21;
	    float _m22;
	    column_major float4x4 _m23;
	};
	
	static float4 _3;
	static float3 _4;
	
	cbuffer _Globals_ : register(b0, space1)
	{
	    uint _Globals_1_g_sTrilinearWrap : packoffset(c0.z);
	    uint _Globals_1_g_sTrilinearClamp : packoffset(c0.w);
	    uint _Globals_1_g_sPointClamp : packoffset(c1);
	    uint _Globals_1_g_sUserConfig : packoffset(c1.w);
	    float _Globals_1_g_flMetalnessA : packoffset(c3);
	    float _Globals_1_g_flMetalnessB : packoffset(c3.y);
	    float2 _Globals_1_g_vTexCoordScale2 : packoffset(c3.z);
	    uint _Globals_1_g_tColorA : packoffset(c4);
	    uint _Globals_1_g_tColorB : packoffset(c4.y);
	    uint _Globals_1_g_tNormalA : packoffset(c4.z);
	    uint _Globals_1_g_tNormalB : packoffset(c4.w);
	    uint _Globals_1_g_tMask : packoffset(c5);
	    uint _Globals_1_g_sCookieSampler : packoffset(c5.z);
	    uint _Globals_1_g_tShadowDepthBufferCmpSampler : packoffset(c5.w);
	    int _Globals_1_g_bFogEnabled : packoffset(c6.y);
	    float _Globals_1_g_flReflectance : packoffset(c7);
	};
	
	cbuffer PerViewConstantBufferCsgo_t : register(b3, space1)
	{
	    int4 PerViewConstantBufferCsgo_t_1_m0 : packoffset(c1);
	    int4 PerViewConstantBufferCsgo_t_1_m1 : packoffset(c2);
	    int4 PerViewConstantBufferCsgo_t_1_m2 : packoffset(c3);
	    uint PerViewConstantBufferCsgo_t_1_m3 : packoffset(c4.z);
	    uint PerViewConstantBufferCsgo_t_1_m4 : packoffset(c4.w);
	    uint PerViewConstantBufferCsgo_t_1_m5 : packoffset(c5);
	    uint PerViewConstantBufferCsgo_t_1_m6 : packoffset(c5.z);
	    uint PerViewConstantBufferCsgo_t_1_m7 : packoffset(c6.z);
	    column_major float4x4 PerViewConstantBufferCsgo_t_1_m8 : packoffset(c12);
	    float2 PerViewConstantBufferCsgo_t_1_m9 : packoffset(c16);
	    float PerViewConstantBufferCsgo_t_1_m10 : packoffset(c16.z);
	    float4 PerViewConstantBufferCsgo_t_1_m11 : packoffset(c23);
	    float4 PerViewConstantBufferCsgo_t_1_m12 : packoffset(c24);
	    float4 PerViewConstantBufferCsgo_t_1_m13 : packoffset(c25);
	    float4 PerViewConstantBufferCsgo_t_1_m14 : packoffset(c26);
	    float4 PerViewConstantBufferCsgo_t_1_m15 : packoffset(c27);
	    float4 PerViewConstantBufferCsgo_t_1_m16 : packoffset(c28);
	    column_major float4x4 PerViewConstantBufferCsgo_t_1_m17 : packoffset(c29);
	    float4 PerViewConstantBufferCsgo_t_1_m18 : packoffset(c33);
	    float4 PerViewConstantBufferCsgo_t_1_m19 : packoffset(c34);
	    float4 PerViewConstantBufferCsgo_t_1_m20 : packoffset(c35);
	};
	
	cbuffer PerViewLightingConstantBufferGpu_t : register(b0, space3)
	{
	    _2242 PerViewLightingConstantBufferGpu_t_1_m0 : packoffset(c7);
	    _2452 PerViewLightingConstantBufferGpu_t_1_m1 : packoffset(c11);
	    float4 PerViewLightingConstantBufferGpu_t_1_m2 : packoffset(c16);
	    float4 PerViewLightingConstantBufferGpu_t_1_m3 : packoffset(c17);
	    float4 PerViewLightingConstantBufferGpu_t_1_m4 : packoffset(c18);
	    uint4 PerViewLightingConstantBufferGpu_t_1_m5 : packoffset(c19);
	    uint4 PerViewLightingConstantBufferGpu_t_1_m6 : packoffset(c22);
	    float4 PerViewLightingConstantBufferGpu_t_1_m7 : packoffset(c23);
	    float4 PerViewLightingConstantBufferGpu_t_1_m8 : packoffset(c24);
	    float4 PerViewLightingConstantBufferGpu_t_1_m9 : packoffset(c1945);
	    float4 PerViewLightingConstantBufferGpu_t_1_m10 : packoffset(c1946);
	    int PerViewLightingConstantBufferGpu_t_1_m11 : packoffset(c1953);
	    float PerViewLightingConstantBufferGpu_t_1_m12 : packoffset(c1953.z);
	    float4 PerViewLightingConstantBufferGpu_t_1_m13 : packoffset(c1954);
	    float PerViewLightingConstantBufferGpu_t_1_m14 : packoffset(c1955);
	    float PerViewLightingConstantBufferGpu_t_1_m15 : packoffset(c1955.y);
	    float PerViewLightingConstantBufferGpu_t_1_m16 : packoffset(c1955.z);
	    float PerViewLightingConstantBufferGpu_t_1_m17 : packoffset(c1955.w);
	    _2360 PerViewLightingConstantBufferGpu_t_1_m18 : packoffset(c1956);
	    _2452 PerViewLightingConstantBufferGpu_t_1_m19 : packoffset(c1988);
	    uint PerViewLightingConstantBufferGpu_t_1_m20 : packoffset(c1996);
	    uint PerViewLightingConstantBufferGpu_t_1_m21 : packoffset(c1996.y);
	};
	
	cbuffer PerViewConstantBuffer_t : register(b1, space1)
	{
	    float2 PerViewConstantBuffer_t_1_m0 : packoffset(c20);
	    float2 PerViewConstantBuffer_t_1_m1 : packoffset(c20.z);
	    float4 PerViewConstantBuffer_t_1_m2 : packoffset(c22);
	    float3 PerViewConstantBuffer_t_1_m3 : packoffset(c26);
	};
	
	ByteAddressBuffer g_CullBits : register(t30, space3);
	ByteAddressBuffer g_BarnLights : register(t31, space3);
	Texture2D<float4> g_bindless_Texture2D_float4[65536] : register(t46, space4);
	SamplerState g_bindless_Sampler[2048] : register(s29, space4);
	SamplerComparisonState g_bindless_Sampler_1[2048] : register(s29, space4);
	Texture3D<float4> g_bindless_Texture3D_float4[65536] : register(t46, space4);
	TextureCubeArray<float4> g_bindless_TextureCubeArray_float4[65536] : register(t46, space4);
	TextureCube<float4> g_bindless_TextureCube_float4[65536] : register(t46, space4);
	
	static float4 gl_FragCoord;
	static float4 input_0;
	static float3 input_1;
	static float3 input_2;
	static float4 input_3;
	static float4 input_4;
	static float3 input_5;
	static float4 input_6;
	static float4 output_0;
	
	struct PS_INPUT
	{
	    float4 input_0 : TEXCOORD0;
	    float3 input_1 : TEXCOORD1;
	    float3 input_2 : TEXCOORD2;
	    float4 input_3 : TEXCOORD3;
	    centroid float4 input_4 : TEXCOORD4;
	    centroid float3 input_5 : TEXCOORD5;
	    float4 input_6 : TEXCOORD6;
	    float4 gl_FragCoord : SV_Position;
	};
	
	struct PS_OUTPUT
	{
	    float4 output_0 : SV_Target0;
	};
	
	void MainPs_inner()
	{
	    float4 _11408 = gl_FragCoord;
	    _11408.w = 1.0f / _11408.w;
	    float3 _21709;
	    if (dot(input_2.xyz, input_2.xyz) >= 1.0099999904632568359375f)
	    {
	        _21709 = input_5.xyz;
	    }
	    else
	    {
	        _21709 = input_2.xyz;
	    }
	    float3 _20700 = normalize(_21709);
	    float3 _7715 = input_1 + PerViewConstantBufferCsgo_t_1_m20.xyz;
	    float2 _11085 = (input_3.xy * _Globals_1_g_vTexCoordScale2.xy).xy;
	    float4 _21762 = g_bindless_Texture2D_float4[_Globals_1_g_tNormalA].Sample(g_bindless_Sampler[_Globals_1_g_sUserConfig], input_3.xy);
	    float4 _21763 = g_bindless_Texture2D_float4[_Globals_1_g_tNormalB].Sample(g_bindless_Sampler[_Globals_1_g_sUserConfig], _11085);
	    float4 _19372 = g_bindless_Texture2D_float4[_Globals_1_g_tMask].Sample(g_bindless_Sampler[_Globals_1_g_sTrilinearWrap], _11085);
	    float _16038 = _19372.x;
	    float _24575 = smoothstep(max(0.0f, _16038 - input_0.w), min(1.0f, _16038 + input_0.w), input_0.x);
	    float3 _21122 = g_bindless_Texture2D_float4[_Globals_1_g_tColorA].Sample(g_bindless_Sampler[_Globals_1_g_sUserConfig], input_3.xy).xyz * input_4.xyz;
	    float4 _23714;
	    _23714.x = _21122.x;
	    _23714.y = _21122.y;
	    _23714.z = _21122.z;
	    float3 _20313 = g_bindless_Texture2D_float4[_Globals_1_g_tColorB].Sample(g_bindless_Sampler[_Globals_1_g_sUserConfig], _11085).xyz * input_4.xyz;
	    float4 _23715;
	    _23715.x = _20313.x;
	    _23715.y = _20313.y;
	    _23715.z = _20313.z;
	    float4 _8489 = lerp(_21762.xyzw, _21763.xyzw, _24575.xxxx);
	    float _14051 = lerp(_Globals_1_g_flMetalnessA, _Globals_1_g_flMetalnessB, _24575);
	    float3 _11217 = lerp(_23714.xyz, _23715.xyz, _24575.xxx).xyz;
	    float3 _25153 = lerp(_Globals_1_g_flReflectance.xxx.xyz, _11217, _14051.xxx);
	    float _10782 = _8489.x;
	    float _17303 = _8489.y;
	    float _16783 = (_10782 + _17303) - 1.00392162799835205078125f;
	    float _11176 = _10782 - _17303;
	    float3 _23372 = normalize(float3(float2(_16783, _11176), (1.0f - abs(_16783)) - abs(_11176)));
	    float3 _20024 = input_2.xyz * 1.0f;
	    float3 _14435 = cross(_20024.xyz, input_6.xyz) * ((input_6.w > 0.0f) ? 1.0f : (-1.0f));
	    float3 _20195;
	    if (bool4(PerViewConstantBufferCsgo_t_1_m2.x != int4(0, 0, 0, 0).x, PerViewConstantBufferCsgo_t_1_m2.y != int4(0, 0, 0, 0).y, PerViewConstantBufferCsgo_t_1_m2.z != int4(0, 0, 0, 0).z, PerViewConstantBufferCsgo_t_1_m2.w != int4(0, 0, 0, 0).w).w)
	    {
	        _20195 = -_14435;
	    }
	    else
	    {
	        _20195 = _14435;
	    }
	    float3 _19740 = normalize((((input_6.xyz * _23372.x).xyz + (_20195.xyz * (-_23372.y))).xyz + (_20024.xyz * _23372.z)).xyz);
	    bool3 _10679 = all(bool3(true, true, true)).xxx;
	    float3 _17892 = float3(_10679.x ? _19740.x : 1.0f.xxx.x, _10679.y ? _19740.y : 1.0f.xxx.y, _10679.z ? _19740.z : 1.0f.xxx.z);
	    float3 _10560 = _20700.xyz;
	    float3 _11099 = ddx(_10560);
	    float3 _9175 = ddy(_10560);
	    float3 _10347 = _11099.xyz;
	    float3 _12420 = _9175.xyz;
	    float2 _21815 = max(_8489.z.xx.xy, pow(saturate(max(dot(_10347, _10347), dot(_12420, _12420))), 0.333000004291534423828125f).xx);
	    float3 _15598 = -_20700;
	    float3 _24735 = _19740.xyz;
	    float4 _23875 = float4(_24735, 1.0f);
	    bool4 _24465 = bool4(PerViewConstantBufferCsgo_t_1_m0.x != int4(0, 0, 0, 0).x, PerViewConstantBufferCsgo_t_1_m0.y != int4(0, 0, 0, 0).y, PerViewConstantBufferCsgo_t_1_m0.z != int4(0, 0, 0, 0).z, PerViewConstantBufferCsgo_t_1_m0.w != int4(0, 0, 0, 0).w);
	    float _21710;
	    if (_24465.x)
	    {
	        float3 _11394 = _20700.xyz;
	        float2 _11086 = ((floor(_11408.xy * PerViewConstantBufferCsgo_t_1_m10) * PerViewConstantBufferCsgo_t_1_m9.xy) + (PerViewConstantBufferCsgo_t_1_m9.xy * 0.5f)).xy;
	        float4 _18418 = g_bindless_Texture2D_float4[PerViewConstantBufferCsgo_t_1_m5].GatherRed(g_bindless_Sampler[_Globals_1_g_sCookieSampler], _11086).xyzw - _11408.zzzz;
	        float _18579 = _18418.w;
	        float _12013 = _18418.z;
	        bool _12285 = abs(_12013) < _18579;
	        float2 _23168;
	        if (_12285)
	        {
	            _23168 = float2(PerViewConstantBufferCsgo_t_1_m9.x, 0.0f);
	        }
	        else
	        {
	            _23168 = 0.0f.xx;
	        }
	        float _20965 = _12285 ? _12013 : _18579;
	        float _15372 = _18418.x;
	        bool _12286 = abs(_15372) < _20965;
	        float2 _23169;
	        if (_12286)
	        {
	            _23169 = float2(0.0f, PerViewConstantBufferCsgo_t_1_m9.y);
	        }
	        else
	        {
	            _23169 = _23168;
	        }
	        bool2 _13083 = (abs(_18418.y) < (_12286 ? _15372 : _20965)).xx;
	        float4 _10010 = normalize(float4(PerViewLightingConstantBufferGpu_t_1_m2.x * mad(dot(_15598, normalize(float3(PerViewLightingConstantBufferGpu_t_1_m1._m0[0].xy, 0.25f))), 0.5f, 0.5f), PerViewLightingConstantBufferGpu_t_1_m2.y * mad(dot(_15598, normalize(float3(PerViewLightingConstantBufferGpu_t_1_m1._m0[1].xy, 0.25f))), 0.5f, 0.5f), PerViewLightingConstantBufferGpu_t_1_m2.z * mad(dot(_15598, normalize(float3(PerViewLightingConstantBufferGpu_t_1_m1._m0[2].xy, 0.25f))), 0.5f, 0.5f), PerViewLightingConstantBufferGpu_t_1_m2.w * mad(dot(_15598, normalize(float3(PerViewLightingConstantBufferGpu_t_1_m1._m0[3].xy, 0.25f))), 0.5f, 0.5f)));
	        float4 _13232 = max(float4(dot(PerViewLightingConstantBufferGpu_t_1_m1._m0[0].xyz, _11394), dot(PerViewLightingConstantBufferGpu_t_1_m1._m0[1].xyz, _11394), dot(PerViewLightingConstantBufferGpu_t_1_m1._m0[2].xyz, _11394), dot(PerViewLightingConstantBufferGpu_t_1_m1._m0[3].xyz, _11394)).xyzw, 0.0f.xxxx) * normalize(clamp(((_10010 - max(max(_10010.x, _10010.y), max(_10010.z, _10010.w)).xxxx) + 0.20000000298023223876953125f.xxxx) * 5.0f.xxxx, 0.0f.xxxx, 1.0f.xxxx));
	        _21710 = (1.0f / (dot(_13232, 1.0f.xxxx) + PerViewLightingConstantBufferGpu_t_1_m3.x)) * (PerViewLightingConstantBufferGpu_t_1_m3.x + dot(_13232, g_bindless_Texture2D_float4[PerViewConstantBufferCsgo_t_1_m4].SampleLevel(g_bindless_Sampler[_Globals_1_g_sPointClamp], (_11086 + float2(_13083.x ? PerViewConstantBufferCsgo_t_1_m9.xy.x : _23169.x, _13083.y ? PerViewConstantBufferCsgo_t_1_m9.xy.y : _23169.y).xy).xy, 0.0f)));
	    }
	    else
	    {
	        _21710 = 1.0f;
	    }
	    float _21711;
	    [branch]
	    if (PerViewLightingConstantBufferGpu_t_1_m11 != 0)
	    {
	        int _23989;
	        int _10191;
	        float _13136;
	        float3 _14975;
	        int _13039 = 0;
	        for (;;)
	        {
	            if (!(_13039 < PerViewLightingConstantBufferGpu_t_1_m11))
	            {
	                _13136 = 1.0f;
	                _14975 = 0.0f.xxx;
	                _10191 = -1;
	                break;
	            }
	            float4 _18322 = mul(PerViewLightingConstantBufferGpu_t_1_m18._m0[_13039], float4(input_1.xyz, 1.0f));
	            float _12779 = _18322.x;
	            if (max(abs(_12779), abs(_18322.y)) < PerViewLightingConstantBufferGpu_t_1_m13[_13039])
	            {
	                float3 _19470 = float3(_12779, _18322.yz);
	                float2 _24804 = _19470.xy;
	                float2 _22193 = 1.0f.xx - clamp((abs(_24804) * PerViewLightingConstantBufferGpu_t_1_m15.xx) + PerViewLightingConstantBufferGpu_t_1_m14.xx, 0.0f.xx, 1.0f.xx);
	                float2 _20561 = (_24804 * PerViewLightingConstantBufferGpu_t_1_m19._m0[_13039].zw) + PerViewLightingConstantBufferGpu_t_1_m19._m0[_13039].xy;
	                float3 _20488 = _19470;
	                _20488.x = _20561.x;
	                _20488.y = _20561.y;
	                _13136 = saturate(_22193.x * _22193.y);
	                _14975 = _20488;
	                _10191 = _13039;
	                break;
	            }
	            _23989 = _13039 + 1;
	            _13039 = _23989;
	            continue;
	        }
	        float _19363;
	        if (_10191 >= 0)
	        {
	            float _18270 = g_bindless_Texture2D_float4[PerViewLightingConstantBufferGpu_t_1_m20].SampleCmpLevelZero(g_bindless_Sampler_1[_Globals_1_g_tShadowDepthBufferCmpSampler], _14975.xy, saturate(_14975.z + PerViewLightingConstantBufferGpu_t_1_m12));
	            float _12501;
	            [branch]
	            if (_13136 < 1.0f)
	            {
	                float _7934;
	                if (_10191 < (PerViewLightingConstantBufferGpu_t_1_m11 - 1))
	                {
	                    int _15335 = _10191 + 1;
	                    float4 _19671 = mul(PerViewLightingConstantBufferGpu_t_1_m18._m0[_15335], float4(input_1.xyz, 1.0f));
	                    float2 _20562 = (_19671.xy * PerViewLightingConstantBufferGpu_t_1_m19._m0[_15335].zw) + PerViewLightingConstantBufferGpu_t_1_m19._m0[_15335].xy;
	                    float3 _20489;
	                    _20489.x = _20562.x;
	                    _20489.y = _20562.y;
	                    _7934 = g_bindless_Texture2D_float4[PerViewLightingConstantBufferGpu_t_1_m20].SampleCmpLevelZero(g_bindless_Sampler_1[_Globals_1_g_tShadowDepthBufferCmpSampler], _20489.xy, saturate(_19671.z + PerViewLightingConstantBufferGpu_t_1_m12));
	                }
	                else
	                {
	                    _7934 = 1.0f;
	                }
	                _12501 = lerp(_7934, _18270, _13136);
	            }
	            else
	            {
	                _12501 = _18270;
	            }
	            _19363 = _12501;
	        }
	        else
	        {
	            _19363 = 1.0f;
	        }
	        float _13279 = lerp(_19363, 1.0f, saturate((distance(_7715.xyz, PerViewConstantBuffer_t_1_m3) * PerViewLightingConstantBufferGpu_t_1_m17) + PerViewLightingConstantBufferGpu_t_1_m16));
	        float _12502;
	        if (_24465.y)
	        {
	            _12502 = min(_13279, g_bindless_Texture2D_float4[PerViewConstantBufferCsgo_t_1_m6].SampleLevel(g_bindless_Sampler[_Globals_1_g_sTrilinearClamp], (_11408.xy * PerViewConstantBuffer_t_1_m2.xy).xy, 0.0f).z);
	        }
	        else
	        {
	            _12502 = _13279;
	        }
	        _21711 = _12502;
	    }
	    else
	    {
	        _21711 = 1.0f;
	    }
	    float3 _9716;
	    float3 _24878;
	    [branch]
	    if ((dot(PerViewLightingConstantBufferGpu_t_1_m9.xyz, _24735) * _21711) > 0.0f)
	    {
	        bool3 _19899 = all(bool3(_17892.x == 1.0f.xxx.x, _17892.y == 1.0f.xxx.y, _17892.z == 1.0f.xxx.z)).xxx;
	        float _11797 = max(0.0f, dot(_19740.xyz, PerViewLightingConstantBufferGpu_t_1_m9.xyz));
	        float2 _9840 = max(_21815, PerViewLightingConstantBufferGpu_t_1_m9.w.xx);
	        float3 _12281 = normalize(PerViewLightingConstantBufferGpu_t_1_m9.xyz + (-normalize(_7715.xyz - PerViewConstantBuffer_t_1_m3.xyz)).xyz).xyz;
	        float _12386 = dot(_12281, float3(_19899.x ? _24735.x : _17892.x, _19899.y ? _24735.y : _17892.y, _19899.z ? _24735.z : _17892.z).xyz);
	        float _19210 = max(0.0f, dot(PerViewLightingConstantBufferGpu_t_1_m9.xyz, _12281));
	        float _9850 = _9840.x;
	        float _25211 = _9850 * _9850;
	        float _19095 = _25211 * _25211;
	        float _15346 = ((_12386 * _12386) * (_19095 - 1.0f)) + 1.0f;
	        float3 _16808 = (PerViewLightingConstantBufferGpu_t_1_m10.xyz * _21711).xyz;
	        _9716 = ((_25153.xyz * (_19095 / (((_15346 * _15346) * (_19210 * _19210)) * ((_9850 * 4.0f) + 2.0f)))).xyz * _11797).xyz * _16808;
	        _24878 = PerViewLightingConstantBufferGpu_t_1_m4.xyz + (_11797.xxx.xyz * _16808);
	    }
	    else
	    {
	        _9716 = 0.0f.xxx;
	        _24878 = PerViewLightingConstantBufferGpu_t_1_m4.xyz;
	    }
	    bool4 _24466 = bool4(PerViewConstantBufferCsgo_t_1_m1.x != int4(0, 0, 0, 0).x, PerViewConstantBufferCsgo_t_1_m1.y != int4(0, 0, 0, 0).y, PerViewConstantBufferCsgo_t_1_m1.z != int4(0, 0, 0, 0).z, PerViewConstantBufferCsgo_t_1_m1.w != int4(0, 0, 0, 0).w);
	    bool _20060 = _24466.x;
	    float4 _19364;
	    if (_20060)
	    {
	        float4 _18621 = mul(PerViewConstantBufferCsgo_t_1_m8, float4(_7715.xyz, 1.0f).xyzw);
	        float _20176 = _18621.w;
	        float2 _11414 = _18621.xy / _20176.xx;
	        float4 _6651;
	        _6651.x = clamp(((_11414.x + 1.0f) * PerViewConstantBuffer_t_1_m1.x) * 0.5f, 0.0f, PerViewConstantBuffer_t_1_m1.x - 1.0f);
	        _6651.y = clamp(((1.0f - _11414.y) * PerViewConstantBuffer_t_1_m1.y) * 0.5f, 0.0f, PerViewConstantBuffer_t_1_m1.y - 1.0f);
	        _6651.w = _20176;
	        _19364 = _6651;
	    }
	    else
	    {
	        _19364 = _11408;
	    }
	    uint2 _12083 = uint2(_19364.xy - PerViewConstantBuffer_t_1_m0.xy) >> PerViewLightingConstantBufferGpu_t_1_m6.x.xx;
	    uint _10838 = PerViewLightingConstantBufferGpu_t_1_m5.y + (((_12083.y * PerViewLightingConstantBufferGpu_t_1_m6.y) + _12083.x) * PerViewLightingConstantBufferGpu_t_1_m5.z);
	    uint _23393 = PerViewLightingConstantBufferGpu_t_1_m5.x + (uint(clamp(_19364.w * PerViewLightingConstantBufferGpu_t_1_m7.x, 0.0f, PerViewLightingConstantBufferGpu_t_1_m7.y)) * PerViewLightingConstantBufferGpu_t_1_m5.z);
	    float3 _13137;
	    float3 _16324;
	    _13137 = _9716;
	    _16324 = _24878;
	    uint _21567;
	    float3 _13138;
	    float3 _16325;
	    uint _17017 = 0u;
	    for (;;)
	    {
	        if (!(_17017 < PerViewLightingConstantBufferGpu_t_1_m5.z))
	        {
	            break;
	        }
	        uint _14475 = WaveActiveBitOr(g_CullBits.Load<uint>((_10838 + _17017) * 4 + 0) & g_CullBits.Load<uint>((_23393 + _17017) * 4 + 0));
	        _13138 = _13137;
	        _16325 = _16324;
	        uint _20344;
	        float3 _13212;
	        float3 _15670;
	        uint _17018 = _14475;
	        for (;;)
	        {
	            if (!(_17018 != 0u))
	            {
	                break;
	            }
	            int _12608 = int(firstbitlow(_17018) + (_17017 * 32u));
	            _20344 = _17018 & (_17018 - 1u);
	            do
	            {
	                float4x4 _14097 = float4x4(g_BarnLights.Load<float>(_12608 * 480 + 0), g_BarnLights.Load<float>(_12608 * 480 + 16), g_BarnLights.Load<float>(_12608 * 480 + 32), g_BarnLights.Load<float>(_12608 * 480 + 48), g_BarnLights.Load<float>(_12608 * 480 + 4), g_BarnLights.Load<float>(_12608 * 480 + 20), g_BarnLights.Load<float>(_12608 * 480 + 36), g_BarnLights.Load<float>(_12608 * 480 + 52), g_BarnLights.Load<float>(_12608 * 480 + 8), g_BarnLights.Load<float>(_12608 * 480 + 24), g_BarnLights.Load<float>(_12608 * 480 + 40), g_BarnLights.Load<float>(_12608 * 480 + 56), g_BarnLights.Load<float>(_12608 * 480 + 12), g_BarnLights.Load<float>(_12608 * 480 + 28), g_BarnLights.Load<float>(_12608 * 480 + 44), g_BarnLights.Load<float>(_12608 * 480 + 60));
	                float4 _24893 = mul(float4(input_1.xyz, 1.0f), _14097);
	                float3 _10521 = _24893.xyz / _24893.w.xxx;
	                float4 _22905;
	                _22905.x = _10521.x;
	                _22905.y = _10521.y;
	                float _21778 = _10521.z;
	                _22905.z = _21778;
	                float3 _21642 = _22905.xyz;
	                bool _7424;
	                if (all(bool3(_22905.xyz.x > float3(-1.0f, -1.0f, 0.0f).x, _22905.xyz.y > float3(-1.0f, -1.0f, 0.0f).y, _22905.xyz.z > float3(-1.0f, -1.0f, 0.0f).z)))
	                {
	                    _7424 = all(bool3(_22905.xyz.x < 1.0f.xxx.x, _22905.xyz.y < 1.0f.xxx.y, _22905.xyz.z < 1.0f.xxx.z));
	                }
	                else
	                {
	                    _7424 = false;
	                }
	                bool _12885;
	                if (!_7424)
	                {
	                    _12885 = true;
	                }
	                else
	                {
	                    float4x3 _16509 = float4x3(g_BarnLights.Load<float>(_12608 * 480 + 272), g_BarnLights.Load<float>(_12608 * 480 + 288), g_BarnLights.Load<float>(_12608 * 480 + 304), g_BarnLights.Load<float>(_12608 * 480 + 276), g_BarnLights.Load<float>(_12608 * 480 + 292), g_BarnLights.Load<float>(_12608 * 480 + 308), g_BarnLights.Load<float>(_12608 * 480 + 280), g_BarnLights.Load<float>(_12608 * 480 + 296), g_BarnLights.Load<float>(_12608 * 480 + 312), g_BarnLights.Load<float>(_12608 * 480 + 284), g_BarnLights.Load<float>(_12608 * 480 + 300), g_BarnLights.Load<float>(_12608 * 480 + 316));
	                    float3 _6368 = abs(mul(float4(input_1.xyz, 1.0f), _16509).xyz);
	                    _12885 = !all(bool3(_6368.x <= 1.0f.xxx.x, _6368.y <= 1.0f.xxx.y, _6368.z <= 1.0f.xxx.z));
	                }
	                if (_12885)
	                {
	                    _13212 = _13138;
	                    _15670 = _16325;
	                    break;
	                }
	                float _23572 = 2.0f * g_BarnLights.Load<float4>(_12608 * 480 + 176).y;
	                float _18492 = (2.0f * g_BarnLights.Load<float4>(_12608 * 480 + 176).z) * g_BarnLights.Load<float4>(_12608 * 480 + 176).z;
	                float _14805 = 2.0f * g_BarnLights.Load<float4>(_12608 * 480 + 176).x;
	                float _9058 = _14805 * g_BarnLights.Load<float4>(_12608 * 480 + 176).y;
	                float _17330 = 2.0f * g_BarnLights.Load<float4>(_12608 * 480 + 176).w;
	                float _19825 = _17330 * g_BarnLights.Load<float4>(_12608 * 480 + 176).z;
	                float3 _16268 = float3(_9058 - _19825, (1.0f - (_14805 * g_BarnLights.Load<float4>(_12608 * 480 + 176).x)) - _18492, (_23572 * g_BarnLights.Load<float4>(_12608 * 480 + 176).z) + (_17330 * g_BarnLights.Load<float4>(_12608 * 480 + 176).x)) * g_BarnLights.Load<float3>(_12608 * 480 + 192).z;
	                float _21316;
	                if (g_BarnLights.Load<float4>(_12608 * 480 + 144).z > 0.0f)
	                {
	                    _21316 = min(1.0f, _21778 * g_BarnLights.Load<float4>(_12608 * 480 + 144).z);
	                }
	                else
	                {
	                    _21316 = 1.0f;
	                }
	                float _19667;
	                if (g_BarnLights.Load<float4>(_12608 * 480 + 144).w > 0.0f)
	                {
	                    _19667 = _21316 * min(1.0f, (1.0f - _21778) * g_BarnLights.Load<float4>(_12608 * 480 + 144).w);
	                }
	                else
	                {
	                    _19667 = _21316;
	                }
	                float3 _11179;
	                float _11633;
	                if (g_BarnLights.Load<float4>(_12608 * 480 + 128).w != 0.0f)
	                {
	                    float3 _10017 = g_BarnLights.Load<float4>(_12608 * 480 + 128).xyz - input_1.xyz;
	                    float _18345 = dot(_10017, _10017);
	                    float _17647 = sqrt(_18345);
	                    float3 _12302 = _10017 - _16268;
	                    float3 _10210;
	                    do
	                    {
	                        float3 _20229 = (_10017 + _16268) - _12302;
	                        float _25105 = dot(-_12302, _20229);
	                        if (_25105 <= 0.0f)
	                        {
	                            _10210 = _12302;
	                            break;
	                        }
	                        else
	                        {
	                            _10210 = _12302 + (_20229 * min(1.0f, _25105 / dot(_20229, _20229)));
	                            break;
	                        }
	                        break; // unreachable workaround
	                    } while(false);
	                    _11179 = _10017 / _17647.xxx;
	                    _11633 = ((_19667 * (g_BarnLights.Load<float4>(_12608 * 480 + 128).w / max(_18345, g_BarnLights.Load<float4>(_12608 * 480 + 128).w))) * saturate(g_BarnLights.Load<float4>(_12608 * 480 + 144).x + (g_BarnLights.Load<float4>(_12608 * 480 + 144).y * _17647))) * saturate(g_BarnLights.Load<float3>(_12608 * 480 + 192).x + (g_BarnLights.Load<float3>(_12608 * 480 + 192).y * dot(float3((1.0f - (_23572 * g_BarnLights.Load<float4>(_12608 * 480 + 176).y)) - _18492, _9058 + _19825, (_14805 * g_BarnLights.Load<float4>(_12608 * 480 + 176).z) - (_17330 * g_BarnLights.Load<float4>(_12608 * 480 + 176).y)), normalize(_10210))));
	                }
	                else
	                {
	                    _11179 = g_BarnLights.Load<float4>(_12608 * 480 + 128).xyz;
	                    _11633 = _19667;
	                }
	                float3 _17828 = (g_BarnLights.Load<float4>(_12608 * 480 + 160).xyz * 1.0f).xyz * _11633;
	                bool _24419;
	                if (g_BarnLights.Load<float4>(_12608 * 480 + 208).z > 0.0f)
	                {
	                    _24419 = !_20060;
	                }
	                else
	                {
	                    _24419 = false;
	                }
	                float3 _21548;
	                [branch]
	                if (g_BarnLights.Load<float4>(_12608 * 480 + 160).w == 0.0f)
	                {
	                    float _10342;
	                    do
	                    {
	                        float2 _22154 = abs(_22905.xy);
	                        if (g_BarnLights.Load<float4>(_12608 * 480 + 224).z == 0.0f)
	                        {
	                            _10342 = smoothstep(1.0f, g_BarnLights.Load<float4>(_12608 * 480 + 224).x, _22154.x) * smoothstep(1.0f, g_BarnLights.Load<float4>(_12608 * 480 + 224).y, _22154.y);
	                            break;
	                        }
	                        else
	                        {
	                            float _11473 = _22154.x;
	                            float _15266 = 2.0f / g_BarnLights.Load<float4>(_12608 * 480 + 224).z;
	                            float _15018 = _22154.y;
	                            float _23041 = (-0.5f) * g_BarnLights.Load<float4>(_12608 * 480 + 224).z;
	                            float _11981 = (g_BarnLights.Load<float4>(_12608 * 480 + 224).x * g_BarnLights.Load<float4>(_12608 * 480 + 224).y) * pow(max(pow(g_BarnLights.Load<float4>(_12608 * 480 + 224).y * _11473, _15266) + pow(g_BarnLights.Load<float4>(_12608 * 480 + 224).x * _15018, _15266), 1.1754943508222875079687365372222e-38f), _23041);
	                            float _16524 = pow(max(pow(_11473, _15266) + pow(_15018, _15266), 1.1754943508222875079687365372222e-38f), _23041);
	                            if (_11981 < _16524)
	                            {
	                                _10342 = smoothstep(_16524, _11981, 1.0f);
	                                break;
	                            }
	                            else
	                            {
	                                _10342 = float(_16524 > 1.0f);
	                                break;
	                            }
	                            break; // unreachable workaround
	                        }
	                        break; // unreachable workaround
	                    } while(false);
	                    _21548 = _17828.xyz * _10342;
	                }
	                else
	                {
	                    float3 _12503;
	                    if (g_BarnLights.Load<float4>(_12608 * 480 + 160).w < 0.0f)
	                    {
	                        float4 _17795 = float4(-g_BarnLights.Load<float4>(_12608 * 480 + 176).xyz, g_BarnLights.Load<float4>(_12608 * 480 + 176).w);
	                        float4 _19008 = _17795.xyzw * float4(-1.0f, -1.0f, -1.0f, 1.0f);
	                        float3 _24989 = _19008.xyz;
	                        float3 _23629 = float4((-_11179).xyz, 0.0f).xyz;
	                        float _15156 = -dot(_23629, _24989);
	                        float3 _20479 = float4((_23629 * _19008.w) + cross(_23629, _24989), _15156).xyz;
	                        float3 _23592 = _17795.xyz;
	                        float3 _12170 = ((_20479 * g_BarnLights.Load<float4>(_12608 * 480 + 176).w) + (_23592 * _15156)) + cross(_23592, _20479);
	                        float3 _14081 = float3(float2(atan2(_12170.y, -_12170.x) * 0.15915493667125701904296875f, acos(_12170.z) * 0.3183098733425140380859375f), -g_BarnLights.Load<float4>(_12608 * 480 + 160).w);
	                        float2 _20564 = (_14081.xy * g_BarnLights.Load<float4>(_12608 * 480 + 224).zw) + g_BarnLights.Load<float4>(_12608 * 480 + 224).xy;
	                        float3 _20492 = _14081;
	                        _20492.x = _20564.x;
	                        _20492.y = _20564.y;
	                        _12503 = _17828.xyz * g_bindless_Texture3D_float4[PerViewLightingConstantBufferGpu_t_1_m21].SampleLevel(g_bindless_Sampler[_Globals_1_g_sTrilinearWrap], _20492.xyz, 0.0f).xyz;
	                    }
	                    else
	                    {
	                        float3 _13791 = float3(mad(_22905.xy, float2(0.5f, -0.5f), 0.5f.xx), g_BarnLights.Load<float4>(_12608 * 480 + 160).w);
	                        float2 _20563 = (_13791.xy * g_BarnLights.Load<float4>(_12608 * 480 + 224).zw) + g_BarnLights.Load<float4>(_12608 * 480 + 224).xy;
	                        float3 _20491 = _13791;
	                        _20491.x = _20563.x;
	                        _20491.y = _20563.y;
	                        _12503 = _17828.xyz * g_bindless_Texture3D_float4[PerViewLightingConstantBufferGpu_t_1_m21].SampleLevel(g_bindless_Sampler[_Globals_1_g_sCookieSampler], _20491.xyz, 0.0f).xyz;
	                    }
	                    _21548 = _12503;
	                }
	                if (all(bool3(_21548.xyz.x == 0.0f.xxx.x, _21548.xyz.y == 0.0f.xxx.y, _21548.xyz.z == 0.0f.xxx.z)))
	                {
	                    _13212 = _13138;
	                    _15670 = _16325;
	                    break;
	                }
	                float3 _22671;
	                if (_24419)
	                {
	                    float3 _19629;
	                    if ((g_BarnLights.Load<uint>(_12608 * 480 + 264) & 4u) != 0u)
	                    {
	                        float2 _6281 = _22905.yx * float2(1.0f, -1.0f);
	                        float3 _23716 = _21642;
	                        _23716.x = _6281.x;
	                        _23716.y = _6281.y;
	                        _19629 = _23716;
	                    }
	                    else
	                    {
	                        _19629 = _21642;
	                    }
	                    float3 _20482 = _21548.xyz * lerp(1.0f, g_bindless_Texture2D_float4[PerViewLightingConstantBufferGpu_t_1_m20].SampleCmpLevelZero(g_bindless_Sampler_1[_Globals_1_g_tShadowDepthBufferCmpSampler], float3(mad(_19629.xy, g_BarnLights.Load<float4>(_12608 * 480 + 208).zw, g_BarnLights.Load<float4>(_12608 * 480 + 208).xy), _19629.z).xy, saturate(_19629.z + PerViewLightingConstantBufferGpu_t_1_m12)), g_BarnLights.Load<float>(_12608 * 480 + 260));
	                    float3 _16449 = _20482.xyz;
	                    if (all(bool3(_16449.x == 0.0f.xxx.x, _16449.y == 0.0f.xxx.y, _16449.z == 0.0f.xxx.z)))
	                    {
	                        _13212 = _13138;
	                        _15670 = _16325;
	                        break;
	                    }
	                    _22671 = _20482;
	                }
	                else
	                {
	                    _22671 = _21548;
	                }
	                bool3 _19900 = all(bool3(_17892.x == 1.0f.xxx.x, _17892.y == 1.0f.xxx.y, _17892.z == 1.0f.xxx.z)).xxx;
	                float _11798 = max(0.0f, dot(_19740.xyz, _11179.xyz));
	                float2 _9841 = max(_21815, g_BarnLights.Load<float>(_12608 * 480 + 256).xx);
	                float3 _12282 = normalize(_11179.xyz + (-normalize(_7715.xyz - PerViewConstantBuffer_t_1_m3.xyz)).xyz).xyz;
	                float _12387 = dot(_12282, float3(_19900.x ? _24735.x : _17892.x, _19900.y ? _24735.y : _17892.y, _19900.z ? _24735.z : _17892.z).xyz);
	                float _19211 = max(0.0f, dot(_11179.xyz, _12282));
	                float _9851 = _9841.x;
	                float _25212 = _9851 * _9851;
	                float _19097 = _25212 * _25212;
	                float _15348 = ((_12387 * _12387) * (_19097 - 1.0f)) + 1.0f;
	                _13212 = _13138.xyz + (((_25153.xyz * (_19097 / (((_15348 * _15348) * (_19211 * _19211)) * ((_9851 * 4.0f) + 2.0f)))).xyz * _11798).xyz * _22671.xyz);
	                _15670 = _16325.xyz + (_11798.xxx.xyz * _22671.xyz);
	                break;
	            } while(false);
	            _13138 = _13212;
	            _16325 = _15670;
	            _17018 = _20344;
	            continue;
	        }
	        _21567 = _17017 + 1u;
	        _13137 = _13138;
	        _16324 = _16325;
	        _17017 = _21567;
	        continue;
	    }
	    float _17172 = dot(_21815.xy, 0.5f.xx);
	    float3 _6253 = _17892.xyz;
	    float3 _17138 = normalize(_7715.xyz - PerViewConstantBuffer_t_1_m3.xyz);
	    float _17225 = _17172 * _17172;
	    float _20711 = saturate(1.0f - _17225);
	    float4 _15343 = (float4(-1.0f, -0.0274999998509883880615234375f, -0.572000026702880859375f, 0.02199999988079071044921875f) * _17172) + float4(1.0f, 0.0425000004470348358154296875f, 1.03999996185302734375f, -0.039999999105930328369140625f);
	    float _21215 = _15343.x;
	    float2 _24572 = (float2(-1.03999996185302734375f, 1.03999996185302734375f) * ((min(_21215 * _21215, exp2((-9.27999973297119140625f) * max(0.0f, dot((-_17138).xyz, _6253)))) * _21215) + _15343.y)) + _15343.zw;
	    float _20339 = _24572.y;
	    float2 _11427 = float2(_20339, _24572.x + _20339);
	    float3 _8745 = float3(dot(PerViewLightingConstantBufferGpu_t_1_m0._m0[0].xyzw, _23875), dot(PerViewLightingConstantBufferGpu_t_1_m0._m0[1].xyzw, _23875), dot(PerViewLightingConstantBufferGpu_t_1_m0._m0[2].xyzw, _23875)).xyz;
	    float3 _16991 = _16324.xyz + _8745;
	    float3 _20418 = _21710.xxx.xyz;
	    float3 _22686 = (_16324.xyz + (_8745 * _20418).xyz) * (_11217 * (1.0f - _14051)).xyz;
	    float _12931 = _22686.x;
	    float4 _11203 = float4(_12931, _22686.yz, input_4.w);
	    _11203.x = _12931;
	    _11203.y = _22686.y;
	    _11203.z = _22686.z;
	    float3 _15752 = _11203.xyz + (_13137.xyz * _20418).xyz;
	    float4 _20490 = _11203;
	    _20490.x = _15752.x;
	    _20490.y = _15752.y;
	    _20490.z = _15752.z;
	    float3 _15734 = _20490.xyz + ((((lerp(_11427.xxx, _11427.yyy, _25153) * g_bindless_TextureCubeArray_float4[PerViewConstantBufferCsgo_t_1_m7].SampleLevel(g_bindless_Sampler[_Globals_1_g_sTrilinearClamp], float4(normalize(lerp(_6253, reflect(_17138.xyz, _17892.xyz).xyz, (_20711 * (sqrt(_20711) + _17225)).xxx)), 0.0f), PerViewLightingConstantBufferGpu_t_1_m8.y * sqrt(_17172)).xyz).xyz * (normalize(_16991 + 0.001000000047497451305389404296875f.xxx) * clamp(length(_16991), 0.0f, 1.75f))).xyz * (1.0f.xxx + (normalize(_8745 + 0.001000000047497451305389404296875f.xxx) * 0.5f))).xyz * _20418).xyz;
	    float4 _13888 = _20490;
	    _13888.x = _15734.x;
	    _13888.y = _15734.y;
	    _13888.z = _15734.z;
	    float4 _6805;
	    if (_Globals_1_g_bFogEnabled != 0)
	    {
	        float3 _21493;
	        float3 _22956 = _7715.xyz - PerViewConstantBuffer_t_1_m3.xyz;
	        float3 _9057 = _22956.xyz;
	        float3 _19340;
	        do
	        {
	            _21493 = _22956.xyz;
	            bool _12886;
	            if (dot(_21493, _21493) > PerViewConstantBufferCsgo_t_1_m14.x)
	            {
	                _12886 = (_7715.z * PerViewConstantBufferCsgo_t_1_m14.z) < PerViewConstantBufferCsgo_t_1_m14.y;
	            }
	            else
	            {
	                _12886 = false;
	            }
	            [branch]
	            if (_12886)
	            {
	                float2 _9342 = clamp(PerViewConstantBufferCsgo_t_1_m11.xy + (PerViewConstantBufferCsgo_t_1_m11.zw * float2(length(_21493), _7715.z)), 0.0f.xx, 1.0f.xx);
	                float _12872 = (pow(_9342.x, PerViewConstantBufferCsgo_t_1_m12.x) * pow(_9342.y, PerViewConstantBufferCsgo_t_1_m12.y)) * PerViewConstantBufferCsgo_t_1_m13.w;
	                _19340 = lerp(_13888.xyz, float4(PerViewConstantBufferCsgo_t_1_m13.xyz, _12872).xyz, _12872.xxx);
	                break;
	            }
	            _19340 = _13888.xyz;
	            break;
	        } while(false);
	        float4 _23944 = _13888;
	        _23944.x = _19340.x;
	        _23944.y = _19340.y;
	        _23944.z = _19340.z;
	        float3 _19341;
	        do
	        {
	            bool _12887;
	            if (dot(_9057, _9057) > PerViewConstantBufferCsgo_t_1_m18.x)
	            {
	                _12887 = (PerViewConstantBufferCsgo_t_1_m18.z * _7715.z) < PerViewConstantBufferCsgo_t_1_m18.y;
	            }
	            else
	            {
	                _12887 = false;
	            }
	            if (_12887)
	            {
	                float _14602 = saturate(pow(max(0.0f, (length(_21493) * PerViewConstantBufferCsgo_t_1_m15.y) + PerViewConstantBufferCsgo_t_1_m15.x), PerViewConstantBufferCsgo_t_1_m15.w)) * saturate(pow(max(0.0f, (_7715.z * PerViewConstantBufferCsgo_t_1_m16.y) + PerViewConstantBufferCsgo_t_1_m16.x), PerViewConstantBufferCsgo_t_1_m16.z));
	                float _8892 = saturate(_14602) * PerViewConstantBufferCsgo_t_1_m18.w;
	                _19341 = lerp(_23944.xyz, float4((g_bindless_TextureCube_float4[PerViewConstantBufferCsgo_t_1_m3].SampleLevel(g_bindless_Sampler[_Globals_1_g_sTrilinearClamp], normalize(mul(float4(_9057, 0.0f), PerViewConstantBufferCsgo_t_1_m17).xyz).xyz, PerViewConstantBufferCsgo_t_1_m16.w * saturate(1.0f - (_14602 * PerViewConstantBufferCsgo_t_1_m15.z))) * PerViewConstantBufferCsgo_t_1_m19.x).xyz, _8892).xyz, _8892.xxx);
	                break;
	            }
	            _19341 = _23944.xyz;
	            break;
	        } while(false);
	        _23944.x = _19341.x;
	        _23944.y = _19341.y;
	        _23944.z = _19341.z;
	        _6805 = _23944;
	    }
	    else
	    {
	        _6805 = _13888;
	    }
	    output_0 = _6805;
	}
	
	PS_OUTPUT MainPs(PS_INPUT stage_input)
	{
	    gl_FragCoord = stage_input.gl_FragCoord;
	    gl_FragCoord.w = 1.0 / gl_FragCoord.w;
	    input_0 = stage_input.input_0;
	    input_1 = stage_input.input_1;
	    input_2 = stage_input.input_2;
	    input_3 = stage_input.input_3;
	    input_4 = stage_input.input_4;
	    input_5 = stage_input.input_5;
	    input_6 = stage_input.input_6;
	    MainPs_inner();
	    PS_OUTPUT stage_output;
	    stage_output.output_0 = output_0;
	    return stage_output;
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
	
	BoolAttribute(BindlessResources, true);
	BoolAttribute(SupportsLightmapping, true);
	BoolAttribute(PerVertexLighting, true);
	BoolAttribute(AllowBackfaceCulling, F_RENDER_BACKFACES ? 0 : 1);
	TextureAttribute(LightSim_DiffuseAlbedoTexture, g_tColorA);
	TextureAttribute(RepresentativeTexture, g_tColorA);
	BoolAttribute(environmentmapped, true);
	BoolAttribute(environmentmappeddynamic, true);
	BoolAttribute(NeedsLightProbe, true);
	BoolAttribute(NoZPrepass, F_DISABLE_Z_PREPASS ? 1 : 0);
	BoolAttribute(DoNotCastShadows, F_DO_NOT_CAST_SHADOWS ? 1 : 0);
	BoolAttribute(SupportsMappingDimensions, true);
	BoolAttribute(renderbackfaces, F_RENDER_BACKFACES ? 1 : 0);
	
	#if (S_ENABLE_TINT_MASKS == 1)
		TextureAttribute(LightSim_TintMaskTextureR, g_tTintMask);
	#endif
	
	// PSRS
	
	RenderState(BackStencilFunc, F_RENDER_BACKFACES ? NotEqual : Always);
	RenderState(CullMode, F_RENDER_BACKFACES ? None : Front);
	RenderState(CullMode, F_RENDER_BACKFACES ? None : Back);
	RenderState(DepthEnable, F_DISABLE_Z_BUFFERING ? false : true);
	RenderState(DepthWriteEnable, F_DISABLE_Z_BUFFERING ? false : true);
	RenderState(StencilEnable, true);
	RenderState(StencilFunc, NotEqual);
	RenderState(StencilReadMask, 1);
	RenderState(StencilRef, 3);
	RenderState(StencilWriteMask, 254);
	
	
	// Variant parameters
	RenderState(CullMode, F_RENDER_BACKFACES ? None : Front);
	RenderState(CullMode, F_RENDER_BACKFACES ? None : Back);
	
	BoolAttribute(BindlessResources, true);
	
}

RTX
{
	StaticCombo( S_MODE_TOOLS_VIS, 0..1 );
	StaticCombo( S_PAINT_VERTEX_COLORS, F_PAINT_VERTEX_COLORS );
	StaticCombo( S_ENABLE_TINT_MASKS, F_ENABLE_TINT_MASKS );
	StaticCombo( S_SHADER_QUALITY, 0..1 );
	StaticComboRule( Allow0( S_MODE_TOOLS_VIS, S_SHADER_QUALITY ) );
	DynamicCombo( D_COMPRESSED_NORMALS_AND_TANGENTS, 0..1 );
	DynamicCombo( D_CS_VERTEX_ANIMATION, 0..1 );
	DynamicCombo( D_BAKED_LIGHTING_FROM_VERTEX_STREAM, 0..1 );
	DynamicCombo( D_BAKED_LIGHTING_FROM_LIGHTMAP, 0..1 );
	DynamicCombo( D_BAKED_LIGHTING_FROM_PROBE, 0..1 );
	DynamicComboRule( Allow1( D_BAKED_LIGHTING_FROM_VERTEX_STREAM, D_BAKED_LIGHTING_FROM_LIGHTMAP ) );
	DynamicComboRule( Allow1( D_BAKED_LIGHTING_FROM_PROBE, D_BAKED_LIGHTING_FROM_VERTEX_STREAM, D_BAKED_LIGHTING_FROM_LIGHTMAP ) );
	DynamicComboRule( Allow0( D_BAKED_LIGHTING_FROM_PROBE, D_BAKED_LIGHTING_FROM_VERTEX_STREAM, D_BAKED_LIGHTING_FROM_LIGHTMAP ) );
	DynamicComboRule( Allow0( D_COMPRESSED_NORMALS_AND_TANGENTS, D_CS_VERTEX_ANIMATION ) );
	
	float g_flReflectance < UiType(Slider); Expression(pow((1.5-1)/(1.5+1),2)); >;
	Texture2D g_tColorA < Channel(RGB, Box(TextureColorA), Srgb); OutputFormat(DXT1); SrgbRead(true); >;
	Texture2D g_tColorB < Channel(RGB, Box(TextureColorB), Srgb); OutputFormat(DXT1); SrgbRead(true); >;
	Texture2D g_tMask < Channel(R, Box(TextureMask), Linear); OutputFormat(ATI1N); SrgbRead(false); >;
	Texture2D g_tNormalA < Channel(RGBA, HemiOctIsoRoughness_RG_B(TextureNormalA, TextureRoughnessA), Linear); OutputFormat(BC7); SrgbRead(false); >;
	Texture2D g_tNormalB < Channel(RGBA, HemiOctIsoRoughness_RG_B(TextureNormalB, TextureRoughnessB), Linear); OutputFormat(BC7); SrgbRead(false); >;
	Texture2D g_tTintMask < Channel(R, Box(TextureTintMaskA), Linear); Channel(G, Box(TextureTintMaskB), Linear); OutputFormat(ATI2N); SrgbRead(false); >;
	float4 g_vTexCoordXform0 < UiType(VectorText); Expression(v0 = g_flTexCoordRotation*3.1415927/180;
		v1 = cos(v0);
		v2 = sin(v0);
		float4(v1*g_vTexCoordScale.x,-v2*g_vTexCoordScale.y,0,g_vTexCoordCenter.x+g_vTexCoordOffset.x+v2*g_vTexCoordCenter.y-v1*g_vTexCoordCenter.x)); >;
	float4 g_vTexCoordXform1 < UiType(VectorText); Expression(v0 = g_flTexCoordRotation*3.1415927/180;
		v1 = cos(v0);
		v2 = sin(v0);
		float4(v2*g_vTexCoordScale.x,v1*g_vTexCoordScale.y,0,g_vTexCoordCenter.y+g_vTexCoordOffset.y-(v2*g_vTexCoordCenter.x+v1*g_vTexCoordCenter.y))); >;
	
	// Material A
	CreateInputTexture2D(TextureColorA, Srgb, 8, "", "_color", "Material A,10/10", Default4(1, 1, 1, 0));
	CreateInputTexture2D(TextureNormalA, Linear, 8, "NormalizeNormals", "_normal", "Material A,10/20", Default4(0.5, 0.5, 1, 0));
	CreateInputTexture2D(TextureRoughnessA, Linear, 8, "Inverse", "_rough", "Material A,10/30", Default4(0.5, 0.5, 0.5, 0));
	CreateInputTexture2D(TextureTintMaskA, Linear, 8, "", "_mask", "Material A,10/50", Default4(1, 1, 1, 0));
	float g_flMetalnessA < UiType(Slider); UiGroup("Material A,10/60"); >;
	
	// Material B
	float2 g_vTexCoordScale2 < Default2(1, 1); Range2(0, 0, 100, 100); UiType(VectorText); UiGroup("Material B,100"); >;
	CreateInputTexture2D(TextureColorB, Srgb, 8, "", "_color", "Material B,20/10", Default4(1, 1, 1, 0));
	CreateInputTexture2D(TextureNormalB, Linear, 8, "NormalizeNormals", "_normal", "Material B,20/20", Default4(0.5, 0.5, 1, 0));
	CreateInputTexture2D(TextureRoughnessB, Linear, 8, "Inverse", "_rough", "Material B,20/30", Default4(0.5, 0.5, 0.5, 0));
	CreateInputTexture2D(TextureTintMaskB, Linear, 8, "", "_mask", "Material B,10/50", Default4(1, 1, 1, 0));
	float g_flMetalnessB < UiType(Slider); UiGroup("Material B,20/60"); >;
	
	// Mask
	CreateInputTexture2D(TextureMask, Linear, 8, "", "_mask", "Mask,30/10", Default4(1, 1, 1, 0));
	
	// Color
	float3 g_vColorTint < Default3(1, 1, 1); UiType(Color); UiGroup("Color,10/20"); Expression(SrgbGammaToLinear(this)); >;
	float g_flModelTintAmount < Default(1); UiType(Slider); UiGroup("Color,10/30"); >;
	float2 g_vTexCoordCenter < Default2(0.5, 0.5); UiType(VectorText); UiGroup("Color/30"); >;
	float2 g_vTexCoordScale < Default2(1, 1); Range2(0, 0, 100, 100); UiType(VectorText); UiGroup("Color/40"); >;
	float g_flTexCoordRotation < Range(-360, 360); UiType(Slider); UiGroup("Color/50"); >;
	float2 g_vTexCoordOffset < Range2(-1, -1, 1, 1); UiType(VectorText); UiGroup("Color/60"); >;
	float2 g_vTexCoordScrollSpeed < Range2(-10, -10, 10, 10); UiType(VectorText); UiGroup("Color/70"); >;
	int g_nScaleTexCoordUByModelScaleAxis < Range4(0, 0, 0, 0, 3, 3, 3, 3); UiOptions("0=None,1=UV.u * model.x,2=UV.u * model.y,3=UV.u * model.z"); UiType(Enum); UiGroup("Color/80"); >;
	int g_nScaleTexCoordVByModelScaleAxis < Range4(0, 0, 0, 0, 3, 3, 3, 3); UiOptions("0=None,1=UV.v * model.x,2=UV.v * model.y,3=UV.v * model.z"); UiType(Enum); UiGroup("Color/90"); >;
	
	// Texture Address Mode
	int g_nTextureAddressModeU < UiOption("RsTextureAddressMode_t"); UiType(Enum); UiGroup("Texture Address Mode"); >;
	int g_nTextureAddressModeV < UiOption("RsTextureAddressMode_t"); UiType(Enum); UiGroup("Texture Address Mode"); >;
	
	
	// Variant parameters
	
	// SPIR-V reflection failed for backend HLSL:
	// Unsupported builtin in HLSL: 5326
	//
	// Re-attempting reflection with the GLSL backend.
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, GLSL reflection with SPIRV-Cross by KhronosGroup
	
	#version 460
	#extension GL_EXT_shader_explicit_arithmetic_types_int16 : require
	#extension GL_EXT_shader_16bit_storage : require
	#if defined(GL_AMD_gpu_shader_half_float)
	#extension GL_AMD_gpu_shader_half_float : require
	#elif defined(GL_EXT_shader_explicit_arithmetic_types_float16)
	#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
	#else
	#error No extension available for FP16.
	#endif
	#extension GL_EXT_ray_tracing : require
	#extension GL_EXT_nonuniform_qualifier : require
	
	struct VS_INPUT
	{
	    vec3 vPositionOs;
	    vec2 vTexCoord;
	    vec3 vNormalOs;
	    vec4 vTangentUOs_flTangentVSign;
	    uvec4 vBlendIndices;
	    uint nInstanceIdx;
	    vec4 vBlendValues;
	};
	
	struct PackedRtxInstanceData_t_natural
	{
	    uint nSrgbColor;
	    uint nTriangleGeometry;
	    uint nMaterialData;
	    uint nMaterialFlags_nInstanceFlags;
	    float fEmissiveBoost;
	    uint nInstanceFlags;
	    uint _pad1;
	    uint _pad2;
	};
	
	struct _Array_natural_vector_int_4_8
	{
	    ivec4 data[8];
	};
	
	struct GeometryInfo_t_natural
	{
	    ivec4 m_nVertexAndIndexBuffers;
	    ivec4 m_nBufferBindOffsetBytes;
	    ivec4 m_nBufferStrideInBytes;
	    ivec4 m_vNormalFieldInfo;
	    ivec4 m_vTangentFieldInfo;
	    _Array_natural_vector_int_4_8 m_vTexCoordFieldInfo;
	    _Array_natural_vector_int_4_8 m_vColorFieldInfo;
	};
	
	struct BuiltInTriangleIntersectionAttributes
	{
	    vec2 barycentrics;
	};
	
	struct MaterialDataMinimal_t
	{
	    f16vec3 vNormalWs;
	    float16_t flMetalness;
	    f16vec3 vAlbedo;
	    float16_t flRoughness;
	    f16vec3 vEmissive;
	    float16_t flReflectance;
	    uint nMaterialTypeAndFlags;
	    f16vec4 vMaterialBits;
	};
	
	struct Payload_t
	{
	    vec3 vSmoothPositionWs;
	    vec3 vFaceNormalWs;
	    vec3 vInterpolatedNormalWs;
	    float flHitT;
	    float flOpacityRng;
	    int nInstance;
	    bool bFlippedNormal;
	    MaterialDataMinimal_t material;
	};
	
	vec4 _491;
	
	struct PayloadShadow_t
	{
	    float m_flVisibility;
	};
	
	layout(set = 3, binding = 35, std430) readonly buffer StructuredBuffer
	{
	    PackedRtxInstanceData_t_natural _member0[];
	} g_instanceBuffer;
	
	layout(set = 3, binding = 34, std430) readonly buffer g_MaterialData
	{
	    float _member0[];
	} g_MaterialData_1;
	
	layout(set = 3, binding = 34, std430) readonly buffer g_MaterialData_2
	{
	    uint _member0[];
	} g_MaterialData_3;
	
	layout(set = 3, binding = 31, std430) readonly buffer g_Geometries
	{
	    GeometryInfo_t_natural _member0[];
	} g_Geometries_1;
	
	layout(set = 3, binding = 33, std430) readonly buffer g_Indices
	{
	    uint _member0[];
	} g_Indices_1[];
	
	layout(set = 3, binding = 32, std430) readonly buffer g_Vertices
	{
	    float _member0[];
	} g_Vertices_1[];
	
	layout(set = 3, binding = 32, std430) readonly buffer g_Vertices_2
	{
	    uint _member0[];
	} g_Vertices_3[];
	
	struct SLANG_ParameterGroup_PerViewConstantBuffer_t_natural
	{
	    mat4 g_matWorldToProjection;
	    mat4 g_matProjectionToWorld;
	    mat4 g_matWorldToView;
	    mat4 g_matViewToProjection;
	    vec4 g_vInvProjLowerRight2x2;
	    vec4 g_vClipPlane0;
	    float g_flToneMapScalarLinear;
	    float g_flInvToneMapScalarLinear;
	    float g_flRealTime;
	    float g_flGameTime;
	    vec2 g_vViewportToGBufferRatio;
	    float g_fInvViewportZRange;
	    float g_fMinViewportZScaled;
	    vec2 g_vViewportOffset;
	    vec2 g_vViewportSize;
	    vec2 g_vInvViewportSize;
	    vec2 g_vRenderTargetSize;
	    vec4 g_vInvGBufferSize;
	    float g_flViewportMinZ;
	    float g_flViewportMaxZ;
	    float g_flNearPlane;
	    float g_flFarPlane;
	    vec4 g_vWorldToCameraOffset;
	    vec4 g_vCameraAngles;
	    vec3 g_vCameraPositionWs;
	    float _PerViewPad0;
	    vec3 g_vCameraUpDirWs;
	    float _PerViewPad1;
	    vec3 g_vCameraDirWs;
	    float g_flInvMSAASampleCount;
	    vec3 g_vDepthPsToVsConversion;
	    int g_nMSAASampleCount;
	    vec2 g_vMorphTextureAtlasSize;
	    uint g_tCompositeMorphAtlasTextureIndex;
	    float _PerViewPad4;
	    vec3 g_vFogColor;
	    float g_flNegFogStartOverFogRange;
	    float g_flInvFogRange;
	    float g_flFogMaxDensity;
	    float g_flFogExponent;
	    float g_flFogBlendToBackground;
	    vec4 g_vFrameBufferCopyInvSizeAndUvScale;
	    vec4 g_vPrevWorldToCameraOffset;
	    mat4 g_matPrevWorldToProjection;
	    vec4 g_vWireframeColor;
	};
	
	layout(set = 5) uniform SLANG_ParameterGroup_PerViewConstantBuffer_t_natural PerViewConstantBuffer_t;
	
	hitAttributeEXT BuiltInTriangleIntersectionAttributes attrs;
	layout(set = 4, binding = 46) uniform texture2D g_bindless_Texture2D_float4[65536];
	layout(set = 4, binding = 29) uniform sampler g_bindless_Sampler[2048];
	layout(location = 0) rayPayloadInEXT Payload_t payload;
	
	void main()
	{
	    uint _523 = g_instanceBuffer._member0[uint(gl_InstanceID)].nMaterialData;
	    vec4 _569 = vec4(g_MaterialData_1._member0[(_523 + 112u) / 4u], g_MaterialData_1._member0[(_523 + 116u) / 4u], g_MaterialData_1._member0[(_523 + 120u) / 4u], g_MaterialData_1._member0[(_523 + 124u) / 4u]);
	    vec4 _568 = vec4(g_MaterialData_1._member0[(_523 + 128u) / 4u], g_MaterialData_1._member0[(_523 + 132u) / 4u], g_MaterialData_1._member0[(_523 + 136u) / 4u], g_MaterialData_1._member0[(_523 + 140u) / 4u]);
	    vec2 _567 = vec2(g_MaterialData_1._member0[(_523 + 144u) / 4u], g_MaterialData_1._member0[(_523 + 148u) / 4u]);
	    vec3 _566 = vec3(g_MaterialData_1._member0[(_523 + 208u) / 4u], g_MaterialData_1._member0[(_523 + 212u) / 4u], g_MaterialData_1._member0[(_523 + 216u) / 4u]);
	    float _565 = g_MaterialData_1._member0[(_523 + 220u) / 4u];
	    uint _564 = g_MaterialData_3._member0[(_523 + 236u) / 4u];
	    uint _563 = g_MaterialData_3._member0[(_523 + 256u) / 4u];
	    float _562 = g_MaterialData_1._member0[(_523 + 284u) / 4u];
	    float _561 = g_MaterialData_1._member0[(_523 + 288u) / 4u];
	    vec2 _560 = vec2(g_MaterialData_1._member0[(_523 + 296u) / 4u], g_MaterialData_1._member0[(_523 + 300u) / 4u]);
	    uint _559 = g_MaterialData_3._member0[(_523 + 304u) / 4u];
	    uint _558 = g_MaterialData_3._member0[(_523 + 308u) / 4u];
	    uint _557 = g_MaterialData_3._member0[(_523 + 312u) / 4u];
	    uint _556 = g_MaterialData_3._member0[(_523 + 316u) / 4u];
	    uint _555 = g_MaterialData_3._member0[(_523 + 320u) / 4u];
	    float _554 = g_MaterialData_1._member0[(_523 + 336u) / 4u];
	    uvec3 _652;
	    do
	    {
	        if (g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nBufferStrideInBytes.w == 4)
	        {
	            uint _814 = (12u * uint(gl_PrimitiveID)) + uint(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nBufferBindOffsetBytes.w);
	            _652 = uvec3(g_Indices_1[nonuniformEXT(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nVertexAndIndexBuffers.w)]._member0[_814 / 4u], g_Indices_1[nonuniformEXT(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nVertexAndIndexBuffers.w)]._member0[(_814 + 4u) / 4u], g_Indices_1[nonuniformEXT(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nVertexAndIndexBuffers.w)]._member0[(_814 + 8u) / 4u]);
	            break;
	        }
	        else
	        {
	            uint _793 = (6u * uint(gl_PrimitiveID)) + uint(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nBufferBindOffsetBytes.w);
	            uint _794 = _793 & 4294967292u;
	            uint _51 = _794 / 4u;
	            uint _54 = (_794 + 4u) / 4u;
	            uint _798 = (g_Indices_1[nonuniformEXT(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nVertexAndIndexBuffers.w)]._member0[_51] & 4294901760u) >> uint(16);
	            uint _799 = g_Indices_1[nonuniformEXT(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nVertexAndIndexBuffers.w)]._member0[_54] & 65535u;
	            uvec3 _653;
	            if (_793 == _794)
	            {
	                _653 = uvec3(g_Indices_1[nonuniformEXT(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nVertexAndIndexBuffers.w)]._member0[_51] & 65535u, _798, _799);
	            }
	            else
	            {
	                _653 = uvec3(_798, _799, (g_Indices_1[nonuniformEXT(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nVertexAndIndexBuffers.w)]._member0[_54] & 4294901760u) >> uint(16));
	            }
	            _652 = _653;
	            break;
	        }
	        break;
	    } while(false);
	    uint _67 = uint(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nVertexAndIndexBuffers.x);
	    uvec3 _836 = (uvec3(uint(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nBufferStrideInBytes.x)) * _652) + uvec3(uint(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nBufferBindOffsetBytes.x));
	    vec3 _647[3];
	    uint _838 = _836.x;
	    _647[0] = vec3(g_Vertices_1[nonuniformEXT(_67)]._member0[_838 / 4u], g_Vertices_1[nonuniformEXT(_67)]._member0[(_838 + 4u) / 4u], g_Vertices_1[nonuniformEXT(_67)]._member0[(_838 + 8u) / 4u]);
	    uint _843 = _836.y;
	    _647[1] = vec3(g_Vertices_1[nonuniformEXT(_67)]._member0[_843 / 4u], g_Vertices_1[nonuniformEXT(_67)]._member0[(_843 + 4u) / 4u], g_Vertices_1[nonuniformEXT(_67)]._member0[(_843 + 8u) / 4u]);
	    uint _848 = _836.z;
	    _647[2] = vec3(g_Vertices_1[nonuniformEXT(_67)]._member0[_848 / 4u], g_Vertices_1[nonuniformEXT(_67)]._member0[(_848 + 4u) / 4u], g_Vertices_1[nonuniformEXT(_67)]._member0[(_848 + 8u) / 4u]);
	    int _648 = 0;
	    VS_INPUT vsInput[3];
	    for (;;)
	    {
	        if (!(_648 < 3))
	        {
	            break;
	        }
	        vsInput[_648].vPositionOs = _647[_648];
	        _648++;
	        continue;
	    }
	    vec2 _649[3];
	    _649[0] = vec2(0.0);
	    _649[1] = vec2(0.0);
	    _649[2] = vec2(0.0);
	    if (g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vTexCoordFieldInfo.data[0].y != 0)
	    {
	        ivec4 _646 = g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nVertexAndIndexBuffers;
	        uint _96 = uint(_646[g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vTexCoordFieldInfo.data[0].z]);
	        uint _890 = uint(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vTexCoordFieldInfo.data[0].z);
	        ivec4 _644 = g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nBufferStrideInBytes;
	        ivec4 _645 = g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nBufferBindOffsetBytes;
	        uvec3 _906 = (uvec3(uint(_644[_890])) * _652) + uvec3(uint(_645[_890]) + uint(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vTexCoordFieldInfo.data[0].x));
	        if (g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vTexCoordFieldInfo.data[0].y == 16)
	        {
	            uint _1020 = _906.x;
	            _649[0] = vec2(g_Vertices_1[nonuniformEXT(_96)]._member0[_1020 / 4u], g_Vertices_1[nonuniformEXT(_96)]._member0[(_1020 + 4u) / 4u]);
	            uint _1023 = _906.y;
	            _649[1] = vec2(g_Vertices_1[nonuniformEXT(_96)]._member0[_1023 / 4u], g_Vertices_1[nonuniformEXT(_96)]._member0[(_1023 + 4u) / 4u]);
	            uint _1026 = _906.z;
	            _649[2] = vec2(g_Vertices_1[nonuniformEXT(_96)]._member0[_1026 / 4u], g_Vertices_1[nonuniformEXT(_96)]._member0[(_1026 + 4u) / 4u]);
	        }
	        else
	        {
	            if (g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vTexCoordFieldInfo.data[0].y == 34)
	            {
	                uint _108 = _906.x / 4u;
	                _649[0] = vec2(uint16BitsToFloat16(u16vec2(uvec2(g_Vertices_3[nonuniformEXT(_96)]._member0[_108], g_Vertices_3[nonuniformEXT(_96)]._member0[_108] >> uint(16)) & uvec2(65535u))));
	                uint _111 = _906.y / 4u;
	                _649[1] = vec2(uint16BitsToFloat16(u16vec2(uvec2(g_Vertices_3[nonuniformEXT(_96)]._member0[_111], g_Vertices_3[nonuniformEXT(_96)]._member0[_111] >> uint(16)) & uvec2(65535u))));
	                uint _114 = _906.z / 4u;
	                _649[2] = vec2(uint16BitsToFloat16(u16vec2(uvec2(g_Vertices_3[nonuniformEXT(_96)]._member0[_114], g_Vertices_3[nonuniformEXT(_96)]._member0[_114] >> uint(16)) & uvec2(65535u))));
	            }
	            else
	            {
	                if (g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vTexCoordFieldInfo.data[0].y == 37)
	                {
	                    uint _98 = _906.x / 4u;
	                    uint _919 = g_Vertices_3[nonuniformEXT(_96)]._member0[_98] & 65535u;
	                    int _643;
	                    if (_919 > 32767u)
	                    {
	                        _643 = int(4294901760u | _919);
	                    }
	                    else
	                    {
	                        _643 = int(_919);
	                    }
	                    uint _932 = (g_Vertices_3[nonuniformEXT(_96)]._member0[_98] & 4294901760u) >> uint(16);
	                    int _642;
	                    if (_932 > 32767u)
	                    {
	                        _642 = int(4294901760u | _932);
	                    }
	                    else
	                    {
	                        _642 = int(_932);
	                    }
	                    _649[0] = vec2(max(float(_643) * 3.0518509447574615478515625e-05, -1.0), max(float(_642) * 3.0518509447574615478515625e-05, -1.0));
	                    uint _101 = _906.y / 4u;
	                    uint _946 = g_Vertices_3[nonuniformEXT(_96)]._member0[_101] & 65535u;
	                    int _641;
	                    if (_946 > 32767u)
	                    {
	                        _641 = int(4294901760u | _946);
	                    }
	                    else
	                    {
	                        _641 = int(_946);
	                    }
	                    uint _959 = (g_Vertices_3[nonuniformEXT(_96)]._member0[_101] & 4294901760u) >> uint(16);
	                    int _640;
	                    if (_959 > 32767u)
	                    {
	                        _640 = int(4294901760u | _959);
	                    }
	                    else
	                    {
	                        _640 = int(_959);
	                    }
	                    _649[1] = vec2(max(float(_641) * 3.0518509447574615478515625e-05, -1.0), max(float(_640) * 3.0518509447574615478515625e-05, -1.0));
	                    uint _104 = _906.z / 4u;
	                    uint _973 = g_Vertices_3[nonuniformEXT(_96)]._member0[_104] & 65535u;
	                    int _639;
	                    if (_973 > 32767u)
	                    {
	                        _639 = int(4294901760u | _973);
	                    }
	                    else
	                    {
	                        _639 = int(_973);
	                    }
	                    uint _986 = (g_Vertices_3[nonuniformEXT(_96)]._member0[_104] & 4294901760u) >> uint(16);
	                    int _638;
	                    if (_986 > 32767u)
	                    {
	                        _638 = int(4294901760u | _986);
	                    }
	                    else
	                    {
	                        _638 = int(_986);
	                    }
	                    _649[2] = vec2(max(float(_639) * 3.0518509447574615478515625e-05, -1.0), max(float(_638) * 3.0518509447574615478515625e-05, -1.0));
	                }
	            }
	        }
	    }
	    _648 = 0;
	    for (;;)
	    {
	        if (!(_648 < 3))
	        {
	            break;
	        }
	        vsInput[_648].vTexCoord = _649[_648];
	        _648++;
	        continue;
	    }
	    vec3 _650[3];
	    vec4 _651[3];
	    do
	    {
	        if (g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vNormalFieldInfo.y != 0)
	        {
	            ivec4 _624 = g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nVertexAndIndexBuffers;
	            uint _136 = uint(_624[g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vNormalFieldInfo.z]);
	            uint _1070 = uint(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vNormalFieldInfo.z);
	            ivec4 _622 = g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nBufferStrideInBytes;
	            ivec4 _623 = g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nBufferBindOffsetBytes;
	            uvec3 _1086 = (uvec3(uint(_622[_1070])) * _652) + uvec3(uint(_623[_1070]) + uint(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vNormalFieldInfo.x));
	            if (g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vNormalFieldInfo.y == 6)
	            {
	                uint _1587 = _1086.x;
	                _650[0] = vec3(g_Vertices_1[nonuniformEXT(_136)]._member0[_1587 / 4u], g_Vertices_1[nonuniformEXT(_136)]._member0[(_1587 + 4u) / 4u], g_Vertices_1[nonuniformEXT(_136)]._member0[(_1587 + 8u) / 4u]);
	                uint _1592 = _1086.y;
	                _650[1] = vec3(g_Vertices_1[nonuniformEXT(_136)]._member0[_1592 / 4u], g_Vertices_1[nonuniformEXT(_136)]._member0[(_1592 + 4u) / 4u], g_Vertices_1[nonuniformEXT(_136)]._member0[(_1592 + 8u) / 4u]);
	                uint _1597 = _1086.z;
	                _650[2] = vec3(g_Vertices_1[nonuniformEXT(_136)]._member0[_1597 / 4u], g_Vertices_1[nonuniformEXT(_136)]._member0[(_1597 + 4u) / 4u], g_Vertices_1[nonuniformEXT(_136)]._member0[(_1597 + 8u) / 4u]);
	            }
	            else
	            {
	                if (g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vNormalFieldInfo.y == 17)
	                {
	                    uint _1341 = _1086.x;
	                    uvec2 _1343 = uvec2(g_Vertices_3[nonuniformEXT(_136)]._member0[_1341 / 4u], g_Vertices_3[nonuniformEXT(_136)]._member0[(_1341 + 4u) / 4u]);
	                    uint _1344 = _1086.y;
	                    uvec2 _511 = uvec2(g_Vertices_3[nonuniformEXT(_136)]._member0[_1344 / 4u], g_Vertices_3[nonuniformEXT(_136)]._member0[(_1344 + 4u) / 4u]);
	                    uint _1347 = _1086.z;
	                    uvec2 _510 = uvec2(g_Vertices_3[nonuniformEXT(_136)]._member0[_1347 / 4u], g_Vertices_3[nonuniformEXT(_136)]._member0[(_1347 + 4u) / 4u]);
	                    uint _1353 = _1343.x;
	                    uint _1361 = _1343.y;
	                    vec2 _1371 = ((vec2(float(_1353 & 65535u), float((_1353 >> 16u) & 65535u)) * vec2(1.525902189314365386962890625e-05)) * 2.0) - vec2(1.0);
	                    float _1372 = _1371.x;
	                    float _1377 = (1.0 - abs(_1372)) - abs(_1371.y);
	                    vec3 _1378 = vec3(_1372, _1371.y, _1377);
	                    float _1380 = saturate(-_1377);
	                    vec2 _1386 = _1371 + mix(vec2(_1380), vec2(-_1380), greaterThanEqual(_1371, vec2(0.0)));
	                    _1378.x = _1386.x;
	                    _1378.y = _1386.y;
	                    vec3 _626 = normalize(_1378);
	                    vec2 _1393 = ((vec2(float((_1361 >> uint(1)) & 32767u), float((_1361 >> 16u) & 32767u)) * vec2(3.0518509447574615478515625e-05)) * 2.0) - vec2(1.0);
	                    float _1394 = _1393.x;
	                    float _1399 = (1.0 - abs(_1394)) - abs(_1393.y);
	                    vec3 _1400 = vec3(_1394, _1393.y, _1399);
	                    float _1402 = saturate(-_1399);
	                    vec2 _1408 = _1393 + mix(vec2(_1402), vec2(-_1402), greaterThanEqual(_1393, vec2(0.0)));
	                    _1400.x = _1408.x;
	                    _1400.y = _1408.y;
	                    vec3 _625 = normalize(_1400);
	                    float _612;
	                    if ((_1361 & 1u) != 0u)
	                    {
	                        _612 = 1.0;
	                    }
	                    else
	                    {
	                        _612 = -1.0;
	                    }
	                    _650[0] = _626;
	                    _651[0].w = _612;
	                    _651[0].x = _625.x;
	                    _651[0].y = _625.y;
	                    _651[0].z = _625.z;
	                    vec2 _1450 = ((vec2(float(_511.x & 65535u), float((_511.x >> 16u) & 65535u)) * vec2(1.525902189314365386962890625e-05)) * 2.0) - vec2(1.0);
	                    float _1451 = _1450.x;
	                    float _1456 = (1.0 - abs(_1451)) - abs(_1450.y);
	                    vec3 _1457 = vec3(_1451, _1450.y, _1456);
	                    float _1459 = saturate(-_1456);
	                    vec2 _1465 = _1450 + mix(vec2(_1459), vec2(-_1459), greaterThanEqual(_1450, vec2(0.0)));
	                    _1457.x = _1465.x;
	                    _1457.y = _1465.y;
	                    vec3 _628 = normalize(_1457);
	                    vec2 _1472 = ((vec2(float((_511.y >> uint(1)) & 32767u), float((_511.y >> 16u) & 32767u)) * vec2(3.0518509447574615478515625e-05)) * 2.0) - vec2(1.0);
	                    float _1473 = _1472.x;
	                    float _1478 = (1.0 - abs(_1473)) - abs(_1472.y);
	                    vec3 _1479 = vec3(_1473, _1472.y, _1478);
	                    float _1481 = saturate(-_1478);
	                    vec2 _1487 = _1472 + mix(vec2(_1481), vec2(-_1481), greaterThanEqual(_1472, vec2(0.0)));
	                    _1479.x = _1487.x;
	                    _1479.y = _1487.y;
	                    vec3 _627 = normalize(_1479);
	                    float _611;
	                    if ((_511.y & 1u) != 0u)
	                    {
	                        _611 = 1.0;
	                    }
	                    else
	                    {
	                        _611 = -1.0;
	                    }
	                    _650[1] = _628;
	                    _651[1].w = _611;
	                    _651[1].x = _627.x;
	                    _651[1].y = _627.y;
	                    _651[1].z = _627.z;
	                    vec2 _1529 = ((vec2(float(_510.x & 65535u), float((_510.x >> 16u) & 65535u)) * vec2(1.525902189314365386962890625e-05)) * 2.0) - vec2(1.0);
	                    float _1530 = _1529.x;
	                    float _1535 = (1.0 - abs(_1530)) - abs(_1529.y);
	                    vec3 _1536 = vec3(_1530, _1529.y, _1535);
	                    float _1538 = saturate(-_1535);
	                    vec2 _1544 = _1529 + mix(vec2(_1538), vec2(-_1538), greaterThanEqual(_1529, vec2(0.0)));
	                    _1536.x = _1544.x;
	                    _1536.y = _1544.y;
	                    vec3 _630 = normalize(_1536);
	                    vec2 _1551 = ((vec2(float((_510.y >> uint(1)) & 32767u), float((_510.y >> 16u) & 32767u)) * vec2(3.0518509447574615478515625e-05)) * 2.0) - vec2(1.0);
	                    float _1552 = _1551.x;
	                    float _1557 = (1.0 - abs(_1552)) - abs(_1551.y);
	                    vec3 _1558 = vec3(_1552, _1551.y, _1557);
	                    float _1560 = saturate(-_1557);
	                    vec2 _1566 = _1551 + mix(vec2(_1560), vec2(-_1560), greaterThanEqual(_1551, vec2(0.0)));
	                    _1558.x = _1566.x;
	                    _1558.y = _1566.y;
	                    vec3 _629 = normalize(_1558);
	                    float _610;
	                    if ((_510.y & 1u) != 0u)
	                    {
	                        _610 = 1.0;
	                    }
	                    else
	                    {
	                        _610 = -1.0;
	                    }
	                    _650[2] = _630;
	                    _651[2].w = _610;
	                    _651[2].x = _629.x;
	                    _651[2].y = _629.y;
	                    _651[2].z = _629.z;
	                    break;
	                }
	                else
	                {
	                    uint _138 = _1086.x / 4u;
	                    vec4 _632 = _651[0];
	                    float _1108 = (float((g_Vertices_3[nonuniformEXT(_136)]._member0[_138] >> 12u) & 1023u) * 0.00195503421127796173095703125) - 1.0;
	                    float _1111 = (float((g_Vertices_3[nonuniformEXT(_136)]._member0[_138] >> 22u) & 1023u) * 0.00195503421127796173095703125) - 1.0;
	                    float _1115 = (1.0 - abs(_1108)) - abs(_1111);
	                    vec3 _1116 = vec3(_1108, _1111, _1115);
	                    float _1118 = saturate(-_1115);
	                    vec2 _1119 = vec2(_1108, _1111);
	                    vec2 _1125 = _1119 + mix(vec2(_1118), vec2(-_1118), greaterThanEqual(_1119, vec2(0.0)));
	                    _1116.x = _1125.x;
	                    _1116.y = _1125.y;
	                    vec3 _1130 = normalize(_1116);
	                    vec3 _631 = _1130;
	                    float _1131 = _1130.z;
	                    float _619;
	                    if (_1131 >= 0.0)
	                    {
	                        _619 = 1.0;
	                    }
	                    else
	                    {
	                        _619 = -1.0;
	                    }
	                    float _1138 = (-1.0) / (_619 + _1131);
	                    float _1139 = _1130.x;
	                    vec3 _620;
	                    vec3 _1147 = _620;
	                    _1147.x = 1.0 + (((_619 * _1139) * _1139) * _1138);
	                    _1147.y = _619 * ((_1139 * _1130.y) * _1138);
	                    _1147.z = (-_619) * _1139;
	                    _620 = _1147;
	                    float _1155 = float((g_Vertices_3[nonuniformEXT(_136)]._member0[_138] >> uint(1)) & 2047u) * 0.003069460391998291015625;
	                    vec3 _1161 = (_1147 * cos(_1155)) + (cross(_1130, _1147) * sin(_1155));
	                    vec4 _1163 = _632;
	                    _1163.x = _1161.x;
	                    _1163.y = _1161.y;
	                    _1163.z = _1161.z;
	                    _632 = _1163;
	                    float _621;
	                    if ((g_Vertices_3[nonuniformEXT(_136)]._member0[_138] & 1u) == 0u)
	                    {
	                        _621 = -1.0;
	                    }
	                    else
	                    {
	                        _621 = 1.0;
	                    }
	                    vec4 _1174 = _632;
	                    _1174.w = _621;
	                    _632 = _1174;
	                    _650[0] = _631;
	                    _651[0] = _1174;
	                    uint _141 = _1086.y / 4u;
	                    vec4 _634 = _651[1];
	                    float _1190 = (float((g_Vertices_3[nonuniformEXT(_136)]._member0[_141] >> 12u) & 1023u) * 0.00195503421127796173095703125) - 1.0;
	                    float _1193 = (float((g_Vertices_3[nonuniformEXT(_136)]._member0[_141] >> 22u) & 1023u) * 0.00195503421127796173095703125) - 1.0;
	                    float _1197 = (1.0 - abs(_1190)) - abs(_1193);
	                    vec3 _1198 = vec3(_1190, _1193, _1197);
	                    float _1200 = saturate(-_1197);
	                    vec2 _1201 = vec2(_1190, _1193);
	                    vec2 _1207 = _1201 + mix(vec2(_1200), vec2(-_1200), greaterThanEqual(_1201, vec2(0.0)));
	                    _1198.x = _1207.x;
	                    _1198.y = _1207.y;
	                    vec3 _1212 = normalize(_1198);
	                    vec3 _633 = _1212;
	                    float _1213 = _1212.z;
	                    float _616;
	                    if (_1213 >= 0.0)
	                    {
	                        _616 = 1.0;
	                    }
	                    else
	                    {
	                        _616 = -1.0;
	                    }
	                    float _1220 = (-1.0) / (_616 + _1213);
	                    float _1221 = _1212.x;
	                    vec3 _617;
	                    vec3 _1229 = _617;
	                    _1229.x = 1.0 + (((_616 * _1221) * _1221) * _1220);
	                    _1229.y = _616 * ((_1221 * _1212.y) * _1220);
	                    _1229.z = (-_616) * _1221;
	                    _617 = _1229;
	                    float _1237 = float((g_Vertices_3[nonuniformEXT(_136)]._member0[_141] >> uint(1)) & 2047u) * 0.003069460391998291015625;
	                    vec3 _1243 = (_1229 * cos(_1237)) + (cross(_1212, _1229) * sin(_1237));
	                    vec4 _1245 = _634;
	                    _1245.x = _1243.x;
	                    _1245.y = _1243.y;
	                    _1245.z = _1243.z;
	                    _634 = _1245;
	                    float _618;
	                    if ((g_Vertices_3[nonuniformEXT(_136)]._member0[_141] & 1u) == 0u)
	                    {
	                        _618 = -1.0;
	                    }
	                    else
	                    {
	                        _618 = 1.0;
	                    }
	                    vec4 _1256 = _634;
	                    _1256.w = _618;
	                    _634 = _1256;
	                    _650[1] = _633;
	                    _651[1] = _1256;
	                    uint _144 = _1086.z / 4u;
	                    vec4 _636 = _651[2];
	                    float _1272 = (float((g_Vertices_3[nonuniformEXT(_136)]._member0[_144] >> 12u) & 1023u) * 0.00195503421127796173095703125) - 1.0;
	                    float _1275 = (float((g_Vertices_3[nonuniformEXT(_136)]._member0[_144] >> 22u) & 1023u) * 0.00195503421127796173095703125) - 1.0;
	                    float _1279 = (1.0 - abs(_1272)) - abs(_1275);
	                    vec3 _1280 = vec3(_1272, _1275, _1279);
	                    float _1282 = saturate(-_1279);
	                    vec2 _1283 = vec2(_1272, _1275);
	                    vec2 _1289 = _1283 + mix(vec2(_1282), vec2(-_1282), greaterThanEqual(_1283, vec2(0.0)));
	                    _1280.x = _1289.x;
	                    _1280.y = _1289.y;
	                    vec3 _1294 = normalize(_1280);
	                    vec3 _635 = _1294;
	                    float _1295 = _1294.z;
	                    float _613;
	                    if (_1295 >= 0.0)
	                    {
	                        _613 = 1.0;
	                    }
	                    else
	                    {
	                        _613 = -1.0;
	                    }
	                    float _1302 = (-1.0) / (_613 + _1295);
	                    float _1303 = _1294.x;
	                    vec3 _614;
	                    vec3 _1311 = _614;
	                    _1311.x = 1.0 + (((_613 * _1303) * _1303) * _1302);
	                    _1311.y = _613 * ((_1303 * _1294.y) * _1302);
	                    _1311.z = (-_613) * _1303;
	                    _614 = _1311;
	                    float _1319 = float((g_Vertices_3[nonuniformEXT(_136)]._member0[_144] >> uint(1)) & 2047u) * 0.003069460391998291015625;
	                    vec3 _1325 = (_1311 * cos(_1319)) + (cross(_1294, _1311) * sin(_1319));
	                    vec4 _1327 = _636;
	                    _1327.x = _1325.x;
	                    _1327.y = _1325.y;
	                    _1327.z = _1325.z;
	                    _636 = _1327;
	                    float _615;
	                    if ((g_Vertices_3[nonuniformEXT(_136)]._member0[_144] & 1u) == 0u)
	                    {
	                        _615 = -1.0;
	                    }
	                    else
	                    {
	                        _615 = 1.0;
	                    }
	                    vec4 _1338 = _636;
	                    _1338.w = _615;
	                    _636 = _1338;
	                    _650[2] = _635;
	                    _651[2] = _1338;
	                    break;
	                }
	                break;
	            }
	        }
	        else
	        {
	            _650[0] = vec3(0.0);
	            _650[1] = vec3(0.0);
	            _650[2] = vec3(0.0);
	        }
	        if (g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vTangentFieldInfo.y != 0)
	        {
	            ivec4 _637 = g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nVertexAndIndexBuffers;
	            uint _194 = uint(_637[g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vTangentFieldInfo.z]);
	            uint _1616 = uint(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vTangentFieldInfo.z);
	            ivec4 _608 = g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nBufferStrideInBytes;
	            ivec4 _609 = g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nBufferBindOffsetBytes;
	            uvec3 _1632 = (uvec3(uint(_608[_1616])) * _652) + uvec3(uint(_609[_1616]) + uint(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vTangentFieldInfo.x));
	            uint _1634 = _1632.x;
	            _651[0] = vec4(g_Vertices_1[nonuniformEXT(_194)]._member0[_1634 / 4u], g_Vertices_1[nonuniformEXT(_194)]._member0[(_1634 + 4u) / 4u], g_Vertices_1[nonuniformEXT(_194)]._member0[(_1634 + 8u) / 4u], g_Vertices_1[nonuniformEXT(_194)]._member0[(_1634 + 12u) / 4u]);
	            uint _1640 = _1632.y;
	            _651[1] = vec4(g_Vertices_1[nonuniformEXT(_194)]._member0[_1640 / 4u], g_Vertices_1[nonuniformEXT(_194)]._member0[(_1640 + 4u) / 4u], g_Vertices_1[nonuniformEXT(_194)]._member0[(_1640 + 8u) / 4u], g_Vertices_1[nonuniformEXT(_194)]._member0[(_1640 + 12u) / 4u]);
	            uint _1646 = _1632.z;
	            _651[2] = vec4(g_Vertices_1[nonuniformEXT(_194)]._member0[_1646 / 4u], g_Vertices_1[nonuniformEXT(_194)]._member0[(_1646 + 4u) / 4u], g_Vertices_1[nonuniformEXT(_194)]._member0[(_1646 + 8u) / 4u], g_Vertices_1[nonuniformEXT(_194)]._member0[(_1646 + 12u) / 4u]);
	        }
	        else
	        {
	            _651[0] = vec4(0.0);
	            _651[1] = vec4(0.0);
	            _651[2] = vec4(0.0);
	        }
	        break;
	    } while(false);
	    _648 = 0;
	    for (;;)
	    {
	        if (!(_648 < 3))
	        {
	            break;
	        }
	        vsInput[_648].vNormalOs = _650[_648];
	        vsInput[_648].vTangentUOs_flTangentVSign = _651[_648];
	        _648++;
	        continue;
	    }
	    vec4 _654[3];
	    _654[0] = vec4(0.0);
	    _654[1] = vec4(0.0);
	    _654[2] = vec4(0.0);
	    if (g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vTexCoordFieldInfo.data[4].y != 0)
	    {
	        ivec4 _607 = g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nVertexAndIndexBuffers;
	        uint _232 = uint(_607[g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vTexCoordFieldInfo.data[4].z]);
	        uint _1692 = uint(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vTexCoordFieldInfo.data[4].z);
	        ivec4 _605 = g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nBufferStrideInBytes;
	        ivec4 _606 = g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nBufferBindOffsetBytes;
	        uvec3 _1708 = (uvec3(uint(_605[_1692])) * _652) + uvec3(uint(_606[_1692]) + uint(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vTexCoordFieldInfo.data[4].x));
	        if (g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vTexCoordFieldInfo.data[4].y == 2)
	        {
	            uint _1749 = _1708.x;
	            _654[0] = vec4(g_Vertices_1[nonuniformEXT(_232)]._member0[_1749 / 4u], g_Vertices_1[nonuniformEXT(_232)]._member0[(_1749 + 4u) / 4u], g_Vertices_1[nonuniformEXT(_232)]._member0[(_1749 + 8u) / 4u], g_Vertices_1[nonuniformEXT(_232)]._member0[(_1749 + 12u) / 4u]);
	            uint _1754 = _1708.y;
	            _654[1] = vec4(g_Vertices_1[nonuniformEXT(_232)]._member0[_1754 / 4u], g_Vertices_1[nonuniformEXT(_232)]._member0[(_1754 + 4u) / 4u], g_Vertices_1[nonuniformEXT(_232)]._member0[(_1754 + 8u) / 4u], g_Vertices_1[nonuniformEXT(_232)]._member0[(_1754 + 12u) / 4u]);
	            uint _1759 = _1708.z;
	            _654[2] = vec4(g_Vertices_1[nonuniformEXT(_232)]._member0[_1759 / 4u], g_Vertices_1[nonuniformEXT(_232)]._member0[(_1759 + 4u) / 4u], g_Vertices_1[nonuniformEXT(_232)]._member0[(_1759 + 8u) / 4u], g_Vertices_1[nonuniformEXT(_232)]._member0[(_1759 + 12u) / 4u]);
	        }
	        else
	        {
	            if (g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vTexCoordFieldInfo.data[4].y == 28)
	            {
	                uint _234 = _1708.x / 4u;
	                _654[0] = vec4(uvec4(g_Vertices_3[nonuniformEXT(_232)]._member0[_234] & 255u, (g_Vertices_3[nonuniformEXT(_232)]._member0[_234] & 65280u) >> uint(8), (g_Vertices_3[nonuniformEXT(_232)]._member0[_234] & 16711680u) >> uint(16), (g_Vertices_3[nonuniformEXT(_232)]._member0[_234] & 4278190080u) >> uint(24))) * vec4(0.0039215688593685626983642578125);
	                uint _237 = _1708.y / 4u;
	                _654[1] = vec4(uvec4(g_Vertices_3[nonuniformEXT(_232)]._member0[_237] & 255u, (g_Vertices_3[nonuniformEXT(_232)]._member0[_237] & 65280u) >> uint(8), (g_Vertices_3[nonuniformEXT(_232)]._member0[_237] & 16711680u) >> uint(16), (g_Vertices_3[nonuniformEXT(_232)]._member0[_237] & 4278190080u) >> uint(24))) * vec4(0.0039215688593685626983642578125);
	                uint _240 = _1708.z / 4u;
	                _654[2] = vec4(uvec4(g_Vertices_3[nonuniformEXT(_232)]._member0[_240] & 255u, (g_Vertices_3[nonuniformEXT(_232)]._member0[_240] & 65280u) >> uint(8), (g_Vertices_3[nonuniformEXT(_232)]._member0[_240] & 16711680u) >> uint(16), (g_Vertices_3[nonuniformEXT(_232)]._member0[_240] & 4278190080u) >> uint(24))) * vec4(0.0039215688593685626983642578125);
	            }
	        }
	    }
	    int _655 = 0;
	    for (;;)
	    {
	        if (!(_655 < 3))
	        {
	            break;
	        }
	        vsInput[_655].vBlendValues = _654[_655];
	        _655++;
	        continue;
	    }
	    vec2 _522 = vsInput[0].vTexCoord;
	    vec4 _521 = vsInput[0].vBlendValues;
	    vec3 _603 = vsInput[0].vNormalOs;
	    vec4 _604;
	    vec4 _1791 = _604;
	    _1791.x = vsInput[0].vTangentUOs_flTangentVSign.x;
	    _1791.y = vsInput[0].vTangentUOs_flTangentVSign.y;
	    _1791.z = vsInput[0].vTangentUOs_flTangentVSign.z;
	    _1791.w = vsInput[0].vTangentUOs_flTangentVSign.w;
	    _604 = _1791;
	    vec4 _1814 = vec4(uvec4(g_instanceBuffer._member0[uint(gl_InstanceID)].nSrgbColor & 255u, (g_instanceBuffer._member0[uint(gl_InstanceID)].nSrgbColor & 65280u) >> uint(8), (g_instanceBuffer._member0[uint(gl_InstanceID)].nSrgbColor & 16711680u) >> uint(16), (g_instanceBuffer._member0[uint(gl_InstanceID)].nSrgbColor & 4278190080u) >> uint(24))) * vec4(0.0039215688593685626983642578125);
	    vec4 _602 = _1814;
	    vec3 _1815 = _1814.xyz;
	    vec3 _1816 = _1815 * vec3(0.077399380505084991455078125);
	    vec3 _1819 = pow((_1815 * vec3(0.947867333889007568359375)) + vec3(0.052132703363895416259765625), vec3(2.400000095367431640625));
	    float _599;
	    if (_1814.x <= 0.040449999272823333740234375)
	    {
	        _599 = _1816.x;
	    }
	    else
	    {
	        _599 = _1819.x;
	    }
	    float _600;
	    if (_1814.y <= 0.040449999272823333740234375)
	    {
	        _600 = _1816.y;
	    }
	    else
	    {
	        _600 = _1819.y;
	    }
	    float _601;
	    if (_1814.z <= 0.040449999272823333740234375)
	    {
	        _601 = _1816.z;
	    }
	    else
	    {
	        _601 = _1819.z;
	    }
	    vec3 _1844 = vec3(_599, _600, _601);
	    vec4 _1846 = _602;
	    _1846.x = _1844.x;
	    _1846.y = _1844.y;
	    _1846.z = _1844.z;
	    _602 = _1846;
	    vec4 _525;
	    vec4 _1853 = _525;
	    _1853.x = _1846.x;
	    _1853.y = _1846.y;
	    _1853.z = _1846.z;
	    _1853.w = _1846.w;
	    _525 = _1853;
	    mat3x4 _1864 = transpose(gl_WorldToObjectEXT);
	    mat3 _598;
	    mat3 _1867 = _598;
	    _1867[0] = _1864[0].xyz;
	    _1867[1] = _1864[1].xyz;
	    _1867[2] = _1864[2].xyz;
	    _598 = _1867;
	    vec3 _1876 = normalize(_1867 * _603.xyz);
	    vec3 _526;
	    vec3 _1878 = _526;
	    _1878.x = _1876.x;
	    _1878.y = _1876.y;
	    _1878.z = _1876.z;
	    _526 = _1878;
	    mat3x4 _1890 = transpose(gl_WorldToObjectEXT);
	    mat3 _597;
	    mat3 _1893 = _597;
	    _1893[0] = _1890[0].xyz;
	    _1893[1] = _1890[1].xyz;
	    _1893[2] = _1890[2].xyz;
	    _597 = _1893;
	    vec3 _1902 = normalize(_1893 * _604.xyz);
	    vec4 _524;
	    vec4 _1904 = _524;
	    _1904.x = _1902.x;
	    _1904.y = _1902.y;
	    _1904.z = _1902.z;
	    _1904.w = _604.w;
	    _524 = _1904;
	    vec4 _1913 = _522.xyxy;
	    vec4 _527;
	    vec4 _1914 = _527;
	    vec4 _1927 = _1913;
	    _1927.x = dot(_1913.xy, _569.xy) + _569.w;
	    _1927.y = dot(_1913.xy, _568.xy) + _568.w;
	    vec2 _1935 = _1927.xy + (_567.xy * PerViewConstantBuffer_t.g_flGameTime);
	    vec4 _1937 = _1927;
	    _1937.x = _1935.x;
	    _1937.y = _1935.y;
	    vec3 _1943 = mix(vec3(1.0), _1853.xyz, vec3(_565));
	    vec4 _1945 = _1853;
	    _1945.x = _1943.x;
	    _1945.y = _1943.y;
	    _1945.z = _1943.z;
	    vec3 _1953 = _1945.xyz * _566.xyz;
	    vec4 _1955 = _1945;
	    _1955.x = _1953.x;
	    _1955.y = _1953.y;
	    _1955.z = _1953.z;
	    _1914.x = _521.x;
	    _1914.y = _521.y;
	    _1914.z = _521.z;
	    _1914.w = max(_521.w, 0.100000001490116119384765625);
	    vec4 _509 = _1914;
	    vec3 _508 = vec4(vsInput[0].vPositionOs.xyz, 1.0) * transpose(gl_ObjectToWorldEXT);
	    vec3 _507 = _1878;
	    vec4 _506 = _1937;
	    vec4 _505 = _1955;
	    vec4 _504 = _1904;
	    vec2 _520 = vsInput[1].vTexCoord;
	    vec4 _519 = vsInput[1].vBlendValues;
	    vec3 _595 = vsInput[1].vNormalOs;
	    vec4 _596;
	    vec4 _1978 = _596;
	    _1978.x = vsInput[1].vTangentUOs_flTangentVSign.x;
	    _1978.y = vsInput[1].vTangentUOs_flTangentVSign.y;
	    _1978.z = vsInput[1].vTangentUOs_flTangentVSign.z;
	    _1978.w = vsInput[1].vTangentUOs_flTangentVSign.w;
	    _596 = _1978;
	    vec4 _2001 = vec4(uvec4(g_instanceBuffer._member0[uint(gl_InstanceID)].nSrgbColor & 255u, (g_instanceBuffer._member0[uint(gl_InstanceID)].nSrgbColor & 65280u) >> uint(8), (g_instanceBuffer._member0[uint(gl_InstanceID)].nSrgbColor & 16711680u) >> uint(16), (g_instanceBuffer._member0[uint(gl_InstanceID)].nSrgbColor & 4278190080u) >> uint(24))) * vec4(0.0039215688593685626983642578125);
	    vec4 _594 = _2001;
	    vec3 _2002 = _2001.xyz;
	    vec3 _2003 = _2002 * vec3(0.077399380505084991455078125);
	    vec3 _2006 = pow((_2002 * vec3(0.947867333889007568359375)) + vec3(0.052132703363895416259765625), vec3(2.400000095367431640625));
	    float _591;
	    if (_2001.x <= 0.040449999272823333740234375)
	    {
	        _591 = _2003.x;
	    }
	    else
	    {
	        _591 = _2006.x;
	    }
	    float _592;
	    if (_2001.y <= 0.040449999272823333740234375)
	    {
	        _592 = _2003.y;
	    }
	    else
	    {
	        _592 = _2006.y;
	    }
	    float _593;
	    if (_2001.z <= 0.040449999272823333740234375)
	    {
	        _593 = _2003.z;
	    }
	    else
	    {
	        _593 = _2006.z;
	    }
	    vec3 _2031 = vec3(_591, _592, _593);
	    vec4 _2033 = _594;
	    _2033.x = _2031.x;
	    _2033.y = _2031.y;
	    _2033.z = _2031.z;
	    _594 = _2033;
	    vec4 _529;
	    vec4 _2040 = _529;
	    _2040.x = _2033.x;
	    _2040.y = _2033.y;
	    _2040.z = _2033.z;
	    _2040.w = _2033.w;
	    _529 = _2040;
	    mat3x4 _2051 = transpose(gl_WorldToObjectEXT);
	    mat3 _590;
	    mat3 _2054 = _590;
	    _2054[0] = _2051[0].xyz;
	    _2054[1] = _2051[1].xyz;
	    _2054[2] = _2051[2].xyz;
	    _590 = _2054;
	    vec3 _2063 = normalize(_2054 * _595.xyz);
	    vec3 _530;
	    vec3 _2065 = _530;
	    _2065.x = _2063.x;
	    _2065.y = _2063.y;
	    _2065.z = _2063.z;
	    _530 = _2065;
	    mat3x4 _2077 = transpose(gl_WorldToObjectEXT);
	    mat3 _589;
	    mat3 _2080 = _589;
	    _2080[0] = _2077[0].xyz;
	    _2080[1] = _2077[1].xyz;
	    _2080[2] = _2077[2].xyz;
	    _589 = _2080;
	    vec3 _2089 = normalize(_2080 * _596.xyz);
	    vec4 _528;
	    vec4 _2091 = _528;
	    _2091.x = _2089.x;
	    _2091.y = _2089.y;
	    _2091.z = _2089.z;
	    _2091.w = _596.w;
	    _528 = _2091;
	    vec4 _2100 = _520.xyxy;
	    vec4 _531;
	    vec4 _2101 = _531;
	    vec4 _2114 = _2100;
	    _2114.x = dot(_2100.xy, _569.xy) + _569.w;
	    _2114.y = dot(_2100.xy, _568.xy) + _568.w;
	    vec2 _2122 = _2114.xy + (_567.xy * PerViewConstantBuffer_t.g_flGameTime);
	    vec4 _2124 = _2114;
	    _2124.x = _2122.x;
	    _2124.y = _2122.y;
	    vec3 _2130 = mix(vec3(1.0), _2040.xyz, vec3(_565));
	    vec4 _2132 = _2040;
	    _2132.x = _2130.x;
	    _2132.y = _2130.y;
	    _2132.z = _2130.z;
	    vec3 _2140 = _2132.xyz * _566.xyz;
	    vec4 _2142 = _2132;
	    _2142.x = _2140.x;
	    _2142.y = _2140.y;
	    _2142.z = _2140.z;
	    _2101.x = _519.x;
	    _2101.y = _519.y;
	    _2101.z = _519.z;
	    _2101.w = max(_519.w, 0.100000001490116119384765625);
	    vec4 _503 = _2101;
	    vec3 _502 = vec4(vsInput[1].vPositionOs.xyz, 1.0) * transpose(gl_ObjectToWorldEXT);
	    vec3 _501 = _2065;
	    vec4 _500 = _2124;
	    vec4 _499 = _2142;
	    vec4 _498 = _2091;
	    vec2 _518 = vsInput[2].vTexCoord;
	    vec4 _517 = vsInput[2].vBlendValues;
	    vec3 _587 = vsInput[2].vNormalOs;
	    vec4 _588;
	    vec4 _2165 = _588;
	    _2165.x = vsInput[2].vTangentUOs_flTangentVSign.x;
	    _2165.y = vsInput[2].vTangentUOs_flTangentVSign.y;
	    _2165.z = vsInput[2].vTangentUOs_flTangentVSign.z;
	    _2165.w = vsInput[2].vTangentUOs_flTangentVSign.w;
	    _588 = _2165;
	    vec4 _2188 = vec4(uvec4(g_instanceBuffer._member0[uint(gl_InstanceID)].nSrgbColor & 255u, (g_instanceBuffer._member0[uint(gl_InstanceID)].nSrgbColor & 65280u) >> uint(8), (g_instanceBuffer._member0[uint(gl_InstanceID)].nSrgbColor & 16711680u) >> uint(16), (g_instanceBuffer._member0[uint(gl_InstanceID)].nSrgbColor & 4278190080u) >> uint(24))) * vec4(0.0039215688593685626983642578125);
	    vec4 _586 = _2188;
	    vec3 _2189 = _2188.xyz;
	    vec3 _2190 = _2189 * vec3(0.077399380505084991455078125);
	    vec3 _2193 = pow((_2189 * vec3(0.947867333889007568359375)) + vec3(0.052132703363895416259765625), vec3(2.400000095367431640625));
	    float _583;
	    if (_2188.x <= 0.040449999272823333740234375)
	    {
	        _583 = _2190.x;
	    }
	    else
	    {
	        _583 = _2193.x;
	    }
	    float _584;
	    if (_2188.y <= 0.040449999272823333740234375)
	    {
	        _584 = _2190.y;
	    }
	    else
	    {
	        _584 = _2193.y;
	    }
	    float _585;
	    if (_2188.z <= 0.040449999272823333740234375)
	    {
	        _585 = _2190.z;
	    }
	    else
	    {
	        _585 = _2193.z;
	    }
	    vec3 _2218 = vec3(_583, _584, _585);
	    vec4 _2220 = _586;
	    _2220.x = _2218.x;
	    _2220.y = _2218.y;
	    _2220.z = _2218.z;
	    _586 = _2220;
	    vec4 _533;
	    vec4 _2227 = _533;
	    _2227.x = _2220.x;
	    _2227.y = _2220.y;
	    _2227.z = _2220.z;
	    _2227.w = _2220.w;
	    _533 = _2227;
	    mat3x4 _2238 = transpose(gl_WorldToObjectEXT);
	    mat3 _582;
	    mat3 _2241 = _582;
	    _2241[0] = _2238[0].xyz;
	    _2241[1] = _2238[1].xyz;
	    _2241[2] = _2238[2].xyz;
	    _582 = _2241;
	    vec3 _2250 = normalize(_2241 * _587.xyz);
	    vec3 _534;
	    vec3 _2252 = _534;
	    _2252.x = _2250.x;
	    _2252.y = _2250.y;
	    _2252.z = _2250.z;
	    _534 = _2252;
	    vec3 _2260 = vec4(vsInput[2].vPositionOs.xyz, 1.0) * transpose(gl_ObjectToWorldEXT);
	    mat3x4 _2264 = transpose(gl_WorldToObjectEXT);
	    mat3 _581;
	    mat3 _2267 = _581;
	    _2267[0] = _2264[0].xyz;
	    _2267[1] = _2264[1].xyz;
	    _2267[2] = _2264[2].xyz;
	    _581 = _2267;
	    vec3 _2276 = normalize(_2267 * _588.xyz);
	    vec4 _532;
	    vec4 _2278 = _532;
	    _2278.x = _2276.x;
	    _2278.y = _2276.y;
	    _2278.z = _2276.z;
	    _2278.w = _588.w;
	    _532 = _2278;
	    vec4 _2287 = _518.xyxy;
	    vec4 _535;
	    vec4 _2288 = _535;
	    vec4 _2301 = _2287;
	    _2301.x = dot(_2287.xy, _569.xy) + _569.w;
	    _2301.y = dot(_2287.xy, _568.xy) + _568.w;
	    vec2 _2309 = _2301.xy + (_567.xy * PerViewConstantBuffer_t.g_flGameTime);
	    vec4 _2311 = _2301;
	    _2311.x = _2309.x;
	    _2311.y = _2309.y;
	    vec3 _2317 = mix(vec3(1.0), _2227.xyz, vec3(_565));
	    vec4 _2319 = _2227;
	    _2319.x = _2317.x;
	    _2319.y = _2317.y;
	    _2319.z = _2317.z;
	    vec3 _2327 = _2319.xyz * _566.xyz;
	    vec4 _2329 = _2319;
	    _2329.x = _2327.x;
	    _2329.y = _2327.y;
	    _2329.z = _2327.z;
	    _2288.x = _517.x;
	    _2288.y = _517.y;
	    _2288.z = _517.z;
	    _2288.w = max(_517.w, 0.100000001490116119384765625);
	    vec3 _497 = _2260;
	    vec3 _496 = _2252;
	    vec3 _2366 = ((_507 * ((1.0 - attrs.barycentrics.x) - attrs.barycentrics.y)) + (_501 * attrs.barycentrics.x)) + (_2252 * attrs.barycentrics.y);
	    vec3 _536;
	    vec4 _516 = ((_509 * ((1.0 - attrs.barycentrics.x) - attrs.barycentrics.y)) + (_503 * attrs.barycentrics.x)) + (_2288 * attrs.barycentrics.y);
	    vec3 _515 = _2366;
	    vec4 _514 = ((_506 * ((1.0 - attrs.barycentrics.x) - attrs.barycentrics.y)) + (_500 * attrs.barycentrics.x)) + (_2311 * attrs.barycentrics.y);
	    vec4 _513 = ((_505 * ((1.0 - attrs.barycentrics.x) - attrs.barycentrics.y)) + (_499 * attrs.barycentrics.x)) + (_2329 * attrs.barycentrics.y);
	    vec4 _512 = ((_504 * ((1.0 - attrs.barycentrics.x) - attrs.barycentrics.y)) + (_498 * attrs.barycentrics.x)) + (_2278 * attrs.barycentrics.y);
	    vec3 _539 = _536;
	    vec3 _538 = normalize(cross(_502 - _508, _2260 - _508));
	    vec2 _553 = vec2(0.5);
	    vec3 _552 = vec3(0.0);
	    vec3 _551 = vec3(0.0);
	    bool _549 = false;
	    vec3 _2408 = _2366.xyz;
	    vec3 _550 = _2408;
	    if (dot(_2408, _2408) >= 1.0099999904632568359375)
	    {
	        _550 = _539.xyz;
	    }
	    vec3 _2417 = _550;
	    vec3 _2418 = normalize(_2417);
	    _550 = _2418;
	    vec2 _2422 = _553;
	    vec3 _545 = _552;
	    float _544 = _554;
	    vec3 _543 = _551;
	    vec3 _542 = _2418;
	    vec3 _541 = _538;
	    bool _540 = _549;
	    vec2 _2435 = (_514.xy * _560.xy).xy;
	    vec4 _2448 = textureLod(nonuniformEXT(sampler2D(g_bindless_Texture2D_float4[_555], g_bindless_Sampler[_564])), _2435, 0.0);
	    float _2449 = _2448.x;
	    float _2458 = smoothstep(max(0.0, _2449 - _516.w), min(1.0, _2449 + _516.w), _516.x);
	    vec3 _2462 = textureLod(nonuniformEXT(sampler2D(g_bindless_Texture2D_float4[_559], g_bindless_Sampler[_563])), _514.xy, 0.0).xyzw.xyz * _513.xyz;
	    vec4 _2464;
	    _2464.x = _2462.x;
	    _2464.y = _2462.y;
	    _2464.z = _2462.z;
	    vec3 _2471 = textureLod(nonuniformEXT(sampler2D(g_bindless_Texture2D_float4[_558], g_bindless_Sampler[_563])), _2435, 0.0).xyzw.xyz * _513.xyz;
	    vec4 _2473;
	    _2473.x = _2471.x;
	    _2473.y = _2471.y;
	    _2473.z = _2471.z;
	    vec4 _2485 = mix(textureLod(nonuniformEXT(sampler2D(g_bindless_Texture2D_float4[_557], g_bindless_Sampler[_563])), _514.xy, 0.0).xyzw, textureLod(nonuniformEXT(sampler2D(g_bindless_Texture2D_float4[_556], g_bindless_Sampler[_563])), _2435, 0.0).xyzw, vec4(_2458));
	    vec3 _548 = mix(_2464.xyz, _2473.xyz, vec3(_2458)).xyz;
	    float _546 = mix(_562, _561, _2458);
	    _2422.x = _2485.z;
	    _2422.y = _2485.z;
	    vec2 _547 = _2422;
	    float _2496 = _2485.x;
	    float _2497 = _2485.y;
	    float _2499 = (_2496 + _2497) - 1.00392162799835205078125;
	    float _2500 = _2496 - _2497;
	    vec4 _537 = _512;
	    vec3 _579 = normalize(vec3(vec2(_2499, _2500), (1.0 - abs(_2499)) - abs(_2500)));
	    float _580;
	    if (false)
	    {
	        _580 = -1.0;
	    }
	    else
	    {
	        _580 = 1.0;
	    }
	    float _2512 = _580;
	    vec3 _2513 = _515.xyz * _2512;
	    if (_537.w > 0.0)
	    {
	        _580 = 1.0;
	    }
	    else
	    {
	        _580 = -1.0;
	    }
	    if (!false)
	    {
	        vec3 _2528 = _579;
	        _2528.y = -_2528.y;
	        _579 = _2528;
	    }
	    vec3 _2535 = _537.xyz * _579.x;
	    vec3 _578;
	    vec3 _2537 = _578;
	    _2537.x = _2535.x;
	    _2537.y = _2535.y;
	    _2537.z = _2535.z;
	    vec3 _2547 = _2537.xyz + ((cross(_2513.xyz, _537.xyz) * _580).xyz * _579.y);
	    vec3 _2549 = _2537;
	    _2549.x = _2547.x;
	    _2549.y = _2547.y;
	    _2549.z = _2547.z;
	    vec3 _2558 = _2549.xyz + (_2513.xyz * _579.z);
	    vec3 _2560 = _2549;
	    _2560.x = _2558.x;
	    _2560.y = _2558.y;
	    _2560.z = _2558.z;
	    _578 = _2560;
	    payload.nInstance = int(uint(gl_InstanceID));
	    payload.flHitT = gl_RayTmaxEXT;
	    payload.vFaceNormalWs = _541;
	    payload.vInterpolatedNormalWs = _542;
	    vec3 _576[3] = vec3[](_508, _502, _497);
	    vec3 _577[3] = vec3[](_507, _501, _496);
	    vec3 _2607 = ((_576[0] * ((1.0 - attrs.barycentrics.x) - attrs.barycentrics.y)) + (_576[1] * attrs.barycentrics.x)) + (_576[2] * attrs.barycentrics.y);
	    vec3 _570[3];
	    _570[0] = _2607 - (_577[0] * dot(_2607 - _576[0], _577[0]));
	    _570[1] = _2607 - (_577[1] * dot(_2607 - _576[1], _577[1]));
	    _570[2] = _2607 - (_577[2] * dot(_2607 - _576[2], _577[2]));
	    vec3 _2647 = ((_570[0] * ((1.0 - attrs.barycentrics.x) - attrs.barycentrics.y)) + (_570[1] * attrs.barycentrics.x)) + (_570[2] * attrs.barycentrics.y);
	    vec3 _571[3];
	    _571[0] = cross(_576[0] - _576[1], _541);
	    _571[1] = cross(_576[1] - _576[2], _541);
	    _571[2] = cross(_576[2] - _576[0], _541);
	    float _572 = dot(_2647 - _2607, _541);
	    vec3 _573 = _2647;
	    int _574 = 0;
	    for (;;)
	    {
	        bool _2663_ladder_break = false;
	        do
	        {
	            if (!(_574 < 3))
	            {
	                _2663_ladder_break = true;
	                break;
	            }
	            if (_572 > 0.00999999977648258209228515625)
	            {
	                _2663_ladder_break = true;
	                break;
	            }
	            if (dot(_571[_574], _571[_574]) == 0.0)
	            {
	                break;
	            }
	            _571[_574] = normalize(_571[_574]);
	            int _575 = 0;
	            for (;;)
	            {
	                if (!(_575 < 3))
	                {
	                    break;
	                }
	                vec3 _2701 = _577[_575] - (_571[_574] * dot(_571[_574], _577[_575]));
	                _570[_575] = _2607 - (_2701 * dot(_2607 - _576[_575], _2701));
	                _575++;
	                continue;
	            }
	            vec3 _2725 = ((_570[0] * ((1.0 - attrs.barycentrics.x) - attrs.barycentrics.y)) + (_570[1] * attrs.barycentrics.x)) + (_570[2] * attrs.barycentrics.y);
	            _572 = dot(_2725 - _2607, _541);
	            _573 = _2725;
	            break;
	        } while(false);
	        if (_2663_ladder_break)
	        {
	            break;
	        }
	        _574++;
	        continue;
	    }
	    if (!(_572 > 0.00999999977648258209228515625))
	    {
	        _573 = vec3(3.4028234663852885981170418348452e+38);
	    }
	    payload.vSmoothPositionWs = _573;
	    payload.bFlippedNormal = _540;
	    f16vec3 _2738 = f16vec3(vec3(0.0));
	    payload.material = MaterialDataMinimal_t(_2738, float16_t(0.0), f16vec3(vec3(1.0, 0.0, 1.0)), float16_t(1.0), _2738, float16_t(0.040008544921875), 0u, f16vec4(ivec4(0)));
	    payload.material.vNormalWs = f16vec3(normalize(_2560.xyz));
	    payload.material.vAlbedo = f16vec3(_548);
	    payload.material.vEmissive = f16vec3(_545);
	    payload.material.flReflectance = float16_t(_544);
	    payload.material.flMetalness = float16_t(_546);
	    payload.material.flRoughness = float16_t(dot(_547, vec2(0.5)));
	    if (any(greaterThan(_543, vec3(0.0))))
	    {
	        payload.material.nMaterialTypeAndFlags = (payload.material.nMaterialTypeAndFlags & 4294901760u) | 1u;
	        f16vec3 _2764 = f16vec3(_543);
	        payload.material.vMaterialBits.x = _2764.x;
	        payload.material.vMaterialBits.y = _2764.y;
	        payload.material.vMaterialBits.z = _2764.z;
	    }
	}
	
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
	
	BoolAttribute(BindlessResources, true);
	IntAttribute(RayTypeCount, 2);
	BoolAttribute(CanBatchWithDynamicShaderConstants, true);
	IntAttribute(TexCoordScaleByModelU, g_nScaleTexCoordUByModelScaleAxis-1);
	IntAttribute(TexCoordScaleByModelV, g_nScaleTexCoordVByModelScaleAxis-1);
	Float3Attribute(LightSim_MaterialTint, g_vColorTint);
	BoolAttribute(VertexPaintUI2Layer, true);
	BoolAttribute(VertexPaintUIAlphaBlendFactor, true);
	BoolAttribute(SupportsAggregateInstancing, true);
	BoolAttribute(SupportsLightmapping, true);
	BoolAttribute(PerVertexLighting, true);
	BoolAttribute(AllowBackfaceCulling, F_RENDER_BACKFACES ? 0 : 1);
	TextureAttribute(LightSim_DiffuseAlbedoTexture, g_tColorA);
	TextureAttribute(RepresentativeTexture, g_tColorA);
	BoolAttribute(NeedsLightProbe, true);
	BoolAttribute(NoZPrepass, F_DISABLE_Z_PREPASS ? 1 : 0);
	BoolAttribute(DoNotCastShadows, F_DO_NOT_CAST_SHADOWS ? 1 : 0);
	BoolAttribute(SupportsMappingDimensions, true);
	BoolAttribute(renderbackfaces, F_RENDER_BACKFACES ? 1 : 0);
	
	#if (S_PAINT_VERTEX_COLORS == 0)
		TextureAttribute(LightSim_TintMaskTextureR, g_tTintMask);
	#endif
	#if (S_PAINT_VERTEX_COLORS == 1)
		BoolAttribute(VertexPaintUIPickColor, true);
	#endif
	#if (S_ENABLE_TINT_MASKS == 0)
		BoolAttribute(VertexPaintUIPickColor, true);
	#endif
	#if (S_MODE_TOOLS_VIS == 0)
		BoolAttribute(VertexPaintUIPickColor, true);
		TextureAttribute(LightSim_TintMaskTextureR, g_tTintMask);
	#endif
	#if (S_ENABLE_TINT_MASKS == 1)
		TextureAttribute(LightSim_TintMaskTextureR, g_tTintMask);
	#endif
	#if (S_SHADER_QUALITY == 0)
		BoolAttribute(VertexPaintUIPickColor, true);
		TextureAttribute(LightSim_TintMaskTextureR, g_tTintMask);
	#endif
}
