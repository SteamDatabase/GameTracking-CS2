//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Shader for rendering static overlays placed in Hammer.";
	DevShader = false;
	Version = 1;
	
	// Platform: VULKAN_SM_50
	// Programs: ps, vs, psrs
}

MODES
{
	CsgoForward();
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
	Feature( F_LIT, 0..1, "Lighting" );
	Feature( F_BLEND_MODE, 0..6 (0="Opaque", 1="Translucent", 2="Alpha Test", 3="Mod2x", 4="Additive", 5="Multiply", 6="ModThenAdd"), "Blend Mode" );
	Feature( F_PAINT_VERTEX_COLORS, 0..1, "Vertex Color" );
	Feature( F_AUTOMATIC_PBR_COLOR_FITTING, 0..1, "PBR" );
	Feature( F_MATERIAL_REFERENCE, 0..1, "Reference a csgo_environment material" );
	Feature( F_TINT_MASK, 0..1, "Tint Mask" );
	Feature( F_BLEND_EFFECTS, 0..1, "Blend Effects" );
	Feature( F_BORDER_ROUGHNESS, 0..1, "Blend Effects" );
	Feature( F_TEXTURE_ANIMATION, 0..1, "Animation" );
	Feature( F_TEXTURE_ANIMATION_MODE, 0..2 (0="Sequential", 1="Random", 2="Scripted"), "Animation" );
	FeatureRule( Requires( F_DONT_FLIP_BACKFACE_NORMALS, F_RENDER_BACKFACES ), "Only applies to backfaces" );
	FeatureRule( Allow1( F_AUTOMATIC_PBR_COLOR_FITTING, F_MATERIAL_REFERENCE ), "Automatic PBR Color Fitting is incompatible with Material Reference." );
	FeatureRule( Requires( F_AUTOMATIC_PBR_COLOR_FITTING, F_BLEND_MODE==0, F_BLEND_MODE==1, F_BLEND_MODE==2 ), "Automatic PBR Color Fitting is incompatible with Mod2x, Multiply, Additive and ModThenAdd blend modes." );
	FeatureRule( Requires( F_MATERIAL_REFERENCE, F_LIT ), "Material Reference requires Lit" );
	FeatureRule( Requires( F_AUTOMATIC_PBR_COLOR_FITTING, F_LIT ), "Automatic PBR Color Fitting requires Lit" );
	FeatureRule( Requires( F_TINT_MASK, F_MATERIAL_REFERENCE==0 ), "Tint mask is automatically enabled in Material Reference mode therefore it cannot be toggled" );
	FeatureRule( Requires( F_BORDER_ROUGHNESS, F_BLEND_EFFECTS ), "Border Roughness requires Blend Effects" );
	FeatureRule( Requires( F_BLEND_EFFECTS, F_MATERIAL_REFERENCE ), "Blend Effects require Material Reference" );
	FeatureRule( Requires( F_MATERIAL_REFERENCE, F_BLEND_MODE==0, F_BLEND_MODE==1, F_BLEND_MODE==2 ), "Material Reference is incompatible with Mod2x, Multiply, Additive and ModThenAdd blend modes." );
	FeatureRule( Requires( F_LIT==1, F_BLEND_MODE==0, F_BLEND_MODE==1, F_BLEND_MODE==2 ), "Lit is incompatible with Mod2x, Multiply, Additive and ModThenAdd blend modes." );
	FeatureRule( Requires( F_TEXTURE_ANIMATION_MODE, F_TEXTURE_ANIMATION==1 ), "Texture Animation Mode requires Texture Animation On" );
}

COMMON
{
	#include "system.fxc"
}

struct VS_INPUT
{
	float4 vBlendIndices              : BLENDINDICES0  < Semantic( BlendIndices ); >;              // D_CS_VERTEX_ANIMATION=0, S_MODE_TOOLS_VIS=1
	float4 vBlendColorTint            : COLOR0         < Semantic( VertexPaintTintColor ); >;      // S_PAINT_VERTEX_COLORS=1
	float4 vPerVertexLighting         : COLOR1         < Semantic( PerVertexLighting ); >;        
	uint4  nPackedFrame               : NORMAL0        < Semantic( CompressedTangentFrame ); >;   
	float4 vNormalOs                  : NORMAL0        < Semantic( Normal ); >;                   
	float4 vTangentUOs_flTangentVSign : TANGENT0       < Semantic( TangentU_SignV ); >;           
	float3 vPositionOs                : POSITION0      < Semantic( PosXyz ); >;                    // D_CS_VERTEX_ANIMATION=0
	float2 vLightmapUV                : TEXCOORD3      < Semantic( LightmapUV ); >;                // D_BAKED_LIGHTING_FROM_LIGHTMAP=1
	float2 vTexCoord                  : TEXCOORD0      < Semantic( LowPrecisionUv ); >;           
	float2 nInstanceIdx               : TEXCOORD13     < Semantic( InstanceTransformUv ); >;      
};

VS
{
	StaticCombo( S_MATERIAL_REFERENCE, F_MATERIAL_REFERENCE );
	StaticCombo( S_BLEND_MODE, F_BLEND_MODE );
	StaticCombo( S_LIT, F_LIT );
	StaticCombo( S_PAINT_VERTEX_COLORS, F_PAINT_VERTEX_COLORS );
	StaticCombo( S_TEXTURE_ANIMATION, F_TEXTURE_ANIMATION );
	StaticCombo( S_MODE_TOOLS_VIS, 0..1 );
	StaticComboRule( Requires( S_MATERIAL_REFERENCE, S_LIT ) );
	StaticComboRule( Requires( S_MATERIAL_REFERENCE, S_BLEND_MODE==0, S_BLEND_MODE==1, S_BLEND_MODE==2 ) );
	StaticComboRule( Requires( S_LIT==1, S_BLEND_MODE==0, S_BLEND_MODE==1, S_BLEND_MODE==2 ) );
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
	int g_nTextureAnimationMode < UiType(Slider); Expression(F_TEXTURE_ANIMATION_MODE); >;
	[[layer_constant]] StructuredBuffer g_transformBuffer < Attribute("TransformBuffer"); >;
	float2 g_vAnimationInvGrid < UiType(VectorText); Expression(1/g_vAnimationGrid); >;
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
	
	// Texture Animation
	int2 g_vAnimationGrid < Default2(1, 1); Range2(1, 1, 64, 64); UiType(VectorText); UiGroup("Texture Animation,12/10"); >;
	int g_nNumAnimationCells < Default(1); Range(1, 4096); UiType(Slider); UiGroup("Texture Animation,12/20"); >;
	float g_flAnimationTimePerFrame < Default(0.1); Range(0, 10); UiType(Slider); UiGroup("Texture Animation,12/30"); >;
	float g_flAnimationTimeOffset < Range(0, 1000); UiType(Slider); UiGroup("Texture Animation,12/40"); >;
	float g_flAnimationFrame < Range(0, 4096); UiType(Slider); UiGroup("Texture Animation,12/50"); >;
	
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
	
	// Material1
	int g_nUVSet1 < Default(1); Range4(0, 0, 0, 0, 2, 2, 2, 2); UiOptions("0=Biplanar,1=UV1,2=UV2"); UiType(Enum); UiGroup("Material1/Texture Coordinates,34/1"); >;
	float2 g_vTexCoordScale1 < Default2(1, 1); Range2(0, 0, 100, 100); Attribute("0=X,1=Y"); UiType(VectorText); UiGroup("Material1/Texture Transform,35/2"); >;
	float g_flTexCoordRotation1 < Range(-360, 360); UiType(Slider); UiGroup("Material1/Texture Transform,35/13"); UiVisibility(1); >;
	
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
	
	struct _1340
	{
	    mat4 _m0;
	    float _m1;
	    vec4 _m2;
	    vec3 _m3;
	};
	
	layout(set = 0) uniform _1340 PerViewConstantBuffer_t;
	
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
	layout(location = 3) in uvec4 vBlendIndices;
	layout(location = 4) in uint nInstanceIdx;
	layout(location = 0) out vec3 output_0;
	layout(location = 1) out vec3 output_1;
	layout(location = 2) out vec4 output_2;
	layout(location = 3) out vec3 output_3;
	layout(location = 4) out vec3 output_4;
	layout(location = 5) out vec4 output_5;
	layout(location = 6) centroid out vec4 output_6;
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
	    output_0 = _12151;
	    output_1 = _12151 - PerViewConstantBuffer_t._m3.xyz;
	    output_2 = _20488;
	    output_3 = _12151.xyz - PerViewConstantBufferCsgo_t._m0.xyz;
	    output_4 = normalize(vec4(vNormalOs.xyz, 0.0) * g_transformBuffer_1._m0[_21785]._m0);
	    output_5 = _20488;
	    output_6 = _23714;
	    output_7 = g_instanceBuffer_1._m0[nInstanceIdx]._m5 & 65535u;
	    _18237.y = -_18237.y;
	    gl_Position = _18237;
	}
	
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
	
	BoolAttribute(BindlessResources, true);
	BoolAttribute(GroupDefaultCollapseState_TextureTransform, true);
	BoolAttribute(GroupDefaultCollapseState_DetailTextureTransform, true);
	BoolAttribute(CanBatchWithDynamicShaderConstants, true);
	IntAttribute(TexCoordScaleByModelU, g_nScaleTexCoordUByModelScaleAxis-1);
	IntAttribute(TexCoordScaleByModelV, g_nScaleTexCoordVByModelScaleAxis-1);
	Float3Attribute(LightSim_MaterialTint, g_vColorTint);
	
	#if (S_MATERIAL_REFERENCE == 0)
		BoolAttribute(HasTexcoordTransform, false);
	#endif
	#if (S_LIT == 0)
		BoolAttribute(HasTexcoordTransform, false);
	#endif
	#if (S_MODE_TOOLS_VIS == 1)
		BoolAttribute(environmentmapped, true);
		BoolAttribute(environmentmappeddynamic, true);
	#endif
	#if (S_PAINT_VERTEX_COLORS == 0)
		BoolAttribute(environmentmapped, true);
		BoolAttribute(environmentmappeddynamic, true);
	#endif
	#if (S_PAINT_VERTEX_COLORS == 1)
		BoolAttribute(VertexPaintUIPickColorAlpha, F_BLEND_MODE>0);
		BoolAttribute(VertexPaintUIPickColor, true);
	#endif
	#if (S_MODE_TOOLS_VIS == 0)
		BoolAttribute(VertexPaintUIPickColorAlpha, F_BLEND_MODE>0);
		BoolAttribute(VertexPaintUIPickColor, true);
	#endif
	#if (S_LIT == 1)
		BoolAttribute(environmentmapped, true);
		BoolAttribute(environmentmappeddynamic, true);
	#endif
	#if (S_MATERIAL_REFERENCE == 1)
		IntAttribute(MaterialLayerCount, 1);
		BoolAttribute(environmentmapped, true);
		BoolAttribute(environmentmappeddynamic, true);
	#endif
	
	// Variant Attributes
	BoolAttribute(HasTexcoordTransform, (g_nUVSet1>0 && (g_vTexCoordScale1.x!=1 || g_vTexCoordScale1.y!=1 || g_flTexCoordRotation1!=0)) ? 1 : 0);
}

PS
{
	StaticCombo( S_MATERIAL_REFERENCE, F_MATERIAL_REFERENCE );
	StaticCombo( S_BLEND_MODE, F_BLEND_MODE );
	StaticCombo( S_LIT, F_LIT );
	StaticCombo( S_BLEND_EFFECTS, F_BLEND_EFFECTS );
	StaticCombo( S_TINT_MASK, F_TINT_MASK );
	StaticCombo( S_SHADER_QUALITY, 0..1 );
	StaticCombo( S_MODE_TOOLS_VIS, 0..1 );
	StaticComboRule( Requires( S_MODE_TOOLS_VIS, S_SHADER_QUALITY ) );
	StaticComboRule( Requires( S_MATERIAL_REFERENCE, S_LIT ) );
	StaticComboRule( Requires( S_TINT_MASK, S_MATERIAL_REFERENCE==0 ) );
	StaticComboRule( Requires( S_BLEND_EFFECTS, S_MATERIAL_REFERENCE ) );
	StaticComboRule( Requires( S_MATERIAL_REFERENCE, S_BLEND_MODE==0, S_BLEND_MODE==1, S_BLEND_MODE==2 ) );
	StaticComboRule( Requires( S_LIT==1, S_BLEND_MODE==0, S_BLEND_MODE==1, S_BLEND_MODE==2 ) );
	DynamicCombo( D_OPAQUE_FADE, 0..1 );
	DynamicCombo( D_BAKED_LIGHTING_FROM_VERTEX_STREAM, 0..1 );
	DynamicCombo( D_BAKED_LIGHTING_FROM_PROBE, 0..1 );
	DynamicCombo( D_BAKED_LIGHTING_FROM_LIGHTMAP, 0..1 );
	DynamicComboRule( Requires( D_OPAQUE_FADE, S_BLEND_MODE==0 ) );
	DynamicComboRule( Allow1( D_BAKED_LIGHTING_FROM_PROBE, D_BAKED_LIGHTING_FROM_VERTEX_STREAM, D_BAKED_LIGHTING_FROM_LIGHTMAP ) );
	
	bool bAutomaticPBRColorFitting < UiType(CheckBox); Expression(F_AUTOMATIC_PBR_COLOR_FITTING); >;
	[[layer_constant]] StructuredBuffer g_BarnLights < Attribute("BarnLights"); >;
	[[layer_constant]] StructuredBuffer g_CullBits < Attribute("CullBits"); >;
	bool g_bAdjustBaseColor1 < UiType(CheckBox); Expression(g_nColorCorrectionMode1==1); >;
	bool g_bBorderRoughness < UiType(CheckBox); Expression(F_BORDER_ROUGHNESS); >;
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
	float4x4 g_mTextureAdjust1 < Expression(MatrixMultiply(MatrixColorTint2(float3(1,1,1),1),MatrixColorCorrect2(float3(g_fTextureColorContrast1,g_fTextureColorSaturation1,g_fTextureColorBrightness1),TextureAverageColor(g_tColor1)))); >;
	float4x4 g_mTextureColorAdjust < Expression(MatrixMultiply(MatrixColorTint2(g_vTextureColorCorrectionTint,1),MatrixColorCorrect2(float3(g_fTextureColorContrast,g_fTextureColorSaturation,g_fTextureColorBrightness),TextureAverageColor(g_tColor)))); >;
	float4x4 g_mTextureColorAdjust1 < Expression(MatrixMultiply(MatrixColorTint2(g_vTextureColorTint1,1),MatrixColorCorrect2(float3(g_fTextureColorContrast1,g_fTextureColorSaturation1,g_fTextureColorBrightness1),TextureAverageColor(g_tColor1)))); >;
	int g_nToolsVisMode < Attribute("g_nToolsVisMode"); UiType(Slider); >;
	Texture2D g_tAmbientOcclusion < Channel(R, Box3(TextureAmbientOcclusion), Linear); OutputFormat(ATI1N); SrgbRead(false); >;
	Texture2D g_tColor < Channel(RGB, ArtistDefinedOrAlphaWeighted(TextureColor, TextureTranslucency), Srgb); Channel(A, Box(TextureTranslucency), Linear); OutputFormat(BC7); SrgbRead(false); >;
	Texture2D g_tColor < Channel(RGB, ArtistDefined(TextureColor), Srgb); OutputFormat(DXT1); SrgbRead(true); >;
	Texture2D g_tColor < Channel(RGB, ArtistDefinedOrAlphaWeighted(TextureColor, TextureTranslucency), Srgb); Channel(A, Box(TextureTranslucency), Linear); OutputFormat(BC7); SrgbRead(true); >;
	Texture2D g_tColor < Channel(RGB, ArtistDefinedOrAlphaWeighted(TextureColor, TextureTranslucency), Srgb); Channel(A, PreserveCoverage(TextureTranslucency), Linear); OutputFormat(BC7); SrgbRead(true); >;
	Texture2D g_tColor1 < Channel(RGB, ArtistDefined(TextureColor1), Srgb); Channel(A, Box(TextureAmbientOcclusion1), Linear); OutputFormat(BC7); SrgbRead(true); >;
	Texture2D g_tColor1 < Channel(RGB, ArtistDefinedOrAlphaWeighted(TextureColor1, TextureTranslucency1), Srgb); Channel(A, PreserveCoverage(TextureTranslucency1), Linear); OutputFormat(BC7); SrgbRead(true); >;
	Texture2D g_tHeight1 < Channel(R, ArtistDefined(TextureHeight1), Linear); Channel(G, ArtistDefined(TextureTintMask1), Linear); Channel(A, Box(TextureMetalness1), Linear); OutputFormat(BC7); SrgbRead(false); >;
	Texture2D g_tMetalness < Channel(G, Box(TextureMetalness), Linear); OutputFormat(DXT1); SrgbRead(false); >;
	Texture2D g_tNormal < Channel(RGBA, HemiOctIsoRoughness_RG_B(TextureNormal, TextureRoughness), Linear); OutputFormat(BC7); SrgbRead(false); >;
	Texture2D g_tNormal1 < Channel(RGBA, HemiOctIsoRoughness_RG_B(TextureNormal1, TextureRoughness1), Linear); OutputFormat(BC7); SrgbRead(false); >;
	Texture2D g_tSelfIllumMask < Channel(RGB, Box(TextureSelfIllumMask), Srgb); OutputFormat(DXT1); SrgbRead(true); >;
	Texture2D g_tSelfIllumMask < Channel(RGB, Box(TextureSelfIllumMask), Srgb); Channel(A, Box(TextureTranslucency), Linear); OutputFormat(BC7); SrgbRead(true); >;
	Texture2D g_tTintMask < Channel(R, Box(TextureTintMask), Linear); OutputFormat(ATI1N); SrgbRead(false); >;
	float3 g_vAlbedoLevels < UiType(VectorText); Expression(float3(-float3(-.045,.4,1.15).x,-1.4427*log(max(.0001,1-float3(-.045,.4,1.15).y)),2-float3(-.045,.4,1.15).z)); >;
	float3 g_vBiplanarTexCoordScale < UiType(VectorText); Expression(1/64*float3(-1,1,-1)); >;
	float3 g_vDarkMetallicAlbedoLevels < UiType(VectorText); Expression(float3(-float3(-.1,.4,1.08).x,-1.4427*log(max(.0001,1-float3(-.1,.4,1.08).y)),2-float3(-.1,.4,1.08).z)); >;
	float3 g_vFlatOverlayColor < Default2(1, 0); Attribute("FlatOverlayColor"); UiType(VectorText); >;
	float3 g_vMetallicAlbedoLevels < UiType(VectorText); Expression(float3(-float3(-.45,.4,1.08).x,-1.4427*log(max(.0001,1-float3(-.45,.4,1.08).y)),2-float3(-.45,.4,1.08).z)); >;
	float4 g_vNormalXform_1 < UiType(VectorText); Expression(v0 = g_flTexCoordRotation1*3.1415927/180;
		v1 = cos(v0);
		v2 = sin(v0);
		float4(v1,-v2,v2,v1)); >;
	float3 g_vSelfIllumTintScaled < UiType(VectorText); Expression(pow(2,g_flSelfIllumBrightness).x*g_flSelfIllumScale.x*SrgbGammaToLinear(g_vSelfIllumTint.xyz)); >;
	float4 g_vShaderIDColor < Source(ShaderIDColor); UiType(VectorText); >;
	
	// Ambient Occlusion
	CreateInputTexture2D(TextureAmbientOcclusion, Linear, 8, "", "_ao", "Ambient Occlusion/10", Default4(1, 1, 1, 0));
	
	// Material1
	CreateInputTexture2D(TextureColor1, Srgb, 8, "", "_color", "Material1,0/Color,10/0", Default4(1, 1, 1, 0));
	CreateInputTexture2D(TextureNormal1, Linear, 8, "NormalizeNormals", "_normal", "Material1/Lighting/0", Default4(0.5, 0.5, 1, 0));
	CreateInputTexture2D(TextureTintMask1, Linear, 8, "", "_mask", "Material1/Tint Mask,15/0", Default4(1, 1, 1, 0));
	CreateInputTexture2D(TextureTranslucency1, Linear, 8, "", "_trans", "Material1/Translucent,15/0", Default4(1, 1, 1, 0));
	float g_flBlendSoftness1 < Default(0.01); UiType(Slider); UiGroup("Material1/Blend Effects,40/0"); Expression(max(.001,this)); >;
	int g_nUVSet1 < Default(1); Range4(0, 0, 0, 0, 2, 2, 2, 2); UiOptions("0=Biplanar,1=UV1,2=UV2"); UiType(Enum); UiGroup("Material1/Texture Coordinates,34/1"); >;
	float2 g_vTexCoordScale1 < Default2(1, 1); Range2(0, 0, 100, 100); Attribute("0=X,1=Y"); UiType(VectorText); UiGroup("Material1/Texture Transform,35/2"); >;
	float g_fTintMaskBrightness1 < Default(1); Range(0, 4); UiType(Slider); UiGroup("Material1/Tint Mask/5"); >;
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
	float g_fTextureColorBrightness1 < Default(1); Range(-8, 8); UiType(Slider); UiGroup("Material1/Color Correction/40"); >;
	int g_nColorCorrectionMode1 < UiOptions("0=Mask All,1=Mask only Tint"); UiType(Enum); UiGroup("Material1/Color Correction/45"); >;
	bool g_bModelTint1 < Default(1); UiType(CheckBox); UiGroup("Material1/Color Correction/60"); >;
	bool g_bSnowLayer1 < UiType(CheckBox); UiGroup("Material1/Snow,100"); >;
	
	// Color
	CreateInputTexture2D(TextureTintMask, Linear, 8, "", "_mask", "Color", Default4(1, 1, 1, 0));
	CreateInputTexture2D(TextureColor, Srgb, 8, "", "_color", "Color/10", Default4(1, 1, 1, 0));
	float3 g_vTextureColorCorrectionTint < Default3(1, 1, 1); UiType(Color); UiGroup("Color/Color Correction,17/10"); >;
	float g_fTextureColorContrast < Default(1); Range(0, 4); UiType(Slider); UiGroup("Color/Color Correction/20"); >;
	float g_fTextureColorSaturation < Default(1); Range(0, 4); UiType(Slider); UiGroup("Color/Color Correction/30"); >;
	float g_fTextureColorBrightness < Default(1); Range(-8, 8); UiType(Slider); UiGroup("Color/Color Correction/40"); >;
	float g_flBlendSoftnessDistanceModifierStrength < Default(1); UiType(Slider); UiGroup("Color/120"); >;
	
	// Lighting
	CreateInputTexture2D(TextureMetalness, Linear, 8, "", "_metal", "Lighting,30/Metalness,30/10", Default4(0, 0, 0, 0));
	CreateInputTexture2D(TextureRoughness, Linear, 8, "Inverse", "_rough", "Lighting,30/Roughness,20/10", Default4(0.5, 0.5, 0.5, 0));
	float g_fTextureRoughnessContrast < Default(1); Range(0, 4); UiType(Slider); UiGroup("Lighting/Roughness/11"); >;
	float g_fTextureRoughnessBrightness < Default(1); Range(0, 4); UiType(Slider); UiGroup("Lighting/Roughness/12"); >;
	bool g_bMaskRoughnessAdjustmentsByTintMask < UiType(CheckBox); UiGroup("Lighting/Roughness/13"); UiVisibility(F_TINT_MASK==1); >;
	
	// Normal Map
	CreateInputTexture2D(TextureNormal, Linear, 8, "NormalizeNormals", "_normal", "Normal Map,20", Default4(0.5, 0.5, 1, 0));
	float g_fTextureNormalContrast < Default(1); Range(-2, 2); UiType(Slider); UiGroup("Normal Map/100"); >;
	
	// Self Illum
	float g_flSelfIllumBrightness < Range(-10, 10); UiType(Slider); UiGroup("Self Illum"); >;
	CreateInputTexture2D(TextureSelfIllumMask, Srgb, 8, "", "_selfillum", "Self Illum/10", Default4(0, 0, 0, 0));
	float3 g_vSelfIllumTint < Default3(1, 1, 1); UiType(Color); UiGroup("Self Illum/20"); >;
	float g_flSelfIllumScale < Default(1); UiType(Slider); UiGroup("Self Illum/30"); >;
	float2 g_vSelfIllumScrollSpeed < Range2(-10, -10, 10, 10); UiType(VectorText); UiGroup("Self Illum/40"); >;
	float g_flSelfIllumAlbedoFactor < Default(1); UiType(Slider); UiGroup("Self Illum/50"); >;
	
	// Translucent
	CreateInputTexture2D(TextureTranslucency, Linear, 8, "", "_trans", "Translucent,15", Default4(1, 1, 1, 0));
	float g_flAlphaTestReference < Default(0.5); Range(0.01, 0.99); UiType(Slider); UiGroup("Translucent"); >;
	float g_flAntiAliasedEdgeStrength < Default(1); UiType(Slider); UiGroup("Translucent"); >;
	float g_flOpacityScale < Default(1); UiType(Slider); UiGroup("Translucent"); >;
	
	// Fog
	bool g_bFogEnabled < Default(1); UiType(CheckBox); UiGroup("Fog"); >;
	
	// Blend Effects
	float g_flBorderSpread1 < Default(0.1); Range(-1, 1); UiType(Slider); UiGroup("Blend Effects/Border,0/10"); >;
	float g_flBorderSoftness1 < Default(0.2); UiType(Slider); UiGroup("Blend Effects/Border/20"); Expression(max(.001,this)); >;
	float g_flBorderOffset1 < Range(-1, 1); UiType(Slider); UiGroup("Blend Effects/Border/30"); Expression(this*2); >;
	float g_fBorderRoughness1 < Default(0.5); UiType(Slider); UiGroup("Blend Effects/Border/35"); UiVisibility(F_BORDER_ROUGHNESS); >;
	float3 g_vBorderTint1 < Default3(1, 1, 1); UiType(Color); UiGroup("Blend Effects/Border/40"); Expression(SrgbGammaToLinear(this)); >;
	float g_flBevelSoftness1 < Default(0.1); UiType(Slider); UiGroup("Blend Effects/Bevel/60"); Expression(max(.001,this)); >;
	float g_flBevelSpread1 < Default(0.5); UiType(Slider); UiGroup("Blend Effects/Bevel/60"); >;
	float g_flBevelStrength1 < Default(0.2); Range(-1, 1); UiType(Slider); UiGroup("Blend Effects,4/Bevel,1/70"); >;
	float g_flBevelCurve1 < Default(0.5); UiType(Slider); UiGroup("Blend Effects/Bevel/80"); Expression(this*2); >;
	float g_flNormalStrengthUnderBevel1 < Default(1); UiType(Slider); UiGroup("Blend Effects/Bevel/100"); Expression(1-this); >;
	
	// Texture Address Mode
	int g_nTextureAddressModeU < UiOption("RsTextureAddressMode_t"); UiType(Enum); UiGroup("Texture Address Mode"); >;
	int g_nTextureAddressModeV < UiOption("RsTextureAddressMode_t"); UiType(Enum); UiGroup("Texture Address Mode"); >;
	
	#if (S_BLEND_MODE == 3)
		Texture2D g_tColor < Channel(RGB, ArtistDefinedOrAlphaWeighted(TextureColor, TextureTranslucency), Srgb); Channel(A, Box(TextureTranslucency), Linear); OutputFormat(BC7); SrgbRead(false); >;
	#endif
	#if (S_BLEND_MODE == 6)
		Texture2D g_tColor < Channel(RGB, ArtistDefinedOrAlphaWeighted(TextureColor, TextureTranslucency), Srgb); Channel(A, Box(TextureTranslucency), Linear); OutputFormat(BC7); SrgbRead(true); >;
	#endif
	#if (S_MATERIAL_REFERENCE == 1)
		Texture2D g_tSelfIllumMask < Channel(RGB, Box(TextureSelfIllumMask), Srgb); Channel(A, Box(TextureTranslucency), Linear); OutputFormat(BC7); SrgbRead(true); >;
	#endif
	#if (S_BLEND_EFFECTS == 1)
		Texture2D g_tSelfIllumMask < Channel(RGB, Box(TextureSelfIllumMask), Srgb); Channel(A, Box(TextureTranslucency), Linear); OutputFormat(BC7); SrgbRead(true); >;
	#endif
	
	// Variant parameters
	Texture2D g_tColor < Channel(RGB, ArtistDefined(TextureColor), Srgb); OutputFormat(DXT1); SrgbRead(true); >;
	Texture2D g_tColor < Channel(RGB, ArtistDefinedOrAlphaWeighted(TextureColor, TextureTranslucency), Srgb); Channel(A, PreserveCoverage(TextureTranslucency), Linear); OutputFormat(BC7); SrgbRead(true); >;
	Texture2D g_tColor1 < Channel(RGB, ArtistDefined(TextureColor1), Srgb); Channel(A, Box(TextureAmbientOcclusion1), Linear); OutputFormat(BC7); SrgbRead(true); >;
	Texture2D g_tColor1 < Channel(RGB, ArtistDefinedOrAlphaWeighted(TextureColor1, TextureTranslucency1), Srgb); Channel(A, PreserveCoverage(TextureTranslucency1), Linear); OutputFormat(BC7); SrgbRead(true); >;
	Texture2D g_tSelfIllumMask < Channel(RGB, Box(TextureSelfIllumMask), Srgb); OutputFormat(DXT1); SrgbRead(true); >;
	
	// SPIR-V reflection failed for backend HLSL:
	// cbuffer ID 5618 (name: _Globals_), member index 4 (name: g_mTextureColorAdjust) cannot be expressed with either HLSL packing layout or packoffset.
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
	
	float _2;
	vec4 _3;
	
	struct _193
	{
	    uint _m0;
	    vec4 _m1;
	    vec4 _m2;
	    vec4 _m3;
	    vec4 _m4;
	    vec4 _m5;
	    vec4 _m6;
	    mat4 _m7;
	    vec4 _m8;
	    vec4 _m9;
	    vec4 _m10;
	};
	
	layout(set = 1) uniform _193 PerViewConstantBufferCsgo_t;
	
	struct _1579
	{
	    uint g_sTrilinearClamp;
	    uint g_sUserConfigAllowGlobalMipBias;
	    int g_bFogEnabled;
	    uint g_tColor;
	    mat4 g_mTextureColorAdjust;
	};
	
	layout(set = 1) uniform _1579 _Globals_;
	
	struct _1007
	{
	    vec3 _m0;
	};
	
	layout(set = 1) uniform _1007 PerViewConstantBuffer_t;
	
	layout(set = 4, binding = 46) uniform texture2D g_bindless_Texture2D_float4[65536];
	layout(set = 4, binding = 29) uniform sampler g_bindless_Sampler[2048];
	layout(set = 4, binding = 46) uniform textureCube g_bindless_TextureCube_float4[65536];
	
	layout(location = 3) in vec3 input_3;
	layout(location = 5) in vec4 input_5;
	layout(location = 6) centroid in vec4 input_6;
	layout(location = 0) out vec4 output_0;
	
	void main()
	{
	    vec3 _10829 = input_3 + PerViewConstantBufferCsgo_t._m10.xyz;
	    vec4 _19391 = texture(sampler2D(g_bindless_Texture2D_float4[_Globals_.g_tColor], g_bindless_Sampler[_Globals_.g_sUserConfigAllowGlobalMipBias]), input_5.xy);
	    vec4 _18900;
	    _18900.x = _19391.x;
	    _18900.y = _19391.y;
	    _18900.z = _19391.z;
	    vec3 _9388 = (vec4((vec4(_18900.xyz, 1.0) * _Globals_.g_mTextureColorAdjust).xyz, _2).xyz * input_6.xyz).xyz * 1.0;
	    float _16847 = _9388.x;
	    vec4 _11203 = vec4(_16847, _9388.yz, input_6.w);
	    _11203.x = _16847;
	    _11203.y = _9388.y;
	    _11203.z = _9388.z;
	    vec4 _6805;
	    if (_Globals_.g_bFogEnabled != 0)
	    {
	        vec3 _21493;
	        vec3 _10666 = _10829.xyz - PerViewConstantBuffer_t._m0.xyz;
	        vec3 _9057 = _10666.xyz;
	        vec3 _19340;
	        do
	        {
	            _21493 = _10666.xyz;
	            bool _12885;
	            if (dot(_21493, _21493) > PerViewConstantBufferCsgo_t._m4.x)
	            {
	                _12885 = (_10829.z * PerViewConstantBufferCsgo_t._m4.z) < PerViewConstantBufferCsgo_t._m4.y;
	            }
	            else
	            {
	                _12885 = false;
	            }
	            SPIRV_CROSS_BRANCH
	            if (_12885)
	            {
	                vec2 _9342 = saturate(PerViewConstantBufferCsgo_t._m1.xy + (PerViewConstantBufferCsgo_t._m1.zw * vec2(length(_21493), _10829.z)));
	                float _12872 = (pow(_9342.x, PerViewConstantBufferCsgo_t._m2.x) * pow(_9342.y, PerViewConstantBufferCsgo_t._m2.y)) * PerViewConstantBufferCsgo_t._m3.w;
	                _19340 = mix(_11203.xyz, vec4(PerViewConstantBufferCsgo_t._m3.xyz, _12872).xyz, vec3(_12872));
	                break;
	            }
	            _19340 = _11203.xyz;
	            break;
	        } while(false);
	        vec4 _23944 = _11203;
	        _23944.x = _19340.x;
	        _23944.y = _19340.y;
	        _23944.z = _19340.z;
	        vec3 _19341;
	        do
	        {
	            bool _12886;
	            if (dot(_9057, _9057) > PerViewConstantBufferCsgo_t._m8.x)
	            {
	                _12886 = (PerViewConstantBufferCsgo_t._m8.z * _10829.z) < PerViewConstantBufferCsgo_t._m8.y;
	            }
	            else
	            {
	                _12886 = false;
	            }
	            if (_12886)
	            {
	                float _14602 = saturate(pow(max(0.0, (length(_21493) * PerViewConstantBufferCsgo_t._m5.y) + PerViewConstantBufferCsgo_t._m5.x), PerViewConstantBufferCsgo_t._m5.w)) * saturate(pow(max(0.0, (_10829.z * PerViewConstantBufferCsgo_t._m6.y) + PerViewConstantBufferCsgo_t._m6.x), PerViewConstantBufferCsgo_t._m6.z));
	                float _8892 = saturate(_14602) * PerViewConstantBufferCsgo_t._m8.w;
	                _19341 = mix(_23944.xyz, vec4((textureLod(samplerCube(g_bindless_TextureCube_float4[PerViewConstantBufferCsgo_t._m0], g_bindless_Sampler[_Globals_.g_sTrilinearClamp]), normalize((PerViewConstantBufferCsgo_t._m7 * vec4(_9057, 0.0)).xyz).xyz, PerViewConstantBufferCsgo_t._m6.w * saturate(1.0 - (_14602 * PerViewConstantBufferCsgo_t._m5.z))) * PerViewConstantBufferCsgo_t._m9.x).xyz, _8892).xyz, vec3(_8892));
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
	        _6805 = _11203;
	    }
	    output_0 = _6805;
	}
	
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
	
	BoolAttribute(BindlessResources, true);
	BoolAttribute(SupportsLightmapping, true);
	BoolAttribute(PerVertexLighting, true);
	BoolAttribute(AllowBackfaceCulling, true);
	BoolAttribute(overlay, true);
	BoolAttribute(DoNotCastShadows, F_DO_NOT_CAST_SHADOWS ? 1 : 0);
	BoolAttribute(SupportsMappingDimensions, true);
	BoolAttribute(renderbackfaces, F_RENDER_BACKFACES ? 1 : 0);
	
	#if (S_MATERIAL_REFERENCE == 0)
		TextureAttribute(LightSim_DiffuseAlbedoTexture, g_tColor);
		TextureAttribute(RepresentativeTexture, g_tColor);
	#endif
	#if (S_BLEND_MODE == 0)
		BoolAttribute(NoZPrepass, F_DISABLE_Z_PREPASS ? 1 : 0);
	#endif
	#if (S_LIT == 0)
		BoolAttribute(unlit, true);
		TextureAttribute(LightSim_DiffuseAlbedoTexture, g_tColor);
		TextureAttribute(RepresentativeTexture, g_tColor);
	#endif
	#if (S_SHADER_QUALITY == 1)
		BoolAttribute(environmentmapped, true);
		BoolAttribute(environmentmappeddynamic, true);
	#endif
	#if (S_SHADER_QUALITY == 0)
		TextureAttribute(LightSim_TintMaskTextureR, g_tTintMask);
		TextureAttribute(LightSim_DiffuseAlbedoTexture, g_tColor);
		TextureAttribute(RepresentativeTexture, g_tColor);
	#endif
	#if (S_TINT_MASK == 0)
		BoolAttribute(environmentmapped, true);
		BoolAttribute(environmentmappeddynamic, true);
	#endif
	#if (S_TINT_MASK == 1)
		TextureAttribute(LightSim_TintMaskTextureR, g_tTintMask);
		TextureAttribute(LightSim_DiffuseAlbedoTexture, g_tColor);
		TextureAttribute(RepresentativeTexture, g_tColor);
	#endif
	#if (S_BLEND_MODE == 1)
		BoolAttribute(translucent, true);
		BoolAttribute(NoZPrepass, F_DISABLE_Z_PREPASS ? 1 : 0);
	#endif
	#if (S_BLEND_MODE == 2)
		BoolAttribute(alphatest, true);
		FloatAttribute(_dummyReferenceAlphaTestReferenceInMainShader, g_flAlphaTestReference);
		FloatAttribute(_dummyReferenceAntiAliasedEdgeStrengthReferenceInMainShader, g_flAntiAliasedEdgeStrength);
		BoolAttribute(NoZPrepass, true);
	#endif
	#if (S_LIT == 1)
		BoolAttribute(environmentmapped, true);
		BoolAttribute(environmentmappeddynamic, true);
		BoolAttribute(NeedsLightProbe, true);
		TextureAttribute(LightSim_SelfIllumMaskTexture, g_tSelfIllumMask);
		Float3Attribute(LightSim_SelfIllumTint, g_vSelfIllumTint);
		FloatAttribute(LightSim_SelfIllumScale, g_flSelfIllumScale);
	#endif
	#if (S_MATERIAL_REFERENCE == 1)
		IntAttribute(MaterialLayerCount, 1);
		BoolAttribute(VertexPaintUIAlphaBlendFactor, true);
		StringAttribute(MaterialLayerRefType, csgo_environment);
		BoolAttribute(GroupDefaultCollapseState_TextureTransform, true);
		BoolAttribute(GroupDefaultCollapseState_DetailTextureTransform, true);
		BoolAttribute(HasTexcoordTransform, (g_nUVSet1>0 && (g_vTexCoordScale1.x!=1 || g_vTexCoordScale1.y!=1 || g_flTexCoordRotation1!=0)) ? 1 : 0);
		BoolAttribute(environmentmapped, true);
		BoolAttribute(environmentmappeddynamic, true);
		BoolAttribute(NeedsLightProbe, true);
		TextureAttribute(LightSim_SelfIllumMaskTexture, g_tSelfIllumMask);
		Float3Attribute(LightSim_SelfIllumTint, g_vSelfIllumTint);
		FloatAttribute(LightSim_SelfIllumScale, g_flSelfIllumScale);
	#endif
	#if (S_BLEND_EFFECTS == 1)
		IntAttribute(MaterialLayerCount, 1);
		BoolAttribute(VertexPaintUIAlphaBlendFactor, true);
		StringAttribute(MaterialLayerRefType, csgo_environment);
		BoolAttribute(GroupDefaultCollapseState_TextureTransform, true);
		BoolAttribute(GroupDefaultCollapseState_DetailTextureTransform, true);
		BoolAttribute(HasTexcoordTransform, (g_nUVSet1>0 && (g_vTexCoordScale1.x!=1 || g_vTexCoordScale1.y!=1 || g_flTexCoordRotation1!=0)) ? 1 : 0);
		BoolAttribute(environmentmapped, true);
		BoolAttribute(environmentmappeddynamic, true);
		BoolAttribute(NeedsLightProbe, true);
		TextureAttribute(LightSim_SelfIllumMaskTexture, g_tSelfIllumMask);
		Float3Attribute(LightSim_SelfIllumTint, g_vSelfIllumTint);
		FloatAttribute(LightSim_SelfIllumScale, g_flSelfIllumScale);
	#endif
	#if (S_MODE_TOOLS_VIS == 0)
		TextureAttribute(LightSim_TintMaskTextureR, g_tTintMask);
		TextureAttribute(LightSim_DiffuseAlbedoTexture, g_tColor);
		TextureAttribute(RepresentativeTexture, g_tColor);
	#endif
	#if (S_BLEND_EFFECTS == 0)
		BoolAttribute(environmentmapped, true);
		BoolAttribute(environmentmappeddynamic, true);
	#endif
	#if (S_MODE_TOOLS_VIS == 1)
		BoolAttribute(environmentmapped, true);
		BoolAttribute(environmentmappeddynamic, true);
	#endif
	
	// PSRS
	
	RenderState(BackStencilFunc, F_RENDER_BACKFACES ? NotEqual : Always);
	RenderState(BlendEnable, true);
	RenderState(CullMode, F_RENDER_BACKFACES ? None : Front);
	RenderState(CullMode, F_RENDER_BACKFACES ? None : Back);
	RenderState(DepthBias, -64);
	RenderState(DepthBiasClamp, 0);
	RenderState(DepthWriteEnable, false);
	RenderState(DstBlend, (F_BLEND_MODE==3) ? One : InvSrcAlpha);
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
	
	#if (S_MATERIAL_REFERENCE == 1)
		IntAttribute(MaterialLayerCount, 1);
	#endif
	#if (S_LIT == 1)
		IntAttribute(MaterialLayerCount, 1);
	#endif
}
