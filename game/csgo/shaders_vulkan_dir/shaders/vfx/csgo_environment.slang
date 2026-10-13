//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Environment shader with blended layers";
	DevShader = false;
	Version = 5;
	
	// Platform: VULKAN_SM_60
	// Programs: ps, vs, rtx, psrs
}

MODES
{
	CsgoForward();
	RayTrace();
	Depth(S_MODE_DEPTH);
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
	Feature( F_DETAIL_NORMAL, 0..1, "Detail" );
	Feature( F_WETNESS, 0..1, "Wetness" );
	Feature( F_MATERIAL_REFERENCE, 0..1, "Create Variation" );
	Feature( F_ALPHA_TEST, 0..1, "Translucent" );
	Feature( F_OCCLUSION_CULLING_BOUNDS_SCALE, 0..1, "Z-Buffering" );
	FeatureRule( Requires( F_DONT_FLIP_BACKFACE_NORMALS, F_RENDER_BACKFACES ), "Only applies to backfaces" );
}

COMMON
{
	#include "system.fxc"
}

struct VS_INPUT
{
	float4 vBlendIndices              : BLENDINDICES0  < Semantic( BlendIndices ); >;              // D_CS_VERTEX_ANIMATION=0
	float4 vBlendColorTint            : COLOR0         < Semantic( VertexPaintTintColor ); >;      // S_MODE_DEPTH=0, D_CS_VERTEX_ANIMATION=1, S_MODE_TOOLS_VIS=1, S_ALPHA_TEST_LAYER=1
	float4 vPerVertexLighting         : COLOR1         < Semantic( PerVertexLighting ); >;        
	uint4  nPackedFrame               : NORMAL0        < Semantic( CompressedTangentFrame ); >;   
	float4 vNormalOs                  : NORMAL0        < Semantic( Normal ); >;                   
	float3 vPositionOs                : POSITION0      < Semantic( PosXyz ); >;                    // D_CS_VERTEX_ANIMATION=0
	float4 vTangentUOs_flTangentVSign : TANGENT0       < Semantic( TangentU_SignV ); >;           
	float2 vLightmapUV                : TEXCOORD3      < Semantic( LightmapUV ); >;               
	float2 vTexCoord                  : TEXCOORD0      < Semantic( LowPrecisionUv ); >;            // S_MODE_DEPTH=0, D_CS_VERTEX_ANIMATION=1, S_MODE_TOOLS_VIS=1, S_ALPHA_TEST_LAYER=1
	float2 vTexCoord2                 : TEXCOORD1      < Semantic( LowPrecisionUv1 ); >;           // S_MODE_DEPTH=0, D_CS_VERTEX_ANIMATION=1, S_MODE_TOOLS_VIS=1, S_ALPHA_TEST_LAYER=1
	float4 vColorBlendValues          : TEXCOORD4      < Semantic( VertexPaintBlendParams ); >;    // S_MODE_DEPTH=0, D_CS_VERTEX_ANIMATION=1, S_MODE_TOOLS_VIS=1, S_ALPHA_TEST_LAYER=1
	float2 nInstanceIdx               : TEXCOORD13     < Semantic( InstanceTransformUv ); >;      
};

VS
{
	StaticCombo( S_DETAIL_NORMAL, F_DETAIL_NORMAL );
	StaticCombo( S_MATERIAL_REFERENCE, F_MATERIAL_REFERENCE );
	StaticCombo( S_MODE_TOOLS_VIS, 0..1 );
	StaticCombo( S_ALPHA_TEST_LAYER, F_ALPHA_TEST );
	StaticCombo( S_MODE_DEPTH, 0..1 );
	StaticComboRule( Allow1( S_MODE_TOOLS_VIS, S_MODE_DEPTH ) );
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
	float4 g_vDetailTexCoordXform0_1 < UiType(VectorText); Expression(v0 = g_flDetailTexCoordRotation1*3.1415927/180;
		v1 = cos(v0);
		v2 = sin(v0);
		float4(v1*g_vDetailTexCoordScale1.x,-v2*g_vDetailTexCoordScale1.y,0,g_vDetailTexCoordCenter1.x+g_vDetailTexCoordOffset1.x+v2*g_vDetailTexCoordCenter1.y-v1*g_vDetailTexCoordCenter1.x)); >;
	float4 g_vDetailTexCoordXform1_1 < UiType(VectorText); Expression(v0 = g_flDetailTexCoordRotation1*3.1415927/180;
		v1 = cos(v0);
		v2 = sin(v0);
		float4(v2*g_vDetailTexCoordScale1.x,v1*g_vDetailTexCoordScale1.y,0,g_vDetailTexCoordCenter1.y+g_vDetailTexCoordOffset1.y-(v2*g_vDetailTexCoordCenter1.x+v1*g_vDetailTexCoordCenter1.y))); >;
	float4 g_vTexCoordScaleByModelU < UiType(VectorText); Expression(float4((g_nScaleTexCoordUByModelScaleAxis==1) ? 1 : 0,(g_nScaleTexCoordUByModelScaleAxis==2) ? 1 : 0,(g_nScaleTexCoordUByModelScaleAxis==3) ? 1 : 0,(g_nScaleTexCoordUByModelScaleAxis==0) ? 1 : 0)); >;
	float4 g_vTexCoordScaleByModelV < UiType(VectorText); Expression(float4((g_nScaleTexCoordVByModelScaleAxis==1) ? 1 : 0,(g_nScaleTexCoordVByModelScaleAxis==2) ? 1 : 0,(g_nScaleTexCoordVByModelScaleAxis==3) ? 1 : 0,(g_nScaleTexCoordVByModelScaleAxis==0) ? 1 : 0)); >;
	float4 g_vTexCoordXform0_1 < UiType(VectorText); Expression(v0 = g_flTexCoordRotation1*3.1415927/180;
		v1 = cos(v0);
		v2 = sin(v0);
		float4(v1*g_vTexCoordScale1.x,-v2*g_vTexCoordScale1.y,0,g_vTexCoordCenter1.x+g_vTexCoordOffset1.x+v2*g_vTexCoordCenter1.y-v1*g_vTexCoordCenter1.x)); >;
	float4 g_vTexCoordXform1_1 < UiType(VectorText); Expression(v0 = g_flTexCoordRotation1*3.1415927/180;
		v1 = cos(v0);
		v2 = sin(v0);
		float4(v2*g_vTexCoordScale1.x,v1*g_vTexCoordScale1.y,0,g_vTexCoordCenter1.y+g_vTexCoordOffset1.y-(v2*g_vTexCoordCenter1.x+v1*g_vTexCoordCenter1.y))); >;
	
	// Material1
	int g_nUVSet1 < Default(1); Range4(0, 0, 0, 0, 2, 2, 2, 2); UiOptions("0=Biplanar,1=UV1,2=UV2"); UiType(Enum); UiGroup("Material1/Texture Coordinates,34/1"); >;
	float2 g_vTexCoordCenter1 < Default2(0.5, 0.5); Attribute("0=X,1=Y"); UiType(VectorText); UiGroup("Material1/Texture Transform,35/1"); UiVisibility(1); >;
	int g_nDetailUVSet1 < Default(-1); Range4(-1, -1, -1, -1, 2, 2, 2, 2); UiOptions("-1=Inherit,0=Biplanar,1=UV1,2=UV2"); UiType(Enum); UiGroup("Material1/Texture Coordinates,34/2"); >;
	float2 g_vTexCoordScale1 < Default2(1, 1); Range2(0, 0, 100, 100); Attribute("0=X,1=Y"); UiType(VectorText); UiGroup("Material1/Texture Transform,35/2"); >;
	float2 g_vTexCoordOffset1 < Range2(-1, -1, 1, 1); Attribute("0=X,1=Y"); UiType(VectorText); UiGroup("Material1/Texture Transform,35/4"); UiVisibility(1); >;
	float2 g_vDetailTexCoordCenter1 < Default2(0.5, 0.5); Attribute("0=X,1=Y"); UiType(VectorText); UiGroup("Material1/Detail Texture Transform/5"); UiVisibility(1); >;
	float2 g_vDetailTexCoordScale1 < Default2(1, 1); Range2(0, 0, 100, 100); Attribute("0=X,1=Y"); UiType(VectorText); UiGroup("Material1/Detail Texture Transform/6"); >;
	float g_flDetailTexCoordRotation1 < Range(-360, 360); UiType(Slider); UiGroup("Material1/Detail Texture Transform/8"); UiVisibility(1); >;
	float2 g_vDetailTexCoordOffset1 < Range2(-1, -1, 1, 1); Attribute("0=X,1=Y"); UiType(VectorText); UiGroup("Material1/Detail Texture Transform/9"); UiVisibility(1); >;
	float g_flTexCoordRotation1 < Range(-360, 360); UiType(Slider); UiGroup("Material1/Texture Transform,35/13"); UiVisibility(1); >;
	
	// Color
	float3 g_vColorTint < Default3(1, 1, 1); UiType(Color); UiGroup("Color,10/20"); Expression(SrgbGammaToLinear(this)); >;
	float g_flModelTintAmount < Default(1); UiType(Slider); UiGroup("Color,10/30"); >;
	int g_nScaleTexCoordUByModelScaleAxis < Range4(0, 0, 0, 0, 3, 3, 3, 3); UiOptions("0=None,1=UV.u * model.x,2=UV.u * model.y,3=UV.u * model.z"); UiType(Enum); UiGroup("Color/80"); >;
	int g_nScaleTexCoordVByModelScaleAxis < Range4(0, 0, 0, 0, 3, 3, 3, 3); UiOptions("0=None,1=UV.v * model.x,2=UV.v * model.y,3=UV.v * model.z"); UiType(Enum); UiGroup("Color/90"); >;
	
	// SPIR-V reflection failed for backend HLSL:
	// cbuffer ID 5618 (name: _Globals_), member index 0 (name: g_vColorTint) cannot be expressed with either HLSL packing layout or packoffset.
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
	
	struct _1224
	{
	    mat4 _m0;
	    vec4 _m1;
	};
	
	layout(set = 0) uniform _1224 PerViewConstantBuffer_t;
	
	struct _1269
	{
	    vec3 g_vColorTint;
	    float g_flModelTintAmount;
	    int g_nUVSet1;
	    vec4 g_vTexCoordXform0_1;
	    vec4 g_vTexCoordXform1_1;
	};
	
	layout(set = 0) uniform _1269 _Globals_;
	
	struct _1017
	{
	    vec4 _m0;
	};
	
	layout(set = 0) uniform _1017 PerViewConstantBufferCsgo_t;
	
	layout(location = 0) in vec3 vPositionOs;
	layout(location = 1) in vec2 vTexCoord;
	layout(location = 2) in vec2 vTexCoord2;
	layout(location = 3) in vec3 vNormalOs;
	layout(location = 4) in vec4 vTangentUOs_flTangentVSign;
	layout(location = 5) in uvec4 vBlendIndices;
	layout(location = 6) in uint nInstanceIdx;
	layout(location = 7) in vec4 vBlendColorTint;
	layout(location = 8) in vec4 vColorBlendValues;
	layout(location = 0) out vec4 output_0;
	layout(location = 1) out vec4 output_1;
	layout(location = 2) out vec3 output_2;
	layout(location = 3) out vec3 output_3;
	layout(location = 4) out vec4 output_4;
	layout(location = 5) centroid out vec4 output_5;
	layout(location = 6) centroid out vec3 output_6;
	layout(location = 7) out vec4 output_7;
	layout(location = 8) flat out uint output_8;
	
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
	    vec3 _11179 = normalize(vec4(vNormalOs.xyz, 0.0) * g_transformBuffer_1._m0[_21785]._m0);
	    vec3 _12151 = vec4(vPositionOs.xyz * _21709.xyz, 1.0) * g_transformBuffer_1._m0[_21785]._m0;
	    vec4 _18237 = (vec4(_12151.xyz, 1.0) + (PerViewConstantBuffer_t._m1 * 1.0)).xyzw * PerViewConstantBuffer_t._m0;
	    vec4 _9337 = vTexCoord.xyxy;
	    _9337.z = vTexCoord2.x;
	    _9337.w = vTexCoord2.y;
	    vec4 _18606;
	    if (_Globals_.g_nUVSet1 > 0)
	    {
	        vec4 _11399 = vec4(mix(_9337.xy, _9337.zw, bvec2(_Globals_.g_nUVSet1 == 2)), vTexCoord2);
	        vec2 _9573 = _11399.xy;
	        vec4 _16823 = _11399;
	        _16823.x = dot(_9573, _Globals_.g_vTexCoordXform0_1.xy) + _Globals_.g_vTexCoordXform0_1.w;
	        _16823.y = dot(_9573, _Globals_.g_vTexCoordXform1_1.xy) + _Globals_.g_vTexCoordXform1_1.w;
	        _18606 = _16823;
	    }
	    else
	    {
	        _18606 = _9337;
	    }
	    vec4 _11323 = vec4(_Globals_.g_vColorTint, _23812.w * g_instanceBuffer_1._m0[nInstanceIdx]._m7);
	    vec3 _14119 = _11323.xyz * mix(vec3(1.0), vBlendColorTint.xyz, vec3(vBlendColorTint.w));
	    vec4 _23714 = _11323;
	    _23714.x = _14119.x;
	    _23714.y = _14119.y;
	    _23714.z = _14119.z;
	    output_0 = vec4(_21354, _21355, _17978, _Globals_.g_flModelTintAmount * (1.0 - min(_21354, min(_21355, _17978))));
	    output_1 = vec4(vColorBlendValues.xyz, max(min(vColorBlendValues.w, 1.0), 0.001000000047497451305389404296875));
	    output_2 = _12151.xyz - PerViewConstantBufferCsgo_t._m0.xyz;
	    output_3 = _11179;
	    output_4 = _18606;
	    output_5 = _23714;
	    output_6 = _11179;
	    output_7 = vec4(normalize(vec4(vTangentUOs_flTangentVSign.xyz, 0.0) * g_transformBuffer_1._m0[_21785]._m0), vTangentUOs_flTangentVSign.w);
	    output_8 = g_instanceBuffer_1._m0[nInstanceIdx]._m5 & 65535u;
	    _18237.y = -_18237.y;
	    gl_Position = _18237;
	}
	
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
	
	BoolAttribute(BindlessResources, true);
	StringAttribute(MaterialLayerRefType, csgo_environment);
	BoolAttribute(environmentmapped, true);
	BoolAttribute(environmentmappeddynamic, true);
	BoolAttribute(CanBatchWithDynamicShaderConstants, true);
	IntAttribute(TexCoordScaleByModelU, g_nScaleTexCoordUByModelScaleAxis-1);
	IntAttribute(TexCoordScaleByModelV, g_nScaleTexCoordVByModelScaleAxis-1);
	Float3Attribute(LightSim_MaterialTint, g_vColorTint);
	BoolAttribute(VertexPaintUIPickColor, true);
	BoolAttribute(GroupDefaultCollapseState_TextureTransform, true);
	BoolAttribute(GroupDefaultCollapseState_DetailTextureTransform, true);
	BoolAttribute(HasTexcoordTransform, (g_nUVSet1>0 && (g_vTexCoordScale1.x!=1 || g_vTexCoordScale1.y!=1 || g_flTexCoordRotation1!=0)) ? 1 : 0);
	BoolAttribute(VertexPaintUIAlphaBlendFactor, true);
	BoolAttribute(VertexPaintUIPuddles, (F_WETNESS==1) ? 1 : 0);
	BoolAttribute(SupportsAggregateInstancing, true);
	
	#if (S_MATERIAL_REFERENCE == 1)
		IntAttribute(MaterialLayerCount, 1);
		StringAttribute(MaterialLayerType, csgo_environment);
	#endif
}

PS
{
	StaticCombo( S_DETAIL_NORMAL, F_DETAIL_NORMAL );
	StaticCombo( S_MATERIAL_REFERENCE, F_MATERIAL_REFERENCE );
	StaticCombo( S_ALPHA_TEST_LAYER, F_ALPHA_TEST );
	StaticCombo( S_MODE_TOOLS_VIS, 0..1 );
	StaticCombo( S_SHADER_QUALITY, 0..1 );
	StaticCombo( S_MODE_DEPTH, 0..1 );
	StaticComboRule( Requires( S_MODE_TOOLS_VIS, S_SHADER_QUALITY ) );
	DynamicCombo( D_BAKED_LIGHTING_FROM_VERTEX_STREAM, 0..1 );
	DynamicCombo( D_BAKED_LIGHTING_FROM_PROBE, 0..1 );
	DynamicCombo( D_BAKED_LIGHTING_FROM_LIGHTMAP, 0..1 );
	DynamicCombo( D_OPAQUE_FADE, 0..1 );
	DynamicCombo( D_SPECULAR_CUBE_MAP_STATIC, 0..1 );
	DynamicCombo( D_ALPHA_TEST_PREPASS, 0..1 );
	DynamicComboRule( Allow1( D_BAKED_LIGHTING_FROM_PROBE, D_BAKED_LIGHTING_FROM_VERTEX_STREAM, D_BAKED_LIGHTING_FROM_LIGHTMAP ) );
	DynamicComboRule( Requires( D_SPECULAR_CUBE_MAP_STATIC, S_SHADER_QUALITY==1 ) );
	DynamicComboRule( Allow1( S_ALPHA_TEST_LAYER, D_OPAQUE_FADE ) );
	DynamicComboRule( Allow1( S_MODE_DEPTH, D_SPECULAR_CUBE_MAP_STATIC ) );
	DynamicComboRule( Requires( D_ALPHA_TEST_PREPASS, S_ALPHA_TEST_LAYER ) );
	
	[[layer_constant]] StructuredBuffer g_BarnLights < Attribute("BarnLights"); >;
	[[layer_constant]] StructuredBuffer g_CullBits < Attribute("CullBits"); >;
	bool g_bAdjustBaseColor1 < UiType(CheckBox); Expression(g_nColorCorrectionMode1==1); >;
	bool g_bCubemapNormalization < Attribute("g_bCubemapNormalization"); UiType(CheckBox); >;
	bool g_bDisableNormalMapping < Attribute("g_bDisableNormalMapping"); UiType(CheckBox); >;
	bool g_bDontFlipBackfaceNormals < UiType(CheckBox); Expression(F_DONT_FLIP_BACKFACE_NORMALS ? 1 : 0); >;
	bool g_bHighlightDeprecated < Attribute("g_bHighlightDeprecated"); UiType(CheckBox); >;
	bool g_bIsDeprecated < Attribute("bIsDeprecated"); UiType(CheckBox); >;
	bool g_bRenderBackfaceNormals < UiType(CheckBox); Expression((F_RENDER_BACKFACES ? 1 : 0) ? 1 : 0); >;
	bool g_bRenderingToCubemaps < Attribute("g_bRenderingToCubemaps"); UiType(CheckBox); >;
	bool g_bShowLPVVoxels < Attribute("g_bShowLPVVoxels"); UiType(CheckBox); >;
	bool g_bShowLightmapTexels < Attribute("g_bShowLightmapTexels"); UiType(CheckBox); >;
	bool g_bWetness < UiType(CheckBox); Expression((F_WETNESS==1) ? 1 : 0); >;
	float g_fToolsVisHeightTint < Default(0.9); Attribute("g_fToolsVisHeightTint"); UiType(Slider); >;
	float g_fToolsVisMaxHeightRange < Default(1); Attribute("g_fToolsVisMaxHeightRange"); UiType(Slider); >;
	float g_fToolsVisMaxLightingComplexity < Default(8); Attribute("g_fToolsVisMaxLightingComplexity"); UiType(Slider); >;
	float g_flReflectance < UiType(Slider); Expression(pow((1.5-1)/(1.5+1),2)); >;
	[[layer_constant]] ExternalDescriptorSet g_globalLateBoundBindlessSet < Source(ExternalDescSet); Attribute("g_globalLateBoundBindlessSet"); >;
	[[layer_constant]] ExternalDescriptorSet g_lightBinnerGpuSet < Source(ExternalDescSet); Attribute("g_lightBinnerGpuSet"); >;
	float4x4 g_mTextureAdjust1 < Expression(MatrixMultiply(MatrixColorTint2(float3(1,1,1),1),MatrixColorCorrect2(float3(g_fTextureColorContrast1,g_fTextureColorSaturation1,g_fTextureColorBrightness1),TextureAverageColor(g_tColor1)))); >;
	float4x4 g_mTextureColorAdjust1 < Expression(MatrixMultiply(MatrixColorTint2(g_vTextureColorTint1,1),MatrixColorCorrect2(float3(g_fTextureColorContrast1,g_fTextureColorSaturation1,g_fTextureColorBrightness1),TextureAverageColor(g_tColor1)))); >;
	float4x4 g_mTextureColorAdjust1 < Expression(MatrixMultiply(MatrixColorTint2(float3(1,1,1),1),MatrixColorCorrect2(float3(1,1,1),TextureAverageColor(g_tColor1)))); >;
	int g_nToolsVisMode < Attribute("g_nToolsVisMode"); UiType(Slider); >;
	Texture2D g_tColor1 < Channel(RGB, ArtistDefined(TextureColor1), Srgb); Channel(A, Box(TextureAmbientOcclusion1), Linear); OutputFormat(BC7); SrgbRead(true); >;
	Texture2D g_tColor1 < Channel(RGB, ArtistDefinedOrAlphaWeighted(TextureColor1, TextureTranslucency1), Srgb); Channel(A, PreserveCoverage(TextureTranslucency1), Linear); OutputFormat(BC7); SrgbRead(true); >;
	Texture2D g_tHeight1 < Channel(R, ArtistDefined(TextureHeight1), Linear); Channel(G, ArtistDefined(TextureTintMask1), Linear); Channel(A, Box(TextureMetalness1), Linear); OutputFormat(BC7); SrgbRead(false); >;
	Texture2D g_tHeight1 < Channel(R, ArtistDefined(TextureHeight1), Linear); Channel(G, ArtistDefined(TextureTintMask1), Linear); Channel(B, Box(TextureAmbientOcclusion1), Linear); Channel(A, Box(TextureMetalness1), Linear); OutputFormat(BC7); SrgbRead(false); >;
	Texture2D g_tNormal1 < Channel(RGBA, HemiOctIsoRoughness_RG_B(TextureNormal1, TextureRoughness1), Linear); OutputFormat(BC7); SrgbRead(false); >;
	Texture2D g_tNormalDetail1 < Channel(RG, HemiOctIsoRoughness_RG_B(TextureNormalDetail1), Linear); OutputFormat(ATI2N); SrgbRead(false); >;
	float3 g_vBiplanarTexCoordScale < UiType(VectorText); Expression(1/64*float3(-1,1,-1)); >;
	float4 g_vDetailNormalXform_1 < UiType(VectorText); Expression(v0 = g_flDetailTexCoordRotation1*3.1415927/180;
		v1 = cos(v0);
		v2 = sin(v0);
		float4(v1,-v2,v2,v1)); >;
	float3 g_vFlatOverlayColor < Default2(1, 0); Attribute("FlatOverlayColor"); UiType(VectorText); >;
	float4 g_vNormalXform_1 < UiType(VectorText); Expression(v0 = g_flTexCoordRotation1*3.1415927/180;
		v1 = cos(v0);
		v2 = sin(v0);
		float4(v1,-v2,v2,v1)); >;
	float4 g_vShaderIDColor < Source(ShaderIDColor); UiType(VectorText); >;
	
	// Material1
	CreateInputTexture2D(TextureColor1, Srgb, 8, "", "_color", "Material1,0/Color,10/0", Default4(1, 1, 1, 0));
	CreateInputTexture2D(TextureNormal1, Linear, 8, "NormalizeNormals", "_normal", "Material1/Lighting/0", Default4(0.5, 0.5, 1, 0));
	CreateInputTexture2D(TextureTintMask1, Linear, 8, "", "_mask", "Material1/Tint Mask,15/0", Default4(1, 1, 1, 0));
	CreateInputTexture2D(TextureTranslucency1, Linear, 8, "", "_trans", "Material1/Translucent,15/0", Default4(1, 1, 1, 0));
	int g_nUVSet1 < Default(1); Range4(0, 0, 0, 0, 2, 2, 2, 2); UiOptions("0=Biplanar,1=UV1,2=UV2"); UiType(Enum); UiGroup("Material1/Texture Coordinates,34/1"); >;
	int g_nDetailUVSet1 < Default(-1); Range4(-1, -1, -1, -1, 2, 2, 2, 2); UiOptions("-1=Inherit,0=Biplanar,1=UV1,2=UV2"); UiType(Enum); UiGroup("Material1/Texture Coordinates,34/2"); >;
	float2 g_vTexCoordScale1 < Default2(1, 1); Range2(0, 0, 100, 100); Attribute("0=X,1=Y"); UiType(VectorText); UiGroup("Material1/Texture Transform,35/2"); >;
	float g_fTintMaskBrightness1 < Default(1); Range(0, 4); UiType(Slider); UiGroup("Material1/Tint Mask/5"); >;
	float2 g_vDetailTexCoordScale1 < Default2(1, 1); Range2(0, 0, 100, 100); Attribute("0=X,1=Y"); UiType(VectorText); UiGroup("Material1/Detail Texture Transform/6"); >;
	float g_flDetailTexCoordRotation1 < Range(-360, 360); UiType(Slider); UiGroup("Material1/Detail Texture Transform/8"); UiVisibility(1); >;
	CreateInputTexture2D(TextureHeight1, Linear, 8, "", "_height", "Material1/Height,30/10", Default4(0.5, 0.5, 0.5, 0));
	CreateInputTexture2D(TextureRoughness1, Linear, 8, "Inverse", "_rough", "Material1/Lighting/10", Default4(0.5, 0.5, 0.5, 0));
	float g_fTintMaskContrast1 < Default(1); Range(-2, 4); UiType(Slider); UiGroup("Material1/Tint Mask/10"); >;
	float3 g_vTextureColorTint1 < Default3(1, 1, 1); UiType(Color); UiGroup("Material1/Color Correction,17/10"); >;
	float g_fTextureRoughnessContrast1 < Default(1); Range(0, 4); UiType(Slider); UiGroup("Material1/Lighting/11"); >;
	float g_fTextureRoughnessBrightness1 < Default(1); Range(0, 4); UiType(Slider); UiGroup("Material1/Lighting/12"); >;
	float g_fTextureNormalContrast1 < Default(1); Range(-2, 2); UiType(Slider); UiGroup("Material1/Lighting/13"); >;
	float g_flTexCoordRotation1 < Range(-360, 360); UiType(Slider); UiGroup("Material1/Texture Transform,35/13"); UiVisibility(1); >;
	bool g_bMetalness1 < Default(1); UiType(CheckBox); UiGroup("Material1/Lighting/14"); >;
	CreateInputTexture2D(TextureAmbientOcclusion1, Linear, 8, "", "_ao", "Material1/Lighting,20/20", Default4(1, 1, 1, 0));
	float g_fTextureColorContrast1 < Default(1); Range(0, 4); UiType(Slider); UiGroup("Material1/Color Correction/20"); >;
	float g_flHeightMapScale1 < Default(1); Range(-4, 4); UiType(Slider); UiGroup("Material1/Height/20"); >;
	float3 g_vAmbientOcclusionLevels1 < Default2(0, 0.5); Range(-1, 1); Attribute("0=Option 1,1=Option 2,2=Option 3"); UiType(VectorText); UiGroup("Material1/Lighting/21"); Expression(float3(-this.x,-1.4427*log(max(.0001,1-this.y)),2-this.z)); >;
	CreateInputTexture2D(TextureMetalness1, Linear, 8, "", "_metal", "Material1/Lighting/30", Default4(0, 0, 0, 0));
	float g_fTextureColorSaturation1 < Default(1); Range(0, 4); UiType(Slider); UiGroup("Material1/Color Correction/30"); >;
	float g_flHeightMapZeroPoint1 < Default(0.5); UiType(Slider); UiGroup("Material1/Height/30"); >;
	CreateInputTexture2D(TextureNormalDetail1, Linear, 8, "NormalizeNormals", "_normal", "Material1/Detail/35", Default4(0.5, 0.5, 1, 0));
	float g_fTextureColorBrightness1 < Default(1); Range(-8, 8); UiType(Slider); UiGroup("Material1/Color Correction/40"); >;
	float g_fDetailTextureNormalContrast1 < Default(1); Range(-2, 2); UiType(Slider); UiGroup("Material1/Detail/45"); >;
	int g_nColorCorrectionMode1 < UiOptions("0=Mask All,1=Mask only Tint"); UiType(Enum); UiGroup("Material1/Color Correction/45"); >;
	bool g_bModelTint1 < Default(1); UiType(CheckBox); UiGroup("Material1/Color Correction/60"); >;
	float g_flWetnessDarkeningStrength1 < Default(1); UiType(Slider); UiGroup("Material1/Lighting/61"); >;
	bool g_bSnowLayer1 < UiType(CheckBox); UiGroup("Material1/Snow,100"); >;
	
	// Fog
	bool g_bFogEnabled < Default(1); UiType(CheckBox); UiGroup("Fog"); >;
	
	// Wetness
	bool g_bWetnessUseHeightmapAdjustments < UiType(CheckBox); UiGroup("Wetness/2"); UiVisibility(F_WETNESS ? 1 : 0); >;
	bool g_bPuddlesOnVerticalSurfaces < UiType(CheckBox); UiGroup("Wetness,9/3"); UiVisibility(F_WETNESS ? 1 : 0); >;
	float g_fPuddleStrength < Default(1); UiType(Slider); UiGroup("Wetness/5"); UiVisibility(F_WETNESS ? 1 : 0); >;
	float3 g_vPuddleSedimentColor < Default3(0.62, 0.56, 0.5); UiType(Color); UiGroup("Wetness/10"); Expression(SrgbGammaToLinear(this)); UiVisibility(F_WETNESS ? 1 : 0); >;
	float g_fPuddleSedimentHeight < Default(0.9); Range(0, 2); UiType(Slider); UiGroup("Wetness/15"); Expression(this*2-1); UiVisibility(F_WETNESS ? 1 : 0); >;
	float g_fPuddleSedimentOpacity < Default(0.25); UiType(Slider); UiGroup("Wetness/16"); UiVisibility(F_WETNESS ? 1 : 0); >;
	float g_fPuddleRoughness < Default(0.02); UiType(Slider); UiGroup("Wetness/17"); UiVisibility(F_WETNESS ? 1 : 0); >;
	float g_fPuddleBlendSoftness < Default(0.08); UiType(Slider); UiGroup("Wetness/18"); UiVisibility(F_WETNESS ? 1 : 0); >;
	float g_fWetEdgeStrength < Default(0.5); UiType(Slider); UiGroup("Wetness/20"); UiVisibility(F_WETNESS ? 1 : 0); >;
	float g_fWetEdgeSpread < Default(0.2); UiType(Slider); UiGroup("Wetness/25"); UiVisibility(F_WETNESS ? 1 : 0); >;
	float g_fWetnessStrength < Default(1); Range(0, 2); UiType(Slider); UiGroup("Wetness/30"); UiVisibility(F_WETNESS ? 1 : 0); >;
	float g_fRainStrength < Default(1); Range(0, 2); UiType(Slider); UiGroup("Wetness/35"); UiVisibility(F_WETNESS ? 1 : 0); >;
	float g_fRippleStrength < Default(1); Range(0, 2); UiType(Slider); UiGroup("Wetness/40"); UiVisibility(F_WETNESS ? 1 : 0); >;
	
	// Translucent
	float g_flAlphaTestReference < Default(0.5); Range(0.01, 0.99); UiType(Slider); UiGroup("Translucent"); >;
	float g_flAntiAliasedEdgeStrength < Default(1); UiType(Slider); UiGroup("Translucent"); >;
	
	// Color
	float g_flBlendSoftnessDistanceModifierStrength < Default(1); UiType(Slider); UiGroup("Color/120"); >;
	
	// Occlusion Culling
	float g_flOcclusionCullingBoundsScale < Default(1); Range(1, 100); UiType(Slider); UiGroup("Occlusion Culling"); UiVisibility(F_OCCLUSION_CULLING_BOUNDS_SCALE); >;
	
	// Texture Address Mode
	int g_nTextureAddressModeU < UiOption("RsTextureAddressMode_t"); UiType(Enum); UiGroup("Texture Address Mode"); >;
	int g_nTextureAddressModeV < UiOption("RsTextureAddressMode_t"); UiType(Enum); UiGroup("Texture Address Mode"); >;
	
	#if (S_MODE_TOOLS_VIS == 1)
		Texture2D g_tColor1 < Channel(RGB, ArtistDefinedOrAlphaWeighted(TextureColor1, TextureTranslucency1), Srgb); Channel(A, PreserveCoverage(TextureTranslucency1), Linear); OutputFormat(BC7); SrgbRead(true); >;
	#endif
	#if (S_MODE_DEPTH == 1)
		Texture2D g_tColor1 < Channel(RGB, ArtistDefinedOrAlphaWeighted(TextureColor1, TextureTranslucency1), Srgb); Channel(A, PreserveCoverage(TextureTranslucency1), Linear); OutputFormat(BC7); SrgbRead(true); >;
	#endif
	#if (S_ALPHA_TEST_LAYER == 1)
		Texture2D g_tColor1 < Channel(RGB, ArtistDefinedOrAlphaWeighted(TextureColor1, TextureTranslucency1), Srgb); Channel(A, PreserveCoverage(TextureTranslucency1), Linear); OutputFormat(BC7); SrgbRead(true); >;
	#endif
	#if (S_SHADER_QUALITY == 1)
		Texture2D g_tColor1 < Channel(RGB, ArtistDefinedOrAlphaWeighted(TextureColor1, TextureTranslucency1), Srgb); Channel(A, PreserveCoverage(TextureTranslucency1), Linear); OutputFormat(BC7); SrgbRead(true); >;
	#endif
	
	// Variant parameters
	float4x4 g_mTextureColorAdjust1 < Expression(MatrixMultiply(MatrixColorTint2(g_vTextureColorTint1,1),MatrixColorCorrect2(float3(g_fTextureColorContrast1,g_fTextureColorSaturation1,g_fTextureColorBrightness1),TextureAverageColor(g_tColor1)))); >;
	float4x4 g_mTextureColorAdjust1 < Expression(MatrixMultiply(MatrixColorTint2(float3(1,1,1),1),MatrixColorCorrect2(float3(1,1,1),TextureAverageColor(g_tColor1)))); >;
	Texture2D g_tColor1 < Channel(RGB, ArtistDefined(TextureColor1), Srgb); Channel(A, Box(TextureAmbientOcclusion1), Linear); OutputFormat(BC7); SrgbRead(true); >;
	Texture2D g_tHeight1 < Channel(R, ArtistDefined(TextureHeight1), Linear); Channel(G, ArtistDefined(TextureTintMask1), Linear); Channel(A, Box(TextureMetalness1), Linear); OutputFormat(BC7); SrgbRead(false); >;
	Texture2D g_tHeight1 < Channel(R, ArtistDefined(TextureHeight1), Linear); Channel(G, ArtistDefined(TextureTintMask1), Linear); Channel(B, Box(TextureAmbientOcclusion1), Linear); Channel(A, Box(TextureMetalness1), Linear); OutputFormat(BC7); SrgbRead(false); >;
	
	// SPIR-V reflection failed for backend HLSL:
	// cbuffer ID 5618 (name: _Globals_), member index 5 (name: g_vBiplanarTexCoordScale) cannot be expressed with either HLSL packing layout or packoffset.
	//
	// Re-attempting reflection with the GLSL backend.
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, GLSL reflection with SPIRV-Cross by KhronosGroup
	
	#version 460
	#if defined(GL_EXT_control_flow_attributes)
	#extension GL_EXT_control_flow_attributes : require
	#define SPIRV_CROSS_FLATTEN [[flatten]]
	#define SPIRV_CROSS_BRANCH [[dont_flatten]]
	#define SPIRV_CROSS_UNROLL [[unroll]]
	#define SPIRV_CROSS_LOOP [[dont_unroll]]
	#else
	#define SPIRV_CROSS_FLATTEN
	#define SPIRV_CROSS_BRANCH
	#define SPIRV_CROSS_UNROLL
	#define SPIRV_CROSS_LOOP
	#endif
	#extension GL_KHR_shader_subgroup_arithmetic : require
	
	const vec3 _2109[3] = vec3[](vec3(-1.0, 0.0, 0.0), vec3(0.0, 1.0, 0.0), vec3(-1.0, 0.0, 0.0));
	const vec3 _922[3] = vec3[](vec3(0.0, 0.0, 1.0), vec3(0.0, -1.0, 0.0), vec3(0.0, 0.0, 1.0));
	
	struct _2872
	{
	    vec4 _m0[3];
	};
	
	struct _71
	{
	    vec4 _m0[4];
	};
	
	struct _2139
	{
	    mat4 _m0[4];
	};
	
	struct _200
	{
	    mat4 _m0;
	    mat4 _m1;
	    vec4 _m2;
	    vec4 _m3;
	    vec4 _m4;
	    vec4 _m5;
	    vec3 _m6;
	    uint _m7;
	    vec4 _m8;
	    vec4 _m9;
	    vec4 _m10;
	    float _m11;
	    float _m12;
	    uint _m13;
	    int _m14;
	    mat4x3 _m15;
	    vec4 _m16;
	    vec4 _m17;
	    vec4 _m18;
	    vec4 _m19;
	    vec4 _m20;
	    vec3 _m21;
	    float _m22;
	    mat4 _m23;
	};
	
	float _4;
	vec3 _5;
	vec4 _6;
	float _7;
	
	struct _2558
	{
	    uint g_sTrilinearWrap;
	    uint g_sTrilinearClamp;
	    uint g_sPointClamp;
	    uint g_sUserConfig;
	    uint g_tColor1;
	    vec3 g_vBiplanarTexCoordScale;
	    int g_bSnowLayer1;
	    int g_nUVSet1;
	    vec2 g_vTexCoordScale1;
	    vec4 g_vNormalXform_1;
	    float g_flWetnessDarkeningStrength1;
	    uint g_tNormal1;
	    uint g_tHeight1;
	    mat4 g_mTextureColorAdjust1;
	    int g_bPuddlesOnVerticalSurfaces;
	    int g_bWetnessUseHeightmapAdjustments;
	    float g_fPuddleStrength;
	    vec3 g_vPuddleSedimentColor;
	    float g_fPuddleSedimentHeight;
	    float g_fPuddleSedimentOpacity;
	    float g_fPuddleRoughness;
	    float g_fPuddleBlendSoftness;
	    float g_fWetEdgeStrength;
	    float g_fWetEdgeSpread;
	    float g_fWetnessStrength;
	    float g_fRainStrength;
	    float g_fRippleStrength;
	    uint g_sCookieSampler;
	    uint g_tShadowDepthBufferCmpSampler;
	    int g_bFogEnabled;
	    int g_bDontFlipBackfaceNormals;
	    int g_bRenderBackfaceNormals;
	    float g_flReflectance;
	    int g_bWetness;
	};
	
	layout(set = 1) uniform _2558 _Globals_;
	
	struct _698
	{
	    ivec4 _m0;
	    ivec4 _m1;
	    uint _m2;
	    uint _m3;
	    uint _m4;
	    uint _m5;
	    uint _m6;
	    uint _m7;
	    float _m8;
	    float _m9;
	    float _m10;
	    float _m11;
	    float _m12;
	    mat4 _m13;
	    vec2 _m14;
	    float _m15;
	    vec4 _m16;
	    vec4 _m17;
	    vec4 _m18;
	    vec4 _m19;
	    vec4 _m20;
	    vec4 _m21;
	    mat4 _m22;
	    vec4 _m23;
	    vec4 _m24;
	    vec4 _m25;
	    float _m26;
	};
	
	layout(set = 1) uniform _698 PerViewConstantBufferCsgo_t;
	
	struct _1337
	{
	    float _m0;
	    float _m1;
	    vec2 _m2;
	    vec2 _m3;
	    vec4 _m4;
	    vec3 _m5;
	};
	
	layout(set = 1) uniform _1337 PerViewConstantBuffer_t;
	
	struct _1992
	{
	    _2872 _m0;
	    _71 _m1;
	    vec4 _m2;
	    vec4 _m3;
	    vec4 _m4;
	    uvec4 _m5;
	    uvec4 _m6;
	    vec4 _m7;
	    vec4 _m8;
	    vec4 _m9;
	    vec4 _m10;
	    int _m11;
	    float _m12;
	    vec4 _m13;
	    float _m14;
	    float _m15;
	    float _m16;
	    float _m17;
	    _2139 _m18;
	    _71 _m19;
	    uint _m20;
	    uint _m21;
	};
	
	layout(set = 3) uniform _1992 PerViewLightingConstantBufferGpu_t;
	
	layout(set = 3, binding = 30, std430) readonly buffer g_CullBits
	{
	    uint _m0[];
	} g_CullBits_1;
	
	layout(set = 3, binding = 31, std430) readonly buffer g_BarnLights
	{
	    layout(row_major) _200 _m0[];
	} g_BarnLights_1;
	
	layout(set = 4, binding = 46) uniform texture2D g_bindless_Texture2D_float4[65536];
	layout(set = 4, binding = 29) uniform sampler g_bindless_Sampler[2048];
	layout(set = 4, binding = 29) uniform samplerShadow g_bindless_Sampler_1[2048];
	layout(set = 4, binding = 46) uniform texture3D g_bindless_Texture3D_float4[65536];
	layout(set = 4, binding = 46) uniform textureCubeArray g_bindless_TextureCubeArray_float4[65536];
	layout(set = 4, binding = 46) uniform textureCube g_bindless_TextureCube_float4[65536];
	
	layout(location = 0) in vec4 input_0;
	layout(location = 1) in vec4 input_1;
	layout(location = 2) in vec3 input_2;
	layout(location = 3) in vec3 input_3;
	layout(location = 4) in vec4 input_4;
	layout(location = 5) centroid in vec4 input_5;
	layout(location = 6) centroid in vec3 input_6;
	layout(location = 7) in vec4 input_7;
	layout(location = 0) out vec4 output_0;
	
	void main()
	{
	    vec4 _11408 = gl_FragCoord;
	    _11408.w = 1.0 / _11408.w;
	    vec3 _21709;
	    if (dot(input_3.xyz, input_3.xyz) >= 1.0099999904632568359375)
	    {
	        _21709 = input_6.xyz;
	    }
	    else
	    {
	        _21709 = input_3.xyz;
	    }
	    bool _14874 = _Globals_.g_bRenderBackfaceNormals != 0;
	    bool _12885;
	    if (_14874)
	    {
	        _12885 = _Globals_.g_bDontFlipBackfaceNormals == 0;
	    }
	    else
	    {
	        _12885 = false;
	    }
	    vec3 _10251;
	    SPIRV_CROSS_BRANCH
	    if (_12885)
	    {
	        _10251 = _21709 * (gl_FrontFacing ? 1.0 : (-1.0));
	    }
	    else
	    {
	        _10251 = _21709;
	    }
	    vec3 _24347 = normalize(_10251);
	    vec3 _10061 = input_2 + PerViewConstantBufferCsgo_t._m25.xyz;
	    bool _7312 = _Globals_.g_nUVSet1 > 1;
	    bool _21710;
	    if (PerViewConstantBufferCsgo_t._m26 > 1.9900000095367431640625)
	    {
	        _21710 = step(0.5, fract(PerViewConstantBuffer_t._m0 * 0.5)) != 0.0;
	    }
	    else
	    {
	        _21710 = !(PerViewConstantBufferCsgo_t._m26 > 0.9900000095367431640625);
	    }
	    vec3 _22993 = _10061 - PerViewConstantBuffer_t._m5.xyz;
	    bool _12886;
	    if (_14874)
	    {
	        _12886 = _Globals_.g_bDontFlipBackfaceNormals == 0;
	    }
	    else
	    {
	        _12886 = false;
	    }
	    bool _18545;
	    if (_12886)
	    {
	        _18545 = !gl_FrontFacing;
	    }
	    else
	    {
	        _18545 = false;
	    }
	    vec3 _7147 = dFdxFine(_22993);
	    vec3 _20949 = dFdyFine(_22993);
	    float _12157 = 1.0 / length(input_3);
	    vec3 _11587 = input_3 * _12157;
	    vec3 _8889;
	    if (_18545)
	    {
	        _8889 = _11587 * (-1.0);
	    }
	    else
	    {
	        _8889 = _11587;
	    }
	    vec3 _10247;
	    vec3 _11711;
	    if (_7312)
	    {
	        vec2 _13939 = dFdxFine(input_4.zw);
	        vec2 _13915 = dFdyFine(input_4.zw);
	        float _17522 = _13915.y;
	        float _15279 = dot(_13939, vec2(_17522, -_13915.x));
	        float _17298 = (_15279 < 0.0) ? (-1.0) : 1.0;
	        vec2 _24530 = vec2(_17522, -_13939.y) * _17298;
	        vec3 _7463 = ((_7147 - (_8889 * dot(_7147, _8889))) * _24530.x) + ((_20949 - (_8889 * dot(_20949, _8889))) * _24530.y);
	        vec3 _9082;
	        if (abs(_15279) > 0.0)
	        {
	            _9082 = normalize(_7463);
	        }
	        else
	        {
	            _9082 = _7463;
	        }
	        _11711 = _9082;
	        _10247 = cross(_8889, _9082) * (_17298 * float((dot(_20949, cross(_8889, _7147)) < 0.0) ? (-1) : 1));
	    }
	    else
	    {
	        _11711 = vec3(0.0);
	        _10247 = vec3(0.0);
	    }
	    bool _8452 = _Globals_.g_nUVSet1 == 0;
	    vec2 _6616;
	    ivec2 _13136;
	    vec2 _13694;
	    ivec2 _16305;
	    vec2 _17114;
	    vec2 _17115;
	    vec2 _17116;
	    vec2 _17117;
	    vec2 _17118;
	    if (_8452)
	    {
	        vec3 _10577 = abs(_24347);
	        vec3 _16100 = _10577;
	        float _17349 = _10577.x;
	        float _8043 = _10577.y;
	        bool _12887;
	        if (_17349 > _8043)
	        {
	            _12887 = _17349 > _10577.z;
	        }
	        else
	        {
	            _12887 = false;
	        }
	        ivec3 _23727;
	        if (_12887)
	        {
	            _23727 = ivec3(0, 1, 2);
	        }
	        else
	        {
	            _23727 = mix(ivec3(2, 0, 1), ivec3(1, 2, 0), bvec3(_8043 > _10577.z));
	        }
	        bool _12888;
	        if (_17349 < _8043)
	        {
	            _12888 = _17349 < _10577.z;
	        }
	        else
	        {
	            _12888 = false;
	        }
	        ivec3 _11775;
	        if (_12888)
	        {
	            _11775 = ivec3(0, 1, 2);
	        }
	        else
	        {
	            _11775 = mix(ivec3(2, 0, 1), ivec3(1, 2, 0), bvec3(_8043 < _10577.z));
	        }
	        ivec3 _19442 = (ivec3(3) - _11775) - _23727;
	        ivec2 _19321;
	        if (_23727.x == 1)
	        {
	            _19321 = _23727.zy;
	        }
	        else
	        {
	            _19321 = _23727.yz;
	        }
	        int _9992 = _19442.x;
	        ivec2 _19322;
	        if (_9992 == 1)
	        {
	            _19322 = _19442.zy;
	        }
	        else
	        {
	            _19322 = _19442.yz;
	        }
	        vec2 _19651 = saturate((vec2(_16100[_23727.x], _16100[_9992]) - vec2(0.577300012111663818359375)) * vec2(2.365744113922119140625));
	        vec3 _18781 = _10061 * _Globals_.g_vBiplanarTexCoordScale.xyz;
	        vec3 _16414 = _18781;
	        vec3 _16415 = dFdxFine(_18781);
	        vec3 _16446 = dFdyFine(_18781);
	        _13136 = _19321;
	        _16305 = _19322;
	        _17114 = vec2(_16414[_19321.x], _16414[_19321.y]);
	        _17115 = vec2(_16414[_19322.x], _16414[_19322.y]);
	        _17116 = vec2(_16415[_19321.x], _16415[_19321.y]);
	        _17117 = vec2(_16446[_19321.x], _16446[_19321.y]);
	        _17118 = vec2(_16415[_19322.x], _16415[_19322.y]);
	        _13694 = vec2(_16446[_19322.x], _16446[_19322.y]);
	        _6616 = _19651 / vec2(_19651.x + _19651.y);
	    }
	    else
	    {
	        _13136 = ivec2(0);
	        _16305 = ivec2(0);
	        _17114 = vec2(0.0);
	        _17115 = vec2(0.0);
	        _17116 = vec2(0.0);
	        _17117 = vec2(0.0);
	        _17118 = vec2(0.0);
	        _13694 = vec2(0.0);
	        _6616 = vec2(0.0);
	    }
	    vec3 _18905;
	    _18905.x = input_4.x;
	    _18905.y = input_4.y;
	    vec4 _9716;
	    vec3 _24878;
	    if (_8452)
	    {
	        _9716 = vec4(0.0);
	        _24878 = _18905;
	    }
	    else
	    {
	        vec4 _8625 = vec4(dFdx(_18905.xy), dFdy(_18905.xy));
	        vec2 _20312 = _18905.xy + vec2(length(_8625) * 1.0000000133514319600180897396058e-10);
	        vec3 _20488;
	        _20488.x = _20312.x;
	        _20488.y = _20312.y;
	        _9716 = _8625;
	        _24878 = _20488;
	    }
	    vec4 _19323;
	    if (_8452)
	    {
	        _19323 = (textureGrad(sampler2D(g_bindless_Texture2D_float4[_Globals_.g_tHeight1], g_bindless_Sampler[_Globals_.g_sUserConfig]), (_17114 * _Globals_.g_vTexCoordScale1.xy).xy, (_17116 * _Globals_.g_vTexCoordScale1.xy).xy, (_17117 * _Globals_.g_vTexCoordScale1.xy).xy) * _6616.x) + (textureGrad(sampler2D(g_bindless_Texture2D_float4[_Globals_.g_tHeight1], g_bindless_Sampler[_Globals_.g_sUserConfig]), (_17115 * _Globals_.g_vTexCoordScale1.xy).xy, (_17118 * _Globals_.g_vTexCoordScale1.xy).xy, (_13694 * _Globals_.g_vTexCoordScale1.xy).xy) * _6616.y);
	    }
	    else
	    {
	        _19323 = texture(sampler2D(g_bindless_Texture2D_float4[_Globals_.g_tHeight1], g_bindless_Sampler[_Globals_.g_sUserConfig]), _24878.xy).xyzw;
	    }
	    float _21711;
	    SPIRV_CROSS_BRANCH
	    if (_Globals_.g_bWetnessUseHeightmapAdjustments != 0)
	    {
	        _21711 = max(0.0, _19323.x);
	    }
	    else
	    {
	        _21711 = _19323.x;
	    }
	    float _13138;
	    vec3 _13189;
	    vec4 _22057;
	    if (_8452)
	    {
	        vec2 _8315 = (_17114 * _Globals_.g_vTexCoordScale1.xy).xy;
	        vec2 _7412 = (_17116 * _Globals_.g_vTexCoordScale1.xy).xy;
	        vec2 _8903 = (_17117 * _Globals_.g_vTexCoordScale1.xy).xy;
	        vec4 _23806 = textureGrad(sampler2D(g_bindless_Texture2D_float4[_Globals_.g_tColor1], g_bindless_Sampler[_Globals_.g_sUserConfig]), _8315, _7412, _8903) * _6616.x;
	        vec4 _12167 = textureGrad(sampler2D(g_bindless_Texture2D_float4[_Globals_.g_tNormal1], g_bindless_Sampler[_Globals_.g_sUserConfig]), _8315, _7412, _8903);
	        float _18178 = _12167.z * _6616.x;
	        float _15456 = _12167.x;
	        float _24534 = _12167.y;
	        float _16784 = (_15456 + _24534) - 1.00392162799835205078125;
	        float _11177 = _15456 - _24534;
	        vec3 _21631 = normalize(vec3(vec2(_16784, _11177), (1.0 - abs(_16784)) - abs(_11177))).xyz * _6616.x;
	        vec3 _24466 = (_2109[_13136.x] * _21631.x) + (_922[_13136.y] * _21631.y);
	        float _13137;
	        vec3 _13753;
	        vec4 _14101;
	        if (_6616.y > 0.0)
	        {
	            vec2 _17047 = (_17115 * _Globals_.g_vTexCoordScale1.xy).xy;
	            vec2 _10017 = (_17118 * _Globals_.g_vTexCoordScale1.xy).xy;
	            vec2 _8904 = (_13694 * _Globals_.g_vTexCoordScale1.xy).xy;
	            vec4 _12168 = textureGrad(sampler2D(g_bindless_Texture2D_float4[_Globals_.g_tNormal1], g_bindless_Sampler[_Globals_.g_sUserConfig]), _17047, _10017, _8904);
	            float _13491 = _12168.x;
	            float _21308 = _12168.y;
	            float _16785 = (_13491 + _21308) - 1.00392162799835205078125;
	            float _11178 = _13491 - _21308;
	            vec3 _21632 = normalize(vec3(vec2(_16785, _11178), (1.0 - abs(_16785)) - abs(_11178))).xyz * _6616.y;
	            _13137 = _18178 + (_12168.z * _6616.y);
	            _14101 = _23806 + (textureGrad(sampler2D(g_bindless_Texture2D_float4[_Globals_.g_tColor1], g_bindless_Sampler[_Globals_.g_sUserConfig]), _17047, _10017, _8904) * _6616.y);
	            _13753 = _24466 + ((_2109[_16305.x] * _21632.x) + (_922[_16305.y] * _21632.y));
	        }
	        else
	        {
	            _13137 = _18178;
	            _14101 = _23806;
	            _13753 = _24466;
	        }
	        _13138 = _13137;
	        _13189 = normalize(_13753 + _24347);
	        _22057 = _14101;
	    }
	    else
	    {
	        vec4 _11179 = textureGrad(sampler2D(g_bindless_Texture2D_float4[_Globals_.g_tNormal1], g_bindless_Sampler[_Globals_.g_sUserConfig]), _24878.xy, _9716.xy, _9716.zw);
	        float _6493 = _11179.x;
	        float _14881 = _11179.y;
	        float _16783 = (_6493 + _14881) - 1.00392162799835205078125;
	        float _11176 = _6493 - _14881;
	        vec3 _15162 = normalize(vec3(vec2(_16783, _11176), (1.0 - abs(_16783)) - abs(_11176)));
	        vec2 _20890 = _15162.xy;
	        float _7796 = dot(_20890, _Globals_.g_vNormalXform_1.xy);
	        float _19701 = dot(_20890, _Globals_.g_vNormalXform_1.zw);
	        vec3 _19582 = _15162;
	        _19582.x = _7796;
	        _19582.y = _19701;
	        bvec3 _20662 = bvec3(_7312);
	        vec3 _10844 = abs(_19582.xyz);
	        vec2 _16475 = (-vec2(_7796, (-1.0) * _19701)) / vec2(max(_10844.z, 0.0078125 * max(_10844.x, _10844.y)));
	        _13138 = _11179.z;
	        _13189 = normalize(_8889 - ((mix(input_7.xyz * _12157, _11711, _20662) * _16475.x) + (mix((cross(input_3, input_7.xyz) * ((input_7.w > 0.0) ? 1.0 : (-1.0))) * _12157, _10247, _20662) * _16475.y)));
	        _22057 = textureGrad(sampler2D(g_bindless_Texture2D_float4[_Globals_.g_tColor1], g_bindless_Sampler[_Globals_.g_sUserConfig]), _24878.xy, _9716.xy, _9716.zw).xyzw;
	    }
	    vec3 _19225 = normalize(_13189);
	    float _6375 = saturate(_13138);
	    float _14713 = saturate(mix(0.0, 1.0, pow(_22057.w, 1.0)));
	    float _7029 = saturate(_19323.y);
	    vec3 _25191 = mix(_22057.xyz, vec4((vec4(_22057.xyz, 1.0) * _Globals_.g_mTextureColorAdjust1).xyz, _4).xyz, vec3(_7029));
	    vec4 _17842;
	    _17842.x = _25191.x;
	    _17842.y = _25191.y;
	    _17842.z = _25191.z;
	    float _24323 = dot(_17842.xyz, vec3(0.2125000059604644775390625, 0.7153999805450439453125, 0.07209999859333038330078125));
	    vec3 _9577 = normalize(max(input_0.xyz, vec3(0.001000000047497451305389404296875)));
	    bool _21618 = _Globals_.g_bSnowLayer1 != 0;
	    vec3 _6756 = _19225.xyz;
	    vec3 _6663 = vec4(saturate(mix(_17842.xyz, (_9577 * min(_24323 / dot(_9577.xyz, vec3(0.2125000059604644775390625, 0.7153999805450439453125, 0.07209999859333038330078125)), (3.0 * _24323) * max(input_0.x, max(input_0.y, input_0.z)))).xyz, vec3(input_0.w * _7029))).xyz, _7).xyz;
	    vec2 _11281 = vec2(_6375);
	    vec3 _21712;
	    if (_21710)
	    {
	        _21712 = _6663 * mix(vec3(1.0), input_5.xyz, vec3(saturate(_7029)));
	    }
	    else
	    {
	        _21712 = _6663;
	    }
	    bool _12889;
	    if (_Globals_.g_bWetness != 0)
	    {
	        _12889 = (_Globals_.g_fPuddleStrength + _Globals_.g_fWetnessStrength) > 0.0;
	    }
	    else
	    {
	        _12889 = false;
	    }
	    bool _12890;
	    if (_12889)
	    {
	        _12890 = input_1.z > 0.0;
	    }
	    else
	    {
	        _12890 = false;
	    }
	    vec3 _13141;
	    float _13960;
	    vec2 _16306;
	    float _17119;
	    float _17120;
	    vec3 _17121;
	    vec3 _24595;
	    SPIRV_CROSS_BRANCH
	    if (_12890)
	    {
	        vec4 _19372 = texture(sampler2D(g_bindless_Texture2D_float4[PerViewConstantBufferCsgo_t._m7], g_bindless_Sampler[_Globals_.g_sUserConfig]), (_10061.xy * 0.006000000052154064178466796875).xy);
	        float _21302 = _24347.z;
	        float _14498 = pow(max(0.0, _21302), 32.0);
	        float _23204 = min(min(input_1.z, saturate(PerViewConstantBufferCsgo_t._m11)), 1.0 - (saturate(PerViewConstantBufferCsgo_t._m12 - 0.5) * 2.0));
	        float _20426 = saturate(_23204 - 0.75);
	        float _8284 = _23204 + (4.0 * (_20426 * _20426));
	        float _16777 = _8284 - _Globals_.g_fWetEdgeSpread;
	        float _11964 = saturate(_8284 * 20.0);
	        vec4 _9717;
	        float _24879;
	        SPIRV_CROSS_BRANCH
	        if (_Globals_.g_bPuddlesOnVerticalSurfaces != 0)
	        {
	            vec4 _9186 = vec4(0.0, 0.0, 1.0, 0.0);
	            _9186.x = _24347.x;
	            _9186.y = _24347.y;
	            _9186.z = _21302;
	            _9717 = _9186;
	            _24879 = max(0.0, _16777);
	        }
	        else
	        {
	            _9717 = vec4(0.0, 0.0, 1.0, 0.0);
	            _24879 = max(0.0, (_8284 * _14498) - _Globals_.g_fWetEdgeSpread);
	        }
	        float _15811 = max(0.001000000047497451305389404296875, _Globals_.g_fPuddleBlendSoftness);
	        float _14611 = smoothstep(_24879 + _15811, _24879 - (input_1.w + (_15811 * 2.0)), _21711) * _11964;
	        float _19808 = max((smoothstep(_23204, _16777 - (0.20000000298023223876953125 * _8284), _21711) * _Globals_.g_fWetEdgeStrength) * _11964, _14611) * _Globals_.g_fPuddleStrength;
	        float _17924 = (_23204 - 1.0) - _21711;
	        float _10334 = (saturate(_17924 + _Globals_.g_fPuddleSedimentHeight) * _Globals_.g_fPuddleSedimentOpacity) * _14611;
	        float _13706 = saturate(((saturate((((_8284 * 2.0) - (mix(0.5, _19372.w, saturate(_14498 * 20.0)) * 0.5)) - (_21711 * 0.5)) + 0.25) * _Globals_.g_fWetnessStrength) * _11964) + _14611);
	        float _13140;
	        float _13151;
	        vec4 _23607;
	        SPIRV_CROSS_BRANCH
	        if (_13706 > 0.5)
	        {
	            float _12497 = _Globals_.g_fRippleStrength * PerViewConstantBufferCsgo_t._m9;
	            vec3 _6617;
	            vec4 _12891;
	            float _13139;
	            SPIRV_CROSS_BRANCH
	            if (_12497 > 0.0)
	            {
	                vec3 _18756 = normalize(vec3(-1.0, 0.20000000298023223876953125, 0.0));
	                float _9925 = PerViewConstantBufferCsgo_t._m10 * 6.283185482025146484375;
	                float _22373 = sin(_9925);
	                float _20617 = cos(_9925);
	                vec2 _23932 = _18756.xy * mat2(vec2(_20617, -_22373), vec2(_22373, _20617));
	                vec3 _22900 = _18756;
	                _22900.x = _23932.x;
	                _22900.y = _23932.y;
	                vec3 _21326 = -cross(_22900, _24347);
	                vec3 _13887 = _10061.xyz;
	                float _9965 = dot(_13887, _21326);
	                float _12056 = 1.0 - input_1.z;
	                vec2 _20274 = ((vec2(dot(_13887, _22900)) + (vec2(0.100000001490116119384765625, -0.100000001490116119384765625) * _9965)) + (vec2(8.0, 5.0) * _10061.z)) + vec2((_12056 * _12056) * (-80.0));
	                vec2 _15991 = vec2(_20274.x, _9965) * vec2(0.0199999995529651641845703125, 0.010999999940395355224609375);
	                vec4 _20877 = texture(sampler2D(g_bindless_Texture2D_float4[PerViewConstantBufferCsgo_t._m7], g_bindless_Sampler[_Globals_.g_sUserConfig]), (_15991 + (vec2(0.20000000298023223876953125, 0.0) * PerViewConstantBuffer_t._m1)).xy);
	                vec2 _18922 = (_20877.xy * 2.0) - vec2(1.0);
	                float _22216 = saturate(length(fwidth(_15991)) * 10.0);
	                vec2 _15297 = ((_18922 * vec2(0.100000001490116119384765625, 0.0500000007450580596923828125)) * input_1.z) * mix(1.0, 0.300000011920928955078125, _22216);
	                vec2 _13711 = _21326.xy;
	                vec4 _19601 = vec4(0.0);
	                _19601.x = dot(_22900.xy, _15297);
	                _19601.y = dot(_13711, _15297);
	                vec2 _16046 = (vec2(_20274.y, _9965) * vec2(0.03599999845027923583984375, 0.01620000042021274566650390625)) + (_18922 * 0.0500000007450580596923828125);
	                vec4 _20878 = texture(sampler2D(g_bindless_Texture2D_float4[PerViewConstantBufferCsgo_t._m7], g_bindless_Sampler[_Globals_.g_sUserConfig]), (_16046 + (vec2(0.1500000059604644775390625, 0.0) * PerViewConstantBuffer_t._m1)).xy);
	                vec2 _17104 = (((_20878.xy * 2.0) - vec2(1.0)) * 0.05200000107288360595703125) * input_1.z;
	                _17104.y = _17104.y * 0.5;
	                float _9250 = saturate(length(fwidth(_16046)) * 10.0);
	                vec2 _13560 = _17104 * mix(1.0, 0.300000011920928955078125, _9250);
	                vec2 _13330 = _19601.xy + vec2(dot(_22900.xy, _13560), dot(_13711, _13560));
	                vec4 _20489 = _19601;
	                _20489.x = _13330.x;
	                _20489.y = _13330.y;
	                _20489.w = input_1.z * (_20877.z + _20878.z);
	                vec3 _20490;
	                _20490.x = _10061.x;
	                _20490.y = _10061.y;
	                _13139 = _12497 * (0.039999999105930328369140625 * (_22216 + _9250));
	                _12891 = _9717 + ((_20489 * _14498) * _12497);
	                _6617 = _20490;
	            }
	            else
	            {
	                _13139 = 0.0;
	                _12891 = _9717;
	                _6617 = _10061;
	            }
	            float _8914 = (_Globals_.g_fRainStrength * PerViewConstantBufferCsgo_t._m8) * PerViewConstantBufferCsgo_t._m8;
	            float _9982;
	            vec4 _21594;
	            SPIRV_CROSS_BRANCH
	            if (_8914 > 0.0)
	            {
	                vec2 _10473 = _6617.xy * 0.119999997317790985107421875;
	                vec3 _20506 = vec3(PerViewConstantBuffer_t._m1 * 6.5) + vec3(0.0, 0.3167000114917755126953125, 0.633400022983551025390625);
	                vec3 _13155;
	                _13155 = vec3(0.0);
	                int _18440;
	                vec3 _25251;
	                int _16208 = 0;
	                SPIRV_CROSS_UNROLL
	                for (;;)
	                {
	                    if (!(_16208 < 3))
	                    {
	                        break;
	                    }
	                    vec3 _23854 = vec3(0.97130000591278076171875, 0.751800000667572021484375, 0.362399995326995849609375);
	                    vec3 _16408 = vec3(0.23770000040531158447265625, 0.65939998626708984375, 0.931999981403350830078125);
	                    mat2 _21666 = mat2(vec2(_23854[_16208], -_16408[_16208]), vec2(_16408[_16208], _23854[_16208]));
	                    vec3 _16409 = vec3(0.60000002384185791015625, 0.666100025177001953125, 0.73220002651214599609375);
	                    float _23410 = _20506[_16208];
	                    vec2 _10212 = ((_21666 * _10473) * _16409[_16208]) + vec2(_23410 * 0.0199999995529651641845703125);
	                    vec2 _7848 = _21666 * ((fract(_10212) * 2.0) - vec2(1.0));
	                    float _8329 = length(_7848);
	                    float _20173 = saturate(1.0 - (_8329 * mix(3.0, 1.0, _14611)));
	                    float _20213 = saturate(1.0 - (_8329 * 6.0));
	                    float _7135 = floor(fract(_10212.x * 0.100000001490116119384765625) * 10.0);
	                    float _23598 = _20506[_16208];
	                    float _18429 = _23598 + ((_7135 + (floor(fract(_10212.y * 0.100000001490116119384765625) * 10.0) * (0.20000000298023223876953125 + _7135))) * 8.0);
	                    _20506[_16208] = _18429;
	                    float _18120 = _8914 * _8914;
	                    _25251 = vec3(_13155.xy + (((-(((((_7848 / vec2(_8329)) * cos(mix(1.0, (_20173 * 40.0) + (PerViewConstantBuffer_t._m1 * 65.0), _14611))) * _20173) * _20173) * mix(2.0, 0.25, saturate(fwidth(_20173) * 20.0)))) * ((saturate((sin(((_20173 * mix(1.0, 4.0, _14611)) + _18429) * _8914) - (1.0 - ((0.20000000298023223876953125 * _18120) * mix(0.25, 1.0, _14611)))) * 2.0) * _20173) / _18120)) * mix(16.0, 2.0, _14611)), _13155.z + (((saturate((sin((((_20213 + _18429) + 4.0) + (sin(_21711 * 60.0) * 0.25)) * _8914) - (1.0 - (_18120 * 0.02000000141561031341552734375))) * 2.0) * _20213) / _18120) * 28.0));
	                    _18440 = _16208 + 1;
	                    _13155 = _25251;
	                    _16208 = _18440;
	                    continue;
	                }
	                vec3 _9348 = _13155 * _14498;
	                vec2 _15752 = _12891.xy + _9348.xy;
	                vec4 _20491 = _12891;
	                _20491.x = _15752.x;
	                _20491.y = _15752.y;
	                _9982 = _9348.z;
	                _21594 = _20491;
	            }
	            else
	            {
	                _9982 = 0.0;
	                _21594 = _12891;
	            }
	            vec3 _10508 = normalize(_21594.xyz);
	            vec4 _16886 = _21594;
	            _16886.x = _10508.x;
	            _16886.y = _10508.y;
	            _16886.z = _10508.z;
	            _13140 = _9982;
	            _13151 = _13139;
	            _23607 = _16886;
	        }
	        else
	        {
	            _13140 = 0.0;
	            _13151 = 0.0;
	            _23607 = _9717;
	        }
	        float _10839 = _14611 * _Globals_.g_fPuddleStrength;
	        vec3 _23311 = vec3(_19808 * _10334);
	        vec3 _13712 = normalize(mix(_19225.xyz, _23607.xyz, vec3(saturate(_10839 * 4.0))));
	        float _9038 = max(_13706 * (1.0 - saturate(PerViewConstantBufferCsgo_t._m12 * 2.0)), _19808);
	        vec3 _18806 = mix(_21712, pow(_21712, vec3(1.2999999523162841796875)) * 0.800000011920928955078125, saturate((pow(_21712, vec3(0.25)) * (_9038 * _6375)) * 8.0) * _Globals_.g_flWetnessDarkeningStrength1);
	        _13141 = fma(mix((mix(_18806, _18806 * 0.5, vec3(saturate(_14611 * 1.5))) * mix(1.0, _14713, _19808)) * mix(1.0, 1.0 - _17924, _10334), _Globals_.g_vPuddleSedimentColor, _23311), vec3(1.0 + _13140), vec3(_13140 * 0.100000001490116119384765625));
	        _16306 = saturate(mix(_11281.xx, vec2(_Globals_.g_fPuddleRoughness), vec2(_9038)) + vec2(_13151 + (length(fwidth(_13712.xyz)) * 0.5)));
	        _17119 = mix(_14713, 1.0, _19808);
	        _17120 = mix(_Globals_.g_flReflectance, 0.0350000001490116119384765625, _9038);
	        _17121 = _13712;
	        _13960 = _10839 * (0.20000000298023223876953125 + (((0.1500000059604644775390625 * _23607.w) * _23607.w) * _23607.w));
	        _24595 = mix(_6756, _23607.xyz, _23311);
	    }
	    else
	    {
	        _13141 = _21712;
	        _16306 = _11281;
	        _17119 = _14713;
	        _17120 = _Globals_.g_flReflectance;
	        _17121 = vec3(1.0);
	        _13960 = 0.0;
	        _24595 = _6756;
	    }
	    vec3 _9451 = mix(vec3(_17120).xyz, _13141.xyz, vec3(_19323.w));
	    vec3 _17892 = mix(_17121, _24595, bvec3(all(equal(_17121, vec3(1.0)))));
	    vec3 _10560 = _24347.xyz;
	    vec3 _11099 = dFdx(_10560);
	    vec3 _9175 = dFdy(_10560);
	    vec3 _10347 = _11099.xyz;
	    vec3 _12420 = _9175.xyz;
	    vec2 _21818 = max(_16306.xy, vec2(pow(saturate(max(dot(_10347, _10347), dot(_12420, _12420))), 0.333000004291534423828125)));
	    vec3 _15598 = -_24347;
	    vec4 _23875 = vec4(_24595.xyz, 1.0);
	    bvec4 _24464 = notEqual(PerViewConstantBufferCsgo_t._m0, ivec4(0));
	    float _21714;
	    if (_24464.x)
	    {
	        vec3 _11394 = _24347.xyz;
	        vec2 _11086 = ((floor(_11408.xy * PerViewConstantBufferCsgo_t._m15) * PerViewConstantBufferCsgo_t._m14.xy) + (PerViewConstantBufferCsgo_t._m14.xy * 0.5)).xy;
	        vec4 _18418 = textureGather(sampler2D(g_bindless_Texture2D_float4[PerViewConstantBufferCsgo_t._m4], g_bindless_Sampler[_Globals_.g_sCookieSampler]), _11086).xyzw - _11408.zzzz;
	        float _18579 = _18418.w;
	        float _12013 = _18418.z;
	        bool _12285 = abs(_12013) < _18579;
	        vec2 _23168;
	        if (_12285)
	        {
	            _23168 = vec2(PerViewConstantBufferCsgo_t._m14.x, 0.0);
	        }
	        else
	        {
	            _23168 = vec2(0.0);
	        }
	        float _20965 = _12285 ? _12013 : _18579;
	        float _15372 = _18418.x;
	        bool _12287 = abs(_15372) < _20965;
	        vec2 _23169;
	        if (_12287)
	        {
	            _23169 = vec2(0.0, PerViewConstantBufferCsgo_t._m14.y);
	        }
	        else
	        {
	            _23169 = _23168;
	        }
	        vec4 _10010 = normalize(vec4(PerViewLightingConstantBufferGpu_t._m2.x * fma(dot(_15598, normalize(vec3(PerViewLightingConstantBufferGpu_t._m1._m0[0].xy, 0.25))), 0.5, 0.5), PerViewLightingConstantBufferGpu_t._m2.y * fma(dot(_15598, normalize(vec3(PerViewLightingConstantBufferGpu_t._m1._m0[1].xy, 0.25))), 0.5, 0.5), PerViewLightingConstantBufferGpu_t._m2.z * fma(dot(_15598, normalize(vec3(PerViewLightingConstantBufferGpu_t._m1._m0[2].xy, 0.25))), 0.5, 0.5), PerViewLightingConstantBufferGpu_t._m2.w * fma(dot(_15598, normalize(vec3(PerViewLightingConstantBufferGpu_t._m1._m0[3].xy, 0.25))), 0.5, 0.5)));
	        vec4 _13232 = max(vec4(dot(PerViewLightingConstantBufferGpu_t._m1._m0[0].xyz, _11394), dot(PerViewLightingConstantBufferGpu_t._m1._m0[1].xyz, _11394), dot(PerViewLightingConstantBufferGpu_t._m1._m0[2].xyz, _11394), dot(PerViewLightingConstantBufferGpu_t._m1._m0[3].xyz, _11394)).xyzw, vec4(0.0)) * normalize(saturate(((_10010 - vec4(max(max(_10010.x, _10010.y), max(_10010.z, _10010.w)))) + vec4(0.20000000298023223876953125)) * vec4(5.0)));
	        _21714 = (1.0 / (dot(_13232, vec4(1.0)) + PerViewLightingConstantBufferGpu_t._m3.x)) * (PerViewLightingConstantBufferGpu_t._m3.x + dot(_13232, textureLod(sampler2D(g_bindless_Texture2D_float4[PerViewConstantBufferCsgo_t._m3], g_bindless_Sampler[_Globals_.g_sPointClamp]), (_11086 + mix(_23169, PerViewConstantBufferCsgo_t._m14.xy, bvec2(abs(_18418.y) < (_12287 ? _15372 : _20965))).xy).xy, 0.0)));
	    }
	    else
	    {
	        _21714 = 1.0;
	    }
	    float _21715;
	    SPIRV_CROSS_BRANCH
	    if (PerViewLightingConstantBufferGpu_t._m11 != 0)
	    {
	        int _23989;
	        int _10191;
	        float _13142;
	        vec3 _14975;
	        int _13039 = 0;
	        for (;;)
	        {
	            if (!(_13039 < PerViewLightingConstantBufferGpu_t._m11))
	            {
	                _13142 = 1.0;
	                _14975 = vec3(0.0);
	                _10191 = -1;
	                break;
	            }
	            vec4 _18322 = vec4(input_2.xyz, 1.0) * PerViewLightingConstantBufferGpu_t._m18._m0[_13039];
	            float _12779 = _18322.x;
	            if (max(abs(_12779), abs(_18322.y)) < PerViewLightingConstantBufferGpu_t._m13[_13039])
	            {
	                vec3 _19470 = vec3(_12779, _18322.yz);
	                vec2 _24804 = _19470.xy;
	                vec2 _22193 = vec2(1.0) - saturate((abs(_24804) * vec2(PerViewLightingConstantBufferGpu_t._m15)) + vec2(PerViewLightingConstantBufferGpu_t._m14));
	                vec2 _20561 = (_24804 * PerViewLightingConstantBufferGpu_t._m19._m0[_13039].zw) + PerViewLightingConstantBufferGpu_t._m19._m0[_13039].xy;
	                vec3 _20492 = _19470;
	                _20492.x = _20561.x;
	                _20492.y = _20561.y;
	                _13142 = saturate(_22193.x * _22193.y);
	                _14975 = _20492;
	                _10191 = _13039;
	                break;
	            }
	            _23989 = _13039 + 1;
	            _13039 = _23989;
	            continue;
	        }
	        float _18423;
	        if (_10191 >= 0)
	        {
	            float _18270 = textureLod(sampler2DShadow(g_bindless_Texture2D_float4[PerViewLightingConstantBufferGpu_t._m20], g_bindless_Sampler_1[_Globals_.g_tShadowDepthBufferCmpSampler]), vec3(_14975.xy, saturate(_14975.z + PerViewLightingConstantBufferGpu_t._m12)), 0.0);
	            float _12501;
	            SPIRV_CROSS_BRANCH
	            if (_13142 < 1.0)
	            {
	                float _7934;
	                if (_10191 < (PerViewLightingConstantBufferGpu_t._m11 - 1))
	                {
	                    int _15335 = _10191 + 1;
	                    vec4 _19671 = vec4(input_2.xyz, 1.0) * PerViewLightingConstantBufferGpu_t._m18._m0[_15335];
	                    vec2 _20562 = (_19671.xy * PerViewLightingConstantBufferGpu_t._m19._m0[_15335].zw) + PerViewLightingConstantBufferGpu_t._m19._m0[_15335].xy;
	                    vec3 _20493;
	                    _20493.x = _20562.x;
	                    _20493.y = _20562.y;
	                    _7934 = textureLod(sampler2DShadow(g_bindless_Texture2D_float4[PerViewLightingConstantBufferGpu_t._m20], g_bindless_Sampler_1[_Globals_.g_tShadowDepthBufferCmpSampler]), vec3(_20493.xy, saturate(_19671.z + PerViewLightingConstantBufferGpu_t._m12)), 0.0);
	                }
	                else
	                {
	                    _7934 = 1.0;
	                }
	                _12501 = mix(_7934, _18270, _13142);
	            }
	            else
	            {
	                _12501 = _18270;
	            }
	            _18423 = _12501;
	        }
	        else
	        {
	            _18423 = 1.0;
	        }
	        float _13279 = mix(_18423, 1.0, saturate((distance(_10061.xyz, PerViewConstantBuffer_t._m5) * PerViewLightingConstantBufferGpu_t._m17) + PerViewLightingConstantBufferGpu_t._m16));
	        float _12502;
	        if (_24464.y)
	        {
	            _12502 = min(_13279, textureLod(sampler2D(g_bindless_Texture2D_float4[PerViewConstantBufferCsgo_t._m5], g_bindless_Sampler[_Globals_.g_sTrilinearClamp]), (_11408.xy * PerViewConstantBuffer_t._m4.xy).xy, 0.0).z);
	        }
	        else
	        {
	            _12502 = _13279;
	        }
	        _21715 = _12502;
	    }
	    else
	    {
	        _21715 = 1.0;
	    }
	    vec3 _9718;
	    vec3 _24880;
	    SPIRV_CROSS_BRANCH
	    if ((dot(PerViewLightingConstantBufferGpu_t._m9.xyz, _24595.xyz) * _21715) > 0.0)
	    {
	        vec3 _15460 = mix(_17892, _24595.xyz, bvec3(all(equal(_17892, vec3(1.0)))));
	        float _13811 = max(0.0, dot(_24595.xyz, PerViewLightingConstantBufferGpu_t._m9.xyz));
	        vec3 _17874 = vec3(_13811);
	        vec3 _18223;
	        if (_13960 > 0.0)
	        {
	            float _8780 = dot(_15460, PerViewLightingConstantBufferGpu_t._m9.xyz);
	            float _8124 = saturate(_13960);
	            _18223 = mix(_17874.xyz, vec3((((0.5 + (_13811 * 0.5)) + pow(1.0 - saturate(_8780), 4.0)) * saturate((_8780 + 0.20000000298023223876953125) * 4.0)) * saturate(mix(dot(mix(_24595.xyz, _15460, vec3(10.0)), PerViewLightingConstantBufferGpu_t._m9.xyz), 1.0, _8124))), vec3(_8124));
	        }
	        else
	        {
	            _18223 = _17874;
	        }
	        vec2 _17301 = max(_21818, vec2(PerViewLightingConstantBufferGpu_t._m9.w));
	        vec3 _12281 = normalize(PerViewLightingConstantBufferGpu_t._m9.xyz + (-normalize(_10061.xyz - PerViewConstantBuffer_t._m5.xyz)).xyz).xyz;
	        float _12386 = dot(_12281, _15460.xyz);
	        float _19210 = max(0.0, dot(PerViewLightingConstantBufferGpu_t._m9.xyz, _12281));
	        float _9850 = _17301.x;
	        float _25211 = _9850 * _9850;
	        float _19095 = _25211 * _25211;
	        float _15346 = ((_12386 * _12386) * (_19095 - 1.0)) + 1.0;
	        vec3 _16808 = (PerViewLightingConstantBufferGpu_t._m10.xyz * _21715).xyz;
	        _9718 = ((_9451.xyz * (_19095 / (((_15346 * _15346) * (_19210 * _19210)) * ((_9850 * 4.0) + 2.0)))).xyz * _13811).xyz * _16808;
	        _24880 = PerViewLightingConstantBufferGpu_t._m4.xyz + (_18223.xyz * _16808);
	    }
	    else
	    {
	        _9718 = vec3(0.0);
	        _24880 = PerViewLightingConstantBufferGpu_t._m4.xyz;
	    }
	    bvec4 _24465 = notEqual(PerViewConstantBufferCsgo_t._m1, ivec4(0));
	    bool _20059 = _24465.x;
	    vec4 _19364;
	    if (_20059)
	    {
	        vec4 _18621 = vec4(_10061.xyz, 1.0).xyzw * PerViewConstantBufferCsgo_t._m13;
	        float _20176 = _18621.w;
	        vec2 _11414 = _18621.xy / vec2(_20176);
	        vec4 _6651;
	        _6651.x = clamp(((_11414.x + 1.0) * PerViewConstantBuffer_t._m3.x) * 0.5, 0.0, PerViewConstantBuffer_t._m3.x - 1.0);
	        _6651.y = clamp(((1.0 - _11414.y) * PerViewConstantBuffer_t._m3.y) * 0.5, 0.0, PerViewConstantBuffer_t._m3.y - 1.0);
	        _6651.w = _20176;
	        _19364 = _6651;
	    }
	    else
	    {
	        _19364 = _11408;
	    }
	    uvec2 _12083 = uvec2(_19364.xy - PerViewConstantBuffer_t._m2.xy) >> uvec2(PerViewLightingConstantBufferGpu_t._m6.x);
	    uint _10838 = PerViewLightingConstantBufferGpu_t._m5.y + (((_12083.y * PerViewLightingConstantBufferGpu_t._m6.y) + _12083.x) * PerViewLightingConstantBufferGpu_t._m5.z);
	    uint _23393 = PerViewLightingConstantBufferGpu_t._m5.x + (uint(clamp(_19364.w * PerViewLightingConstantBufferGpu_t._m7.x, 0.0, PerViewLightingConstantBufferGpu_t._m7.y)) * PerViewLightingConstantBufferGpu_t._m5.z);
	    vec3 _13143;
	    vec3 _16324;
	    _13143 = _9718;
	    _16324 = _24880;
	    uint _21567;
	    vec3 _13144;
	    vec3 _16325;
	    uint _17017 = 0u;
	    for (;;)
	    {
	        if (!(_17017 < PerViewLightingConstantBufferGpu_t._m5.z))
	        {
	            break;
	        }
	        uint _14475 = subgroupOr(g_CullBits_1._m0[_10838 + _17017] & g_CullBits_1._m0[_23393 + _17017]);
	        _13144 = _13143;
	        _16325 = _16324;
	        uint _20344;
	        vec3 _13212;
	        vec3 _15670;
	        uint _17018 = _14475;
	        for (;;)
	        {
	            if (!(_17018 != 0u))
	            {
	                break;
	            }
	            int _12608 = int(uint(findLSB(_17018)) + (_17017 * 32u));
	            _20344 = _17018 & (_17018 - 1u);
	            do
	            {
	                vec4 _24893 = g_BarnLights_1._m0[_12608]._m0 * vec4(input_2.xyz, 1.0);
	                vec3 _10521 = _24893.xyz / vec3(_24893.w);
	                vec4 _22905;
	                _22905.x = _10521.x;
	                _22905.y = _10521.y;
	                float _21775 = _10521.z;
	                _22905.z = _21775;
	                vec3 _21642 = _22905.xyz;
	                bool _7424;
	                if (all(greaterThan(_22905.xyz, vec3(-1.0, -1.0, 0.0))))
	                {
	                    _7424 = all(lessThan(_22905.xyz, vec3(1.0)));
	                }
	                else
	                {
	                    _7424 = false;
	                }
	                bool _12893;
	                if (!_7424)
	                {
	                    _12893 = true;
	                }
	                else
	                {
	                    _12893 = !all(lessThanEqual(abs((g_BarnLights_1._m0[_12608]._m15 * vec4(input_2.xyz, 1.0)).xyz), vec3(1.0)));
	                }
	                if (_12893)
	                {
	                    _13212 = _13144;
	                    _15670 = _16325;
	                    break;
	                }
	                float _23572 = 2.0 * g_BarnLights_1._m0[_12608]._m5.y;
	                float _18492 = (2.0 * g_BarnLights_1._m0[_12608]._m5.z) * g_BarnLights_1._m0[_12608]._m5.z;
	                float _14805 = 2.0 * g_BarnLights_1._m0[_12608]._m5.x;
	                float _9058 = _14805 * g_BarnLights_1._m0[_12608]._m5.y;
	                float _17330 = 2.0 * g_BarnLights_1._m0[_12608]._m5.w;
	                float _19825 = _17330 * g_BarnLights_1._m0[_12608]._m5.z;
	                vec3 _16268 = vec3(_9058 - _19825, (1.0 - (_14805 * g_BarnLights_1._m0[_12608]._m5.x)) - _18492, (_23572 * g_BarnLights_1._m0[_12608]._m5.z) + (_17330 * g_BarnLights_1._m0[_12608]._m5.x)) * g_BarnLights_1._m0[_12608]._m6.z;
	                float _21316;
	                if (g_BarnLights_1._m0[_12608]._m3.z > 0.0)
	                {
	                    _21316 = min(1.0, _21775 * g_BarnLights_1._m0[_12608]._m3.z);
	                }
	                else
	                {
	                    _21316 = 1.0;
	                }
	                float _19667;
	                if (g_BarnLights_1._m0[_12608]._m3.w > 0.0)
	                {
	                    _19667 = _21316 * min(1.0, (1.0 - _21775) * g_BarnLights_1._m0[_12608]._m3.w);
	                }
	                else
	                {
	                    _19667 = _21316;
	                }
	                vec3 _11180;
	                float _11633;
	                if (g_BarnLights_1._m0[_12608]._m2.w != 0.0)
	                {
	                    vec3 _10018 = g_BarnLights_1._m0[_12608]._m2.xyz - input_2.xyz;
	                    float _18345 = dot(_10018, _10018);
	                    float _17647 = sqrt(_18345);
	                    vec3 _12302 = _10018 - _16268;
	                    vec3 _10210;
	                    do
	                    {
	                        vec3 _20229 = (_10018 + _16268) - _12302;
	                        float _25105 = dot(-_12302, _20229);
	                        if (_25105 <= 0.0)
	                        {
	                            _10210 = _12302;
	                            break;
	                        }
	                        else
	                        {
	                            _10210 = _12302 + (_20229 * min(1.0, _25105 / dot(_20229, _20229)));
	                            break;
	                        }
	                        break; // unreachable workaround
	                    } while(false);
	                    _11180 = _10018 / vec3(_17647);
	                    _11633 = ((_19667 * (g_BarnLights_1._m0[_12608]._m2.w / max(_18345, g_BarnLights_1._m0[_12608]._m2.w))) * saturate(g_BarnLights_1._m0[_12608]._m3.x + (g_BarnLights_1._m0[_12608]._m3.y * _17647))) * saturate(g_BarnLights_1._m0[_12608]._m6.x + (g_BarnLights_1._m0[_12608]._m6.y * dot(vec3((1.0 - (_23572 * g_BarnLights_1._m0[_12608]._m5.y)) - _18492, _9058 + _19825, (_14805 * g_BarnLights_1._m0[_12608]._m5.z) - (_17330 * g_BarnLights_1._m0[_12608]._m5.y)), normalize(_10210))));
	                }
	                else
	                {
	                    _11180 = g_BarnLights_1._m0[_12608]._m2.xyz;
	                    _11633 = _19667;
	                }
	                vec3 _17828 = (g_BarnLights_1._m0[_12608]._m4.xyz * 1.0).xyz * _11633;
	                bool _24419;
	                if (g_BarnLights_1._m0[_12608]._m8.z > 0.0)
	                {
	                    _24419 = !_20059;
	                }
	                else
	                {
	                    _24419 = false;
	                }
	                vec3 _21548;
	                SPIRV_CROSS_BRANCH
	                if (g_BarnLights_1._m0[_12608]._m4.w == 0.0)
	                {
	                    float _10342;
	                    do
	                    {
	                        vec2 _22154 = abs(_22905.xy);
	                        if (g_BarnLights_1._m0[_12608]._m9.z == 0.0)
	                        {
	                            _10342 = smoothstep(1.0, g_BarnLights_1._m0[_12608]._m9.x, _22154.x) * smoothstep(1.0, g_BarnLights_1._m0[_12608]._m9.y, _22154.y);
	                            break;
	                        }
	                        else
	                        {
	                            float _11475 = _22154.x;
	                            float _15266 = 2.0 / g_BarnLights_1._m0[_12608]._m9.z;
	                            float _15018 = _22154.y;
	                            float _23041 = (-0.5) * g_BarnLights_1._m0[_12608]._m9.z;
	                            float _11981 = (g_BarnLights_1._m0[_12608]._m9.x * g_BarnLights_1._m0[_12608]._m9.y) * pow(max(pow(g_BarnLights_1._m0[_12608]._m9.y * _11475, _15266) + pow(g_BarnLights_1._m0[_12608]._m9.x * _15018, _15266), 1.1754943508222875079687365372222e-38), _23041);
	                            float _16524 = pow(max(pow(_11475, _15266) + pow(_15018, _15266), 1.1754943508222875079687365372222e-38), _23041);
	                            if (_11981 < _16524)
	                            {
	                                _10342 = smoothstep(_16524, _11981, 1.0);
	                                break;
	                            }
	                            else
	                            {
	                                _10342 = float(_16524 > 1.0);
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
	                    vec3 _12503;
	                    if (g_BarnLights_1._m0[_12608]._m4.w < 0.0)
	                    {
	                        vec4 _17795 = vec4(-g_BarnLights_1._m0[_12608]._m5.xyz, g_BarnLights_1._m0[_12608]._m5.w);
	                        vec4 _19008 = _17795.xyzw * vec4(-1.0, -1.0, -1.0, 1.0);
	                        vec3 _24989 = _19008.xyz;
	                        vec3 _23629 = vec4((-_11180).xyz, 0.0).xyz;
	                        float _15156 = -dot(_23629, _24989);
	                        vec3 _20479 = vec4((_23629 * _19008.w) + cross(_23629, _24989), _15156).xyz;
	                        vec3 _23592 = _17795.xyz;
	                        vec3 _12170 = ((_20479 * g_BarnLights_1._m0[_12608]._m5.w) + (_23592 * _15156)) + cross(_23592, _20479);
	                        vec3 _14081 = vec3(vec2(atan(_12170.y, -_12170.x) * 0.15915493667125701904296875, acos(_12170.z) * 0.3183098733425140380859375), -g_BarnLights_1._m0[_12608]._m4.w);
	                        vec2 _20564 = (_14081.xy * g_BarnLights_1._m0[_12608]._m9.zw) + g_BarnLights_1._m0[_12608]._m9.xy;
	                        vec3 _20496 = _14081;
	                        _20496.x = _20564.x;
	                        _20496.y = _20564.y;
	                        _12503 = _17828.xyz * textureLod(sampler3D(g_bindless_Texture3D_float4[PerViewLightingConstantBufferGpu_t._m21], g_bindless_Sampler[_Globals_.g_sTrilinearWrap]), _20496.xyz, 0.0).xyz;
	                    }
	                    else
	                    {
	                        vec3 _13791 = vec3(fma(_22905.xy, vec2(0.5, -0.5), vec2(0.5)), g_BarnLights_1._m0[_12608]._m4.w);
	                        vec2 _20563 = (_13791.xy * g_BarnLights_1._m0[_12608]._m9.zw) + g_BarnLights_1._m0[_12608]._m9.xy;
	                        vec3 _20494 = _13791;
	                        _20494.x = _20563.x;
	                        _20494.y = _20563.y;
	                        _12503 = _17828.xyz * textureLod(sampler3D(g_bindless_Texture3D_float4[PerViewLightingConstantBufferGpu_t._m21], g_bindless_Sampler[_Globals_.g_sCookieSampler]), _20494.xyz, 0.0).xyz;
	                    }
	                    _21548 = _12503;
	                }
	                if (all(equal(_21548.xyz, vec3(0.0))))
	                {
	                    _13212 = _13144;
	                    _15670 = _16325;
	                    break;
	                }
	                vec3 _21549;
	                if (_24419)
	                {
	                    vec3 _19629;
	                    if ((g_BarnLights_1._m0[_12608]._m13 & 4u) != 0u)
	                    {
	                        vec2 _6281 = _22905.yx * vec2(1.0, -1.0);
	                        vec3 _23714 = _21642;
	                        _23714.x = _6281.x;
	                        _23714.y = _6281.y;
	                        _19629 = _23714;
	                    }
	                    else
	                    {
	                        _19629 = _21642;
	                    }
	                    vec3 _20482 = _21548.xyz * mix(1.0, textureLod(sampler2DShadow(g_bindless_Texture2D_float4[PerViewLightingConstantBufferGpu_t._m20], g_bindless_Sampler_1[_Globals_.g_tShadowDepthBufferCmpSampler]), vec3(vec3(fma(_19629.xy, g_BarnLights_1._m0[_12608]._m8.zw, g_BarnLights_1._m0[_12608]._m8.xy), _19629.z).xy, saturate(_19629.z + PerViewLightingConstantBufferGpu_t._m12)), 0.0), g_BarnLights_1._m0[_12608]._m12);
	                    if (all(equal(_20482.xyz, vec3(0.0))))
	                    {
	                        _13212 = _13144;
	                        _15670 = _16325;
	                        break;
	                    }
	                    _21549 = _20482;
	                }
	                else
	                {
	                    _21549 = _21548;
	                }
	                vec3 _15461 = mix(_17892, _24595.xyz, bvec3(all(equal(_17892, vec3(1.0)))));
	                float _13812 = max(0.0, dot(_24595.xyz, _11180.xyz));
	                vec3 _17875 = vec3(_13812);
	                vec3 _18225;
	                if (_13960 > 0.0)
	                {
	                    float _8781 = dot(_15461, _11180.xyz);
	                    float _8125 = saturate(_13960);
	                    _18225 = mix(_17875.xyz, vec3((((0.5 + (_13812 * 0.5)) + pow(1.0 - saturate(_8781), 4.0)) * saturate((_8781 + 0.20000000298023223876953125) * 4.0)) * saturate(mix(dot(mix(_24595.xyz, _15461, vec3(10.0)), _11180.xyz), 1.0, _8125))), vec3(_8125));
	                }
	                else
	                {
	                    _18225 = _17875;
	                }
	                vec2 _17302 = max(_21818, vec2(g_BarnLights_1._m0[_12608]._m11));
	                vec3 _12282 = normalize(_11180.xyz + (-normalize(_10061.xyz - PerViewConstantBuffer_t._m5.xyz)).xyz).xyz;
	                float _12387 = dot(_12282, _15461.xyz);
	                float _19211 = max(0.0, dot(_11180.xyz, _12282));
	                float _9851 = _17302.x;
	                float _25212 = _9851 * _9851;
	                float _19097 = _25212 * _25212;
	                float _15348 = ((_12387 * _12387) * (_19097 - 1.0)) + 1.0;
	                _13212 = _13144.xyz + (((_9451.xyz * (_19097 / (((_15348 * _15348) * (_19211 * _19211)) * ((_9851 * 4.0) + 2.0)))).xyz * _13812).xyz * _21549.xyz);
	                _15670 = _16325.xyz + (_18225.xyz * _21549.xyz);
	                break;
	            } while(false);
	            _13144 = _13212;
	            _16325 = _15670;
	            _17018 = _20344;
	            continue;
	        }
	        _21567 = _17017 + 1u;
	        _13143 = _13144;
	        _16324 = _16325;
	        _17017 = _21567;
	        continue;
	    }
	    float _17172 = dot(_21818.xy, vec2(0.5));
	    vec3 _7507 = _17892.xyz;
	    vec3 _17138 = normalize(_10061.xyz - PerViewConstantBuffer_t._m5.xyz);
	    float _17225 = _17172 * _17172;
	    float _20711 = saturate(1.0 - _17225);
	    vec4 _15344 = (vec4(-1.0, -0.0274999998509883880615234375, -0.572000026702880859375, 0.02199999988079071044921875) * _17172) + vec4(1.0, 0.0425000004470348358154296875, 1.03999996185302734375, -0.039999999105930328369140625);
	    float _21215 = _15344.x;
	    vec2 _24572 = (vec2(-1.03999996185302734375, 1.03999996185302734375) * ((min(_21215 * _21215, exp2((-9.27999973297119140625) * max(0.0, dot((-_17138).xyz, _7507)))) * _21215) + _15344.y)) + _15344.zw;
	    float _20339 = _24572.y;
	    vec2 _11427 = vec2(_20339, _24572.x + _20339);
	    vec3 _8745 = vec3(dot(PerViewLightingConstantBufferGpu_t._m0._m0[0].xyzw, _23875), dot(PerViewLightingConstantBufferGpu_t._m0._m0[1].xyzw, _23875), dot(PerViewLightingConstantBufferGpu_t._m0._m0[2].xyzw, _23875)).xyz;
	    vec3 _16991 = _16324.xyz + _8745;
	    vec3 _20418 = vec3(_21714 * _17119).xyz;
	    vec3 _20015 = _8745 * _20418;
	    vec3 _20579;
	    if (_21618)
	    {
	        _20579 = mix(_20015, pow(_20015, vec3(1.0499999523162841796875, 0.949999988079071044921875, 0.800000011920928955078125)), vec3(float(_21618)));
	    }
	    else
	    {
	        _20579 = _20015;
	    }
	    vec3 _22686 = (_16324.xyz + _20579.xyz) * (_13141.xyz * (1.0 - _19323.w)).xyz;
	    float _12931 = _22686.x;
	    vec4 _11204 = vec4(_12931, _22686.yz, input_5.w);
	    _11204.x = _12931;
	    _11204.y = _22686.y;
	    _11204.z = _22686.z;
	    vec3 _15753 = _11204.xyz + (_13143.xyz * _20418).xyz;
	    vec4 _20497 = _11204;
	    _20497.x = _15753.x;
	    _20497.y = _15753.y;
	    _20497.z = _15753.z;
	    vec3 _15734 = _20497.xyz + ((((mix(_11427.xxx, _11427.yyy, _9451) * textureLod(samplerCubeArray(g_bindless_TextureCubeArray_float4[PerViewConstantBufferCsgo_t._m6], g_bindless_Sampler[_Globals_.g_sTrilinearClamp]), vec4(normalize(mix(_7507, reflect(_17138.xyz, _17892.xyz).xyz, vec3(_20711 * (sqrt(_20711) + _17225)))), 0.0), PerViewLightingConstantBufferGpu_t._m8.y * sqrt(_17172)).xyz).xyz * (normalize(_16991 + vec3(0.001000000047497451305389404296875)) * clamp(length(_16991), 0.0, 1.75))).xyz * (vec3(1.0) + (normalize(_8745 + vec3(0.001000000047497451305389404296875)) * 0.5))).xyz * _20418).xyz;
	    vec4 _13888 = _20497;
	    _13888.x = _15734.x;
	    _13888.y = _15734.y;
	    _13888.z = _15734.z;
	    vec4 _6805;
	    if (_Globals_.g_bFogEnabled != 0)
	    {
	        vec3 _21493;
	        vec3 _22956 = _10061.xyz - PerViewConstantBuffer_t._m5.xyz;
	        vec3 _9057 = _22956.xyz;
	        vec3 _19340;
	        do
	        {
	            _21493 = _22956.xyz;
	            bool _12894;
	            if (dot(_21493, _21493) > PerViewConstantBufferCsgo_t._m19.x)
	            {
	                _12894 = (_10061.z * PerViewConstantBufferCsgo_t._m19.z) < PerViewConstantBufferCsgo_t._m19.y;
	            }
	            else
	            {
	                _12894 = false;
	            }
	            SPIRV_CROSS_BRANCH
	            if (_12894)
	            {
	                vec2 _9342 = saturate(PerViewConstantBufferCsgo_t._m16.xy + (PerViewConstantBufferCsgo_t._m16.zw * vec2(length(_21493), _10061.z)));
	                float _12872 = (pow(_9342.x, PerViewConstantBufferCsgo_t._m17.x) * pow(_9342.y, PerViewConstantBufferCsgo_t._m17.y)) * PerViewConstantBufferCsgo_t._m18.w;
	                _19340 = mix(_13888.xyz, vec4(PerViewConstantBufferCsgo_t._m18.xyz, _12872).xyz, vec3(_12872));
	                break;
	            }
	            _19340 = _13888.xyz;
	            break;
	        } while(false);
	        vec4 _23944 = _13888;
	        _23944.x = _19340.x;
	        _23944.y = _19340.y;
	        _23944.z = _19340.z;
	        vec3 _19341;
	        do
	        {
	            bool _12895;
	            if (dot(_9057, _9057) > PerViewConstantBufferCsgo_t._m23.x)
	            {
	                _12895 = (PerViewConstantBufferCsgo_t._m23.z * _10061.z) < PerViewConstantBufferCsgo_t._m23.y;
	            }
	            else
	            {
	                _12895 = false;
	            }
	            if (_12895)
	            {
	                float _14602 = saturate(pow(max(0.0, (length(_21493) * PerViewConstantBufferCsgo_t._m20.y) + PerViewConstantBufferCsgo_t._m20.x), PerViewConstantBufferCsgo_t._m20.w)) * saturate(pow(max(0.0, (_10061.z * PerViewConstantBufferCsgo_t._m21.y) + PerViewConstantBufferCsgo_t._m21.x), PerViewConstantBufferCsgo_t._m21.z));
	                float _8892 = saturate(_14602) * PerViewConstantBufferCsgo_t._m23.w;
	                _19341 = mix(_23944.xyz, vec4((textureLod(samplerCube(g_bindless_TextureCube_float4[PerViewConstantBufferCsgo_t._m2], g_bindless_Sampler[_Globals_.g_sTrilinearClamp]), normalize((PerViewConstantBufferCsgo_t._m22 * vec4(_9057, 0.0)).xyz).xyz, PerViewConstantBufferCsgo_t._m21.w * saturate(1.0 - (_14602 * PerViewConstantBufferCsgo_t._m20.z))) * PerViewConstantBufferCsgo_t._m24.x).xyz, _8892).xyz, vec3(_8892));
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
	
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
	
	BoolAttribute(BindlessResources, true);
	StringAttribute(MaterialLayerRefType, csgo_environment);
	BoolAttribute(GroupDefaultCollapseState_TextureTransform, true);
	BoolAttribute(GroupDefaultCollapseState_DetailTextureTransform, true);
	BoolAttribute(HasTexcoordTransform, (g_nUVSet1>0 && (g_vTexCoordScale1.x!=1 || g_vTexCoordScale1.y!=1 || g_flTexCoordRotation1!=0)) ? 1 : 0);
	BoolAttribute(environmentmapped, true);
	BoolAttribute(environmentmappeddynamic, true);
	BoolAttribute(NeedsLightProbe, true);
	BoolAttribute(DoNotCastShadows, F_DO_NOT_CAST_SHADOWS ? 1 : 0);
	BoolAttribute(SupportsMappingDimensions, true);
	BoolAttribute(renderbackfaces, F_RENDER_BACKFACES ? 1 : 0);
	BoolAttribute(SupportsLightmapping, true);
	BoolAttribute(PerVertexLighting, true);
	BoolAttribute(AllowBackfaceCulling, F_RENDER_BACKFACES ? 0 : 1);
	TextureAttribute(LightSim_DiffuseAlbedoTexture, g_tColor1);
	TextureAttribute(RepresentativeTexture, g_tColor1);
	FloatAttribute(OcclusionCullingBoundsScale, F_OCCLUSION_CULLING_BOUNDS_SCALE ? g_flOcclusionCullingBoundsScale : 1);
	
	#if (S_MATERIAL_REFERENCE == 0)
		BoolAttribute(alphatest, true);
		FloatAttribute(_dummyReferenceAlphaTestReferenceInMainShader, g_flAlphaTestReference);
		FloatAttribute(_dummyReferenceAntiAliasedEdgeStrengthReferenceInMainShader, g_flAntiAliasedEdgeStrength);
		BoolAttribute(NoZPrepass, true);
		BoolAttribute(AlphaTestZPrepass, true);
		TextureAttribute(LightSim_Opacity_A, g_tColor1);
	#endif
	#if (S_ALPHA_TEST_LAYER == 1)
		BoolAttribute(alphatest, true);
		FloatAttribute(_dummyReferenceAlphaTestReferenceInMainShader, g_flAlphaTestReference);
		FloatAttribute(_dummyReferenceAntiAliasedEdgeStrengthReferenceInMainShader, g_flAntiAliasedEdgeStrength);
		BoolAttribute(NoZPrepass, true);
		BoolAttribute(AlphaTestZPrepass, true);
		TextureAttribute(LightSim_Opacity_A, g_tColor1);
	#endif
	#if (S_ALPHA_TEST_LAYER == 0)
		IntAttribute(DepthPassBatchID, F_RENDER_BACKFACES ? 0 : 1);
		BoolAttribute(NoZPrepass, F_DISABLE_Z_PREPASS ? 1 : 0);
	#endif
	#if (S_MATERIAL_REFERENCE == 1)
		IntAttribute(MaterialLayerCount, 1);
		StringAttribute(MaterialLayerType, csgo_environment);
	#endif
	
	// PSRS
	
	RenderState(BackStencilFunc, F_RENDER_BACKFACES ? NotEqual : Always);
	RenderState(CullMode, F_RENDER_BACKFACES ? None : Front);
	RenderState(CullMode, F_RENDER_BACKFACES ? None : Back);
	RenderState(DepthEnable, F_DISABLE_Z_BUFFERING ? false : true);
	RenderState(DepthFunc, Equal);
	RenderState(SlopeScaleDepthBias, 0);
	RenderState(StencilEnable, true);
	RenderState(StencilFunc, NotEqual);
	RenderState(StencilReadMask, 1);
	RenderState(StencilRef, 3);
	RenderState(StencilWriteMask, 254);
	
	
	// Variant parameters
	RenderState(CullMode, F_RENDER_BACKFACES ? None : Front);
	RenderState(CullMode, F_RENDER_BACKFACES ? None : Back);
	
	BoolAttribute(BindlessResources, true);
	StringAttribute(MaterialLayerRefType, csgo_environment);
	
	#if (S_MATERIAL_REFERENCE == 1)
		IntAttribute(MaterialLayerCount, 1);
		StringAttribute(MaterialLayerType, csgo_environment);
	#endif
}

RTX
{
	StaticCombo( S_DETAIL_NORMAL, F_DETAIL_NORMAL );
	StaticCombo( S_MATERIAL_REFERENCE, F_MATERIAL_REFERENCE );
	StaticCombo( S_MODE_TOOLS_VIS, 0..1 );
	StaticCombo( S_ALPHA_TEST_LAYER, F_ALPHA_TEST );
	StaticCombo( S_MODE_DEPTH, 0..1 );
	StaticCombo( S_SHADER_QUALITY, 0..1 );
	StaticComboRule( Allow1( S_MODE_TOOLS_VIS, S_MODE_DEPTH ) );
	StaticComboRule( Requires( S_MODE_TOOLS_VIS, S_SHADER_QUALITY ) );
	StaticComboRule( Allow0( S_MODE_DEPTH ) );
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
	
	bool g_bAdjustBaseColor1 < UiType(CheckBox); Expression(g_nColorCorrectionMode1==1); >;
	bool g_bDontFlipBackfaceNormals < UiType(CheckBox); Expression(F_DONT_FLIP_BACKFACE_NORMALS ? 1 : 0); >;
	bool g_bRenderBackfaceNormals < UiType(CheckBox); Expression((F_RENDER_BACKFACES ? 1 : 0) ? 1 : 0); >;
	float g_flReflectance < UiType(Slider); Expression(pow((1.5-1)/(1.5+1),2)); >;
	float4x4 g_mTextureAdjust1 < Expression(MatrixMultiply(MatrixColorTint2(float3(1,1,1),1),MatrixColorCorrect2(float3(g_fTextureColorContrast1,g_fTextureColorSaturation1,g_fTextureColorBrightness1),TextureAverageColor(g_tColor1)))); >;
	float4x4 g_mTextureColorAdjust1 < Expression(MatrixMultiply(MatrixColorTint2(g_vTextureColorTint1,1),MatrixColorCorrect2(float3(g_fTextureColorContrast1,g_fTextureColorSaturation1,g_fTextureColorBrightness1),TextureAverageColor(g_tColor1)))); >;
	float4x4 g_mTextureColorAdjust1 < Expression(MatrixMultiply(MatrixColorTint2(float3(1,1,1),1),MatrixColorCorrect2(float3(1,1,1),TextureAverageColor(g_tColor1)))); >;
	Texture2D g_tColor1 < Channel(RGB, ArtistDefined(TextureColor1), Srgb); Channel(A, Box(TextureAmbientOcclusion1), Linear); OutputFormat(BC7); SrgbRead(true); >;
	Texture2D g_tColor1 < Channel(RGB, ArtistDefinedOrAlphaWeighted(TextureColor1, TextureTranslucency1), Srgb); Channel(A, PreserveCoverage(TextureTranslucency1), Linear); OutputFormat(BC7); SrgbRead(true); >;
	Texture2D g_tHeight1 < Channel(R, ArtistDefined(TextureHeight1), Linear); Channel(G, ArtistDefined(TextureTintMask1), Linear); Channel(A, Box(TextureMetalness1), Linear); OutputFormat(BC7); SrgbRead(false); >;
	Texture2D g_tHeight1 < Channel(R, ArtistDefined(TextureHeight1), Linear); Channel(G, ArtistDefined(TextureTintMask1), Linear); Channel(B, Box(TextureAmbientOcclusion1), Linear); Channel(A, Box(TextureMetalness1), Linear); OutputFormat(BC7); SrgbRead(false); >;
	Texture2D g_tNormal1 < Channel(RGBA, HemiOctIsoRoughness_RG_B(TextureNormal1, TextureRoughness1), Linear); OutputFormat(BC7); SrgbRead(false); >;
	Texture2D g_tNormalDetail1 < Channel(RG, HemiOctIsoRoughness_RG_B(TextureNormalDetail1), Linear); OutputFormat(ATI2N); SrgbRead(false); >;
	float3 g_vBiplanarTexCoordScale < UiType(VectorText); Expression(1/64*float3(-1,1,-1)); >;
	float4 g_vDetailNormalXform_1 < UiType(VectorText); Expression(v0 = g_flDetailTexCoordRotation1*3.1415927/180;
		v1 = cos(v0);
		v2 = sin(v0);
		float4(v1,-v2,v2,v1)); >;
	float4 g_vDetailTexCoordXform0_1 < UiType(VectorText); Expression(v0 = g_flDetailTexCoordRotation1*3.1415927/180;
		v1 = cos(v0);
		v2 = sin(v0);
		float4(v1*g_vDetailTexCoordScale1.x,-v2*g_vDetailTexCoordScale1.y,0,g_vDetailTexCoordCenter1.x+g_vDetailTexCoordOffset1.x+v2*g_vDetailTexCoordCenter1.y-v1*g_vDetailTexCoordCenter1.x)); >;
	float4 g_vDetailTexCoordXform1_1 < UiType(VectorText); Expression(v0 = g_flDetailTexCoordRotation1*3.1415927/180;
		v1 = cos(v0);
		v2 = sin(v0);
		float4(v2*g_vDetailTexCoordScale1.x,v1*g_vDetailTexCoordScale1.y,0,g_vDetailTexCoordCenter1.y+g_vDetailTexCoordOffset1.y-(v2*g_vDetailTexCoordCenter1.x+v1*g_vDetailTexCoordCenter1.y))); >;
	float4 g_vNormalXform_1 < UiType(VectorText); Expression(v0 = g_flTexCoordRotation1*3.1415927/180;
		v1 = cos(v0);
		v2 = sin(v0);
		float4(v1,-v2,v2,v1)); >;
	float4 g_vTexCoordXform0_1 < UiType(VectorText); Expression(v0 = g_flTexCoordRotation1*3.1415927/180;
		v1 = cos(v0);
		v2 = sin(v0);
		float4(v1*g_vTexCoordScale1.x,-v2*g_vTexCoordScale1.y,0,g_vTexCoordCenter1.x+g_vTexCoordOffset1.x+v2*g_vTexCoordCenter1.y-v1*g_vTexCoordCenter1.x)); >;
	float4 g_vTexCoordXform1_1 < UiType(VectorText); Expression(v0 = g_flTexCoordRotation1*3.1415927/180;
		v1 = cos(v0);
		v2 = sin(v0);
		float4(v2*g_vTexCoordScale1.x,v1*g_vTexCoordScale1.y,0,g_vTexCoordCenter1.y+g_vTexCoordOffset1.y-(v2*g_vTexCoordCenter1.x+v1*g_vTexCoordCenter1.y))); >;
	
	// Material1
	CreateInputTexture2D(TextureColor1, Srgb, 8, "", "_color", "Material1,0/Color,10/0", Default4(1, 1, 1, 0));
	CreateInputTexture2D(TextureNormal1, Linear, 8, "NormalizeNormals", "_normal", "Material1/Lighting/0", Default4(0.5, 0.5, 1, 0));
	CreateInputTexture2D(TextureTintMask1, Linear, 8, "", "_mask", "Material1/Tint Mask,15/0", Default4(1, 1, 1, 0));
	CreateInputTexture2D(TextureTranslucency1, Linear, 8, "", "_trans", "Material1/Translucent,15/0", Default4(1, 1, 1, 0));
	int g_nUVSet1 < Default(1); Range4(0, 0, 0, 0, 2, 2, 2, 2); UiOptions("0=Biplanar,1=UV1,2=UV2"); UiType(Enum); UiGroup("Material1/Texture Coordinates,34/1"); >;
	float2 g_vTexCoordCenter1 < Default2(0.5, 0.5); Attribute("0=X,1=Y"); UiType(VectorText); UiGroup("Material1/Texture Transform,35/1"); UiVisibility(1); >;
	int g_nDetailUVSet1 < Default(-1); Range4(-1, -1, -1, -1, 2, 2, 2, 2); UiOptions("-1=Inherit,0=Biplanar,1=UV1,2=UV2"); UiType(Enum); UiGroup("Material1/Texture Coordinates,34/2"); >;
	float2 g_vTexCoordScale1 < Default2(1, 1); Range2(0, 0, 100, 100); Attribute("0=X,1=Y"); UiType(VectorText); UiGroup("Material1/Texture Transform,35/2"); >;
	float2 g_vTexCoordOffset1 < Range2(-1, -1, 1, 1); Attribute("0=X,1=Y"); UiType(VectorText); UiGroup("Material1/Texture Transform,35/4"); UiVisibility(1); >;
	float g_fTintMaskBrightness1 < Default(1); Range(0, 4); UiType(Slider); UiGroup("Material1/Tint Mask/5"); >;
	float2 g_vDetailTexCoordCenter1 < Default2(0.5, 0.5); Attribute("0=X,1=Y"); UiType(VectorText); UiGroup("Material1/Detail Texture Transform/5"); UiVisibility(1); >;
	float2 g_vDetailTexCoordScale1 < Default2(1, 1); Range2(0, 0, 100, 100); Attribute("0=X,1=Y"); UiType(VectorText); UiGroup("Material1/Detail Texture Transform/6"); >;
	float g_flDetailTexCoordRotation1 < Range(-360, 360); UiType(Slider); UiGroup("Material1/Detail Texture Transform/8"); UiVisibility(1); >;
	float2 g_vDetailTexCoordOffset1 < Range2(-1, -1, 1, 1); Attribute("0=X,1=Y"); UiType(VectorText); UiGroup("Material1/Detail Texture Transform/9"); UiVisibility(1); >;
	CreateInputTexture2D(TextureHeight1, Linear, 8, "", "_height", "Material1/Height,30/10", Default4(0.5, 0.5, 0.5, 0));
	CreateInputTexture2D(TextureRoughness1, Linear, 8, "Inverse", "_rough", "Material1/Lighting/10", Default4(0.5, 0.5, 0.5, 0));
	float g_fTintMaskContrast1 < Default(1); Range(-2, 4); UiType(Slider); UiGroup("Material1/Tint Mask/10"); >;
	float3 g_vTextureColorTint1 < Default3(1, 1, 1); UiType(Color); UiGroup("Material1/Color Correction,17/10"); >;
	float g_fTextureRoughnessContrast1 < Default(1); Range(0, 4); UiType(Slider); UiGroup("Material1/Lighting/11"); >;
	float g_fTextureRoughnessBrightness1 < Default(1); Range(0, 4); UiType(Slider); UiGroup("Material1/Lighting/12"); >;
	float g_fTextureNormalContrast1 < Default(1); Range(-2, 2); UiType(Slider); UiGroup("Material1/Lighting/13"); >;
	float g_flTexCoordRotation1 < Range(-360, 360); UiType(Slider); UiGroup("Material1/Texture Transform,35/13"); UiVisibility(1); >;
	bool g_bMetalness1 < Default(1); UiType(CheckBox); UiGroup("Material1/Lighting/14"); >;
	CreateInputTexture2D(TextureAmbientOcclusion1, Linear, 8, "", "_ao", "Material1/Lighting,20/20", Default4(1, 1, 1, 0));
	float g_fTextureColorContrast1 < Default(1); Range(0, 4); UiType(Slider); UiGroup("Material1/Color Correction/20"); >;
	CreateInputTexture2D(TextureMetalness1, Linear, 8, "", "_metal", "Material1/Lighting/30", Default4(0, 0, 0, 0));
	float g_fTextureColorSaturation1 < Default(1); Range(0, 4); UiType(Slider); UiGroup("Material1/Color Correction/30"); >;
	CreateInputTexture2D(TextureNormalDetail1, Linear, 8, "NormalizeNormals", "_normal", "Material1/Detail/35", Default4(0.5, 0.5, 1, 0));
	float g_fTextureColorBrightness1 < Default(1); Range(-8, 8); UiType(Slider); UiGroup("Material1/Color Correction/40"); >;
	float g_fDetailTextureNormalContrast1 < Default(1); Range(-2, 2); UiType(Slider); UiGroup("Material1/Detail/45"); >;
	int g_nColorCorrectionMode1 < UiOptions("0=Mask All,1=Mask only Tint"); UiType(Enum); UiGroup("Material1/Color Correction/45"); >;
	bool g_bModelTint1 < Default(1); UiType(CheckBox); UiGroup("Material1/Color Correction/60"); >;
	
	// Translucent
	float g_flAlphaTestReference < Default(0.5); Range(0.01, 0.99); UiType(Slider); UiGroup("Translucent"); >;
	float g_flAntiAliasedEdgeStrength < Default(1); UiType(Slider); UiGroup("Translucent"); >;
	
	// Color
	float3 g_vColorTint < Default3(1, 1, 1); UiType(Color); UiGroup("Color,10/20"); Expression(SrgbGammaToLinear(this)); >;
	float g_flModelTintAmount < Default(1); UiType(Slider); UiGroup("Color,10/30"); >;
	int g_nScaleTexCoordUByModelScaleAxis < Range4(0, 0, 0, 0, 3, 3, 3, 3); UiOptions("0=None,1=UV.u * model.x,2=UV.u * model.y,3=UV.u * model.z"); UiType(Enum); UiGroup("Color/80"); >;
	int g_nScaleTexCoordVByModelScaleAxis < Range4(0, 0, 0, 0, 3, 3, 3, 3); UiOptions("0=None,1=UV.v * model.x,2=UV.v * model.y,3=UV.v * model.z"); UiType(Enum); UiGroup("Color/90"); >;
	
	// Texture Address Mode
	int g_nTextureAddressModeU < UiOption("RsTextureAddressMode_t"); UiType(Enum); UiGroup("Texture Address Mode"); >;
	int g_nTextureAddressModeV < UiOption("RsTextureAddressMode_t"); UiType(Enum); UiGroup("Texture Address Mode"); >;
	
	#if (S_MATERIAL_REFERENCE == 1)
		float4x4 g_mTextureColorAdjust1 < Expression(MatrixMultiply(MatrixColorTint2(g_vTextureColorTint1,1),MatrixColorCorrect2(float3(g_fTextureColorContrast1,g_fTextureColorSaturation1,g_fTextureColorBrightness1),TextureAverageColor(g_tColor1)))); >;
	#endif
	#if (S_ALPHA_TEST_LAYER == 1)
		Texture2D g_tHeight1 < Channel(R, ArtistDefined(TextureHeight1), Linear); Channel(G, ArtistDefined(TextureTintMask1), Linear); Channel(B, Box(TextureAmbientOcclusion1), Linear); Channel(A, Box(TextureMetalness1), Linear); OutputFormat(BC7); SrgbRead(false); >;
		Texture2D g_tColor1 < Channel(RGB, ArtistDefinedOrAlphaWeighted(TextureColor1, TextureTranslucency1), Srgb); Channel(A, PreserveCoverage(TextureTranslucency1), Linear); OutputFormat(BC7); SrgbRead(true); >;
	#endif
	
	// Variant parameters
	float4x4 g_mTextureColorAdjust1 < Expression(MatrixMultiply(MatrixColorTint2(float3(1,1,1),1),MatrixColorCorrect2(float3(1,1,1),TextureAverageColor(g_tColor1)))); >;
	Texture2D g_tColor1 < Channel(RGB, ArtistDefined(TextureColor1), Srgb); Channel(A, Box(TextureAmbientOcclusion1), Linear); OutputFormat(BC7); SrgbRead(true); >;
	Texture2D g_tHeight1 < Channel(R, ArtistDefined(TextureHeight1), Linear); Channel(G, ArtistDefined(TextureTintMask1), Linear); Channel(A, Box(TextureMetalness1), Linear); OutputFormat(BC7); SrgbRead(false); >;
	
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
	#if defined(GL_EXT_control_flow_attributes)
	#extension GL_EXT_control_flow_attributes : require
	#define SPIRV_CROSS_FLATTEN [[flatten]]
	#define SPIRV_CROSS_BRANCH [[dont_flatten]]
	#define SPIRV_CROSS_UNROLL [[unroll]]
	#define SPIRV_CROSS_LOOP [[dont_unroll]]
	#else
	#define SPIRV_CROSS_FLATTEN
	#define SPIRV_CROSS_BRANCH
	#define SPIRV_CROSS_UNROLL
	#define SPIRV_CROSS_LOOP
	#endif
	
	struct VS_INPUT
	{
	    vec3 vPositionOs;
	    vec2 vTexCoord;
	    vec2 vTexCoord2;
	    vec3 vNormalOs;
	    vec4 vTangentUOs_flTangentVSign;
	    uvec4 vBlendIndices;
	    uint nInstanceIdx;
	    vec4 vBlendColorTint;
	    vec4 vColorBlendValues;
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
	
	struct _RTX_MATERIAL_DATA_
	{
	    vec2 g_vDetailTexCoordScale;
	    float g_flDetailTexCoordRotation;
	    float _g_fl_AutoPad0_;
	    vec2 g_vDetailTexCoordOffset;
	    float _g_fl_AutoPad1_;
	    float _g_fl_AutoPad2_;
	    vec4 g_vDetailTexCoordXform;
	    float g_flDetailNormalStrength;
	    float _g_fl_AutoPad3_;
	    float _g_fl_AutoPad4_;
	    float _g_fl_AutoPad5_;
	    vec4 g_vDetailNormalStrengthOffsetScale;
	    vec2 g_vTexCoordCenter;
	    vec2 g_vTexCoordScale;
	    float g_flTexCoordRotation;
	    float _g_fl_AutoPad6_;
	    vec2 g_vTexCoordOffset;
	    vec4 g_vTexCoordXform0;
	    vec4 g_vTexCoordXform1;
	    vec2 g_vTexCoordScrollSpeed;
	    int g_nScaleTexCoordUByModelScaleAxis;
	    int g_nScaleTexCoordVByModelScaleAxis;
	    bool g_bTexCoordScaleByModel;
	    float _g_fl_AutoPad7_;
	    float _g_fl_AutoPad8_;
	    float _g_fl_AutoPad9_;
	    vec4 g_vTexCoordScaleByModelU;
	    vec4 g_vTexCoordScaleByModelV;
	    vec3 g_vColorTint;
	    float g_flModelTintAmount;
	    bool g_bUseSecondaryUvForDetailTexture;
	    float _g_fl_AutoPad10_;
	    float _g_fl_AutoPad11_;
	    float _g_fl_AutoPad12_;
	    vec3 g_vBiplanarTexCoordScale;
	    float g_flDetailPropMaskBias1;
	    float g_flDetailPropPuddleReduction1;
	    bool g_bSnowLayer1;
	    int g_nUVSet1;
	    float _g_fl_AutoPad13_;
	    vec2 g_vTexCoordScale1;
	    vec2 g_vTexCoordCenter1;
	    float g_flTexCoordRotation1;
	    float _g_fl_AutoPad14_;
	    vec2 g_vTexCoordOffset1;
	    vec4 g_vTexCoordXform0_1;
	    vec4 g_vTexCoordXform1_1;
	    vec4 g_vNormalXform_1;
	    float g_flWetnessDarkeningStrength1;
	    int g_nDetailUVSet1;
	    vec2 g_vDetailTexCoordScale1;
	    vec2 g_vDetailTexCoordCenter1;
	    float g_flDetailTexCoordRotation1;
	    float _g_fl_AutoPad15_;
	    vec2 g_vDetailTexCoordOffset1;
	    float _g_fl_AutoPad16_;
	    float _g_fl_AutoPad17_;
	    vec4 g_vDetailTexCoordXform0_1;
	    vec4 g_vDetailTexCoordXform1_1;
	    vec4 g_vDetailNormalXform_1;
	    uint g_tNormal1;
	    uint g_tHeight1;
	    uint g_tNormalDetail1;
	    float g_fDetailTextureNormalContrast1;
	    mat4 g_mTextureColorAdjust1;
	    mat4 g_mTextureAdjust1;
	    float g_flBlendSoftnessDistanceModifierStrength;
	    bool g_bPuddlesOnVerticalSurfaces;
	    bool g_bWetnessUseHeightmapAdjustments;
	    float g_flWetnessUnderlyingHeightMapInfluence;
	    float g_flHorizontalSurfaceTolerance;
	    float g_fPuddleStrength;
	    float g_fPuddleHeight;
	    float _g_fl_AutoPad18_;
	    vec3 g_vPuddleSedimentColor;
	    float g_fPuddleSedimentHeight;
	    float g_fPuddleSedimentOpacity;
	    float g_fPuddleRoughness;
	    float g_fPuddleBlendSoftness;
	    float g_fWetEdgeStrength;
	    float g_fWetEdgeSpread;
	    float g_fWetEdgeSoftness;
	    float g_fWetnessStrength;
	    float g_fRainStrength;
	    float g_fRippleStrength;
	    uint g_sAniso;
	    uint g_sBilinearClamp;
	    uint g_sTrilinearWrap;
	    uint g_sTrilinearClamp;
	    uint g_sPointClamp;
	    int g_nTextureAddressModeU;
	    int g_nTextureAddressModeV;
	    uint g_sUserConfig;
	    uint g_sUserConfigAllowGlobalMipBias;
	    uint g_tColor1;
	    bool g_bFogEnabled;
	    bool g_bDontFlipBackfaceNormals;
	    bool g_bRenderBackfaceNormals;
	    float g_flReflectance;
	    uint g_tAmbientOcclusion;
	    float g_flMetalness;
	    float g_flRetroReflectivity;
	    bool g_bWetness;
	    float _g_fl_AutoPad19_;
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
	
	const vec3 _727[3] = vec3[](vec3(-1.0, 0.0, 0.0), vec3(0.0, 1.0, 0.0), vec3(-1.0, 0.0, 0.0));
	const vec3 _731[3] = vec3[](vec3(0.0, 0.0, 1.0), vec3(0.0, -1.0, 0.0), vec3(0.0, 0.0, 1.0));
	
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
	
	vec4 _788;
	float _789;
	
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
	    int _member0[];
	} g_MaterialData_3;
	
	layout(set = 3, binding = 34, std430) readonly buffer g_MaterialData_4
	{
	    int _member0[];
	} g_MaterialData_5;
	
	layout(set = 3, binding = 34, std430) readonly buffer g_MaterialData_6
	{
	    uint _member0[];
	} g_MaterialData_7;
	
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
	
	hitAttributeEXT BuiltInTriangleIntersectionAttributes attrs;
	layout(set = 4, binding = 46) uniform texture2D g_bindless_Texture2D_float4[65536];
	layout(set = 4, binding = 29) uniform sampler g_bindless_Sampler[2048];
	layout(location = 0) rayPayloadInEXT Payload_t payload;
	
	void main()
	{
	    uint _828 = g_instanceBuffer._member0[uint(gl_InstanceID)].nMaterialData;
	    _RTX_MATERIAL_DATA_ _1873 = _RTX_MATERIAL_DATA_(vec2(g_MaterialData_1._member0[_828 / 4u], g_MaterialData_1._member0[(_828 + 4u) / 4u]), g_MaterialData_1._member0[(_828 + 8u) / 4u], g_MaterialData_1._member0[(_828 + 12u) / 4u], vec2(g_MaterialData_1._member0[(_828 + 16u) / 4u], g_MaterialData_1._member0[(_828 + 20u) / 4u]), g_MaterialData_1._member0[(_828 + 24u) / 4u], g_MaterialData_1._member0[(_828 + 28u) / 4u], vec4(g_MaterialData_1._member0[(_828 + 32u) / 4u], g_MaterialData_1._member0[(_828 + 36u) / 4u], g_MaterialData_1._member0[(_828 + 40u) / 4u], g_MaterialData_1._member0[(_828 + 44u) / 4u]), g_MaterialData_1._member0[(_828 + 48u) / 4u], g_MaterialData_1._member0[(_828 + 52u) / 4u], g_MaterialData_1._member0[(_828 + 56u) / 4u], g_MaterialData_1._member0[(_828 + 60u) / 4u], vec4(g_MaterialData_1._member0[(_828 + 64u) / 4u], g_MaterialData_1._member0[(_828 + 68u) / 4u], g_MaterialData_1._member0[(_828 + 72u) / 4u], g_MaterialData_1._member0[(_828 + 76u) / 4u]), vec2(g_MaterialData_1._member0[(_828 + 80u) / 4u], g_MaterialData_1._member0[(_828 + 84u) / 4u]), vec2(g_MaterialData_1._member0[(_828 + 88u) / 4u], g_MaterialData_1._member0[(_828 + 92u) / 4u]), g_MaterialData_1._member0[(_828 + 96u) / 4u], g_MaterialData_1._member0[(_828 + 100u) / 4u], vec2(g_MaterialData_1._member0[(_828 + 104u) / 4u], g_MaterialData_1._member0[(_828 + 108u) / 4u]), vec4(g_MaterialData_1._member0[(_828 + 112u) / 4u], g_MaterialData_1._member0[(_828 + 116u) / 4u], g_MaterialData_1._member0[(_828 + 120u) / 4u], g_MaterialData_1._member0[(_828 + 124u) / 4u]), vec4(g_MaterialData_1._member0[(_828 + 128u) / 4u], g_MaterialData_1._member0[(_828 + 132u) / 4u], g_MaterialData_1._member0[(_828 + 136u) / 4u], g_MaterialData_1._member0[(_828 + 140u) / 4u]), vec2(g_MaterialData_1._member0[(_828 + 144u) / 4u], g_MaterialData_1._member0[(_828 + 148u) / 4u]), g_MaterialData_3._member0[(_828 + 152u) / 4u], g_MaterialData_3._member0[(_828 + 156u) / 4u], g_MaterialData_5._member0[(_828 + 160u) / 4u] != 0, g_MaterialData_1._member0[(_828 + 164u) / 4u], g_MaterialData_1._member0[(_828 + 168u) / 4u], g_MaterialData_1._member0[(_828 + 172u) / 4u], vec4(g_MaterialData_1._member0[(_828 + 176u) / 4u], g_MaterialData_1._member0[(_828 + 180u) / 4u], g_MaterialData_1._member0[(_828 + 184u) / 4u], g_MaterialData_1._member0[(_828 + 188u) / 4u]), vec4(g_MaterialData_1._member0[(_828 + 192u) / 4u], g_MaterialData_1._member0[(_828 + 196u) / 4u], g_MaterialData_1._member0[(_828 + 200u) / 4u], g_MaterialData_1._member0[(_828 + 204u) / 4u]), vec3(g_MaterialData_1._member0[(_828 + 208u) / 4u], g_MaterialData_1._member0[(_828 + 212u) / 4u], g_MaterialData_1._member0[(_828 + 216u) / 4u]), g_MaterialData_1._member0[(_828 + 220u) / 4u], g_MaterialData_5._member0[(_828 + 224u) / 4u] != 0, g_MaterialData_1._member0[(_828 + 228u) / 4u], g_MaterialData_1._member0[(_828 + 232u) / 4u], g_MaterialData_1._member0[(_828 + 236u) / 4u], vec3(g_MaterialData_1._member0[(_828 + 240u) / 4u], g_MaterialData_1._member0[(_828 + 244u) / 4u], g_MaterialData_1._member0[(_828 + 248u) / 4u]), g_MaterialData_1._member0[(_828 + 252u) / 4u], g_MaterialData_1._member0[(_828 + 256u) / 4u], g_MaterialData_5._member0[(_828 + 260u) / 4u] != 0, g_MaterialData_3._member0[(_828 + 264u) / 4u], g_MaterialData_1._member0[(_828 + 268u) / 4u], vec2(g_MaterialData_1._member0[(_828 + 272u) / 4u], g_MaterialData_1._member0[(_828 + 276u) / 4u]), vec2(g_MaterialData_1._member0[(_828 + 280u) / 4u], g_MaterialData_1._member0[(_828 + 284u) / 4u]), g_MaterialData_1._member0[(_828 + 288u) / 4u], g_MaterialData_1._member0[(_828 + 292u) / 4u], vec2(g_MaterialData_1._member0[(_828 + 296u) / 4u], g_MaterialData_1._member0[(_828 + 300u) / 4u]), vec4(g_MaterialData_1._member0[(_828 + 304u) / 4u], g_MaterialData_1._member0[(_828 + 308u) / 4u], g_MaterialData_1._member0[(_828 + 312u) / 4u], g_MaterialData_1._member0[(_828 + 316u) / 4u]), vec4(g_MaterialData_1._member0[(_828 + 320u) / 4u], g_MaterialData_1._member0[(_828 + 324u) / 4u], g_MaterialData_1._member0[(_828 + 328u) / 4u], g_MaterialData_1._member0[(_828 + 332u) / 4u]), vec4(g_MaterialData_1._member0[(_828 + 336u) / 4u], g_MaterialData_1._member0[(_828 + 340u) / 4u], g_MaterialData_1._member0[(_828 + 344u) / 4u], g_MaterialData_1._member0[(_828 + 348u) / 4u]), g_MaterialData_1._member0[(_828 + 352u) / 4u], g_MaterialData_3._member0[(_828 + 356u) / 4u], vec2(g_MaterialData_1._member0[(_828 + 360u) / 4u], g_MaterialData_1._member0[(_828 + 364u) / 4u]), vec2(g_MaterialData_1._member0[(_828 + 368u) / 4u], g_MaterialData_1._member0[(_828 + 372u) / 4u]), g_MaterialData_1._member0[(_828 + 376u) / 4u], g_MaterialData_1._member0[(_828 + 380u) / 4u], vec2(g_MaterialData_1._member0[(_828 + 384u) / 4u], g_MaterialData_1._member0[(_828 + 388u) / 4u]), g_MaterialData_1._member0[(_828 + 392u) / 4u], g_MaterialData_1._member0[(_828 + 396u) / 4u], vec4(g_MaterialData_1._member0[(_828 + 400u) / 4u], g_MaterialData_1._member0[(_828 + 404u) / 4u], g_MaterialData_1._member0[(_828 + 408u) / 4u], g_MaterialData_1._member0[(_828 + 412u) / 4u]), vec4(g_MaterialData_1._member0[(_828 + 416u) / 4u], g_MaterialData_1._member0[(_828 + 420u) / 4u], g_MaterialData_1._member0[(_828 + 424u) / 4u], g_MaterialData_1._member0[(_828 + 428u) / 4u]), vec4(g_MaterialData_1._member0[(_828 + 432u) / 4u], g_MaterialData_1._member0[(_828 + 436u) / 4u], g_MaterialData_1._member0[(_828 + 440u) / 4u], g_MaterialData_1._member0[(_828 + 444u) / 4u]), g_MaterialData_7._member0[(_828 + 448u) / 4u], g_MaterialData_7._member0[(_828 + 452u) / 4u], g_MaterialData_7._member0[(_828 + 456u) / 4u], g_MaterialData_1._member0[(_828 + 460u) / 4u], mat4(vec4(g_MaterialData_1._member0[(_828 + 464u) / 4u], g_MaterialData_1._member0[(_828 + 480u) / 4u], g_MaterialData_1._member0[(_828 + 496u) / 4u], g_MaterialData_1._member0[(_828 + 512u) / 4u]), vec4(g_MaterialData_1._member0[(_828 + 468u) / 4u], g_MaterialData_1._member0[(_828 + 484u) / 4u], g_MaterialData_1._member0[(_828 + 500u) / 4u], g_MaterialData_1._member0[(_828 + 516u) / 4u]), vec4(g_MaterialData_1._member0[(_828 + 472u) / 4u], g_MaterialData_1._member0[(_828 + 488u) / 4u], g_MaterialData_1._member0[(_828 + 504u) / 4u], g_MaterialData_1._member0[(_828 + 520u) / 4u]), vec4(g_MaterialData_1._member0[(_828 + 476u) / 4u], g_MaterialData_1._member0[(_828 + 492u) / 4u], g_MaterialData_1._member0[(_828 + 508u) / 4u], g_MaterialData_1._member0[(_828 + 524u) / 4u])), mat4(vec4(g_MaterialData_1._member0[(_828 + 528u) / 4u], g_MaterialData_1._member0[(_828 + 544u) / 4u], g_MaterialData_1._member0[(_828 + 560u) / 4u], g_MaterialData_1._member0[(_828 + 576u) / 4u]), vec4(g_MaterialData_1._member0[(_828 + 532u) / 4u], g_MaterialData_1._member0[(_828 + 548u) / 4u], g_MaterialData_1._member0[(_828 + 564u) / 4u], g_MaterialData_1._member0[(_828 + 580u) / 4u]), vec4(g_MaterialData_1._member0[(_828 + 536u) / 4u], g_MaterialData_1._member0[(_828 + 552u) / 4u], g_MaterialData_1._member0[(_828 + 568u) / 4u], g_MaterialData_1._member0[(_828 + 584u) / 4u]), vec4(g_MaterialData_1._member0[(_828 + 540u) / 4u], g_MaterialData_1._member0[(_828 + 556u) / 4u], g_MaterialData_1._member0[(_828 + 572u) / 4u], g_MaterialData_1._member0[(_828 + 588u) / 4u])), g_MaterialData_1._member0[(_828 + 592u) / 4u], g_MaterialData_5._member0[(_828 + 596u) / 4u] != 0, g_MaterialData_5._member0[(_828 + 600u) / 4u] != 0, g_MaterialData_1._member0[(_828 + 604u) / 4u], g_MaterialData_1._member0[(_828 + 608u) / 4u], g_MaterialData_1._member0[(_828 + 612u) / 4u], g_MaterialData_1._member0[(_828 + 616u) / 4u], g_MaterialData_1._member0[(_828 + 620u) / 4u], vec3(g_MaterialData_1._member0[(_828 + 624u) / 4u], g_MaterialData_1._member0[(_828 + 628u) / 4u], g_MaterialData_1._member0[(_828 + 632u) / 4u]), g_MaterialData_1._member0[(_828 + 636u) / 4u], g_MaterialData_1._member0[(_828 + 640u) / 4u], g_MaterialData_1._member0[(_828 + 644u) / 4u], g_MaterialData_1._member0[(_828 + 648u) / 4u], g_MaterialData_1._member0[(_828 + 652u) / 4u], g_MaterialData_1._member0[(_828 + 656u) / 4u], g_MaterialData_1._member0[(_828 + 660u) / 4u], g_MaterialData_1._member0[(_828 + 664u) / 4u], g_MaterialData_1._member0[(_828 + 668u) / 4u], g_MaterialData_1._member0[(_828 + 672u) / 4u], g_MaterialData_7._member0[(_828 + 676u) / 4u], g_MaterialData_7._member0[(_828 + 680u) / 4u], g_MaterialData_7._member0[(_828 + 684u) / 4u], g_MaterialData_7._member0[(_828 + 688u) / 4u], g_MaterialData_7._member0[(_828 + 692u) / 4u], g_MaterialData_3._member0[(_828 + 696u) / 4u], g_MaterialData_3._member0[(_828 + 700u) / 4u], g_MaterialData_7._member0[(_828 + 704u) / 4u], g_MaterialData_7._member0[(_828 + 708u) / 4u], g_MaterialData_7._member0[(_828 + 712u) / 4u], g_MaterialData_5._member0[(_828 + 716u) / 4u] != 0, g_MaterialData_5._member0[(_828 + 720u) / 4u] != 0, g_MaterialData_5._member0[(_828 + 724u) / 4u] != 0, g_MaterialData_1._member0[(_828 + 728u) / 4u], g_MaterialData_7._member0[(_828 + 732u) / 4u], g_MaterialData_1._member0[(_828 + 736u) / 4u], g_MaterialData_1._member0[(_828 + 740u) / 4u], g_MaterialData_5._member0[(_828 + 744u) / 4u] != 0, g_MaterialData_1._member0[(_828 + 748u) / 4u]);
	    _RTX_MATERIAL_DATA_ _g_rtx_material_data_ = _1873;
	    uvec3 _1064;
	    do
	    {
	        if (g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nBufferStrideInBytes.w == 4)
	        {
	            uint _1915 = (12u * uint(gl_PrimitiveID)) + uint(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nBufferBindOffsetBytes.w);
	            _1064 = uvec3(g_Indices_1[nonuniformEXT(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nVertexAndIndexBuffers.w)]._member0[_1915 / 4u], g_Indices_1[nonuniformEXT(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nVertexAndIndexBuffers.w)]._member0[(_1915 + 4u) / 4u], g_Indices_1[nonuniformEXT(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nVertexAndIndexBuffers.w)]._member0[(_1915 + 8u) / 4u]);
	            break;
	        }
	        else
	        {
	            uint _1894 = (6u * uint(gl_PrimitiveID)) + uint(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nBufferBindOffsetBytes.w);
	            uint _1895 = _1894 & 4294967292u;
	            uint _57 = _1895 / 4u;
	            uint _60 = (_1895 + 4u) / 4u;
	            uint _1899 = (g_Indices_1[nonuniformEXT(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nVertexAndIndexBuffers.w)]._member0[_57] & 4294901760u) >> uint(16);
	            uint _1900 = g_Indices_1[nonuniformEXT(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nVertexAndIndexBuffers.w)]._member0[_60] & 65535u;
	            uvec3 _1065;
	            if (_1894 == _1895)
	            {
	                _1065 = uvec3(g_Indices_1[nonuniformEXT(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nVertexAndIndexBuffers.w)]._member0[_57] & 65535u, _1899, _1900);
	            }
	            else
	            {
	                _1065 = uvec3(_1899, _1900, (g_Indices_1[nonuniformEXT(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nVertexAndIndexBuffers.w)]._member0[_60] & 4294901760u) >> uint(16));
	            }
	            _1064 = _1065;
	            break;
	        }
	        break;
	    } while(false);
	    uint _73 = uint(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nVertexAndIndexBuffers.x);
	    uvec3 _1937 = (uvec3(uint(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nBufferStrideInBytes.x)) * _1064) + uvec3(uint(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nBufferBindOffsetBytes.x));
	    vec3 _1058[3];
	    uint _1939 = _1937.x;
	    _1058[0] = vec3(g_Vertices_1[nonuniformEXT(_73)]._member0[_1939 / 4u], g_Vertices_1[nonuniformEXT(_73)]._member0[(_1939 + 4u) / 4u], g_Vertices_1[nonuniformEXT(_73)]._member0[(_1939 + 8u) / 4u]);
	    uint _1944 = _1937.y;
	    _1058[1] = vec3(g_Vertices_1[nonuniformEXT(_73)]._member0[_1944 / 4u], g_Vertices_1[nonuniformEXT(_73)]._member0[(_1944 + 4u) / 4u], g_Vertices_1[nonuniformEXT(_73)]._member0[(_1944 + 8u) / 4u]);
	    uint _1949 = _1937.z;
	    _1058[2] = vec3(g_Vertices_1[nonuniformEXT(_73)]._member0[_1949 / 4u], g_Vertices_1[nonuniformEXT(_73)]._member0[(_1949 + 4u) / 4u], g_Vertices_1[nonuniformEXT(_73)]._member0[(_1949 + 8u) / 4u]);
	    int _1059 = 0;
	    VS_INPUT vsInput[3];
	    for (;;)
	    {
	        if (!(_1059 < 3))
	        {
	            break;
	        }
	        vsInput[_1059].vPositionOs = _1058[_1059];
	        _1059++;
	        continue;
	    }
	    vec2 _1060[3];
	    _1060[0] = vec2(0.0);
	    _1060[1] = vec2(0.0);
	    _1060[2] = vec2(0.0);
	    if (g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vTexCoordFieldInfo.data[0].y != 0)
	    {
	        ivec4 _1057 = g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nVertexAndIndexBuffers;
	        uint _102 = uint(_1057[g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vTexCoordFieldInfo.data[0].z]);
	        uint _1991 = uint(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vTexCoordFieldInfo.data[0].z);
	        ivec4 _1055 = g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nBufferStrideInBytes;
	        ivec4 _1056 = g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nBufferBindOffsetBytes;
	        uvec3 _2007 = (uvec3(uint(_1055[_1991])) * _1064) + uvec3(uint(_1056[_1991]) + uint(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vTexCoordFieldInfo.data[0].x));
	        if (g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vTexCoordFieldInfo.data[0].y == 16)
	        {
	            uint _2121 = _2007.x;
	            _1060[0] = vec2(g_Vertices_1[nonuniformEXT(_102)]._member0[_2121 / 4u], g_Vertices_1[nonuniformEXT(_102)]._member0[(_2121 + 4u) / 4u]);
	            uint _2124 = _2007.y;
	            _1060[1] = vec2(g_Vertices_1[nonuniformEXT(_102)]._member0[_2124 / 4u], g_Vertices_1[nonuniformEXT(_102)]._member0[(_2124 + 4u) / 4u]);
	            uint _2127 = _2007.z;
	            _1060[2] = vec2(g_Vertices_1[nonuniformEXT(_102)]._member0[_2127 / 4u], g_Vertices_1[nonuniformEXT(_102)]._member0[(_2127 + 4u) / 4u]);
	        }
	        else
	        {
	            if (g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vTexCoordFieldInfo.data[0].y == 34)
	            {
	                uint _114 = _2007.x / 4u;
	                _1060[0] = vec2(uint16BitsToFloat16(u16vec2(uvec2(g_Vertices_3[nonuniformEXT(_102)]._member0[_114], g_Vertices_3[nonuniformEXT(_102)]._member0[_114] >> uint(16)) & uvec2(65535u))));
	                uint _117 = _2007.y / 4u;
	                _1060[1] = vec2(uint16BitsToFloat16(u16vec2(uvec2(g_Vertices_3[nonuniformEXT(_102)]._member0[_117], g_Vertices_3[nonuniformEXT(_102)]._member0[_117] >> uint(16)) & uvec2(65535u))));
	                uint _120 = _2007.z / 4u;
	                _1060[2] = vec2(uint16BitsToFloat16(u16vec2(uvec2(g_Vertices_3[nonuniformEXT(_102)]._member0[_120], g_Vertices_3[nonuniformEXT(_102)]._member0[_120] >> uint(16)) & uvec2(65535u))));
	            }
	            else
	            {
	                if (g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vTexCoordFieldInfo.data[0].y == 37)
	                {
	                    uint _104 = _2007.x / 4u;
	                    uint _2020 = g_Vertices_3[nonuniformEXT(_102)]._member0[_104] & 65535u;
	                    int _1054;
	                    if (_2020 > 32767u)
	                    {
	                        _1054 = int(4294901760u | _2020);
	                    }
	                    else
	                    {
	                        _1054 = int(_2020);
	                    }
	                    uint _2033 = (g_Vertices_3[nonuniformEXT(_102)]._member0[_104] & 4294901760u) >> uint(16);
	                    int _1053;
	                    if (_2033 > 32767u)
	                    {
	                        _1053 = int(4294901760u | _2033);
	                    }
	                    else
	                    {
	                        _1053 = int(_2033);
	                    }
	                    _1060[0] = vec2(max(float(_1054) * 3.0518509447574615478515625e-05, -1.0), max(float(_1053) * 3.0518509447574615478515625e-05, -1.0));
	                    uint _107 = _2007.y / 4u;
	                    uint _2047 = g_Vertices_3[nonuniformEXT(_102)]._member0[_107] & 65535u;
	                    int _1052;
	                    if (_2047 > 32767u)
	                    {
	                        _1052 = int(4294901760u | _2047);
	                    }
	                    else
	                    {
	                        _1052 = int(_2047);
	                    }
	                    uint _2060 = (g_Vertices_3[nonuniformEXT(_102)]._member0[_107] & 4294901760u) >> uint(16);
	                    int _1051;
	                    if (_2060 > 32767u)
	                    {
	                        _1051 = int(4294901760u | _2060);
	                    }
	                    else
	                    {
	                        _1051 = int(_2060);
	                    }
	                    _1060[1] = vec2(max(float(_1052) * 3.0518509447574615478515625e-05, -1.0), max(float(_1051) * 3.0518509447574615478515625e-05, -1.0));
	                    uint _110 = _2007.z / 4u;
	                    uint _2074 = g_Vertices_3[nonuniformEXT(_102)]._member0[_110] & 65535u;
	                    int _1050;
	                    if (_2074 > 32767u)
	                    {
	                        _1050 = int(4294901760u | _2074);
	                    }
	                    else
	                    {
	                        _1050 = int(_2074);
	                    }
	                    uint _2087 = (g_Vertices_3[nonuniformEXT(_102)]._member0[_110] & 4294901760u) >> uint(16);
	                    int _1049;
	                    if (_2087 > 32767u)
	                    {
	                        _1049 = int(4294901760u | _2087);
	                    }
	                    else
	                    {
	                        _1049 = int(_2087);
	                    }
	                    _1060[2] = vec2(max(float(_1050) * 3.0518509447574615478515625e-05, -1.0), max(float(_1049) * 3.0518509447574615478515625e-05, -1.0));
	                }
	            }
	        }
	    }
	    _1059 = 0;
	    for (;;)
	    {
	        if (!(_1059 < 3))
	        {
	            break;
	        }
	        vsInput[_1059].vTexCoord = _1060[_1059];
	        _1059++;
	        continue;
	    }
	    _1060[0] = vec2(0.0);
	    _1060[1] = vec2(0.0);
	    _1060[2] = vec2(0.0);
	    if (g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vTexCoordFieldInfo.data[1].y != 0)
	    {
	        ivec4 _1048 = g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nVertexAndIndexBuffers;
	        uint _142 = uint(_1048[g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vTexCoordFieldInfo.data[1].z]);
	        uint _2166 = uint(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vTexCoordFieldInfo.data[1].z);
	        ivec4 _1046 = g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nBufferStrideInBytes;
	        ivec4 _1047 = g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nBufferBindOffsetBytes;
	        uvec3 _2182 = (uvec3(uint(_1046[_2166])) * _1064) + uvec3(uint(_1047[_2166]) + uint(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vTexCoordFieldInfo.data[1].x));
	        if (g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vTexCoordFieldInfo.data[1].y == 16)
	        {
	            uint _2296 = _2182.x;
	            _1060[0] = vec2(g_Vertices_1[nonuniformEXT(_142)]._member0[_2296 / 4u], g_Vertices_1[nonuniformEXT(_142)]._member0[(_2296 + 4u) / 4u]);
	            uint _2299 = _2182.y;
	            _1060[1] = vec2(g_Vertices_1[nonuniformEXT(_142)]._member0[_2299 / 4u], g_Vertices_1[nonuniformEXT(_142)]._member0[(_2299 + 4u) / 4u]);
	            uint _2302 = _2182.z;
	            _1060[2] = vec2(g_Vertices_1[nonuniformEXT(_142)]._member0[_2302 / 4u], g_Vertices_1[nonuniformEXT(_142)]._member0[(_2302 + 4u) / 4u]);
	        }
	        else
	        {
	            if (g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vTexCoordFieldInfo.data[1].y == 34)
	            {
	                uint _154 = _2182.x / 4u;
	                _1060[0] = vec2(uint16BitsToFloat16(u16vec2(uvec2(g_Vertices_3[nonuniformEXT(_142)]._member0[_154], g_Vertices_3[nonuniformEXT(_142)]._member0[_154] >> uint(16)) & uvec2(65535u))));
	                uint _157 = _2182.y / 4u;
	                _1060[1] = vec2(uint16BitsToFloat16(u16vec2(uvec2(g_Vertices_3[nonuniformEXT(_142)]._member0[_157], g_Vertices_3[nonuniformEXT(_142)]._member0[_157] >> uint(16)) & uvec2(65535u))));
	                uint _160 = _2182.z / 4u;
	                _1060[2] = vec2(uint16BitsToFloat16(u16vec2(uvec2(g_Vertices_3[nonuniformEXT(_142)]._member0[_160], g_Vertices_3[nonuniformEXT(_142)]._member0[_160] >> uint(16)) & uvec2(65535u))));
	            }
	            else
	            {
	                if (g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vTexCoordFieldInfo.data[1].y == 37)
	                {
	                    uint _144 = _2182.x / 4u;
	                    uint _2195 = g_Vertices_3[nonuniformEXT(_142)]._member0[_144] & 65535u;
	                    int _1045;
	                    if (_2195 > 32767u)
	                    {
	                        _1045 = int(4294901760u | _2195);
	                    }
	                    else
	                    {
	                        _1045 = int(_2195);
	                    }
	                    uint _2208 = (g_Vertices_3[nonuniformEXT(_142)]._member0[_144] & 4294901760u) >> uint(16);
	                    int _1044;
	                    if (_2208 > 32767u)
	                    {
	                        _1044 = int(4294901760u | _2208);
	                    }
	                    else
	                    {
	                        _1044 = int(_2208);
	                    }
	                    _1060[0] = vec2(max(float(_1045) * 3.0518509447574615478515625e-05, -1.0), max(float(_1044) * 3.0518509447574615478515625e-05, -1.0));
	                    uint _147 = _2182.y / 4u;
	                    uint _2222 = g_Vertices_3[nonuniformEXT(_142)]._member0[_147] & 65535u;
	                    int _1043;
	                    if (_2222 > 32767u)
	                    {
	                        _1043 = int(4294901760u | _2222);
	                    }
	                    else
	                    {
	                        _1043 = int(_2222);
	                    }
	                    uint _2235 = (g_Vertices_3[nonuniformEXT(_142)]._member0[_147] & 4294901760u) >> uint(16);
	                    int _1042;
	                    if (_2235 > 32767u)
	                    {
	                        _1042 = int(4294901760u | _2235);
	                    }
	                    else
	                    {
	                        _1042 = int(_2235);
	                    }
	                    _1060[1] = vec2(max(float(_1043) * 3.0518509447574615478515625e-05, -1.0), max(float(_1042) * 3.0518509447574615478515625e-05, -1.0));
	                    uint _150 = _2182.z / 4u;
	                    uint _2249 = g_Vertices_3[nonuniformEXT(_142)]._member0[_150] & 65535u;
	                    int _1041;
	                    if (_2249 > 32767u)
	                    {
	                        _1041 = int(4294901760u | _2249);
	                    }
	                    else
	                    {
	                        _1041 = int(_2249);
	                    }
	                    uint _2262 = (g_Vertices_3[nonuniformEXT(_142)]._member0[_150] & 4294901760u) >> uint(16);
	                    int _1040;
	                    if (_2262 > 32767u)
	                    {
	                        _1040 = int(4294901760u | _2262);
	                    }
	                    else
	                    {
	                        _1040 = int(_2262);
	                    }
	                    _1060[2] = vec2(max(float(_1041) * 3.0518509447574615478515625e-05, -1.0), max(float(_1040) * 3.0518509447574615478515625e-05, -1.0));
	                }
	            }
	        }
	    }
	    _1059 = 0;
	    for (;;)
	    {
	        if (!(_1059 < 3))
	        {
	            break;
	        }
	        vsInput[_1059].vTexCoord2 = _1060[_1059];
	        _1059++;
	        continue;
	    }
	    vec3 _1061[3];
	    vec4 _1062[3];
	    do
	    {
	        if (g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vNormalFieldInfo.y != 0)
	        {
	            ivec4 _1026 = g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nVertexAndIndexBuffers;
	            uint _182 = uint(_1026[g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vNormalFieldInfo.z]);
	            uint _2346 = uint(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vNormalFieldInfo.z);
	            ivec4 _1024 = g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nBufferStrideInBytes;
	            ivec4 _1025 = g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nBufferBindOffsetBytes;
	            uvec3 _2362 = (uvec3(uint(_1024[_2346])) * _1064) + uvec3(uint(_1025[_2346]) + uint(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vNormalFieldInfo.x));
	            if (g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vNormalFieldInfo.y == 6)
	            {
	                uint _2863 = _2362.x;
	                _1061[0] = vec3(g_Vertices_1[nonuniformEXT(_182)]._member0[_2863 / 4u], g_Vertices_1[nonuniformEXT(_182)]._member0[(_2863 + 4u) / 4u], g_Vertices_1[nonuniformEXT(_182)]._member0[(_2863 + 8u) / 4u]);
	                uint _2868 = _2362.y;
	                _1061[1] = vec3(g_Vertices_1[nonuniformEXT(_182)]._member0[_2868 / 4u], g_Vertices_1[nonuniformEXT(_182)]._member0[(_2868 + 4u) / 4u], g_Vertices_1[nonuniformEXT(_182)]._member0[(_2868 + 8u) / 4u]);
	                uint _2873 = _2362.z;
	                _1061[2] = vec3(g_Vertices_1[nonuniformEXT(_182)]._member0[_2873 / 4u], g_Vertices_1[nonuniformEXT(_182)]._member0[(_2873 + 4u) / 4u], g_Vertices_1[nonuniformEXT(_182)]._member0[(_2873 + 8u) / 4u]);
	            }
	            else
	            {
	                if (g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vNormalFieldInfo.y == 17)
	                {
	                    uint _2617 = _2362.x;
	                    uvec2 _2619 = uvec2(g_Vertices_3[nonuniformEXT(_182)]._member0[_2617 / 4u], g_Vertices_3[nonuniformEXT(_182)]._member0[(_2617 + 4u) / 4u]);
	                    uint _2620 = _2362.y;
	                    uvec2 _809 = uvec2(g_Vertices_3[nonuniformEXT(_182)]._member0[_2620 / 4u], g_Vertices_3[nonuniformEXT(_182)]._member0[(_2620 + 4u) / 4u]);
	                    uint _2623 = _2362.z;
	                    uvec2 _808 = uvec2(g_Vertices_3[nonuniformEXT(_182)]._member0[_2623 / 4u], g_Vertices_3[nonuniformEXT(_182)]._member0[(_2623 + 4u) / 4u]);
	                    uint _2629 = _2619.x;
	                    uint _2637 = _2619.y;
	                    vec2 _2647 = ((vec2(float(_2629 & 65535u), float((_2629 >> 16u) & 65535u)) * vec2(1.525902189314365386962890625e-05)) * 2.0) - vec2(1.0);
	                    float _2648 = _2647.x;
	                    float _2653 = (1.0 - abs(_2648)) - abs(_2647.y);
	                    vec3 _2654 = vec3(_2648, _2647.y, _2653);
	                    float _2656 = saturate(-_2653);
	                    vec2 _2662 = _2647 + mix(vec2(_2656), vec2(-_2656), greaterThanEqual(_2647, vec2(0.0)));
	                    _2654.x = _2662.x;
	                    _2654.y = _2662.y;
	                    vec3 _1028 = normalize(_2654);
	                    vec2 _2669 = ((vec2(float((_2637 >> uint(1)) & 32767u), float((_2637 >> 16u) & 32767u)) * vec2(3.0518509447574615478515625e-05)) * 2.0) - vec2(1.0);
	                    float _2670 = _2669.x;
	                    float _2675 = (1.0 - abs(_2670)) - abs(_2669.y);
	                    vec3 _2676 = vec3(_2670, _2669.y, _2675);
	                    float _2678 = saturate(-_2675);
	                    vec2 _2684 = _2669 + mix(vec2(_2678), vec2(-_2678), greaterThanEqual(_2669, vec2(0.0)));
	                    _2676.x = _2684.x;
	                    _2676.y = _2684.y;
	                    vec3 _1027 = normalize(_2676);
	                    float _1014;
	                    if ((_2637 & 1u) != 0u)
	                    {
	                        _1014 = 1.0;
	                    }
	                    else
	                    {
	                        _1014 = -1.0;
	                    }
	                    _1061[0] = _1028;
	                    _1062[0].w = _1014;
	                    _1062[0].x = _1027.x;
	                    _1062[0].y = _1027.y;
	                    _1062[0].z = _1027.z;
	                    vec2 _2726 = ((vec2(float(_809.x & 65535u), float((_809.x >> 16u) & 65535u)) * vec2(1.525902189314365386962890625e-05)) * 2.0) - vec2(1.0);
	                    float _2727 = _2726.x;
	                    float _2732 = (1.0 - abs(_2727)) - abs(_2726.y);
	                    vec3 _2733 = vec3(_2727, _2726.y, _2732);
	                    float _2735 = saturate(-_2732);
	                    vec2 _2741 = _2726 + mix(vec2(_2735), vec2(-_2735), greaterThanEqual(_2726, vec2(0.0)));
	                    _2733.x = _2741.x;
	                    _2733.y = _2741.y;
	                    vec3 _1030 = normalize(_2733);
	                    vec2 _2748 = ((vec2(float((_809.y >> uint(1)) & 32767u), float((_809.y >> 16u) & 32767u)) * vec2(3.0518509447574615478515625e-05)) * 2.0) - vec2(1.0);
	                    float _2749 = _2748.x;
	                    float _2754 = (1.0 - abs(_2749)) - abs(_2748.y);
	                    vec3 _2755 = vec3(_2749, _2748.y, _2754);
	                    float _2757 = saturate(-_2754);
	                    vec2 _2763 = _2748 + mix(vec2(_2757), vec2(-_2757), greaterThanEqual(_2748, vec2(0.0)));
	                    _2755.x = _2763.x;
	                    _2755.y = _2763.y;
	                    vec3 _1029 = normalize(_2755);
	                    float _1013;
	                    if ((_809.y & 1u) != 0u)
	                    {
	                        _1013 = 1.0;
	                    }
	                    else
	                    {
	                        _1013 = -1.0;
	                    }
	                    _1061[1] = _1030;
	                    _1062[1].w = _1013;
	                    _1062[1].x = _1029.x;
	                    _1062[1].y = _1029.y;
	                    _1062[1].z = _1029.z;
	                    vec2 _2805 = ((vec2(float(_808.x & 65535u), float((_808.x >> 16u) & 65535u)) * vec2(1.525902189314365386962890625e-05)) * 2.0) - vec2(1.0);
	                    float _2806 = _2805.x;
	                    float _2811 = (1.0 - abs(_2806)) - abs(_2805.y);
	                    vec3 _2812 = vec3(_2806, _2805.y, _2811);
	                    float _2814 = saturate(-_2811);
	                    vec2 _2820 = _2805 + mix(vec2(_2814), vec2(-_2814), greaterThanEqual(_2805, vec2(0.0)));
	                    _2812.x = _2820.x;
	                    _2812.y = _2820.y;
	                    vec3 _1032 = normalize(_2812);
	                    vec2 _2827 = ((vec2(float((_808.y >> uint(1)) & 32767u), float((_808.y >> 16u) & 32767u)) * vec2(3.0518509447574615478515625e-05)) * 2.0) - vec2(1.0);
	                    float _2828 = _2827.x;
	                    float _2833 = (1.0 - abs(_2828)) - abs(_2827.y);
	                    vec3 _2834 = vec3(_2828, _2827.y, _2833);
	                    float _2836 = saturate(-_2833);
	                    vec2 _2842 = _2827 + mix(vec2(_2836), vec2(-_2836), greaterThanEqual(_2827, vec2(0.0)));
	                    _2834.x = _2842.x;
	                    _2834.y = _2842.y;
	                    vec3 _1031 = normalize(_2834);
	                    float _1012;
	                    if ((_808.y & 1u) != 0u)
	                    {
	                        _1012 = 1.0;
	                    }
	                    else
	                    {
	                        _1012 = -1.0;
	                    }
	                    _1061[2] = _1032;
	                    _1062[2].w = _1012;
	                    _1062[2].x = _1031.x;
	                    _1062[2].y = _1031.y;
	                    _1062[2].z = _1031.z;
	                    break;
	                }
	                else
	                {
	                    uint _184 = _2362.x / 4u;
	                    vec4 _1034 = _1062[0];
	                    float _2384 = (float((g_Vertices_3[nonuniformEXT(_182)]._member0[_184] >> 12u) & 1023u) * 0.00195503421127796173095703125) - 1.0;
	                    float _2387 = (float((g_Vertices_3[nonuniformEXT(_182)]._member0[_184] >> 22u) & 1023u) * 0.00195503421127796173095703125) - 1.0;
	                    float _2391 = (1.0 - abs(_2384)) - abs(_2387);
	                    vec3 _2392 = vec3(_2384, _2387, _2391);
	                    float _2394 = saturate(-_2391);
	                    vec2 _2395 = vec2(_2384, _2387);
	                    vec2 _2401 = _2395 + mix(vec2(_2394), vec2(-_2394), greaterThanEqual(_2395, vec2(0.0)));
	                    _2392.x = _2401.x;
	                    _2392.y = _2401.y;
	                    vec3 _2406 = normalize(_2392);
	                    vec3 _1033 = _2406;
	                    float _2407 = _2406.z;
	                    float _1021;
	                    if (_2407 >= 0.0)
	                    {
	                        _1021 = 1.0;
	                    }
	                    else
	                    {
	                        _1021 = -1.0;
	                    }
	                    float _2414 = (-1.0) / (_1021 + _2407);
	                    float _2415 = _2406.x;
	                    vec3 _1022;
	                    vec3 _2423 = _1022;
	                    _2423.x = 1.0 + (((_1021 * _2415) * _2415) * _2414);
	                    _2423.y = _1021 * ((_2415 * _2406.y) * _2414);
	                    _2423.z = (-_1021) * _2415;
	                    _1022 = _2423;
	                    float _2431 = float((g_Vertices_3[nonuniformEXT(_182)]._member0[_184] >> uint(1)) & 2047u) * 0.003069460391998291015625;
	                    vec3 _2437 = (_2423 * cos(_2431)) + (cross(_2406, _2423) * sin(_2431));
	                    vec4 _2439 = _1034;
	                    _2439.x = _2437.x;
	                    _2439.y = _2437.y;
	                    _2439.z = _2437.z;
	                    _1034 = _2439;
	                    float _1023;
	                    if ((g_Vertices_3[nonuniformEXT(_182)]._member0[_184] & 1u) == 0u)
	                    {
	                        _1023 = -1.0;
	                    }
	                    else
	                    {
	                        _1023 = 1.0;
	                    }
	                    vec4 _2450 = _1034;
	                    _2450.w = _1023;
	                    _1034 = _2450;
	                    _1061[0] = _1033;
	                    _1062[0] = _2450;
	                    uint _187 = _2362.y / 4u;
	                    vec4 _1036 = _1062[1];
	                    float _2466 = (float((g_Vertices_3[nonuniformEXT(_182)]._member0[_187] >> 12u) & 1023u) * 0.00195503421127796173095703125) - 1.0;
	                    float _2469 = (float((g_Vertices_3[nonuniformEXT(_182)]._member0[_187] >> 22u) & 1023u) * 0.00195503421127796173095703125) - 1.0;
	                    float _2473 = (1.0 - abs(_2466)) - abs(_2469);
	                    vec3 _2474 = vec3(_2466, _2469, _2473);
	                    float _2476 = saturate(-_2473);
	                    vec2 _2477 = vec2(_2466, _2469);
	                    vec2 _2483 = _2477 + mix(vec2(_2476), vec2(-_2476), greaterThanEqual(_2477, vec2(0.0)));
	                    _2474.x = _2483.x;
	                    _2474.y = _2483.y;
	                    vec3 _2488 = normalize(_2474);
	                    vec3 _1035 = _2488;
	                    float _2489 = _2488.z;
	                    float _1018;
	                    if (_2489 >= 0.0)
	                    {
	                        _1018 = 1.0;
	                    }
	                    else
	                    {
	                        _1018 = -1.0;
	                    }
	                    float _2496 = (-1.0) / (_1018 + _2489);
	                    float _2497 = _2488.x;
	                    vec3 _1019;
	                    vec3 _2505 = _1019;
	                    _2505.x = 1.0 + (((_1018 * _2497) * _2497) * _2496);
	                    _2505.y = _1018 * ((_2497 * _2488.y) * _2496);
	                    _2505.z = (-_1018) * _2497;
	                    _1019 = _2505;
	                    float _2513 = float((g_Vertices_3[nonuniformEXT(_182)]._member0[_187] >> uint(1)) & 2047u) * 0.003069460391998291015625;
	                    vec3 _2519 = (_2505 * cos(_2513)) + (cross(_2488, _2505) * sin(_2513));
	                    vec4 _2521 = _1036;
	                    _2521.x = _2519.x;
	                    _2521.y = _2519.y;
	                    _2521.z = _2519.z;
	                    _1036 = _2521;
	                    float _1020;
	                    if ((g_Vertices_3[nonuniformEXT(_182)]._member0[_187] & 1u) == 0u)
	                    {
	                        _1020 = -1.0;
	                    }
	                    else
	                    {
	                        _1020 = 1.0;
	                    }
	                    vec4 _2532 = _1036;
	                    _2532.w = _1020;
	                    _1036 = _2532;
	                    _1061[1] = _1035;
	                    _1062[1] = _2532;
	                    uint _190 = _2362.z / 4u;
	                    vec4 _1038 = _1062[2];
	                    float _2548 = (float((g_Vertices_3[nonuniformEXT(_182)]._member0[_190] >> 12u) & 1023u) * 0.00195503421127796173095703125) - 1.0;
	                    float _2551 = (float((g_Vertices_3[nonuniformEXT(_182)]._member0[_190] >> 22u) & 1023u) * 0.00195503421127796173095703125) - 1.0;
	                    float _2555 = (1.0 - abs(_2548)) - abs(_2551);
	                    vec3 _2556 = vec3(_2548, _2551, _2555);
	                    float _2558 = saturate(-_2555);
	                    vec2 _2559 = vec2(_2548, _2551);
	                    vec2 _2565 = _2559 + mix(vec2(_2558), vec2(-_2558), greaterThanEqual(_2559, vec2(0.0)));
	                    _2556.x = _2565.x;
	                    _2556.y = _2565.y;
	                    vec3 _2570 = normalize(_2556);
	                    vec3 _1037 = _2570;
	                    float _2571 = _2570.z;
	                    float _1015;
	                    if (_2571 >= 0.0)
	                    {
	                        _1015 = 1.0;
	                    }
	                    else
	                    {
	                        _1015 = -1.0;
	                    }
	                    float _2578 = (-1.0) / (_1015 + _2571);
	                    float _2579 = _2570.x;
	                    vec3 _1016;
	                    vec3 _2587 = _1016;
	                    _2587.x = 1.0 + (((_1015 * _2579) * _2579) * _2578);
	                    _2587.y = _1015 * ((_2579 * _2570.y) * _2578);
	                    _2587.z = (-_1015) * _2579;
	                    _1016 = _2587;
	                    float _2595 = float((g_Vertices_3[nonuniformEXT(_182)]._member0[_190] >> uint(1)) & 2047u) * 0.003069460391998291015625;
	                    vec3 _2601 = (_2587 * cos(_2595)) + (cross(_2570, _2587) * sin(_2595));
	                    vec4 _2603 = _1038;
	                    _2603.x = _2601.x;
	                    _2603.y = _2601.y;
	                    _2603.z = _2601.z;
	                    _1038 = _2603;
	                    float _1017;
	                    if ((g_Vertices_3[nonuniformEXT(_182)]._member0[_190] & 1u) == 0u)
	                    {
	                        _1017 = -1.0;
	                    }
	                    else
	                    {
	                        _1017 = 1.0;
	                    }
	                    vec4 _2614 = _1038;
	                    _2614.w = _1017;
	                    _1038 = _2614;
	                    _1061[2] = _1037;
	                    _1062[2] = _2614;
	                    break;
	                }
	                break;
	            }
	        }
	        else
	        {
	            _1061[0] = vec3(0.0);
	            _1061[1] = vec3(0.0);
	            _1061[2] = vec3(0.0);
	        }
	        if (g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vTangentFieldInfo.y != 0)
	        {
	            ivec4 _1039 = g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nVertexAndIndexBuffers;
	            uint _240 = uint(_1039[g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vTangentFieldInfo.z]);
	            uint _2892 = uint(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vTangentFieldInfo.z);
	            ivec4 _1010 = g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nBufferStrideInBytes;
	            ivec4 _1011 = g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nBufferBindOffsetBytes;
	            uvec3 _2908 = (uvec3(uint(_1010[_2892])) * _1064) + uvec3(uint(_1011[_2892]) + uint(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vTangentFieldInfo.x));
	            uint _2910 = _2908.x;
	            _1062[0] = vec4(g_Vertices_1[nonuniformEXT(_240)]._member0[_2910 / 4u], g_Vertices_1[nonuniformEXT(_240)]._member0[(_2910 + 4u) / 4u], g_Vertices_1[nonuniformEXT(_240)]._member0[(_2910 + 8u) / 4u], g_Vertices_1[nonuniformEXT(_240)]._member0[(_2910 + 12u) / 4u]);
	            uint _2916 = _2908.y;
	            _1062[1] = vec4(g_Vertices_1[nonuniformEXT(_240)]._member0[_2916 / 4u], g_Vertices_1[nonuniformEXT(_240)]._member0[(_2916 + 4u) / 4u], g_Vertices_1[nonuniformEXT(_240)]._member0[(_2916 + 8u) / 4u], g_Vertices_1[nonuniformEXT(_240)]._member0[(_2916 + 12u) / 4u]);
	            uint _2922 = _2908.z;
	            _1062[2] = vec4(g_Vertices_1[nonuniformEXT(_240)]._member0[_2922 / 4u], g_Vertices_1[nonuniformEXT(_240)]._member0[(_2922 + 4u) / 4u], g_Vertices_1[nonuniformEXT(_240)]._member0[(_2922 + 8u) / 4u], g_Vertices_1[nonuniformEXT(_240)]._member0[(_2922 + 12u) / 4u]);
	        }
	        else
	        {
	            _1062[0] = vec4(0.0);
	            _1062[1] = vec4(0.0);
	            _1062[2] = vec4(0.0);
	        }
	        break;
	    } while(false);
	    _1059 = 0;
	    for (;;)
	    {
	        if (!(_1059 < 3))
	        {
	            break;
	        }
	        vsInput[_1059].vNormalOs = _1061[_1059];
	        vsInput[_1059].vTangentUOs_flTangentVSign = _1062[_1059];
	        _1059++;
	        continue;
	    }
	    vec4 _1063[3];
	    if (g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vColorFieldInfo.data[0].y != 0)
	    {
	        ivec4 _1009 = g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nVertexAndIndexBuffers;
	        uint _278 = uint(_1009[g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vColorFieldInfo.data[0].z]);
	        uint _2969 = uint(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vColorFieldInfo.data[0].z);
	        ivec4 _1007 = g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nBufferStrideInBytes;
	        ivec4 _1008 = g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nBufferBindOffsetBytes;
	        uvec3 _2985 = (uvec3(uint(_1007[_2969])) * _1064) + uvec3(uint(_1008[_2969]) + uint(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vColorFieldInfo.data[0].x));
	        if (g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vColorFieldInfo.data[0].y == 2)
	        {
	            uint _3027 = _2985.x;
	            _1063[0] = vec4(g_Vertices_1[nonuniformEXT(_278)]._member0[_3027 / 4u], g_Vertices_1[nonuniformEXT(_278)]._member0[(_3027 + 4u) / 4u], g_Vertices_1[nonuniformEXT(_278)]._member0[(_3027 + 8u) / 4u], g_Vertices_1[nonuniformEXT(_278)]._member0[(_3027 + 12u) / 4u]);
	            uint _3033 = _2985.y;
	            _1063[1] = vec4(g_Vertices_1[nonuniformEXT(_278)]._member0[_3033 / 4u], g_Vertices_1[nonuniformEXT(_278)]._member0[(_3033 + 4u) / 4u], g_Vertices_1[nonuniformEXT(_278)]._member0[(_3033 + 8u) / 4u], g_Vertices_1[nonuniformEXT(_278)]._member0[(_3033 + 12u) / 4u]);
	            uint _3039 = _2985.z;
	            _1063[2] = vec4(g_Vertices_1[nonuniformEXT(_278)]._member0[_3039 / 4u], g_Vertices_1[nonuniformEXT(_278)]._member0[(_3039 + 4u) / 4u], g_Vertices_1[nonuniformEXT(_278)]._member0[(_3039 + 8u) / 4u], g_Vertices_1[nonuniformEXT(_278)]._member0[(_3039 + 12u) / 4u]);
	        }
	        else
	        {
	            uint _280 = _2985.x / 4u;
	            _1063[0] = vec4(uvec4(g_Vertices_3[nonuniformEXT(_278)]._member0[_280] & 255u, (g_Vertices_3[nonuniformEXT(_278)]._member0[_280] & 65280u) >> uint(8), (g_Vertices_3[nonuniformEXT(_278)]._member0[_280] & 16711680u) >> uint(16), (g_Vertices_3[nonuniformEXT(_278)]._member0[_280] & 4278190080u) >> uint(24))) * vec4(0.0039215688593685626983642578125);
	            uint _283 = _2985.y / 4u;
	            _1063[1] = vec4(uvec4(g_Vertices_3[nonuniformEXT(_278)]._member0[_283] & 255u, (g_Vertices_3[nonuniformEXT(_278)]._member0[_283] & 65280u) >> uint(8), (g_Vertices_3[nonuniformEXT(_278)]._member0[_283] & 16711680u) >> uint(16), (g_Vertices_3[nonuniformEXT(_278)]._member0[_283] & 4278190080u) >> uint(24))) * vec4(0.0039215688593685626983642578125);
	            uint _286 = _2985.z / 4u;
	            _1063[2] = vec4(uvec4(g_Vertices_3[nonuniformEXT(_278)]._member0[_286] & 255u, (g_Vertices_3[nonuniformEXT(_278)]._member0[_286] & 65280u) >> uint(8), (g_Vertices_3[nonuniformEXT(_278)]._member0[_286] & 16711680u) >> uint(16), (g_Vertices_3[nonuniformEXT(_278)]._member0[_286] & 4278190080u) >> uint(24))) * vec4(0.0039215688593685626983642578125);
	        }
	    }
	    else
	    {
	        _1063[0] = vec4(0.0);
	        _1063[1] = vec4(0.0);
	        _1063[2] = vec4(0.0);
	    }
	    _1059 = 0;
	    for (;;)
	    {
	        if (!(_1059 < 3))
	        {
	            break;
	        }
	        vsInput[_1059].vBlendColorTint = _1063[_1059];
	        _1059++;
	        continue;
	    }
	    vec4 _1066[3];
	    _1066[0] = vec4(0.0);
	    _1066[1] = vec4(0.0);
	    _1066[2] = vec4(0.0);
	    if (g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vTexCoordFieldInfo.data[4].y != 0)
	    {
	        ivec4 _1006 = g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nVertexAndIndexBuffers;
	        uint _326 = uint(_1006[g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vTexCoordFieldInfo.data[4].z]);
	        uint _3082 = uint(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vTexCoordFieldInfo.data[4].z);
	        ivec4 _1004 = g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nBufferStrideInBytes;
	        ivec4 _1005 = g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nBufferBindOffsetBytes;
	        uvec3 _3098 = (uvec3(uint(_1004[_3082])) * _1064) + uvec3(uint(_1005[_3082]) + uint(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vTexCoordFieldInfo.data[4].x));
	        if (g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vTexCoordFieldInfo.data[4].y == 2)
	        {
	            uint _3139 = _3098.x;
	            _1066[0] = vec4(g_Vertices_1[nonuniformEXT(_326)]._member0[_3139 / 4u], g_Vertices_1[nonuniformEXT(_326)]._member0[(_3139 + 4u) / 4u], g_Vertices_1[nonuniformEXT(_326)]._member0[(_3139 + 8u) / 4u], g_Vertices_1[nonuniformEXT(_326)]._member0[(_3139 + 12u) / 4u]);
	            uint _3144 = _3098.y;
	            _1066[1] = vec4(g_Vertices_1[nonuniformEXT(_326)]._member0[_3144 / 4u], g_Vertices_1[nonuniformEXT(_326)]._member0[(_3144 + 4u) / 4u], g_Vertices_1[nonuniformEXT(_326)]._member0[(_3144 + 8u) / 4u], g_Vertices_1[nonuniformEXT(_326)]._member0[(_3144 + 12u) / 4u]);
	            uint _3149 = _3098.z;
	            _1066[2] = vec4(g_Vertices_1[nonuniformEXT(_326)]._member0[_3149 / 4u], g_Vertices_1[nonuniformEXT(_326)]._member0[(_3149 + 4u) / 4u], g_Vertices_1[nonuniformEXT(_326)]._member0[(_3149 + 8u) / 4u], g_Vertices_1[nonuniformEXT(_326)]._member0[(_3149 + 12u) / 4u]);
	        }
	        else
	        {
	            if (g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vTexCoordFieldInfo.data[4].y == 28)
	            {
	                uint _328 = _3098.x / 4u;
	                _1066[0] = vec4(uvec4(g_Vertices_3[nonuniformEXT(_326)]._member0[_328] & 255u, (g_Vertices_3[nonuniformEXT(_326)]._member0[_328] & 65280u) >> uint(8), (g_Vertices_3[nonuniformEXT(_326)]._member0[_328] & 16711680u) >> uint(16), (g_Vertices_3[nonuniformEXT(_326)]._member0[_328] & 4278190080u) >> uint(24))) * vec4(0.0039215688593685626983642578125);
	                uint _331 = _3098.y / 4u;
	                _1066[1] = vec4(uvec4(g_Vertices_3[nonuniformEXT(_326)]._member0[_331] & 255u, (g_Vertices_3[nonuniformEXT(_326)]._member0[_331] & 65280u) >> uint(8), (g_Vertices_3[nonuniformEXT(_326)]._member0[_331] & 16711680u) >> uint(16), (g_Vertices_3[nonuniformEXT(_326)]._member0[_331] & 4278190080u) >> uint(24))) * vec4(0.0039215688593685626983642578125);
	                uint _334 = _3098.z / 4u;
	                _1066[2] = vec4(uvec4(g_Vertices_3[nonuniformEXT(_326)]._member0[_334] & 255u, (g_Vertices_3[nonuniformEXT(_326)]._member0[_334] & 65280u) >> uint(8), (g_Vertices_3[nonuniformEXT(_326)]._member0[_334] & 16711680u) >> uint(16), (g_Vertices_3[nonuniformEXT(_326)]._member0[_334] & 4278190080u) >> uint(24))) * vec4(0.0039215688593685626983642578125);
	            }
	        }
	    }
	    int _1067 = 0;
	    for (;;)
	    {
	        if (!(_1067 < 3))
	        {
	            break;
	        }
	        vsInput[_1067].vColorBlendValues = _1066[_1067];
	        _1067++;
	        continue;
	    }
	    vec2 _827 = vsInput[0].vTexCoord;
	    vec2 _826 = vsInput[0].vTexCoord2;
	    vec4 _825 = vsInput[0].vBlendColorTint;
	    vec3 _1001 = vsInput[0].vNormalOs;
	    vec4 _1002;
	    vec4 _3182 = _1002;
	    _3182.x = vsInput[0].vTangentUOs_flTangentVSign.x;
	    _3182.y = vsInput[0].vTangentUOs_flTangentVSign.y;
	    _3182.z = vsInput[0].vTangentUOs_flTangentVSign.z;
	    _3182.w = vsInput[0].vTangentUOs_flTangentVSign.w;
	    _1002 = _3182;
	    vec4 _3205 = vec4(uvec4(g_instanceBuffer._member0[uint(gl_InstanceID)].nSrgbColor & 255u, (g_instanceBuffer._member0[uint(gl_InstanceID)].nSrgbColor & 65280u) >> uint(8), (g_instanceBuffer._member0[uint(gl_InstanceID)].nSrgbColor & 16711680u) >> uint(16), (g_instanceBuffer._member0[uint(gl_InstanceID)].nSrgbColor & 4278190080u) >> uint(24))) * vec4(0.0039215688593685626983642578125);
	    vec4 _1000 = _3205;
	    vec3 _3206 = _3205.xyz;
	    vec3 _3207 = _3206 * vec3(0.077399380505084991455078125);
	    vec3 _3210 = pow((_3206 * vec3(0.947867333889007568359375)) + vec3(0.052132703363895416259765625), vec3(2.400000095367431640625));
	    float _997;
	    if (_3205.x <= 0.040449999272823333740234375)
	    {
	        _997 = _3207.x;
	    }
	    else
	    {
	        _997 = _3210.x;
	    }
	    float _998;
	    if (_3205.y <= 0.040449999272823333740234375)
	    {
	        _998 = _3207.y;
	    }
	    else
	    {
	        _998 = _3210.y;
	    }
	    float _999;
	    if (_3205.z <= 0.040449999272823333740234375)
	    {
	        _999 = _3207.z;
	    }
	    else
	    {
	        _999 = _3210.z;
	    }
	    vec3 _3235 = vec3(_997, _998, _999);
	    vec4 _3237 = _1000;
	    _3237.x = _3235.x;
	    _3237.y = _3235.y;
	    _3237.z = _3235.z;
	    _1000 = _3237;
	    vec4 _836;
	    vec4 _3244 = _836;
	    _3244.x = _3237.x;
	    _3244.y = _3237.y;
	    _3244.z = _3237.z;
	    _3244.w = _3237.w;
	    _836 = _3244;
	    mat3x4 _3255 = transpose(gl_WorldToObjectEXT);
	    mat3 _996;
	    mat3 _3258 = _996;
	    _3258[0] = _3255[0].xyz;
	    _3258[1] = _3255[1].xyz;
	    _3258[2] = _3255[2].xyz;
	    _996 = _3258;
	    vec3 _3267 = normalize(_3258 * _1001.xyz);
	    vec3 _837;
	    vec3 _3269 = _837;
	    _3269.x = _3267.x;
	    _3269.y = _3267.y;
	    _3269.z = _3267.z;
	    _837 = _3269;
	    mat3x4 _3281 = transpose(gl_WorldToObjectEXT);
	    mat3 _995;
	    mat3 _3284 = _995;
	    _3284[0] = _3281[0].xyz;
	    _3284[1] = _3281[1].xyz;
	    _3284[2] = _3281[2].xyz;
	    _995 = _3284;
	    vec3 _3293 = normalize(_3284 * _1002.xyz);
	    vec4 _835;
	    vec4 _3295 = _835;
	    _3295.x = _3293.x;
	    _3295.y = _3293.y;
	    _3295.z = _3293.z;
	    _3295.w = _1002.w;
	    _835 = _3295;
	    vec4 _3304 = _827.xyxy;
	    _3304.z = _826.x;
	    _3304.w = _826.y;
	    vec4 _838;
	    vec4 _834 = _838;
	    vec3 _833 = vec4(vsInput[0].vPositionOs.xyz, 1.0) * transpose(gl_ObjectToWorldEXT);
	    vec3 _832 = _3269;
	    vec4 _831 = _3304;
	    vec4 _830 = _3244;
	    vec4 _829 = _3295;
	    if (_g_rtx_material_data_.g_nUVSet1 > 0)
	    {
	        vec2 _1003;
	        if (_g_rtx_material_data_.g_nUVSet1 == 2)
	        {
	            _1003 = _3304.zw;
	        }
	        else
	        {
	            _1003 = _3304.xy;
	        }
	        vec4 _3326 = _831;
	        _3326.x = _1003.x;
	        _3326.y = _1003.y;
	        vec4 _3345 = _3326;
	        _3345.x = dot(_3326.xy, _g_rtx_material_data_.g_vTexCoordXform0_1.xy) + _g_rtx_material_data_.g_vTexCoordXform0_1.w;
	        _3345.y = dot(_3326.xy, _g_rtx_material_data_.g_vTexCoordXform1_1.xy) + _g_rtx_material_data_.g_vTexCoordXform1_1.w;
	        _831 = _3345;
	    }
	    vec4 _3347 = _830;
	    vec4 _3349 = _834;
	    _3349.x = _3347.x;
	    _3349.y = _3347.y;
	    _3349.z = _3347.z;
	    _3349.w = _g_rtx_material_data_.g_flModelTintAmount * (1.0 - min(_3349.x, min(_3349.y, _3349.z)));
	    _834 = _3349;
	    _3347.x = _g_rtx_material_data_.g_vColorTint.x;
	    _3347.y = _g_rtx_material_data_.g_vColorTint.y;
	    _3347.z = _g_rtx_material_data_.g_vColorTint.z;
	    vec3 _3378 = _3347.xyz * mix(vec3(1.0), _825.xyz, vec3(_825.w));
	    vec4 _3380 = _3347;
	    _3380.x = _3378.x;
	    _3380.y = _3378.y;
	    _3380.z = _3378.z;
	    _830 = _3380;
	    vec4 _807 = _3349;
	    vec3 _806 = _833;
	    vec3 _805 = _832;
	    vec4 _804 = _831;
	    vec4 _803 = _3380;
	    vec4 _802 = _829;
	    vec2 _824 = vsInput[1].vTexCoord;
	    vec2 _823 = vsInput[1].vTexCoord2;
	    vec4 _822 = vsInput[1].vBlendColorTint;
	    vec3 _992 = vsInput[1].vNormalOs;
	    vec4 _993;
	    vec4 _3398 = _993;
	    _3398.x = vsInput[1].vTangentUOs_flTangentVSign.x;
	    _3398.y = vsInput[1].vTangentUOs_flTangentVSign.y;
	    _3398.z = vsInput[1].vTangentUOs_flTangentVSign.z;
	    _3398.w = vsInput[1].vTangentUOs_flTangentVSign.w;
	    _993 = _3398;
	    vec4 _3421 = vec4(uvec4(g_instanceBuffer._member0[uint(gl_InstanceID)].nSrgbColor & 255u, (g_instanceBuffer._member0[uint(gl_InstanceID)].nSrgbColor & 65280u) >> uint(8), (g_instanceBuffer._member0[uint(gl_InstanceID)].nSrgbColor & 16711680u) >> uint(16), (g_instanceBuffer._member0[uint(gl_InstanceID)].nSrgbColor & 4278190080u) >> uint(24))) * vec4(0.0039215688593685626983642578125);
	    vec4 _991 = _3421;
	    vec3 _3422 = _3421.xyz;
	    vec3 _3423 = _3422 * vec3(0.077399380505084991455078125);
	    vec3 _3426 = pow((_3422 * vec3(0.947867333889007568359375)) + vec3(0.052132703363895416259765625), vec3(2.400000095367431640625));
	    float _988;
	    if (_3421.x <= 0.040449999272823333740234375)
	    {
	        _988 = _3423.x;
	    }
	    else
	    {
	        _988 = _3426.x;
	    }
	    float _989;
	    if (_3421.y <= 0.040449999272823333740234375)
	    {
	        _989 = _3423.y;
	    }
	    else
	    {
	        _989 = _3426.y;
	    }
	    float _990;
	    if (_3421.z <= 0.040449999272823333740234375)
	    {
	        _990 = _3423.z;
	    }
	    else
	    {
	        _990 = _3426.z;
	    }
	    vec3 _3451 = vec3(_988, _989, _990);
	    vec4 _3453 = _991;
	    _3453.x = _3451.x;
	    _3453.y = _3451.y;
	    _3453.z = _3451.z;
	    _991 = _3453;
	    vec4 _846;
	    vec4 _3460 = _846;
	    _3460.x = _3453.x;
	    _3460.y = _3453.y;
	    _3460.z = _3453.z;
	    _3460.w = _3453.w;
	    _846 = _3460;
	    mat3x4 _3471 = transpose(gl_WorldToObjectEXT);
	    mat3 _987;
	    mat3 _3474 = _987;
	    _3474[0] = _3471[0].xyz;
	    _3474[1] = _3471[1].xyz;
	    _3474[2] = _3471[2].xyz;
	    _987 = _3474;
	    vec3 _3483 = normalize(_3474 * _992.xyz);
	    vec3 _847;
	    vec3 _3485 = _847;
	    _3485.x = _3483.x;
	    _3485.y = _3483.y;
	    _3485.z = _3483.z;
	    _847 = _3485;
	    mat3x4 _3497 = transpose(gl_WorldToObjectEXT);
	    mat3 _986;
	    mat3 _3500 = _986;
	    _3500[0] = _3497[0].xyz;
	    _3500[1] = _3497[1].xyz;
	    _3500[2] = _3497[2].xyz;
	    _986 = _3500;
	    vec3 _3509 = normalize(_3500 * _993.xyz);
	    vec4 _845;
	    vec4 _3511 = _845;
	    _3511.x = _3509.x;
	    _3511.y = _3509.y;
	    _3511.z = _3509.z;
	    _3511.w = _993.w;
	    _845 = _3511;
	    vec4 _3520 = _824.xyxy;
	    _3520.z = _823.x;
	    _3520.w = _823.y;
	    vec4 _848;
	    vec4 _844 = _848;
	    vec3 _843 = vec4(vsInput[1].vPositionOs.xyz, 1.0) * transpose(gl_ObjectToWorldEXT);
	    vec3 _842 = _3485;
	    vec4 _841 = _3520;
	    vec4 _840 = _3460;
	    vec4 _839 = _3511;
	    if (_g_rtx_material_data_.g_nUVSet1 > 0)
	    {
	        vec2 _994;
	        if (_g_rtx_material_data_.g_nUVSet1 == 2)
	        {
	            _994 = _3520.zw;
	        }
	        else
	        {
	            _994 = _3520.xy;
	        }
	        vec4 _3542 = _841;
	        _3542.x = _994.x;
	        _3542.y = _994.y;
	        vec4 _3561 = _3542;
	        _3561.x = dot(_3542.xy, _g_rtx_material_data_.g_vTexCoordXform0_1.xy) + _g_rtx_material_data_.g_vTexCoordXform0_1.w;
	        _3561.y = dot(_3542.xy, _g_rtx_material_data_.g_vTexCoordXform1_1.xy) + _g_rtx_material_data_.g_vTexCoordXform1_1.w;
	        _841 = _3561;
	    }
	    vec4 _3563 = _840;
	    vec4 _3565 = _844;
	    _3565.x = _3563.x;
	    _3565.y = _3563.y;
	    _3565.z = _3563.z;
	    _3565.w = _g_rtx_material_data_.g_flModelTintAmount * (1.0 - min(_3565.x, min(_3565.y, _3565.z)));
	    _844 = _3565;
	    _3563.x = _g_rtx_material_data_.g_vColorTint.x;
	    _3563.y = _g_rtx_material_data_.g_vColorTint.y;
	    _3563.z = _g_rtx_material_data_.g_vColorTint.z;
	    vec3 _3594 = _3563.xyz * mix(vec3(1.0), _822.xyz, vec3(_822.w));
	    vec4 _3596 = _3563;
	    _3596.x = _3594.x;
	    _3596.y = _3594.y;
	    _3596.z = _3594.z;
	    _840 = _3596;
	    vec4 _801 = _3565;
	    vec3 _800 = _843;
	    vec3 _799 = _842;
	    vec4 _798 = _841;
	    vec4 _797 = _3596;
	    vec4 _796 = _839;
	    vec2 _821 = vsInput[2].vTexCoord;
	    vec2 _820 = vsInput[2].vTexCoord2;
	    vec4 _819 = vsInput[2].vBlendColorTint;
	    vec3 _983 = vsInput[2].vNormalOs;
	    vec4 _984;
	    vec4 _3614 = _984;
	    _3614.x = vsInput[2].vTangentUOs_flTangentVSign.x;
	    _3614.y = vsInput[2].vTangentUOs_flTangentVSign.y;
	    _3614.z = vsInput[2].vTangentUOs_flTangentVSign.z;
	    _3614.w = vsInput[2].vTangentUOs_flTangentVSign.w;
	    _984 = _3614;
	    vec4 _3637 = vec4(uvec4(g_instanceBuffer._member0[uint(gl_InstanceID)].nSrgbColor & 255u, (g_instanceBuffer._member0[uint(gl_InstanceID)].nSrgbColor & 65280u) >> uint(8), (g_instanceBuffer._member0[uint(gl_InstanceID)].nSrgbColor & 16711680u) >> uint(16), (g_instanceBuffer._member0[uint(gl_InstanceID)].nSrgbColor & 4278190080u) >> uint(24))) * vec4(0.0039215688593685626983642578125);
	    vec4 _982 = _3637;
	    vec3 _3638 = _3637.xyz;
	    vec3 _3639 = _3638 * vec3(0.077399380505084991455078125);
	    vec3 _3642 = pow((_3638 * vec3(0.947867333889007568359375)) + vec3(0.052132703363895416259765625), vec3(2.400000095367431640625));
	    float _979;
	    if (_3637.x <= 0.040449999272823333740234375)
	    {
	        _979 = _3639.x;
	    }
	    else
	    {
	        _979 = _3642.x;
	    }
	    float _980;
	    if (_3637.y <= 0.040449999272823333740234375)
	    {
	        _980 = _3639.y;
	    }
	    else
	    {
	        _980 = _3642.y;
	    }
	    float _981;
	    if (_3637.z <= 0.040449999272823333740234375)
	    {
	        _981 = _3639.z;
	    }
	    else
	    {
	        _981 = _3642.z;
	    }
	    vec3 _3667 = vec3(_979, _980, _981);
	    vec4 _3669 = _982;
	    _3669.x = _3667.x;
	    _3669.y = _3667.y;
	    _3669.z = _3667.z;
	    _982 = _3669;
	    vec4 _856;
	    vec4 _3676 = _856;
	    _3676.x = _3669.x;
	    _3676.y = _3669.y;
	    _3676.z = _3669.z;
	    _3676.w = _3669.w;
	    _856 = _3676;
	    mat3x4 _3687 = transpose(gl_WorldToObjectEXT);
	    mat3 _978;
	    mat3 _3690 = _978;
	    _3690[0] = _3687[0].xyz;
	    _3690[1] = _3687[1].xyz;
	    _3690[2] = _3687[2].xyz;
	    _978 = _3690;
	    vec3 _3699 = normalize(_3690 * _983.xyz);
	    vec3 _857;
	    vec3 _3701 = _857;
	    _3701.x = _3699.x;
	    _3701.y = _3699.y;
	    _3701.z = _3699.z;
	    _857 = _3701;
	    mat3x4 _3713 = transpose(gl_WorldToObjectEXT);
	    mat3 _977;
	    mat3 _3716 = _977;
	    _3716[0] = _3713[0].xyz;
	    _3716[1] = _3713[1].xyz;
	    _3716[2] = _3713[2].xyz;
	    _977 = _3716;
	    vec3 _3725 = normalize(_3716 * _984.xyz);
	    vec4 _855;
	    vec4 _3727 = _855;
	    _3727.x = _3725.x;
	    _3727.y = _3725.y;
	    _3727.z = _3725.z;
	    _3727.w = _984.w;
	    _855 = _3727;
	    vec4 _3736 = _821.xyxy;
	    _3736.z = _820.x;
	    _3736.w = _820.y;
	    vec4 _858;
	    vec4 _854 = _858;
	    vec3 _853 = vec4(vsInput[2].vPositionOs.xyz, 1.0) * transpose(gl_ObjectToWorldEXT);
	    vec3 _852 = _3701;
	    vec4 _851 = _3736;
	    vec4 _850 = _3676;
	    vec4 _849 = _3727;
	    if (_g_rtx_material_data_.g_nUVSet1 > 0)
	    {
	        vec2 _985;
	        if (_g_rtx_material_data_.g_nUVSet1 == 2)
	        {
	            _985 = _3736.zw;
	        }
	        else
	        {
	            _985 = _3736.xy;
	        }
	        vec4 _3758 = _851;
	        _3758.x = _985.x;
	        _3758.y = _985.y;
	        vec4 _3777 = _3758;
	        _3777.x = dot(_3758.xy, _g_rtx_material_data_.g_vTexCoordXform0_1.xy) + _g_rtx_material_data_.g_vTexCoordXform0_1.w;
	        _3777.y = dot(_3758.xy, _g_rtx_material_data_.g_vTexCoordXform1_1.xy) + _g_rtx_material_data_.g_vTexCoordXform1_1.w;
	        _851 = _3777;
	    }
	    vec4 _3779 = _850;
	    vec4 _3781 = _854;
	    _3781.x = _3779.x;
	    _3781.y = _3779.y;
	    _3781.z = _3779.z;
	    _3781.w = _g_rtx_material_data_.g_flModelTintAmount * (1.0 - min(_3781.x, min(_3781.y, _3781.z)));
	    _854 = _3781;
	    _3779.x = _g_rtx_material_data_.g_vColorTint.x;
	    _3779.y = _g_rtx_material_data_.g_vColorTint.y;
	    _3779.z = _g_rtx_material_data_.g_vColorTint.z;
	    vec3 _3810 = _3779.xyz * mix(vec3(1.0), _819.xyz, vec3(_819.w));
	    vec4 _3812 = _3779;
	    _3812.x = _3810.x;
	    _3812.y = _3810.y;
	    _3812.z = _3810.z;
	    _850 = _3812;
	    vec3 _795 = _853;
	    vec3 _794 = _852;
	    vec3 _3843 = ((_805 * ((1.0 - attrs.barycentrics.x) - attrs.barycentrics.y)) + (_799 * attrs.barycentrics.x)) + (_852 * attrs.barycentrics.y);
	    bool _3849 = gl_HitKindEXT == 254u;
	    vec3 _859;
	    vec3 _860;
	    vec4 _818 = ((_807 * ((1.0 - attrs.barycentrics.x) - attrs.barycentrics.y)) + (_801 * attrs.barycentrics.x)) + (_3781 * attrs.barycentrics.y);
	    vec3 _817 = _860;
	    vec3 _816 = _3843;
	    vec4 _815 = ((_804 * ((1.0 - attrs.barycentrics.x) - attrs.barycentrics.y)) + (_798 * attrs.barycentrics.x)) + (_851 * attrs.barycentrics.y);
	    vec4 _814 = ((_803 * ((1.0 - attrs.barycentrics.x) - attrs.barycentrics.y)) + (_797 * attrs.barycentrics.x)) + (_3812 * attrs.barycentrics.y);
	    vec4 _813 = ((_802 * ((1.0 - attrs.barycentrics.x) - attrs.barycentrics.y)) + (_796 * attrs.barycentrics.x)) + (_849 * attrs.barycentrics.y);
	    bool _812 = _3849;
	    vec3 _869 = _859;
	    vec3 _868 = normalize(cross(_800 - _806, _853 - _806));
	    bool _867 = _3849;
	    vec3 _878 = vec3(0.5);
	    vec2 _877 = vec2(0.5);
	    float _876 = 0.0;
	    vec3 _875 = vec3(0.0);
	    float _874 = 0.039999999105930328369140625;
	    vec3 _873 = vec3(0.0);
	    vec3 _871 = vec3(1.0);
	    bool _870 = false;
	    vec3 _3888 = _3843.xyz;
	    vec3 _872 = _3888;
	    if (dot(_3888, _3888) >= 1.0099999904632568359375)
	    {
	        _872 = _869.xyz;
	    }
	    _874 = _g_rtx_material_data_.g_flReflectance;
	    _871 = _868;
	    bool _975;
	    if (_g_rtx_material_data_.g_bRenderBackfaceNormals)
	    {
	        _975 = !_g_rtx_material_data_.g_bDontFlipBackfaceNormals;
	    }
	    else
	    {
	        _975 = false;
	    }
	    SPIRV_CROSS_BRANCH
	    if (_975)
	    {
	        float _976;
	        if (_867)
	        {
	            _976 = 1.0;
	        }
	        else
	        {
	            _976 = -1.0;
	        }
	        _872 *= _976;
	        if (_867)
	        {
	            _976 = 1.0;
	        }
	        else
	        {
	            _976 = -1.0;
	        }
	        _871 *= _976;
	        _870 = !_867;
	    }
	    vec3 _3922 = _872;
	    vec3 _3923 = normalize(_3922);
	    _872 = _3923;
	    vec4 _866 = _818;
	    vec3 _865 = _817;
	    vec3 _864 = _816;
	    vec4 _863 = _815;
	    vec4 _862 = _814;
	    bool _861 = _812;
	    vec3 _912 = _3923;
	    vec3 _911 = _878;
	    vec2 _910 = _877;
	    float _909 = _876;
	    vec3 _908 = _875;
	    float _907 = _874;
	    vec3 _906 = _873;
	    vec3 _905 = _3923;
	    vec3 _904 = _871;
	    bool _903 = _870;
	    bool _973;
	    if (_g_rtx_material_data_.g_bRenderBackfaceNormals)
	    {
	        _973 = !_g_rtx_material_data_.g_bDontFlipBackfaceNormals;
	    }
	    else
	    {
	        _973 = false;
	    }
	    if (_973)
	    {
	        float _974;
	        if (_861)
	        {
	            _974 = 1.0;
	        }
	        else
	        {
	            _974 = -1.0;
	        }
	        _973 = _974 < 0.0;
	    }
	    else
	    {
	        _973 = false;
	    }
	    vec3 _916 = vec3(0.0);
	    vec3 _915 = vec3(0.0);
	    float _971;
	    if (_813.w > 0.0)
	    {
	        _971 = 1.0;
	    }
	    else
	    {
	        _971 = -1.0;
	    }
	    float _3974 = 1.0 / length(_864);
	    vec3 _917 = _864 * _3974;
	    vec3 _811 = _813.xyz * _3974;
	    vec3 _810 = (cross(_864, _813.xyz) * _971) * _3974;
	    if (_973)
	    {
	        _917 *= (-1.0);
	    }
	    vec3 _914 = _916 - (_917 * dot(_916, _917));
	    vec3 _913 = _915 - (_917 * dot(_915, _917));
	    int _972;
	    if (dot(_915, cross(_917, _916)) < 0.0)
	    {
	        _972 = -1;
	    }
	    else
	    {
	        _972 = 1;
	    }
	    vec3 _940 = _917;
	    vec3 _939 = _914;
	    vec3 _938 = _913;
	    float _937 = float(_972);
	    vec3 _901;
	    vec3 _902;
	    if (_g_rtx_material_data_.g_nUVSet1 > 1)
	    {
	        float _970;
	        if (false)
	        {
	            _970 = -1.0;
	        }
	        else
	        {
	            _970 = 1.0;
	        }
	        vec2 _4011 = vec2(0.0, -0.0) * _970;
	        vec3 _918 = (_939 * _4011.x) + (_938 * _4011.y);
	        float _4019 = abs(0.0);
	        if (_4019 > 0.0)
	        {
	            _918 = normalize(_918);
	        }
	        _902 = _918;
	        _901 = cross(_940, _918) * (_970 * _937);
	    }
	    else
	    {
	        _902 = vec3(0.0);
	        _901 = vec3(0.0);
	    }
	    vec2 _900 = vec2(0.0);
	    vec2 _899 = vec2(0.0);
	    vec2 _898 = vec2(0.0);
	    vec2 _897 = vec2(0.0);
	    vec2 _896 = vec2(0.0);
	    vec2 _895 = vec2(0.0);
	    vec2 _894 = vec2(0.0);
	    ivec2 _893 = ivec2(0);
	    ivec2 _892 = ivec2(0);
	    if (_g_rtx_material_data_.g_nUVSet1 == 0)
	    {
	        vec3 _4039 = abs(_905);
	        vec3 _965 = _4039;
	        float _4040 = _4039.x;
	        float _4041 = _4039.y;
	        bool _966;
	        if (_4040 > _4041)
	        {
	            _966 = _4040 > _4039.z;
	        }
	        else
	        {
	            _966 = false;
	        }
	        ivec3 _967;
	        if (_966)
	        {
	            _967 = ivec3(0, 1, 2);
	        }
	        else
	        {
	            if (_4041 > _4039.z)
	            {
	                _967 = ivec3(1, 2, 0);
	            }
	            else
	            {
	                _967 = ivec3(2, 0, 1);
	            }
	        }
	        if (_4040 < _4041)
	        {
	            _966 = _4040 < _4039.z;
	        }
	        else
	        {
	            _966 = false;
	        }
	        ivec3 _968;
	        if (_966)
	        {
	            _968 = ivec3(0, 1, 2);
	        }
	        else
	        {
	            if (_4041 < _4039.z)
	            {
	                _968 = ivec3(1, 2, 0);
	            }
	            else
	            {
	                _968 = ivec3(2, 0, 1);
	            }
	        }
	        ivec3 _4075 = (ivec3(3) - _968) - _967;
	        ivec2 _969;
	        if (_967.x == 1)
	        {
	            _969 = _967.zy;
	        }
	        else
	        {
	            _969 = _967.yz;
	        }
	        ivec2 _4087 = _893;
	        _4087.x = _969.x;
	        _4087.y = _969.y;
	        _893 = _4087;
	        int _4091 = _4075.x;
	        if (_4091 == 1)
	        {
	            _969 = _4075.zy;
	        }
	        else
	        {
	            _969 = _4075.yz;
	        }
	        ivec2 _4100 = _892;
	        _4100.x = _969.x;
	        _4100.y = _969.y;
	        _892 = _4100;
	        vec2 _4111 = saturate((vec2(_965[_967.x], _965[_4091]) - vec2(0.577300012111663818359375)) * vec2(2.365744113922119140625));
	        _894 = _4111 / vec2(_4111.x + _4111.y);
	        vec3 _956 = _865 * _g_rtx_material_data_.g_vBiplanarTexCoordScale.xyz;
	        _900 = vec2(_956[_893.x], _956[_893.y]);
	        vec3 _957 = vec3(0.0);
	        vec3 _958 = vec3(0.0);
	        _898 = vec2(_957[_893.x], _958[_893.y]);
	        vec3 _959 = vec3(0.0);
	        vec3 _960 = vec3(0.0);
	        _897 = vec2(_959[_893.x], _960[_893.y]);
	        _899 = vec2(_956[_4100.x], _956[_4100.y]);
	        vec3 _961 = vec3(0.0);
	        vec3 _962 = vec3(0.0);
	        _896 = vec2(_961[_4100.x], _962[_4100.y]);
	        vec3 _963 = vec3(0.0);
	        vec3 _964 = vec3(0.0);
	        _895 = vec2(_963[_4100.x], _964[_4100.y]);
	    }
	    vec4 _891 = vec4(0.0);
	    vec3 _890 = vec3(0.0);
	    vec4 _887 = vec4(0.0);
	    float _886 = 0.0;
	    float _885 = 0.0;
	    float _884 = 0.0;
	    vec3 _4169 = vec3(0.0);
	    _4169.x = _863.x;
	    _4169.y = _863.y;
	    vec3 _889 = _4169;
	    vec2 _888 = _g_rtx_material_data_.g_vTexCoordScale1.xy;
	    vec2 _925 = _900;
	    vec2 _924 = _899;
	    vec2 _923 = _898;
	    vec2 _922 = _897;
	    vec2 _921 = _896;
	    vec2 _920 = _895;
	    vec2 _919 = _894;
	    vec4 _955;
	    if (_g_rtx_material_data_.g_nUVSet1 == 0)
	    {
	        vec2 _4194 = _925;
	        vec2 _4195 = _4194 * _888;
	        _925 = _4195;
	        vec2 _4196 = _923;
	        vec2 _4197 = _4196 * _888;
	        _923 = _4197;
	        vec2 _4198 = _922;
	        vec2 _4199 = _4198 * _888;
	        _922 = _4199;
	        vec2 _4200 = _924;
	        vec2 _4201 = _4200 * _888;
	        _924 = _4201;
	        vec2 _4202 = _921;
	        vec2 _4203 = _4202 * _888;
	        _921 = _4203;
	        vec2 _4204 = _920;
	        vec2 _4205 = _4204 * _888;
	        _920 = _4205;
	        _955 = (textureGrad(nonuniformEXT(sampler2D(g_bindless_Texture2D_float4[_g_rtx_material_data_.g_tHeight1], g_bindless_Sampler[_g_rtx_material_data_.g_sUserConfig])), _4195.xy, _4197.xy, _4199.xy) * _919.x) + (textureGrad(nonuniformEXT(sampler2D(g_bindless_Texture2D_float4[_g_rtx_material_data_.g_tHeight1], g_bindless_Sampler[_g_rtx_material_data_.g_sUserConfig])), _4201.xy, _4203.xy, _4205.xy) * _919.y);
	    }
	    else
	    {
	        _955 = textureLod(nonuniformEXT(sampler2D(g_bindless_Texture2D_float4[_g_rtx_material_data_.g_tHeight1], g_bindless_Sampler[_g_rtx_material_data_.g_sUserConfig])), _889.xy, 0.0).xyzw;
	    }
	    _885 = _955.y;
	    _886 = _955.w;
	    vec3 _883 = _905;
	    vec3 _882 = _811;
	    vec3 _881 = _810;
	    vec3 _880 = _902;
	    vec3 _879 = _901;
	    vec2 _936 = _900;
	    vec2 _935 = _899;
	    vec2 _934 = _898;
	    vec2 _933 = _897;
	    vec2 _932 = _896;
	    vec2 _931 = _895;
	    vec2 _930 = _894;
	    ivec2 _929 = _893;
	    ivec2 _928 = _892;
	    if (_g_rtx_material_data_.g_nUVSet1 == 0)
	    {
	        _936 *= _888;
	        _934 *= _888;
	        _933 *= _888;
	        _935 *= _888;
	        _932 *= _888;
	        _931 *= _888;
	        _890 = _883;
	        if (true)
	        {
	            _891 = textureGrad(nonuniformEXT(sampler2D(g_bindless_Texture2D_float4[_g_rtx_material_data_.g_tColor1], g_bindless_Sampler[_g_rtx_material_data_.g_sUserConfig])), _936.xy, _934.xy, _933.xy) * _930.x;
	        }
	        if (true)
	        {
	            vec4 _4382 = textureGrad(nonuniformEXT(sampler2D(g_bindless_Texture2D_float4[_g_rtx_material_data_.g_tNormal1], g_bindless_Sampler[_g_rtx_material_data_.g_sUserConfig])), _936.xy, _934.xy, _933.xy);
	            _884 = _4382.z * _930.x;
	            float _4387 = _4382.x;
	            float _4388 = _4382.y;
	            float _4390 = (_4387 + _4388) - 1.00392162799835205078125;
	            float _4391 = _4387 - _4388;
	            vec3 _4401 = normalize(vec3(vec2(_4390, _4391), (1.0 - abs(_4390)) - abs(_4391))).xyz * _930.x;
	            vec4 _4403;
	            _4403.x = _4401.x;
	            _4403.y = _4401.y;
	            vec4 _4407 = _4403;
	            _4407.z = _4401.z;
	            _890 = (_727[_929.x] * _4403.x) + (_731[_929.y] * _4403.y);
	        }
	        if (_930.y > 0.0)
	        {
	            if (true)
	            {
	                _891 += (textureGrad(nonuniformEXT(sampler2D(g_bindless_Texture2D_float4[_g_rtx_material_data_.g_tColor1], g_bindless_Sampler[_g_rtx_material_data_.g_sUserConfig])), _935.xy, _932.xy, _931.xy) * _930.y);
	            }
	            if (true)
	            {
	                vec4 _4455 = textureGrad(nonuniformEXT(sampler2D(g_bindless_Texture2D_float4[_g_rtx_material_data_.g_tNormal1], g_bindless_Sampler[_g_rtx_material_data_.g_sUserConfig])), _935.xy, _932.xy, _931.xy);
	                _884 += (_4455.z * _930.y);
	                float _4462 = _4455.x;
	                float _4463 = _4455.y;
	                float _4465 = (_4462 + _4463) - 1.00392162799835205078125;
	                float _4466 = _4462 - _4463;
	                vec3 _4476 = normalize(vec3(vec2(_4465, _4466), (1.0 - abs(_4465)) - abs(_4466))).xyz * _930.y;
	                vec4 _4478;
	                _4478.x = _4476.x;
	                _4478.y = _4476.y;
	                vec4 _4482 = _4478;
	                _4482.z = _4476.z;
	                _890 += ((_727[_928.x] * _4478.x) + (_731[_928.y] * _4478.y));
	            }
	        }
	        _890 = normalize(_890 + _883);
	    }
	    else
	    {
	        if (true)
	        {
	            _891 = textureGrad(nonuniformEXT(sampler2D(g_bindless_Texture2D_float4[_g_rtx_material_data_.g_tColor1], g_bindless_Sampler[_g_rtx_material_data_.g_sUserConfig])), _889.xy, _887.xy, _887.zw).xyzw;
	        }
	        if (true)
	        {
	            vec4 _4277 = textureGrad(nonuniformEXT(sampler2D(g_bindless_Texture2D_float4[_g_rtx_material_data_.g_tNormal1], g_bindless_Sampler[_g_rtx_material_data_.g_sUserConfig])), _889.xy, _887.xy, _887.zw);
	            vec3 _4278 = _4277.xyz;
	            _884 = _4277.z;
	            float _4280 = _4277.x;
	            float _4281 = _4277.y;
	            float _4283 = (_4280 + _4281) - 1.00392162799835205078125;
	            float _4284 = _4280 - _4281;
	            vec3 _4291 = normalize(vec3(vec2(_4283, _4284), (1.0 - abs(_4283)) - abs(_4284)));
	            _4278.x = _4291.x;
	            _4278.y = _4291.y;
	            _4278.z = _4291.z;
	            vec3 _4304 = _4278;
	            _4304.x = dot(_4278.xy, _g_rtx_material_data_.g_vNormalXform_1.xy);
	            _4304.y = dot(_4278.xy, _g_rtx_material_data_.g_vNormalXform_1.zw);
	            vec3 _954 = _4304;
	            vec3 _926;
	            vec3 _927;
	            if (_g_rtx_material_data_.g_nUVSet1 > 1)
	            {
	                _927 = _880;
	                _926 = _879;
	            }
	            else
	            {
	                _927 = _882;
	                _926 = _881;
	            }
	            vec3 _4316 = abs(_954.xyz);
	            vec2 _4329 = (-vec2(_954.x, (-1.0) * _954.y)) / vec2(max(_4316.z, 0.0078125 * max(_4316.x, _4316.y)));
	            _890 = normalize(_940 - ((_927 * _4329.x) + (_926 * _4329.y)));
	        }
	    }
	    if (true)
	    {
	        _890 = normalize(_890);
	        _884 = saturate(_884);
	    }
	    vec4 _949;
	    if (false)
	    {
	        _949 = vec4((vec4(_891.xyz, 1.0) * _g_rtx_material_data_.g_mTextureAdjust1).xyz, _891.w);
	    }
	    else
	    {
	        _949 = _891;
	    }
	    vec4 _4525 = _949;
	    float _4527 = _885;
	    float _4528 = saturate(_4527);
	    _885 = _4528;
	    vec3 _4532 = mix(_4525.xyz, vec4((vec4(_891.xyz, 1.0) * _g_rtx_material_data_.g_mTextureColorAdjust1).xyz, _789).xyz, vec3(_4528));
	    vec4 _4534 = _4525;
	    _4534.x = _4532.x;
	    _4534.y = _4532.y;
	    _4534.z = _4532.z;
	    float _4544 = dot(_4534.xyz, vec3(0.2125000059604644775390625, 0.7153999805450439453125, 0.07209999859333038330078125));
	    vec3 _4547 = normalize(max(_866.xyz, vec3(0.001000000047497451305389404296875)));
	    vec4 _4566 = vec4(saturate(mix(_4534.xyz, (_4547 * min(_4544 / dot(_4547.xyz, vec3(0.2125000059604644775390625, 0.7153999805450439453125, 0.07209999859333038330078125)), (3.0 * _4544) * max(_866.x, max(_866.y, _866.z)))).xyz, vec3(_866.w * _4528))).xyz, _4534.w);
	    _891 = _4566;
	    _912 = _890.xyz;
	    _911 = _4566.xyz;
	    vec2 _4571 = _910;
	    _4571.x = _884;
	    _909 = _886;
	    vec2 _4574 = _4571;
	    _4574.x = _4571.x;
	    _4574.y = _4571.x;
	    _910 = _4574;
	    vec3 _4584 = _911;
	    vec3 _4585 = _4584 * mix(vec3(1.0), _862.xyz, vec3(saturate(_885)));
	    _911 = _4585;
	    payload.nInstance = int(uint(gl_InstanceID));
	    payload.flHitT = gl_RayTmaxEXT;
	    payload.vFaceNormalWs = _904;
	    payload.vInterpolatedNormalWs = _905;
	    vec3 _947[3] = vec3[](_806, _800, _795);
	    vec3 _948[3] = vec3[](_805, _799, _794);
	    vec3 _4626 = ((_947[0] * ((1.0 - attrs.barycentrics.x) - attrs.barycentrics.y)) + (_947[1] * attrs.barycentrics.x)) + (_947[2] * attrs.barycentrics.y);
	    vec3 _941[3];
	    _941[0] = _4626 - (_948[0] * dot(_4626 - _947[0], _948[0]));
	    _941[1] = _4626 - (_948[1] * dot(_4626 - _947[1], _948[1]));
	    _941[2] = _4626 - (_948[2] * dot(_4626 - _947[2], _948[2]));
	    vec3 _4666 = ((_941[0] * ((1.0 - attrs.barycentrics.x) - attrs.barycentrics.y)) + (_941[1] * attrs.barycentrics.x)) + (_941[2] * attrs.barycentrics.y);
	    vec3 _942[3];
	    _942[0] = cross(_947[0] - _947[1], _904);
	    _942[1] = cross(_947[1] - _947[2], _904);
	    _942[2] = cross(_947[2] - _947[0], _904);
	    float _943 = dot(_4666 - _4626, _904);
	    vec3 _944 = _4666;
	    int _945 = 0;
	    for (;;)
	    {
	        bool _4682_ladder_break = false;
	        do
	        {
	            if (!(_945 < 3))
	            {
	                _4682_ladder_break = true;
	                break;
	            }
	            if (_943 > 0.00999999977648258209228515625)
	            {
	                _4682_ladder_break = true;
	                break;
	            }
	            if (dot(_942[_945], _942[_945]) == 0.0)
	            {
	                break;
	            }
	            _942[_945] = normalize(_942[_945]);
	            int _946 = 0;
	            for (;;)
	            {
	                if (!(_946 < 3))
	                {
	                    break;
	                }
	                vec3 _4720 = _948[_946] - (_942[_945] * dot(_942[_945], _948[_946]));
	                _941[_946] = _4626 - (_4720 * dot(_4626 - _947[_946], _4720));
	                _946++;
	                continue;
	            }
	            vec3 _4744 = ((_941[0] * ((1.0 - attrs.barycentrics.x) - attrs.barycentrics.y)) + (_941[1] * attrs.barycentrics.x)) + (_941[2] * attrs.barycentrics.y);
	            _943 = dot(_4744 - _4626, _904);
	            _944 = _4744;
	            break;
	        } while(false);
	        if (_4682_ladder_break)
	        {
	            break;
	        }
	        _945++;
	        continue;
	    }
	    if (!(_943 > 0.00999999977648258209228515625))
	    {
	        _944 = vec3(3.4028234663852885981170418348452e+38);
	    }
	    payload.vSmoothPositionWs = _944;
	    payload.bFlippedNormal = _903;
	    f16vec3 _4757 = f16vec3(vec3(0.0));
	    payload.material = MaterialDataMinimal_t(_4757, float16_t(0.0), f16vec3(vec3(1.0, 0.0, 1.0)), float16_t(1.0), _4757, float16_t(0.040008544921875), 0u, f16vec4(ivec4(0)));
	    payload.material.vNormalWs = f16vec3(_912);
	    payload.material.vAlbedo = f16vec3(_4585);
	    payload.material.vEmissive = f16vec3(_908);
	    payload.material.flReflectance = float16_t(_907);
	    payload.material.flMetalness = float16_t(_909);
	    payload.material.flRoughness = float16_t(dot(_910, vec2(0.5)));
	    if (any(greaterThan(_906, vec3(0.0))))
	    {
	        payload.material.nMaterialTypeAndFlags = (payload.material.nMaterialTypeAndFlags & 4294901760u) | 1u;
	        f16vec3 _4783 = f16vec3(_906);
	        payload.material.vMaterialBits.x = _4783.x;
	        payload.material.vMaterialBits.y = _4783.y;
	        payload.material.vMaterialBits.z = _4783.z;
	    }
	}
	
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
	
	BoolAttribute(BindlessResources, true);
	IntAttribute(RayTypeCount, 2);
	StringAttribute(MaterialLayerRefType, csgo_environment);
	BoolAttribute(CanBatchWithDynamicShaderConstants, true);
	IntAttribute(TexCoordScaleByModelU, g_nScaleTexCoordUByModelScaleAxis-1);
	IntAttribute(TexCoordScaleByModelV, g_nScaleTexCoordVByModelScaleAxis-1);
	Float3Attribute(LightSim_MaterialTint, g_vColorTint);
	BoolAttribute(VertexPaintUIPickColor, true);
	BoolAttribute(GroupDefaultCollapseState_TextureTransform, true);
	BoolAttribute(GroupDefaultCollapseState_DetailTextureTransform, true);
	BoolAttribute(HasTexcoordTransform, (g_nUVSet1>0 && (g_vTexCoordScale1.x!=1 || g_vTexCoordScale1.y!=1 || g_flTexCoordRotation1!=0)) ? 1 : 0);
	BoolAttribute(VertexPaintUIAlphaBlendFactor, true);
	BoolAttribute(VertexPaintUIPuddles, (F_WETNESS==1) ? 1 : 0);
	BoolAttribute(SupportsAggregateInstancing, true);
	BoolAttribute(NeedsLightProbe, true);
	BoolAttribute(DoNotCastShadows, F_DO_NOT_CAST_SHADOWS ? 1 : 0);
	BoolAttribute(SupportsMappingDimensions, true);
	BoolAttribute(renderbackfaces, F_RENDER_BACKFACES ? 1 : 0);
	
	#if (S_SHADER_QUALITY == 0)
		BoolAttribute(alphatest, true);
		FloatAttribute(_dummyReferenceAlphaTestReferenceInMainShader, g_flAlphaTestReference);
		FloatAttribute(_dummyReferenceAntiAliasedEdgeStrengthReferenceInMainShader, g_flAntiAliasedEdgeStrength);
		BoolAttribute(NoZPrepass, true);
		BoolAttribute(AlphaTestZPrepass, true);
	#endif
	#if (S_ALPHA_TEST_LAYER == 1)
		BoolAttribute(alphatest, true);
		FloatAttribute(_dummyReferenceAlphaTestReferenceInMainShader, g_flAlphaTestReference);
		FloatAttribute(_dummyReferenceAntiAliasedEdgeStrengthReferenceInMainShader, g_flAntiAliasedEdgeStrength);
		BoolAttribute(NoZPrepass, true);
		BoolAttribute(AlphaTestZPrepass, true);
	#endif
	#if (S_ALPHA_TEST_LAYER == 0)
		BoolAttribute(NoZPrepass, F_DISABLE_Z_PREPASS ? 1 : 0);
	#endif
	#if (S_MODE_DEPTH == 0)
		BoolAttribute(alphatest, true);
		FloatAttribute(_dummyReferenceAlphaTestReferenceInMainShader, g_flAlphaTestReference);
		FloatAttribute(_dummyReferenceAntiAliasedEdgeStrengthReferenceInMainShader, g_flAntiAliasedEdgeStrength);
		BoolAttribute(NoZPrepass, true);
		BoolAttribute(AlphaTestZPrepass, true);
	#endif
	#if (S_MODE_TOOLS_VIS == 0)
		BoolAttribute(alphatest, true);
		FloatAttribute(_dummyReferenceAlphaTestReferenceInMainShader, g_flAlphaTestReference);
		FloatAttribute(_dummyReferenceAntiAliasedEdgeStrengthReferenceInMainShader, g_flAntiAliasedEdgeStrength);
		BoolAttribute(NoZPrepass, true);
		BoolAttribute(AlphaTestZPrepass, true);
	#endif
	#if (S_MATERIAL_REFERENCE == 0)
		BoolAttribute(alphatest, true);
		FloatAttribute(_dummyReferenceAlphaTestReferenceInMainShader, g_flAlphaTestReference);
		FloatAttribute(_dummyReferenceAntiAliasedEdgeStrengthReferenceInMainShader, g_flAntiAliasedEdgeStrength);
		BoolAttribute(NoZPrepass, true);
		BoolAttribute(AlphaTestZPrepass, true);
	#endif
	#if (S_MATERIAL_REFERENCE == 1)
		IntAttribute(MaterialLayerCount, 1);
		StringAttribute(MaterialLayerType, csgo_environment);
	#endif
}
