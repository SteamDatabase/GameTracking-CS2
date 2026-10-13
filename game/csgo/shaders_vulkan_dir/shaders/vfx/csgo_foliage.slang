//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Foliage Shader";
	DevShader = false;
	Version = 9;
	
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
	ToolsShadingComplexity(S_MODE_TOOLS_SHADING_COMPLEXITY);
}

FEATURES
{
	Feature( F_DO_NOT_CAST_SHADOWS, 0..1, "Shadows" );
	Feature( F_RENDER_BACKFACES, 0..1, "2-Sided Rendering" );
	Feature( F_DONT_FLIP_BACKFACE_NORMALS, 0..1, "2-Sided Rendering" );
	Feature( F_DISABLE_Z_BUFFERING, 0..1, "Z-Buffering" );
	Feature( F_DISABLE_Z_PREPASS, 0..1, "Z-Prepass" );
	Feature( F_ALPHA_TEST, 0..1, "Translucent" );
	Feature( F_TINT_MASK, 0..1, "Per-Instance Tint Mask" );
	Feature( F_VERTEX_ANIMATION, 0..2 (0="None", 1="Simple", 2="Advanced"), "Vertex Animation" );
	Feature( F_FOLIAGE_ANIMATION, 0..1, "Foliage Animation" );
	Feature( F_FOLIAGE_UV_ANIMATION, 0..1, "Foliage Animation" );
	Feature( F_TRANSMISSIVE_BACKFACE_NDOTL, 0..1, "PBR" );
	Feature( F_USE_ALBEDO_FOR_TRANSMISSIVE, 0..1, "PBR" );
	Feature( F_DISABLE_TRANSMISSIVE_SHADOWS, 0..1, "PBR" );
	Feature( F_ANIMATED_SHADOWS, 0..1, "Shadows" );
	FeatureRule( Requires( F_DONT_FLIP_BACKFACE_NORMALS, F_RENDER_BACKFACES ), "Only applies to backfaces" );
	FeatureRule( Requires( F_FOLIAGE_UV_ANIMATION, F_ALPHA_TEST ), "Foliage UV Animation requires alpha test" );
	FeatureRule( ChildOf( F_USE_ALBEDO_FOR_TRANSMISSIVE, F_TRANSMISSIVE_BACKFACE_NDOTL ), "Use Albedo for Transmissive requires Transmissive Backface Ndotl" );
	FeatureRule( ChildOf( F_DISABLE_TRANSMISSIVE_SHADOWS, F_TRANSMISSIVE_BACKFACE_NDOTL ), "Disable Transmissive Shadows requires Transmissive Backface Ndotl" );
	FeatureRule( Allow1( F_FOLIAGE_ANIMATION, F_VERTEX_ANIMATION ), "Foliage Animation and Vertex Animation are not compatible" );
	FeatureRule( Requires( F_ANIMATED_SHADOWS, F_VERTEX_ANIMATION, F_DO_NOT_CAST_SHADOWS==0 ), "Fully Animated shadows requires vertex animation and shadows" );
}

COMMON
{
	#include "system.fxc"
}

struct VS_INPUT
{
	float4 vBlendIndices              : BLENDINDICES0  < Semantic( BlendIndices ); >;              // D_CS_VERTEX_ANIMATION=0
	float4 vBlendColorTint            : COLOR0         < Semantic( Color ); >;                    
	float4 vPerVertexLighting         : COLOR1         < Semantic( PerVertexLighting ); >;         // D_BAKED_LIGHTING_FROM_VERTEX_STREAM=1
	uint4  nPackedFrame               : NORMAL0        < Semantic( CompressedTangentFrame ); >;   
	float4 vNormalOs                  : NORMAL0        < Semantic( Normal ); >;                   
	float3 vPositionOs                : POSITION0      < Semantic( PosXyz ); >;                    // D_CS_VERTEX_ANIMATION=0, S_FOLIAGE_UV_ANIMATION=1
	float4 vPivotPaint                : TEXCOORD4      < Semantic( PivotPaint ); >;               
	float4 vFoliageParams             : TEXCOORD5      < Semantic( FoliageAnimation ); >;         
	float2 vLightmapUV                : TEXCOORD3      < Semantic( LightmapUV ); >;                // D_BAKED_LIGHTING_FROM_LIGHTMAP=1
	float4 vTangentUOs_flTangentVSign : TANGENT0       < Semantic( TangentU_SignV ); >;           
	float2 vTexCoord                  : TEXCOORD0      < Semantic( LowPrecisionUv ); >;           
	float2 nInstanceIdx               : TEXCOORD13     < Semantic( InstanceTransformUv ); >;      
};

VS
{
	StaticCombo( S_FOLIAGE_UV_ANIMATION, F_FOLIAGE_UV_ANIMATION );
	StaticCombo( S_MODE_DEPTH, 0..1 );
	StaticCombo( S_ANIMATED_SHADOWS, F_ANIMATED_SHADOWS );
	StaticCombo( S_VERTEX_ANIMATION, F_VERTEX_ANIMATION );
	StaticCombo( S_FOLIAGE_ANIMATION, F_FOLIAGE_ANIMATION );
	StaticCombo( S_MODE_TOOLS_VIS, 0..1 );
	StaticComboRule( Allow1( S_FOLIAGE_ANIMATION, S_VERTEX_ANIMATION ) );
	DynamicCombo( D_COMPRESSED_NORMALS_AND_TANGENTS, 0..1 );
	DynamicCombo( D_CS_VERTEX_ANIMATION, 0..1 );
	DynamicCombo( D_BAKED_LIGHTING_FROM_VERTEX_STREAM, 0..1 );
	DynamicCombo( D_BAKED_LIGHTING_FROM_LIGHTMAP, 0..1 );
	DynamicComboRule( Allow1( D_BAKED_LIGHTING_FROM_VERTEX_STREAM, D_BAKED_LIGHTING_FROM_LIGHTMAP ) );
	
	ByteAddressBuffer g_animatedVertexCache < Attribute("AnimatedVertexCache"); >;
	[[layer_constant]] ExternalDescriptorSet g_globalLateBoundBindlessSet < Source(ExternalDescSet); Attribute("g_globalLateBoundBindlessSet"); >;
	[[layer_constant]] StructuredBuffer g_instanceBuffer < Attribute("InstanceBuffer"); >;
	[[layer_constant]] ExternalDescriptorSet g_lightBinnerGpuSet < Source(ExternalDescSet); Attribute("g_lightBinnerGpuSet"); >;
	Texture3D g_tNoiseMap < Channel(RGB, Box(NoiseMap), Linear); OutputFormat(RGBA8888); SrgbRead(false); >;
	[[layer_constant]] StructuredBuffer g_transformBuffer < Attribute("TransformBuffer"); >;
	float4 g_vTexCoordXform0 < UiType(VectorText); Expression(v0 = 0*3.14159/180;
		v1 = cos(v0);
		v2 = sin(v0);
		float4(v1*float2(1,1).x,-v2*float2(1,1).y,0,float2(.5,.5).x+float2(0,0).x+v2*float2(.5,.5).y-v1*float2(.5,.5).x)); >;
	float4 g_vTexCoordXform1 < UiType(VectorText); Expression(v0 = 0*3.14159/180;
		v1 = cos(v0);
		v2 = sin(v0);
		float4(v2*float2(1,1).x,v1*float2(1,1).y,0,float2(.5,.5).y+float2(0,0).y-(v2*float2(.5,.5).x+v1*float2(.5,.5).y))); >;
	
	// Vertex Noise
	CreateInputTexture2D(NoiseMap, Linear, 8, "", "", "Vertex Noise,15/10", "materials/default/effects/noise/perlin_a_z000.tga");
	
	// Foliage Animation
	float g_flFrondTipStrength < Default(2); Range(0, 25); UiType(Slider); UiGroup("Foliage Animation,15/Frond Tip Anim (Red Channel),40/10"); >;
	bool g_bBranchMotionPerpendicular < Default(1); UiType(CheckBox); UiGroup("Foliage Animation,15/Branch Animation,40/13"); >;
	bool g_bFrondTipUseEnvWind < UiType(CheckBox); UiGroup("Foliage Animation,15/Frond Tip Anim (Red Channel),40/13"); >;
	bool g_bSmootherNoiseBranchAndTrunk < Default(1); UiType(CheckBox); UiGroup("Foliage Animation,15/Common Noise Parameters,40/13"); >;
	float g_flBranchAnimSpeed < Default(1); Range(0, 4); UiType(Slider); UiGroup("Foliage Animation,15/Branch Animation,40/13"); >;
	float g_flBranchDeflection < UiType(Slider); UiGroup("Foliage Animation,15/Branch Animation,40/13"); >;
	float g_flBranchDeflectionEnd < Default(150); Range(0.001, 1000); UiType(Slider); UiGroup("Foliage Animation,15/Branch Animation,40/13"); >;
	float g_flBranchDeflectionStart < Range(0, 1000); UiType(Slider); UiGroup("Foliage Animation,15/Branch Animation,40/13"); >;
	float g_flBranchNoiseLevel < Default(0.5); UiType(Slider); UiGroup("Foliage Animation,15/Branch Animation,40/13"); >;
	float g_flFrondTipAnimSpeed < Default(1); Range(0, 4); UiType(Slider); UiGroup("Foliage Animation,15/Frond Tip Anim (Red Channel),40/13"); >;
	float g_flFrondTipMaskFalloff < Default(1); Range(1, 5); UiType(Slider); UiGroup("Foliage Animation,15/Frond Tip Anim (Red Channel),40/13"); >;
	float g_flFrondTipSpatialIncoherence < Default(1); Range(0, 10); UiType(Slider); UiGroup("Foliage Animation,15/Frond Tip Anim (Red Channel),40/13"); >;
	float g_flTrunkAnimSpeed < Default(1); Range(0, 4); UiType(Slider); UiGroup("Foliage Animation,15/Trunk Animation,40/13"); >;
	float g_flTrunkDeflection < UiType(Slider); UiGroup("Foliage Animation/Trunk Animation,40/13"); >;
	float g_flTrunkDeflectionEnd < Default(300); Range(-1000, 1000); UiType(Slider); UiGroup("Foliage Animation/Trunk Animation,40/13"); >;
	float g_flTrunkDeflectionStart < Range(-1000, 1000); UiType(Slider); UiGroup("Foliage Animation/Trunk Animation,40/13"); >;
	float g_flTrunkNoiseLevel < Default(0.5); UiType(Slider); UiGroup("Foliage Animation,15/Trunk Animation,40/13"); >;
	float3 g_vNoiseUvScale < Default3(1, 1, 1); Range3(0, 0, 0, 5, 5, 5); UiType(VectorText); UiGroup("Foliage Animation,15/Common Noise Parameters,40/13"); >;
	float3 g_vNoiseUvSpeed < Default3(0.25, 0.25, 0.25); Range3(-1, -1, -1, 1, 1, 1); UiType(VectorText); UiGroup("Foliage Animation,15/Common Noise Parameters,40/13"); >;
	
	// Vertex Animation
	bool g_bUseEnvWind < UiType(CheckBox); UiGroup("Vertex Animation,15/Use Env Wind,43/10"); >;
	float g_flFlutterAmount < Default(0.25); UiType(Slider); UiGroup("Vertex Animation,15/Flutter (Blue Channel),41/10"); >;
	float g_flNoise1Strength < Range(0, 150); UiType(Slider); UiGroup("Vertex Animation,15/Noise 1 (Red Channel),40/10"); >;
	float g_flNoise2Strength < Range(0, 150); UiType(Slider); UiGroup("Vertex Animation,15/Noise 2 (Blue Channel),41/10"); >;
	float g_flSwayAmount < Default(0.25); Range(0, 2); UiType(Slider); UiGroup("Vertex Animation,15/Sway (Red Channel),40/10"); >;
	float g_flFlutterSpeed < Default(1); Range(0, 2); UiType(Slider); UiGroup("Vertex Animation,15/Flutter (Blue Channel),41/11"); >;
	float g_flSwaySpeed < Default(1); Range(0, 2); UiType(Slider); UiGroup("Vertex Animation,15/Sway (Red Channel),40/11"); >;
	float3 g_vNoise1Speed < Range3(-1, -1, -1, 1, 1, 1); UiType(VectorText); UiGroup("Vertex Animation,15/Noise 1 (Red Channel),40/11"); >;
	float3 g_vNoise2Speed < Range3(-1, -1, -1, 1, 1, 1); UiType(VectorText); UiGroup("Vertex Animation,15/Noise 2 (Blue Channel),41/11"); >;
	float g_flFlutterNoiseScale < Default(1); Range(0, 2); UiType(Slider); UiGroup("Vertex Animation,15/Flutter (Blue Channel),41/12"); >;
	float g_flSwayNoiseScale < Default(1); Range(0, 2); UiType(Slider); UiGroup("Vertex Animation,15/Sway (Red Channel),40/12"); >;
	float3 g_vNoise1Scale < Range3(0, 0, 0, 5, 5, 5); UiType(VectorText); UiGroup("Vertex Animation,15/Noise 1 (Red Channel),40/12"); >;
	float3 g_vNoise2Scale < Range3(0, 0, 0, 5, 5, 5); UiType(VectorText); UiGroup("Vertex Animation,15/Noise 2 (Blue Channel),41/12"); >;
	float g_flFlutterFalloff < Default(1); Range(1, 5); UiType(Slider); UiGroup("Vertex Animation,15/Flutter (Blue Channel),41/13"); >;
	float g_flNoise1MaskFalloff < Default(1); Range(1, 5); UiType(Slider); UiGroup("Vertex Animation,15/Noise 1 (Red Channel),40/13"); >;
	float g_flNoise2MaskFalloff < Default(1); Range(1, 5); UiType(Slider); UiGroup("Vertex Animation,15/Noise 2 (Blue Channel),41/13"); >;
	float g_flSwayFalloff < Default(1); Range(1, 5); UiType(Slider); UiGroup("Vertex Animation,15/Sway (Red Channel),40/13"); >;
	
	// Color
	float3 g_vColorTint < Default3(1, 1, 1); UiType(Color); UiGroup("Color,10/20"); Expression(SrgbGammaToLinear(this)); >;
	float g_flModelTintAmount < Default(1); UiType(Slider); UiGroup("Color,10/30"); >;
	float2 g_vTexCoordScrollSpeed < Range2(-10, -10, 10, 10); UiType(VectorText); UiGroup("Color/70"); >;
	
	// Foliage UV Animation
	float g_flSpatialIncoherence < Default(0.1); UiType(Slider); UiGroup("Foliage UV Animation"); >;
	
	// SPIR-V reflection failed for backend HLSL:
	// cbuffer ID 5618 (name: _Globals_), member index 3 (name: g_vColorTint) cannot be expressed with either HLSL packing layout or packoffset.
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
	layout(location = 6) in vec4 vBlendColorTint;
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
	    vec4 _7227 = vTexCoord.xyxy;
	    _7227.x = dot(vTexCoord.xy, _Globals_.g_vTexCoordXform0.xy) + _Globals_.g_vTexCoordXform0.w;
	    _7227.y = dot(vTexCoord.xy, _Globals_.g_vTexCoordXform1.xy) + _Globals_.g_vTexCoordXform1.w;
	    vec2 _22490 = _7227.xy + (_Globals_.g_vTexCoordScrollSpeed.xy * PerViewConstantBuffer_t._m1);
	    vec4 _20488 = _7227;
	    _20488.x = _22490.x;
	    _20488.y = _22490.y;
	    vec4 _11399 = vec4(mix(vec3(1.0), vec4(_21354, _21355, _17978, _7654).xyz, vec3(_Globals_.g_flModelTintAmount)), _7654 * g_instanceBuffer_1._m0[nInstanceIdx]._m7);
	    vec3 _13062 = _11399.xyz * _Globals_.g_vColorTint.xyz;
	    vec4 _23714 = _11399;
	    _23714.x = _13062.x;
	    _23714.y = _13062.y;
	    _23714.z = _13062.z;
	    vec4 _17895 = (vec4(_12151.xyz, 1.0) + (PerViewConstantBuffer_t._m2 * 1.0)).xyzw * PerViewConstantBuffer_t._m0;
	    output_0 = vBlendColorTint;
	    output_1 = _12151.xyz - PerViewConstantBufferCsgo_t._m0.xyz;
	    output_2 = _11179;
	    output_3 = _20488;
	    output_4 = _23714;
	    output_5 = _11179;
	    output_6 = vec4(normalize(vec4(vTangentUOs_flTangentVSign.xyz, 0.0) * g_transformBuffer_1._m0[_21785]._m0), vTangentUOs_flTangentVSign.w);
	    output_7 = g_instanceBuffer_1._m0[nInstanceIdx]._m5 & 65535u;
	    _17895.y = -_17895.y;
	    gl_Position = _17895;
	}
	
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
	
	BoolAttribute(BindlessResources, true);
	BoolAttribute(DoNotRenderIntoSST, F_ANIMATED_SHADOWS);
	BoolAttribute(environmentmapped, true);
	BoolAttribute(environmentmappeddynamic, true);
	BoolAttribute(CanBatchWithDynamicShaderConstants, true);
	Float3Attribute(LightSim_MaterialTint, g_vColorTint);
	
	#if (S_VERTEX_ANIMATION == 0)
		BoolAttribute(NeedsLocalSpaceVertices, true);
	#endif
	#if (S_FOLIAGE_ANIMATION == 1)
		BoolAttribute(NeedsLocalSpaceVertices, true);
	#endif
}

PS
{
	StaticCombo( S_FOLIAGE_UV_ANIMATION, F_FOLIAGE_UV_ANIMATION );
	StaticCombo( S_MODE_DEPTH, 0..1 );
	StaticCombo( S_ANIMATED_SHADOWS, F_ANIMATED_SHADOWS );
	StaticCombo( S_ALPHA_TEST, F_ALPHA_TEST );
	StaticCombo( S_TINT_MASK, F_TINT_MASK );
	StaticCombo( S_TRANSMISSIVE_BACKFACE_NDOTL, F_TRANSMISSIVE_BACKFACE_NDOTL );
	StaticCombo( S_VERTEX_ANIMATION, F_VERTEX_ANIMATION );
	StaticCombo( S_MODE_TOOLS_SHADING_COMPLEXITY, 0..1 );
	StaticCombo( S_SHADER_QUALITY, 0..1 );
	StaticCombo( S_MODE_TOOLS_VIS, 0..1 );
	StaticComboRule( Allow1( S_MODE_DEPTH, S_TINT_MASK ) );
	StaticComboRule( Allow1( S_MODE_DEPTH, S_TRANSMISSIVE_BACKFACE_NDOTL ) );
	StaticComboRule( Allow1( S_MODE_TOOLS_SHADING_COMPLEXITY, S_TINT_MASK ) );
	StaticComboRule( Allow1( S_MODE_TOOLS_SHADING_COMPLEXITY, S_TRANSMISSIVE_BACKFACE_NDOTL ) );
	StaticComboRule( Allow1( S_MODE_TOOLS_SHADING_COMPLEXITY, S_VERTEX_ANIMATION ) );
	StaticComboRule( Allow1( S_MODE_DEPTH, S_SHADER_QUALITY ) );
	StaticComboRule( Allow1( S_MODE_TOOLS_VIS ) );
	StaticComboRule( Requires( S_MODE_TOOLS_VIS, S_SHADER_QUALITY ) );
	StaticComboRule( Requires( S_FOLIAGE_UV_ANIMATION, S_ALPHA_TEST ) );
	DynamicCombo( D_ALPHA_TEST_PREPASS, 0..1 );
	DynamicCombo( D_QUAD_OVERDRAW, 0..1 );
	DynamicCombo( D_OPAQUE_FADE, 0..1 );
	DynamicCombo( D_SPECULAR_CUBE_MAP_STATIC, 0..1 );
	DynamicCombo( D_BAKED_LIGHTING_FROM_VERTEX_STREAM, 0..1 );
	DynamicCombo( D_BAKED_LIGHTING_FROM_PROBE, 0..1 );
	DynamicCombo( D_BAKED_LIGHTING_FROM_LIGHTMAP, 0..1 );
	DynamicComboRule( Requires( D_ALPHA_TEST_PREPASS, S_ALPHA_TEST ) );
	DynamicComboRule( Requires( D_QUAD_OVERDRAW, S_MODE_TOOLS_SHADING_COMPLEXITY ) );
	DynamicComboRule( Requires( D_SPECULAR_CUBE_MAP_STATIC, S_SHADER_QUALITY ) );
	DynamicComboRule( Allow1( D_BAKED_LIGHTING_FROM_PROBE, D_BAKED_LIGHTING_FROM_VERTEX_STREAM, D_BAKED_LIGHTING_FROM_LIGHTMAP ) );
	
	[[layer_constant]] StructuredBuffer g_BarnLights < Attribute("BarnLights"); >;
	[[layer_constant]] StructuredBuffer g_CullBits < Attribute("CullBits"); >;
	bool g_bAdjustBaseColor < UiType(CheckBox); Expression(g_nColorCorrectionMode==1); >;
	bool g_bCubemapNormalization < Attribute("g_bCubemapNormalization"); UiType(CheckBox); >;
	bool g_bDisableNormalMapping < Attribute("g_bDisableNormalMapping"); UiType(CheckBox); >;
	bool g_bDontFlipBackfaceNormals < UiType(CheckBox); Expression(F_DONT_FLIP_BACKFACE_NORMALS ? 1 : 0); >;
	bool g_bHighlightDeprecated < Attribute("g_bHighlightDeprecated"); UiType(CheckBox); >;
	bool g_bIsDeprecated < Attribute("bIsDeprecated"); UiType(CheckBox); >;
	bool g_bRenderBackfaceNormals < UiType(CheckBox); Expression((F_RENDER_BACKFACES ? 1 : 0) ? 1 : 0); >;
	bool g_bRenderingToCubemaps < Attribute("g_bRenderingToCubemaps"); UiType(CheckBox); >;
	bool g_bShowLPVVoxels < Attribute("g_bShowLPVVoxels"); UiType(CheckBox); >;
	bool g_bShowLightmapTexels < Attribute("g_bShowLightmapTexels"); UiType(CheckBox); >;
	bool g_bTransmissiveShadows < UiType(CheckBox); Expression(F_DISABLE_TRANSMISSIVE_SHADOWS ? 0 : 1); >;
	bool g_bUseAlbedoForTransmissive < UiType(CheckBox); Expression(F_USE_ALBEDO_FOR_TRANSMISSIVE ? 1 : 0); >;
	float g_fToolsVisHeightTint < Default(0.9); Attribute("g_fToolsVisHeightTint"); UiType(Slider); >;
	float g_fToolsVisMaxHeightRange < Default(1); Attribute("g_fToolsVisMaxHeightRange"); UiType(Slider); >;
	float g_fToolsVisMaxLightingComplexity < Default(8); Attribute("g_fToolsVisMaxLightingComplexity"); UiType(Slider); >;
	float g_flReflectance < UiType(Slider); Expression(pow((1.5-1)/(1.5+1),2)); >;
	[[layer_constant]] ExternalDescriptorSet g_globalLateBoundBindlessSet < Source(ExternalDescSet); Attribute("g_globalLateBoundBindlessSet"); >;
	[[layer_constant]] ExternalDescriptorSet g_lightBinnerGpuSet < Source(ExternalDescSet); Attribute("g_lightBinnerGpuSet"); >;
	float4x4 g_mTextureAdjust < Expression(MatrixMultiply(MatrixColorTint2(float3(1,1,1),1),MatrixColorCorrect2(float3(g_fTextureColorContrast,g_fTextureColorSaturation,g_fTextureColorBrightness),TextureAverageColor(g_tColor)))); >;
	float4x4 g_mTextureColorAdjust < Expression(MatrixMultiply(MatrixColorTint2(g_vTextureColorCorrectionTint,1),MatrixColorCorrect2(float3(g_fTextureColorContrast,g_fTextureColorSaturation,g_fTextureColorBrightness),TextureAverageColor(g_tColor)))); >;
	float4x4 g_mTransmissiveTextureAdjust < Expression(MatrixMultiply(MatrixColorTint2(float3(1,1,1),1),MatrixColorCorrect2(float3(g_fTextureColorContrast,g_fTextureColorSaturation,g_fTextureColorBrightness),TextureAverageColor(g_tTransmissiveColor)))); >;
	float4x4 g_mTransmissiveTextureColorAdjust < Expression(MatrixMultiply(MatrixColorTint2(g_vTextureColorCorrectionTint,1),MatrixColorCorrect2(float3(g_fTextureColorContrast,g_fTextureColorSaturation,g_fTextureColorBrightness),TextureAverageColor(g_tTransmissiveColor)))); >;
	int g_nToolsVisMode < Attribute("g_nToolsVisMode"); UiType(Slider); >;
	Texture2D g_tAmbientOcclusion < Channel(R, Box3(TextureAmbientOcclusion), Linear); OutputFormat(ATI1N); SrgbRead(false); >;
	Texture2D g_tColor < Channel(RGB, ArtistDefined(TextureColor), Srgb); OutputFormat(DXT1); SrgbRead(true); >;
	Texture2D g_tColor < Channel(RGB, ArtistDefinedOrAlphaWeighted(TextureColor, TextureTranslucency), Srgb); Channel(A, PreserveCoverage(TextureTranslucency), Linear); OutputFormat(BC7); SrgbRead(true); >;
	Texture2D g_tNormal < Channel(RGBA, HemiOctIsoRoughness_RG_B(TextureNormal, TextureRoughness), Linear); OutputFormat(BC7); SrgbRead(false); >;
	RWTexture2D<float4> g_tQuadOverdrawMutexUAV < Attribute("QuadOverdrawMutexUAV"); >;
	RWTexture2D<float4> g_tQuadOverdrawUAV < Attribute("QuadOverdrawUAV"); >;
	Texture2D g_tTintMask < Channel(R, Box(TextureTintMask), Linear); OutputFormat(ATI1N); SrgbRead(false); >;
	Texture2D g_tTransmissiveColor < Channel(RGB, Box(TextureTransmissiveColor), Srgb); OutputFormat(BC7); SrgbRead(true); >;
	Texture2D g_tUvMotionMask < Channel(RGBA, Box(FoliageUvAnimation), Linear); OutputFormat(BC7); SrgbRead(false); >;
	float3 g_vFlatOverlayColor < Default2(1, 0); Attribute("FlatOverlayColor"); UiType(VectorText); >;
	float4 g_vShaderIDColor < Source(ShaderIDColor); UiType(VectorText); >;
	float4 g_vShadingComplexity < Source(ShadingComplexity); UiType(VectorText); >;
	
	// Foliage UV Animation
	CreateInputTexture2D(FoliageUvAnimation, Linear, 8, "", "_wind", "Foliage UV Animation", Default4(0, 0, 0, 0));
	float g_flFoliageUvAnimation < Default(0.1); UiType(Slider); UiGroup("Foliage UV Animation"); >;
	
	// Ambient Occlusion
	CreateInputTexture2D(TextureAmbientOcclusion, Linear, 8, "", "_ao", "Ambient Occlusion/10", Default4(1, 1, 1, 0));
	
	// Color
	CreateInputTexture2D(TextureTintMask, Linear, 8, "", "_mask", "Color", Default4(1, 1, 1, 0));
	CreateInputTexture2D(TextureColor, Srgb, 8, "", "_color", "Color/10", Default4(1, 1, 1, 0));
	float3 g_vTextureColorCorrectionTint < Default3(1, 1, 1); UiType(Color); UiGroup("Color/Color Correction,75/50"); >;
	float g_fTextureColorContrast < Default(1); Range(0, 4); UiType(Slider); UiGroup("Color/Color Correction/52"); >;
	float g_fTextureColorSaturation < Default(1); Range(0, 4); UiType(Slider); UiGroup("Color/Color Correction/53"); >;
	float g_fTextureColorBrightness < Default(1); Range(-8, 8); UiType(Slider); UiGroup("Color/Color Correction/54"); >;
	int g_nColorCorrectionMode < UiOptions("0=Mask All,1=Mask only Tint"); UiType(Enum); UiGroup("Color/Color Correction/55"); UiVisibility(F_TINT_MASK==1); >;
	
	// Normal Map
	CreateInputTexture2D(TextureNormal, Linear, 8, "NormalizeNormals", "_normal", "Normal Map,20", Default4(0.5, 0.5, 1, 0));
	float g_fTextureNormalContrast < Default(1); Range(-2, 2); UiType(Slider); UiGroup("Normal Map"); >;
	
	// Lighting
	CreateInputTexture2D(TextureRoughness, Linear, 8, "Inverse", "_rough", "Lighting,30/Roughness,20/10", Default4(0.5, 0.5, 0.5, 0));
	float g_fTextureRoughnessContrast < Default(1); Range(0, 4); UiType(Slider); UiGroup("Lighting/Roughness/11"); >;
	float g_fTextureRoughnessBrightness < Default(1); Range(0, 4); UiType(Slider); UiGroup("Lighting/Roughness/12"); >;
	bool g_bMaskRoughnessAdjustmentsByTintMask < UiType(CheckBox); UiGroup("Lighting/Roughness/13"); UiVisibility(F_TINT_MASK==1); >;
	
	// Translucent
	CreateInputTexture2D(TextureTranslucency, Linear, 8, "", "_trans", "Translucent,15", Default4(1, 1, 1, 0));
	float g_flAlphaTestReference < Default(0.5); Range(0.01, 0.99); UiType(Slider); UiGroup("Translucent"); >;
	float g_flGrazingAngleMask < UiType(Slider); UiGroup("Translucent/Grazing Angle Mask,40/10"); >;
	float g_flAlphaBoostStrength < Default(3); Range(1, 20); UiType(Slider); UiGroup("Translucent/Alpha Boost Mask,40/11"); >;
	float g_flAlphaBoostDistance < Default(20000); Range(5000, 20000); UiType(Slider); UiGroup("Translucent/Alpha Boost Mask,40/12"); >;
	
	// Transmission
	CreateInputTexture2D(TextureTransmissiveColor, Srgb, 8, "", "_color", "Transmission/0", Default4(1, 1, 1, 0));
	bool g_bApplyColorCorrectionToTransmissiveColor < UiType(CheckBox); UiGroup("Transmission/5"); >;
	
	// Fog
	bool g_bFogEnabled < Default(1); UiType(CheckBox); UiGroup("Fog"); >;
	
	// Vertex Color
	float g_flVertexAmbientOcclusionAmount < UiType(Slider); UiGroup("Vertex Color,15/Ambient Occlusion (Alpha Channel), 15/10"); >;
	float g_flVertexAmbientOcclusionPower < Default(1); Range(1, 5); UiType(Slider); UiGroup("Vertex Color,15/Ambient Occlusion (Alpha Channel), 15/11"); >;
	float g_flHeightGradientAmount < UiType(Slider); UiGroup("Vertex Color,15/Height Gradient (Red Channel), 15/12"); >;
	float g_flHeightGradientPower < Default(1); Range(1, 5); UiType(Slider); UiGroup("Vertex Color,15/Height Gradient (Red Channel), 15/13"); >;
	
	// Texture Address Mode
	int g_nTextureAddressModeU < UiOption("RsTextureAddressMode_t"); UiType(Enum); UiGroup("Texture Address Mode"); >;
	int g_nTextureAddressModeV < UiOption("RsTextureAddressMode_t"); UiType(Enum); UiGroup("Texture Address Mode"); >;
	
	#if (S_TINT_MASK == 0)
		Texture2D g_tColor < Channel(RGB, ArtistDefinedOrAlphaWeighted(TextureColor, TextureTranslucency), Srgb); Channel(A, PreserveCoverage(TextureTranslucency), Linear); OutputFormat(BC7); SrgbRead(true); >;
	#endif
	#if (S_TRANSMISSIVE_BACKFACE_NDOTL == 0)
		Texture2D g_tColor < Channel(RGB, ArtistDefinedOrAlphaWeighted(TextureColor, TextureTranslucency), Srgb); Channel(A, PreserveCoverage(TextureTranslucency), Linear); OutputFormat(BC7); SrgbRead(true); >;
	#endif
	#if (S_MODE_TOOLS_VIS == 1)
		Texture2D g_tColor < Channel(RGB, ArtistDefinedOrAlphaWeighted(TextureColor, TextureTranslucency), Srgb); Channel(A, PreserveCoverage(TextureTranslucency), Linear); OutputFormat(BC7); SrgbRead(true); >;
	#endif
	#if (S_SHADER_QUALITY == 1)
		Texture2D g_tColor < Channel(RGB, ArtistDefinedOrAlphaWeighted(TextureColor, TextureTranslucency), Srgb); Channel(A, PreserveCoverage(TextureTranslucency), Linear); OutputFormat(BC7); SrgbRead(true); >;
	#endif
	#if (S_ALPHA_TEST == 1)
		Texture2D g_tColor < Channel(RGB, ArtistDefinedOrAlphaWeighted(TextureColor, TextureTranslucency), Srgb); Channel(A, PreserveCoverage(TextureTranslucency), Linear); OutputFormat(BC7); SrgbRead(true); >;
	#endif
	#if (S_VERTEX_ANIMATION == 0)
		Texture2D g_tColor < Channel(RGB, ArtistDefinedOrAlphaWeighted(TextureColor, TextureTranslucency), Srgb); Channel(A, PreserveCoverage(TextureTranslucency), Linear); OutputFormat(BC7); SrgbRead(true); >;
	#endif
	#if (S_MODE_TOOLS_SHADING_COMPLEXITY == 1)
		Texture2D g_tColor < Channel(RGB, ArtistDefinedOrAlphaWeighted(TextureColor, TextureTranslucency), Srgb); Channel(A, PreserveCoverage(TextureTranslucency), Linear); OutputFormat(BC7); SrgbRead(true); >;
	#endif
	
	// Variant parameters
	Texture2D g_tColor < Channel(RGB, ArtistDefined(TextureColor), Srgb); OutputFormat(DXT1); SrgbRead(true); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	struct _1289
	{
	    float4 _m0[3];
	};
	
	struct _1499
	{
	    float4 _m0[4];
	};
	
	struct _2441
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
	
	static float3 _4;
	static float4 _5;
	
	cbuffer _Globals_ : register(b0, space1)
	{
	    uint _Globals_1_g_tColor : packoffset(c0);
	    uint _Globals_1_g_sTrilinearWrap : packoffset(c0.w);
	    uint _Globals_1_g_sTrilinearClamp : packoffset(c1);
	    uint _Globals_1_g_sPointClamp : packoffset(c1.y);
	    uint _Globals_1_g_sUserConfig : packoffset(c2);
	    uint _Globals_1_g_sUserConfigAllowGlobalMipBias : packoffset(c2.y);
	    uint _Globals_1_g_sCookieSampler : packoffset(c2.w);
	    uint _Globals_1_g_tShadowDepthBufferCmpSampler : packoffset(c3);
	    int _Globals_1_g_bFogEnabled : packoffset(c3.z);
	    int _Globals_1_g_bDontFlipBackfaceNormals : packoffset(c3.w);
	    int _Globals_1_g_bRenderBackfaceNormals : packoffset(c4);
	    float _Globals_1_g_flReflectance : packoffset(c4.y);
	    uint _Globals_1_g_tNormal : packoffset(c8);
	    uint _Globals_1_g_tAmbientOcclusion : packoffset(c8.w);
	    float _Globals_1_g_flVertexAmbientOcclusionAmount : packoffset(c11);
	    float _Globals_1_g_flVertexAmbientOcclusionPower : packoffset(c11.y);
	    float _Globals_1_g_flHeightGradientAmount : packoffset(c11.z);
	    float _Globals_1_g_flHeightGradientPower : packoffset(c11.w);
	    column_major float4x4 _Globals_1_g_mTextureColorAdjust : packoffset(c14);
	    float _Globals_1_g_fTextureRoughnessContrast : packoffset(c30.y);
	    float _Globals_1_g_fTextureRoughnessBrightness : packoffset(c30.z);
	    float _Globals_1_g_fTextureNormalContrast : packoffset(c31);
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
	    _1289 PerViewLightingConstantBufferGpu_t_1_m0 : packoffset(c7);
	    _1499 PerViewLightingConstantBufferGpu_t_1_m1 : packoffset(c11);
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
	    _2441 PerViewLightingConstantBufferGpu_t_1_m18 : packoffset(c1956);
	    _1499 PerViewLightingConstantBufferGpu_t_1_m19 : packoffset(c1988);
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
	static bool gl_FrontFacing;
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
	    bool gl_FrontFacing : SV_IsFrontFace;
	};
	
	struct PS_OUTPUT
	{
	    float4 output_0 : SV_Target0;
	};
	
	void MainPs_inner()
	{
	    float4 _11408 = gl_FragCoord;
	    _11408.w = 1.0f / _11408.w;
	    float4 _24079 = clamp(input_0, 0.001000000047497451305389404296875f.xxxx, 1.0f.xxxx);
	    float3 _21709;
	    if (dot(input_2.xyz, input_2.xyz) >= 1.0099999904632568359375f)
	    {
	        _21709 = input_5.xyz;
	    }
	    else
	    {
	        _21709 = input_2.xyz;
	    }
	    bool _14874 = _Globals_1_g_bRenderBackfaceNormals != 0;
	    bool _12885;
	    if (_14874)
	    {
	        _12885 = _Globals_1_g_bDontFlipBackfaceNormals == 0;
	    }
	    else
	    {
	        _12885 = false;
	    }
	    float3 _10251;
	    [branch]
	    if (_12885)
	    {
	        _10251 = _21709 * (gl_FrontFacing ? 1.0f : (-1.0f));
	    }
	    else
	    {
	        _10251 = _21709;
	    }
	    float3 _24347 = normalize(_10251);
	    float3 _10061 = input_1 + PerViewConstantBufferCsgo_t_1_m20.xyz;
	    float4 _19334 = g_bindless_Texture2D_float4[_Globals_1_g_tColor].Sample(g_bindless_Sampler[_Globals_1_g_sUserConfigAllowGlobalMipBias], input_3.xy);
	    float4 _19068 = g_bindless_Texture2D_float4[_Globals_1_g_tAmbientOcclusion].Sample(g_bindless_Sampler[_Globals_1_g_sUserConfig], float2(input_3.xy).xy);
	    float4 _19372 = g_bindless_Texture2D_float4[_Globals_1_g_tNormal].Sample(g_bindless_Sampler[_Globals_1_g_sUserConfig], input_3.xy);
	    float _16000 = _19372.x;
	    float _19720 = _19372.y;
	    float _16783 = (_16000 + _19720) - 1.00392162799835205078125f;
	    float _11176 = _16000 - _19720;
	    float3 _8418 = normalize(float3(float2(_16783, _11176), (1.0f - abs(_16783)) - abs(_11176)));
	    bool _12886;
	    if (_14874)
	    {
	        _12886 = _Globals_1_g_bDontFlipBackfaceNormals == 0;
	    }
	    else
	    {
	        _12886 = false;
	    }
	    bool _24327;
	    if (_12886)
	    {
	        _24327 = !gl_FrontFacing;
	    }
	    else
	    {
	        _24327 = false;
	    }
	    float3 _12631 = input_2.xyz * (_24327 ? (-1.0f) : 1.0f);
	    float _23240 = (input_6.w > 0.0f) ? 1.0f : (-1.0f);
	    float3 _14435 = cross(_12631.xyz, input_6.xyz) * _23240;
	    bool4 _24464 = bool4(PerViewConstantBufferCsgo_t_1_m2.x != int4(0, 0, 0, 0).x, PerViewConstantBufferCsgo_t_1_m2.y != int4(0, 0, 0, 0).y, PerViewConstantBufferCsgo_t_1_m2.z != int4(0, 0, 0, 0).z, PerViewConstantBufferCsgo_t_1_m2.w != int4(0, 0, 0, 0).w);
	    bool _20058 = _24464.w;
	    float3 _7424;
	    if (_20058)
	    {
	        _7424 = -_14435;
	    }
	    else
	    {
	        _7424 = _14435;
	    }
	    float3 _20480;
	    if (!_24327)
	    {
	        float3 _7482 = _8418;
	        _7482.y = -_8418.y;
	        _20480 = _7482;
	    }
	    else
	    {
	        _20480 = _8418;
	    }
	    float3 _8357 = _Globals_1_g_flReflectance.xxx;
	    float3 _21710;
	    [branch]
	    if (_Globals_1_g_fTextureNormalContrast != 1.0f)
	    {
	        float2 _8828 = _20480.yx * _Globals_1_g_fTextureNormalContrast;
	        float _16674 = _8828.x;
	        float3 _8673 = _20480;
	        _8673.y = _16674;
	        _8673.x = _8828.y;
	        bool _12887;
	        if (_14874)
	        {
	            _12887 = _Globals_1_g_bDontFlipBackfaceNormals == 0;
	        }
	        else
	        {
	            _12887 = false;
	        }
	        bool _24328;
	        if (_12887)
	        {
	            _24328 = !gl_FrontFacing;
	        }
	        else
	        {
	            _24328 = false;
	        }
	        float3 _9739 = input_2.xyz * (_24328 ? (-1.0f) : 1.0f);
	        float3 _24682 = cross(_9739.xyz, input_6.xyz) * _23240;
	        float3 _7425;
	        if (_20058)
	        {
	            _7425 = -_24682;
	        }
	        else
	        {
	            _7425 = _24682;
	        }
	        float3 _20481;
	        if (!_24328)
	        {
	            float3 _16556 = _8673;
	            _16556.y = -_16674;
	            _20481 = _16556;
	        }
	        else
	        {
	            _20481 = _8673;
	        }
	        _21710 = normalize((((input_6.xyz * _20481.x).xyz + (_7425.xyz * _20481.y)).xyz + (_9739.xyz * _20481.z)).xyz);
	    }
	    else
	    {
	        _21710 = normalize((((input_6.xyz * _20480.x).xyz + (_7424.xyz * _20480.y)).xyz + (_12631.xyz * _20480.z)).xyz);
	    }
	    bool3 _15080 = all(bool3(true, true, true)).xxx;
	    float3 _17892 = float3(_15080.x ? _21710.x : 1.0f.xxx.x, _15080.y ? _21710.y : 1.0f.xxx.y, _15080.z ? _21710.z : 1.0f.xxx.z);
	    float3 _10560 = _24347.xyz;
	    float3 _11099 = ddx(_10560);
	    float3 _9175 = ddy(_10560);
	    float3 _10347 = _11099.xyz;
	    float3 _12420 = _9175.xyz;
	    float2 _21813 = max(clamp((((_19372.zz - 0.5f.xx) * _Globals_1_g_fTextureRoughnessContrast) + 0.5f.xx).xy * _Globals_1_g_fTextureRoughnessBrightness, 0.0f.xx, 1.0f.xx).xy, pow(saturate(max(dot(_10347, _10347), dot(_12420, _12420))), 0.333000004291534423828125f).xx);
	    float3 _15598 = -_24347;
	    float4 _23875 = float4(_21710.xyz, 1.0f);
	    bool4 _24465 = bool4(PerViewConstantBufferCsgo_t_1_m0.x != int4(0, 0, 0, 0).x, PerViewConstantBufferCsgo_t_1_m0.y != int4(0, 0, 0, 0).y, PerViewConstantBufferCsgo_t_1_m0.z != int4(0, 0, 0, 0).z, PerViewConstantBufferCsgo_t_1_m0.w != int4(0, 0, 0, 0).w);
	    float _21711;
	    if (_24465.x)
	    {
	        float3 _11394 = _24347.xyz;
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
	        _21711 = (1.0f / (dot(_13232, 1.0f.xxxx) + PerViewLightingConstantBufferGpu_t_1_m3.x)) * (PerViewLightingConstantBufferGpu_t_1_m3.x + dot(_13232, g_bindless_Texture2D_float4[PerViewConstantBufferCsgo_t_1_m4].SampleLevel(g_bindless_Sampler[_Globals_1_g_sPointClamp], (_11086 + float2(_13083.x ? PerViewConstantBufferCsgo_t_1_m9.xy.x : _23169.x, _13083.y ? PerViewConstantBufferCsgo_t_1_m9.xy.y : _23169.y).xy).xy, 0.0f)));
	    }
	    else
	    {
	        _21711 = 1.0f;
	    }
	    float _21712;
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
	        float _13279 = lerp(_19363, 1.0f, saturate((distance(_10061.xyz, PerViewConstantBuffer_t_1_m3) * PerViewLightingConstantBufferGpu_t_1_m17) + PerViewLightingConstantBufferGpu_t_1_m16));
	        float _12502;
	        if (_24465.y)
	        {
	            _12502 = min(_13279, g_bindless_Texture2D_float4[PerViewConstantBufferCsgo_t_1_m6].SampleLevel(g_bindless_Sampler[_Globals_1_g_sTrilinearClamp], (_11408.xy * PerViewConstantBuffer_t_1_m2.xy).xy, 0.0f).z);
	        }
	        else
	        {
	            _12502 = _13279;
	        }
	        _21712 = _12502;
	    }
	    else
	    {
	        _21712 = 1.0f;
	    }
	    float3 _9716;
	    float3 _24878;
	    [branch]
	    if ((dot(PerViewLightingConstantBufferGpu_t_1_m9.xyz, _21710.xyz) * _21712) > 0.0f)
	    {
	        bool3 _19899 = all(bool3(_17892.x == 1.0f.xxx.x, _17892.y == 1.0f.xxx.y, _17892.z == 1.0f.xxx.z)).xxx;
	        float _11797 = max(0.0f, dot(_21710.xyz, PerViewLightingConstantBufferGpu_t_1_m9.xyz));
	        float2 _9840 = max(_21813, PerViewLightingConstantBufferGpu_t_1_m9.w.xx);
	        float3 _12281 = normalize(PerViewLightingConstantBufferGpu_t_1_m9.xyz + (-normalize(_10061.xyz - PerViewConstantBuffer_t_1_m3.xyz)).xyz).xyz;
	        float _12386 = dot(_12281, float3(_19899.x ? _21710.xyz.x : _17892.x, _19899.y ? _21710.xyz.y : _17892.y, _19899.z ? _21710.xyz.z : _17892.z).xyz);
	        float _19210 = max(0.0f, dot(PerViewLightingConstantBufferGpu_t_1_m9.xyz, _12281));
	        float _9850 = _9840.x;
	        float _25211 = _9850 * _9850;
	        float _19095 = _25211 * _25211;
	        float _15346 = ((_12386 * _12386) * (_19095 - 1.0f)) + 1.0f;
	        float3 _16808 = (PerViewLightingConstantBufferGpu_t_1_m10.xyz * _21712).xyz;
	        _9716 = ((_8357.xyz * (_19095 / (((_15346 * _15346) * (_19210 * _19210)) * ((_9850 * 4.0f) + 2.0f)))).xyz * _11797).xyz * _16808;
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
	        float4 _18621 = mul(PerViewConstantBufferCsgo_t_1_m8, float4(_10061.xyz, 1.0f).xyzw);
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
	                float _21776 = _10521.z;
	                _22905.z = _21776;
	                float3 _21642 = _22905.xyz;
	                bool _7426;
	                if (all(bool3(_22905.xyz.x > float3(-1.0f, -1.0f, 0.0f).x, _22905.xyz.y > float3(-1.0f, -1.0f, 0.0f).y, _22905.xyz.z > float3(-1.0f, -1.0f, 0.0f).z)))
	                {
	                    _7426 = all(bool3(_22905.xyz.x < 1.0f.xxx.x, _22905.xyz.y < 1.0f.xxx.y, _22905.xyz.z < 1.0f.xxx.z));
	                }
	                else
	                {
	                    _7426 = false;
	                }
	                bool _12888;
	                if (!_7426)
	                {
	                    _12888 = true;
	                }
	                else
	                {
	                    float4x3 _16509 = float4x3(g_BarnLights.Load<float>(_12608 * 480 + 272), g_BarnLights.Load<float>(_12608 * 480 + 288), g_BarnLights.Load<float>(_12608 * 480 + 304), g_BarnLights.Load<float>(_12608 * 480 + 276), g_BarnLights.Load<float>(_12608 * 480 + 292), g_BarnLights.Load<float>(_12608 * 480 + 308), g_BarnLights.Load<float>(_12608 * 480 + 280), g_BarnLights.Load<float>(_12608 * 480 + 296), g_BarnLights.Load<float>(_12608 * 480 + 312), g_BarnLights.Load<float>(_12608 * 480 + 284), g_BarnLights.Load<float>(_12608 * 480 + 300), g_BarnLights.Load<float>(_12608 * 480 + 316));
	                    float3 _6368 = abs(mul(float4(input_1.xyz, 1.0f), _16509).xyz);
	                    _12888 = !all(bool3(_6368.x <= 1.0f.xxx.x, _6368.y <= 1.0f.xxx.y, _6368.z <= 1.0f.xxx.z));
	                }
	                if (_12888)
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
	                    _21316 = min(1.0f, _21776 * g_BarnLights.Load<float4>(_12608 * 480 + 144).z);
	                }
	                else
	                {
	                    _21316 = 1.0f;
	                }
	                float _19667;
	                if (g_BarnLights.Load<float4>(_12608 * 480 + 144).w > 0.0f)
	                {
	                    _19667 = _21316 * min(1.0f, (1.0f - _21776) * g_BarnLights.Load<float4>(_12608 * 480 + 144).w);
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
	                            float _15019 = _22154.y;
	                            float _23041 = (-0.5f) * g_BarnLights.Load<float4>(_12608 * 480 + 224).z;
	                            float _11981 = (g_BarnLights.Load<float4>(_12608 * 480 + 224).x * g_BarnLights.Load<float4>(_12608 * 480 + 224).y) * pow(max(pow(g_BarnLights.Load<float4>(_12608 * 480 + 224).y * _11473, _15266) + pow(g_BarnLights.Load<float4>(_12608 * 480 + 224).x * _15019, _15266), 1.1754943508222875079687365372222e-38f), _23041);
	                            float _16524 = pow(max(pow(_11473, _15266) + pow(_15019, _15266), 1.1754943508222875079687365372222e-38f), _23041);
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
	                        float3 _23714 = _21642;
	                        _23714.x = _6281.x;
	                        _23714.y = _6281.y;
	                        _19629 = _23714;
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
	                float _11798 = max(0.0f, dot(_21710.xyz, _11179.xyz));
	                float2 _9841 = max(_21813, g_BarnLights.Load<float>(_12608 * 480 + 256).xx);
	                float3 _12282 = normalize(_11179.xyz + (-normalize(_10061.xyz - PerViewConstantBuffer_t_1_m3.xyz)).xyz).xyz;
	                float _12387 = dot(_12282, float3(_19900.x ? _21710.xyz.x : _17892.x, _19900.y ? _21710.xyz.y : _17892.y, _19900.z ? _21710.xyz.z : _17892.z).xyz);
	                float _19211 = max(0.0f, dot(_11179.xyz, _12282));
	                float _9851 = _9841.x;
	                float _25212 = _9851 * _9851;
	                float _19097 = _25212 * _25212;
	                float _15348 = ((_12387 * _12387) * (_19097 - 1.0f)) + 1.0f;
	                _13212 = _13138.xyz + (((_8357.xyz * (_19097 / (((_15348 * _15348) * (_19211 * _19211)) * ((_9851 * 4.0f) + 2.0f)))).xyz * _11798).xyz * _22671.xyz);
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
	    float _17172 = dot(_21813.xy, 0.5f.xx);
	    float3 _6253 = _17892.xyz;
	    float3 _17138 = normalize(_10061.xyz - PerViewConstantBuffer_t_1_m3.xyz);
	    float _17225 = _17172 * _17172;
	    float _20711 = saturate(1.0f - _17225);
	    float4 _15343 = (float4(-1.0f, -0.0274999998509883880615234375f, -0.572000026702880859375f, 0.02199999988079071044921875f) * _17172) + float4(1.0f, 0.0425000004470348358154296875f, 1.03999996185302734375f, -0.039999999105930328369140625f);
	    float _21215 = _15343.x;
	    float2 _24572 = (float2(-1.03999996185302734375f, 1.03999996185302734375f) * ((min(_21215 * _21215, exp2((-9.27999973297119140625f) * max(0.0f, dot((-_17138).xyz, _6253)))) * _21215) + _15343.y)) + _15343.zw;
	    float _20339 = _24572.y;
	    float2 _11427 = float2(_20339, _24572.x + _20339);
	    float3 _8745 = float3(dot(PerViewLightingConstantBufferGpu_t_1_m0._m0[0].xyzw, _23875), dot(PerViewLightingConstantBufferGpu_t_1_m0._m0[1].xyzw, _23875), dot(PerViewLightingConstantBufferGpu_t_1_m0._m0[2].xyzw, _23875)).xyz;
	    float3 _16991 = _16324.xyz + _8745;
	    float3 _20418 = (_21711 * (_19068.x * lerp(1.0f, pow(_24079.w, _Globals_1_g_flVertexAmbientOcclusionPower), _Globals_1_g_flVertexAmbientOcclusionAmount))).xxx.xyz;
	    float3 _22686 = (_16324.xyz + (_8745 * _20418).xyz) * ((float3(max(float4(mul(_Globals_1_g_mTextureColorAdjust, float4(float4((_19334.xyz * input_4.xyz).xyz, 1.0f).xyz, 1.0f)).xyz, 1.0f), 0.0f.xxxx).xyz).xyz * 1.0f) * (lerp(0.0f, pow(_24079.x, _Globals_1_g_flHeightGradientPower), _Globals_1_g_flHeightGradientAmount) + 1.0f)).xyz;
	    float4 _11205 = float4(_22686, _19334.w);
	    _11205.x = _22686.x;
	    _11205.y = _22686.y;
	    _11205.z = _22686.z;
	    float3 _15752 = _11205.xyz + (_13137.xyz * _20418).xyz;
	    float4 _20490 = _11205;
	    _20490.x = _15752.x;
	    _20490.y = _15752.y;
	    _20490.z = _15752.z;
	    float3 _15734 = _20490.xyz + ((((lerp(_11427.xxx, _11427.yyy, _8357) * g_bindless_TextureCubeArray_float4[PerViewConstantBufferCsgo_t_1_m7].SampleLevel(g_bindless_Sampler[_Globals_1_g_sTrilinearClamp], float4(normalize(lerp(_6253, reflect(_17138.xyz, _17892.xyz).xyz, (_20711 * (sqrt(_20711) + _17225)).xxx)), 0.0f), PerViewLightingConstantBufferGpu_t_1_m8.y * sqrt(_17172)).xyz).xyz * (normalize(_16991 + 0.001000000047497451305389404296875f.xxx) * clamp(length(_16991), 0.0f, 1.75f))).xyz * (1.0f.xxx + (normalize(_8745 + 0.001000000047497451305389404296875f.xxx) * 0.5f))).xyz * _20418).xyz;
	    float4 _13888 = _20490;
	    _13888.x = _15734.x;
	    _13888.y = _15734.y;
	    _13888.z = _15734.z;
	    float4 _6805;
	    if (_Globals_1_g_bFogEnabled != 0)
	    {
	        float3 _21493;
	        float3 _22956 = _10061.xyz - PerViewConstantBuffer_t_1_m3.xyz;
	        float3 _9057 = _22956.xyz;
	        float3 _19340;
	        do
	        {
	            _21493 = _22956.xyz;
	            bool _12889;
	            if (dot(_21493, _21493) > PerViewConstantBufferCsgo_t_1_m14.x)
	            {
	                _12889 = (_10061.z * PerViewConstantBufferCsgo_t_1_m14.z) < PerViewConstantBufferCsgo_t_1_m14.y;
	            }
	            else
	            {
	                _12889 = false;
	            }
	            [branch]
	            if (_12889)
	            {
	                float2 _9342 = clamp(PerViewConstantBufferCsgo_t_1_m11.xy + (PerViewConstantBufferCsgo_t_1_m11.zw * float2(length(_21493), _10061.z)), 0.0f.xx, 1.0f.xx);
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
	            bool _12890;
	            if (dot(_9057, _9057) > PerViewConstantBufferCsgo_t_1_m18.x)
	            {
	                _12890 = (PerViewConstantBufferCsgo_t_1_m18.z * _10061.z) < PerViewConstantBufferCsgo_t_1_m18.y;
	            }
	            else
	            {
	                _12890 = false;
	            }
	            if (_12890)
	            {
	                float _14602 = saturate(pow(max(0.0f, (length(_21493) * PerViewConstantBufferCsgo_t_1_m15.y) + PerViewConstantBufferCsgo_t_1_m15.x), PerViewConstantBufferCsgo_t_1_m15.w)) * saturate(pow(max(0.0f, (_10061.z * PerViewConstantBufferCsgo_t_1_m16.y) + PerViewConstantBufferCsgo_t_1_m16.x), PerViewConstantBufferCsgo_t_1_m16.z));
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
	    gl_FrontFacing = stage_input.gl_FrontFacing;
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
	TextureAttribute(LightSim_DiffuseAlbedoTexture, g_tColor);
	TextureAttribute(RepresentativeTexture, g_tColor);
	BoolAttribute(environmentmapped, true);
	BoolAttribute(environmentmappeddynamic, true);
	BoolAttribute(NeedsLightProbe, true);
	BoolAttribute(DoNotCastShadows, F_DO_NOT_CAST_SHADOWS ? 1 : 0);
	BoolAttribute(SupportsMappingDimensions, true);
	BoolAttribute(renderbackfaces, F_RENDER_BACKFACES ? 1 : 0);
	BoolAttribute(SupportsLightmapping, true);
	BoolAttribute(PerVertexLighting, true);
	BoolAttribute(AllowBackfaceCulling, F_RENDER_BACKFACES ? 0 : 1);
	BoolAttribute(DoubleSided, F_RENDER_BACKFACES);
	BoolAttribute(SupportsAggregateInstancing, F_FOLIAGE_ANIMATION==0);
	BoolAttribute(IgnoreFaceNormalsForLighting, true);
	
	#if (S_MODE_TOOLS_SHADING_COMPLEXITY == 0)
		TextureAttribute(LightSim_TintMaskTextureR, g_tTintMask);
	#endif
	#if (S_ALPHA_TEST == 1)
		TextureAttribute(LightSim_Opacity_A, g_tColor);
		BoolAttribute(alphatest, true);
		BoolAttribute(NoZPrepass, true);
		BoolAttribute(AlphaTestZPrepass, true);
	#endif
	#if (S_ALPHA_TEST == 0)
		BoolAttribute(NoZPrepass, F_DISABLE_Z_PREPASS ? 1 : 0);
	#endif
	#if (S_TINT_MASK == 1)
		TextureAttribute(LightSim_TintMaskTextureR, g_tTintMask);
	#endif
	#if (S_MODE_TOOLS_SHADING_COMPLEXITY == 1)
		TextureAttribute(LightSim_Opacity_A, g_tColor);
		BoolAttribute(alphatest, true);
		BoolAttribute(NoZPrepass, true);
		BoolAttribute(AlphaTestZPrepass, true);
	#endif
	#if (S_TINT_MASK == 0)
		TextureAttribute(LightSim_Opacity_A, g_tColor);
		BoolAttribute(alphatest, true);
		BoolAttribute(NoZPrepass, true);
		BoolAttribute(AlphaTestZPrepass, true);
	#endif
	#if (S_VERTEX_ANIMATION == 0)
		TextureAttribute(LightSim_Opacity_A, g_tColor);
		BoolAttribute(alphatest, true);
		BoolAttribute(NoZPrepass, true);
		BoolAttribute(AlphaTestZPrepass, true);
	#endif
	#if (S_TRANSMISSIVE_BACKFACE_NDOTL == 0)
		TextureAttribute(LightSim_Opacity_A, g_tColor);
		BoolAttribute(alphatest, true);
		BoolAttribute(NoZPrepass, true);
		BoolAttribute(AlphaTestZPrepass, true);
	#endif
	#if (S_TRANSMISSIVE_BACKFACE_NDOTL == 1)
		TextureAttribute(LightSim_TintMaskTextureR, g_tTintMask);
	#endif
	
	// PSRS
	
	RenderState(BackStencilFunc, F_RENDER_BACKFACES ? NotEqual : Always);
	RenderState(CullMode, F_RENDER_BACKFACES ? None : Front);
	RenderState(CullMode, F_RENDER_BACKFACES ? None : Back);
	RenderState(DepthEnable, F_DISABLE_Z_BUFFERING ? false : true);
	RenderState(DepthFunc, Equal);
	RenderState(DepthWriteEnable, false);
	RenderState(DepthWriteEnable, F_DISABLE_Z_BUFFERING ? false : true);
	RenderState(SlopeScaleDepthBias, 0);
	RenderState(StencilEnable, true);
	RenderState(StencilFunc, NotEqual);
	RenderState(StencilReadMask, 1);
	RenderState(StencilRef, 3);
	RenderState(StencilWriteMask, 254);
	
	
	// Variant parameters
	RenderState(CullMode, F_RENDER_BACKFACES ? None : Front);
	RenderState(CullMode, F_RENDER_BACKFACES ? None : Back);
	RenderState(DepthWriteEnable, false);
	RenderState(DepthWriteEnable, F_DISABLE_Z_BUFFERING ? false : true);
	
	BoolAttribute(BindlessResources, true);
	
}

RTX
{
	StaticCombo( S_FOLIAGE_UV_ANIMATION, F_FOLIAGE_UV_ANIMATION );
	StaticCombo( S_MODE_DEPTH, 0..1 );
	StaticCombo( S_ANIMATED_SHADOWS, F_ANIMATED_SHADOWS );
	StaticCombo( S_VERTEX_ANIMATION, F_VERTEX_ANIMATION );
	StaticCombo( S_FOLIAGE_ANIMATION, F_FOLIAGE_ANIMATION );
	StaticCombo( S_MODE_TOOLS_VIS, 0..1 );
	StaticCombo( S_ALPHA_TEST, F_ALPHA_TEST );
	StaticCombo( S_TINT_MASK, F_TINT_MASK );
	StaticCombo( S_TRANSMISSIVE_BACKFACE_NDOTL, F_TRANSMISSIVE_BACKFACE_NDOTL );
	StaticCombo( S_MODE_TOOLS_SHADING_COMPLEXITY, 0..1 );
	StaticCombo( S_SHADER_QUALITY, 0..1 );
	StaticComboRule( Allow1( S_MODE_DEPTH, S_TINT_MASK ) );
	StaticComboRule( Allow1( S_MODE_DEPTH, S_TRANSMISSIVE_BACKFACE_NDOTL ) );
	StaticComboRule( Allow1( S_MODE_TOOLS_SHADING_COMPLEXITY, S_TINT_MASK ) );
	StaticComboRule( Allow1( S_MODE_TOOLS_SHADING_COMPLEXITY, S_TRANSMISSIVE_BACKFACE_NDOTL ) );
	StaticComboRule( Allow1( S_MODE_TOOLS_SHADING_COMPLEXITY, S_VERTEX_ANIMATION ) );
	StaticComboRule( Allow1( S_MODE_DEPTH, S_SHADER_QUALITY ) );
	StaticComboRule( Allow1( S_MODE_TOOLS_VIS ) );
	StaticComboRule( Requires( S_MODE_TOOLS_VIS, S_SHADER_QUALITY ) );
	StaticComboRule( Allow0( S_MODE_DEPTH, S_MODE_TOOLS_SHADING_COMPLEXITY ) );
	StaticComboRule( Allow0( S_VERTEX_ANIMATION ) );
	StaticComboRule( Allow0( S_FOLIAGE_ANIMATION ) );
	StaticComboRule( Allow0( S_FOLIAGE_UV_ANIMATION ) );
	StaticComboRule( Allow0( S_MODE_TOOLS_VIS, S_SHADER_QUALITY ) );
	StaticComboRule( Requires( S_FOLIAGE_UV_ANIMATION, S_ALPHA_TEST ) );
	StaticComboRule( Allow1( S_FOLIAGE_ANIMATION, S_VERTEX_ANIMATION ) );
	DynamicCombo( D_COMPRESSED_NORMALS_AND_TANGENTS, 0..1 );
	DynamicCombo( D_CS_VERTEX_ANIMATION, 0..1 );
	DynamicCombo( D_BAKED_LIGHTING_FROM_VERTEX_STREAM, 0..1 );
	DynamicCombo( D_BAKED_LIGHTING_FROM_LIGHTMAP, 0..1 );
	DynamicCombo( D_ALPHA_TEST_PREPASS, 0..1 );
	DynamicCombo( D_QUAD_OVERDRAW, 0..1 );
	DynamicCombo( D_OPAQUE_FADE, 0..1 );
	DynamicCombo( D_SPECULAR_CUBE_MAP_STATIC, 0..1 );
	DynamicCombo( D_BAKED_LIGHTING_FROM_PROBE, 0..1 );
	DynamicComboRule( Allow1( D_BAKED_LIGHTING_FROM_VERTEX_STREAM, D_BAKED_LIGHTING_FROM_LIGHTMAP ) );
	DynamicComboRule( Requires( D_ALPHA_TEST_PREPASS, S_ALPHA_TEST ) );
	DynamicComboRule( Requires( D_QUAD_OVERDRAW, S_MODE_TOOLS_SHADING_COMPLEXITY ) );
	DynamicComboRule( Requires( D_SPECULAR_CUBE_MAP_STATIC, S_SHADER_QUALITY ) );
	DynamicComboRule( Allow1( D_BAKED_LIGHTING_FROM_PROBE, D_BAKED_LIGHTING_FROM_VERTEX_STREAM, D_BAKED_LIGHTING_FROM_LIGHTMAP ) );
	DynamicComboRule( Allow0( D_OPAQUE_FADE ) );
	DynamicComboRule( Allow0( D_ALPHA_TEST_PREPASS ) );
	DynamicComboRule( Allow0( D_SPECULAR_CUBE_MAP_STATIC ) );
	DynamicComboRule( Allow0( D_BAKED_LIGHTING_FROM_PROBE, D_BAKED_LIGHTING_FROM_VERTEX_STREAM, D_BAKED_LIGHTING_FROM_LIGHTMAP ) );
	DynamicComboRule( Allow0( D_COMPRESSED_NORMALS_AND_TANGENTS, D_CS_VERTEX_ANIMATION ) );
	
	bool g_bDontFlipBackfaceNormals < UiType(CheckBox); Expression(F_DONT_FLIP_BACKFACE_NORMALS ? 1 : 0); >;
	bool g_bRenderBackfaceNormals < UiType(CheckBox); Expression((F_RENDER_BACKFACES ? 1 : 0) ? 1 : 0); >;
	bool g_bUseAlbedoForTransmissive < UiType(CheckBox); Expression(F_USE_ALBEDO_FOR_TRANSMISSIVE ? 1 : 0); >;
	float g_flReflectance < UiType(Slider); Expression(pow((1.5-1)/(1.5+1),2)); >;
	float4x4 g_mTextureColorAdjust < Expression(MatrixMultiply(MatrixColorTint2(g_vTextureColorCorrectionTint,1),MatrixColorCorrect2(float3(g_fTextureColorContrast,g_fTextureColorSaturation,g_fTextureColorBrightness),TextureAverageColor(g_tColor)))); >;
	float4x4 g_mTransmissiveTextureColorAdjust < Expression(MatrixMultiply(MatrixColorTint2(g_vTextureColorCorrectionTint,1),MatrixColorCorrect2(float3(g_fTextureColorContrast,g_fTextureColorSaturation,g_fTextureColorBrightness),TextureAverageColor(g_tTransmissiveColor)))); >;
	Texture2D g_tColor < Channel(RGB, ArtistDefined(TextureColor), Srgb); OutputFormat(DXT1); SrgbRead(true); >;
	Texture2D g_tColor < Channel(RGB, ArtistDefinedOrAlphaWeighted(TextureColor, TextureTranslucency), Srgb); Channel(A, PreserveCoverage(TextureTranslucency), Linear); OutputFormat(BC7); SrgbRead(true); >;
	Texture2D g_tNormal < Channel(RGBA, HemiOctIsoRoughness_RG_B(TextureNormal, TextureRoughness), Linear); OutputFormat(BC7); SrgbRead(false); >;
	Texture2D g_tTintMask < Channel(R, Box(TextureTintMask), Linear); OutputFormat(ATI1N); SrgbRead(false); >;
	Texture2D g_tTransmissiveColor < Channel(RGB, Box(TextureTransmissiveColor), Srgb); OutputFormat(BC7); SrgbRead(true); >;
	float4 g_vTexCoordXform0 < UiType(VectorText); Expression(v0 = 0*3.14159/180;
		v1 = cos(v0);
		v2 = sin(v0);
		float4(v1*float2(1,1).x,-v2*float2(1,1).y,0,float2(.5,.5).x+float2(0,0).x+v2*float2(.5,.5).y-v1*float2(.5,.5).x)); >;
	float4 g_vTexCoordXform1 < UiType(VectorText); Expression(v0 = 0*3.14159/180;
		v1 = cos(v0);
		v2 = sin(v0);
		float4(v2*float2(1,1).x,v1*float2(1,1).y,0,float2(.5,.5).y+float2(0,0).y-(v2*float2(.5,.5).x+v1*float2(.5,.5).y))); >;
	
	// Color
	CreateInputTexture2D(TextureTintMask, Linear, 8, "", "_mask", "Color", Default4(1, 1, 1, 0));
	CreateInputTexture2D(TextureColor, Srgb, 8, "", "_color", "Color/10", Default4(1, 1, 1, 0));
	float3 g_vColorTint < Default3(1, 1, 1); UiType(Color); UiGroup("Color,10/20"); Expression(SrgbGammaToLinear(this)); >;
	float g_flModelTintAmount < Default(1); UiType(Slider); UiGroup("Color,10/30"); >;
	float3 g_vTextureColorCorrectionTint < Default3(1, 1, 1); UiType(Color); UiGroup("Color/Color Correction,75/50"); >;
	float g_fTextureColorContrast < Default(1); Range(0, 4); UiType(Slider); UiGroup("Color/Color Correction/52"); >;
	float g_fTextureColorSaturation < Default(1); Range(0, 4); UiType(Slider); UiGroup("Color/Color Correction/53"); >;
	float g_fTextureColorBrightness < Default(1); Range(-8, 8); UiType(Slider); UiGroup("Color/Color Correction/54"); >;
	float2 g_vTexCoordScrollSpeed < Range2(-10, -10, 10, 10); UiType(VectorText); UiGroup("Color/70"); >;
	
	// Normal Map
	CreateInputTexture2D(TextureNormal, Linear, 8, "NormalizeNormals", "_normal", "Normal Map,20", Default4(0.5, 0.5, 1, 0));
	float g_fTextureNormalContrast < Default(1); Range(-2, 2); UiType(Slider); UiGroup("Normal Map"); >;
	
	// Lighting
	CreateInputTexture2D(TextureRoughness, Linear, 8, "Inverse", "_rough", "Lighting,30/Roughness,20/10", Default4(0.5, 0.5, 0.5, 0));
	float g_fTextureRoughnessContrast < Default(1); Range(0, 4); UiType(Slider); UiGroup("Lighting/Roughness/11"); >;
	float g_fTextureRoughnessBrightness < Default(1); Range(0, 4); UiType(Slider); UiGroup("Lighting/Roughness/12"); >;
	
	// Translucent
	CreateInputTexture2D(TextureTranslucency, Linear, 8, "", "_trans", "Translucent,15", Default4(1, 1, 1, 0));
	
	// Transmission
	CreateInputTexture2D(TextureTransmissiveColor, Srgb, 8, "", "_color", "Transmission/0", Default4(1, 1, 1, 0));
	bool g_bApplyColorCorrectionToTransmissiveColor < UiType(CheckBox); UiGroup("Transmission/5"); >;
	
	// Texture Address Mode
	int g_nTextureAddressModeU < UiOption("RsTextureAddressMode_t"); UiType(Enum); UiGroup("Texture Address Mode"); >;
	int g_nTextureAddressModeV < UiOption("RsTextureAddressMode_t"); UiType(Enum); UiGroup("Texture Address Mode"); >;
	
	#if (S_ALPHA_TEST == 1)
		Texture2D g_tColor < Channel(RGB, ArtistDefinedOrAlphaWeighted(TextureColor, TextureTranslucency), Srgb); Channel(A, PreserveCoverage(TextureTranslucency), Linear); OutputFormat(BC7); SrgbRead(true); >;
	#endif
	
	// Variant parameters
	Texture2D g_tColor < Channel(RGB, ArtistDefined(TextureColor), Srgb); OutputFormat(DXT1); SrgbRead(true); >;
	
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
	    vec3 vNormalOs;
	    vec4 vTangentUOs_flTangentVSign;
	    uvec4 vBlendIndices;
	    uint nInstanceIdx;
	    vec4 vBlendColorTint;
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
	    uint _member0[];
	} g_MaterialData_1;
	
	layout(set = 3, binding = 34, std430) readonly buffer g_MaterialData_2
	{
	    float _member0[];
	} g_MaterialData_3;
	
	layout(set = 3, binding = 34, std430) readonly buffer g_MaterialData_4
	{
	    int _member0[];
	} g_MaterialData_5;
	
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
	    uint _549 = g_instanceBuffer._member0[uint(gl_InstanceID)].nMaterialData;
	    uint _604 = g_MaterialData_1._member0[(_549 + 28u) / 4u];
	    uint _603 = g_MaterialData_1._member0[(_549 + 32u) / 4u];
	    vec4 _602 = vec4(g_MaterialData_3._member0[(_549 + 112u) / 4u], g_MaterialData_3._member0[(_549 + 116u) / 4u], g_MaterialData_3._member0[(_549 + 120u) / 4u], g_MaterialData_3._member0[(_549 + 124u) / 4u]);
	    vec4 _601 = vec4(g_MaterialData_3._member0[(_549 + 128u) / 4u], g_MaterialData_3._member0[(_549 + 132u) / 4u], g_MaterialData_3._member0[(_549 + 136u) / 4u], g_MaterialData_3._member0[(_549 + 140u) / 4u]);
	    vec2 _600 = vec2(g_MaterialData_3._member0[(_549 + 144u) / 4u], g_MaterialData_3._member0[(_549 + 148u) / 4u]);
	    vec3 _599 = vec3(g_MaterialData_3._member0[(_549 + 160u) / 4u], g_MaterialData_3._member0[(_549 + 164u) / 4u], g_MaterialData_3._member0[(_549 + 168u) / 4u]);
	    float _598 = g_MaterialData_3._member0[(_549 + 172u) / 4u];
	    uint _597 = g_MaterialData_1._member0[(_549 + 180u) / 4u];
	    bool _596 = g_MaterialData_5._member0[(_549 + 188u) / 4u] != 0;
	    bool _595 = g_MaterialData_5._member0[(_549 + 192u) / 4u] != 0;
	    float _594 = g_MaterialData_3._member0[(_549 + 196u) / 4u];
	    uint _593 = g_MaterialData_1._member0[(_549 + 200u) / 4u];
	    bool _592 = g_MaterialData_5._member0[(_549 + 300u) / 4u] != 0;
	    mat4 _591 = mat4(vec4(g_MaterialData_3._member0[(_549 + 304u) / 4u], g_MaterialData_3._member0[(_549 + 320u) / 4u], g_MaterialData_3._member0[(_549 + 336u) / 4u], g_MaterialData_3._member0[(_549 + 352u) / 4u]), vec4(g_MaterialData_3._member0[(_549 + 308u) / 4u], g_MaterialData_3._member0[(_549 + 324u) / 4u], g_MaterialData_3._member0[(_549 + 340u) / 4u], g_MaterialData_3._member0[(_549 + 356u) / 4u]), vec4(g_MaterialData_3._member0[(_549 + 312u) / 4u], g_MaterialData_3._member0[(_549 + 328u) / 4u], g_MaterialData_3._member0[(_549 + 344u) / 4u], g_MaterialData_3._member0[(_549 + 360u) / 4u]), vec4(g_MaterialData_3._member0[(_549 + 316u) / 4u], g_MaterialData_3._member0[(_549 + 332u) / 4u], g_MaterialData_3._member0[(_549 + 348u) / 4u], g_MaterialData_3._member0[(_549 + 364u) / 4u]));
	    mat4 _590 = mat4(vec4(g_MaterialData_3._member0[(_549 + 368u) / 4u], g_MaterialData_3._member0[(_549 + 384u) / 4u], g_MaterialData_3._member0[(_549 + 400u) / 4u], g_MaterialData_3._member0[(_549 + 416u) / 4u]), vec4(g_MaterialData_3._member0[(_549 + 372u) / 4u], g_MaterialData_3._member0[(_549 + 388u) / 4u], g_MaterialData_3._member0[(_549 + 404u) / 4u], g_MaterialData_3._member0[(_549 + 420u) / 4u]), vec4(g_MaterialData_3._member0[(_549 + 376u) / 4u], g_MaterialData_3._member0[(_549 + 392u) / 4u], g_MaterialData_3._member0[(_549 + 408u) / 4u], g_MaterialData_3._member0[(_549 + 424u) / 4u]), vec4(g_MaterialData_3._member0[(_549 + 380u) / 4u], g_MaterialData_3._member0[(_549 + 396u) / 4u], g_MaterialData_3._member0[(_549 + 412u) / 4u], g_MaterialData_3._member0[(_549 + 428u) / 4u]));
	    float _589 = g_MaterialData_3._member0[(_549 + 564u) / 4u];
	    float _588 = g_MaterialData_3._member0[(_549 + 568u) / 4u];
	    bool _587 = g_MaterialData_5._member0[(_549 + 572u) / 4u] != 0;
	    float _586 = g_MaterialData_3._member0[(_549 + 576u) / 4u];
	    uvec3 _703;
	    do
	    {
	        if (g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nBufferStrideInBytes.w == 4)
	        {
	            uint _1006 = (12u * uint(gl_PrimitiveID)) + uint(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nBufferBindOffsetBytes.w);
	            _703 = uvec3(g_Indices_1[nonuniformEXT(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nVertexAndIndexBuffers.w)]._member0[_1006 / 4u], g_Indices_1[nonuniformEXT(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nVertexAndIndexBuffers.w)]._member0[(_1006 + 4u) / 4u], g_Indices_1[nonuniformEXT(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nVertexAndIndexBuffers.w)]._member0[(_1006 + 8u) / 4u]);
	            break;
	        }
	        else
	        {
	            uint _985 = (6u * uint(gl_PrimitiveID)) + uint(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nBufferBindOffsetBytes.w);
	            uint _986 = _985 & 4294967292u;
	            uint _56 = _986 / 4u;
	            uint _59 = (_986 + 4u) / 4u;
	            uint _990 = (g_Indices_1[nonuniformEXT(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nVertexAndIndexBuffers.w)]._member0[_56] & 4294901760u) >> uint(16);
	            uint _991 = g_Indices_1[nonuniformEXT(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nVertexAndIndexBuffers.w)]._member0[_59] & 65535u;
	            uvec3 _704;
	            if (_985 == _986)
	            {
	                _704 = uvec3(g_Indices_1[nonuniformEXT(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nVertexAndIndexBuffers.w)]._member0[_56] & 65535u, _990, _991);
	            }
	            else
	            {
	                _704 = uvec3(_990, _991, (g_Indices_1[nonuniformEXT(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nVertexAndIndexBuffers.w)]._member0[_59] & 4294901760u) >> uint(16));
	            }
	            _703 = _704;
	            break;
	        }
	        break;
	    } while(false);
	    uint _72 = uint(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nVertexAndIndexBuffers.x);
	    uvec3 _1028 = (uvec3(uint(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nBufferStrideInBytes.x)) * _703) + uvec3(uint(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nBufferBindOffsetBytes.x));
	    vec3 _698[3];
	    uint _1030 = _1028.x;
	    _698[0] = vec3(g_Vertices_1[nonuniformEXT(_72)]._member0[_1030 / 4u], g_Vertices_1[nonuniformEXT(_72)]._member0[(_1030 + 4u) / 4u], g_Vertices_1[nonuniformEXT(_72)]._member0[(_1030 + 8u) / 4u]);
	    uint _1035 = _1028.y;
	    _698[1] = vec3(g_Vertices_1[nonuniformEXT(_72)]._member0[_1035 / 4u], g_Vertices_1[nonuniformEXT(_72)]._member0[(_1035 + 4u) / 4u], g_Vertices_1[nonuniformEXT(_72)]._member0[(_1035 + 8u) / 4u]);
	    uint _1040 = _1028.z;
	    _698[2] = vec3(g_Vertices_1[nonuniformEXT(_72)]._member0[_1040 / 4u], g_Vertices_1[nonuniformEXT(_72)]._member0[(_1040 + 4u) / 4u], g_Vertices_1[nonuniformEXT(_72)]._member0[(_1040 + 8u) / 4u]);
	    int _699 = 0;
	    VS_INPUT vsInput[3];
	    for (;;)
	    {
	        if (!(_699 < 3))
	        {
	            break;
	        }
	        vsInput[_699].vPositionOs = _698[_699];
	        _699++;
	        continue;
	    }
	    vec2 _700[3];
	    _700[0] = vec2(0.0);
	    _700[1] = vec2(0.0);
	    _700[2] = vec2(0.0);
	    if (g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vTexCoordFieldInfo.data[0].y != 0)
	    {
	        ivec4 _697 = g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nVertexAndIndexBuffers;
	        uint _101 = uint(_697[g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vTexCoordFieldInfo.data[0].z]);
	        uint _1082 = uint(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vTexCoordFieldInfo.data[0].z);
	        ivec4 _695 = g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nBufferStrideInBytes;
	        ivec4 _696 = g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nBufferBindOffsetBytes;
	        uvec3 _1098 = (uvec3(uint(_695[_1082])) * _703) + uvec3(uint(_696[_1082]) + uint(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vTexCoordFieldInfo.data[0].x));
	        if (g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vTexCoordFieldInfo.data[0].y == 16)
	        {
	            uint _1212 = _1098.x;
	            _700[0] = vec2(g_Vertices_1[nonuniformEXT(_101)]._member0[_1212 / 4u], g_Vertices_1[nonuniformEXT(_101)]._member0[(_1212 + 4u) / 4u]);
	            uint _1215 = _1098.y;
	            _700[1] = vec2(g_Vertices_1[nonuniformEXT(_101)]._member0[_1215 / 4u], g_Vertices_1[nonuniformEXT(_101)]._member0[(_1215 + 4u) / 4u]);
	            uint _1218 = _1098.z;
	            _700[2] = vec2(g_Vertices_1[nonuniformEXT(_101)]._member0[_1218 / 4u], g_Vertices_1[nonuniformEXT(_101)]._member0[(_1218 + 4u) / 4u]);
	        }
	        else
	        {
	            if (g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vTexCoordFieldInfo.data[0].y == 34)
	            {
	                uint _113 = _1098.x / 4u;
	                _700[0] = vec2(uint16BitsToFloat16(u16vec2(uvec2(g_Vertices_3[nonuniformEXT(_101)]._member0[_113], g_Vertices_3[nonuniformEXT(_101)]._member0[_113] >> uint(16)) & uvec2(65535u))));
	                uint _116 = _1098.y / 4u;
	                _700[1] = vec2(uint16BitsToFloat16(u16vec2(uvec2(g_Vertices_3[nonuniformEXT(_101)]._member0[_116], g_Vertices_3[nonuniformEXT(_101)]._member0[_116] >> uint(16)) & uvec2(65535u))));
	                uint _119 = _1098.z / 4u;
	                _700[2] = vec2(uint16BitsToFloat16(u16vec2(uvec2(g_Vertices_3[nonuniformEXT(_101)]._member0[_119], g_Vertices_3[nonuniformEXT(_101)]._member0[_119] >> uint(16)) & uvec2(65535u))));
	            }
	            else
	            {
	                if (g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vTexCoordFieldInfo.data[0].y == 37)
	                {
	                    uint _103 = _1098.x / 4u;
	                    uint _1111 = g_Vertices_3[nonuniformEXT(_101)]._member0[_103] & 65535u;
	                    int _694;
	                    if (_1111 > 32767u)
	                    {
	                        _694 = int(4294901760u | _1111);
	                    }
	                    else
	                    {
	                        _694 = int(_1111);
	                    }
	                    uint _1124 = (g_Vertices_3[nonuniformEXT(_101)]._member0[_103] & 4294901760u) >> uint(16);
	                    int _693;
	                    if (_1124 > 32767u)
	                    {
	                        _693 = int(4294901760u | _1124);
	                    }
	                    else
	                    {
	                        _693 = int(_1124);
	                    }
	                    _700[0] = vec2(max(float(_694) * 3.0518509447574615478515625e-05, -1.0), max(float(_693) * 3.0518509447574615478515625e-05, -1.0));
	                    uint _106 = _1098.y / 4u;
	                    uint _1138 = g_Vertices_3[nonuniformEXT(_101)]._member0[_106] & 65535u;
	                    int _692;
	                    if (_1138 > 32767u)
	                    {
	                        _692 = int(4294901760u | _1138);
	                    }
	                    else
	                    {
	                        _692 = int(_1138);
	                    }
	                    uint _1151 = (g_Vertices_3[nonuniformEXT(_101)]._member0[_106] & 4294901760u) >> uint(16);
	                    int _691;
	                    if (_1151 > 32767u)
	                    {
	                        _691 = int(4294901760u | _1151);
	                    }
	                    else
	                    {
	                        _691 = int(_1151);
	                    }
	                    _700[1] = vec2(max(float(_692) * 3.0518509447574615478515625e-05, -1.0), max(float(_691) * 3.0518509447574615478515625e-05, -1.0));
	                    uint _109 = _1098.z / 4u;
	                    uint _1165 = g_Vertices_3[nonuniformEXT(_101)]._member0[_109] & 65535u;
	                    int _690;
	                    if (_1165 > 32767u)
	                    {
	                        _690 = int(4294901760u | _1165);
	                    }
	                    else
	                    {
	                        _690 = int(_1165);
	                    }
	                    uint _1178 = (g_Vertices_3[nonuniformEXT(_101)]._member0[_109] & 4294901760u) >> uint(16);
	                    int _689;
	                    if (_1178 > 32767u)
	                    {
	                        _689 = int(4294901760u | _1178);
	                    }
	                    else
	                    {
	                        _689 = int(_1178);
	                    }
	                    _700[2] = vec2(max(float(_690) * 3.0518509447574615478515625e-05, -1.0), max(float(_689) * 3.0518509447574615478515625e-05, -1.0));
	                }
	            }
	        }
	    }
	    _699 = 0;
	    for (;;)
	    {
	        if (!(_699 < 3))
	        {
	            break;
	        }
	        vsInput[_699].vTexCoord = _700[_699];
	        _699++;
	        continue;
	    }
	    vec3 _701[3];
	    vec4 _702[3];
	    do
	    {
	        if (g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vNormalFieldInfo.y != 0)
	        {
	            ivec4 _675 = g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nVertexAndIndexBuffers;
	            uint _141 = uint(_675[g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vNormalFieldInfo.z]);
	            uint _1262 = uint(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vNormalFieldInfo.z);
	            ivec4 _673 = g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nBufferStrideInBytes;
	            ivec4 _674 = g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nBufferBindOffsetBytes;
	            uvec3 _1278 = (uvec3(uint(_673[_1262])) * _703) + uvec3(uint(_674[_1262]) + uint(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vNormalFieldInfo.x));
	            if (g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vNormalFieldInfo.y == 6)
	            {
	                uint _1779 = _1278.x;
	                _701[0] = vec3(g_Vertices_1[nonuniformEXT(_141)]._member0[_1779 / 4u], g_Vertices_1[nonuniformEXT(_141)]._member0[(_1779 + 4u) / 4u], g_Vertices_1[nonuniformEXT(_141)]._member0[(_1779 + 8u) / 4u]);
	                uint _1784 = _1278.y;
	                _701[1] = vec3(g_Vertices_1[nonuniformEXT(_141)]._member0[_1784 / 4u], g_Vertices_1[nonuniformEXT(_141)]._member0[(_1784 + 4u) / 4u], g_Vertices_1[nonuniformEXT(_141)]._member0[(_1784 + 8u) / 4u]);
	                uint _1789 = _1278.z;
	                _701[2] = vec3(g_Vertices_1[nonuniformEXT(_141)]._member0[_1789 / 4u], g_Vertices_1[nonuniformEXT(_141)]._member0[(_1789 + 4u) / 4u], g_Vertices_1[nonuniformEXT(_141)]._member0[(_1789 + 8u) / 4u]);
	            }
	            else
	            {
	                if (g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vNormalFieldInfo.y == 17)
	                {
	                    uint _1533 = _1278.x;
	                    uvec2 _1535 = uvec2(g_Vertices_3[nonuniformEXT(_141)]._member0[_1533 / 4u], g_Vertices_3[nonuniformEXT(_141)]._member0[(_1533 + 4u) / 4u]);
	                    uint _1536 = _1278.y;
	                    uvec2 _538 = uvec2(g_Vertices_3[nonuniformEXT(_141)]._member0[_1536 / 4u], g_Vertices_3[nonuniformEXT(_141)]._member0[(_1536 + 4u) / 4u]);
	                    uint _1539 = _1278.z;
	                    uvec2 _537 = uvec2(g_Vertices_3[nonuniformEXT(_141)]._member0[_1539 / 4u], g_Vertices_3[nonuniformEXT(_141)]._member0[(_1539 + 4u) / 4u]);
	                    uint _1545 = _1535.x;
	                    uint _1553 = _1535.y;
	                    vec2 _1563 = ((vec2(float(_1545 & 65535u), float((_1545 >> 16u) & 65535u)) * vec2(1.525902189314365386962890625e-05)) * 2.0) - vec2(1.0);
	                    float _1564 = _1563.x;
	                    float _1569 = (1.0 - abs(_1564)) - abs(_1563.y);
	                    vec3 _1570 = vec3(_1564, _1563.y, _1569);
	                    float _1572 = saturate(-_1569);
	                    vec2 _1578 = _1563 + mix(vec2(_1572), vec2(-_1572), greaterThanEqual(_1563, vec2(0.0)));
	                    _1570.x = _1578.x;
	                    _1570.y = _1578.y;
	                    vec3 _677 = normalize(_1570);
	                    vec2 _1585 = ((vec2(float((_1553 >> uint(1)) & 32767u), float((_1553 >> 16u) & 32767u)) * vec2(3.0518509447574615478515625e-05)) * 2.0) - vec2(1.0);
	                    float _1586 = _1585.x;
	                    float _1591 = (1.0 - abs(_1586)) - abs(_1585.y);
	                    vec3 _1592 = vec3(_1586, _1585.y, _1591);
	                    float _1594 = saturate(-_1591);
	                    vec2 _1600 = _1585 + mix(vec2(_1594), vec2(-_1594), greaterThanEqual(_1585, vec2(0.0)));
	                    _1592.x = _1600.x;
	                    _1592.y = _1600.y;
	                    vec3 _676 = normalize(_1592);
	                    float _663;
	                    if ((_1553 & 1u) != 0u)
	                    {
	                        _663 = 1.0;
	                    }
	                    else
	                    {
	                        _663 = -1.0;
	                    }
	                    _701[0] = _677;
	                    _702[0].w = _663;
	                    _702[0].x = _676.x;
	                    _702[0].y = _676.y;
	                    _702[0].z = _676.z;
	                    vec2 _1642 = ((vec2(float(_538.x & 65535u), float((_538.x >> 16u) & 65535u)) * vec2(1.525902189314365386962890625e-05)) * 2.0) - vec2(1.0);
	                    float _1643 = _1642.x;
	                    float _1648 = (1.0 - abs(_1643)) - abs(_1642.y);
	                    vec3 _1649 = vec3(_1643, _1642.y, _1648);
	                    float _1651 = saturate(-_1648);
	                    vec2 _1657 = _1642 + mix(vec2(_1651), vec2(-_1651), greaterThanEqual(_1642, vec2(0.0)));
	                    _1649.x = _1657.x;
	                    _1649.y = _1657.y;
	                    vec3 _679 = normalize(_1649);
	                    vec2 _1664 = ((vec2(float((_538.y >> uint(1)) & 32767u), float((_538.y >> 16u) & 32767u)) * vec2(3.0518509447574615478515625e-05)) * 2.0) - vec2(1.0);
	                    float _1665 = _1664.x;
	                    float _1670 = (1.0 - abs(_1665)) - abs(_1664.y);
	                    vec3 _1671 = vec3(_1665, _1664.y, _1670);
	                    float _1673 = saturate(-_1670);
	                    vec2 _1679 = _1664 + mix(vec2(_1673), vec2(-_1673), greaterThanEqual(_1664, vec2(0.0)));
	                    _1671.x = _1679.x;
	                    _1671.y = _1679.y;
	                    vec3 _678 = normalize(_1671);
	                    float _662;
	                    if ((_538.y & 1u) != 0u)
	                    {
	                        _662 = 1.0;
	                    }
	                    else
	                    {
	                        _662 = -1.0;
	                    }
	                    _701[1] = _679;
	                    _702[1].w = _662;
	                    _702[1].x = _678.x;
	                    _702[1].y = _678.y;
	                    _702[1].z = _678.z;
	                    vec2 _1721 = ((vec2(float(_537.x & 65535u), float((_537.x >> 16u) & 65535u)) * vec2(1.525902189314365386962890625e-05)) * 2.0) - vec2(1.0);
	                    float _1722 = _1721.x;
	                    float _1727 = (1.0 - abs(_1722)) - abs(_1721.y);
	                    vec3 _1728 = vec3(_1722, _1721.y, _1727);
	                    float _1730 = saturate(-_1727);
	                    vec2 _1736 = _1721 + mix(vec2(_1730), vec2(-_1730), greaterThanEqual(_1721, vec2(0.0)));
	                    _1728.x = _1736.x;
	                    _1728.y = _1736.y;
	                    vec3 _681 = normalize(_1728);
	                    vec2 _1743 = ((vec2(float((_537.y >> uint(1)) & 32767u), float((_537.y >> 16u) & 32767u)) * vec2(3.0518509447574615478515625e-05)) * 2.0) - vec2(1.0);
	                    float _1744 = _1743.x;
	                    float _1749 = (1.0 - abs(_1744)) - abs(_1743.y);
	                    vec3 _1750 = vec3(_1744, _1743.y, _1749);
	                    float _1752 = saturate(-_1749);
	                    vec2 _1758 = _1743 + mix(vec2(_1752), vec2(-_1752), greaterThanEqual(_1743, vec2(0.0)));
	                    _1750.x = _1758.x;
	                    _1750.y = _1758.y;
	                    vec3 _680 = normalize(_1750);
	                    float _661;
	                    if ((_537.y & 1u) != 0u)
	                    {
	                        _661 = 1.0;
	                    }
	                    else
	                    {
	                        _661 = -1.0;
	                    }
	                    _701[2] = _681;
	                    _702[2].w = _661;
	                    _702[2].x = _680.x;
	                    _702[2].y = _680.y;
	                    _702[2].z = _680.z;
	                    break;
	                }
	                else
	                {
	                    uint _143 = _1278.x / 4u;
	                    vec4 _683 = _702[0];
	                    float _1300 = (float((g_Vertices_3[nonuniformEXT(_141)]._member0[_143] >> 12u) & 1023u) * 0.00195503421127796173095703125) - 1.0;
	                    float _1303 = (float((g_Vertices_3[nonuniformEXT(_141)]._member0[_143] >> 22u) & 1023u) * 0.00195503421127796173095703125) - 1.0;
	                    float _1307 = (1.0 - abs(_1300)) - abs(_1303);
	                    vec3 _1308 = vec3(_1300, _1303, _1307);
	                    float _1310 = saturate(-_1307);
	                    vec2 _1311 = vec2(_1300, _1303);
	                    vec2 _1317 = _1311 + mix(vec2(_1310), vec2(-_1310), greaterThanEqual(_1311, vec2(0.0)));
	                    _1308.x = _1317.x;
	                    _1308.y = _1317.y;
	                    vec3 _1322 = normalize(_1308);
	                    vec3 _682 = _1322;
	                    float _1323 = _1322.z;
	                    float _670;
	                    if (_1323 >= 0.0)
	                    {
	                        _670 = 1.0;
	                    }
	                    else
	                    {
	                        _670 = -1.0;
	                    }
	                    float _1330 = (-1.0) / (_670 + _1323);
	                    float _1331 = _1322.x;
	                    vec3 _671;
	                    vec3 _1339 = _671;
	                    _1339.x = 1.0 + (((_670 * _1331) * _1331) * _1330);
	                    _1339.y = _670 * ((_1331 * _1322.y) * _1330);
	                    _1339.z = (-_670) * _1331;
	                    _671 = _1339;
	                    float _1347 = float((g_Vertices_3[nonuniformEXT(_141)]._member0[_143] >> uint(1)) & 2047u) * 0.003069460391998291015625;
	                    vec3 _1353 = (_1339 * cos(_1347)) + (cross(_1322, _1339) * sin(_1347));
	                    vec4 _1355 = _683;
	                    _1355.x = _1353.x;
	                    _1355.y = _1353.y;
	                    _1355.z = _1353.z;
	                    _683 = _1355;
	                    float _672;
	                    if ((g_Vertices_3[nonuniformEXT(_141)]._member0[_143] & 1u) == 0u)
	                    {
	                        _672 = -1.0;
	                    }
	                    else
	                    {
	                        _672 = 1.0;
	                    }
	                    vec4 _1366 = _683;
	                    _1366.w = _672;
	                    _683 = _1366;
	                    _701[0] = _682;
	                    _702[0] = _1366;
	                    uint _146 = _1278.y / 4u;
	                    vec4 _685 = _702[1];
	                    float _1382 = (float((g_Vertices_3[nonuniformEXT(_141)]._member0[_146] >> 12u) & 1023u) * 0.00195503421127796173095703125) - 1.0;
	                    float _1385 = (float((g_Vertices_3[nonuniformEXT(_141)]._member0[_146] >> 22u) & 1023u) * 0.00195503421127796173095703125) - 1.0;
	                    float _1389 = (1.0 - abs(_1382)) - abs(_1385);
	                    vec3 _1390 = vec3(_1382, _1385, _1389);
	                    float _1392 = saturate(-_1389);
	                    vec2 _1393 = vec2(_1382, _1385);
	                    vec2 _1399 = _1393 + mix(vec2(_1392), vec2(-_1392), greaterThanEqual(_1393, vec2(0.0)));
	                    _1390.x = _1399.x;
	                    _1390.y = _1399.y;
	                    vec3 _1404 = normalize(_1390);
	                    vec3 _684 = _1404;
	                    float _1405 = _1404.z;
	                    float _667;
	                    if (_1405 >= 0.0)
	                    {
	                        _667 = 1.0;
	                    }
	                    else
	                    {
	                        _667 = -1.0;
	                    }
	                    float _1412 = (-1.0) / (_667 + _1405);
	                    float _1413 = _1404.x;
	                    vec3 _668;
	                    vec3 _1421 = _668;
	                    _1421.x = 1.0 + (((_667 * _1413) * _1413) * _1412);
	                    _1421.y = _667 * ((_1413 * _1404.y) * _1412);
	                    _1421.z = (-_667) * _1413;
	                    _668 = _1421;
	                    float _1429 = float((g_Vertices_3[nonuniformEXT(_141)]._member0[_146] >> uint(1)) & 2047u) * 0.003069460391998291015625;
	                    vec3 _1435 = (_1421 * cos(_1429)) + (cross(_1404, _1421) * sin(_1429));
	                    vec4 _1437 = _685;
	                    _1437.x = _1435.x;
	                    _1437.y = _1435.y;
	                    _1437.z = _1435.z;
	                    _685 = _1437;
	                    float _669;
	                    if ((g_Vertices_3[nonuniformEXT(_141)]._member0[_146] & 1u) == 0u)
	                    {
	                        _669 = -1.0;
	                    }
	                    else
	                    {
	                        _669 = 1.0;
	                    }
	                    vec4 _1448 = _685;
	                    _1448.w = _669;
	                    _685 = _1448;
	                    _701[1] = _684;
	                    _702[1] = _1448;
	                    uint _149 = _1278.z / 4u;
	                    vec4 _687 = _702[2];
	                    float _1464 = (float((g_Vertices_3[nonuniformEXT(_141)]._member0[_149] >> 12u) & 1023u) * 0.00195503421127796173095703125) - 1.0;
	                    float _1467 = (float((g_Vertices_3[nonuniformEXT(_141)]._member0[_149] >> 22u) & 1023u) * 0.00195503421127796173095703125) - 1.0;
	                    float _1471 = (1.0 - abs(_1464)) - abs(_1467);
	                    vec3 _1472 = vec3(_1464, _1467, _1471);
	                    float _1474 = saturate(-_1471);
	                    vec2 _1475 = vec2(_1464, _1467);
	                    vec2 _1481 = _1475 + mix(vec2(_1474), vec2(-_1474), greaterThanEqual(_1475, vec2(0.0)));
	                    _1472.x = _1481.x;
	                    _1472.y = _1481.y;
	                    vec3 _1486 = normalize(_1472);
	                    vec3 _686 = _1486;
	                    float _1487 = _1486.z;
	                    float _664;
	                    if (_1487 >= 0.0)
	                    {
	                        _664 = 1.0;
	                    }
	                    else
	                    {
	                        _664 = -1.0;
	                    }
	                    float _1494 = (-1.0) / (_664 + _1487);
	                    float _1495 = _1486.x;
	                    vec3 _665;
	                    vec3 _1503 = _665;
	                    _1503.x = 1.0 + (((_664 * _1495) * _1495) * _1494);
	                    _1503.y = _664 * ((_1495 * _1486.y) * _1494);
	                    _1503.z = (-_664) * _1495;
	                    _665 = _1503;
	                    float _1511 = float((g_Vertices_3[nonuniformEXT(_141)]._member0[_149] >> uint(1)) & 2047u) * 0.003069460391998291015625;
	                    vec3 _1517 = (_1503 * cos(_1511)) + (cross(_1486, _1503) * sin(_1511));
	                    vec4 _1519 = _687;
	                    _1519.x = _1517.x;
	                    _1519.y = _1517.y;
	                    _1519.z = _1517.z;
	                    _687 = _1519;
	                    float _666;
	                    if ((g_Vertices_3[nonuniformEXT(_141)]._member0[_149] & 1u) == 0u)
	                    {
	                        _666 = -1.0;
	                    }
	                    else
	                    {
	                        _666 = 1.0;
	                    }
	                    vec4 _1530 = _687;
	                    _1530.w = _666;
	                    _687 = _1530;
	                    _701[2] = _686;
	                    _702[2] = _1530;
	                    break;
	                }
	                break;
	            }
	        }
	        else
	        {
	            _701[0] = vec3(0.0);
	            _701[1] = vec3(0.0);
	            _701[2] = vec3(0.0);
	        }
	        if (g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vTangentFieldInfo.y != 0)
	        {
	            ivec4 _688 = g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nVertexAndIndexBuffers;
	            uint _199 = uint(_688[g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vTangentFieldInfo.z]);
	            uint _1808 = uint(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vTangentFieldInfo.z);
	            ivec4 _659 = g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nBufferStrideInBytes;
	            ivec4 _660 = g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nBufferBindOffsetBytes;
	            uvec3 _1824 = (uvec3(uint(_659[_1808])) * _703) + uvec3(uint(_660[_1808]) + uint(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vTangentFieldInfo.x));
	            uint _1826 = _1824.x;
	            _702[0] = vec4(g_Vertices_1[nonuniformEXT(_199)]._member0[_1826 / 4u], g_Vertices_1[nonuniformEXT(_199)]._member0[(_1826 + 4u) / 4u], g_Vertices_1[nonuniformEXT(_199)]._member0[(_1826 + 8u) / 4u], g_Vertices_1[nonuniformEXT(_199)]._member0[(_1826 + 12u) / 4u]);
	            uint _1832 = _1824.y;
	            _702[1] = vec4(g_Vertices_1[nonuniformEXT(_199)]._member0[_1832 / 4u], g_Vertices_1[nonuniformEXT(_199)]._member0[(_1832 + 4u) / 4u], g_Vertices_1[nonuniformEXT(_199)]._member0[(_1832 + 8u) / 4u], g_Vertices_1[nonuniformEXT(_199)]._member0[(_1832 + 12u) / 4u]);
	            uint _1838 = _1824.z;
	            _702[2] = vec4(g_Vertices_1[nonuniformEXT(_199)]._member0[_1838 / 4u], g_Vertices_1[nonuniformEXT(_199)]._member0[(_1838 + 4u) / 4u], g_Vertices_1[nonuniformEXT(_199)]._member0[(_1838 + 8u) / 4u], g_Vertices_1[nonuniformEXT(_199)]._member0[(_1838 + 12u) / 4u]);
	        }
	        else
	        {
	            _702[0] = vec4(0.0);
	            _702[1] = vec4(0.0);
	            _702[2] = vec4(0.0);
	        }
	        break;
	    } while(false);
	    _699 = 0;
	    for (;;)
	    {
	        if (!(_699 < 3))
	        {
	            break;
	        }
	        vsInput[_699].vNormalOs = _701[_699];
	        vsInput[_699].vTangentUOs_flTangentVSign = _702[_699];
	        _699++;
	        continue;
	    }
	    vec4 _705[3];
	    _705[0] = vec4(0.0);
	    _705[1] = vec4(0.0);
	    _705[2] = vec4(0.0);
	    if (g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vColorFieldInfo.data[0].y != 0)
	    {
	        ivec4 _658 = g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nVertexAndIndexBuffers;
	        uint _237 = uint(_658[g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vColorFieldInfo.data[0].z]);
	        uint _1884 = uint(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vColorFieldInfo.data[0].z);
	        ivec4 _656 = g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nBufferStrideInBytes;
	        ivec4 _657 = g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nBufferBindOffsetBytes;
	        uvec3 _1900 = (uvec3(uint(_656[_1884])) * _703) + uvec3(uint(_657[_1884]) + uint(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vColorFieldInfo.data[0].x));
	        if (g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vColorFieldInfo.data[0].y == 2)
	        {
	            uint _1941 = _1900.x;
	            _705[0] = vec4(g_Vertices_1[nonuniformEXT(_237)]._member0[_1941 / 4u], g_Vertices_1[nonuniformEXT(_237)]._member0[(_1941 + 4u) / 4u], g_Vertices_1[nonuniformEXT(_237)]._member0[(_1941 + 8u) / 4u], g_Vertices_1[nonuniformEXT(_237)]._member0[(_1941 + 12u) / 4u]);
	            uint _1946 = _1900.y;
	            _705[1] = vec4(g_Vertices_1[nonuniformEXT(_237)]._member0[_1946 / 4u], g_Vertices_1[nonuniformEXT(_237)]._member0[(_1946 + 4u) / 4u], g_Vertices_1[nonuniformEXT(_237)]._member0[(_1946 + 8u) / 4u], g_Vertices_1[nonuniformEXT(_237)]._member0[(_1946 + 12u) / 4u]);
	            uint _1951 = _1900.z;
	            _705[2] = vec4(g_Vertices_1[nonuniformEXT(_237)]._member0[_1951 / 4u], g_Vertices_1[nonuniformEXT(_237)]._member0[(_1951 + 4u) / 4u], g_Vertices_1[nonuniformEXT(_237)]._member0[(_1951 + 8u) / 4u], g_Vertices_1[nonuniformEXT(_237)]._member0[(_1951 + 12u) / 4u]);
	        }
	        else
	        {
	            if (g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vColorFieldInfo.data[0].y == 28)
	            {
	                uint _239 = _1900.x / 4u;
	                _705[0] = vec4(uvec4(g_Vertices_3[nonuniformEXT(_237)]._member0[_239] & 255u, (g_Vertices_3[nonuniformEXT(_237)]._member0[_239] & 65280u) >> uint(8), (g_Vertices_3[nonuniformEXT(_237)]._member0[_239] & 16711680u) >> uint(16), (g_Vertices_3[nonuniformEXT(_237)]._member0[_239] & 4278190080u) >> uint(24))) * vec4(0.0039215688593685626983642578125);
	                uint _242 = _1900.y / 4u;
	                _705[1] = vec4(uvec4(g_Vertices_3[nonuniformEXT(_237)]._member0[_242] & 255u, (g_Vertices_3[nonuniformEXT(_237)]._member0[_242] & 65280u) >> uint(8), (g_Vertices_3[nonuniformEXT(_237)]._member0[_242] & 16711680u) >> uint(16), (g_Vertices_3[nonuniformEXT(_237)]._member0[_242] & 4278190080u) >> uint(24))) * vec4(0.0039215688593685626983642578125);
	                uint _245 = _1900.z / 4u;
	                _705[2] = vec4(uvec4(g_Vertices_3[nonuniformEXT(_237)]._member0[_245] & 255u, (g_Vertices_3[nonuniformEXT(_237)]._member0[_245] & 65280u) >> uint(8), (g_Vertices_3[nonuniformEXT(_237)]._member0[_245] & 16711680u) >> uint(16), (g_Vertices_3[nonuniformEXT(_237)]._member0[_245] & 4278190080u) >> uint(24))) * vec4(0.0039215688593685626983642578125);
	            }
	        }
	    }
	    int _706 = 0;
	    for (;;)
	    {
	        if (!(_706 < 3))
	        {
	            break;
	        }
	        vsInput[_706].vBlendColorTint = _705[_706];
	        _706++;
	        continue;
	    }
	    vec2 _548 = vsInput[0].vTexCoord;
	    vec3 _654 = vsInput[0].vNormalOs;
	    vec4 _655;
	    vec4 _1982 = _655;
	    _1982.x = vsInput[0].vTangentUOs_flTangentVSign.x;
	    _1982.y = vsInput[0].vTangentUOs_flTangentVSign.y;
	    _1982.z = vsInput[0].vTangentUOs_flTangentVSign.z;
	    _1982.w = vsInput[0].vTangentUOs_flTangentVSign.w;
	    _655 = _1982;
	    vec4 _2005 = vec4(uvec4(g_instanceBuffer._member0[uint(gl_InstanceID)].nSrgbColor & 255u, (g_instanceBuffer._member0[uint(gl_InstanceID)].nSrgbColor & 65280u) >> uint(8), (g_instanceBuffer._member0[uint(gl_InstanceID)].nSrgbColor & 16711680u) >> uint(16), (g_instanceBuffer._member0[uint(gl_InstanceID)].nSrgbColor & 4278190080u) >> uint(24))) * vec4(0.0039215688593685626983642578125);
	    vec4 _653 = _2005;
	    vec3 _2006 = _2005.xyz;
	    vec3 _2007 = _2006 * vec3(0.077399380505084991455078125);
	    vec3 _2010 = pow((_2006 * vec3(0.947867333889007568359375)) + vec3(0.052132703363895416259765625), vec3(2.400000095367431640625));
	    float _650;
	    if (_2005.x <= 0.040449999272823333740234375)
	    {
	        _650 = _2007.x;
	    }
	    else
	    {
	        _650 = _2010.x;
	    }
	    float _651;
	    if (_2005.y <= 0.040449999272823333740234375)
	    {
	        _651 = _2007.y;
	    }
	    else
	    {
	        _651 = _2010.y;
	    }
	    float _652;
	    if (_2005.z <= 0.040449999272823333740234375)
	    {
	        _652 = _2007.z;
	    }
	    else
	    {
	        _652 = _2010.z;
	    }
	    vec3 _2035 = vec3(_650, _651, _652);
	    vec4 _2037 = _653;
	    _2037.x = _2035.x;
	    _2037.y = _2035.y;
	    _2037.z = _2035.z;
	    _653 = _2037;
	    vec4 _551;
	    vec4 _2044 = _551;
	    _2044.x = _2037.x;
	    _2044.y = _2037.y;
	    _2044.z = _2037.z;
	    _2044.w = _2037.w;
	    _551 = _2044;
	    mat3x4 _2055 = transpose(gl_WorldToObjectEXT);
	    mat3 _649;
	    mat3 _2058 = _649;
	    _2058[0] = _2055[0].xyz;
	    _2058[1] = _2055[1].xyz;
	    _2058[2] = _2055[2].xyz;
	    _649 = _2058;
	    vec3 _2067 = normalize(_2058 * _654.xyz);
	    vec3 _552;
	    vec3 _2069 = _552;
	    _2069.x = _2067.x;
	    _2069.y = _2067.y;
	    _2069.z = _2067.z;
	    _552 = _2069;
	    mat3x4 _2081 = transpose(gl_WorldToObjectEXT);
	    mat3 _648;
	    mat3 _2084 = _648;
	    _2084[0] = _2081[0].xyz;
	    _2084[1] = _2081[1].xyz;
	    _2084[2] = _2081[2].xyz;
	    _648 = _2084;
	    vec3 _2093 = normalize(_2084 * _655.xyz);
	    vec4 _550;
	    vec4 _2095 = _550;
	    _2095.x = _2093.x;
	    _2095.y = _2093.y;
	    _2095.z = _2093.z;
	    _2095.w = _655.w;
	    _550 = _2095;
	    vec4 _2104 = _548.xyxy;
	    vec4 _2117 = _2104;
	    _2117.x = dot(_2104.xy, _602.xy) + _602.w;
	    _2117.y = dot(_2104.xy, _601.xy) + _601.w;
	    vec2 _2125 = _2117.xy + (_600.xy * PerViewConstantBuffer_t.g_flGameTime);
	    vec4 _2127 = _2117;
	    _2127.x = _2125.x;
	    _2127.y = _2125.y;
	    vec3 _2133 = mix(vec3(1.0), _2044.xyz, vec3(_598));
	    vec4 _2135 = _2044;
	    _2135.x = _2133.x;
	    _2135.y = _2133.y;
	    _2135.z = _2133.z;
	    vec3 _2143 = _2135.xyz * _599.xyz;
	    vec4 _2145 = _2135;
	    _2145.x = _2143.x;
	    _2145.y = _2143.y;
	    _2145.z = _2143.z;
	    vec3 _536 = vec4(vsInput[0].vPositionOs.xyz, 1.0) * transpose(gl_ObjectToWorldEXT);
	    vec3 _535 = _2069;
	    vec4 _534 = _2127;
	    vec4 _533 = _2145;
	    vec4 _532 = _2095;
	    vec2 _547 = vsInput[1].vTexCoord;
	    vec3 _646 = vsInput[1].vNormalOs;
	    vec4 _647;
	    vec4 _2157 = _647;
	    _2157.x = vsInput[1].vTangentUOs_flTangentVSign.x;
	    _2157.y = vsInput[1].vTangentUOs_flTangentVSign.y;
	    _2157.z = vsInput[1].vTangentUOs_flTangentVSign.z;
	    _2157.w = vsInput[1].vTangentUOs_flTangentVSign.w;
	    _647 = _2157;
	    vec4 _2180 = vec4(uvec4(g_instanceBuffer._member0[uint(gl_InstanceID)].nSrgbColor & 255u, (g_instanceBuffer._member0[uint(gl_InstanceID)].nSrgbColor & 65280u) >> uint(8), (g_instanceBuffer._member0[uint(gl_InstanceID)].nSrgbColor & 16711680u) >> uint(16), (g_instanceBuffer._member0[uint(gl_InstanceID)].nSrgbColor & 4278190080u) >> uint(24))) * vec4(0.0039215688593685626983642578125);
	    vec4 _645 = _2180;
	    vec3 _2181 = _2180.xyz;
	    vec3 _2182 = _2181 * vec3(0.077399380505084991455078125);
	    vec3 _2185 = pow((_2181 * vec3(0.947867333889007568359375)) + vec3(0.052132703363895416259765625), vec3(2.400000095367431640625));
	    float _642;
	    if (_2180.x <= 0.040449999272823333740234375)
	    {
	        _642 = _2182.x;
	    }
	    else
	    {
	        _642 = _2185.x;
	    }
	    float _643;
	    if (_2180.y <= 0.040449999272823333740234375)
	    {
	        _643 = _2182.y;
	    }
	    else
	    {
	        _643 = _2185.y;
	    }
	    float _644;
	    if (_2180.z <= 0.040449999272823333740234375)
	    {
	        _644 = _2182.z;
	    }
	    else
	    {
	        _644 = _2185.z;
	    }
	    vec3 _2210 = vec3(_642, _643, _644);
	    vec4 _2212 = _645;
	    _2212.x = _2210.x;
	    _2212.y = _2210.y;
	    _2212.z = _2210.z;
	    _645 = _2212;
	    vec4 _554;
	    vec4 _2219 = _554;
	    _2219.x = _2212.x;
	    _2219.y = _2212.y;
	    _2219.z = _2212.z;
	    _2219.w = _2212.w;
	    _554 = _2219;
	    mat3x4 _2230 = transpose(gl_WorldToObjectEXT);
	    mat3 _641;
	    mat3 _2233 = _641;
	    _2233[0] = _2230[0].xyz;
	    _2233[1] = _2230[1].xyz;
	    _2233[2] = _2230[2].xyz;
	    _641 = _2233;
	    vec3 _2242 = normalize(_2233 * _646.xyz);
	    vec3 _555;
	    vec3 _2244 = _555;
	    _2244.x = _2242.x;
	    _2244.y = _2242.y;
	    _2244.z = _2242.z;
	    _555 = _2244;
	    mat3x4 _2256 = transpose(gl_WorldToObjectEXT);
	    mat3 _640;
	    mat3 _2259 = _640;
	    _2259[0] = _2256[0].xyz;
	    _2259[1] = _2256[1].xyz;
	    _2259[2] = _2256[2].xyz;
	    _640 = _2259;
	    vec3 _2268 = normalize(_2259 * _647.xyz);
	    vec4 _553;
	    vec4 _2270 = _553;
	    _2270.x = _2268.x;
	    _2270.y = _2268.y;
	    _2270.z = _2268.z;
	    _2270.w = _647.w;
	    _553 = _2270;
	    vec4 _2279 = _547.xyxy;
	    vec4 _2292 = _2279;
	    _2292.x = dot(_2279.xy, _602.xy) + _602.w;
	    _2292.y = dot(_2279.xy, _601.xy) + _601.w;
	    vec2 _2300 = _2292.xy + (_600.xy * PerViewConstantBuffer_t.g_flGameTime);
	    vec4 _2302 = _2292;
	    _2302.x = _2300.x;
	    _2302.y = _2300.y;
	    vec3 _2308 = mix(vec3(1.0), _2219.xyz, vec3(_598));
	    vec4 _2310 = _2219;
	    _2310.x = _2308.x;
	    _2310.y = _2308.y;
	    _2310.z = _2308.z;
	    vec3 _2318 = _2310.xyz * _599.xyz;
	    vec4 _2320 = _2310;
	    _2320.x = _2318.x;
	    _2320.y = _2318.y;
	    _2320.z = _2318.z;
	    vec3 _531 = vec4(vsInput[1].vPositionOs.xyz, 1.0) * transpose(gl_ObjectToWorldEXT);
	    vec3 _530 = _2244;
	    vec4 _529 = _2302;
	    vec4 _528 = _2320;
	    vec4 _527 = _2270;
	    vec2 _546 = vsInput[2].vTexCoord;
	    vec3 _638 = vsInput[2].vNormalOs;
	    vec4 _639;
	    vec4 _2332 = _639;
	    _2332.x = vsInput[2].vTangentUOs_flTangentVSign.x;
	    _2332.y = vsInput[2].vTangentUOs_flTangentVSign.y;
	    _2332.z = vsInput[2].vTangentUOs_flTangentVSign.z;
	    _2332.w = vsInput[2].vTangentUOs_flTangentVSign.w;
	    _639 = _2332;
	    vec4 _2355 = vec4(uvec4(g_instanceBuffer._member0[uint(gl_InstanceID)].nSrgbColor & 255u, (g_instanceBuffer._member0[uint(gl_InstanceID)].nSrgbColor & 65280u) >> uint(8), (g_instanceBuffer._member0[uint(gl_InstanceID)].nSrgbColor & 16711680u) >> uint(16), (g_instanceBuffer._member0[uint(gl_InstanceID)].nSrgbColor & 4278190080u) >> uint(24))) * vec4(0.0039215688593685626983642578125);
	    vec4 _637 = _2355;
	    vec3 _2356 = _2355.xyz;
	    vec3 _2357 = _2356 * vec3(0.077399380505084991455078125);
	    vec3 _2360 = pow((_2356 * vec3(0.947867333889007568359375)) + vec3(0.052132703363895416259765625), vec3(2.400000095367431640625));
	    float _634;
	    if (_2355.x <= 0.040449999272823333740234375)
	    {
	        _634 = _2357.x;
	    }
	    else
	    {
	        _634 = _2360.x;
	    }
	    float _635;
	    if (_2355.y <= 0.040449999272823333740234375)
	    {
	        _635 = _2357.y;
	    }
	    else
	    {
	        _635 = _2360.y;
	    }
	    float _636;
	    if (_2355.z <= 0.040449999272823333740234375)
	    {
	        _636 = _2357.z;
	    }
	    else
	    {
	        _636 = _2360.z;
	    }
	    vec3 _2385 = vec3(_634, _635, _636);
	    vec4 _2387 = _637;
	    _2387.x = _2385.x;
	    _2387.y = _2385.y;
	    _2387.z = _2385.z;
	    _637 = _2387;
	    vec4 _557;
	    vec4 _2394 = _557;
	    _2394.x = _2387.x;
	    _2394.y = _2387.y;
	    _2394.z = _2387.z;
	    _2394.w = _2387.w;
	    _557 = _2394;
	    mat3x4 _2405 = transpose(gl_WorldToObjectEXT);
	    mat3 _633;
	    mat3 _2408 = _633;
	    _2408[0] = _2405[0].xyz;
	    _2408[1] = _2405[1].xyz;
	    _2408[2] = _2405[2].xyz;
	    _633 = _2408;
	    vec3 _2417 = normalize(_2408 * _638.xyz);
	    vec3 _558;
	    vec3 _2419 = _558;
	    _2419.x = _2417.x;
	    _2419.y = _2417.y;
	    _2419.z = _2417.z;
	    _558 = _2419;
	    vec3 _2427 = vec4(vsInput[2].vPositionOs.xyz, 1.0) * transpose(gl_ObjectToWorldEXT);
	    mat3x4 _2431 = transpose(gl_WorldToObjectEXT);
	    mat3 _632;
	    mat3 _2434 = _632;
	    _2434[0] = _2431[0].xyz;
	    _2434[1] = _2431[1].xyz;
	    _2434[2] = _2431[2].xyz;
	    _632 = _2434;
	    vec3 _2443 = normalize(_2434 * _639.xyz);
	    vec4 _556;
	    vec4 _2445 = _556;
	    _2445.x = _2443.x;
	    _2445.y = _2443.y;
	    _2445.z = _2443.z;
	    _2445.w = _639.w;
	    _556 = _2445;
	    vec4 _2454 = _546.xyxy;
	    vec4 _2467 = _2454;
	    _2467.x = dot(_2454.xy, _602.xy) + _602.w;
	    _2467.y = dot(_2454.xy, _601.xy) + _601.w;
	    vec2 _2475 = _2467.xy + (_600.xy * PerViewConstantBuffer_t.g_flGameTime);
	    vec4 _2477 = _2467;
	    _2477.x = _2475.x;
	    _2477.y = _2475.y;
	    vec3 _2483 = mix(vec3(1.0), _2394.xyz, vec3(_598));
	    vec4 _2485 = _2394;
	    _2485.x = _2483.x;
	    _2485.y = _2483.y;
	    _2485.z = _2483.z;
	    vec3 _2493 = _2485.xyz * _599.xyz;
	    vec4 _2495 = _2485;
	    _2495.x = _2493.x;
	    _2495.y = _2493.y;
	    _2495.z = _2493.z;
	    vec3 _526 = _2427;
	    vec3 _525 = _2419;
	    vec3 _2520 = ((_535 * ((1.0 - attrs.barycentrics.x) - attrs.barycentrics.y)) + (_530 * attrs.barycentrics.x)) + (_2419 * attrs.barycentrics.y);
	    vec3 _559;
	    vec3 _545 = _2520;
	    vec4 _544 = ((_534 * ((1.0 - attrs.barycentrics.x) - attrs.barycentrics.y)) + (_529 * attrs.barycentrics.x)) + (_2477 * attrs.barycentrics.y);
	    vec4 _543 = ((_533 * ((1.0 - attrs.barycentrics.x) - attrs.barycentrics.y)) + (_528 * attrs.barycentrics.x)) + (_2495 * attrs.barycentrics.y);
	    vec3 _542 = _559;
	    vec4 _541 = ((_532 * ((1.0 - attrs.barycentrics.x) - attrs.barycentrics.y)) + (_527 * attrs.barycentrics.x)) + (_2445 * attrs.barycentrics.y);
	    vec3 _540 = normalize(cross(_531 - _536, _2427 - _536));
	    bool _539 = gl_HitKindEXT == 254u;
	    vec3 _585 = vec3(0.0);
	    float _584 = 0.039999999105930328369140625;
	    vec3 _583 = vec3(0.0);
	    vec3 _581 = vec3(1.0);
	    bool _580 = false;
	    vec3 _2555 = _2520.xyz;
	    vec3 _582 = _2555;
	    if (dot(_2555, _2555) >= 1.0099999904632568359375)
	    {
	        _582 = _542.xyz;
	    }
	    _584 = _594;
	    _581 = _540;
	    bool _627;
	    if (_595)
	    {
	        _627 = !_596;
	    }
	    else
	    {
	        _627 = false;
	    }
	    SPIRV_CROSS_BRANCH
	    if (_627)
	    {
	        float _628;
	        if (_539)
	        {
	            _628 = 1.0;
	        }
	        else
	        {
	            _628 = -1.0;
	        }
	        _582 *= _628;
	        if (_539)
	        {
	            _628 = 1.0;
	        }
	        else
	        {
	            _628 = -1.0;
	        }
	        _581 *= _628;
	        _580 = !_539;
	    }
	    vec3 _2587 = _582;
	    vec3 _2588 = normalize(_2587);
	    _582 = _2588;
	    vec3 _576 = _585;
	    float _575 = _584;
	    vec3 _574 = _583;
	    vec3 _573 = _2588;
	    vec3 _572 = _581;
	    bool _571 = _580;
	    vec3 _579 = textureLod(nonuniformEXT(sampler2D(g_bindless_Texture2D_float4[_597], g_bindless_Sampler[_603])), _544.xy, 0.0).xyz * _543.xyz;
	    float _577 = 0.0;
	    vec4 _2608 = textureLod(nonuniformEXT(sampler2D(g_bindless_Texture2D_float4[_593], g_bindless_Sampler[_604])), _544.xy, 0.0);
	    float _2609 = _2608.x;
	    float _2610 = _2608.y;
	    float _2612 = (_2609 + _2610) - 1.00392162799835205078125;
	    float _2613 = _2609 - _2610;
	    vec2 _578 = _2608.zz;
	    vec3 _625 = normalize(vec3(vec2(_2612, _2613), (1.0 - abs(_2612)) - abs(_2613)));
	    bool _623;
	    if (_595)
	    {
	        _623 = !_596;
	    }
	    else
	    {
	        _623 = false;
	    }
	    if (_623)
	    {
	        float _624;
	        if (_539)
	        {
	            _624 = 1.0;
	        }
	        else
	        {
	            _624 = -1.0;
	        }
	        _623 = _624 < 0.0;
	    }
	    else
	    {
	        _623 = false;
	    }
	    float _626;
	    if (_623)
	    {
	        _626 = -1.0;
	    }
	    else
	    {
	        _626 = 1.0;
	    }
	    float _2644 = _626;
	    vec3 _2645 = _545.xyz * _2644;
	    if (_541.w > 0.0)
	    {
	        _626 = 1.0;
	    }
	    else
	    {
	        _626 = -1.0;
	    }
	    bool _621;
	    if (_595)
	    {
	        _621 = !_596;
	    }
	    else
	    {
	        _621 = false;
	    }
	    if (_621)
	    {
	        float _622;
	        if (_539)
	        {
	            _622 = 1.0;
	        }
	        else
	        {
	            _622 = -1.0;
	        }
	        _621 = _622 < 0.0;
	    }
	    else
	    {
	        _621 = false;
	    }
	    if (!_621)
	    {
	        vec3 _2677 = _625;
	        _2677.y = -_2677.y;
	        _625 = _2677;
	    }
	    vec3 _2684 = _541.xyz * _625.x;
	    vec3 _620;
	    vec3 _2686 = _620;
	    _2686.x = _2684.x;
	    _2686.y = _2684.y;
	    _2686.z = _2684.z;
	    vec3 _2696 = _2686.xyz + ((cross(_2645.xyz, _541.xyz) * _626).xyz * _625.y);
	    vec3 _2698 = _2686;
	    _2698.x = _2696.x;
	    _2698.y = _2696.y;
	    _2698.z = _2696.z;
	    vec3 _2707 = _2698.xyz + (_2645.xyz * _625.z);
	    vec3 _2709 = _2698;
	    _2709.x = _2707.x;
	    _2709.y = _2707.y;
	    _2709.z = _2707.z;
	    _620 = _2709;
	    vec3 _570 = normalize(_2709.xyz);
	    vec3 _569 = _579;
	    vec2 _568 = _578;
	    float _567 = _577;
	    vec3 _566 = _576;
	    float _565 = _575;
	    vec3 _564 = _574;
	    vec3 _563 = _573;
	    vec3 _562 = _572;
	    bool _561 = _571;
	    vec3 _560 = _625;
	    vec4 _2742 = max(vec4((vec4(vec4(_579.xyz, 1.0).xyz, 1.0) * _591).xyz, 1.0), vec4(0.0));
	    vec3 _629;
	    if (_592)
	    {
	        _629 = max(vec4((vec4(vec4(_579.xyz, 1.0).xyz, 1.0) * _590).xyz, 1.0), vec4(0.0)).xyz;
	    }
	    else
	    {
	        _629 = _569.xyz;
	    }
	    vec3 _2752 = _569;
	    vec3 _2753 = _2752;
	    _2753.x = _629.x;
	    vec3 _2755 = _2752;
	    _2755.y = _629.y;
	    vec3 _2757 = _2752;
	    _2757.z = _629.z;
	    vec3 _2759 = _2752;
	    _2759.x = _2742.x;
	    _2759.y = _2742.y;
	    _2759.z = _2742.z;
	    _569 = _2759;
	    SPIRV_CROSS_BRANCH
	    if (_586 != 1.0)
	    {
	        vec3 _2768 = _560;
	        vec2 _2771 = _2768.yx * _586;
	        vec3 _2773 = _2768;
	        _2773.y = _2771.x;
	        _2773.x = _2771.y;
	        _560 = _2773;
	        vec3 _618 = _2773;
	        bool _616;
	        if (_595)
	        {
	            _616 = !_596;
	        }
	        else
	        {
	            _616 = false;
	        }
	        if (_616)
	        {
	            float _617;
	            if (_539)
	            {
	                _617 = 1.0;
	            }
	            else
	            {
	                _617 = -1.0;
	            }
	            _616 = _617 < 0.0;
	        }
	        else
	        {
	            _616 = false;
	        }
	        float _619;
	        if (_616)
	        {
	            _619 = -1.0;
	        }
	        else
	        {
	            _619 = 1.0;
	        }
	        float _2798 = _619;
	        vec3 _2799 = _545.xyz * _2798;
	        if (_541.w > 0.0)
	        {
	            _619 = 1.0;
	        }
	        else
	        {
	            _619 = -1.0;
	        }
	        bool _614;
	        if (_595)
	        {
	            _614 = !_596;
	        }
	        else
	        {
	            _614 = false;
	        }
	        if (_614)
	        {
	            float _615;
	            if (_539)
	            {
	                _615 = 1.0;
	            }
	            else
	            {
	                _615 = -1.0;
	            }
	            _614 = _615 < 0.0;
	        }
	        else
	        {
	            _614 = false;
	        }
	        if (!_614)
	        {
	            vec3 _2831 = _618;
	            _2831.y = -_2831.y;
	            _618 = _2831;
	        }
	        _560 = _618;
	        vec3 _2838 = _541.xyz * _618.x;
	        vec3 _613;
	        vec3 _2840 = _613;
	        _2840.x = _2838.x;
	        _2840.y = _2838.y;
	        _2840.z = _2838.z;
	        vec3 _2850 = _2840.xyz + ((cross(_2799.xyz, _541.xyz) * _619).xyz * _618.y);
	        vec3 _2852 = _2840;
	        _2852.x = _2850.x;
	        _2852.y = _2850.y;
	        _2852.z = _2850.z;
	        vec3 _2861 = _2852.xyz + (_2799.xyz * _618.z);
	        vec3 _2863 = _2852;
	        _2863.x = _2861.x;
	        _2863.y = _2861.y;
	        _2863.z = _2861.z;
	        _613 = _2863;
	        _570 = normalize(_2863.xyz);
	    }
	    float _630;
	    if (_587)
	    {
	        _630 = _589;
	    }
	    else
	    {
	        _630 = _589;
	    }
	    float _631;
	    if (_587)
	    {
	        _631 = _588;
	    }
	    else
	    {
	        _631 = _588;
	    }
	    vec2 _2882 = _568;
	    vec2 _2887 = ((_2882.xy - vec2(0.5)) * _630) + vec2(0.5);
	    vec2 _2889 = _2882;
	    _2889.x = _2887.x;
	    _2889.y = _2887.y;
	    vec2 _2895 = saturate(_2889.xy * _631);
	    vec2 _2897 = _2889;
	    _2897.x = _2895.x;
	    _2897.y = _2895.y;
	    _568 = _2897;
	    payload.nInstance = int(uint(gl_InstanceID));
	    payload.flHitT = gl_RayTmaxEXT;
	    payload.vFaceNormalWs = _562;
	    payload.vInterpolatedNormalWs = _563;
	    vec3 _611[3] = vec3[](_536, _531, _526);
	    vec3 _612[3] = vec3[](_535, _530, _525);
	    vec3 _2940 = ((_611[0] * ((1.0 - attrs.barycentrics.x) - attrs.barycentrics.y)) + (_611[1] * attrs.barycentrics.x)) + (_611[2] * attrs.barycentrics.y);
	    vec3 _605[3];
	    _605[0] = _2940 - (_612[0] * dot(_2940 - _611[0], _612[0]));
	    _605[1] = _2940 - (_612[1] * dot(_2940 - _611[1], _612[1]));
	    _605[2] = _2940 - (_612[2] * dot(_2940 - _611[2], _612[2]));
	    vec3 _2980 = ((_605[0] * ((1.0 - attrs.barycentrics.x) - attrs.barycentrics.y)) + (_605[1] * attrs.barycentrics.x)) + (_605[2] * attrs.barycentrics.y);
	    vec3 _606[3];
	    _606[0] = cross(_611[0] - _611[1], _562);
	    _606[1] = cross(_611[1] - _611[2], _562);
	    _606[2] = cross(_611[2] - _611[0], _562);
	    float _607 = dot(_2980 - _2940, _562);
	    vec3 _608 = _2980;
	    int _609 = 0;
	    for (;;)
	    {
	        bool _2996_ladder_break = false;
	        do
	        {
	            if (!(_609 < 3))
	            {
	                _2996_ladder_break = true;
	                break;
	            }
	            if (_607 > 0.00999999977648258209228515625)
	            {
	                _2996_ladder_break = true;
	                break;
	            }
	            if (dot(_606[_609], _606[_609]) == 0.0)
	            {
	                break;
	            }
	            _606[_609] = normalize(_606[_609]);
	            int _610 = 0;
	            for (;;)
	            {
	                if (!(_610 < 3))
	                {
	                    break;
	                }
	                vec3 _3034 = _612[_610] - (_606[_609] * dot(_606[_609], _612[_610]));
	                _605[_610] = _2940 - (_3034 * dot(_2940 - _611[_610], _3034));
	                _610++;
	                continue;
	            }
	            vec3 _3058 = ((_605[0] * ((1.0 - attrs.barycentrics.x) - attrs.barycentrics.y)) + (_605[1] * attrs.barycentrics.x)) + (_605[2] * attrs.barycentrics.y);
	            _607 = dot(_3058 - _2940, _562);
	            _608 = _3058;
	            break;
	        } while(false);
	        if (_2996_ladder_break)
	        {
	            break;
	        }
	        _609++;
	        continue;
	    }
	    if (!(_607 > 0.00999999977648258209228515625))
	    {
	        _608 = vec3(3.4028234663852885981170418348452e+38);
	    }
	    payload.vSmoothPositionWs = _608;
	    payload.bFlippedNormal = _561;
	    f16vec3 _3071 = f16vec3(vec3(0.0));
	    payload.material = MaterialDataMinimal_t(_3071, float16_t(0.0), f16vec3(vec3(1.0, 0.0, 1.0)), float16_t(1.0), _3071, float16_t(0.040008544921875), 0u, f16vec4(ivec4(0)));
	    payload.material.vNormalWs = f16vec3(_570);
	    payload.material.vAlbedo = f16vec3(_569);
	    payload.material.vEmissive = f16vec3(_566);
	    payload.material.flReflectance = float16_t(_565);
	    payload.material.flMetalness = float16_t(_567);
	    payload.material.flRoughness = float16_t(dot(_2897, vec2(0.5)));
	    if (any(greaterThan(_564, vec3(0.0))))
	    {
	        payload.material.nMaterialTypeAndFlags = (payload.material.nMaterialTypeAndFlags & 4294901760u) | 1u;
	        f16vec3 _3097 = f16vec3(_564);
	        payload.material.vMaterialBits.x = _3097.x;
	        payload.material.vMaterialBits.y = _3097.y;
	        payload.material.vMaterialBits.z = _3097.z;
	    }
	}
	
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
	
	BoolAttribute(BindlessResources, true);
	IntAttribute(RayTypeCount, 2);
	BoolAttribute(DoNotRenderIntoSST, F_ANIMATED_SHADOWS);
	BoolAttribute(CanBatchWithDynamicShaderConstants, true);
	Float3Attribute(LightSim_MaterialTint, g_vColorTint);
	TextureAttribute(LightSim_DiffuseAlbedoTexture, g_tColor);
	TextureAttribute(RepresentativeTexture, g_tColor);
	BoolAttribute(NeedsLightProbe, true);
	BoolAttribute(DoNotCastShadows, F_DO_NOT_CAST_SHADOWS ? 1 : 0);
	BoolAttribute(SupportsMappingDimensions, true);
	BoolAttribute(renderbackfaces, F_RENDER_BACKFACES ? 1 : 0);
	BoolAttribute(SupportsLightmapping, true);
	BoolAttribute(PerVertexLighting, true);
	BoolAttribute(AllowBackfaceCulling, F_RENDER_BACKFACES ? 0 : 1);
	BoolAttribute(DoubleSided, F_RENDER_BACKFACES);
	BoolAttribute(SupportsAggregateInstancing, F_FOLIAGE_ANIMATION==0);
	BoolAttribute(IgnoreFaceNormalsForLighting, true);
	
	#if (S_MODE_DEPTH == 0)
		TextureAttribute(LightSim_TintMaskTextureR, g_tTintMask);
	#endif
	#if (S_TINT_MASK == 0)
		TextureAttribute(LightSim_Opacity_A, g_tColor);
		BoolAttribute(alphatest, true);
		BoolAttribute(NoZPrepass, true);
		BoolAttribute(AlphaTestZPrepass, true);
	#endif
	#if (S_VERTEX_ANIMATION == 0)
		TextureAttribute(LightSim_TintMaskTextureR, g_tTintMask);
	#endif
	#if (S_ALPHA_TEST == 1)
		TextureAttribute(LightSim_Opacity_A, g_tColor);
		BoolAttribute(alphatest, true);
		BoolAttribute(NoZPrepass, true);
		BoolAttribute(AlphaTestZPrepass, true);
	#endif
	#if (S_ALPHA_TEST == 0)
		BoolAttribute(NoZPrepass, F_DISABLE_Z_PREPASS ? 1 : 0);
	#endif
	#if (S_TINT_MASK == 1)
		TextureAttribute(LightSim_TintMaskTextureR, g_tTintMask);
	#endif
	#if (S_MODE_TOOLS_SHADING_COMPLEXITY == 0)
		TextureAttribute(LightSim_TintMaskTextureR, g_tTintMask);
	#endif
	#if (S_MODE_TOOLS_VIS == 0)
		TextureAttribute(LightSim_TintMaskTextureR, g_tTintMask);
	#endif
	#if (S_SHADER_QUALITY == 0)
		TextureAttribute(LightSim_TintMaskTextureR, g_tTintMask);
	#endif
	#if (S_FOLIAGE_ANIMATION == 0)
		TextureAttribute(LightSim_TintMaskTextureR, g_tTintMask);
	#endif
	#if (S_FOLIAGE_UV_ANIMATION == 0)
		TextureAttribute(LightSim_TintMaskTextureR, g_tTintMask);
	#endif
}
