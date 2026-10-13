//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Environment shader with blended layers";
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
	ToolsShadingComplexity("csgo_tools_shading_complexity.vfx");
}

FEATURES
{
	Feature( F_DO_NOT_CAST_SHADOWS, 0..1, "Shadows" );
	Feature( F_RENDER_BACKFACES, 0..1, "2-Sided Rendering" );
	Feature( F_DONT_FLIP_BACKFACE_NORMALS, 0..1, "2-Sided Rendering" );
	Feature( F_DISABLE_Z_BUFFERING, 0..1, "Z-Buffering" );
	Feature( F_DISABLE_Z_PREPASS, 0..1, "Z-Prepass" );
	Feature( F_BLEND_BY_FACING_DIRECTION_2, 0..1, "Layer 2" );
	Feature( F_ENABLE_LAYER_3, 0..1, "Layer 3" );
	Feature( F_BLEND_BY_FACING_DIRECTION_3, 0..1, "Layer 3" );
	Feature( F_BLEND_EFFECTS_2, 0..1, "Layer 2" );
	Feature( F_BORDER_ROUGHNESS_2, 0..1, "Layer 2" );
	Feature( F_BORDER_BLEND_MODE_2, 0..3 (0="Multiply", 1="Replace", 2="Mod2x", 3="Colorize"), "Layer 2" );
	Feature( F_BLEND_EFFECTS_3, 0..1, "Layer 3" );
	Feature( F_BORDER_ROUGHNESS_3, 0..1, "Layer 3" );
	Feature( F_BORDER_BLEND_MODE_3, 0..3 (0="Multiply", 1="Replace", 2="Mod2x", 3="Colorize"), "Layer 3" );
	Feature( F_DETAIL_NORMAL, 0..1, "Detail" );
	Feature( F_WETNESS, 0..1, "Wetness" );
	Feature( F_USE_NEW_BLENDING, 0..1, "Blending" );
	Feature( F_SHARED_COLOR_OVERLAY, 0..1, "Color Effects" );
	Feature( F_ALPHA_TEST, 0..1, "Translucent" );
	Feature( F_DEPTH_BIAS, 0..1, "Z-Buffering" );
	Feature( F_OCCLUSION_CULLING_BOUNDS_SCALE, 0..1, "Z-Buffering" );
	Feature( F_ENABLE_VISUALIZATIONS, 0..1, "Visualizations" );
	Feature( F_VISUALIZATION_MODE, 0..3 (0="Show Blending", 1="Show Final Heights", 2="Show Vertex Painting", 3="Show Detail Prop Masks"), "Visualizations" );
	Feature( F_BLEND_EFFECTS, 0..0, "F_BLEND_EFFECTS_2" );
	Feature( F_BORDER_ROUGHNESS, 0..0, "F_BORDER_ROUGHNESS_2" );
	Feature( F_BORDER_BLEND_MODE, 0..0, "F_BORDER_BLEND_MODE_2" );
	FeatureRule( Requires( F_DONT_FLIP_BACKFACE_NORMALS, F_RENDER_BACKFACES ), "Only applies to backfaces" );
	FeatureRule( Requires( F_BLEND_BY_FACING_DIRECTION_3, F_ENABLE_LAYER_3 ), "Blend by Facing Direction 3 requires Enable Layer 3" );
	FeatureRule( Requires( F_BORDER_ROUGHNESS_2, F_BLEND_EFFECTS_2 ), "Border Roughness requires Blend Effects" );
	FeatureRule( Requires( F_BORDER_BLEND_MODE_2, F_BLEND_EFFECTS_2 ), "Border Roughness requires Blend Effects" );
	FeatureRule( Requires( F_BLEND_EFFECTS_3, F_ENABLE_LAYER_3 ), "Blend Effects for Layer 3 requries Enable Layer 3" );
	FeatureRule( Requires( F_BORDER_ROUGHNESS_3, F_BLEND_EFFECTS_3 ), "Border Roughness 3 requires Blend Effects 3" );
	FeatureRule( Requires( F_BORDER_BLEND_MODE_3, F_BLEND_EFFECTS_3 ), "Border Roughness 3 requires Blend Effects 3" );
	FeatureRule( Allow1( F_DISABLE_Z_BUFFERING, F_DEPTH_BIAS ), "Z Bias and Disable Z Buffering are not compatible" );
	FeatureRule( Requires( F_VISUALIZATION_MODE, F_ENABLE_VISUALIZATIONS ), "Enable Visualization Mode" );
}

COMMON
{
	#include "system.fxc"
}

struct VS_INPUT
{
	float4 vBlendIndices              : BLENDINDICES0  < Semantic( BlendIndices ); >;              // D_CS_VERTEX_ANIMATION=0
	float4 vBlendColorTint            : COLOR0         < Semantic( VertexPaintTintColor ); >;      // S_MODE_DEPTH=0, D_CS_VERTEX_ANIMATION=1, S_MODE_TOOLS_VIS=1, S_ALPHA_TEST=1
	float4 vPerVertexLighting         : COLOR1         < Semantic( PerVertexLighting ); >;        
	uint4  nPackedFrame               : NORMAL0        < Semantic( CompressedTangentFrame ); >;   
	float4 vNormalOs                  : NORMAL0        < Semantic( Normal ); >;                   
	float3 vPositionOs                : POSITION0      < Semantic( PosXyz ); >;                    // D_CS_VERTEX_ANIMATION=0
	float4 vTangentUOs_flTangentVSign : TANGENT0       < Semantic( TangentU_SignV ); >;           
	float2 vLightmapUV                : TEXCOORD3      < Semantic( LightmapUV ); >;               
	float2 vTexCoord                  : TEXCOORD0      < Semantic( LowPrecisionUv ); >;            // S_MODE_DEPTH=0, D_CS_VERTEX_ANIMATION=1, S_MODE_TOOLS_VIS=1, S_ALPHA_TEST=1
	float2 vTexCoord2                 : TEXCOORD1      < Semantic( LowPrecisionUv1 ); >;           // S_MODE_DEPTH=0, D_CS_VERTEX_ANIMATION=1, S_MODE_TOOLS_VIS=1, S_ALPHA_TEST=1
	float4 vColorBlendValues          : TEXCOORD4      < Semantic( VertexPaintBlendParams ); >;    // S_MODE_DEPTH=0, D_CS_VERTEX_ANIMATION=1, S_MODE_TOOLS_VIS=1, S_ALPHA_TEST=1
	float2 nInstanceIdx               : TEXCOORD13     < Semantic( InstanceTransformUv ); >;      
};

VS
{
	StaticCombo( S_DETAIL_NORMAL, F_DETAIL_NORMAL );
	StaticCombo( S_SHARED_COLOR_OVERLAY, F_SHARED_COLOR_OVERLAY );
	StaticCombo( S_ENABLE_LAYER_3, F_ENABLE_LAYER_3 );
	StaticCombo( S_MODE_TOOLS_VIS, 0..1 );
	StaticCombo( S_ALPHA_TEST, F_ALPHA_TEST );
	StaticCombo( S_MODE_DEPTH, 0..1 );
	StaticComboRule( Allow1( S_MODE_TOOLS_VIS, S_MODE_DEPTH ) );
	DynamicCombo( D_COMPRESSED_NORMALS_AND_TANGENTS, 0..1 );
	DynamicCombo( D_CS_VERTEX_ANIMATION, 0..1 );
	DynamicCombo( D_BAKED_LIGHTING_FROM_VERTEX_STREAM, 0..1 );
	DynamicCombo( D_BAKED_LIGHTING_FROM_LIGHTMAP, 0..1 );
	DynamicComboRule( Allow1( D_BAKED_LIGHTING_FROM_VERTEX_STREAM, D_BAKED_LIGHTING_FROM_LIGHTMAP ) );
	
	ByteAddressBuffer g_animatedVertexCache < Attribute("AnimatedVertexCache"); >;
	bool g_bTexCoord2ScaleByModel < UiType(CheckBox); Expression(g_nScaleTexCoord2UByModelScaleAxis!=0 || g_nScaleTexCoord2VByModelScaleAxis!=0); >;
	bool g_bTexCoordScaleByModel < UiType(CheckBox); Expression(g_nScaleTexCoordUByModelScaleAxis!=0 || g_nScaleTexCoordVByModelScaleAxis!=0); >;
	[[layer_constant]] ExternalDescriptorSet g_globalLateBoundBindlessSet < Source(ExternalDescSet); Attribute("g_globalLateBoundBindlessSet"); >;
	[[layer_constant]] StructuredBuffer g_instanceBuffer < Attribute("InstanceBuffer"); >;
	[[layer_constant]] ExternalDescriptorSet g_lightBinnerGpuSet < Source(ExternalDescSet); Attribute("g_lightBinnerGpuSet"); >;
	[[layer_constant]] StructuredBuffer g_transformBuffer < Attribute("TransformBuffer"); >;
	float4 g_vDetailTexCoordXform0_1 < UiType(VectorText); Expression(v0 = g_flDetailTexCoordRotation1*3.1415927/180;
		v1 = cos(v0);
		v2 = sin(v0);
		float4(v1*g_vDetailTexCoordScale1.x,-v2*g_vDetailTexCoordScale1.y,0,g_vDetailTexCoordCenter1.x+g_vDetailTexCoordOffset1.x+v2*g_vDetailTexCoordCenter1.y-v1*g_vDetailTexCoordCenter1.x)); >;
	float4 g_vDetailTexCoordXform0_2 < UiType(VectorText); Expression(v0 = g_flDetailTexCoordRotation2*3.1415927/180;
		v1 = cos(v0);
		v2 = sin(v0);
		float4(v1*g_vDetailTexCoordScale2.x,-v2*g_vDetailTexCoordScale2.y,0,g_vDetailTexCoordCenter2.x+g_vDetailTexCoordOffset2.x+v2*g_vDetailTexCoordCenter2.y-v1*g_vDetailTexCoordCenter2.x)); >;
	float4 g_vDetailTexCoordXform0_3 < UiType(VectorText); Expression(v0 = g_flDetailTexCoordRotation3*3.1415927/180;
		v1 = cos(v0);
		v2 = sin(v0);
		float4(v1*g_vDetailTexCoordScale3.x,-v2*g_vDetailTexCoordScale3.y,0,g_vDetailTexCoordCenter3.x+g_vDetailTexCoordOffset3.x+v2*g_vDetailTexCoordCenter3.y-v1*g_vDetailTexCoordCenter3.x)); >;
	float4 g_vDetailTexCoordXform1_1 < UiType(VectorText); Expression(v0 = g_flDetailTexCoordRotation1*3.1415927/180;
		v1 = cos(v0);
		v2 = sin(v0);
		float4(v2*g_vDetailTexCoordScale1.x,v1*g_vDetailTexCoordScale1.y,0,g_vDetailTexCoordCenter1.y+g_vDetailTexCoordOffset1.y-(v2*g_vDetailTexCoordCenter1.x+v1*g_vDetailTexCoordCenter1.y))); >;
	float4 g_vDetailTexCoordXform1_2 < UiType(VectorText); Expression(v0 = g_flDetailTexCoordRotation2*3.1415927/180;
		v1 = cos(v0);
		v2 = sin(v0);
		float4(v2*g_vDetailTexCoordScale2.x,v1*g_vDetailTexCoordScale2.y,0,g_vDetailTexCoordCenter2.y+g_vDetailTexCoordOffset2.y-(v2*g_vDetailTexCoordCenter2.x+v1*g_vDetailTexCoordCenter2.y))); >;
	float4 g_vDetailTexCoordXform1_3 < UiType(VectorText); Expression(v0 = g_flDetailTexCoordRotation3*3.1415927/180;
		v1 = cos(v0);
		v2 = sin(v0);
		float4(v2*g_vDetailTexCoordScale3.x,v1*g_vDetailTexCoordScale3.y,0,g_vDetailTexCoordCenter3.y+g_vDetailTexCoordOffset3.y-(v2*g_vDetailTexCoordCenter3.x+v1*g_vDetailTexCoordCenter3.y))); >;
	float4 g_vOverlayTexCoordXform0 < UiType(VectorText); Expression(v0 = g_flOverlayTexCoordRotation*3.1415927/180;
		v1 = cos(v0);
		v2 = sin(v0);
		float4(v1*g_vOverlayTexCoordScale.x,-v2*g_vOverlayTexCoordScale.y,0,g_vOverlayTexCoordCenter.x+g_vOverlayTexCoordOffset.x+v2*g_vOverlayTexCoordCenter.y-v1*g_vOverlayTexCoordCenter.x)); >;
	float4 g_vOverlayTexCoordXform1 < UiType(VectorText); Expression(v0 = g_flOverlayTexCoordRotation*3.1415927/180;
		v1 = cos(v0);
		v2 = sin(v0);
		float4(v2*g_vOverlayTexCoordScale.x,v1*g_vOverlayTexCoordScale.y,0,g_vOverlayTexCoordCenter.y+g_vOverlayTexCoordOffset.y-(v2*g_vOverlayTexCoordCenter.x+v1*g_vOverlayTexCoordCenter.y))); >;
	float4 g_vTexCoord2ScaleByModelU < UiType(VectorText); Expression(float4((g_nScaleTexCoord2UByModelScaleAxis==1) ? 1 : 0,(g_nScaleTexCoord2UByModelScaleAxis==2) ? 1 : 0,(g_nScaleTexCoord2UByModelScaleAxis==3) ? 1 : 0,(g_nScaleTexCoord2UByModelScaleAxis==0) ? 1 : 0)); >;
	float4 g_vTexCoord2ScaleByModelV < UiType(VectorText); Expression(float4((g_nScaleTexCoord2VByModelScaleAxis==1) ? 1 : 0,(g_nScaleTexCoord2VByModelScaleAxis==2) ? 1 : 0,(g_nScaleTexCoord2VByModelScaleAxis==3) ? 1 : 0,(g_nScaleTexCoord2VByModelScaleAxis==0) ? 1 : 0)); >;
	float4 g_vTexCoordScaleByModelU < UiType(VectorText); Expression(float4((g_nScaleTexCoordUByModelScaleAxis==1) ? 1 : 0,(g_nScaleTexCoordUByModelScaleAxis==2) ? 1 : 0,(g_nScaleTexCoordUByModelScaleAxis==3) ? 1 : 0,(g_nScaleTexCoordUByModelScaleAxis==0) ? 1 : 0)); >;
	float4 g_vTexCoordScaleByModelV < UiType(VectorText); Expression(float4((g_nScaleTexCoordVByModelScaleAxis==1) ? 1 : 0,(g_nScaleTexCoordVByModelScaleAxis==2) ? 1 : 0,(g_nScaleTexCoordVByModelScaleAxis==3) ? 1 : 0,(g_nScaleTexCoordVByModelScaleAxis==0) ? 1 : 0)); >;
	float4 g_vTexCoordXform0_1 < UiType(VectorText); Expression(v0 = g_flTexCoordRotation1*3.1415927/180;
		v1 = cos(v0);
		v2 = sin(v0);
		float4(v1*g_vTexCoordScale1.x,-v2*g_vTexCoordScale1.y,0,g_vTexCoordCenter1.x+g_vTexCoordOffset1.x+v2*g_vTexCoordCenter1.y-v1*g_vTexCoordCenter1.x)); >;
	float4 g_vTexCoordXform0_2 < UiType(VectorText); Expression(v0 = g_flTexCoordRotation2*3.1415927/180;
		v1 = cos(v0);
		v2 = sin(v0);
		float4(v1*g_vTexCoordScale2.x,-v2*g_vTexCoordScale2.y,0,g_vTexCoordCenter2.x+g_vTexCoordOffset2.x+v2*g_vTexCoordCenter2.y-v1*g_vTexCoordCenter2.x)); >;
	float4 g_vTexCoordXform0_3 < UiType(VectorText); Expression(v0 = g_flTexCoordRotation3*3.1415927/180;
		v1 = cos(v0);
		v2 = sin(v0);
		float4(v1*g_vTexCoordScale3.x,-v2*g_vTexCoordScale3.y,0,g_vTexCoordCenter3.x+g_vTexCoordOffset3.x+v2*g_vTexCoordCenter3.y-v1*g_vTexCoordCenter3.x)); >;
	float4 g_vTexCoordXform1_1 < UiType(VectorText); Expression(v0 = g_flTexCoordRotation1*3.1415927/180;
		v1 = cos(v0);
		v2 = sin(v0);
		float4(v2*g_vTexCoordScale1.x,v1*g_vTexCoordScale1.y,0,g_vTexCoordCenter1.y+g_vTexCoordOffset1.y-(v2*g_vTexCoordCenter1.x+v1*g_vTexCoordCenter1.y))); >;
	float4 g_vTexCoordXform1_2 < UiType(VectorText); Expression(v0 = g_flTexCoordRotation2*3.1415927/180;
		v1 = cos(v0);
		v2 = sin(v0);
		float4(v2*g_vTexCoordScale2.x,v1*g_vTexCoordScale2.y,0,g_vTexCoordCenter2.y+g_vTexCoordOffset2.y-(v2*g_vTexCoordCenter2.x+v1*g_vTexCoordCenter2.y))); >;
	float4 g_vTexCoordXform1_3 < UiType(VectorText); Expression(v0 = g_flTexCoordRotation3*3.1415927/180;
		v1 = cos(v0);
		v2 = sin(v0);
		float4(v2*g_vTexCoordScale3.x,v1*g_vTexCoordScale3.y,0,g_vTexCoordCenter3.y+g_vTexCoordOffset3.y-(v2*g_vTexCoordCenter3.x+v1*g_vTexCoordCenter3.y))); >;
	
	// Material1
	int g_nUVSet1 < Default(1); Range4(0, 0, 0, 0, 2, 2, 2, 2); UiOptions("0=Biplanar,1=UV1,2=UV2"); UiType(Enum); UiGroup("Material1/Texture Coordinates,34/1"); >;
	float2 g_vTexCoordCenter1 < Default2(0.5, 0.5); Attribute("0=X,1=Y"); UiType(VectorText); UiGroup("Material1/Texture Transform,35/1"); UiVisibility(1); >;
	float2 g_vTexCoordCenter2 < Default2(0.5, 0.5); Attribute("0=X,1=Y"); UiType(VectorText); UiGroup("Material1/Texture Transform,35/1"); UiVisibility(1); >;
	int g_nDetailUVSet1 < Default(-1); Range4(-1, -1, -1, -1, 2, 2, 2, 2); UiOptions("-1=Inherit,0=Biplanar,1=UV1,2=UV2"); UiType(Enum); UiGroup("Material1/Texture Coordinates,34/2"); >;
	float2 g_vTexCoordScale1 < Default2(1, 1); Range2(0, 0, 100, 100); Attribute("0=X,1=Y"); UiType(VectorText); UiGroup("Material1/Texture Transform,35/2"); >;
	float2 g_vTexCoordScale2 < Default2(1, 1); Range2(0, 0, 100, 100); Attribute("0=X,1=Y"); UiType(VectorText); UiGroup("Material1/Texture Transform,35/2"); >;
	float g_flTexCoordRotation2 < Range(-360, 360); UiType(Slider); UiGroup("Material1/Texture Transform,35/3"); UiVisibility(1); >;
	float2 g_vTexCoordOffset1 < Range2(-1, -1, 1, 1); Attribute("0=X,1=Y"); UiType(VectorText); UiGroup("Material1/Texture Transform,35/4"); UiVisibility(1); >;
	float2 g_vTexCoordOffset2 < Range2(-1, -1, 1, 1); Attribute("0=X,1=Y"); UiType(VectorText); UiGroup("Material1/Texture Transform,35/4"); UiVisibility(1); >;
	float2 g_vDetailTexCoordCenter1 < Default2(0.5, 0.5); Attribute("0=X,1=Y"); UiType(VectorText); UiGroup("Material1/Detail Texture Transform/5"); UiVisibility(1); >;
	float2 g_vDetailTexCoordScale1 < Default2(1, 1); Range2(0, 0, 100, 100); Attribute("0=X,1=Y"); UiType(VectorText); UiGroup("Material1/Detail Texture Transform/6"); >;
	float g_flDetailTexCoordRotation1 < Range(-360, 360); UiType(Slider); UiGroup("Material1/Detail Texture Transform/8"); UiVisibility(1); >;
	float2 g_vDetailTexCoordOffset1 < Range2(-1, -1, 1, 1); Attribute("0=X,1=Y"); UiType(VectorText); UiGroup("Material1/Detail Texture Transform/9"); UiVisibility(1); >;
	float g_flTexCoordRotation1 < Range(-360, 360); UiType(Slider); UiGroup("Material1/Texture Transform,35/13"); UiVisibility(1); >;
	
	// Material2
	int g_nUVSet2 < Default(1); Range4(0, 0, 0, 0, 2, 2, 2, 2); UiOptions("0=Biplanar,1=UV1,2=UV2"); UiType(Enum); UiGroup("Material2/Texture Coordinates,34/1"); >;
	int g_nDetailUVSet2 < Default(-1); Range4(-1, -1, -1, -1, 2, 2, 2, 2); UiOptions("-1=Inherit,0=Biplanar,1=UV1,2=UV2"); UiType(Enum); UiGroup("Material2/Texture Coordinates,34/2"); >;
	float2 g_vDetailTexCoordCenter2 < Default2(0.5, 0.5); Attribute("0=X,1=Y"); UiType(VectorText); UiGroup("Material2/Detail Texture Transform/5"); UiVisibility(1); >;
	float2 g_vDetailTexCoordScale2 < Default2(1, 1); Range2(0, 0, 100, 100); Attribute("0=X,1=Y"); UiType(VectorText); UiGroup("Material2/Detail Texture Transform/6"); >;
	float g_flDetailTexCoordRotation2 < Range(-360, 360); UiType(Slider); UiGroup("Material2/Detail Texture Transform/8"); UiVisibility(1); >;
	float2 g_vDetailTexCoordOffset2 < Range2(-1, -1, 1, 1); Attribute("0=X,1=Y"); UiType(VectorText); UiGroup("Material2/Detail Texture Transform/9"); UiVisibility(1); >;
	
	// Material3
	int g_nUVSet3 < Default(1); Range4(0, 0, 0, 0, 2, 2, 2, 2); UiOptions("0=Biplanar,1=UV1,2=UV2"); UiType(Enum); UiGroup("Material3/Texture Coordinates,34/1"); >;
	float2 g_vTexCoordCenter3 < Default2(0.5, 0.5); UiType(VectorText); UiGroup("Material3/Texture Transform,35/1"); UiVisibility(1); >;
	int g_nDetailUVSet3 < Default(-1); Range4(-1, -1, -1, -1, 2, 2, 2, 2); UiOptions("-1=Inherit,0=Biplanar,1=UV1,2=UV2"); UiType(Enum); UiGroup("Material3/Texture Coordinates,34/2"); >;
	float2 g_vTexCoordScale3 < Default2(1, 1); Range2(0, 0, 100, 100); UiType(VectorText); UiGroup("Material3/Texture Transform,35/2"); >;
	float g_flTexCoordRotation3 < Range(-360, 360); UiType(Slider); UiGroup("Material3/Texture Transform,35/3"); UiVisibility(1); >;
	float2 g_vTexCoordOffset3 < Range2(-1, -1, 1, 1); UiType(VectorText); UiGroup("Material3/Texture Transform,35/4"); UiVisibility(1); >;
	float2 g_vDetailTexCoordCenter3 < Default2(0.5, 0.5); UiType(VectorText); UiGroup("Material3/Detail Texture Transform/5"); UiVisibility(1); >;
	float2 g_vDetailTexCoordScale3 < Default2(1, 1); Range2(0, 0, 100, 100); UiType(VectorText); UiGroup("Material3/Detail Texture Transform/6"); >;
	float g_flDetailTexCoordRotation3 < Range(-360, 360); UiType(Slider); UiGroup("Material3/Detail Texture Transform/8"); UiVisibility(1); >;
	float2 g_vDetailTexCoordOffset3 < Range2(-1, -1, 1, 1); UiType(VectorText); UiGroup("Material3/Detail Texture Transform/9"); UiVisibility(1); >;
	
	// Color
	float3 g_vColorTint < Default3(1, 1, 1); UiType(Color); UiGroup("Color,10/20"); Expression(SrgbGammaToLinear(this)); >;
	float g_flModelTintAmount < Default(1); UiType(Slider); UiGroup("Color,10/30"); >;
	int g_nColorOverlayUVSet < Default(2); Range4(0, 0, 0, 0, 2, 2, 2, 2); UiOptions("0=Biplanar,1=UV1,2=UV2"); UiType(Enum); UiGroup("Color/Overlay/40"); >;
	int g_nScaleTexCoordUByModelScaleAxis < Range4(0, 0, 0, 0, 3, 3, 3, 3); UiOptions("0=None,1=UV.u * model.x,2=UV.u * model.y,3=UV.u * model.z"); UiType(Enum); UiGroup("Color/80"); >;
	int g_nScaleTexCoordVByModelScaleAxis < Range4(0, 0, 0, 0, 3, 3, 3, 3); UiOptions("0=None,1=UV.v * model.x,2=UV.v * model.y,3=UV.v * model.z"); UiType(Enum); UiGroup("Color/90"); >;
	int g_nScaleTexCoord2UByModelScaleAxis < Range4(0, 0, 0, 0, 3, 3, 3, 3); UiOptions("0=None,1=UV2.u * model.x,2=UV2.u * model.y,3=UV2.u * model.z"); UiType(Enum); UiGroup("Color/100"); UiVisibility(1); >;
	int g_nScaleTexCoord2VByModelScaleAxis < Range4(0, 0, 0, 0, 3, 3, 3, 3); UiOptions("0=None,1=UV2.v * model.x,2=UV2.v * model.y,3=UV2.v * model.z"); UiType(Enum); UiGroup("Color/110"); UiVisibility(1); >;
	float2 g_vOverlayTexCoordCenter < Default2(0.5, 0.5); UiType(VectorText); UiGroup("Color/Overlay/200"); >;
	float2 g_vOverlayTexCoordScale < Default2(1, 1); Range2(0, 0, 100, 100); UiType(VectorText); UiGroup("Color/Overlay/210"); >;
	float g_flOverlayTexCoordRotation < Range(-360, 360); UiType(Slider); UiGroup("Color/Overlay/220"); >;
	float2 g_vOverlayTexCoordOffset < Range2(-1, -1, 1, 1); Attribute("0=X,1=Y"); UiType(VectorText); UiGroup("Color/Overlay/230"); >;
	
	// SPIR-V reflection failed for backend HLSL:
	// cbuffer ID 5618 (name: _Globals_), member index 1 (name: g_vTexCoordXform0_1) cannot be expressed with either HLSL packing layout or packoffset.
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
	
	struct _1596
	{
	    int g_nUVSet1;
	    vec4 g_vTexCoordXform0_1;
	    vec4 g_vTexCoordXform1_1;
	    int g_nUVSet2;
	    vec4 g_vTexCoordXform0_2;
	    vec4 g_vTexCoordXform1_2;
	    vec3 g_vColorTint;
	    float g_flModelTintAmount;
	};
	
	layout(set = 0) uniform _1596 _Globals_;
	
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
	    vec4 _21710;
	    if (_Globals_.g_nUVSet1 > 0)
	    {
	        vec4 _11399 = vec4(mix(_9337.xy, _9337.zw, bvec2(_Globals_.g_nUVSet1 == 2)), vTexCoord2);
	        vec2 _9573 = _11399.xy;
	        vec4 _16823 = _11399;
	        _16823.x = dot(_9573, _Globals_.g_vTexCoordXform0_1.xy) + _Globals_.g_vTexCoordXform0_1.w;
	        _16823.y = dot(_9573, _Globals_.g_vTexCoordXform1_1.xy) + _Globals_.g_vTexCoordXform1_1.w;
	        _21710 = _16823;
	    }
	    else
	    {
	        _21710 = _9337;
	    }
	    vec4 _18606;
	    if (_Globals_.g_nUVSet2 > 0)
	    {
	        vec2 _17583 = mix(_9337.xy, _9337.zw, bvec2(_Globals_.g_nUVSet2 == 2));
	        vec4 _7849 = _21710;
	        _7849.z = _17583.x;
	        _7849.w = _17583.y;
	        vec4 _16824 = _7849;
	        _16824.z = dot(_7849.zw, _Globals_.g_vTexCoordXform0_2.xy) + _Globals_.g_vTexCoordXform0_2.w;
	        _16824.w = dot(_7849.zw, _Globals_.g_vTexCoordXform1_2.xy) + _Globals_.g_vTexCoordXform1_2.w;
	        _18606 = _16824;
	    }
	    else
	    {
	        _18606 = _21710;
	    }
	    vec4 _11323 = vec4(_Globals_.g_vColorTint, _23812.w * g_instanceBuffer_1._m0[nInstanceIdx]._m7);
	    vec3 _14119 = _11323.xyz * mix(vec3(1.0), vBlendColorTint.xyz, vec3(vBlendColorTint.w));
	    vec4 _23714 = _11323;
	    _23714.x = _14119.x;
	    _23714.y = _14119.y;
	    _23714.z = _14119.z;
	    output_0 = vColorBlendValues;
	    output_1 = vec4(_21354, _21355, _17978, _Globals_.g_flModelTintAmount * (1.0 - min(_21354, min(_21355, _17978))));
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
	BoolAttribute(GroupDefaultCollapseState_TextureTransform, true);
	BoolAttribute(GroupDefaultCollapseState_DetailTextureTransform, true);
	IntAttribute(TexCoord2ScaleByModelU, g_nScaleTexCoord2UByModelScaleAxis-1);
	IntAttribute(TexCoord2ScaleByModelV, g_nScaleTexCoord2VByModelScaleAxis-1);
	BoolAttribute(environmentmapped, true);
	BoolAttribute(environmentmappeddynamic, true);
	BoolAttribute(CanBatchWithDynamicShaderConstants, true);
	IntAttribute(TexCoordScaleByModelU, g_nScaleTexCoordUByModelScaleAxis-1);
	IntAttribute(TexCoordScaleByModelV, g_nScaleTexCoordVByModelScaleAxis-1);
	Float3Attribute(LightSim_MaterialTint, g_vColorTint);
	BoolAttribute(VertexPaintUIPickColor, true);
	BoolAttribute(VertexpaintUIPuddles, (F_WETNESS==1) ? 1 : 0);
	BoolAttribute(VertexPaintUIAlphaBlendFactor, true);
	BoolAttribute(SupportsAggregateInstancing, true);
	BoolAttribute(SupportsMaterialLayerSampling, true);
	
	#if (S_SHARED_COLOR_OVERLAY == 1)
		BoolAttribute(HasTexcoordTransform, (g_nUVSet1>0 && (g_vTexCoordScale1.x!=1 || g_vTexCoordScale1.y!=1 || g_flTexCoordRotation1!=0) || g_nUVSet2>0 && (g_vTexCoordScale2.x!=1 || g_vTexCoordScale2.y!=1 || g_flTexCoordRotation2!=0) || g_nUVSet3>0 && (g_vTexCoordScale3.x!=1 || g_vTexCoordScale3.y!=1 || g_flTexCoordRotation3!=0) || g_nColorOverlayUVSet>0 && (g_vOverlayTexCoordScale.x!=1 || g_vOverlayTexCoordScale.y!=1 || g_flOverlayTexCoordRotation!=0)) ? 1 : 0);
		BoolAttribute(VertexPaintUI2Layer, false);
		BoolAttribute(VertexPaintUI3Layer, true);
	#endif
	#if (S_ENABLE_LAYER_3 == 1)
		BoolAttribute(VertexPaintUI2Layer, false);
		BoolAttribute(VertexPaintUI3Layer, true);
	#endif
	#if (S_ENABLE_LAYER_3 == 0)
		BoolAttribute(VertexPaintUI2Layer, true);
		BoolAttribute(VertexPaintUI3Layer, false);
	#endif
	#if (S_SHARED_COLOR_OVERLAY == 0)
		BoolAttribute(HasTexcoordTransform, (g_nUVSet1>0 && (g_vTexCoordScale1.x!=1 || g_vTexCoordScale1.y!=1 || g_flTexCoordRotation1!=0) || g_nUVSet2>0 && (g_vTexCoordScale2.x!=1 || g_vTexCoordScale2.y!=1 || g_flTexCoordRotation2!=0) || g_nUVSet3>0 && (g_vTexCoordScale3.x!=1 || g_vTexCoordScale3.y!=1 || g_flTexCoordRotation3!=0)) ? 1 : 0);
		BoolAttribute(VertexPaintUI2Layer, false);
		BoolAttribute(VertexPaintUI3Layer, true);
	#endif
	
	// Variant Attributes
	BoolAttribute(HasTexcoordTransform, (g_nUVSet1>0 && (g_vTexCoordScale1.x!=1 || g_vTexCoordScale1.y!=1 || g_flTexCoordRotation1!=0) || g_nUVSet2>0 && (g_vTexCoordScale2.x!=1 || g_vTexCoordScale2.y!=1 || g_flTexCoordRotation2!=0)) ? 1 : 0);
	BoolAttribute(HasTexcoordTransform, (g_nUVSet1>0 && (g_vTexCoordScale1.x!=1 || g_vTexCoordScale1.y!=1 || g_flTexCoordRotation1!=0) || g_nUVSet2>0 && (g_vTexCoordScale2.x!=1 || g_vTexCoordScale2.y!=1 || g_flTexCoordRotation2!=0) || g_nColorOverlayUVSet>0 && (g_vOverlayTexCoordScale.x!=1 || g_vOverlayTexCoordScale.y!=1 || g_flOverlayTexCoordRotation!=0)) ? 1 : 0);
}

PS
{
	StaticCombo( S_DETAIL_NORMAL, F_DETAIL_NORMAL );
	StaticCombo( S_SHARED_COLOR_OVERLAY, F_SHARED_COLOR_OVERLAY );
	StaticCombo( S_ENABLE_LAYER_3, F_ENABLE_LAYER_3 );
	StaticCombo( S_MODE_TOOLS_VIS, 0..1 );
	StaticCombo( S_USE_NEW_BLENDING, F_USE_NEW_BLENDING );
	StaticCombo( S_ENABLE_VISUALIZATIONS, F_ENABLE_VISUALIZATIONS );
	StaticCombo( S_ALPHA_TEST, F_ALPHA_TEST );
	StaticCombo( S_SHADER_QUALITY, 0..1 );
	StaticCombo( S_BLEND_EFFECTS_2, F_BLEND_EFFECTS_2 );
	StaticCombo( S_BLEND_EFFECTS_3, F_BLEND_EFFECTS_3 );
	StaticCombo( S_MODE_DEPTH, 0..1 );
	StaticComboRule( Requires( S_MODE_TOOLS_VIS, S_SHADER_QUALITY ) );
	StaticComboRule( Requires( S_BLEND_EFFECTS_3, S_ENABLE_LAYER_3 ) );
	DynamicCombo( D_BAKED_LIGHTING_FROM_VERTEX_STREAM, 0..1 );
	DynamicCombo( D_BAKED_LIGHTING_FROM_PROBE, 0..1 );
	DynamicCombo( D_BAKED_LIGHTING_FROM_LIGHTMAP, 0..1 );
	DynamicCombo( D_OPAQUE_FADE, 0..1 );
	DynamicCombo( D_SPECULAR_CUBE_MAP_STATIC, 0..1 );
	DynamicCombo( D_ALPHA_TEST_PREPASS, 0..1 );
	DynamicComboRule( Allow1( D_BAKED_LIGHTING_FROM_PROBE, D_BAKED_LIGHTING_FROM_VERTEX_STREAM, D_BAKED_LIGHTING_FROM_LIGHTMAP ) );
	DynamicComboRule( Allow1( S_ALPHA_TEST, D_OPAQUE_FADE ) );
	DynamicComboRule( Allow1( S_MODE_DEPTH, D_SPECULAR_CUBE_MAP_STATIC ) );
	DynamicComboRule( Requires( D_SPECULAR_CUBE_MAP_STATIC, S_SHADER_QUALITY ) );
	DynamicComboRule( Requires( D_ALPHA_TEST_PREPASS, S_ALPHA_TEST ) );
	
	bool bBiplanarUsedAny < UiType(CheckBox); Expression(g_nUVSet1==0 || g_nUVSet2==0); >;
	bool bBiplanarUsedAny < UiType(CheckBox); Expression(g_nUVSet1==0 || g_nUVSet2==0 || g_nUVSet3==0); >;
	bool bBiplanarUsedAny < UiType(CheckBox); Expression(g_nUVSet1==0 || g_nUVSet2==0 || g_nColorOverlayUVSet==0); >;
	bool bBiplanarUsedAny < UiType(CheckBox); Expression(g_nUVSet1==0 || g_nUVSet2==0 || g_nUVSet3==0 || g_nColorOverlayUVSet==0); >;
	bool bBiplanarUsedAny < UiType(CheckBox); Expression(g_nUVSet1==0 || g_nUVSet2==0 || g_nDetailUVSet1==0 || g_nDetailUVSet2==0); >;
	bool bBiplanarUsedAny < UiType(CheckBox); Expression(g_nUVSet1==0 || g_nUVSet2==0 || g_nDetailUVSet1==0 || g_nDetailUVSet2==0 || g_nColorOverlayUVSet==0); >;
	bool bBiplanarUsedAny < UiType(CheckBox); Expression(g_nUVSet1==0 || g_nUVSet2==0 || g_nUVSet3==0 || g_nDetailUVSet1==0 || g_nDetailUVSet2==0 || g_nDetailUVSet3==0); >;
	bool bBiplanarUsedAny < UiType(CheckBox); Expression(g_nUVSet1==0 || g_nUVSet2==0 || g_nUVSet3==0 || g_nDetailUVSet1==0 || g_nDetailUVSet2==0 || g_nDetailUVSet3==0 || g_nColorOverlayUVSet==0); >;
	bool bBlendByFacingDirection2 < UiType(CheckBox); Expression(F_BLEND_BY_FACING_DIRECTION_2); >;
	bool bBlendByFacingDirection3 < UiType(CheckBox); Expression(F_BLEND_BY_FACING_DIRECTION_3); >;
	[[layer_constant]] StructuredBuffer g_BarnLights < Attribute("BarnLights"); >;
	[[layer_constant]] StructuredBuffer g_CullBits < Attribute("CullBits"); >;
	bool g_bAdjustBaseColor1 < UiType(CheckBox); Expression(g_nColorCorrectionMode1==1); >;
	bool g_bAdjustBaseColor2 < UiType(CheckBox); Expression(g_nColorCorrectionMode2==1); >;
	bool g_bAdjustBaseColor3 < UiType(CheckBox); Expression(g_nColorCorrectionMode3==1); >;
	bool g_bBorderBlendColorize2 < UiType(CheckBox); Expression(F_BORDER_BLEND_MODE_2==3); >;
	bool g_bBorderBlendColorize3 < UiType(CheckBox); Expression(F_BORDER_BLEND_MODE_3==3); >;
	bool g_bBorderBlendMod2x2 < UiType(CheckBox); Expression(F_BORDER_BLEND_MODE_2==2); >;
	bool g_bBorderBlendMod2x3 < UiType(CheckBox); Expression(F_BORDER_BLEND_MODE_3==2); >;
	bool g_bBorderBlendMultiply2 < UiType(CheckBox); Expression(!F_BORDER_BLEND_MODE_2); >;
	bool g_bBorderBlendMultiply3 < UiType(CheckBox); Expression(!F_BORDER_BLEND_MODE_3); >;
	bool g_bBorderBlendReplace2 < UiType(CheckBox); Expression(F_BORDER_BLEND_MODE_2==1); >;
	bool g_bBorderBlendReplace3 < UiType(CheckBox); Expression(F_BORDER_BLEND_MODE_3==1); >;
	bool g_bBorderRoughness2 < UiType(CheckBox); Expression(F_BORDER_ROUGHNESS_2); >;
	bool g_bBorderRoughness3 < UiType(CheckBox); Expression(F_BORDER_ROUGHNESS_3); >;
	bool g_bColorOverlayLayer1 < UiType(CheckBox); Expression(g_nColorOverlayMode==0 || g_nColorOverlayMode==1); >;
	bool g_bColorOverlayLayer2 < UiType(CheckBox); Expression(g_nColorOverlayMode==0 || g_nColorOverlayMode==2); >;
	bool g_bColorOverlayLayer3 < UiType(CheckBox); Expression(g_nColorOverlayMode==0 || g_nColorOverlayMode==3); >;
	bool g_bColorOverlayMaskLayer1 < UiType(CheckBox); Expression(g_nColorOverlayTintMask==0 || g_nColorOverlayTintMask==1); >;
	bool g_bColorOverlayMaskLayer2 < UiType(CheckBox); Expression(g_nColorOverlayTintMask==0 || g_nColorOverlayTintMask==2); >;
	bool g_bColorOverlayMaskLayer3 < UiType(CheckBox); Expression(g_nColorOverlayTintMask==0 || g_nColorOverlayTintMask==3); >;
	bool g_bCubemapNormalization < Attribute("g_bCubemapNormalization"); UiType(CheckBox); >;
	bool g_bDisableNormalMapping < Attribute("g_bDisableNormalMapping"); UiType(CheckBox); >;
	bool g_bDontFlipBackfaceNormals < UiType(CheckBox); Expression(F_DONT_FLIP_BACKFACE_NORMALS ? 1 : 0); >;
	bool g_bHighlightDeprecated < Attribute("g_bHighlightDeprecated"); UiType(CheckBox); >;
	bool g_bIsDeprecated < Attribute("bIsDeprecated"); UiType(CheckBox); >;
	bool g_bMaskVertexColor1 < UiType(CheckBox); Expression(g_nVertexColorMode1==0); >;
	bool g_bMaskVertexColor2 < UiType(CheckBox); Expression(g_nVertexColorMode2==0); >;
	bool g_bMaskVertexColor3 < UiType(CheckBox); Expression(g_nVertexColorMode3==0); >;
	bool g_bRenderBackfaceNormals < UiType(CheckBox); Expression((F_RENDER_BACKFACES ? 1 : 0) ? 1 : 0); >;
	bool g_bRenderingToCubemaps < Attribute("g_bRenderingToCubemaps"); UiType(CheckBox); >;
	bool g_bShowLPVVoxels < Attribute("g_bShowLPVVoxels"); UiType(CheckBox); >;
	bool g_bShowLightmapTexels < Attribute("g_bShowLightmapTexels"); UiType(CheckBox); >;
	bool g_bVertexColorEnabled1 < UiType(CheckBox); Expression(g_nVertexColorMode1!=2); >;
	bool g_bVertexColorEnabled2 < UiType(CheckBox); Expression(g_nVertexColorMode2!=2); >;
	bool g_bVertexColorEnabled3 < UiType(CheckBox); Expression(g_nVertexColorMode3!=2); >;
	bool g_bWetness < UiType(CheckBox); Expression((F_WETNESS==1) ? 1 : 0); >;
	float g_fToolsVisHeightTint < Default(0.9); Attribute("g_fToolsVisHeightTint"); UiType(Slider); >;
	float g_fToolsVisMaxHeightRange < Default(1); Attribute("g_fToolsVisMaxHeightRange"); UiType(Slider); >;
	float g_fToolsVisMaxLightingComplexity < Default(8); Attribute("g_fToolsVisMaxLightingComplexity"); UiType(Slider); >;
	float g_flReflectance < UiType(Slider); Expression(pow((1.5-1)/(1.5+1),2)); >;
	[[layer_constant]] ExternalDescriptorSet g_globalLateBoundBindlessSet < Source(ExternalDescSet); Attribute("g_globalLateBoundBindlessSet"); >;
	[[layer_constant]] ExternalDescriptorSet g_lightBinnerGpuSet < Source(ExternalDescSet); Attribute("g_lightBinnerGpuSet"); >;
	float4x4 g_mTextureAdjust1 < Expression(MatrixMultiply(MatrixColorTint2(float3(1,1,1),1),MatrixColorCorrect2(float3(g_fTextureColorContrast1,g_fTextureColorSaturation1,g_fTextureColorBrightness1),TextureAverageColor(g_tColor1)))); >;
	float4x4 g_mTextureAdjust2 < Expression(MatrixMultiply(MatrixColorTint2(float3(1,1,1),1),MatrixColorCorrect2(float3(g_fTextureColorContrast2,g_fTextureColorSaturation2,g_fTextureColorBrightness2),TextureAverageColor(g_tColor2)))); >;
	float4x4 g_mTextureAdjust3 < Expression(MatrixMultiply(MatrixColorTint2(float3(1,1,1),1),MatrixColorCorrect2(float3(g_fTextureColorContrast3,g_fTextureColorSaturation3,g_fTextureColorBrightness3),TextureAverageColor(g_tColor3)))); >;
	float4x4 g_mTextureColorAdjust1 < Expression(MatrixMultiply(MatrixColorTint2(g_vTextureColorTint1,1),MatrixColorCorrect2(float3(g_fTextureColorContrast1,g_fTextureColorSaturation1,g_fTextureColorBrightness1),TextureAverageColor(g_tColor1)))); >;
	float4x4 g_mTextureColorAdjust2 < Expression(MatrixMultiply(MatrixColorTint2(g_vTextureColorTint2,1),MatrixColorCorrect2(float3(g_fTextureColorContrast2,g_fTextureColorSaturation2,g_fTextureColorBrightness2),TextureAverageColor(g_tColor2)))); >;
	float4x4 g_mTextureColorAdjust3 < Expression(MatrixMultiply(MatrixColorTint2(g_vTextureColorTint3,1),MatrixColorCorrect2(float3(g_fTextureColorContrast3,g_fTextureColorSaturation3,g_fTextureColorBrightness3),TextureAverageColor(g_tColor3)))); >;
	int g_nToolsVisMode < Attribute("g_nToolsVisMode"); UiType(Slider); >;
	int g_nVisualization < UiType(Slider); Expression(F_VISUALIZATION_MODE); >;
	Texture2D g_tColor1 < Channel(RGB, ArtistDefined(TextureColor1), Srgb); Channel(A, Box(TextureAmbientOcclusion1), Linear); OutputFormat(BC7); SrgbRead(true); >;
	Texture2D g_tColor1 < Channel(RGB, ArtistDefinedOrAlphaWeighted(TextureColor1, TextureTranslucency1), Srgb); Channel(A, PreserveCoverage(TextureTranslucency1), Linear); OutputFormat(BC7); SrgbRead(true); >;
	Texture2D g_tColor2 < Channel(RGB, ArtistDefined(TextureColor2), Srgb); Channel(A, Box(TextureAmbientOcclusion2), Linear); OutputFormat(BC7); SrgbRead(true); >;
	Texture2D g_tColor3 < Channel(RGB, ArtistDefined(TextureColor3), Srgb); Channel(A, Box(TextureAmbientOcclusion3), Linear); OutputFormat(BC7); SrgbRead(true); >;
	Texture2D g_tHeight1 < Channel(R, ArtistDefined(TextureHeight1), Linear); Channel(G, ArtistDefined(TextureTintMask1), Linear); Channel(A, Box(TextureMetalness1), Linear); OutputFormat(BC7); SrgbRead(false); >;
	Texture2D g_tHeight1 < Channel(R, ArtistDefined(TextureHeight1), Linear); Channel(G, ArtistDefined(TextureTintMask1), Linear); Channel(B, Box(TextureAmbientOcclusion1), Linear); Channel(A, Box(TextureMetalness1), Linear); OutputFormat(BC7); SrgbRead(false); >;
	Texture2D g_tHeight2 < Channel(R, Box(TextureHeight2), Linear); Channel(G, Box(TextureTintMask2), Linear); Channel(A, Box(TextureMetalness2), Linear); OutputFormat(BC7); SrgbRead(false); >;
	Texture2D g_tHeight3 < Channel(R, Box(TextureHeight3), Linear); Channel(G, Box(TextureTintMask3), Linear); Channel(A, Box(TextureMetalness3), Linear); OutputFormat(BC7); SrgbRead(false); >;
	Texture2D g_tNormal1 < Channel(RGBA, HemiOctIsoRoughness_RG_B(TextureNormal1, TextureRoughness1), Linear); OutputFormat(BC7); SrgbRead(false); >;
	Texture2D g_tNormal2 < Channel(RGBA, HemiOctIsoRoughness_RG_B(TextureNormal2, TextureRoughness2), Linear); OutputFormat(BC7); SrgbRead(false); >;
	Texture2D g_tNormal3 < Channel(RGBA, HemiOctIsoRoughness_RG_B(TextureNormal3, TextureRoughness3), Linear); OutputFormat(BC7); SrgbRead(false); >;
	Texture2D g_tNormalDetail1 < Channel(RG, HemiOctIsoRoughness_RG_B(TextureNormalDetail1), Linear); OutputFormat(ATI2N); SrgbRead(false); >;
	Texture2D g_tNormalDetail2 < Channel(RG, HemiOctIsoRoughness_RG_B(TextureNormalDetail2), Linear); OutputFormat(ATI2N); SrgbRead(false); >;
	Texture2D g_tNormalDetail3 < Channel(RG, HemiOctIsoRoughness_RG_B(TextureNormalDetail3), Linear); OutputFormat(ATI2N); SrgbRead(false); >;
	Texture2D g_tSharedColorOverlay < Channel(RGB, ArtistDefined(TextureSharedColorOverlay), Srgb); OutputFormat(DXT1); SrgbRead(true); >;
	float3 g_vBiplanarTexCoordScale < UiType(VectorText); Expression(1/64*float3(-1,1,-1)); >;
	float4 g_vDetailNormalXform_1 < UiType(VectorText); Expression(v0 = g_flDetailTexCoordRotation1*3.1415927/180;
		v1 = cos(v0);
		v2 = sin(v0);
		float4(v1,-v2,v2,v1)); >;
	float4 g_vDetailNormalXform_2 < UiType(VectorText); Expression(v0 = g_flDetailTexCoordRotation2*3.1415927/180;
		v1 = cos(v0);
		v2 = sin(v0);
		float4(v1,-v2,v2,v1)); >;
	float4 g_vDetailNormalXform_3 < UiType(VectorText); Expression(v0 = g_flDetailTexCoordRotation3*3.1415927/180;
		v1 = cos(v0);
		v2 = sin(v0);
		float4(v1,-v2,v2,v1)); >;
	float3 g_vFlatOverlayColor < Default2(1, 0); Attribute("FlatOverlayColor"); UiType(VectorText); >;
	float4 g_vNormalXform_1 < UiType(VectorText); Expression(v0 = g_flTexCoordRotation1*3.1415927/180;
		v1 = cos(v0);
		v2 = sin(v0);
		float4(v1,-v2,v2,v1)); >;
	float4 g_vNormalXform_2 < UiType(VectorText); Expression(v0 = g_flTexCoordRotation2*3.1415927/180;
		v1 = cos(v0);
		v2 = sin(v0);
		float4(v1,-v2,v2,v1)); >;
	float4 g_vNormalXform_3 < UiType(VectorText); Expression(v0 = g_flTexCoordRotation3*3.1415927/180;
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
	float2 g_vTexCoordScale2 < Default2(1, 1); Range2(0, 0, 100, 100); Attribute("0=X,1=Y"); UiType(VectorText); UiGroup("Material1/Texture Transform,35/2"); >;
	float g_flTexCoordRotation2 < Range(-360, 360); UiType(Slider); UiGroup("Material1/Texture Transform,35/3"); UiVisibility(1); >;
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
	float g_flDetailPropMaskBias1 < Range(0, 10); UiType(Slider); UiGroup("Material1/Detail Props,90/20"); >;
	float g_flHeightMapScale1 < Default(1); Range(-4, 4); UiType(Slider); UiGroup("Material1/Height/20"); >;
	float g_flHeightMapScale1 < Default(1); Range(-2, 2); UiType(Slider); UiGroup("Material1/Height/20"); >;
	float3 g_vAmbientOcclusionLevels1 < Default2(0, 0.5); Range(-1, 1); Attribute("0=Option 1,1=Option 2,2=Option 3"); UiType(VectorText); UiGroup("Material1/Lighting/21"); Expression(float3(-this.x,-1.4427*log(max(.0001,1-this.y)),2-this.z)); >;
	CreateInputTexture2D(TextureMetalness1, Linear, 8, "", "_metal", "Material1/Lighting/30", Default4(0, 0, 0, 0));
	float g_fTextureColorSaturation1 < Default(1); Range(0, 4); UiType(Slider); UiGroup("Material1/Color Correction/30"); >;
	float g_flDetailPropPuddleReduction1 < UiType(Slider); UiGroup("Material1/Detail Props,90/30"); >;
	float g_flHeightMapZeroPoint1 < Default(0.5); UiType(Slider); UiGroup("Material1/Height/30"); >;
	CreateInputTexture2D(TextureNormalDetail1, Linear, 8, "NormalizeNormals", "_normal", "Material1/Detail/35", Default4(0.5, 0.5, 1, 0));
	float g_fTextureColorBrightness1 < Default(1); Range(-8, 8); UiType(Slider); UiGroup("Material1/Color Correction/40"); >;
	float g_fDetailTextureNormalContrast1 < Default(1); Range(-2, 2); UiType(Slider); UiGroup("Material1/Detail/45"); >;
	int g_nColorCorrectionMode1 < UiOptions("0=Mask All,1=Mask only Tint"); UiType(Enum); UiGroup("Material1/Color Correction/45"); >;
	bool g_bModelTint1 < Default(1); UiType(CheckBox); UiGroup("Material1/Color Correction/60"); >;
	int g_nVertexColorMode1 < Range4(0, 0, 0, 0, 2, 2, 2, 2); UiOptions("0=Masked,1=Unmasked,2=Disabled"); UiType(Enum); UiGroup("Material1/Color Correction/60"); >;
	float g_flWetnessDarkeningStrength1 < Default(1); UiType(Slider); UiGroup("Material1/Lighting/61"); >;
	bool g_bSnowLayer1 < UiType(CheckBox); UiGroup("Material1/Snow,100"); >;
	
	// Material2
	CreateInputTexture2D(TextureColor2, Srgb, 8, "", "_color", "Material2/Color,10/0", Default4(1, 1, 1, 0));
	CreateInputTexture2D(TextureNormal2, Linear, 8, "NormalizeNormals", "_normal", "Material2/Lighting/0", Default4(0.5, 0.5, 1, 0));
	CreateInputTexture2D(TextureTintMask2, Linear, 8, "", "_mask", "Material2/Tint Mask,15/0", Default4(1, 1, 1, 0));
	float g_flColorReplace2 < Default(1); UiType(Slider); UiGroup("Material2/Selective Blending/0"); >;
	int g_nUVSet2 < Default(1); Range4(0, 0, 0, 0, 2, 2, 2, 2); UiOptions("0=Biplanar,1=UV1,2=UV2"); UiType(Enum); UiGroup("Material2/Texture Coordinates,34/1"); >;
	int g_nDetailUVSet2 < Default(-1); Range4(-1, -1, -1, -1, 2, 2, 2, 2); UiOptions("-1=Inherit,0=Biplanar,1=UV1,2=UV2"); UiType(Enum); UiGroup("Material2/Texture Coordinates,34/2"); >;
	float g_fTintMaskBrightness2 < Default(1); Range(0, 4); UiType(Slider); UiGroup("Material2/Tint Mask/5"); >;
	float2 g_vDetailTexCoordScale2 < Default2(1, 1); Range2(0, 0, 100, 100); Attribute("0=X,1=Y"); UiType(VectorText); UiGroup("Material2/Detail Texture Transform/6"); >;
	float g_flDetailTexCoordRotation2 < Range(-360, 360); UiType(Slider); UiGroup("Material2/Detail Texture Transform/8"); UiVisibility(1); >;
	CreateInputTexture2D(TextureHeight2, Linear, 8, "", "_height", "Material2/Height,30/10", Default4(0.5, 0.5, 0.5, 0));
	CreateInputTexture2D(TextureRoughness2, Linear, 8, "Inverse", "_rough", "Material2/Lighting/10", Default4(0.5, 0.5, 0.5, 0));
	float g_fTintMaskContrast2 < Default(1); Range(-2, 4); UiType(Slider); UiGroup("Material2/Tint Mask/10"); >;
	float g_flColorOverlay2 < UiType(Slider); UiGroup("Material2/Selective Blending/10"); >;
	float g_flDetailPropMaskSoftness2 < Default(0.01); UiType(Slider); UiGroup("Material2/Detail Props,90/10"); >;
	float3 g_vFacingDirection2 < Default(0); Range3(-1, -1, -1, 1, 1, 1); UiType(VectorText); UiGroup("Material2/Facing Direction/10"); Expression(normalize(float3(this.x,this.y,this.z+((this.z==0) ? .0001 : 0)))); UiVisibility(F_BLEND_BY_FACING_DIRECTION_2>0); >;
	float3 g_vTextureColorTint2 < Default3(1, 1, 1); UiType(Color); UiGroup("Material2/Color Correction,17/10"); >;
	float g_fTextureRoughnessContrast2 < Default(1); Range(0, 4); UiType(Slider); UiGroup("Material2,0/Lighting,20/11"); >;
	float g_fTextureRoughnessBrightness2 < Default(1); Range(0, 4); UiType(Slider); UiGroup("Material2/Lighting/12"); >;
	float g_fTextureNormalContrast2 < Default(1); Range(-2, 2); UiType(Slider); UiGroup("Material2/Lighting/13"); >;
	bool g_bMetalness2 < Default(1); UiType(CheckBox); UiGroup("Material2/Lighting/14"); >;
	CreateInputTexture2D(TextureAmbientOcclusion2, Linear, 8, "", "_ao", "Material2/Lighting/20", Default4(1, 1, 1, 0));
	float g_fTextureColorContrast2 < Default(1); Range(0, 4); UiType(Slider); UiGroup("Material2/Color Correction/20"); >;
	float g_flDetailPropMaskBias2 < Range(0, 10); UiType(Slider); UiGroup("Material2/Detail Props,90/20"); >;
	float g_flFacingDirectionMaskSpread2 < Default(0.5); UiType(Slider); UiGroup("Material2/Facing Direction/20"); UiVisibility(F_BLEND_BY_FACING_DIRECTION_2>0); >;
	float g_flHeightMapScale2 < Default(1); Range(-4, 4); UiType(Slider); UiGroup("Material2/Height/20"); >;
	float g_flHeightMapScale2 < Default(1); Range(-2, 2); UiType(Slider); UiGroup("Material2/Height/20"); >;
	float g_flNormalReplace2 < Default(1); UiType(Slider); UiGroup("Material2/Selective Blending/20"); >;
	float3 g_vAmbientOcclusionLevels2 < Default2(0, 0.5); Range(-1, 1); UiType(VectorText); UiGroup("Material2/Lighting/21"); Expression(float3(-this.x,-1.4427*log(max(.0001,1-this.y)),2-this.z)); >;
	CreateInputTexture2D(TextureMetalness2, Linear, 8, "", "_metal", "Material2/Lighting/30", Default4(0, 0, 0, 0));
	float g_fTextureColorSaturation2 < Default(1); Range(0, 4); UiType(Slider); UiGroup("Material2/Color Correction/30"); >;
	float g_flDetailPropPuddleReduction2 < UiType(Slider); UiGroup("Material2/Detail Props,90/30"); >;
	float g_flHeightMapZeroPoint2 < Default(0.5); UiType(Slider); UiGroup("Material2/Height/30"); >;
	float g_flNormalCombine2 < Range(0, 8); UiType(Slider); UiGroup("Material2/Selective Blending/30"); >;
	float g_vFacingDirectionMaskNormalMapStrength2 < Default(1); Range(0, 4); UiType(Slider); UiGroup("Material2/Facing Direction/30"); UiVisibility(F_BLEND_BY_FACING_DIRECTION_2>0); >;
	CreateInputTexture2D(TextureNormalDetail2, Linear, 8, "NormalizeNormals", "_normal", "Material2/Detail/35", Default4(0.5, 0.5, 1, 0));
	float g_fTextureColorBrightness2 < Default(1); Range(-8, 8); UiType(Slider); UiGroup("Material2/Color Correction/40"); >;
	float g_flBlendSoftness2 < Default(0.01); UiType(Slider); UiGroup("Material2/Height,30/40"); >;
	float g_flRoughnessReplace2 < Default(1); UiType(Slider); UiGroup("Material2/Selective Blending/40"); >;
	float g_vFacingDirectionMaskSoftness2 < Default(0.1); UiType(Slider); UiGroup("Material2/Facing Direction/40"); UiVisibility(F_BLEND_BY_FACING_DIRECTION_2>0); >;
	float g_flUnderlyingHeightMapInfluence2 < Default(1); Range(-2, 2); UiType(Slider); UiGroup("Material2/Height,30/41"); >;
	float g_fDetailTextureNormalContrast2 < Default(1); Range(-2, 2); UiType(Slider); UiGroup("Material2/Detail/45"); >;
	float g_flRoughnessCombine2 < UiType(Slider); UiGroup("Material2/Selective Blending/45"); >;
	int g_nColorCorrectionMode2 < UiOptions("0=Mask All,1=Mask only Tint"); UiType(Enum); UiGroup("Material2/Color Correction/45"); >;
	float g_flMetalnessReplace2 < Default(1); UiType(Slider); UiGroup("Material2/Selective Blending/50"); >;
	float g_flMetalnessCombine2 < UiType(Slider); UiGroup("Material2/Selective Blending/55"); >;
	bool g_bModelTint2 < Default(1); UiType(CheckBox); UiGroup("Material2/Color Correction/60"); >;
	float g_flAOReplace2 < Default(1); UiType(Slider); UiGroup("Material2/Selective Blending/60"); >;
	int g_nVertexColorMode2 < Range4(0, 0, 0, 0, 2, 2, 2, 2); UiOptions("0=Masked,1=Unmasked,2=Disabled"); UiType(Enum); UiGroup("Material2/Color Correction/60"); >;
	float g_flWetnessDarkeningStrength2 < Default(1); UiType(Slider); UiGroup("Material2/Lighting/62"); >;
	float g_flAOCombine2 < UiType(Slider); UiGroup("Material2/Selective Blending/70"); >;
	float g_flMaskWithHeight2 < Range(0, 8); UiType(Slider); UiGroup("Material2/Height/70"); >;
	bool g_bSnowLayer2 < UiType(CheckBox); UiGroup("Material2/Snow,100"); >;
	
	// Material3
	CreateInputTexture2D(TextureColor3, Srgb, 8, "", "_color", "Material3/Color,10/0", Default4(1, 1, 1, 0));
	CreateInputTexture2D(TextureNormal3, Linear, 8, "NormalizeNormals", "_normal", "Material3/Lighting/0", Default4(0.5, 0.5, 1, 0));
	CreateInputTexture2D(TextureTintMask3, Linear, 8, "", "_mask", "Material3/Tint Mask,15/0", Default4(1, 1, 1, 0));
	float g_flColorReplace3 < Default(1); UiType(Slider); UiGroup("Material3/Selective Blending/0"); >;
	int g_nUVSet3 < Default(1); Range4(0, 0, 0, 0, 2, 2, 2, 2); UiOptions("0=Biplanar,1=UV1,2=UV2"); UiType(Enum); UiGroup("Material3/Texture Coordinates,34/1"); >;
	int g_nDetailUVSet3 < Default(-1); Range4(-1, -1, -1, -1, 2, 2, 2, 2); UiOptions("-1=Inherit,0=Biplanar,1=UV1,2=UV2"); UiType(Enum); UiGroup("Material3/Texture Coordinates,34/2"); >;
	float2 g_vTexCoordScale3 < Default2(1, 1); Range2(0, 0, 100, 100); UiType(VectorText); UiGroup("Material3/Texture Transform,35/2"); >;
	float g_flTexCoordRotation3 < Range(-360, 360); UiType(Slider); UiGroup("Material3/Texture Transform,35/3"); UiVisibility(1); >;
	float g_fTintMaskBrightness3 < Default(1); Range(0, 4); UiType(Slider); UiGroup("Material3/Tint Mask/5"); >;
	float2 g_vDetailTexCoordScale3 < Default2(1, 1); Range2(0, 0, 100, 100); UiType(VectorText); UiGroup("Material3/Detail Texture Transform/6"); >;
	float g_flDetailTexCoordRotation3 < Range(-360, 360); UiType(Slider); UiGroup("Material3/Detail Texture Transform/8"); UiVisibility(1); >;
	CreateInputTexture2D(TextureHeight3, Linear, 8, "", "_height", "Material3/Height,30/10", Default4(0.5, 0.5, 0.5, 0));
	CreateInputTexture2D(TextureRoughness3, Linear, 8, "Inverse", "_rough", "Material3/Lighting/10", Default4(0.5, 0.5, 0.5, 0));
	float g_fTintMaskContrast3 < Default(1); Range(-2, 4); UiType(Slider); UiGroup("Material3/Tint Mask/10"); >;
	float g_flColorOverlay3 < UiType(Slider); UiGroup("Material3/Selective Blending/10"); >;
	float g_flDetailPropMaskSoftness3 < Default(0.01); UiType(Slider); UiGroup("Material3/Detail Props,90/10"); >;
	float3 g_vFacingDirection3 < Default(0); Range3(-1, -1, -1, 1, 1, 1); UiType(VectorText); UiGroup("Material3/Facing Direction/10"); Expression(normalize(float3(this.x,this.y,this.z+((this.z==0) ? .0001 : 0)))); UiVisibility(F_BLEND_BY_FACING_DIRECTION_3>0); >;
	float3 g_vTextureColorTint3 < Default3(1, 1, 1); UiType(Color); UiGroup("Material3/Color Correction,17/10"); >;
	float g_fTextureRoughnessContrast3 < Default(1); Range(0, 4); UiType(Slider); UiGroup("Material3,2/Lighting,20/11"); >;
	float g_fTextureRoughnessBrightness3 < Default(1); Range(0, 4); UiType(Slider); UiGroup("Material3/Lighting/12"); >;
	float g_fTextureNormalContrast3 < Default(1); Range(-2, 2); UiType(Slider); UiGroup("Material3/Lighting/13"); >;
	bool g_bMetalness3 < Default(1); UiType(CheckBox); UiGroup("Material3/Lighting/14"); >;
	CreateInputTexture2D(TextureAmbientOcclusion3, Linear, 8, "", "_ao", "Material3/Lighting/20", Default4(1, 1, 1, 0));
	float g_fTextureColorContrast3 < Default(1); Range(0, 4); UiType(Slider); UiGroup("Material3/Color Correction/20"); >;
	float g_flDetailPropMaskBias3 < Range(0, 10); UiType(Slider); UiGroup("Material3/Detail Props,90/20"); >;
	float g_flFacingDirectionMaskSpread3 < Default(0.5); UiType(Slider); UiGroup("Material3/Facing Direction/20"); UiVisibility(F_BLEND_BY_FACING_DIRECTION_3>0); >;
	float g_flHeightMapScale3 < Default(1); Range(-4, 4); UiType(Slider); UiGroup("Material3/Height/20"); >;
	float g_flHeightMapScale3 < Default(1); Range(-2, 2); UiType(Slider); UiGroup("Material3/Height/20"); >;
	float g_flNormalReplace3 < Default(1); UiType(Slider); UiGroup("Material3/Selective Blending/20"); >;
	float3 g_vAmbientOcclusionLevels3 < Default2(0, 0.5); Range(-1, 1); UiType(VectorText); UiGroup("Material3/Lighting/21"); Expression(float3(-this.x,-1.4427*log(max(.0001,1-this.y)),2-this.z)); >;
	CreateInputTexture2D(TextureMetalness3, Linear, 8, "", "_metal", "Material3/Lighting/30", Default4(0, 0, 0, 0));
	float g_fTextureColorSaturation3 < Default(1); Range(0, 4); UiType(Slider); UiGroup("Material3/Color Correction/30"); >;
	float g_flDetailPropPuddleReduction3 < UiType(Slider); UiGroup("Material3/Detail Props,90/30"); >;
	float g_flHeightMapZeroPoint3 < Default(0.5); UiType(Slider); UiGroup("Material3/Height/30"); >;
	float g_flNormalCombine3 < Range(0, 8); UiType(Slider); UiGroup("Material3/Selective Blending/30"); >;
	float g_vFacingDirectionMaskNormalMapStrength3 < Default(1); Range(0, 4); UiType(Slider); UiGroup("Material3/Facing Direction/30"); UiVisibility(F_BLEND_BY_FACING_DIRECTION_3>0); >;
	CreateInputTexture2D(TextureNormalDetail3, Linear, 8, "NormalizeNormals", "_normal", "Material3/Detail/35", Default4(0.5, 0.5, 1, 0));
	float g_fTextureColorBrightness3 < Default(1); Range(-8, 8); UiType(Slider); UiGroup("Material3/Color Correction/40"); >;
	float g_flBlendSoftness3 < Default(0.01); UiType(Slider); UiGroup("Material3/Height,30/40"); >;
	float g_flRoughnessReplace3 < Default(1); UiType(Slider); UiGroup("Material3/Selective Blending/40"); >;
	float g_vFacingDirectionMaskSoftness3 < Default(0.1); UiType(Slider); UiGroup("Material3/Facing Direction/40"); UiVisibility(F_BLEND_BY_FACING_DIRECTION_3>0); >;
	float g_flUnderlyingHeightMapInfluence3 < Default(1); Range(-2, 2); UiType(Slider); UiGroup("Material3/Height,30/41"); >;
	float g_fDetailTextureNormalContrast3 < Default(1); Range(-2, 2); UiType(Slider); UiGroup("Material3/Detail/45"); >;
	float g_flRoughnessCombine3 < UiType(Slider); UiGroup("Material3/Selective Blending/45"); >;
	int g_nColorCorrectionMode3 < UiOptions("0=Mask All,1=Mask only Tint"); UiType(Enum); UiGroup("Material3/Color Correction/45"); >;
	float g_flMetalnessReplace3 < Default(1); UiType(Slider); UiGroup("Material3/Selective Blending/50"); >;
	float g_flMetalnessCombine3 < UiType(Slider); UiGroup("Material3/Selective Blending/55"); >;
	float g_flAOReplace3 < Default(1); UiType(Slider); UiGroup("Material3/Selective Blending/60"); >;
	int g_nVertexColorMode3 < Range4(0, 0, 0, 0, 2, 2, 2, 2); UiOptions("0=Masked,1=Unmasked,2=Disabled"); UiType(Enum); UiGroup("Material3/Color Correction/60"); >;
	bool g_bModelTint3 < Default(1); UiType(CheckBox); UiGroup("Material3/Color Correction/61"); >;
	float g_flWetnessDarkeningStrength3 < Default(1); UiType(Slider); UiGroup("Material3/Lighting/63"); >;
	float g_flAOCombine3 < UiType(Slider); UiGroup("Material3/Selective Blending/70"); >;
	float g_flMaskWithHeight3 < Range(0, 8); UiType(Slider); UiGroup("Material3/Height/70"); >;
	bool g_bSnowLayer3 < UiType(CheckBox); UiGroup("Material3/Snow,100"); >;
	
	// Color
	CreateInputTexture2D(TextureSharedColorOverlay, Linear, 8, "", "_color", "Color/Overlay/0", Default4(1, 1, 1, 0));
	int g_nColorOverlayUVSet < Default(2); Range4(0, 0, 0, 0, 2, 2, 2, 2); UiOptions("0=Biplanar,1=UV1,2=UV2"); UiType(Enum); UiGroup("Color/Overlay/40"); >;
	int g_nColorOverlayMode < Range4(0, 0, 0, 0, 3, 3, 3, 3); UiOptions("0=All Layers,1=Layer1,2=Layer2,3=Layer3"); UiType(Enum); UiGroup("Color/Overlay/50"); >;
	int g_nColorOverlayTintMask < Range4(0, 0, 0, 0, 4, 4, 4, 4); UiOptions("0=Mask All,1=Mask Layer1,2=Mask Layer2,3=Mask Layer3,4=Unmasked"); UiType(Enum); UiGroup("Color/Overlay/55"); >;
	float3 g_vColorOverlayLayerStrengths < Default3(1, 1, 1); UiType(VectorText); UiGroup("Color/Overlay/60"); >;
	float3 g_vColorOverlayTintMaskStrengths < Range3(-1, -1, -1, 1, 1, 1); UiType(VectorText); UiGroup("Color/Overlay/65"); >;
	float g_flOverlayDarknessContrast < Default(1); Range(0.2, 2); UiType(Slider); UiGroup("Color/Overlay/100"); >;
	int g_nScaleTexCoord2UByModelScaleAxis < Range4(0, 0, 0, 0, 3, 3, 3, 3); UiOptions("0=None,1=UV2.u * model.x,2=UV2.u * model.y,3=UV2.u * model.z"); UiType(Enum); UiGroup("Color/100"); UiVisibility(1); >;
	float g_flOverlayBrightnessContrast < Default(1); Range(0.2, 2); UiType(Slider); UiGroup("Color/Overlay/110"); >;
	int g_nScaleTexCoord2VByModelScaleAxis < Range4(0, 0, 0, 0, 3, 3, 3, 3); UiOptions("0=None,1=UV2.v * model.x,2=UV2.v * model.y,3=UV2.v * model.z"); UiType(Enum); UiGroup("Color/110"); UiVisibility(1); >;
	float g_flBlendSoftnessDistanceModifierStrength < Default(1); UiType(Slider); UiGroup("Color/120"); >;
	float2 g_vOverlayTexCoordScale < Default2(1, 1); Range2(0, 0, 100, 100); UiType(VectorText); UiGroup("Color/Overlay/210"); >;
	float g_flOverlayTexCoordRotation < Range(-360, 360); UiType(Slider); UiGroup("Color/Overlay/220"); >;
	
	// Blend Effects
	float g_flBorderSpread2 < Default(0.1); UiType(Slider); UiGroup("Blend Effects,8/Border Layer 2,0/10"); >;
	float g_flBorderSpread3 < Default(0.1); UiType(Slider); UiGroup("Blend Effects/Border Layer 3,10/10"); >;
	float g_flBorderSoftness2 < Default(0.1); UiType(Slider); UiGroup("Blend Effects/Border Layer 2/20"); >;
	float g_flBorderSoftness3 < Default(0.1); UiType(Slider); UiGroup("Blend Effects/Border Layer 3/20"); >;
	float g_flBorderOffset2 < Range(-4, 4); UiType(Slider); UiGroup("Blend Effects/Border Layer 2/30"); >;
	float g_flBorderOffset3 < Range(-4, 4); UiType(Slider); UiGroup("Blend Effects/Border Layer 3/30"); >;
	float g_fBorderRoughness2 < Default(0.5); UiType(Slider); UiGroup("Blend Effects/Border Layer 2/35"); UiVisibility(F_BORDER_ROUGHNESS_2); >;
	float g_fBorderRoughness3 < Default(0.5); UiType(Slider); UiGroup("Blend Effects/Border Layer 3/35"); UiVisibility(F_BORDER_ROUGHNESS_3); >;
	float3 g_vBorderTint2 < Default3(1, 1, 1); UiType(Color); UiGroup("Blend Effects/Border Layer 2/40"); Expression(SrgbGammaToLinear(this)); >;
	float3 g_vBorderTint3 < Default3(1, 1, 1); UiType(Color); UiGroup("Blend Effects/Border Layer 3/40"); Expression(SrgbGammaToLinear(this)); >;
	bool g_bBorderTintMask3 < UiType(CheckBox); UiGroup("Blend Effects/Border Layer 3/41"); >;
	float2 g_vBorderLayerAmount2 < Default(1); UiType(VectorText); UiGroup("Blend Effects/Border Layer 2/41"); >;
	float2 g_vBorderLayerAmount3 < Default(1); UiType(VectorText); UiGroup("Blend Effects/Border Layer 3/41"); >;
	bool g_bBorderTintMask2 < UiType(CheckBox); UiGroup("Blend Effects/Border Layer 2/42"); >;
	float g_flBevelSpread2 < Default(0.1); UiType(Slider); UiGroup("Blend Effects/Bevel Layer 2,5/50"); >;
	float g_flBevelSpread3 < Default(0.1); UiType(Slider); UiGroup("Blend Effects/Bevel Layer 3,15/50"); >;
	float g_flBevelSoftness2 < Default(0.1); UiType(Slider); UiGroup("Blend Effects/Bevel Layer 2/60"); >;
	float g_flBevelSoftness3 < Default(0.1); UiType(Slider); UiGroup("Blend Effects/Bevel Layer 3/60"); >;
	float g_flBevelOffset2 < Range(-4, 4); UiType(Slider); UiGroup("Blend Effects/Bevel Layer 2/65"); >;
	float g_flBevelOffset3 < Range(-4, 4); UiType(Slider); UiGroup("Blend Effects/Bevel Layer 3/65"); >;
	float g_flBevelStrength2 < Range(-1, 1); UiType(Slider); UiGroup("Blend Effects/Bevel Layer 2/70"); Expression(this*.01); >;
	float g_flBevelStrength3 < Range(-1, 1); UiType(Slider); UiGroup("Blend Effects/Bevel Layer 3/70"); Expression(this*.01); >;
	float g_flBevelCurve2 < Range(-1, 1); UiType(Slider); UiGroup("Blend Effects/Bevel Layer 2/80"); >;
	float g_flBevelCurve3 < Range(-1, 1); UiType(Slider); UiGroup("Blend Effects/Bevel Layer 3/80"); >;
	float2 g_vBevelLayerAmount2 < Default2(1, 1); UiType(VectorText); UiGroup("Blend Effects/Bevel Layer 2/90"); >;
	float2 g_vBevelLayerAmount3 < Default2(1, 1); UiType(VectorText); UiGroup("Blend Effects/Bevel Layer 3/90"); >;
	
	// Fog
	bool g_bFogEnabled < Default(1); UiType(CheckBox); UiGroup("Fog"); >;
	
	// Wetness
	bool g_bWetnessUseHeightmapAdjustments < UiType(CheckBox); UiGroup("Wetness/2"); UiVisibility(F_WETNESS ? 1 : 0); >;
	bool g_bPuddlesOnVerticalSurfaces < UiType(CheckBox); UiGroup("Wetness,9/3"); UiVisibility(F_WETNESS ? 1 : 0); >;
	float g_flWetnessUnderlyingHeightMapInfluence < Default(1); Range(0, 2); UiType(Slider); UiGroup("Wetness/3"); UiVisibility(F_WETNESS ? 1 : 0); >;
	float g_flHorizontalSurfaceTolerance < Default(32); Range(0, 100); UiType(Slider); UiGroup("Wetness/4"); UiVisibility(F_WETNESS ? 1 : 0); >;
	float g_fPuddleStrength < Default(1); UiType(Slider); UiGroup("Wetness/5"); UiVisibility(F_WETNESS ? 1 : 0); >;
	float g_fPuddleHeight < Default(0.5); UiType(Slider); UiGroup("Wetness/6"); UiVisibility(F_WETNESS ? 1 : 0); >;
	float3 g_vPuddleSedimentColor < Default3(0.62, 0.56, 0.5); UiType(Color); UiGroup("Wetness/10"); Expression(SrgbGammaToLinear(this)); UiVisibility(F_WETNESS ? 1 : 0); >;
	float g_fPuddleSedimentHeight < Default(0.9); Range(0, 2); UiType(Slider); UiGroup("Wetness/15"); Expression(this*2-1); UiVisibility(F_WETNESS ? 1 : 0); >;
	float g_fPuddleSedimentOpacity < Default(0.25); UiType(Slider); UiGroup("Wetness/16"); UiVisibility(F_WETNESS ? 1 : 0); >;
	float g_fPuddleRoughness < Default(0.02); UiType(Slider); UiGroup("Wetness/17"); UiVisibility(F_WETNESS ? 1 : 0); >;
	float g_fPuddleBlendSoftness < Default(0.08); UiType(Slider); UiGroup("Wetness/18"); UiVisibility(F_WETNESS ? 1 : 0); >;
	float g_fWetEdgeStrength < Default(0.5); UiType(Slider); UiGroup("Wetness/20"); UiVisibility(F_WETNESS ? 1 : 0); >;
	float g_fWetEdgeSpread < Default(0.2); UiType(Slider); UiGroup("Wetness/25"); UiVisibility(F_WETNESS ? 1 : 0); >;
	float g_fWetEdgeSoftness < Default(0.2); UiType(Slider); UiGroup("Wetness/26"); UiVisibility(F_WETNESS ? 1 : 0); >;
	float g_fWetnessStrength < Default(1); Range(0, 2); UiType(Slider); UiGroup("Wetness/30"); UiVisibility(F_WETNESS ? 1 : 0); >;
	float g_fRainStrength < Default(1); Range(0, 2); UiType(Slider); UiGroup("Wetness/35"); UiVisibility(F_WETNESS ? 1 : 0); >;
	float g_fRippleStrength < Default(1); Range(0, 2); UiType(Slider); UiGroup("Wetness/40"); UiVisibility(F_WETNESS ? 1 : 0); >;
	
	// Translucent
	float g_flAlphaTestReference < Default(0.5); Range(0.01, 0.99); UiType(Slider); UiGroup("Translucent"); >;
	float g_flAntiAliasedEdgeStrength < Default(1); UiType(Slider); UiGroup("Translucent"); >;
	
	// Occlusion Culling
	float g_flOcclusionCullingBoundsScale < Default(1); Range(1, 100); UiType(Slider); UiGroup("Occlusion Culling"); UiVisibility(F_OCCLUSION_CULLING_BOUNDS_SCALE); >;
	
	// Texture Address Mode
	int g_nTextureAddressModeU < UiOption("RsTextureAddressMode_t"); UiType(Enum); UiGroup("Texture Address Mode"); >;
	int g_nTextureAddressModeV < UiOption("RsTextureAddressMode_t"); UiType(Enum); UiGroup("Texture Address Mode"); >;
	
	#if (S_MODE_DEPTH == 1)
		Texture2D g_tColor1 < Channel(RGB, ArtistDefinedOrAlphaWeighted(TextureColor1, TextureTranslucency1), Srgb); Channel(A, PreserveCoverage(TextureTranslucency1), Linear); OutputFormat(BC7); SrgbRead(true); >;
	#endif
	#if (S_ENABLE_LAYER_3 == 1)
		Texture2D g_tColor1 < Channel(RGB, ArtistDefinedOrAlphaWeighted(TextureColor1, TextureTranslucency1), Srgb); Channel(A, PreserveCoverage(TextureTranslucency1), Linear); OutputFormat(BC7); SrgbRead(true); >;
	#endif
	#if (S_ALPHA_TEST == 1)
		Texture2D g_tColor1 < Channel(RGB, ArtistDefinedOrAlphaWeighted(TextureColor1, TextureTranslucency1), Srgb); Channel(A, PreserveCoverage(TextureTranslucency1), Linear); OutputFormat(BC7); SrgbRead(true); >;
	#endif
	#if (S_SHADER_QUALITY == 1)
		Texture2D g_tColor1 < Channel(RGB, ArtistDefinedOrAlphaWeighted(TextureColor1, TextureTranslucency1), Srgb); Channel(A, PreserveCoverage(TextureTranslucency1), Linear); OutputFormat(BC7); SrgbRead(true); >;
	#endif
	#if (S_BLEND_EFFECTS_2 == 1)
		Texture2D g_tColor1 < Channel(RGB, ArtistDefinedOrAlphaWeighted(TextureColor1, TextureTranslucency1), Srgb); Channel(A, PreserveCoverage(TextureTranslucency1), Linear); OutputFormat(BC7); SrgbRead(true); >;
	#endif
	#if (S_BLEND_EFFECTS_3 == 1)
		Texture2D g_tColor1 < Channel(RGB, ArtistDefinedOrAlphaWeighted(TextureColor1, TextureTranslucency1), Srgb); Channel(A, PreserveCoverage(TextureTranslucency1), Linear); OutputFormat(BC7); SrgbRead(true); >;
	#endif
	
	// Variant parameters
	bool bBiplanarUsedAny < UiType(CheckBox); Expression(g_nUVSet1==0 || g_nUVSet2==0); >;
	bool bBiplanarUsedAny < UiType(CheckBox); Expression(g_nUVSet1==0 || g_nUVSet2==0 || g_nUVSet3==0); >;
	bool bBiplanarUsedAny < UiType(CheckBox); Expression(g_nUVSet1==0 || g_nUVSet2==0 || g_nColorOverlayUVSet==0); >;
	bool bBiplanarUsedAny < UiType(CheckBox); Expression(g_nUVSet1==0 || g_nUVSet2==0 || g_nUVSet3==0 || g_nColorOverlayUVSet==0); >;
	bool bBiplanarUsedAny < UiType(CheckBox); Expression(g_nUVSet1==0 || g_nUVSet2==0 || g_nDetailUVSet1==0 || g_nDetailUVSet2==0); >;
	bool bBiplanarUsedAny < UiType(CheckBox); Expression(g_nUVSet1==0 || g_nUVSet2==0 || g_nDetailUVSet1==0 || g_nDetailUVSet2==0 || g_nColorOverlayUVSet==0); >;
	bool bBiplanarUsedAny < UiType(CheckBox); Expression(g_nUVSet1==0 || g_nUVSet2==0 || g_nUVSet3==0 || g_nDetailUVSet1==0 || g_nDetailUVSet2==0 || g_nDetailUVSet3==0); >;
	bool bBiplanarUsedAny < UiType(CheckBox); Expression(g_nUVSet1==0 || g_nUVSet2==0 || g_nUVSet3==0 || g_nDetailUVSet1==0 || g_nDetailUVSet2==0 || g_nDetailUVSet3==0 || g_nColorOverlayUVSet==0); >;
	float g_flHeightMapScale1 < Default(1); Range(-4, 4); UiType(Slider); UiGroup("Material1/Height/20"); >;
	float g_flHeightMapScale1 < Default(1); Range(-2, 2); UiType(Slider); UiGroup("Material1/Height/20"); >;
	float g_flHeightMapScale2 < Default(1); Range(-4, 4); UiType(Slider); UiGroup("Material2/Height/20"); >;
	float g_flHeightMapScale2 < Default(1); Range(-2, 2); UiType(Slider); UiGroup("Material2/Height/20"); >;
	float g_flHeightMapScale3 < Default(1); Range(-4, 4); UiType(Slider); UiGroup("Material3/Height/20"); >;
	float g_flHeightMapScale3 < Default(1); Range(-2, 2); UiType(Slider); UiGroup("Material3/Height/20"); >;
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
	
	const vec3 _1834[3] = vec3[](vec3(-1.0, 0.0, 0.0), vec3(0.0, 1.0, 0.0), vec3(-1.0, 0.0, 0.0));
	const vec3 _647[3] = vec3[](vec3(0.0, 0.0, 1.0), vec3(0.0, -1.0, 0.0), vec3(0.0, 0.0, 1.0));
	
	struct _1021
	{
	    vec4 _m0[3];
	};
	
	struct _1189
	{
	    vec4 _m0[4];
	};
	
	struct _638
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
	vec2 _10;
	
	struct _558
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
	};
	
	layout(set = 1) uniform _558 PerViewConstantBufferCsgo_t;
	
	struct _1263
	{
	    float _m0;
	    vec2 _m1;
	    vec2 _m2;
	    vec4 _m3;
	    vec3 _m4;
	};
	
	layout(set = 1) uniform _1263 PerViewConstantBuffer_t;
	
	struct _225
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
	    float g_flBlendSoftness2;
	    int g_bSnowLayer2;
	    int g_nUVSet2;
	    vec2 g_vTexCoordScale2;
	    vec4 g_vNormalXform_2;
	    float g_flWetnessDarkeningStrength2;
	    uint g_tNormal1;
	    uint g_tHeight1;
	    float g_fTintMaskContrast1;
	    float g_fTintMaskBrightness1;
	    vec3 g_vAmbientOcclusionLevels1;
	    int g_bAdjustBaseColor1;
	    float g_flHeightMapScale1;
	    float g_flHeightMapZeroPoint1;
	    int g_bVertexColorEnabled1;
	    int g_bMaskVertexColor1;
	    float g_fTextureRoughnessContrast1;
	    float g_fTextureRoughnessBrightness1;
	    float g_fTextureNormalContrast1;
	    int g_bMetalness1;
	    int g_bModelTint1;
	    mat4 g_mTextureColorAdjust1;
	    mat4 g_mTextureAdjust1;
	    float g_flBlendSoftnessDistanceModifierStrength;
	    float g_flColorReplace2;
	    float g_flColorOverlay2;
	    float g_flNormalReplace2;
	    float g_flNormalCombine2;
	    float g_flRoughnessReplace2;
	    float g_flRoughnessCombine2;
	    float g_flMetalnessReplace2;
	    float g_flMetalnessCombine2;
	    float g_flAOReplace2;
	    float g_flAOCombine2;
	    float g_fTextureRoughnessContrast2;
	    float g_fTextureRoughnessBrightness2;
	    float g_fTextureNormalContrast2;
	    int g_bMetalness2;
	    float g_fTintMaskContrast2;
	    float g_fTintMaskBrightness2;
	    uint g_tColor2;
	    uint g_tNormal2;
	    uint g_tHeight2;
	    vec3 g_vAmbientOcclusionLevels2;
	    int g_bAdjustBaseColor2;
	    mat4 g_mTextureColorAdjust2;
	    mat4 g_mTextureAdjust2;
	    float g_flHeightMapScale2;
	    float g_flHeightMapZeroPoint2;
	    float g_flMaskWithHeight2;
	    vec3 g_vFacingDirection2;
	    float g_flFacingDirectionMaskSpread2;
	    float g_vFacingDirectionMaskNormalMapStrength2;
	    float g_vFacingDirectionMaskSoftness2;
	    int g_bVertexColorEnabled2;
	    int g_bMaskVertexColor2;
	    int g_bModelTint2;
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
	    int bBlendByFacingDirection2;
	    int g_bWetness;
	    int bBiplanarUsedAny;
	};
	
	layout(set = 1) uniform _225 _Globals_;
	
	struct _1124
	{
	    _1021 _m0;
	    _1189 _m1;
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
	    _638 _m18;
	    _1189 _m19;
	    uint _m20;
	    uint _m21;
	};
	
	layout(set = 3) uniform _1124 PerViewLightingConstantBufferGpu_t;
	
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
	    float _10136 = saturate((input_0.x * 1.10000002384185791015625) - 0.0500000007450580596923828125);
	    float _20519 = saturate((input_0.y * 1.10000002384185791015625) - 0.0500000007450580596923828125);
	    vec3 _18843 = normalize(vec3(saturate((1.0 - _10136) - _20519), _10136, _20519));
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
	    vec2 _6616;
	    ivec2 _13136;
	    vec2 _13694;
	    ivec2 _16305;
	    vec2 _17114;
	    vec2 _17115;
	    vec2 _17116;
	    vec2 _17117;
	    vec2 _17118;
	    if (_Globals_.bBiplanarUsedAny != 0)
	    {
	        vec3 _10577 = abs(_24347);
	        vec3 _16100 = _10577;
	        float _17349 = _10577.x;
	        float _8043 = _10577.y;
	        bool _12886;
	        if (_17349 > _8043)
	        {
	            _12886 = _17349 > _10577.z;
	        }
	        else
	        {
	            _12886 = false;
	        }
	        ivec3 _23727;
	        if (_12886)
	        {
	            _23727 = ivec3(0, 1, 2);
	        }
	        else
	        {
	            _23727 = mix(ivec3(2, 0, 1), ivec3(1, 2, 0), bvec3(_8043 > _10577.z));
	        }
	        bool _12887;
	        if (_17349 < _8043)
	        {
	            _12887 = _17349 < _10577.z;
	        }
	        else
	        {
	            _12887 = false;
	        }
	        ivec3 _11775;
	        if (_12887)
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
	        vec3 _16418 = _18781;
	        vec3 _16419 = dFdxFine(_18781);
	        vec3 _16446 = dFdyFine(_18781);
	        _13136 = _19321;
	        _16305 = _19322;
	        _17114 = vec2(_16418[_19321.x], _16418[_19321.y]);
	        _17115 = vec2(_16418[_19322.x], _16418[_19322.y]);
	        _17116 = vec2(_16419[_19321.x], _16419[_19321.y]);
	        _17117 = vec2(_16446[_19321.x], _16446[_19321.y]);
	        _17118 = vec2(_16419[_19322.x], _16419[_19322.y]);
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
	    bool _17559 = _Globals_.g_nUVSet1 > 1;
	    vec2 _21710;
	    if (_17559)
	    {
	        _21710 = input_4.xy;
	    }
	    else
	    {
	        _21710 = vec2(0.0);
	    }
	    bool _17560 = _Globals_.g_nUVSet2 > 1;
	    vec2 _22864;
	    if (_17560)
	    {
	        _22864 = input_4.zw;
	    }
	    else
	    {
	        _22864 = _21710;
	    }
	    vec3 _22993 = _10061 - PerViewConstantBuffer_t._m4.xyz;
	    bool _12888;
	    if (_14874)
	    {
	        _12888 = _Globals_.g_bDontFlipBackfaceNormals == 0;
	    }
	    else
	    {
	        _12888 = false;
	    }
	    bool _18545;
	    if (_12888)
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
	    vec3 _9521 = input_7.xyz * _12157;
	    vec3 _15323 = (cross(input_3, input_7.xyz) * ((input_7.w > 0.0) ? 1.0 : (-1.0))) * _12157;
	    vec3 _8889;
	    if (_18545)
	    {
	        _8889 = _11587 * (-1.0);
	    }
	    else
	    {
	        _8889 = _11587;
	    }
	    vec3 _10020;
	    vec3 _22186;
	    if (_17560 ? true : _17559)
	    {
	        vec2 _16592 = dFdxFine(_22864);
	        vec2 _18145 = dFdyFine(_22864);
	        float _17522 = _18145.y;
	        float _15279 = dot(_16592, vec2(_17522, -_18145.x));
	        float _17298 = (_15279 < 0.0) ? (-1.0) : 1.0;
	        vec2 _24530 = vec2(_17522, -_16592.y) * _17298;
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
	        _10020 = _9082;
	        _22186 = cross(_8889, _9082) * (_17298 * float((dot(_20949, cross(_8889, _7147)) < 0.0) ? (-1) : 1));
	    }
	    else
	    {
	        _10020 = vec3(0.0);
	        _22186 = vec3(0.0);
	    }
	    vec3 _18905;
	    _18905.x = input_4.x;
	    _18905.y = input_4.y;
	    bool _23685 = _Globals_.g_nUVSet1 == 0;
	    vec4 _9716;
	    vec3 _24878;
	    if (_23685)
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
	    if (_23685)
	    {
	        _19323 = (textureGrad(sampler2D(g_bindless_Texture2D_float4[_Globals_.g_tHeight1], g_bindless_Sampler[_Globals_.g_sUserConfig]), (_17114 * _Globals_.g_vTexCoordScale1.xy).xy, (_17116 * _Globals_.g_vTexCoordScale1.xy).xy, (_17117 * _Globals_.g_vTexCoordScale1.xy).xy) * _6616.x) + (textureGrad(sampler2D(g_bindless_Texture2D_float4[_Globals_.g_tHeight1], g_bindless_Sampler[_Globals_.g_sUserConfig]), (_17115 * _Globals_.g_vTexCoordScale1.xy).xy, (_17118 * _Globals_.g_vTexCoordScale1.xy).xy, (_13694 * _Globals_.g_vTexCoordScale1.xy).xy) * _6616.y);
	    }
	    else
	    {
	        _19323 = texture(sampler2D(g_bindless_Texture2D_float4[_Globals_.g_tHeight1], g_bindless_Sampler[_Globals_.g_sUserConfig]), _24878.xy).xyzw;
	    }
	    vec2 _6383 = textureQueryLod(sampler2D(g_bindless_Texture2D_float4[_Globals_.g_tHeight1], g_bindless_Sampler[_Globals_.g_sUserConfig]), _24878.xy);
	    float _16356 = _6383.x;
	    float _19275 = fwidth(_19323.x * _Globals_.g_flHeightMapScale1);
	    float _15317 = ((((_16356 * _16356) * (0.012500000186264514923095703125 + _19275)) * 0.0199999995529651641845703125) * _Globals_.g_flBlendSoftnessDistanceModifierStrength) * _18843.x;
	    float _8284 = max(min(input_0.w + _Globals_.g_flBlendSoftness2, 1.0), 9.9999997473787516355514526367188e-05) + _15317;
	    bool _14876 = _Globals_.g_bWetnessUseHeightmapAdjustments != 0;
	    float _11237;
	    SPIRV_CROSS_BRANCH
	    if (_14876)
	    {
	        _11237 = max(0.0, ((_19323.x + 0.5) - _Globals_.g_flHeightMapZeroPoint1) * _Globals_.g_flHeightMapScale1);
	    }
	    else
	    {
	        _11237 = _19323.x;
	    }
	    float _17767 = _Globals_.g_flHeightMapZeroPoint1 + (_15317 * 0.5);
	    float _6379 = _Globals_.g_flHeightMapScale1 + _8284;
	    float _20609 = (_19323.x - _17767) * _6379;
	    float _13138;
	    vec3 _13189;
	    vec4 _22995;
	    if (_23685)
	    {
	        vec2 _21820 = (_17114 * _Globals_.g_vTexCoordScale1.xy).xy;
	        vec2 _17053 = (_17116 * _Globals_.g_vTexCoordScale1.xy).xy;
	        vec2 _8903 = (_17117 * _Globals_.g_vTexCoordScale1.xy).xy;
	        vec4 _23806 = textureGrad(sampler2D(g_bindless_Texture2D_float4[_Globals_.g_tColor1], g_bindless_Sampler[_Globals_.g_sUserConfig]), _21820, _17053, _8903) * _6616.x;
	        vec4 _12167 = textureGrad(sampler2D(g_bindless_Texture2D_float4[_Globals_.g_tNormal1], g_bindless_Sampler[_Globals_.g_sUserConfig]), _21820, _17053, _8903);
	        float _18178 = _12167.z * _6616.x;
	        float _15456 = _12167.x;
	        float _24534 = _12167.y;
	        float _16784 = (_15456 + _24534) - 1.00392162799835205078125;
	        float _11177 = _15456 - _24534;
	        vec3 _21631 = normalize(vec3(vec2(_16784, _11177), (1.0 - abs(_16784)) - abs(_11177))).xyz * _6616.x;
	        vec3 _24466 = (_1834[_13136.x] * _21631.x) + (_647[_13136.y] * _21631.y);
	        float _13137;
	        vec3 _13753;
	        vec4 _14101;
	        if (_6616.y > 0.0)
	        {
	            vec2 _17048 = (_17115 * _Globals_.g_vTexCoordScale1.xy).xy;
	            vec2 _10018 = (_17118 * _Globals_.g_vTexCoordScale1.xy).xy;
	            vec2 _8904 = (_13694 * _Globals_.g_vTexCoordScale1.xy).xy;
	            vec4 _12168 = textureGrad(sampler2D(g_bindless_Texture2D_float4[_Globals_.g_tNormal1], g_bindless_Sampler[_Globals_.g_sUserConfig]), _17048, _10018, _8904);
	            float _13491 = _12168.x;
	            float _21308 = _12168.y;
	            float _16785 = (_13491 + _21308) - 1.00392162799835205078125;
	            float _11178 = _13491 - _21308;
	            vec3 _21632 = normalize(vec3(vec2(_16785, _11178), (1.0 - abs(_16785)) - abs(_11178))).xyz * _6616.y;
	            _13137 = _18178 + (_12168.z * _6616.y);
	            _14101 = _23806 + (textureGrad(sampler2D(g_bindless_Texture2D_float4[_Globals_.g_tColor1], g_bindless_Sampler[_Globals_.g_sUserConfig]), _17048, _10018, _8904) * _6616.y);
	            _13753 = _24466 + ((_1834[_16305.x] * _21632.x) + (_647[_16305.y] * _21632.y));
	        }
	        else
	        {
	            _13137 = _18178;
	            _14101 = _23806;
	            _13753 = _24466;
	        }
	        _13138 = _13137;
	        _13189 = normalize(_13753 + _24347);
	        _22995 = _14101;
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
	        bvec3 _20662 = bvec3(_17559);
	        vec3 _10844 = abs(_19582.xyz);
	        vec2 _16475 = (-vec2(_7796, (-1.0) * _19701)) / vec2(max(_10844.z, 0.0078125 * max(_10844.x, _10844.y)));
	        _13138 = _11179.z;
	        _13189 = normalize(_8889 - ((mix(_9521, _10020, _20662) * _16475.x) + (mix(_15323, _22186, _20662) * _16475.y)));
	        _22995 = textureGrad(sampler2D(g_bindless_Texture2D_float4[_Globals_.g_tColor1], g_bindless_Sampler[_Globals_.g_sUserConfig]), _24878.xy, _9716.xy, _9716.zw).xyzw;
	    }
	    float _7812 = saturate(((_Globals_.g_fTextureRoughnessContrast1 * (_13138 - 0.5)) + 0.5) * _Globals_.g_fTextureRoughnessBrightness1);
	    vec4 _23230 = vec4(_22995.xyz, 1.0);
	    float _10048 = saturate(mix(_Globals_.g_vAmbientOcclusionLevels1.x, _Globals_.g_vAmbientOcclusionLevels1.z, pow(_22995.w, _Globals_.g_vAmbientOcclusionLevels1.y)));
	    float _9068 = _19323.w * float(_Globals_.g_bMetalness1 != 0);
	    float _24803 = saturate(((_Globals_.g_fTintMaskContrast1 * (_19323.y - 0.5)) + 0.5) * _Globals_.g_fTintMaskBrightness1);
	    vec3 _25191 = mix(mix(_22995, vec4((_23230 * _Globals_.g_mTextureAdjust1).xyz, _22995.w), bvec4(_Globals_.g_bAdjustBaseColor1 != 0)).xyz, vec4((_23230 * _Globals_.g_mTextureColorAdjust1).xyz, _4).xyz, vec3(_24803));
	    vec4 _17842;
	    _17842.x = _25191.x;
	    _17842.y = _25191.y;
	    _17842.z = _25191.z;
	    float _24323 = dot(_17842.xyz, vec3(0.2125000059604644775390625, 0.7153999805450439453125, 0.07209999859333038330078125));
	    vec3 _9577 = normalize(max(input_1.xyz, vec3(0.001000000047497451305389404296875)));
	    float _21159 = dot(_9577.xyz, vec3(0.2125000059604644775390625, 0.7153999805450439453125, 0.07209999859333038330078125));
	    float _24175 = max(input_1.x, max(input_1.y, input_1.z));
	    vec3 _24174 = normalize(mix(_24347, _13189, vec3(_Globals_.g_fTextureNormalContrast1))).xyz;
	    vec3 _23405 = vec4(saturate(mix(_17842.xyz, (_9577 * min(_24323 / _21159, (3.0 * _24323) * _24175)).xyz, vec3((input_1.w * _24803) * float(_Globals_.g_bModelTint1 != 0)))).xyz, _7).xyz;
	    vec2 _22927;
	    _22927.x = _7812;
	    float _7406 = float(_Globals_.g_bSnowLayer1 != 0);
	    bool _12889;
	    if (_Globals_.g_flColorOverlay2 == 0.0)
	    {
	        _12889 = _Globals_.g_flColorReplace2 == 0.0;
	    }
	    else
	    {
	        _12889 = false;
	    }
	    bool _12890;
	    if (_12889)
	    {
	        _12890 = _Globals_.g_flAOCombine2 == 0.0;
	    }
	    else
	    {
	        _12890 = false;
	    }
	    bool _21711;
	    if (_12890)
	    {
	        _21711 = _Globals_.g_flAOReplace2 == 0.0;
	    }
	    else
	    {
	        _21711 = false;
	    }
	    bool _12891;
	    if (_Globals_.g_flNormalCombine2 == 0.0)
	    {
	        _12891 = _Globals_.g_flNormalReplace2 == 0.0;
	    }
	    else
	    {
	        _12891 = false;
	    }
	    bool _12892;
	    if (_12891)
	    {
	        _12892 = _Globals_.g_flRoughnessCombine2 == 0.0;
	    }
	    else
	    {
	        _12892 = false;
	    }
	    bool _21712;
	    if (_12892)
	    {
	        _21712 = _Globals_.g_flRoughnessReplace2 == 0.0;
	    }
	    else
	    {
	        _21712 = false;
	    }
	    vec3 _18906;
	    _18906.x = input_4.z;
	    _18906.y = input_4.w;
	    bool _23686 = _Globals_.g_nUVSet2 == 0;
	    vec4 _9717;
	    vec3 _24879;
	    if (_23686)
	    {
	        _9717 = vec4(0.0);
	        _24879 = _18906;
	    }
	    else
	    {
	        vec4 _8626 = vec4(dFdx(_18906.xy), dFdy(_18906.xy));
	        vec2 _20313 = _18906.xy + vec2(length(_8626) * 1.0000000133514319600180897396058e-10);
	        vec3 _20489;
	        _20489.x = _20313.x;
	        _20489.y = _20313.y;
	        _9717 = _8626;
	        _24879 = _20489;
	    }
	    vec4 _19324;
	    if (_23686)
	    {
	        _19324 = (textureGrad(sampler2D(g_bindless_Texture2D_float4[_Globals_.g_tHeight2], g_bindless_Sampler[_Globals_.g_sUserConfig]), (_17114 * _Globals_.g_vTexCoordScale2.xy).xy, (_17116 * _Globals_.g_vTexCoordScale2.xy).xy, (_17117 * _Globals_.g_vTexCoordScale2.xy).xy) * _6616.x) + (textureGrad(sampler2D(g_bindless_Texture2D_float4[_Globals_.g_tHeight2], g_bindless_Sampler[_Globals_.g_sUserConfig]), (_17115 * _Globals_.g_vTexCoordScale2.xy).xy, (_17118 * _Globals_.g_vTexCoordScale2.xy).xy, (_13694 * _Globals_.g_vTexCoordScale2.xy).xy) * _6616.y);
	    }
	    else
	    {
	        _19324 = texture(sampler2D(g_bindless_Texture2D_float4[_Globals_.g_tHeight2], g_bindless_Sampler[_Globals_.g_sUserConfig]), _24879.xy).xyzw;
	    }
	    vec2 _6384 = textureQueryLod(sampler2D(g_bindless_Texture2D_float4[_Globals_.g_tHeight2], g_bindless_Sampler[_Globals_.g_sUserConfig]), _24879.xy);
	    float _16357 = _6384.x;
	    float _19276 = fwidth(_19324.x * _Globals_.g_flHeightMapScale2);
	    float _19817 = _15317 + (((((_16357 * _16357) * (0.012500000186264514923095703125 + _19276)) * 0.0199999995529651641845703125) * _Globals_.g_flBlendSoftnessDistanceModifierStrength) * _18843.y);
	    float _6913 = _8284 + _19817;
	    float _11241;
	    SPIRV_CROSS_BRANCH
	    if (_14876)
	    {
	        _11241 = max(0.0, ((_19324.x + 0.5) - _Globals_.g_flHeightMapZeroPoint2) * _Globals_.g_flHeightMapScale2);
	    }
	    else
	    {
	        _11241 = _19324.x;
	    }
	    float _17768 = _Globals_.g_flHeightMapZeroPoint2 + (_19817 * 0.5);
	    float _6380 = _Globals_.g_flHeightMapScale2 + _6913;
	    float _12197 = _6380 - (_6913 * 2.0);
	    float _11621;
	    SPIRV_CROSS_BRANCH
	    if (_Globals_.bBlendByFacingDirection2 != 0)
	    {
	        _11621 = _10136 * saturate((((dot(_Globals_.g_vFacingDirection2.xyz, mix(_24347.xyz, _24174, vec3(_Globals_.g_vFacingDirectionMaskNormalMapStrength2)).xyz) - 1.0) + (_Globals_.g_flFacingDirectionMaskSpread2 * 2.0)) / (_Globals_.g_vFacingDirectionMaskSoftness2 * 2.0)) + 0.5);
	    }
	    else
	    {
	        _11621 = _10136;
	    }
	    float _6994 = ((_19324.x - _17768) * ((_12197 == 0.0) ? 9.9999997473787516355514526367188e-05 : _12197)) + mix((((-_17767) * _6379) - ((1.0 - _17768) * _6380)) - _6913, ((1.0 - _17767) * _6379) - ((-_17768) * _6380), _11621);
	    vec3 _16290;
	    _16290.x = _20609;
	    _16290.y = _6994;
	    vec2 _9007 = max((_16290.xy - vec2(max(_20609, _6994))) + vec2(_6913), vec2(0.0));
	    float _6253 = saturate(((_9007 / vec2((_9007.x + 9.9999997473787516355514526367188e-05) + _9007.y)).y * mix(0.5, _19324.x, _Globals_.g_flMaskWithHeight2)) * 2.0);
	    bool _19615 = _6253 > 0.0500000007450580596923828125;
	    float _13141;
	    vec4 _16306;
	    float _16863;
	    vec3 _17119;
	    float _17120;
	    float _17152;
	    SPIRV_CROSS_BRANCH
	    if (_19615)
	    {
	        float _13140;
	        vec3 _13190;
	        vec4 _22996;
	        if (_23686)
	        {
	            vec2 _19981 = _17114 * _Globals_.g_vTexCoordScale2.xy;
	            vec2 _21754 = _17116 * _Globals_.g_vTexCoordScale2.xy;
	            vec2 _22336 = _17117 * _Globals_.g_vTexCoordScale2.xy;
	            vec2 _22337 = _17115 * _Globals_.g_vTexCoordScale2.xy;
	            vec2 _22994 = _17118 * _Globals_.g_vTexCoordScale2.xy;
	            vec2 _18440 = _13694 * _Globals_.g_vTexCoordScale2.xy;
	            bool _23211 = !_21711;
	            vec4 _7425;
	            if (_23211)
	            {
	                _7425 = textureGrad(sampler2D(g_bindless_Texture2D_float4[_Globals_.g_tColor2], g_bindless_Sampler[_Globals_.g_sUserConfig]), _19981.xy, _21754.xy, _22336.xy) * _6616.x;
	            }
	            else
	            {
	                _7425 = vec4(0.0);
	            }
	            bool _24030 = !_21712;
	            vec3 _10024;
	            float _24485;
	            if (_24030)
	            {
	                vec4 _11182 = textureGrad(sampler2D(g_bindless_Texture2D_float4[_Globals_.g_tNormal2], g_bindless_Sampler[_Globals_.g_sUserConfig]), _19981.xy, _21754.xy, _22336.xy);
	                float _15457 = _11182.x;
	                float _24535 = _11182.y;
	                float _16787 = (_15457 + _24535) - 1.00392162799835205078125;
	                float _11183 = _15457 - _24535;
	                vec3 _21633 = normalize(vec3(vec2(_16787, _11183), (1.0 - abs(_16787)) - abs(_11183))).xyz * _6616.x;
	                _10024 = (_1834[_13136.x] * _21633.x) + (_647[_13136.y] * _21633.y);
	                _24485 = _11182.z * _6616.x;
	            }
	            else
	            {
	                _10024 = _24347;
	                _24485 = 0.0;
	            }
	            float _13139;
	            vec3 _13754;
	            vec4 _14102;
	            if (_6616.y > 0.0)
	            {
	                vec4 _12893;
	                if (_23211)
	                {
	                    _12893 = _7425 + (textureGrad(sampler2D(g_bindless_Texture2D_float4[_Globals_.g_tColor2], g_bindless_Sampler[_Globals_.g_sUserConfig]), _22337.xy, _22994.xy, _18440.xy) * _6616.y);
	                }
	                else
	                {
	                    _12893 = _7425;
	                }
	                float _13213;
	                vec3 _15671;
	                if (_24030)
	                {
	                    vec4 _12169 = textureGrad(sampler2D(g_bindless_Texture2D_float4[_Globals_.g_tNormal2], g_bindless_Sampler[_Globals_.g_sUserConfig]), _22337.xy, _22994.xy, _18440.xy);
	                    float _13492 = _12169.x;
	                    float _21309 = _12169.y;
	                    float _16788 = (_13492 + _21309) - 1.00392162799835205078125;
	                    float _11184 = _13492 - _21309;
	                    vec3 _21634 = normalize(vec3(vec2(_16788, _11184), (1.0 - abs(_16788)) - abs(_11184))).xyz * _6616.y;
	                    _13213 = _24485 + (_12169.z * _6616.y);
	                    _15671 = _10024 + ((_1834[_16305.x] * _21634.x) + (_647[_16305.y] * _21634.y));
	                }
	                else
	                {
	                    _13213 = _24485;
	                    _15671 = _10024;
	                }
	                _13139 = _13213;
	                _14102 = _12893;
	                _13754 = _15671;
	            }
	            else
	            {
	                _13139 = _24485;
	                _14102 = _7425;
	                _13754 = _10024;
	            }
	            _13140 = _13139;
	            _13190 = normalize(_13754 + _24347);
	            _22996 = _14102;
	        }
	        else
	        {
	            vec4 _7424;
	            if (!_21711)
	            {
	                _7424 = textureGrad(sampler2D(g_bindless_Texture2D_float4[_Globals_.g_tColor2], g_bindless_Sampler[_Globals_.g_sUserConfig]), _24879.xy, _9717.xy, _9717.zw).xyzw;
	            }
	            else
	            {
	                _7424 = vec4(0.0);
	            }
	            float _13212;
	            vec3 _15670;
	            if (!_21712)
	            {
	                vec4 _11180 = textureGrad(sampler2D(g_bindless_Texture2D_float4[_Globals_.g_tNormal2], g_bindless_Sampler[_Globals_.g_sUserConfig]), _24879.xy, _9717.xy, _9717.zw);
	                float _6494 = _11180.x;
	                float _14882 = _11180.y;
	                float _16786 = (_6494 + _14882) - 1.00392162799835205078125;
	                float _11181 = _6494 - _14882;
	                vec3 _15163 = normalize(vec3(vec2(_16786, _11181), (1.0 - abs(_16786)) - abs(_11181)));
	                vec2 _20891 = _15163.xy;
	                float _7797 = dot(_20891, _Globals_.g_vNormalXform_2.xy);
	                float _19702 = dot(_20891, _Globals_.g_vNormalXform_2.zw);
	                vec3 _19583 = _15163;
	                _19583.x = _7797;
	                _19583.y = _19702;
	                bvec3 _20663 = bvec3(_17560);
	                vec3 _10845 = abs(_19583.xyz);
	                vec2 _16476 = (-vec2(_7797, (-1.0) * _19702)) / vec2(max(_10845.z, 0.0078125 * max(_10845.x, _10845.y)));
	                _13212 = _11180.z;
	                _15670 = normalize(_8889 - ((mix(_9521, _10020, _20663) * _16476.x) + (mix(_15323, _22186, _20663) * _16476.y)));
	            }
	            else
	            {
	                _13212 = 0.0;
	                _15670 = vec3(0.0);
	            }
	            _13140 = _13212;
	            _13190 = _15670;
	            _22996 = _7424;
	        }
	        vec3 _9718;
	        float _24880;
	        if (!_21712)
	        {
	            _9718 = normalize(mix(_24347, _13190, vec3(_Globals_.g_fTextureNormalContrast2)));
	            _24880 = saturate(((_Globals_.g_fTextureRoughnessContrast2 * (_13140 - 0.5)) + 0.5) * _Globals_.g_fTextureRoughnessBrightness2);
	        }
	        else
	        {
	            _9718 = _13190;
	            _24880 = _13140;
	        }
	        vec4 _21847 = vec4(_22996.xyz, 1.0);
	        float _24804 = saturate(((_Globals_.g_fTintMaskContrast2 * (_19324.y - 0.5)) + 0.5) * _Globals_.g_fTintMaskBrightness2);
	        vec3 _25192 = mix(mix(_22996, vec4((_21847 * _Globals_.g_mTextureAdjust2).xyz, _22996.w), bvec4(_Globals_.g_bAdjustBaseColor2 != 0)).xyz, vec4((_21847 * _Globals_.g_mTextureColorAdjust2).xyz, _4).xyz, vec3(_24804));
	        vec4 _17843;
	        _17843.x = _25192.x;
	        _17843.y = _25192.y;
	        _17843.z = _25192.z;
	        float _16721 = dot(_17843.xyz, vec3(0.2125000059604644775390625, 0.7153999805450439453125, 0.07209999859333038330078125));
	        _13141 = _24804;
	        _16306 = vec4(saturate(mix(_17843.xyz, (_9577 * min(_16721 / _21159, (3.0 * _16721) * _24175)).xyz, vec3((input_1.w * _24804) * float(_Globals_.g_bModelTint2 != 0)))).xyz, _7);
	        _17119 = _9718;
	        _17120 = saturate(mix(_Globals_.g_vAmbientOcclusionLevels2.x, _Globals_.g_vAmbientOcclusionLevels2.z, pow(_22996.w, _Globals_.g_vAmbientOcclusionLevels2.y)));
	        _17152 = _19324.w * float(_Globals_.g_bMetalness2 != 0);
	        _16863 = _24880;
	    }
	    else
	    {
	        _13141 = _19324.y;
	        _16306 = vec4(0.0);
	        _17119 = vec3(0.0);
	        _17120 = 0.0;
	        _17152 = _19324.w;
	        _16863 = 0.0;
	    }
	    float _13142;
	    vec3 _13381;
	    vec2 _14948;
	    float _16307;
	    float _17121;
	    vec3 _17124;
	    float _17125;
	    SPIRV_CROSS_BRANCH
	    if (_19615)
	    {
	        vec3 _10593;
	        float _11673;
	        if (!_21711)
	        {
	            vec3 _18442 = _16306.xyz * 12.9200000762939453125;
	            vec3 _7485 = (pow(_16306.xyz, vec3(0.4166666567325592041015625)) * 1.05499994754791259765625) - vec3(0.054999999701976776123046875);
	            float _21354;
	            if (_16306.x <= 0.003130800090730190277099609375)
	            {
	                _21354 = _18442.x;
	            }
	            else
	            {
	                _21354 = _7485.x;
	            }
	            float _21355;
	            if (_16306.y <= 0.003130800090730190277099609375)
	            {
	                _21355 = _18442.y;
	            }
	            else
	            {
	                _21355 = _7485.y;
	            }
	            float _20653;
	            if (_16306.z <= 0.003130800090730190277099609375)
	            {
	                _20653 = _18442.z;
	            }
	            else
	            {
	                _20653 = _7485.z;
	            }
	            _11673 = mix(_10048 * mix(1.0, _17120, _6253 * _Globals_.g_flAOCombine2), _17120, _6253 * _Globals_.g_flAOReplace2);
	            _10593 = mix(_23405 * mix(vec3(1.0), vec3(_21354, _21355, _20653) * 2.0, vec3(_6253 * _Globals_.g_flColorOverlay2)), _16306.xyz, vec3(_6253 * _Globals_.g_flColorReplace2));
	        }
	        else
	        {
	            _11673 = _10048;
	            _10593 = _23405;
	        }
	        vec3 _11008;
	        vec2 _14482;
	        if (!_21712)
	        {
	            vec2 _12792;
	            _12792.x = mix(_7812 * (1.0 + ((((_16863 - _7812) * 2.0) * _6253) * _Globals_.g_flRoughnessCombine2)), _16863, _6253 * _Globals_.g_flRoughnessReplace2);
	            _11008 = mix(mix(_24174, normalize(mix(_24347, (_24174 + _17119.xyz) * vec3(0.5), vec3(2.0))), vec3(_6253 * _Globals_.g_flNormalCombine2)), _17119.xyz, vec3((_6253 * saturate((_6994 + _17768) - _20609)) * _Globals_.g_flNormalReplace2));
	            _14482 = _12792;
	        }
	        else
	        {
	            _11008 = _24174;
	            _14482 = _22927;
	        }
	        _13142 = mix(_9068 * mix(1.0, _17152 * 2.0, _6253 * _Globals_.g_flMetalnessCombine2), _17152, _6253 * _Globals_.g_flMetalnessReplace2);
	        _16307 = mix(_7406, float(_Globals_.g_bSnowLayer2 != 0), _6253);
	        _17121 = _11673;
	        _17124 = _11008;
	        _17125 = mix(_11237, _11241, _6253);
	        _14948 = _14482;
	        _13381 = _10593;
	    }
	    else
	    {
	        _13142 = _9068;
	        _16307 = _7406;
	        _17121 = _10048;
	        _17124 = _24174;
	        _17125 = _11237;
	        _14948 = _22927;
	        _13381 = _23405;
	    }
	    float _13984 = saturate(1.0 - _6253);
	    vec3 _14081 = _13381 * mix(vec3(1.0), input_5.xyz, vec3(saturate(saturate(((float(_Globals_.g_bMaskVertexColor1 == 0) * _13984) + (float(_Globals_.g_bMaskVertexColor2 == 0) * _6253)) + ((_24803 * _13984) + (_13141 * _6253))) * ((float(_Globals_.g_bVertexColorEnabled1 != 0) * _13984) + (float(_Globals_.g_bVertexColorEnabled2 != 0) * _6253)))));
	    vec2 _23398 = vec2(_14948.x);
	    bool _12896;
	    if (_Globals_.g_bWetness != 0)
	    {
	        _12896 = (_Globals_.g_fPuddleStrength + _Globals_.g_fWetnessStrength) > 0.0;
	    }
	    else
	    {
	        _12896 = false;
	    }
	    bool _12897;
	    if (_12896)
	    {
	        _12897 = input_0.z > 0.0;
	    }
	    else
	    {
	        _12897 = false;
	    }
	    float _12727;
	    vec3 _13145;
	    vec2 _16308;
	    float _17127;
	    vec3 _17128;
	    float _17129;
	    vec3 _18774;
	    SPIRV_CROSS_BRANCH
	    if (_12897)
	    {
	        vec4 _19372 = texture(sampler2D(g_bindless_Texture2D_float4[PerViewConstantBufferCsgo_t._m7], g_bindless_Sampler[_Globals_.g_sUserConfig]), (_10061.xy * 0.006000000052154064178466796875).xy);
	        float _21302 = _24347.z;
	        float _14498 = pow(max(0.0, _21302), 32.0);
	        float _23204 = min(min(input_0.z, saturate(PerViewConstantBufferCsgo_t._m11)), 1.0 - (saturate(PerViewConstantBufferCsgo_t._m12 - 0.5) * 2.0));
	        float _20426 = saturate(_23204 - 0.75);
	        float _8286 = _23204 + (4.0 * (_20426 * _20426));
	        float _16777 = _8286 - _Globals_.g_fWetEdgeSpread;
	        float _11964 = saturate(_8286 * 20.0);
	        vec4 _9719;
	        float _24883;
	        SPIRV_CROSS_BRANCH
	        if (_Globals_.g_bPuddlesOnVerticalSurfaces != 0)
	        {
	            vec4 _9186 = vec4(0.0, 0.0, 1.0, 0.0);
	            _9186.x = _24347.x;
	            _9186.y = _24347.y;
	            _9186.z = _21302;
	            _9719 = _9186;
	            _24883 = max(0.0, _16777);
	        }
	        else
	        {
	            _9719 = vec4(0.0, 0.0, 1.0, 0.0);
	            _24883 = max(0.0, (_8286 * _14498) - _Globals_.g_fWetEdgeSpread);
	        }
	        float _16799 = max(0.001000000047497451305389404296875, _Globals_.g_fPuddleBlendSoftness);
	        float _14611 = smoothstep(_24883 + _16799, _24883 - (input_0.w + (_16799 * 2.0)), _17125) * _11964;
	        float _19808 = max((smoothstep(_23204, _16777 - (0.20000000298023223876953125 * _8286), _17125) * _Globals_.g_fWetEdgeStrength) * _11964, _14611) * _Globals_.g_fPuddleStrength;
	        float _17924 = (_23204 - 1.0) - _17125;
	        float _10334 = (saturate(_17924 + _Globals_.g_fPuddleSedimentHeight) * _Globals_.g_fPuddleSedimentOpacity) * _14611;
	        float _13706 = saturate(((saturate((((_8286 * 2.0) - (mix(0.5, _19372.w, saturate(_14498 * 20.0)) * 0.5)) - (_17125 * 0.5)) + 0.25) * _Globals_.g_fWetnessStrength) * _11964) + _14611);
	        float _13144;
	        float _13151;
	        vec4 _23607;
	        SPIRV_CROSS_BRANCH
	        if (_13706 > 0.5)
	        {
	            float _12497 = _Globals_.g_fRippleStrength * PerViewConstantBufferCsgo_t._m9;
	            vec3 _6617;
	            vec4 _12898;
	            float _13143;
	            SPIRV_CROSS_BRANCH
	            if (_12497 > 0.0)
	            {
	                vec3 _18756 = normalize(vec3(-1.0, 0.20000000298023223876953125, 0.0));
	                float _9927 = PerViewConstantBufferCsgo_t._m10 * 6.283185482025146484375;
	                float _22373 = sin(_9927);
	                float _20617 = cos(_9927);
	                vec2 _23932 = _18756.xy * mat2(vec2(_20617, -_22373), vec2(_22373, _20617));
	                vec3 _22900 = _18756;
	                _22900.x = _23932.x;
	                _22900.y = _23932.y;
	                vec3 _21326 = -cross(_22900, _24347);
	                vec3 _13887 = _10061.xyz;
	                float _9965 = dot(_13887, _21326);
	                float _12056 = 1.0 - input_0.z;
	                vec2 _20274 = ((vec2(dot(_13887, _22900)) + (vec2(0.100000001490116119384765625, -0.100000001490116119384765625) * _9965)) + (vec2(8.0, 5.0) * _10061.z)) + vec2((_12056 * _12056) * (-80.0));
	                vec2 _15991 = vec2(_20274.x, _9965) * vec2(0.0199999995529651641845703125, 0.010999999940395355224609375);
	                vec4 _20877 = texture(sampler2D(g_bindless_Texture2D_float4[PerViewConstantBufferCsgo_t._m7], g_bindless_Sampler[_Globals_.g_sUserConfig]), (_15991 + (vec2(0.20000000298023223876953125, 0.0) * PerViewConstantBuffer_t._m0)).xy);
	                vec2 _18922 = (_20877.xy * 2.0) - vec2(1.0);
	                float _22216 = saturate(length(fwidth(_15991)) * 10.0);
	                vec2 _15297 = ((_18922 * vec2(0.100000001490116119384765625, 0.0500000007450580596923828125)) * input_0.z) * mix(1.0, 0.300000011920928955078125, _22216);
	                vec2 _13712 = _21326.xy;
	                vec4 _19601 = vec4(0.0);
	                _19601.x = dot(_22900.xy, _15297);
	                _19601.y = dot(_13712, _15297);
	                vec2 _16046 = (vec2(_20274.y, _9965) * vec2(0.03599999845027923583984375, 0.01620000042021274566650390625)) + (_18922 * 0.0500000007450580596923828125);
	                vec4 _20878 = texture(sampler2D(g_bindless_Texture2D_float4[PerViewConstantBufferCsgo_t._m7], g_bindless_Sampler[_Globals_.g_sUserConfig]), (_16046 + (vec2(0.1500000059604644775390625, 0.0) * PerViewConstantBuffer_t._m0)).xy);
	                vec2 _17104 = (((_20878.xy * 2.0) - vec2(1.0)) * 0.05200000107288360595703125) * input_0.z;
	                _17104.y = _17104.y * 0.5;
	                float _9251 = saturate(length(fwidth(_16046)) * 10.0);
	                vec2 _13561 = _17104 * mix(1.0, 0.300000011920928955078125, _9251);
	                vec2 _13330 = _19601.xy + vec2(dot(_22900.xy, _13561), dot(_13712, _13561));
	                vec4 _20490 = _19601;
	                _20490.x = _13330.x;
	                _20490.y = _13330.y;
	                _20490.w = input_0.z * (_20877.z + _20878.z);
	                vec3 _20491;
	                _20491.x = _10061.x;
	                _20491.y = _10061.y;
	                _13143 = _12497 * (0.039999999105930328369140625 * (_22216 + _9251));
	                _12898 = _9719 + ((_20490 * _14498) * _12497);
	                _6617 = _20491;
	            }
	            else
	            {
	                _13143 = 0.0;
	                _12898 = _9719;
	                _6617 = _10061;
	            }
	            float _8914 = (_Globals_.g_fRainStrength * PerViewConstantBufferCsgo_t._m8) * PerViewConstantBufferCsgo_t._m8;
	            float _9982;
	            vec4 _21594;
	            SPIRV_CROSS_BRANCH
	            if (_8914 > 0.0)
	            {
	                vec2 _10473 = _6617.xy * 0.119999997317790985107421875;
	                vec3 _20506 = vec3(PerViewConstantBuffer_t._m0 * 6.5) + vec3(0.0, 0.3167000114917755126953125, 0.633400022983551025390625);
	                vec3 _13155;
	                _13155 = vec3(0.0);
	                int _18441;
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
	                    _25251 = vec3(_13155.xy + (((-(((((_7848 / vec2(_8329)) * cos(mix(1.0, (_20173 * 40.0) + (PerViewConstantBuffer_t._m0 * 65.0), _14611))) * _20173) * _20173) * mix(2.0, 0.25, saturate(fwidth(_20173) * 20.0)))) * ((saturate((sin(((_20173 * mix(1.0, 4.0, _14611)) + _18429) * _8914) - (1.0 - ((0.20000000298023223876953125 * _18120) * mix(0.25, 1.0, _14611)))) * 2.0) * _20173) / _18120)) * mix(16.0, 2.0, _14611)), _13155.z + (((saturate((sin((((_20213 + _18429) + 4.0) + (sin(_17125 * 60.0) * 0.25)) * _8914) - (1.0 - (_18120 * 0.02000000141561031341552734375))) * 2.0) * _20213) / _18120) * 28.0));
	                    _18441 = _16208 + 1;
	                    _13155 = _25251;
	                    _16208 = _18441;
	                    continue;
	                }
	                vec3 _9348 = _13155 * _14498;
	                vec2 _15752 = _12898.xy + _9348.xy;
	                vec4 _20492 = _12898;
	                _20492.x = _15752.x;
	                _20492.y = _15752.y;
	                _9982 = _9348.z;
	                _21594 = _20492;
	            }
	            else
	            {
	                _9982 = 0.0;
	                _21594 = _12898;
	            }
	            vec3 _10508 = normalize(_21594.xyz);
	            vec4 _16886 = _21594;
	            _16886.x = _10508.x;
	            _16886.y = _10508.y;
	            _16886.z = _10508.z;
	            _13144 = _9982;
	            _13151 = _13143;
	            _23607 = _16886;
	        }
	        else
	        {
	            _13144 = 0.0;
	            _13151 = 0.0;
	            _23607 = _9719;
	        }
	        float _10839 = _14611 * _Globals_.g_fPuddleStrength;
	        vec3 _23311 = vec3(_19808 * _10334);
	        vec3 _13713 = normalize(mix(_17124.xyz, _23607.xyz, vec3(saturate(_10839 * 4.0))));
	        float _9038 = max(_13706 * (1.0 - saturate(PerViewConstantBufferCsgo_t._m12 * 2.0)), _19808);
	        vec3 _18806 = mix(_14081, pow(_14081, vec3(1.2999999523162841796875)) * 0.800000011920928955078125, saturate((pow(_14081, vec3(0.25)) * (_9038 * _14948.x)) * 8.0) * mix(_Globals_.g_flWetnessDarkeningStrength1, _Globals_.g_flWetnessDarkeningStrength2, _6253 * _Globals_.g_flColorReplace2));
	        _13145 = fma(mix((mix(_18806, _18806 * 0.5, vec3(saturate(_14611 * 1.5))) * mix(1.0, _17121, _19808)) * mix(1.0, 1.0 - _17924, _10334), _Globals_.g_vPuddleSedimentColor, _23311), vec3(1.0 + _13144), vec3(_13144 * 0.100000001490116119384765625));
	        _16308 = saturate(mix(_23398.xx, vec2(_Globals_.g_fPuddleRoughness), vec2(_9038)) + vec2(_13151 + (length(fwidth(_13713.xyz)) * 0.5)));
	        _17127 = mix(_Globals_.g_flReflectance, 0.0350000001490116119384765625, _9038);
	        _17128 = _13713;
	        _17129 = _10839 * (0.20000000298023223876953125 + (((0.1500000059604644775390625 * _23607.w) * _23607.w) * _23607.w));
	        _12727 = mix(_17121, 1.0, _19808);
	        _18774 = mix(_17124, _23607.xyz, _23311);
	    }
	    else
	    {
	        _13145 = _14081;
	        _16308 = _23398;
	        _17127 = _Globals_.g_flReflectance;
	        _17128 = vec3(1.0);
	        _17129 = 0.0;
	        _12727 = _17121;
	        _18774 = _17124;
	    }
	    vec3 _9451 = mix(vec3(_17127).xyz, _13145.xyz, vec3(_13142));
	    vec3 _17892 = mix(_17128, _18774, bvec3(all(equal(_17128, vec3(1.0)))));
	    vec3 _10562 = _24347.xyz;
	    vec3 _11099 = dFdx(_10562);
	    vec3 _9175 = dFdy(_10562);
	    vec3 _10347 = _11099.xyz;
	    vec3 _12420 = _9175.xyz;
	    vec2 _21819 = max(_16308.xy, vec2(pow(saturate(max(dot(_10347, _10347), dot(_12420, _12420))), 0.333000004291534423828125)));
	    vec3 _15598 = -_24347;
	    vec4 _23875 = vec4(_18774.xyz, 1.0);
	    bvec4 _24464 = notEqual(PerViewConstantBufferCsgo_t._m0, ivec4(0));
	    float _21714;
	    if (_24464.x)
	    {
	        vec3 _11394 = _24347.xyz;
	        vec2 _11087 = ((floor(_11408.xy * PerViewConstantBufferCsgo_t._m15) * PerViewConstantBufferCsgo_t._m14.xy) + (PerViewConstantBufferCsgo_t._m14.xy * 0.5)).xy;
	        vec4 _18418 = textureGather(sampler2D(g_bindless_Texture2D_float4[PerViewConstantBufferCsgo_t._m4], g_bindless_Sampler[_Globals_.g_sCookieSampler]), _11087).xyzw - _11408.zzzz;
	        float _18579 = _18418.w;
	        float _12022 = _18418.z;
	        bool _12285 = abs(_12022) < _18579;
	        vec2 _23168;
	        if (_12285)
	        {
	            _23168 = vec2(PerViewConstantBufferCsgo_t._m14.x, 0.0);
	        }
	        else
	        {
	            _23168 = vec2(0.0);
	        }
	        float _20965 = _12285 ? _12022 : _18579;
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
	        _21714 = (1.0 / (dot(_13232, vec4(1.0)) + PerViewLightingConstantBufferGpu_t._m3.x)) * (PerViewLightingConstantBufferGpu_t._m3.x + dot(_13232, textureLod(sampler2D(g_bindless_Texture2D_float4[PerViewConstantBufferCsgo_t._m3], g_bindless_Sampler[_Globals_.g_sPointClamp]), (_11087 + mix(_23169, PerViewConstantBufferCsgo_t._m14.xy, bvec2(abs(_18418.y) < (_12287 ? _15372 : _20965))).xy).xy, 0.0)));
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
	        float _13146;
	        vec3 _14975;
	        int _13039 = 0;
	        for (;;)
	        {
	            if (!(_13039 < PerViewLightingConstantBufferGpu_t._m11))
	            {
	                _13146 = 1.0;
	                _14975 = vec3(0.0);
	                _10191 = -1;
	                break;
	            }
	            vec4 _18322 = vec4(input_2.xyz, 1.0) * PerViewLightingConstantBufferGpu_t._m18._m0[_13039];
	            float _12779 = _18322.x;
	            if (max(abs(_12779), abs(_18322.y)) < PerViewLightingConstantBufferGpu_t._m13[_13039])
	            {
	                vec3 _19470 = vec3(_12779, _18322.yz);
	                vec2 _24805 = _19470.xy;
	                vec2 _22193 = vec2(1.0) - saturate((abs(_24805) * vec2(PerViewLightingConstantBufferGpu_t._m15)) + vec2(PerViewLightingConstantBufferGpu_t._m14));
	                vec2 _20561 = (_24805 * PerViewLightingConstantBufferGpu_t._m19._m0[_13039].zw) + PerViewLightingConstantBufferGpu_t._m19._m0[_13039].xy;
	                vec3 _20493 = _19470;
	                _20493.x = _20561.x;
	                _20493.y = _20561.y;
	                _13146 = saturate(_22193.x * _22193.y);
	                _14975 = _20493;
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
	            if (_13146 < 1.0)
	            {
	                float _7934;
	                if (_10191 < (PerViewLightingConstantBufferGpu_t._m11 - 1))
	                {
	                    int _15335 = _10191 + 1;
	                    vec4 _19671 = vec4(input_2.xyz, 1.0) * PerViewLightingConstantBufferGpu_t._m18._m0[_15335];
	                    vec2 _20562 = (_19671.xy * PerViewLightingConstantBufferGpu_t._m19._m0[_15335].zw) + PerViewLightingConstantBufferGpu_t._m19._m0[_15335].xy;
	                    vec3 _20494;
	                    _20494.x = _20562.x;
	                    _20494.y = _20562.y;
	                    _7934 = textureLod(sampler2DShadow(g_bindless_Texture2D_float4[PerViewLightingConstantBufferGpu_t._m20], g_bindless_Sampler_1[_Globals_.g_tShadowDepthBufferCmpSampler]), vec3(_20494.xy, saturate(_19671.z + PerViewLightingConstantBufferGpu_t._m12)), 0.0);
	                }
	                else
	                {
	                    _7934 = 1.0;
	                }
	                _12501 = mix(_7934, _18270, _13146);
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
	        float _13279 = mix(_18423, 1.0, saturate((distance(_10061.xyz, PerViewConstantBuffer_t._m4) * PerViewLightingConstantBufferGpu_t._m17) + PerViewLightingConstantBufferGpu_t._m16));
	        float _12502;
	        if (_24464.y)
	        {
	            _12502 = min(_13279, textureLod(sampler2D(g_bindless_Texture2D_float4[PerViewConstantBufferCsgo_t._m5], g_bindless_Sampler[_Globals_.g_sTrilinearClamp]), (_11408.xy * PerViewConstantBuffer_t._m3.xy).xy, 0.0).z);
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
	    vec3 _9720;
	    vec3 _24884;
	    SPIRV_CROSS_BRANCH
	    if ((dot(PerViewLightingConstantBufferGpu_t._m9.xyz, _18774.xyz) * _21715) > 0.0)
	    {
	        vec3 _15460 = mix(_17892, _18774.xyz, bvec3(all(equal(_17892, vec3(1.0)))));
	        float _13811 = max(0.0, dot(_18774.xyz, PerViewLightingConstantBufferGpu_t._m9.xyz));
	        vec3 _17874 = vec3(_13811);
	        vec3 _18223;
	        if (_17129 > 0.0)
	        {
	            float _8780 = dot(_15460, PerViewLightingConstantBufferGpu_t._m9.xyz);
	            float _8124 = saturate(_17129);
	            _18223 = mix(_17874.xyz, vec3((((0.5 + (_13811 * 0.5)) + pow(1.0 - saturate(_8780), 4.0)) * saturate((_8780 + 0.20000000298023223876953125) * 4.0)) * saturate(mix(dot(mix(_18774.xyz, _15460, vec3(10.0)), PerViewLightingConstantBufferGpu_t._m9.xyz), 1.0, _8124))), vec3(_8124));
	        }
	        else
	        {
	            _18223 = _17874;
	        }
	        vec2 _17301 = max(_21819, vec2(PerViewLightingConstantBufferGpu_t._m9.w));
	        vec3 _12281 = normalize(PerViewLightingConstantBufferGpu_t._m9.xyz + (-normalize(_10061.xyz - PerViewConstantBuffer_t._m4.xyz)).xyz).xyz;
	        float _12386 = dot(_12281, _15460.xyz);
	        float _19210 = max(0.0, dot(PerViewLightingConstantBufferGpu_t._m9.xyz, _12281));
	        float _9850 = _17301.x;
	        float _25211 = _9850 * _9850;
	        float _19095 = _25211 * _25211;
	        float _15346 = ((_12386 * _12386) * (_19095 - 1.0)) + 1.0;
	        vec3 _16808 = (PerViewLightingConstantBufferGpu_t._m10.xyz * _21715).xyz;
	        _9720 = ((_9451.xyz * (_19095 / (((_15346 * _15346) * (_19210 * _19210)) * ((_9850 * 4.0) + 2.0)))).xyz * _13811).xyz * _16808;
	        _24884 = PerViewLightingConstantBufferGpu_t._m4.xyz + (_18223.xyz * _16808);
	    }
	    else
	    {
	        _9720 = vec3(0.0);
	        _24884 = PerViewLightingConstantBufferGpu_t._m4.xyz;
	    }
	    bvec4 _24465 = notEqual(PerViewConstantBufferCsgo_t._m1, ivec4(0));
	    bool _20059 = _24465.x;
	    vec4 _19363;
	    if (_20059)
	    {
	        vec4 _18621 = vec4(_10061.xyz, 1.0).xyzw * PerViewConstantBufferCsgo_t._m13;
	        float _20176 = _18621.w;
	        vec2 _11414 = _18621.xy / vec2(_20176);
	        vec4 _6651;
	        _6651.x = clamp(((_11414.x + 1.0) * PerViewConstantBuffer_t._m2.x) * 0.5, 0.0, PerViewConstantBuffer_t._m2.x - 1.0);
	        _6651.y = clamp(((1.0 - _11414.y) * PerViewConstantBuffer_t._m2.y) * 0.5, 0.0, PerViewConstantBuffer_t._m2.y - 1.0);
	        _6651.w = _20176;
	        _19363 = _6651;
	    }
	    else
	    {
	        _19363 = _11408;
	    }
	    uvec2 _12083 = uvec2(_19363.xy - PerViewConstantBuffer_t._m1.xy) >> uvec2(PerViewLightingConstantBufferGpu_t._m6.x);
	    uint _10838 = PerViewLightingConstantBufferGpu_t._m5.y + (((_12083.y * PerViewLightingConstantBufferGpu_t._m6.y) + _12083.x) * PerViewLightingConstantBufferGpu_t._m5.z);
	    uint _23393 = PerViewLightingConstantBufferGpu_t._m5.x + (uint(clamp(_19363.w * PerViewLightingConstantBufferGpu_t._m7.x, 0.0, PerViewLightingConstantBufferGpu_t._m7.y)) * PerViewLightingConstantBufferGpu_t._m5.z);
	    vec3 _13147;
	    vec3 _16324;
	    _13147 = _9720;
	    _16324 = _24884;
	    uint _21567;
	    vec3 _13148;
	    vec3 _16325;
	    uint _17017 = 0u;
	    for (;;)
	    {
	        if (!(_17017 < PerViewLightingConstantBufferGpu_t._m5.z))
	        {
	            break;
	        }
	        uint _14475 = subgroupOr(g_CullBits_1._m0[_10838 + _17017] & g_CullBits_1._m0[_23393 + _17017]);
	        _13148 = _13147;
	        _16325 = _16324;
	        uint _20344;
	        vec3 _13214;
	        vec3 _15676;
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
	                bool _7426;
	                if (all(greaterThan(_22905.xyz, vec3(-1.0, -1.0, 0.0))))
	                {
	                    _7426 = all(lessThan(_22905.xyz, vec3(1.0)));
	                }
	                else
	                {
	                    _7426 = false;
	                }
	                bool _12899;
	                if (!_7426)
	                {
	                    _12899 = true;
	                }
	                else
	                {
	                    _12899 = !all(lessThanEqual(abs((g_BarnLights_1._m0[_12608]._m15 * vec4(input_2.xyz, 1.0)).xyz), vec3(1.0)));
	                }
	                if (_12899)
	                {
	                    _13214 = _13148;
	                    _15676 = _16325;
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
	                vec3 _11186;
	                float _11633;
	                if (g_BarnLights_1._m0[_12608]._m2.w != 0.0)
	                {
	                    vec3 _10027 = g_BarnLights_1._m0[_12608]._m2.xyz - input_2.xyz;
	                    float _18345 = dot(_10027, _10027);
	                    float _17647 = sqrt(_18345);
	                    vec3 _12302 = _10027 - _16268;
	                    vec3 _10210;
	                    do
	                    {
	                        vec3 _20229 = (_10027 + _16268) - _12302;
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
	                    _11186 = _10027 / vec3(_17647);
	                    _11633 = ((_19667 * (g_BarnLights_1._m0[_12608]._m2.w / max(_18345, g_BarnLights_1._m0[_12608]._m2.w))) * saturate(g_BarnLights_1._m0[_12608]._m3.x + (g_BarnLights_1._m0[_12608]._m3.y * _17647))) * saturate(g_BarnLights_1._m0[_12608]._m6.x + (g_BarnLights_1._m0[_12608]._m6.y * dot(vec3((1.0 - (_23572 * g_BarnLights_1._m0[_12608]._m5.y)) - _18492, _9058 + _19825, (_14805 * g_BarnLights_1._m0[_12608]._m5.z) - (_17330 * g_BarnLights_1._m0[_12608]._m5.y)), normalize(_10210))));
	                }
	                else
	                {
	                    _11186 = g_BarnLights_1._m0[_12608]._m2.xyz;
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
	                            float _11474 = _22154.x;
	                            float _15266 = 2.0 / g_BarnLights_1._m0[_12608]._m9.z;
	                            float _15018 = _22154.y;
	                            float _23041 = (-0.5) * g_BarnLights_1._m0[_12608]._m9.z;
	                            float _11981 = (g_BarnLights_1._m0[_12608]._m9.x * g_BarnLights_1._m0[_12608]._m9.y) * pow(max(pow(g_BarnLights_1._m0[_12608]._m9.y * _11474, _15266) + pow(g_BarnLights_1._m0[_12608]._m9.x * _15018, _15266), 1.1754943508222875079687365372222e-38), _23041);
	                            float _16524 = pow(max(pow(_11474, _15266) + pow(_15018, _15266), 1.1754943508222875079687365372222e-38), _23041);
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
	                        vec4 _19009 = _17795.xyzw * vec4(-1.0, -1.0, -1.0, 1.0);
	                        vec3 _24989 = _19009.xyz;
	                        vec3 _23629 = vec4((-_11186).xyz, 0.0).xyz;
	                        float _15156 = -dot(_23629, _24989);
	                        vec3 _20479 = vec4((_23629 * _19009.w) + cross(_23629, _24989), _15156).xyz;
	                        vec3 _23592 = _17795.xyz;
	                        vec3 _12170 = ((_20479 * g_BarnLights_1._m0[_12608]._m5.w) + (_23592 * _15156)) + cross(_23592, _20479);
	                        vec3 _14082 = vec3(vec2(atan(_12170.y, -_12170.x) * 0.15915493667125701904296875, acos(_12170.z) * 0.3183098733425140380859375), -g_BarnLights_1._m0[_12608]._m4.w);
	                        vec2 _20564 = (_14082.xy * g_BarnLights_1._m0[_12608]._m9.zw) + g_BarnLights_1._m0[_12608]._m9.xy;
	                        vec3 _20497 = _14082;
	                        _20497.x = _20564.x;
	                        _20497.y = _20564.y;
	                        _12503 = _17828.xyz * textureLod(sampler3D(g_bindless_Texture3D_float4[PerViewLightingConstantBufferGpu_t._m21], g_bindless_Sampler[_Globals_.g_sTrilinearWrap]), _20497.xyz, 0.0).xyz;
	                    }
	                    else
	                    {
	                        vec3 _13791 = vec3(fma(_22905.xy, vec2(0.5, -0.5), vec2(0.5)), g_BarnLights_1._m0[_12608]._m4.w);
	                        vec2 _20563 = (_13791.xy * g_BarnLights_1._m0[_12608]._m9.zw) + g_BarnLights_1._m0[_12608]._m9.xy;
	                        vec3 _20496 = _13791;
	                        _20496.x = _20563.x;
	                        _20496.y = _20563.y;
	                        _12503 = _17828.xyz * textureLod(sampler3D(g_bindless_Texture3D_float4[PerViewLightingConstantBufferGpu_t._m21], g_bindless_Sampler[_Globals_.g_sCookieSampler]), _20496.xyz, 0.0).xyz;
	                    }
	                    _21548 = _12503;
	                }
	                if (all(equal(_21548.xyz, vec3(0.0))))
	                {
	                    _13214 = _13148;
	                    _15676 = _16325;
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
	                        _13214 = _13148;
	                        _15676 = _16325;
	                        break;
	                    }
	                    _21549 = _20482;
	                }
	                else
	                {
	                    _21549 = _21548;
	                }
	                vec3 _15461 = mix(_17892, _18774.xyz, bvec3(all(equal(_17892, vec3(1.0)))));
	                float _13812 = max(0.0, dot(_18774.xyz, _11186.xyz));
	                vec3 _17875 = vec3(_13812);
	                vec3 _18225;
	                if (_17129 > 0.0)
	                {
	                    float _8781 = dot(_15461, _11186.xyz);
	                    float _8125 = saturate(_17129);
	                    _18225 = mix(_17875.xyz, vec3((((0.5 + (_13812 * 0.5)) + pow(1.0 - saturate(_8781), 4.0)) * saturate((_8781 + 0.20000000298023223876953125) * 4.0)) * saturate(mix(dot(mix(_18774.xyz, _15461, vec3(10.0)), _11186.xyz), 1.0, _8125))), vec3(_8125));
	                }
	                else
	                {
	                    _18225 = _17875;
	                }
	                vec2 _17302 = max(_21819, vec2(g_BarnLights_1._m0[_12608]._m11));
	                vec3 _12282 = normalize(_11186.xyz + (-normalize(_10061.xyz - PerViewConstantBuffer_t._m4.xyz)).xyz).xyz;
	                float _12387 = dot(_12282, _15461.xyz);
	                float _19211 = max(0.0, dot(_11186.xyz, _12282));
	                float _9851 = _17302.x;
	                float _25212 = _9851 * _9851;
	                float _19097 = _25212 * _25212;
	                float _15348 = ((_12387 * _12387) * (_19097 - 1.0)) + 1.0;
	                _13214 = _13148.xyz + (((_9451.xyz * (_19097 / (((_15348 * _15348) * (_19211 * _19211)) * ((_9851 * 4.0) + 2.0)))).xyz * _13812).xyz * _21549.xyz);
	                _15676 = _16325.xyz + (_18225.xyz * _21549.xyz);
	                break;
	            } while(false);
	            _13148 = _13214;
	            _16325 = _15676;
	            _17018 = _20344;
	            continue;
	        }
	        _21567 = _17017 + 1u;
	        _13147 = _13148;
	        _16324 = _16325;
	        _17017 = _21567;
	        continue;
	    }
	    float _17172 = dot(_21819.xy, vec2(0.5));
	    vec3 _7507 = _17892.xyz;
	    vec3 _17138 = normalize(_10061.xyz - PerViewConstantBuffer_t._m4.xyz);
	    float _17225 = _17172 * _17172;
	    float _20711 = saturate(1.0 - _17225);
	    vec4 _15344 = (vec4(-1.0, -0.0274999998509883880615234375, -0.572000026702880859375, 0.02199999988079071044921875) * _17172) + vec4(1.0, 0.0425000004470348358154296875, 1.03999996185302734375, -0.039999999105930328369140625);
	    float _21215 = _15344.x;
	    vec2 _24572 = (vec2(-1.03999996185302734375, 1.03999996185302734375) * ((min(_21215 * _21215, exp2((-9.27999973297119140625) * max(0.0, dot((-_17138).xyz, _7507)))) * _21215) + _15344.y)) + _15344.zw;
	    float _20339 = _24572.y;
	    vec2 _11427 = vec2(_20339, _24572.x + _20339);
	    vec3 _8745 = vec3(dot(PerViewLightingConstantBufferGpu_t._m0._m0[0].xyzw, _23875), dot(PerViewLightingConstantBufferGpu_t._m0._m0[1].xyzw, _23875), dot(PerViewLightingConstantBufferGpu_t._m0._m0[2].xyzw, _23875)).xyz;
	    vec3 _16991 = _16324.xyz + _8745;
	    vec3 _20418 = vec3(_21714 * max(_12727, 0.0)).xyz;
	    vec3 _20015 = _8745 * _20418;
	    vec3 _20579;
	    if (_16307 > 0.0)
	    {
	        _20579 = mix(_20015, pow(_20015, vec3(1.0499999523162841796875, 0.949999988079071044921875, 0.800000011920928955078125)), vec3(_16307));
	    }
	    else
	    {
	        _20579 = _20015;
	    }
	    vec3 _22686 = (_16324.xyz + _20579.xyz) * (_13145.xyz * (1.0 - _13142)).xyz;
	    float _12932 = _22686.x;
	    vec4 _11204 = vec4(_12932, _22686.yz, input_5.w);
	    _11204.x = _12932;
	    _11204.y = _22686.y;
	    _11204.z = _22686.z;
	    vec3 _15754 = _11204.xyz + (_13147.xyz * _20418).xyz;
	    vec4 _20498 = _11204;
	    _20498.x = _15754.x;
	    _20498.y = _15754.y;
	    _20498.z = _15754.z;
	    vec3 _15734 = _20498.xyz + ((((mix(_11427.xxx, _11427.yyy, _9451) * textureLod(samplerCubeArray(g_bindless_TextureCubeArray_float4[PerViewConstantBufferCsgo_t._m6], g_bindless_Sampler[_Globals_.g_sTrilinearClamp]), vec4(normalize(mix(_7507, reflect(_17138.xyz, _17892.xyz).xyz, vec3(_20711 * (sqrt(_20711) + _17225)))), 0.0), PerViewLightingConstantBufferGpu_t._m8.y * sqrt(_17172)).xyz).xyz * (normalize(_16991 + vec3(0.001000000047497451305389404296875)) * clamp(length(_16991), 0.0, 1.75))).xyz * (vec3(1.0) + (normalize(_8745 + vec3(0.001000000047497451305389404296875)) * 0.5))).xyz * _20418).xyz;
	    vec4 _13889 = _20498;
	    _13889.x = _15734.x;
	    _13889.y = _15734.y;
	    _13889.z = _15734.z;
	    vec4 _6805;
	    if (_Globals_.g_bFogEnabled != 0)
	    {
	        vec3 _21493;
	        vec3 _22956 = _10061.xyz - PerViewConstantBuffer_t._m4.xyz;
	        vec3 _9057 = _22956.xyz;
	        vec3 _19340;
	        do
	        {
	            _21493 = _22956.xyz;
	            bool _12900;
	            if (dot(_21493, _21493) > PerViewConstantBufferCsgo_t._m19.x)
	            {
	                _12900 = (_10061.z * PerViewConstantBufferCsgo_t._m19.z) < PerViewConstantBufferCsgo_t._m19.y;
	            }
	            else
	            {
	                _12900 = false;
	            }
	            SPIRV_CROSS_BRANCH
	            if (_12900)
	            {
	                vec2 _9342 = saturate(PerViewConstantBufferCsgo_t._m16.xy + (PerViewConstantBufferCsgo_t._m16.zw * vec2(length(_21493), _10061.z)));
	                float _12872 = (pow(_9342.x, PerViewConstantBufferCsgo_t._m17.x) * pow(_9342.y, PerViewConstantBufferCsgo_t._m17.y)) * PerViewConstantBufferCsgo_t._m18.w;
	                _19340 = mix(_13889.xyz, vec4(PerViewConstantBufferCsgo_t._m18.xyz, _12872).xyz, vec3(_12872));
	                break;
	            }
	            _19340 = _13889.xyz;
	            break;
	        } while(false);
	        vec4 _23944 = _13889;
	        _23944.x = _19340.x;
	        _23944.y = _19340.y;
	        _23944.z = _19340.z;
	        vec3 _19341;
	        do
	        {
	            bool _12901;
	            if (dot(_9057, _9057) > PerViewConstantBufferCsgo_t._m23.x)
	            {
	                _12901 = (PerViewConstantBufferCsgo_t._m23.z * _10061.z) < PerViewConstantBufferCsgo_t._m23.y;
	            }
	            else
	            {
	                _12901 = false;
	            }
	            if (_12901)
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
	        _6805 = _13889;
	    }
	    output_0 = _6805;
	}
	
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
	
	BoolAttribute(BindlessResources, true);
	BoolAttribute(GroupDefaultCollapseState_TextureTransform, true);
	BoolAttribute(GroupDefaultCollapseState_DetailTextureTransform, true);
	IntAttribute(TexCoord2ScaleByModelU, g_nScaleTexCoord2UByModelScaleAxis-1);
	IntAttribute(TexCoord2ScaleByModelV, g_nScaleTexCoord2VByModelScaleAxis-1);
	BoolAttribute(environmentmapped, true);
	BoolAttribute(environmentmappeddynamic, true);
	BoolAttribute(NeedsLightProbe, true);
	BoolAttribute(DoNotCastShadows, F_DO_NOT_CAST_SHADOWS ? 1 : 0);
	BoolAttribute(SupportsMappingDimensions, true);
	BoolAttribute(renderbackfaces, F_RENDER_BACKFACES ? 1 : 0);
	FloatAttribute(_dummyMakeVisiblePropMaskBias1, g_flDetailPropMaskBias1);
	FloatAttribute(_dummyMakeVisiblePropPuddleReduction1, g_flDetailPropPuddleReduction1);
	FloatAttribute(_dummyMakeVisiblePropMaskBias2, g_flDetailPropMaskBias2);
	FloatAttribute(_dummyMakeVisiblePropMaskSoftness2, g_flDetailPropMaskSoftness2);
	FloatAttribute(_dummyMakeVisiblePropPuddleReduction2, g_flDetailPropPuddleReduction2);
	BoolAttribute(SupportsLightmapping, true);
	BoolAttribute(PerVertexLighting, true);
	BoolAttribute(AllowBackfaceCulling, F_RENDER_BACKFACES ? 0 : 1);
	FloatAttribute(OcclusionCullingBoundsScale, F_OCCLUSION_CULLING_BOUNDS_SCALE ? g_flOcclusionCullingBoundsScale : F_DEPTH_BIAS ? 1.3 : 1);
	StringAttribute(MaterialLayerRefType, csgo_environment);
	TextureAttribute(LightSim_DiffuseAlbedoTexture, g_tColor1);
	TextureAttribute(RepresentativeTexture, g_tColor1);
	
	#if (S_SHARED_COLOR_OVERLAY == 0)
		BoolAttribute(HasTexcoordTransform, (g_nUVSet1>0 && (g_vTexCoordScale1.x!=1 || g_vTexCoordScale1.y!=1 || g_flTexCoordRotation1!=0) || g_nUVSet2>0 && (g_vTexCoordScale2.x!=1 || g_vTexCoordScale2.y!=1 || g_flTexCoordRotation2!=0) || g_nUVSet3>0 && (g_vTexCoordScale3.x!=1 || g_vTexCoordScale3.y!=1 || g_flTexCoordRotation3!=0)) ? 1 : 0);
		FloatAttribute(_dummyMakeVisiblePropMaskBias3, g_flDetailPropMaskBias3);
		FloatAttribute(_dummyMakeVisiblePropMaskSoftness3, g_flDetailPropMaskSoftness3);
		FloatAttribute(_dummyMakeVisiblePropPuddleReduction3, g_flDetailPropPuddleReduction3);
		IntAttribute(MaterialLayerCount, 3);
	#endif
	#if (S_ENABLE_LAYER_3 == 0)
		IntAttribute(MaterialLayerCount, 2);
	#endif
	#if (S_BLEND_EFFECTS_3 == 1)
		FloatAttribute(_dummyMakeVisiblePropMaskBias3, g_flDetailPropMaskBias3);
		FloatAttribute(_dummyMakeVisiblePropMaskSoftness3, g_flDetailPropMaskSoftness3);
		FloatAttribute(_dummyMakeVisiblePropPuddleReduction3, g_flDetailPropPuddleReduction3);
		IntAttribute(MaterialLayerCount, 3);
	#endif
	#if (S_ALPHA_TEST == 1)
		BoolAttribute(alphatest, true);
		BoolAttribute(NoZPrepass, true);
		BoolAttribute(AlphaTestZPrepass, true);
		TextureAttribute(LightSim_Opacity_A, g_tColor1);
	#endif
	#if (S_ALPHA_TEST == 0)
		IntAttribute(DepthPassBatchID, F_RENDER_BACKFACES ? 0 : 1);
		BoolAttribute(NoZPrepass, F_DISABLE_Z_PREPASS ? 1 : 0);
	#endif
	#if (S_BLEND_EFFECTS_3 == 0)
		BoolAttribute(alphatest, true);
		BoolAttribute(NoZPrepass, true);
		BoolAttribute(AlphaTestZPrepass, true);
		TextureAttribute(LightSim_Opacity_A, g_tColor1);
	#endif
	#if (S_ENABLE_LAYER_3 == 1)
		FloatAttribute(_dummyMakeVisiblePropMaskBias3, g_flDetailPropMaskBias3);
		FloatAttribute(_dummyMakeVisiblePropMaskSoftness3, g_flDetailPropMaskSoftness3);
		FloatAttribute(_dummyMakeVisiblePropPuddleReduction3, g_flDetailPropPuddleReduction3);
		IntAttribute(MaterialLayerCount, 3);
	#endif
	#if (S_SHARED_COLOR_OVERLAY == 1)
		BoolAttribute(HasTexcoordTransform, (g_nUVSet1>0 && (g_vTexCoordScale1.x!=1 || g_vTexCoordScale1.y!=1 || g_flTexCoordRotation1!=0) || g_nUVSet2>0 && (g_vTexCoordScale2.x!=1 || g_vTexCoordScale2.y!=1 || g_flTexCoordRotation2!=0) || g_nUVSet3>0 && (g_vTexCoordScale3.x!=1 || g_vTexCoordScale3.y!=1 || g_flTexCoordRotation3!=0) || g_nColorOverlayUVSet>0 && (g_vOverlayTexCoordScale.x!=1 || g_vOverlayTexCoordScale.y!=1 || g_flOverlayTexCoordRotation!=0)) ? 1 : 0);
		FloatAttribute(_dummyMakeVisiblePropMaskBias3, g_flDetailPropMaskBias3);
		FloatAttribute(_dummyMakeVisiblePropMaskSoftness3, g_flDetailPropMaskSoftness3);
		FloatAttribute(_dummyMakeVisiblePropPuddleReduction3, g_flDetailPropPuddleReduction3);
		IntAttribute(MaterialLayerCount, 3);
	#endif
	
	// Variant Attributes
	BoolAttribute(HasTexcoordTransform, (g_nUVSet1>0 && (g_vTexCoordScale1.x!=1 || g_vTexCoordScale1.y!=1 || g_flTexCoordRotation1!=0) || g_nUVSet2>0 && (g_vTexCoordScale2.x!=1 || g_vTexCoordScale2.y!=1 || g_flTexCoordRotation2!=0)) ? 1 : 0);
	BoolAttribute(HasTexcoordTransform, (g_nUVSet1>0 && (g_vTexCoordScale1.x!=1 || g_vTexCoordScale1.y!=1 || g_flTexCoordRotation1!=0) || g_nUVSet2>0 && (g_vTexCoordScale2.x!=1 || g_vTexCoordScale2.y!=1 || g_flTexCoordRotation2!=0) || g_nColorOverlayUVSet>0 && (g_vOverlayTexCoordScale.x!=1 || g_vOverlayTexCoordScale.y!=1 || g_flOverlayTexCoordRotation!=0)) ? 1 : 0);
	
	// PSRS
	
	RenderState(BackStencilFunc, F_RENDER_BACKFACES ? NotEqual : Always);
	RenderState(CullMode, F_RENDER_BACKFACES ? None : Front);
	RenderState(CullMode, F_RENDER_BACKFACES ? None : Back);
	RenderState(DepthBias, F_DEPTH_BIAS ? -64 : 0);
	RenderState(DepthBiasClamp, F_DEPTH_BIAS ? -.0005 : 0);
	RenderState(DepthEnable, F_DISABLE_Z_BUFFERING ? false : true);
	RenderState(DepthFunc, Equal);
	RenderState(DepthWriteEnable, false);
	RenderState(DepthWriteEnable, (F_DISABLE_Z_BUFFERING || F_DEPTH_BIAS) ? false : true);
	RenderState(SlopeScaleDepthBias, F_DEPTH_BIAS ? -2 : 0);
	RenderState(StencilEnable, true);
	RenderState(StencilFunc, NotEqual);
	RenderState(StencilReadMask, 1);
	RenderState(StencilRef, 3);
	RenderState(StencilWriteMask, 254);
	
	#if (S_MODE_DEPTH == 0)
		RenderState(CullMode, F_RENDER_BACKFACES ? None : Front);
		RenderState(CullMode, F_RENDER_BACKFACES ? None : Back);
	#endif
	#if (S_MODE_DEPTH == 1)
		RenderState(CullMode, F_RENDER_BACKFACES ? None : Front);
		RenderState(CullMode, F_RENDER_BACKFACES ? None : Back);
		RenderState(DepthWriteEnable, (F_DISABLE_Z_BUFFERING || F_DEPTH_BIAS) ? false : true);
	#endif
	
	// Variant parameters
	RenderState(DepthWriteEnable, false);
	
	BoolAttribute(BindlessResources, true);
	
}

RTX
{
	StaticCombo( S_DETAIL_NORMAL, F_DETAIL_NORMAL );
	StaticCombo( S_SHARED_COLOR_OVERLAY, F_SHARED_COLOR_OVERLAY );
	StaticCombo( S_ENABLE_LAYER_3, F_ENABLE_LAYER_3 );
	StaticCombo( S_MODE_TOOLS_VIS, 0..1 );
	StaticCombo( S_ALPHA_TEST, F_ALPHA_TEST );
	StaticCombo( S_MODE_DEPTH, 0..1 );
	StaticCombo( S_USE_NEW_BLENDING, F_USE_NEW_BLENDING );
	StaticCombo( S_ENABLE_VISUALIZATIONS, F_ENABLE_VISUALIZATIONS );
	StaticCombo( S_SHADER_QUALITY, 0..1 );
	StaticCombo( S_BLEND_EFFECTS_2, F_BLEND_EFFECTS_2 );
	StaticCombo( S_BLEND_EFFECTS_3, F_BLEND_EFFECTS_3 );
	StaticComboRule( Allow1( S_MODE_TOOLS_VIS, S_MODE_DEPTH ) );
	StaticComboRule( Requires( S_MODE_TOOLS_VIS, S_SHADER_QUALITY ) );
	StaticComboRule( Allow0( S_DETAIL_NORMAL ) );
	StaticComboRule( Allow0( S_MODE_DEPTH ) );
	StaticComboRule( Allow0( S_MODE_TOOLS_VIS, S_SHADER_QUALITY ) );
	StaticComboRule( Requires( S_BLEND_EFFECTS_3, S_ENABLE_LAYER_3 ) );
	DynamicCombo( D_COMPRESSED_NORMALS_AND_TANGENTS, 0..1 );
	DynamicCombo( D_CS_VERTEX_ANIMATION, 0..1 );
	DynamicCombo( D_BAKED_LIGHTING_FROM_VERTEX_STREAM, 0..1 );
	DynamicCombo( D_BAKED_LIGHTING_FROM_LIGHTMAP, 0..1 );
	DynamicCombo( D_BAKED_LIGHTING_FROM_PROBE, 0..1 );
	DynamicComboRule( Allow1( D_BAKED_LIGHTING_FROM_VERTEX_STREAM, D_BAKED_LIGHTING_FROM_LIGHTMAP ) );
	DynamicComboRule( Allow1( D_BAKED_LIGHTING_FROM_PROBE, D_BAKED_LIGHTING_FROM_VERTEX_STREAM, D_BAKED_LIGHTING_FROM_LIGHTMAP ) );
	DynamicComboRule( Allow0( D_BAKED_LIGHTING_FROM_PROBE, D_BAKED_LIGHTING_FROM_VERTEX_STREAM, D_BAKED_LIGHTING_FROM_LIGHTMAP ) );
	DynamicComboRule( Allow0( D_COMPRESSED_NORMALS_AND_TANGENTS, D_CS_VERTEX_ANIMATION ) );
	
	bool bBiplanarUsedAny < UiType(CheckBox); Expression(g_nUVSet1==0 || g_nUVSet2==0); >;
	bool bBiplanarUsedAny < UiType(CheckBox); Expression(g_nUVSet1==0 || g_nUVSet2==0 || g_nUVSet3==0); >;
	bool bBiplanarUsedAny < UiType(CheckBox); Expression(g_nUVSet1==0 || g_nUVSet2==0 || g_nColorOverlayUVSet==0); >;
	bool bBiplanarUsedAny < UiType(CheckBox); Expression(g_nUVSet1==0 || g_nUVSet2==0 || g_nUVSet3==0 || g_nColorOverlayUVSet==0); >;
	bool bBlendByFacingDirection2 < UiType(CheckBox); Expression(F_BLEND_BY_FACING_DIRECTION_2); >;
	bool bBlendByFacingDirection3 < UiType(CheckBox); Expression(F_BLEND_BY_FACING_DIRECTION_3); >;
	bool g_bAdjustBaseColor1 < UiType(CheckBox); Expression(g_nColorCorrectionMode1==1); >;
	bool g_bAdjustBaseColor2 < UiType(CheckBox); Expression(g_nColorCorrectionMode2==1); >;
	bool g_bAdjustBaseColor3 < UiType(CheckBox); Expression(g_nColorCorrectionMode3==1); >;
	bool g_bBorderBlendColorize2 < UiType(CheckBox); Expression(F_BORDER_BLEND_MODE_2==3); >;
	bool g_bBorderBlendColorize3 < UiType(CheckBox); Expression(F_BORDER_BLEND_MODE_3==3); >;
	bool g_bBorderBlendMod2x2 < UiType(CheckBox); Expression(F_BORDER_BLEND_MODE_2==2); >;
	bool g_bBorderBlendMod2x3 < UiType(CheckBox); Expression(F_BORDER_BLEND_MODE_3==2); >;
	bool g_bBorderBlendMultiply2 < UiType(CheckBox); Expression(!F_BORDER_BLEND_MODE_2); >;
	bool g_bBorderBlendMultiply3 < UiType(CheckBox); Expression(!F_BORDER_BLEND_MODE_3); >;
	bool g_bBorderBlendReplace2 < UiType(CheckBox); Expression(F_BORDER_BLEND_MODE_2==1); >;
	bool g_bBorderBlendReplace3 < UiType(CheckBox); Expression(F_BORDER_BLEND_MODE_3==1); >;
	bool g_bBorderRoughness2 < UiType(CheckBox); Expression(F_BORDER_ROUGHNESS_2); >;
	bool g_bBorderRoughness3 < UiType(CheckBox); Expression(F_BORDER_ROUGHNESS_3); >;
	bool g_bColorOverlayLayer1 < UiType(CheckBox); Expression(g_nColorOverlayMode==0 || g_nColorOverlayMode==1); >;
	bool g_bColorOverlayLayer2 < UiType(CheckBox); Expression(g_nColorOverlayMode==0 || g_nColorOverlayMode==2); >;
	bool g_bColorOverlayLayer3 < UiType(CheckBox); Expression(g_nColorOverlayMode==0 || g_nColorOverlayMode==3); >;
	bool g_bColorOverlayMaskLayer1 < UiType(CheckBox); Expression(g_nColorOverlayTintMask==0 || g_nColorOverlayTintMask==1); >;
	bool g_bColorOverlayMaskLayer2 < UiType(CheckBox); Expression(g_nColorOverlayTintMask==0 || g_nColorOverlayTintMask==2); >;
	bool g_bColorOverlayMaskLayer3 < UiType(CheckBox); Expression(g_nColorOverlayTintMask==0 || g_nColorOverlayTintMask==3); >;
	bool g_bDontFlipBackfaceNormals < UiType(CheckBox); Expression(F_DONT_FLIP_BACKFACE_NORMALS ? 1 : 0); >;
	bool g_bMaskVertexColor1 < UiType(CheckBox); Expression(g_nVertexColorMode1==0); >;
	bool g_bMaskVertexColor2 < UiType(CheckBox); Expression(g_nVertexColorMode2==0); >;
	bool g_bMaskVertexColor3 < UiType(CheckBox); Expression(g_nVertexColorMode3==0); >;
	bool g_bRenderBackfaceNormals < UiType(CheckBox); Expression((F_RENDER_BACKFACES ? 1 : 0) ? 1 : 0); >;
	bool g_bVertexColorEnabled1 < UiType(CheckBox); Expression(g_nVertexColorMode1!=2); >;
	bool g_bVertexColorEnabled2 < UiType(CheckBox); Expression(g_nVertexColorMode2!=2); >;
	bool g_bVertexColorEnabled3 < UiType(CheckBox); Expression(g_nVertexColorMode3!=2); >;
	bool g_bWetness < UiType(CheckBox); Expression((F_WETNESS==1) ? 1 : 0); >;
	float g_flReflectance < UiType(Slider); Expression(pow((1.5-1)/(1.5+1),2)); >;
	float4x4 g_mTextureAdjust1 < Expression(MatrixMultiply(MatrixColorTint2(float3(1,1,1),1),MatrixColorCorrect2(float3(g_fTextureColorContrast1,g_fTextureColorSaturation1,g_fTextureColorBrightness1),TextureAverageColor(g_tColor1)))); >;
	float4x4 g_mTextureAdjust2 < Expression(MatrixMultiply(MatrixColorTint2(float3(1,1,1),1),MatrixColorCorrect2(float3(g_fTextureColorContrast2,g_fTextureColorSaturation2,g_fTextureColorBrightness2),TextureAverageColor(g_tColor2)))); >;
	float4x4 g_mTextureAdjust3 < Expression(MatrixMultiply(MatrixColorTint2(float3(1,1,1),1),MatrixColorCorrect2(float3(g_fTextureColorContrast3,g_fTextureColorSaturation3,g_fTextureColorBrightness3),TextureAverageColor(g_tColor3)))); >;
	float4x4 g_mTextureColorAdjust1 < Expression(MatrixMultiply(MatrixColorTint2(g_vTextureColorTint1,1),MatrixColorCorrect2(float3(g_fTextureColorContrast1,g_fTextureColorSaturation1,g_fTextureColorBrightness1),TextureAverageColor(g_tColor1)))); >;
	float4x4 g_mTextureColorAdjust2 < Expression(MatrixMultiply(MatrixColorTint2(g_vTextureColorTint2,1),MatrixColorCorrect2(float3(g_fTextureColorContrast2,g_fTextureColorSaturation2,g_fTextureColorBrightness2),TextureAverageColor(g_tColor2)))); >;
	float4x4 g_mTextureColorAdjust3 < Expression(MatrixMultiply(MatrixColorTint2(g_vTextureColorTint3,1),MatrixColorCorrect2(float3(g_fTextureColorContrast3,g_fTextureColorSaturation3,g_fTextureColorBrightness3),TextureAverageColor(g_tColor3)))); >;
	int g_nVisualization < UiType(Slider); Expression(F_VISUALIZATION_MODE); >;
	Texture2D g_tColor1 < Channel(RGB, ArtistDefined(TextureColor1), Srgb); Channel(A, Box(TextureAmbientOcclusion1), Linear); OutputFormat(BC7); SrgbRead(true); >;
	Texture2D g_tColor1 < Channel(RGB, ArtistDefinedOrAlphaWeighted(TextureColor1, TextureTranslucency1), Srgb); Channel(A, PreserveCoverage(TextureTranslucency1), Linear); OutputFormat(BC7); SrgbRead(true); >;
	Texture2D g_tColor2 < Channel(RGB, ArtistDefined(TextureColor2), Srgb); Channel(A, Box(TextureAmbientOcclusion2), Linear); OutputFormat(BC7); SrgbRead(true); >;
	Texture2D g_tColor3 < Channel(RGB, ArtistDefined(TextureColor3), Srgb); Channel(A, Box(TextureAmbientOcclusion3), Linear); OutputFormat(BC7); SrgbRead(true); >;
	Texture2D g_tHeight1 < Channel(R, ArtistDefined(TextureHeight1), Linear); Channel(G, ArtistDefined(TextureTintMask1), Linear); Channel(A, Box(TextureMetalness1), Linear); OutputFormat(BC7); SrgbRead(false); >;
	Texture2D g_tHeight1 < Channel(R, ArtistDefined(TextureHeight1), Linear); Channel(G, ArtistDefined(TextureTintMask1), Linear); Channel(B, Box(TextureAmbientOcclusion1), Linear); Channel(A, Box(TextureMetalness1), Linear); OutputFormat(BC7); SrgbRead(false); >;
	Texture2D g_tHeight2 < Channel(R, Box(TextureHeight2), Linear); Channel(G, Box(TextureTintMask2), Linear); Channel(A, Box(TextureMetalness2), Linear); OutputFormat(BC7); SrgbRead(false); >;
	Texture2D g_tHeight3 < Channel(R, Box(TextureHeight3), Linear); Channel(G, Box(TextureTintMask3), Linear); Channel(A, Box(TextureMetalness3), Linear); OutputFormat(BC7); SrgbRead(false); >;
	Texture2D g_tNormal1 < Channel(RGBA, HemiOctIsoRoughness_RG_B(TextureNormal1, TextureRoughness1), Linear); OutputFormat(BC7); SrgbRead(false); >;
	Texture2D g_tNormal2 < Channel(RGBA, HemiOctIsoRoughness_RG_B(TextureNormal2, TextureRoughness2), Linear); OutputFormat(BC7); SrgbRead(false); >;
	Texture2D g_tNormal3 < Channel(RGBA, HemiOctIsoRoughness_RG_B(TextureNormal3, TextureRoughness3), Linear); OutputFormat(BC7); SrgbRead(false); >;
	Texture2D g_tSharedColorOverlay < Channel(RGB, ArtistDefined(TextureSharedColorOverlay), Srgb); OutputFormat(DXT1); SrgbRead(true); >;
	float4 g_vNormalXform_1 < UiType(VectorText); Expression(v0 = g_flTexCoordRotation1*3.1415927/180;
		v1 = cos(v0);
		v2 = sin(v0);
		float4(v1,-v2,v2,v1)); >;
	float4 g_vNormalXform_2 < UiType(VectorText); Expression(v0 = g_flTexCoordRotation2*3.1415927/180;
		v1 = cos(v0);
		v2 = sin(v0);
		float4(v1,-v2,v2,v1)); >;
	float4 g_vNormalXform_3 < UiType(VectorText); Expression(v0 = g_flTexCoordRotation3*3.1415927/180;
		v1 = cos(v0);
		v2 = sin(v0);
		float4(v1,-v2,v2,v1)); >;
	float4 g_vOverlayTexCoordXform0 < UiType(VectorText); Expression(v0 = g_flOverlayTexCoordRotation*3.1415927/180;
		v1 = cos(v0);
		v2 = sin(v0);
		float4(v1*g_vOverlayTexCoordScale.x,-v2*g_vOverlayTexCoordScale.y,0,g_vOverlayTexCoordCenter.x+g_vOverlayTexCoordOffset.x+v2*g_vOverlayTexCoordCenter.y-v1*g_vOverlayTexCoordCenter.x)); >;
	float4 g_vOverlayTexCoordXform1 < UiType(VectorText); Expression(v0 = g_flOverlayTexCoordRotation*3.1415927/180;
		v1 = cos(v0);
		v2 = sin(v0);
		float4(v2*g_vOverlayTexCoordScale.x,v1*g_vOverlayTexCoordScale.y,0,g_vOverlayTexCoordCenter.y+g_vOverlayTexCoordOffset.y-(v2*g_vOverlayTexCoordCenter.x+v1*g_vOverlayTexCoordCenter.y))); >;
	float4 g_vTexCoordXform0_1 < UiType(VectorText); Expression(v0 = g_flTexCoordRotation1*3.1415927/180;
		v1 = cos(v0);
		v2 = sin(v0);
		float4(v1*g_vTexCoordScale1.x,-v2*g_vTexCoordScale1.y,0,g_vTexCoordCenter1.x+g_vTexCoordOffset1.x+v2*g_vTexCoordCenter1.y-v1*g_vTexCoordCenter1.x)); >;
	float4 g_vTexCoordXform0_2 < UiType(VectorText); Expression(v0 = g_flTexCoordRotation2*3.1415927/180;
		v1 = cos(v0);
		v2 = sin(v0);
		float4(v1*g_vTexCoordScale2.x,-v2*g_vTexCoordScale2.y,0,g_vTexCoordCenter2.x+g_vTexCoordOffset2.x+v2*g_vTexCoordCenter2.y-v1*g_vTexCoordCenter2.x)); >;
	float4 g_vTexCoordXform0_3 < UiType(VectorText); Expression(v0 = g_flTexCoordRotation3*3.1415927/180;
		v1 = cos(v0);
		v2 = sin(v0);
		float4(v1*g_vTexCoordScale3.x,-v2*g_vTexCoordScale3.y,0,g_vTexCoordCenter3.x+g_vTexCoordOffset3.x+v2*g_vTexCoordCenter3.y-v1*g_vTexCoordCenter3.x)); >;
	float4 g_vTexCoordXform1_1 < UiType(VectorText); Expression(v0 = g_flTexCoordRotation1*3.1415927/180;
		v1 = cos(v0);
		v2 = sin(v0);
		float4(v2*g_vTexCoordScale1.x,v1*g_vTexCoordScale1.y,0,g_vTexCoordCenter1.y+g_vTexCoordOffset1.y-(v2*g_vTexCoordCenter1.x+v1*g_vTexCoordCenter1.y))); >;
	float4 g_vTexCoordXform1_2 < UiType(VectorText); Expression(v0 = g_flTexCoordRotation2*3.1415927/180;
		v1 = cos(v0);
		v2 = sin(v0);
		float4(v2*g_vTexCoordScale2.x,v1*g_vTexCoordScale2.y,0,g_vTexCoordCenter2.y+g_vTexCoordOffset2.y-(v2*g_vTexCoordCenter2.x+v1*g_vTexCoordCenter2.y))); >;
	float4 g_vTexCoordXform1_3 < UiType(VectorText); Expression(v0 = g_flTexCoordRotation3*3.1415927/180;
		v1 = cos(v0);
		v2 = sin(v0);
		float4(v2*g_vTexCoordScale3.x,v1*g_vTexCoordScale3.y,0,g_vTexCoordCenter3.y+g_vTexCoordOffset3.y-(v2*g_vTexCoordCenter3.x+v1*g_vTexCoordCenter3.y))); >;
	
	// Material1
	CreateInputTexture2D(TextureColor1, Srgb, 8, "", "_color", "Material1,0/Color,10/0", Default4(1, 1, 1, 0));
	CreateInputTexture2D(TextureNormal1, Linear, 8, "NormalizeNormals", "_normal", "Material1/Lighting/0", Default4(0.5, 0.5, 1, 0));
	CreateInputTexture2D(TextureTintMask1, Linear, 8, "", "_mask", "Material1/Tint Mask,15/0", Default4(1, 1, 1, 0));
	CreateInputTexture2D(TextureTranslucency1, Linear, 8, "", "_trans", "Material1/Translucent,15/0", Default4(1, 1, 1, 0));
	int g_nUVSet1 < Default(1); Range4(0, 0, 0, 0, 2, 2, 2, 2); UiOptions("0=Biplanar,1=UV1,2=UV2"); UiType(Enum); UiGroup("Material1/Texture Coordinates,34/1"); >;
	float2 g_vTexCoordCenter1 < Default2(0.5, 0.5); Attribute("0=X,1=Y"); UiType(VectorText); UiGroup("Material1/Texture Transform,35/1"); UiVisibility(1); >;
	float2 g_vTexCoordCenter2 < Default2(0.5, 0.5); Attribute("0=X,1=Y"); UiType(VectorText); UiGroup("Material1/Texture Transform,35/1"); UiVisibility(1); >;
	float2 g_vTexCoordScale1 < Default2(1, 1); Range2(0, 0, 100, 100); Attribute("0=X,1=Y"); UiType(VectorText); UiGroup("Material1/Texture Transform,35/2"); >;
	float2 g_vTexCoordScale2 < Default2(1, 1); Range2(0, 0, 100, 100); Attribute("0=X,1=Y"); UiType(VectorText); UiGroup("Material1/Texture Transform,35/2"); >;
	float g_flTexCoordRotation2 < Range(-360, 360); UiType(Slider); UiGroup("Material1/Texture Transform,35/3"); UiVisibility(1); >;
	float2 g_vTexCoordOffset1 < Range2(-1, -1, 1, 1); Attribute("0=X,1=Y"); UiType(VectorText); UiGroup("Material1/Texture Transform,35/4"); UiVisibility(1); >;
	float2 g_vTexCoordOffset2 < Range2(-1, -1, 1, 1); Attribute("0=X,1=Y"); UiType(VectorText); UiGroup("Material1/Texture Transform,35/4"); UiVisibility(1); >;
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
	float g_flDetailPropMaskBias1 < Range(0, 10); UiType(Slider); UiGroup("Material1/Detail Props,90/20"); >;
	float g_flHeightMapScale1 < Default(1); Range(-4, 4); UiType(Slider); UiGroup("Material1/Height/20"); >;
	float g_flHeightMapScale1 < Default(1); Range(-2, 2); UiType(Slider); UiGroup("Material1/Height/20"); >;
	float3 g_vAmbientOcclusionLevels1 < Default2(0, 0.5); Range(-1, 1); Attribute("0=Option 1,1=Option 2,2=Option 3"); UiType(VectorText); UiGroup("Material1/Lighting/21"); Expression(float3(-this.x,-1.4427*log(max(.0001,1-this.y)),2-this.z)); >;
	CreateInputTexture2D(TextureMetalness1, Linear, 8, "", "_metal", "Material1/Lighting/30", Default4(0, 0, 0, 0));
	float g_fTextureColorSaturation1 < Default(1); Range(0, 4); UiType(Slider); UiGroup("Material1/Color Correction/30"); >;
	float g_flDetailPropPuddleReduction1 < UiType(Slider); UiGroup("Material1/Detail Props,90/30"); >;
	float g_flHeightMapZeroPoint1 < Default(0.5); UiType(Slider); UiGroup("Material1/Height/30"); >;
	float g_fTextureColorBrightness1 < Default(1); Range(-8, 8); UiType(Slider); UiGroup("Material1/Color Correction/40"); >;
	int g_nColorCorrectionMode1 < UiOptions("0=Mask All,1=Mask only Tint"); UiType(Enum); UiGroup("Material1/Color Correction/45"); >;
	bool g_bModelTint1 < Default(1); UiType(CheckBox); UiGroup("Material1/Color Correction/60"); >;
	int g_nVertexColorMode1 < Range4(0, 0, 0, 0, 2, 2, 2, 2); UiOptions("0=Masked,1=Unmasked,2=Disabled"); UiType(Enum); UiGroup("Material1/Color Correction/60"); >;
	float g_flWetnessDarkeningStrength1 < Default(1); UiType(Slider); UiGroup("Material1/Lighting/61"); >;
	
	// Material2
	CreateInputTexture2D(TextureColor2, Srgb, 8, "", "_color", "Material2/Color,10/0", Default4(1, 1, 1, 0));
	CreateInputTexture2D(TextureNormal2, Linear, 8, "NormalizeNormals", "_normal", "Material2/Lighting/0", Default4(0.5, 0.5, 1, 0));
	CreateInputTexture2D(TextureTintMask2, Linear, 8, "", "_mask", "Material2/Tint Mask,15/0", Default4(1, 1, 1, 0));
	float g_flColorReplace2 < Default(1); UiType(Slider); UiGroup("Material2/Selective Blending/0"); >;
	int g_nUVSet2 < Default(1); Range4(0, 0, 0, 0, 2, 2, 2, 2); UiOptions("0=Biplanar,1=UV1,2=UV2"); UiType(Enum); UiGroup("Material2/Texture Coordinates,34/1"); >;
	float g_fTintMaskBrightness2 < Default(1); Range(0, 4); UiType(Slider); UiGroup("Material2/Tint Mask/5"); >;
	CreateInputTexture2D(TextureHeight2, Linear, 8, "", "_height", "Material2/Height,30/10", Default4(0.5, 0.5, 0.5, 0));
	CreateInputTexture2D(TextureRoughness2, Linear, 8, "Inverse", "_rough", "Material2/Lighting/10", Default4(0.5, 0.5, 0.5, 0));
	float g_fTintMaskContrast2 < Default(1); Range(-2, 4); UiType(Slider); UiGroup("Material2/Tint Mask/10"); >;
	float g_flColorOverlay2 < UiType(Slider); UiGroup("Material2/Selective Blending/10"); >;
	float g_flDetailPropMaskSoftness2 < Default(0.01); UiType(Slider); UiGroup("Material2/Detail Props,90/10"); >;
	float3 g_vFacingDirection2 < Default(0); Range3(-1, -1, -1, 1, 1, 1); UiType(VectorText); UiGroup("Material2/Facing Direction/10"); Expression(normalize(float3(this.x,this.y,this.z+((this.z==0) ? .0001 : 0)))); UiVisibility(F_BLEND_BY_FACING_DIRECTION_2>0); >;
	float3 g_vTextureColorTint2 < Default3(1, 1, 1); UiType(Color); UiGroup("Material2/Color Correction,17/10"); >;
	float g_fTextureRoughnessContrast2 < Default(1); Range(0, 4); UiType(Slider); UiGroup("Material2,0/Lighting,20/11"); >;
	float g_fTextureRoughnessBrightness2 < Default(1); Range(0, 4); UiType(Slider); UiGroup("Material2/Lighting/12"); >;
	float g_fTextureNormalContrast2 < Default(1); Range(-2, 2); UiType(Slider); UiGroup("Material2/Lighting/13"); >;
	bool g_bMetalness2 < Default(1); UiType(CheckBox); UiGroup("Material2/Lighting/14"); >;
	CreateInputTexture2D(TextureAmbientOcclusion2, Linear, 8, "", "_ao", "Material2/Lighting/20", Default4(1, 1, 1, 0));
	float g_fTextureColorContrast2 < Default(1); Range(0, 4); UiType(Slider); UiGroup("Material2/Color Correction/20"); >;
	float g_flDetailPropMaskBias2 < Range(0, 10); UiType(Slider); UiGroup("Material2/Detail Props,90/20"); >;
	float g_flFacingDirectionMaskSpread2 < Default(0.5); UiType(Slider); UiGroup("Material2/Facing Direction/20"); UiVisibility(F_BLEND_BY_FACING_DIRECTION_2>0); >;
	float g_flHeightMapScale2 < Default(1); Range(-4, 4); UiType(Slider); UiGroup("Material2/Height/20"); >;
	float g_flHeightMapScale2 < Default(1); Range(-2, 2); UiType(Slider); UiGroup("Material2/Height/20"); >;
	float g_flNormalReplace2 < Default(1); UiType(Slider); UiGroup("Material2/Selective Blending/20"); >;
	float3 g_vAmbientOcclusionLevels2 < Default2(0, 0.5); Range(-1, 1); UiType(VectorText); UiGroup("Material2/Lighting/21"); Expression(float3(-this.x,-1.4427*log(max(.0001,1-this.y)),2-this.z)); >;
	CreateInputTexture2D(TextureMetalness2, Linear, 8, "", "_metal", "Material2/Lighting/30", Default4(0, 0, 0, 0));
	float g_fTextureColorSaturation2 < Default(1); Range(0, 4); UiType(Slider); UiGroup("Material2/Color Correction/30"); >;
	float g_flDetailPropPuddleReduction2 < UiType(Slider); UiGroup("Material2/Detail Props,90/30"); >;
	float g_flHeightMapZeroPoint2 < Default(0.5); UiType(Slider); UiGroup("Material2/Height/30"); >;
	float g_flNormalCombine2 < Range(0, 8); UiType(Slider); UiGroup("Material2/Selective Blending/30"); >;
	float g_vFacingDirectionMaskNormalMapStrength2 < Default(1); Range(0, 4); UiType(Slider); UiGroup("Material2/Facing Direction/30"); UiVisibility(F_BLEND_BY_FACING_DIRECTION_2>0); >;
	float g_fTextureColorBrightness2 < Default(1); Range(-8, 8); UiType(Slider); UiGroup("Material2/Color Correction/40"); >;
	float g_flBlendSoftness2 < Default(0.01); UiType(Slider); UiGroup("Material2/Height,30/40"); >;
	float g_flRoughnessReplace2 < Default(1); UiType(Slider); UiGroup("Material2/Selective Blending/40"); >;
	float g_vFacingDirectionMaskSoftness2 < Default(0.1); UiType(Slider); UiGroup("Material2/Facing Direction/40"); UiVisibility(F_BLEND_BY_FACING_DIRECTION_2>0); >;
	float g_flUnderlyingHeightMapInfluence2 < Default(1); Range(-2, 2); UiType(Slider); UiGroup("Material2/Height,30/41"); >;
	float g_flRoughnessCombine2 < UiType(Slider); UiGroup("Material2/Selective Blending/45"); >;
	int g_nColorCorrectionMode2 < UiOptions("0=Mask All,1=Mask only Tint"); UiType(Enum); UiGroup("Material2/Color Correction/45"); >;
	float g_flMetalnessReplace2 < Default(1); UiType(Slider); UiGroup("Material2/Selective Blending/50"); >;
	float g_flMetalnessCombine2 < UiType(Slider); UiGroup("Material2/Selective Blending/55"); >;
	bool g_bModelTint2 < Default(1); UiType(CheckBox); UiGroup("Material2/Color Correction/60"); >;
	float g_flAOReplace2 < Default(1); UiType(Slider); UiGroup("Material2/Selective Blending/60"); >;
	int g_nVertexColorMode2 < Range4(0, 0, 0, 0, 2, 2, 2, 2); UiOptions("0=Masked,1=Unmasked,2=Disabled"); UiType(Enum); UiGroup("Material2/Color Correction/60"); >;
	float g_flWetnessDarkeningStrength2 < Default(1); UiType(Slider); UiGroup("Material2/Lighting/62"); >;
	float g_flAOCombine2 < UiType(Slider); UiGroup("Material2/Selective Blending/70"); >;
	float g_flMaskWithHeight2 < Range(0, 8); UiType(Slider); UiGroup("Material2/Height/70"); >;
	
	// Material3
	CreateInputTexture2D(TextureColor3, Srgb, 8, "", "_color", "Material3/Color,10/0", Default4(1, 1, 1, 0));
	CreateInputTexture2D(TextureNormal3, Linear, 8, "NormalizeNormals", "_normal", "Material3/Lighting/0", Default4(0.5, 0.5, 1, 0));
	CreateInputTexture2D(TextureTintMask3, Linear, 8, "", "_mask", "Material3/Tint Mask,15/0", Default4(1, 1, 1, 0));
	float g_flColorReplace3 < Default(1); UiType(Slider); UiGroup("Material3/Selective Blending/0"); >;
	int g_nUVSet3 < Default(1); Range4(0, 0, 0, 0, 2, 2, 2, 2); UiOptions("0=Biplanar,1=UV1,2=UV2"); UiType(Enum); UiGroup("Material3/Texture Coordinates,34/1"); >;
	float2 g_vTexCoordCenter3 < Default2(0.5, 0.5); UiType(VectorText); UiGroup("Material3/Texture Transform,35/1"); UiVisibility(1); >;
	float2 g_vTexCoordScale3 < Default2(1, 1); Range2(0, 0, 100, 100); UiType(VectorText); UiGroup("Material3/Texture Transform,35/2"); >;
	float g_flTexCoordRotation3 < Range(-360, 360); UiType(Slider); UiGroup("Material3/Texture Transform,35/3"); UiVisibility(1); >;
	float2 g_vTexCoordOffset3 < Range2(-1, -1, 1, 1); UiType(VectorText); UiGroup("Material3/Texture Transform,35/4"); UiVisibility(1); >;
	float g_fTintMaskBrightness3 < Default(1); Range(0, 4); UiType(Slider); UiGroup("Material3/Tint Mask/5"); >;
	CreateInputTexture2D(TextureHeight3, Linear, 8, "", "_height", "Material3/Height,30/10", Default4(0.5, 0.5, 0.5, 0));
	CreateInputTexture2D(TextureRoughness3, Linear, 8, "Inverse", "_rough", "Material3/Lighting/10", Default4(0.5, 0.5, 0.5, 0));
	float g_fTintMaskContrast3 < Default(1); Range(-2, 4); UiType(Slider); UiGroup("Material3/Tint Mask/10"); >;
	float g_flColorOverlay3 < UiType(Slider); UiGroup("Material3/Selective Blending/10"); >;
	float g_flDetailPropMaskSoftness3 < Default(0.01); UiType(Slider); UiGroup("Material3/Detail Props,90/10"); >;
	float3 g_vFacingDirection3 < Default(0); Range3(-1, -1, -1, 1, 1, 1); UiType(VectorText); UiGroup("Material3/Facing Direction/10"); Expression(normalize(float3(this.x,this.y,this.z+((this.z==0) ? .0001 : 0)))); UiVisibility(F_BLEND_BY_FACING_DIRECTION_3>0); >;
	float3 g_vTextureColorTint3 < Default3(1, 1, 1); UiType(Color); UiGroup("Material3/Color Correction,17/10"); >;
	float g_fTextureRoughnessContrast3 < Default(1); Range(0, 4); UiType(Slider); UiGroup("Material3,2/Lighting,20/11"); >;
	float g_fTextureRoughnessBrightness3 < Default(1); Range(0, 4); UiType(Slider); UiGroup("Material3/Lighting/12"); >;
	float g_fTextureNormalContrast3 < Default(1); Range(-2, 2); UiType(Slider); UiGroup("Material3/Lighting/13"); >;
	bool g_bMetalness3 < Default(1); UiType(CheckBox); UiGroup("Material3/Lighting/14"); >;
	CreateInputTexture2D(TextureAmbientOcclusion3, Linear, 8, "", "_ao", "Material3/Lighting/20", Default4(1, 1, 1, 0));
	float g_fTextureColorContrast3 < Default(1); Range(0, 4); UiType(Slider); UiGroup("Material3/Color Correction/20"); >;
	float g_flDetailPropMaskBias3 < Range(0, 10); UiType(Slider); UiGroup("Material3/Detail Props,90/20"); >;
	float g_flFacingDirectionMaskSpread3 < Default(0.5); UiType(Slider); UiGroup("Material3/Facing Direction/20"); UiVisibility(F_BLEND_BY_FACING_DIRECTION_3>0); >;
	float g_flHeightMapScale3 < Default(1); Range(-4, 4); UiType(Slider); UiGroup("Material3/Height/20"); >;
	float g_flHeightMapScale3 < Default(1); Range(-2, 2); UiType(Slider); UiGroup("Material3/Height/20"); >;
	float g_flNormalReplace3 < Default(1); UiType(Slider); UiGroup("Material3/Selective Blending/20"); >;
	float3 g_vAmbientOcclusionLevels3 < Default2(0, 0.5); Range(-1, 1); UiType(VectorText); UiGroup("Material3/Lighting/21"); Expression(float3(-this.x,-1.4427*log(max(.0001,1-this.y)),2-this.z)); >;
	CreateInputTexture2D(TextureMetalness3, Linear, 8, "", "_metal", "Material3/Lighting/30", Default4(0, 0, 0, 0));
	float g_fTextureColorSaturation3 < Default(1); Range(0, 4); UiType(Slider); UiGroup("Material3/Color Correction/30"); >;
	float g_flDetailPropPuddleReduction3 < UiType(Slider); UiGroup("Material3/Detail Props,90/30"); >;
	float g_flHeightMapZeroPoint3 < Default(0.5); UiType(Slider); UiGroup("Material3/Height/30"); >;
	float g_flNormalCombine3 < Range(0, 8); UiType(Slider); UiGroup("Material3/Selective Blending/30"); >;
	float g_vFacingDirectionMaskNormalMapStrength3 < Default(1); Range(0, 4); UiType(Slider); UiGroup("Material3/Facing Direction/30"); UiVisibility(F_BLEND_BY_FACING_DIRECTION_3>0); >;
	float g_fTextureColorBrightness3 < Default(1); Range(-8, 8); UiType(Slider); UiGroup("Material3/Color Correction/40"); >;
	float g_flBlendSoftness3 < Default(0.01); UiType(Slider); UiGroup("Material3/Height,30/40"); >;
	float g_flRoughnessReplace3 < Default(1); UiType(Slider); UiGroup("Material3/Selective Blending/40"); >;
	float g_vFacingDirectionMaskSoftness3 < Default(0.1); UiType(Slider); UiGroup("Material3/Facing Direction/40"); UiVisibility(F_BLEND_BY_FACING_DIRECTION_3>0); >;
	float g_flUnderlyingHeightMapInfluence3 < Default(1); Range(-2, 2); UiType(Slider); UiGroup("Material3/Height,30/41"); >;
	float g_flRoughnessCombine3 < UiType(Slider); UiGroup("Material3/Selective Blending/45"); >;
	int g_nColorCorrectionMode3 < UiOptions("0=Mask All,1=Mask only Tint"); UiType(Enum); UiGroup("Material3/Color Correction/45"); >;
	float g_flMetalnessReplace3 < Default(1); UiType(Slider); UiGroup("Material3/Selective Blending/50"); >;
	float g_flMetalnessCombine3 < UiType(Slider); UiGroup("Material3/Selective Blending/55"); >;
	float g_flAOReplace3 < Default(1); UiType(Slider); UiGroup("Material3/Selective Blending/60"); >;
	int g_nVertexColorMode3 < Range4(0, 0, 0, 0, 2, 2, 2, 2); UiOptions("0=Masked,1=Unmasked,2=Disabled"); UiType(Enum); UiGroup("Material3/Color Correction/60"); >;
	bool g_bModelTint3 < Default(1); UiType(CheckBox); UiGroup("Material3/Color Correction/61"); >;
	float g_flWetnessDarkeningStrength3 < Default(1); UiType(Slider); UiGroup("Material3/Lighting/63"); >;
	float g_flAOCombine3 < UiType(Slider); UiGroup("Material3/Selective Blending/70"); >;
	float g_flMaskWithHeight3 < Range(0, 8); UiType(Slider); UiGroup("Material3/Height/70"); >;
	
	// Color
	CreateInputTexture2D(TextureSharedColorOverlay, Linear, 8, "", "_color", "Color/Overlay/0", Default4(1, 1, 1, 0));
	float3 g_vColorTint < Default3(1, 1, 1); UiType(Color); UiGroup("Color,10/20"); Expression(SrgbGammaToLinear(this)); >;
	float g_flModelTintAmount < Default(1); UiType(Slider); UiGroup("Color,10/30"); >;
	int g_nColorOverlayUVSet < Default(2); Range4(0, 0, 0, 0, 2, 2, 2, 2); UiOptions("0=Biplanar,1=UV1,2=UV2"); UiType(Enum); UiGroup("Color/Overlay/40"); >;
	int g_nColorOverlayMode < Range4(0, 0, 0, 0, 3, 3, 3, 3); UiOptions("0=All Layers,1=Layer1,2=Layer2,3=Layer3"); UiType(Enum); UiGroup("Color/Overlay/50"); >;
	int g_nColorOverlayTintMask < Range4(0, 0, 0, 0, 4, 4, 4, 4); UiOptions("0=Mask All,1=Mask Layer1,2=Mask Layer2,3=Mask Layer3,4=Unmasked"); UiType(Enum); UiGroup("Color/Overlay/55"); >;
	float3 g_vColorOverlayLayerStrengths < Default3(1, 1, 1); UiType(VectorText); UiGroup("Color/Overlay/60"); >;
	float3 g_vColorOverlayTintMaskStrengths < Range3(-1, -1, -1, 1, 1, 1); UiType(VectorText); UiGroup("Color/Overlay/65"); >;
	int g_nScaleTexCoordUByModelScaleAxis < Range4(0, 0, 0, 0, 3, 3, 3, 3); UiOptions("0=None,1=UV.u * model.x,2=UV.u * model.y,3=UV.u * model.z"); UiType(Enum); UiGroup("Color/80"); >;
	int g_nScaleTexCoordVByModelScaleAxis < Range4(0, 0, 0, 0, 3, 3, 3, 3); UiOptions("0=None,1=UV.v * model.x,2=UV.v * model.y,3=UV.v * model.z"); UiType(Enum); UiGroup("Color/90"); >;
	float g_flOverlayDarknessContrast < Default(1); Range(0.2, 2); UiType(Slider); UiGroup("Color/Overlay/100"); >;
	int g_nScaleTexCoord2UByModelScaleAxis < Range4(0, 0, 0, 0, 3, 3, 3, 3); UiOptions("0=None,1=UV2.u * model.x,2=UV2.u * model.y,3=UV2.u * model.z"); UiType(Enum); UiGroup("Color/100"); UiVisibility(1); >;
	float g_flOverlayBrightnessContrast < Default(1); Range(0.2, 2); UiType(Slider); UiGroup("Color/Overlay/110"); >;
	int g_nScaleTexCoord2VByModelScaleAxis < Range4(0, 0, 0, 0, 3, 3, 3, 3); UiOptions("0=None,1=UV2.v * model.x,2=UV2.v * model.y,3=UV2.v * model.z"); UiType(Enum); UiGroup("Color/110"); UiVisibility(1); >;
	float2 g_vOverlayTexCoordCenter < Default2(0.5, 0.5); UiType(VectorText); UiGroup("Color/Overlay/200"); >;
	float2 g_vOverlayTexCoordScale < Default2(1, 1); Range2(0, 0, 100, 100); UiType(VectorText); UiGroup("Color/Overlay/210"); >;
	float g_flOverlayTexCoordRotation < Range(-360, 360); UiType(Slider); UiGroup("Color/Overlay/220"); >;
	float2 g_vOverlayTexCoordOffset < Range2(-1, -1, 1, 1); Attribute("0=X,1=Y"); UiType(VectorText); UiGroup("Color/Overlay/230"); >;
	
	// Blend Effects
	float g_flBorderSpread2 < Default(0.1); UiType(Slider); UiGroup("Blend Effects,8/Border Layer 2,0/10"); >;
	float g_flBorderSpread3 < Default(0.1); UiType(Slider); UiGroup("Blend Effects/Border Layer 3,10/10"); >;
	float g_flBorderSoftness2 < Default(0.1); UiType(Slider); UiGroup("Blend Effects/Border Layer 2/20"); >;
	float g_flBorderSoftness3 < Default(0.1); UiType(Slider); UiGroup("Blend Effects/Border Layer 3/20"); >;
	float g_flBorderOffset2 < Range(-4, 4); UiType(Slider); UiGroup("Blend Effects/Border Layer 2/30"); >;
	float g_flBorderOffset3 < Range(-4, 4); UiType(Slider); UiGroup("Blend Effects/Border Layer 3/30"); >;
	float g_fBorderRoughness2 < Default(0.5); UiType(Slider); UiGroup("Blend Effects/Border Layer 2/35"); UiVisibility(F_BORDER_ROUGHNESS_2); >;
	float g_fBorderRoughness3 < Default(0.5); UiType(Slider); UiGroup("Blend Effects/Border Layer 3/35"); UiVisibility(F_BORDER_ROUGHNESS_3); >;
	float3 g_vBorderTint2 < Default3(1, 1, 1); UiType(Color); UiGroup("Blend Effects/Border Layer 2/40"); Expression(SrgbGammaToLinear(this)); >;
	float3 g_vBorderTint3 < Default3(1, 1, 1); UiType(Color); UiGroup("Blend Effects/Border Layer 3/40"); Expression(SrgbGammaToLinear(this)); >;
	bool g_bBorderTintMask3 < UiType(CheckBox); UiGroup("Blend Effects/Border Layer 3/41"); >;
	float2 g_vBorderLayerAmount2 < Default(1); UiType(VectorText); UiGroup("Blend Effects/Border Layer 2/41"); >;
	float2 g_vBorderLayerAmount3 < Default(1); UiType(VectorText); UiGroup("Blend Effects/Border Layer 3/41"); >;
	bool g_bBorderTintMask2 < UiType(CheckBox); UiGroup("Blend Effects/Border Layer 2/42"); >;
	
	// Wetness
	bool g_bWetnessUseHeightmapAdjustments < UiType(CheckBox); UiGroup("Wetness/2"); UiVisibility(F_WETNESS ? 1 : 0); >;
	bool g_bPuddlesOnVerticalSurfaces < UiType(CheckBox); UiGroup("Wetness,9/3"); UiVisibility(F_WETNESS ? 1 : 0); >;
	float g_flWetnessUnderlyingHeightMapInfluence < Default(1); Range(0, 2); UiType(Slider); UiGroup("Wetness/3"); UiVisibility(F_WETNESS ? 1 : 0); >;
	float g_flHorizontalSurfaceTolerance < Default(32); Range(0, 100); UiType(Slider); UiGroup("Wetness/4"); UiVisibility(F_WETNESS ? 1 : 0); >;
	float g_fPuddleStrength < Default(1); UiType(Slider); UiGroup("Wetness/5"); UiVisibility(F_WETNESS ? 1 : 0); >;
	float g_fPuddleHeight < Default(0.5); UiType(Slider); UiGroup("Wetness/6"); UiVisibility(F_WETNESS ? 1 : 0); >;
	float3 g_vPuddleSedimentColor < Default3(0.62, 0.56, 0.5); UiType(Color); UiGroup("Wetness/10"); Expression(SrgbGammaToLinear(this)); UiVisibility(F_WETNESS ? 1 : 0); >;
	float g_fPuddleSedimentHeight < Default(0.9); Range(0, 2); UiType(Slider); UiGroup("Wetness/15"); Expression(this*2-1); UiVisibility(F_WETNESS ? 1 : 0); >;
	float g_fPuddleSedimentOpacity < Default(0.25); UiType(Slider); UiGroup("Wetness/16"); UiVisibility(F_WETNESS ? 1 : 0); >;
	float g_fPuddleRoughness < Default(0.02); UiType(Slider); UiGroup("Wetness/17"); UiVisibility(F_WETNESS ? 1 : 0); >;
	float g_fPuddleBlendSoftness < Default(0.08); UiType(Slider); UiGroup("Wetness/18"); UiVisibility(F_WETNESS ? 1 : 0); >;
	float g_fWetEdgeStrength < Default(0.5); UiType(Slider); UiGroup("Wetness/20"); UiVisibility(F_WETNESS ? 1 : 0); >;
	float g_fWetEdgeSpread < Default(0.2); UiType(Slider); UiGroup("Wetness/25"); UiVisibility(F_WETNESS ? 1 : 0); >;
	float g_fWetEdgeSoftness < Default(0.2); UiType(Slider); UiGroup("Wetness/26"); UiVisibility(F_WETNESS ? 1 : 0); >;
	float g_fWetnessStrength < Default(1); Range(0, 2); UiType(Slider); UiGroup("Wetness/30"); UiVisibility(F_WETNESS ? 1 : 0); >;
	
	// Translucent
	float g_flAlphaTestReference < Default(0.5); Range(0.01, 0.99); UiType(Slider); UiGroup("Translucent"); >;
	
	// Texture Address Mode
	int g_nTextureAddressModeU < UiOption("RsTextureAddressMode_t"); UiType(Enum); UiGroup("Texture Address Mode"); >;
	int g_nTextureAddressModeV < UiOption("RsTextureAddressMode_t"); UiType(Enum); UiGroup("Texture Address Mode"); >;
	
	#if (S_ALPHA_TEST == 1)
		Texture2D g_tHeight1 < Channel(R, ArtistDefined(TextureHeight1), Linear); Channel(G, ArtistDefined(TextureTintMask1), Linear); Channel(B, Box(TextureAmbientOcclusion1), Linear); Channel(A, Box(TextureMetalness1), Linear); OutputFormat(BC7); SrgbRead(false); >;
		Texture2D g_tColor1 < Channel(RGB, ArtistDefinedOrAlphaWeighted(TextureColor1, TextureTranslucency1), Srgb); Channel(A, PreserveCoverage(TextureTranslucency1), Linear); OutputFormat(BC7); SrgbRead(true); >;
	#endif
	#if (S_USE_NEW_BLENDING == 1)
		float g_flHeightMapScale1 < Default(1); Range(-2, 2); UiType(Slider); UiGroup("Material1/Height/20"); >;
		float g_flHeightMapScale2 < Default(1); Range(-2, 2); UiType(Slider); UiGroup("Material2/Height/20"); >;
	#endif
	
	// Variant parameters
	bool bBiplanarUsedAny < UiType(CheckBox); Expression(g_nUVSet1==0 || g_nUVSet2==0); >;
	bool bBiplanarUsedAny < UiType(CheckBox); Expression(g_nUVSet1==0 || g_nUVSet2==0 || g_nUVSet3==0); >;
	bool bBiplanarUsedAny < UiType(CheckBox); Expression(g_nUVSet1==0 || g_nUVSet2==0 || g_nColorOverlayUVSet==0); >;
	bool bBiplanarUsedAny < UiType(CheckBox); Expression(g_nUVSet1==0 || g_nUVSet2==0 || g_nUVSet3==0 || g_nColorOverlayUVSet==0); >;
	float g_flHeightMapScale1 < Default(1); Range(-4, 4); UiType(Slider); UiGroup("Material1/Height/20"); >;
	float g_flHeightMapScale2 < Default(1); Range(-4, 4); UiType(Slider); UiGroup("Material2/Height/20"); >;
	float g_flHeightMapScale3 < Default(1); Range(-4, 4); UiType(Slider); UiGroup("Material3/Height/20"); >;
	float g_flHeightMapScale3 < Default(1); Range(-2, 2); UiType(Slider); UiGroup("Material3/Height/20"); >;
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
	    vec3 g_vBiplanarTexCoordScale;
	    float g_flDetailPropMaskBias1;
	    float g_flDetailPropPuddleReduction1;
	    bool g_bSnowLayer1;
	    int g_nUVSet1;
	    float _g_fl_AutoPad0_;
	    vec2 g_vTexCoordScale1;
	    vec2 g_vTexCoordCenter1;
	    float g_flTexCoordRotation1;
	    float _g_fl_AutoPad1_;
	    vec2 g_vTexCoordOffset1;
	    vec4 g_vTexCoordXform0_1;
	    vec4 g_vTexCoordXform1_1;
	    vec4 g_vNormalXform_1;
	    float g_flWetnessDarkeningStrength1;
	    int g_nDetailUVSet1;
	    vec2 g_vDetailTexCoordScale1;
	    vec2 g_vDetailTexCoordCenter1;
	    float g_flDetailTexCoordRotation1;
	    float _g_fl_AutoPad2_;
	    vec2 g_vDetailTexCoordOffset1;
	    float _g_fl_AutoPad3_;
	    float _g_fl_AutoPad4_;
	    vec4 g_vDetailTexCoordXform0_1;
	    vec4 g_vDetailTexCoordXform1_1;
	    vec4 g_vDetailNormalXform_1;
	    int g_nDupeOfLayer2;
	    float g_flBlendSoftness2;
	    float g_flUnderlyingHeightMapInfluence2;
	    bool g_bSnowLayer2;
	    int g_nUVSet2;
	    float _g_fl_AutoPad5_;
	    vec2 g_vTexCoordScale2;
	    vec2 g_vTexCoordCenter2;
	    float g_flTexCoordRotation2;
	    float _g_fl_AutoPad6_;
	    vec2 g_vTexCoordOffset2;
	    float _g_fl_AutoPad7_;
	    float _g_fl_AutoPad8_;
	    vec4 g_vTexCoordXform0_2;
	    vec4 g_vTexCoordXform1_2;
	    vec4 g_vNormalXform_2;
	    float g_flWetnessDarkeningStrength2;
	    int g_nDetailUVSet2;
	    vec2 g_vDetailTexCoordScale2;
	    vec2 g_vDetailTexCoordCenter2;
	    float g_flDetailTexCoordRotation2;
	    float _g_fl_AutoPad9_;
	    vec2 g_vDetailTexCoordOffset2;
	    float _g_fl_AutoPad10_;
	    float _g_fl_AutoPad11_;
	    vec4 g_vDetailTexCoordXform0_2;
	    vec4 g_vDetailTexCoordXform1_2;
	    vec4 g_vDetailNormalXform_2;
	    float g_flDetailPropMaskSoftness2;
	    float g_flDetailPropMaskBias2;
	    float g_flDetailPropPuddleReduction2;
	    uint g_tNormal1;
	    uint g_tHeight1;
	    uint g_tNormalDetail1;
	    float g_fDetailTextureNormalContrast1;
	    float g_fTintMaskContrast1;
	    float g_fTintMaskBrightness1;
	    float _g_fl_AutoPad12_;
	    float _g_fl_AutoPad13_;
	    float _g_fl_AutoPad14_;
	    vec3 g_vAmbientOcclusionLevels1;
	    float _g_fl_AutoPad15_;
	    vec3 g_vTextureColorTint1;
	    float g_fTextureColorContrast1;
	    float g_fTextureColorSaturation1;
	    float g_fTextureColorBrightness1;
	    int g_nColorCorrectionMode1;
	    bool g_bAdjustBaseColor1;
	    float g_flHeightMapScale1;
	    float g_flHeightMapZeroPoint1;
	    int g_nVertexColorMode1;
	    bool g_bVertexColorEnabled1;
	    bool g_bMaskVertexColor1;
	    float g_fTextureRoughnessContrast1;
	    float g_fTextureRoughnessBrightness1;
	    float g_fTextureNormalContrast1;
	    bool g_bMetalness1;
	    bool g_bModelTint1;
	    float _g_fl_AutoPad16_;
	    float _g_fl_AutoPad17_;
	    mat4 g_mTextureColorAdjust1;
	    mat4 g_mTextureAdjust1;
	    float g_flBlendSoftnessDistanceModifierStrength;
	    float g_flColorReplace2;
	    float g_flColorOverlay2;
	    float g_flNormalReplace2;
	    float g_flNormalCombine2;
	    float g_flRoughnessReplace2;
	    float g_flRoughnessCombine2;
	    float g_flMetalnessReplace2;
	    float g_flMetalnessCombine2;
	    float g_flAOReplace2;
	    float g_flAOCombine2;
	    float g_fTextureRoughnessContrast2;
	    float g_fTextureRoughnessBrightness2;
	    float g_fTextureNormalContrast2;
	    bool g_bMetalness2;
	    float g_fTintMaskContrast2;
	    float g_fTintMaskBrightness2;
	    uint g_tColor2;
	    uint g_tNormal2;
	    uint g_tHeight2;
	    vec3 g_vAmbientOcclusionLevels2;
	    float _g_fl_AutoPad18_;
	    vec3 g_vTextureColorTint2;
	    float g_fTextureColorContrast2;
	    float g_fTextureColorSaturation2;
	    float g_fTextureColorBrightness2;
	    int g_nColorCorrectionMode2;
	    bool g_bAdjustBaseColor2;
	    mat4 g_mTextureColorAdjust2;
	    mat4 g_mTextureAdjust2;
	    float g_flHeightMapScale2;
	    float g_flHeightMapZeroPoint2;
	    float g_flMaskWithHeight2;
	    float _g_fl_AutoPad19_;
	    vec3 g_vFacingDirection2;
	    float g_flFacingDirectionMaskSpread2;
	    float g_vFacingDirectionMaskNormalMapStrength2;
	    float g_vFacingDirectionMaskSoftness2;
	    int g_nVertexColorMode2;
	    bool g_bVertexColorEnabled2;
	    bool g_bMaskVertexColor2;
	    bool g_bModelTint2;
	    uint g_tNormalDetail2;
	    float g_fDetailTextureNormalContrast2;
	    bool g_bPuddlesOnVerticalSurfaces;
	    bool g_bWetnessUseHeightmapAdjustments;
	    float g_flWetnessUnderlyingHeightMapInfluence;
	    float g_flHorizontalSurfaceTolerance;
	    float g_fPuddleStrength;
	    float g_fPuddleHeight;
	    float _g_fl_AutoPad20_;
	    float _g_fl_AutoPad21_;
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
	    int g_nScaleTexCoord2UByModelScaleAxis;
	    int g_nScaleTexCoord2VByModelScaleAxis;
	    bool g_bTexCoord2ScaleByModel;
	    vec4 g_vTexCoord2ScaleByModelU;
	    vec4 g_vTexCoord2ScaleByModelV;
	    vec2 g_vDetailTexCoordScale;
	    float g_flDetailTexCoordRotation;
	    float _g_fl_AutoPad22_;
	    vec2 g_vDetailTexCoordOffset;
	    float _g_fl_AutoPad23_;
	    float _g_fl_AutoPad24_;
	    vec4 g_vDetailTexCoordXform;
	    float g_flDetailNormalStrength;
	    float _g_fl_AutoPad25_;
	    float _g_fl_AutoPad26_;
	    float _g_fl_AutoPad27_;
	    vec4 g_vDetailNormalStrengthOffsetScale;
	    vec2 g_vTexCoordCenter;
	    vec2 g_vTexCoordScale;
	    float g_flTexCoordRotation;
	    float _g_fl_AutoPad28_;
	    vec2 g_vTexCoordOffset;
	    vec4 g_vTexCoordXform0;
	    vec4 g_vTexCoordXform1;
	    vec2 g_vTexCoordScrollSpeed;
	    int g_nScaleTexCoordUByModelScaleAxis;
	    int g_nScaleTexCoordVByModelScaleAxis;
	    bool g_bTexCoordScaleByModel;
	    float _g_fl_AutoPad29_;
	    float _g_fl_AutoPad30_;
	    float _g_fl_AutoPad31_;
	    vec4 g_vTexCoordScaleByModelU;
	    vec4 g_vTexCoordScaleByModelV;
	    vec3 g_vColorTint;
	    float g_flModelTintAmount;
	    bool g_bUseSecondaryUvForDetailTexture;
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
	    bool g_bBorderRoughness2;
	    bool g_bBorderBlendMultiply2;
	    bool g_bBorderBlendReplace2;
	    bool g_bBorderBlendMod2x2;
	    bool g_bBorderBlendColorize2;
	    bool g_bBorderRoughness3;
	    bool g_bBorderBlendMultiply3;
	    bool g_bBorderBlendReplace3;
	    bool g_bBorderBlendMod2x3;
	    bool g_bBorderBlendColorize3;
	    bool bBlendByFacingDirection2;
	    bool bBlendByFacingDirection3;
	    bool g_bWetness;
	    bool bBiplanarUsedAny;
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
	
	const vec3 _936[3] = vec3[](vec3(-1.0, 0.0, 0.0), vec3(0.0, 1.0, 0.0), vec3(-1.0, 0.0, 0.0));
	const vec3 _940[3] = vec3[](vec3(0.0, 0.0, 1.0), vec3(0.0, -1.0, 0.0), vec3(0.0, 0.0, 1.0));
	
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
	
	vec4 _1025;
	float _1026;
	vec3 _1027;
	
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
	    uint _1071 = g_instanceBuffer._member0[uint(gl_InstanceID)].nMaterialData;
	    _RTX_MATERIAL_DATA_ _2995 = _RTX_MATERIAL_DATA_(vec3(g_MaterialData_1._member0[_1071 / 4u], g_MaterialData_1._member0[(_1071 + 4u) / 4u], g_MaterialData_1._member0[(_1071 + 8u) / 4u]), g_MaterialData_1._member0[(_1071 + 12u) / 4u], g_MaterialData_1._member0[(_1071 + 16u) / 4u], g_MaterialData_3._member0[(_1071 + 20u) / 4u] != 0, g_MaterialData_5._member0[(_1071 + 24u) / 4u], g_MaterialData_1._member0[(_1071 + 28u) / 4u], vec2(g_MaterialData_1._member0[(_1071 + 32u) / 4u], g_MaterialData_1._member0[(_1071 + 36u) / 4u]), vec2(g_MaterialData_1._member0[(_1071 + 40u) / 4u], g_MaterialData_1._member0[(_1071 + 44u) / 4u]), g_MaterialData_1._member0[(_1071 + 48u) / 4u], g_MaterialData_1._member0[(_1071 + 52u) / 4u], vec2(g_MaterialData_1._member0[(_1071 + 56u) / 4u], g_MaterialData_1._member0[(_1071 + 60u) / 4u]), vec4(g_MaterialData_1._member0[(_1071 + 64u) / 4u], g_MaterialData_1._member0[(_1071 + 68u) / 4u], g_MaterialData_1._member0[(_1071 + 72u) / 4u], g_MaterialData_1._member0[(_1071 + 76u) / 4u]), vec4(g_MaterialData_1._member0[(_1071 + 80u) / 4u], g_MaterialData_1._member0[(_1071 + 84u) / 4u], g_MaterialData_1._member0[(_1071 + 88u) / 4u], g_MaterialData_1._member0[(_1071 + 92u) / 4u]), vec4(g_MaterialData_1._member0[(_1071 + 96u) / 4u], g_MaterialData_1._member0[(_1071 + 100u) / 4u], g_MaterialData_1._member0[(_1071 + 104u) / 4u], g_MaterialData_1._member0[(_1071 + 108u) / 4u]), g_MaterialData_1._member0[(_1071 + 112u) / 4u], g_MaterialData_5._member0[(_1071 + 116u) / 4u], vec2(g_MaterialData_1._member0[(_1071 + 120u) / 4u], g_MaterialData_1._member0[(_1071 + 124u) / 4u]), vec2(g_MaterialData_1._member0[(_1071 + 128u) / 4u], g_MaterialData_1._member0[(_1071 + 132u) / 4u]), g_MaterialData_1._member0[(_1071 + 136u) / 4u], g_MaterialData_1._member0[(_1071 + 140u) / 4u], vec2(g_MaterialData_1._member0[(_1071 + 144u) / 4u], g_MaterialData_1._member0[(_1071 + 148u) / 4u]), g_MaterialData_1._member0[(_1071 + 152u) / 4u], g_MaterialData_1._member0[(_1071 + 156u) / 4u], vec4(g_MaterialData_1._member0[(_1071 + 160u) / 4u], g_MaterialData_1._member0[(_1071 + 164u) / 4u], g_MaterialData_1._member0[(_1071 + 168u) / 4u], g_MaterialData_1._member0[(_1071 + 172u) / 4u]), vec4(g_MaterialData_1._member0[(_1071 + 176u) / 4u], g_MaterialData_1._member0[(_1071 + 180u) / 4u], g_MaterialData_1._member0[(_1071 + 184u) / 4u], g_MaterialData_1._member0[(_1071 + 188u) / 4u]), vec4(g_MaterialData_1._member0[(_1071 + 192u) / 4u], g_MaterialData_1._member0[(_1071 + 196u) / 4u], g_MaterialData_1._member0[(_1071 + 200u) / 4u], g_MaterialData_1._member0[(_1071 + 204u) / 4u]), g_MaterialData_5._member0[(_1071 + 208u) / 4u], g_MaterialData_1._member0[(_1071 + 212u) / 4u], g_MaterialData_1._member0[(_1071 + 216u) / 4u], g_MaterialData_3._member0[(_1071 + 220u) / 4u] != 0, g_MaterialData_5._member0[(_1071 + 224u) / 4u], g_MaterialData_1._member0[(_1071 + 228u) / 4u], vec2(g_MaterialData_1._member0[(_1071 + 232u) / 4u], g_MaterialData_1._member0[(_1071 + 236u) / 4u]), vec2(g_MaterialData_1._member0[(_1071 + 240u) / 4u], g_MaterialData_1._member0[(_1071 + 244u) / 4u]), g_MaterialData_1._member0[(_1071 + 248u) / 4u], g_MaterialData_1._member0[(_1071 + 252u) / 4u], vec2(g_MaterialData_1._member0[(_1071 + 256u) / 4u], g_MaterialData_1._member0[(_1071 + 260u) / 4u]), g_MaterialData_1._member0[(_1071 + 264u) / 4u], g_MaterialData_1._member0[(_1071 + 268u) / 4u], vec4(g_MaterialData_1._member0[(_1071 + 272u) / 4u], g_MaterialData_1._member0[(_1071 + 276u) / 4u], g_MaterialData_1._member0[(_1071 + 280u) / 4u], g_MaterialData_1._member0[(_1071 + 284u) / 4u]), vec4(g_MaterialData_1._member0[(_1071 + 288u) / 4u], g_MaterialData_1._member0[(_1071 + 292u) / 4u], g_MaterialData_1._member0[(_1071 + 296u) / 4u], g_MaterialData_1._member0[(_1071 + 300u) / 4u]), vec4(g_MaterialData_1._member0[(_1071 + 304u) / 4u], g_MaterialData_1._member0[(_1071 + 308u) / 4u], g_MaterialData_1._member0[(_1071 + 312u) / 4u], g_MaterialData_1._member0[(_1071 + 316u) / 4u]), g_MaterialData_1._member0[(_1071 + 320u) / 4u], g_MaterialData_5._member0[(_1071 + 324u) / 4u], vec2(g_MaterialData_1._member0[(_1071 + 328u) / 4u], g_MaterialData_1._member0[(_1071 + 332u) / 4u]), vec2(g_MaterialData_1._member0[(_1071 + 336u) / 4u], g_MaterialData_1._member0[(_1071 + 340u) / 4u]), g_MaterialData_1._member0[(_1071 + 344u) / 4u], g_MaterialData_1._member0[(_1071 + 348u) / 4u], vec2(g_MaterialData_1._member0[(_1071 + 352u) / 4u], g_MaterialData_1._member0[(_1071 + 356u) / 4u]), g_MaterialData_1._member0[(_1071 + 360u) / 4u], g_MaterialData_1._member0[(_1071 + 364u) / 4u], vec4(g_MaterialData_1._member0[(_1071 + 368u) / 4u], g_MaterialData_1._member0[(_1071 + 372u) / 4u], g_MaterialData_1._member0[(_1071 + 376u) / 4u], g_MaterialData_1._member0[(_1071 + 380u) / 4u]), vec4(g_MaterialData_1._member0[(_1071 + 384u) / 4u], g_MaterialData_1._member0[(_1071 + 388u) / 4u], g_MaterialData_1._member0[(_1071 + 392u) / 4u], g_MaterialData_1._member0[(_1071 + 396u) / 4u]), vec4(g_MaterialData_1._member0[(_1071 + 400u) / 4u], g_MaterialData_1._member0[(_1071 + 404u) / 4u], g_MaterialData_1._member0[(_1071 + 408u) / 4u], g_MaterialData_1._member0[(_1071 + 412u) / 4u]), g_MaterialData_1._member0[(_1071 + 416u) / 4u], g_MaterialData_1._member0[(_1071 + 420u) / 4u], g_MaterialData_1._member0[(_1071 + 424u) / 4u], g_MaterialData_7._member0[(_1071 + 428u) / 4u], g_MaterialData_7._member0[(_1071 + 432u) / 4u], g_MaterialData_7._member0[(_1071 + 436u) / 4u], g_MaterialData_1._member0[(_1071 + 440u) / 4u], g_MaterialData_1._member0[(_1071 + 444u) / 4u], g_MaterialData_1._member0[(_1071 + 448u) / 4u], g_MaterialData_1._member0[(_1071 + 452u) / 4u], g_MaterialData_1._member0[(_1071 + 456u) / 4u], g_MaterialData_1._member0[(_1071 + 460u) / 4u], vec3(g_MaterialData_1._member0[(_1071 + 464u) / 4u], g_MaterialData_1._member0[(_1071 + 468u) / 4u], g_MaterialData_1._member0[(_1071 + 472u) / 4u]), g_MaterialData_1._member0[(_1071 + 476u) / 4u], vec3(g_MaterialData_1._member0[(_1071 + 480u) / 4u], g_MaterialData_1._member0[(_1071 + 484u) / 4u], g_MaterialData_1._member0[(_1071 + 488u) / 4u]), g_MaterialData_1._member0[(_1071 + 492u) / 4u], g_MaterialData_1._member0[(_1071 + 496u) / 4u], g_MaterialData_1._member0[(_1071 + 500u) / 4u], g_MaterialData_5._member0[(_1071 + 504u) / 4u], g_MaterialData_3._member0[(_1071 + 508u) / 4u] != 0, g_MaterialData_1._member0[(_1071 + 512u) / 4u], g_MaterialData_1._member0[(_1071 + 516u) / 4u], g_MaterialData_5._member0[(_1071 + 520u) / 4u], g_MaterialData_3._member0[(_1071 + 524u) / 4u] != 0, g_MaterialData_3._member0[(_1071 + 528u) / 4u] != 0, g_MaterialData_1._member0[(_1071 + 532u) / 4u], g_MaterialData_1._member0[(_1071 + 536u) / 4u], g_MaterialData_1._member0[(_1071 + 540u) / 4u], g_MaterialData_3._member0[(_1071 + 544u) / 4u] != 0, g_MaterialData_3._member0[(_1071 + 548u) / 4u] != 0, g_MaterialData_1._member0[(_1071 + 552u) / 4u], g_MaterialData_1._member0[(_1071 + 556u) / 4u], mat4(vec4(g_MaterialData_1._member0[(_1071 + 560u) / 4u], g_MaterialData_1._member0[(_1071 + 576u) / 4u], g_MaterialData_1._member0[(_1071 + 592u) / 4u], g_MaterialData_1._member0[(_1071 + 608u) / 4u]), vec4(g_MaterialData_1._member0[(_1071 + 564u) / 4u], g_MaterialData_1._member0[(_1071 + 580u) / 4u], g_MaterialData_1._member0[(_1071 + 596u) / 4u], g_MaterialData_1._member0[(_1071 + 612u) / 4u]), vec4(g_MaterialData_1._member0[(_1071 + 568u) / 4u], g_MaterialData_1._member0[(_1071 + 584u) / 4u], g_MaterialData_1._member0[(_1071 + 600u) / 4u], g_MaterialData_1._member0[(_1071 + 616u) / 4u]), vec4(g_MaterialData_1._member0[(_1071 + 572u) / 4u], g_MaterialData_1._member0[(_1071 + 588u) / 4u], g_MaterialData_1._member0[(_1071 + 604u) / 4u], g_MaterialData_1._member0[(_1071 + 620u) / 4u])), mat4(vec4(g_MaterialData_1._member0[(_1071 + 624u) / 4u], g_MaterialData_1._member0[(_1071 + 640u) / 4u], g_MaterialData_1._member0[(_1071 + 656u) / 4u], g_MaterialData_1._member0[(_1071 + 672u) / 4u]), vec4(g_MaterialData_1._member0[(_1071 + 628u) / 4u], g_MaterialData_1._member0[(_1071 + 644u) / 4u], g_MaterialData_1._member0[(_1071 + 660u) / 4u], g_MaterialData_1._member0[(_1071 + 676u) / 4u]), vec4(g_MaterialData_1._member0[(_1071 + 632u) / 4u], g_MaterialData_1._member0[(_1071 + 648u) / 4u], g_MaterialData_1._member0[(_1071 + 664u) / 4u], g_MaterialData_1._member0[(_1071 + 680u) / 4u]), vec4(g_MaterialData_1._member0[(_1071 + 636u) / 4u], g_MaterialData_1._member0[(_1071 + 652u) / 4u], g_MaterialData_1._member0[(_1071 + 668u) / 4u], g_MaterialData_1._member0[(_1071 + 684u) / 4u])), g_MaterialData_1._member0[(_1071 + 688u) / 4u], g_MaterialData_1._member0[(_1071 + 692u) / 4u], g_MaterialData_1._member0[(_1071 + 696u) / 4u], g_MaterialData_1._member0[(_1071 + 700u) / 4u], g_MaterialData_1._member0[(_1071 + 704u) / 4u], g_MaterialData_1._member0[(_1071 + 708u) / 4u], g_MaterialData_1._member0[(_1071 + 712u) / 4u], g_MaterialData_1._member0[(_1071 + 716u) / 4u], g_MaterialData_1._member0[(_1071 + 720u) / 4u], g_MaterialData_1._member0[(_1071 + 724u) / 4u], g_MaterialData_1._member0[(_1071 + 728u) / 4u], g_MaterialData_1._member0[(_1071 + 732u) / 4u], g_MaterialData_1._member0[(_1071 + 736u) / 4u], g_MaterialData_1._member0[(_1071 + 740u) / 4u], g_MaterialData_3._member0[(_1071 + 744u) / 4u] != 0, g_MaterialData_1._member0[(_1071 + 748u) / 4u], g_MaterialData_1._member0[(_1071 + 752u) / 4u], g_MaterialData_7._member0[(_1071 + 756u) / 4u], g_MaterialData_7._member0[(_1071 + 760u) / 4u], g_MaterialData_7._member0[(_1071 + 764u) / 4u], vec3(g_MaterialData_1._member0[(_1071 + 768u) / 4u], g_MaterialData_1._member0[(_1071 + 772u) / 4u], g_MaterialData_1._member0[(_1071 + 776u) / 4u]), g_MaterialData_1._member0[(_1071 + 780u) / 4u], vec3(g_MaterialData_1._member0[(_1071 + 784u) / 4u], g_MaterialData_1._member0[(_1071 + 788u) / 4u], g_MaterialData_1._member0[(_1071 + 792u) / 4u]), g_MaterialData_1._member0[(_1071 + 796u) / 4u], g_MaterialData_1._member0[(_1071 + 800u) / 4u], g_MaterialData_1._member0[(_1071 + 804u) / 4u], g_MaterialData_5._member0[(_1071 + 808u) / 4u], g_MaterialData_3._member0[(_1071 + 812u) / 4u] != 0, mat4(vec4(g_MaterialData_1._member0[(_1071 + 816u) / 4u], g_MaterialData_1._member0[(_1071 + 832u) / 4u], g_MaterialData_1._member0[(_1071 + 848u) / 4u], g_MaterialData_1._member0[(_1071 + 864u) / 4u]), vec4(g_MaterialData_1._member0[(_1071 + 820u) / 4u], g_MaterialData_1._member0[(_1071 + 836u) / 4u], g_MaterialData_1._member0[(_1071 + 852u) / 4u], g_MaterialData_1._member0[(_1071 + 868u) / 4u]), vec4(g_MaterialData_1._member0[(_1071 + 824u) / 4u], g_MaterialData_1._member0[(_1071 + 840u) / 4u], g_MaterialData_1._member0[(_1071 + 856u) / 4u], g_MaterialData_1._member0[(_1071 + 872u) / 4u]), vec4(g_MaterialData_1._member0[(_1071 + 828u) / 4u], g_MaterialData_1._member0[(_1071 + 844u) / 4u], g_MaterialData_1._member0[(_1071 + 860u) / 4u], g_MaterialData_1._member0[(_1071 + 876u) / 4u])), mat4(vec4(g_MaterialData_1._member0[(_1071 + 880u) / 4u], g_MaterialData_1._member0[(_1071 + 896u) / 4u], g_MaterialData_1._member0[(_1071 + 912u) / 4u], g_MaterialData_1._member0[(_1071 + 928u) / 4u]), vec4(g_MaterialData_1._member0[(_1071 + 884u) / 4u], g_MaterialData_1._member0[(_1071 + 900u) / 4u], g_MaterialData_1._member0[(_1071 + 916u) / 4u], g_MaterialData_1._member0[(_1071 + 932u) / 4u]), vec4(g_MaterialData_1._member0[(_1071 + 888u) / 4u], g_MaterialData_1._member0[(_1071 + 904u) / 4u], g_MaterialData_1._member0[(_1071 + 920u) / 4u], g_MaterialData_1._member0[(_1071 + 936u) / 4u]), vec4(g_MaterialData_1._member0[(_1071 + 892u) / 4u], g_MaterialData_1._member0[(_1071 + 908u) / 4u], g_MaterialData_1._member0[(_1071 + 924u) / 4u], g_MaterialData_1._member0[(_1071 + 940u) / 4u])), g_MaterialData_1._member0[(_1071 + 944u) / 4u], g_MaterialData_1._member0[(_1071 + 948u) / 4u], g_MaterialData_1._member0[(_1071 + 952u) / 4u], g_MaterialData_1._member0[(_1071 + 956u) / 4u], vec3(g_MaterialData_1._member0[(_1071 + 960u) / 4u], g_MaterialData_1._member0[(_1071 + 964u) / 4u], g_MaterialData_1._member0[(_1071 + 968u) / 4u]), g_MaterialData_1._member0[(_1071 + 972u) / 4u], g_MaterialData_1._member0[(_1071 + 976u) / 4u], g_MaterialData_1._member0[(_1071 + 980u) / 4u], g_MaterialData_5._member0[(_1071 + 984u) / 4u], g_MaterialData_3._member0[(_1071 + 988u) / 4u] != 0, g_MaterialData_3._member0[(_1071 + 992u) / 4u] != 0, g_MaterialData_3._member0[(_1071 + 996u) / 4u] != 0, g_MaterialData_7._member0[(_1071 + 1000u) / 4u], g_MaterialData_1._member0[(_1071 + 1004u) / 4u], g_MaterialData_3._member0[(_1071 + 1008u) / 4u] != 0, g_MaterialData_3._member0[(_1071 + 1012u) / 4u] != 0, g_MaterialData_1._member0[(_1071 + 1016u) / 4u], g_MaterialData_1._member0[(_1071 + 1020u) / 4u], g_MaterialData_1._member0[(_1071 + 1024u) / 4u], g_MaterialData_1._member0[(_1071 + 1028u) / 4u], g_MaterialData_1._member0[(_1071 + 1032u) / 4u], g_MaterialData_1._member0[(_1071 + 1036u) / 4u], vec3(g_MaterialData_1._member0[(_1071 + 1040u) / 4u], g_MaterialData_1._member0[(_1071 + 1044u) / 4u], g_MaterialData_1._member0[(_1071 + 1048u) / 4u]), g_MaterialData_1._member0[(_1071 + 1052u) / 4u], g_MaterialData_1._member0[(_1071 + 1056u) / 4u], g_MaterialData_1._member0[(_1071 + 1060u) / 4u], g_MaterialData_1._member0[(_1071 + 1064u) / 4u], g_MaterialData_1._member0[(_1071 + 1068u) / 4u], g_MaterialData_1._member0[(_1071 + 1072u) / 4u], g_MaterialData_1._member0[(_1071 + 1076u) / 4u], g_MaterialData_1._member0[(_1071 + 1080u) / 4u], g_MaterialData_1._member0[(_1071 + 1084u) / 4u], g_MaterialData_1._member0[(_1071 + 1088u) / 4u], g_MaterialData_5._member0[(_1071 + 1092u) / 4u], g_MaterialData_5._member0[(_1071 + 1096u) / 4u], g_MaterialData_3._member0[(_1071 + 1100u) / 4u] != 0, vec4(g_MaterialData_1._member0[(_1071 + 1104u) / 4u], g_MaterialData_1._member0[(_1071 + 1108u) / 4u], g_MaterialData_1._member0[(_1071 + 1112u) / 4u], g_MaterialData_1._member0[(_1071 + 1116u) / 4u]), vec4(g_MaterialData_1._member0[(_1071 + 1120u) / 4u], g_MaterialData_1._member0[(_1071 + 1124u) / 4u], g_MaterialData_1._member0[(_1071 + 1128u) / 4u], g_MaterialData_1._member0[(_1071 + 1132u) / 4u]), vec2(g_MaterialData_1._member0[(_1071 + 1136u) / 4u], g_MaterialData_1._member0[(_1071 + 1140u) / 4u]), g_MaterialData_1._member0[(_1071 + 1144u) / 4u], g_MaterialData_1._member0[(_1071 + 1148u) / 4u], vec2(g_MaterialData_1._member0[(_1071 + 1152u) / 4u], g_MaterialData_1._member0[(_1071 + 1156u) / 4u]), g_MaterialData_1._member0[(_1071 + 1160u) / 4u], g_MaterialData_1._member0[(_1071 + 1164u) / 4u], vec4(g_MaterialData_1._member0[(_1071 + 1168u) / 4u], g_MaterialData_1._member0[(_1071 + 1172u) / 4u], g_MaterialData_1._member0[(_1071 + 1176u) / 4u], g_MaterialData_1._member0[(_1071 + 1180u) / 4u]), g_MaterialData_1._member0[(_1071 + 1184u) / 4u], g_MaterialData_1._member0[(_1071 + 1188u) / 4u], g_MaterialData_1._member0[(_1071 + 1192u) / 4u], g_MaterialData_1._member0[(_1071 + 1196u) / 4u], vec4(g_MaterialData_1._member0[(_1071 + 1200u) / 4u], g_MaterialData_1._member0[(_1071 + 1204u) / 4u], g_MaterialData_1._member0[(_1071 + 1208u) / 4u], g_MaterialData_1._member0[(_1071 + 1212u) / 4u]), vec2(g_MaterialData_1._member0[(_1071 + 1216u) / 4u], g_MaterialData_1._member0[(_1071 + 1220u) / 4u]), vec2(g_MaterialData_1._member0[(_1071 + 1224u) / 4u], g_MaterialData_1._member0[(_1071 + 1228u) / 4u]), g_MaterialData_1._member0[(_1071 + 1232u) / 4u], g_MaterialData_1._member0[(_1071 + 1236u) / 4u], vec2(g_MaterialData_1._member0[(_1071 + 1240u) / 4u], g_MaterialData_1._member0[(_1071 + 1244u) / 4u]), vec4(g_MaterialData_1._member0[(_1071 + 1248u) / 4u], g_MaterialData_1._member0[(_1071 + 1252u) / 4u], g_MaterialData_1._member0[(_1071 + 1256u) / 4u], g_MaterialData_1._member0[(_1071 + 1260u) / 4u]), vec4(g_MaterialData_1._member0[(_1071 + 1264u) / 4u], g_MaterialData_1._member0[(_1071 + 1268u) / 4u], g_MaterialData_1._member0[(_1071 + 1272u) / 4u], g_MaterialData_1._member0[(_1071 + 1276u) / 4u]), vec2(g_MaterialData_1._member0[(_1071 + 1280u) / 4u], g_MaterialData_1._member0[(_1071 + 1284u) / 4u]), g_MaterialData_5._member0[(_1071 + 1288u) / 4u], g_MaterialData_5._member0[(_1071 + 1292u) / 4u], g_MaterialData_3._member0[(_1071 + 1296u) / 4u] != 0, g_MaterialData_1._member0[(_1071 + 1300u) / 4u], g_MaterialData_1._member0[(_1071 + 1304u) / 4u], g_MaterialData_1._member0[(_1071 + 1308u) / 4u], vec4(g_MaterialData_1._member0[(_1071 + 1312u) / 4u], g_MaterialData_1._member0[(_1071 + 1316u) / 4u], g_MaterialData_1._member0[(_1071 + 1320u) / 4u], g_MaterialData_1._member0[(_1071 + 1324u) / 4u]), vec4(g_MaterialData_1._member0[(_1071 + 1328u) / 4u], g_MaterialData_1._member0[(_1071 + 1332u) / 4u], g_MaterialData_1._member0[(_1071 + 1336u) / 4u], g_MaterialData_1._member0[(_1071 + 1340u) / 4u]), vec3(g_MaterialData_1._member0[(_1071 + 1344u) / 4u], g_MaterialData_1._member0[(_1071 + 1348u) / 4u], g_MaterialData_1._member0[(_1071 + 1352u) / 4u]), g_MaterialData_1._member0[(_1071 + 1356u) / 4u], g_MaterialData_3._member0[(_1071 + 1360u) / 4u] != 0, g_MaterialData_7._member0[(_1071 + 1364u) / 4u], g_MaterialData_7._member0[(_1071 + 1368u) / 4u], g_MaterialData_7._member0[(_1071 + 1372u) / 4u], g_MaterialData_7._member0[(_1071 + 1376u) / 4u], g_MaterialData_7._member0[(_1071 + 1380u) / 4u], g_MaterialData_5._member0[(_1071 + 1384u) / 4u], g_MaterialData_5._member0[(_1071 + 1388u) / 4u], g_MaterialData_7._member0[(_1071 + 1392u) / 4u], g_MaterialData_7._member0[(_1071 + 1396u) / 4u], g_MaterialData_7._member0[(_1071 + 1400u) / 4u], g_MaterialData_3._member0[(_1071 + 1404u) / 4u] != 0, g_MaterialData_3._member0[(_1071 + 1408u) / 4u] != 0, g_MaterialData_3._member0[(_1071 + 1412u) / 4u] != 0, g_MaterialData_1._member0[(_1071 + 1416u) / 4u], g_MaterialData_7._member0[(_1071 + 1420u) / 4u], g_MaterialData_1._member0[(_1071 + 1424u) / 4u], g_MaterialData_1._member0[(_1071 + 1428u) / 4u], g_MaterialData_3._member0[(_1071 + 1432u) / 4u] != 0, g_MaterialData_3._member0[(_1071 + 1436u) / 4u] != 0, g_MaterialData_3._member0[(_1071 + 1440u) / 4u] != 0, g_MaterialData_3._member0[(_1071 + 1444u) / 4u] != 0, g_MaterialData_3._member0[(_1071 + 1448u) / 4u] != 0, g_MaterialData_3._member0[(_1071 + 1452u) / 4u] != 0, g_MaterialData_3._member0[(_1071 + 1456u) / 4u] != 0, g_MaterialData_3._member0[(_1071 + 1460u) / 4u] != 0, g_MaterialData_3._member0[(_1071 + 1464u) / 4u] != 0, g_MaterialData_3._member0[(_1071 + 1468u) / 4u] != 0, g_MaterialData_3._member0[(_1071 + 1472u) / 4u] != 0, g_MaterialData_3._member0[(_1071 + 1476u) / 4u] != 0, g_MaterialData_3._member0[(_1071 + 1480u) / 4u] != 0, g_MaterialData_3._member0[(_1071 + 1484u) / 4u] != 0);
	    _RTX_MATERIAL_DATA_ _g_rtx_material_data_ = _2995;
	    uvec3 _1396;
	    do
	    {
	        if (g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nBufferStrideInBytes.w == 4)
	        {
	            uint _3037 = (12u * uint(gl_PrimitiveID)) + uint(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nBufferBindOffsetBytes.w);
	            _1396 = uvec3(g_Indices_1[nonuniformEXT(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nVertexAndIndexBuffers.w)]._member0[_3037 / 4u], g_Indices_1[nonuniformEXT(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nVertexAndIndexBuffers.w)]._member0[(_3037 + 4u) / 4u], g_Indices_1[nonuniformEXT(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nVertexAndIndexBuffers.w)]._member0[(_3037 + 8u) / 4u]);
	            break;
	        }
	        else
	        {
	            uint _3016 = (6u * uint(gl_PrimitiveID)) + uint(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nBufferBindOffsetBytes.w);
	            uint _3017 = _3016 & 4294967292u;
	            uint _57 = _3017 / 4u;
	            uint _60 = (_3017 + 4u) / 4u;
	            uint _3021 = (g_Indices_1[nonuniformEXT(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nVertexAndIndexBuffers.w)]._member0[_57] & 4294901760u) >> uint(16);
	            uint _3022 = g_Indices_1[nonuniformEXT(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nVertexAndIndexBuffers.w)]._member0[_60] & 65535u;
	            uvec3 _1397;
	            if (_3016 == _3017)
	            {
	                _1397 = uvec3(g_Indices_1[nonuniformEXT(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nVertexAndIndexBuffers.w)]._member0[_57] & 65535u, _3021, _3022);
	            }
	            else
	            {
	                _1397 = uvec3(_3021, _3022, (g_Indices_1[nonuniformEXT(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nVertexAndIndexBuffers.w)]._member0[_60] & 4294901760u) >> uint(16));
	            }
	            _1396 = _1397;
	            break;
	        }
	        break;
	    } while(false);
	    uint _73 = uint(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nVertexAndIndexBuffers.x);
	    uvec3 _3059 = (uvec3(uint(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nBufferStrideInBytes.x)) * _1396) + uvec3(uint(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nBufferBindOffsetBytes.x));
	    vec3 _1390[3];
	    uint _3061 = _3059.x;
	    _1390[0] = vec3(g_Vertices_1[nonuniformEXT(_73)]._member0[_3061 / 4u], g_Vertices_1[nonuniformEXT(_73)]._member0[(_3061 + 4u) / 4u], g_Vertices_1[nonuniformEXT(_73)]._member0[(_3061 + 8u) / 4u]);
	    uint _3066 = _3059.y;
	    _1390[1] = vec3(g_Vertices_1[nonuniformEXT(_73)]._member0[_3066 / 4u], g_Vertices_1[nonuniformEXT(_73)]._member0[(_3066 + 4u) / 4u], g_Vertices_1[nonuniformEXT(_73)]._member0[(_3066 + 8u) / 4u]);
	    uint _3071 = _3059.z;
	    _1390[2] = vec3(g_Vertices_1[nonuniformEXT(_73)]._member0[_3071 / 4u], g_Vertices_1[nonuniformEXT(_73)]._member0[(_3071 + 4u) / 4u], g_Vertices_1[nonuniformEXT(_73)]._member0[(_3071 + 8u) / 4u]);
	    int _1391 = 0;
	    VS_INPUT vsInput[3];
	    for (;;)
	    {
	        if (!(_1391 < 3))
	        {
	            break;
	        }
	        vsInput[_1391].vPositionOs = _1390[_1391];
	        _1391++;
	        continue;
	    }
	    vec2 _1392[3];
	    _1392[0] = vec2(0.0);
	    _1392[1] = vec2(0.0);
	    _1392[2] = vec2(0.0);
	    if (g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vTexCoordFieldInfo.data[0].y != 0)
	    {
	        ivec4 _1389 = g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nVertexAndIndexBuffers;
	        uint _102 = uint(_1389[g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vTexCoordFieldInfo.data[0].z]);
	        uint _3113 = uint(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vTexCoordFieldInfo.data[0].z);
	        ivec4 _1387 = g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nBufferStrideInBytes;
	        ivec4 _1388 = g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nBufferBindOffsetBytes;
	        uvec3 _3129 = (uvec3(uint(_1387[_3113])) * _1396) + uvec3(uint(_1388[_3113]) + uint(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vTexCoordFieldInfo.data[0].x));
	        if (g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vTexCoordFieldInfo.data[0].y == 16)
	        {
	            uint _3243 = _3129.x;
	            _1392[0] = vec2(g_Vertices_1[nonuniformEXT(_102)]._member0[_3243 / 4u], g_Vertices_1[nonuniformEXT(_102)]._member0[(_3243 + 4u) / 4u]);
	            uint _3246 = _3129.y;
	            _1392[1] = vec2(g_Vertices_1[nonuniformEXT(_102)]._member0[_3246 / 4u], g_Vertices_1[nonuniformEXT(_102)]._member0[(_3246 + 4u) / 4u]);
	            uint _3249 = _3129.z;
	            _1392[2] = vec2(g_Vertices_1[nonuniformEXT(_102)]._member0[_3249 / 4u], g_Vertices_1[nonuniformEXT(_102)]._member0[(_3249 + 4u) / 4u]);
	        }
	        else
	        {
	            if (g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vTexCoordFieldInfo.data[0].y == 34)
	            {
	                uint _114 = _3129.x / 4u;
	                _1392[0] = vec2(uint16BitsToFloat16(u16vec2(uvec2(g_Vertices_3[nonuniformEXT(_102)]._member0[_114], g_Vertices_3[nonuniformEXT(_102)]._member0[_114] >> uint(16)) & uvec2(65535u))));
	                uint _117 = _3129.y / 4u;
	                _1392[1] = vec2(uint16BitsToFloat16(u16vec2(uvec2(g_Vertices_3[nonuniformEXT(_102)]._member0[_117], g_Vertices_3[nonuniformEXT(_102)]._member0[_117] >> uint(16)) & uvec2(65535u))));
	                uint _120 = _3129.z / 4u;
	                _1392[2] = vec2(uint16BitsToFloat16(u16vec2(uvec2(g_Vertices_3[nonuniformEXT(_102)]._member0[_120], g_Vertices_3[nonuniformEXT(_102)]._member0[_120] >> uint(16)) & uvec2(65535u))));
	            }
	            else
	            {
	                if (g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vTexCoordFieldInfo.data[0].y == 37)
	                {
	                    uint _104 = _3129.x / 4u;
	                    uint _3142 = g_Vertices_3[nonuniformEXT(_102)]._member0[_104] & 65535u;
	                    int _1386;
	                    if (_3142 > 32767u)
	                    {
	                        _1386 = int(4294901760u | _3142);
	                    }
	                    else
	                    {
	                        _1386 = int(_3142);
	                    }
	                    uint _3155 = (g_Vertices_3[nonuniformEXT(_102)]._member0[_104] & 4294901760u) >> uint(16);
	                    int _1385;
	                    if (_3155 > 32767u)
	                    {
	                        _1385 = int(4294901760u | _3155);
	                    }
	                    else
	                    {
	                        _1385 = int(_3155);
	                    }
	                    _1392[0] = vec2(max(float(_1386) * 3.0518509447574615478515625e-05, -1.0), max(float(_1385) * 3.0518509447574615478515625e-05, -1.0));
	                    uint _107 = _3129.y / 4u;
	                    uint _3169 = g_Vertices_3[nonuniformEXT(_102)]._member0[_107] & 65535u;
	                    int _1384;
	                    if (_3169 > 32767u)
	                    {
	                        _1384 = int(4294901760u | _3169);
	                    }
	                    else
	                    {
	                        _1384 = int(_3169);
	                    }
	                    uint _3182 = (g_Vertices_3[nonuniformEXT(_102)]._member0[_107] & 4294901760u) >> uint(16);
	                    int _1383;
	                    if (_3182 > 32767u)
	                    {
	                        _1383 = int(4294901760u | _3182);
	                    }
	                    else
	                    {
	                        _1383 = int(_3182);
	                    }
	                    _1392[1] = vec2(max(float(_1384) * 3.0518509447574615478515625e-05, -1.0), max(float(_1383) * 3.0518509447574615478515625e-05, -1.0));
	                    uint _110 = _3129.z / 4u;
	                    uint _3196 = g_Vertices_3[nonuniformEXT(_102)]._member0[_110] & 65535u;
	                    int _1382;
	                    if (_3196 > 32767u)
	                    {
	                        _1382 = int(4294901760u | _3196);
	                    }
	                    else
	                    {
	                        _1382 = int(_3196);
	                    }
	                    uint _3209 = (g_Vertices_3[nonuniformEXT(_102)]._member0[_110] & 4294901760u) >> uint(16);
	                    int _1381;
	                    if (_3209 > 32767u)
	                    {
	                        _1381 = int(4294901760u | _3209);
	                    }
	                    else
	                    {
	                        _1381 = int(_3209);
	                    }
	                    _1392[2] = vec2(max(float(_1382) * 3.0518509447574615478515625e-05, -1.0), max(float(_1381) * 3.0518509447574615478515625e-05, -1.0));
	                }
	            }
	        }
	    }
	    _1391 = 0;
	    for (;;)
	    {
	        if (!(_1391 < 3))
	        {
	            break;
	        }
	        vsInput[_1391].vTexCoord = _1392[_1391];
	        _1391++;
	        continue;
	    }
	    _1392[0] = vec2(0.0);
	    _1392[1] = vec2(0.0);
	    _1392[2] = vec2(0.0);
	    if (g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vTexCoordFieldInfo.data[1].y != 0)
	    {
	        ivec4 _1380 = g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nVertexAndIndexBuffers;
	        uint _142 = uint(_1380[g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vTexCoordFieldInfo.data[1].z]);
	        uint _3288 = uint(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vTexCoordFieldInfo.data[1].z);
	        ivec4 _1378 = g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nBufferStrideInBytes;
	        ivec4 _1379 = g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nBufferBindOffsetBytes;
	        uvec3 _3304 = (uvec3(uint(_1378[_3288])) * _1396) + uvec3(uint(_1379[_3288]) + uint(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vTexCoordFieldInfo.data[1].x));
	        if (g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vTexCoordFieldInfo.data[1].y == 16)
	        {
	            uint _3418 = _3304.x;
	            _1392[0] = vec2(g_Vertices_1[nonuniformEXT(_142)]._member0[_3418 / 4u], g_Vertices_1[nonuniformEXT(_142)]._member0[(_3418 + 4u) / 4u]);
	            uint _3421 = _3304.y;
	            _1392[1] = vec2(g_Vertices_1[nonuniformEXT(_142)]._member0[_3421 / 4u], g_Vertices_1[nonuniformEXT(_142)]._member0[(_3421 + 4u) / 4u]);
	            uint _3424 = _3304.z;
	            _1392[2] = vec2(g_Vertices_1[nonuniformEXT(_142)]._member0[_3424 / 4u], g_Vertices_1[nonuniformEXT(_142)]._member0[(_3424 + 4u) / 4u]);
	        }
	        else
	        {
	            if (g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vTexCoordFieldInfo.data[1].y == 34)
	            {
	                uint _154 = _3304.x / 4u;
	                _1392[0] = vec2(uint16BitsToFloat16(u16vec2(uvec2(g_Vertices_3[nonuniformEXT(_142)]._member0[_154], g_Vertices_3[nonuniformEXT(_142)]._member0[_154] >> uint(16)) & uvec2(65535u))));
	                uint _157 = _3304.y / 4u;
	                _1392[1] = vec2(uint16BitsToFloat16(u16vec2(uvec2(g_Vertices_3[nonuniformEXT(_142)]._member0[_157], g_Vertices_3[nonuniformEXT(_142)]._member0[_157] >> uint(16)) & uvec2(65535u))));
	                uint _160 = _3304.z / 4u;
	                _1392[2] = vec2(uint16BitsToFloat16(u16vec2(uvec2(g_Vertices_3[nonuniformEXT(_142)]._member0[_160], g_Vertices_3[nonuniformEXT(_142)]._member0[_160] >> uint(16)) & uvec2(65535u))));
	            }
	            else
	            {
	                if (g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vTexCoordFieldInfo.data[1].y == 37)
	                {
	                    uint _144 = _3304.x / 4u;
	                    uint _3317 = g_Vertices_3[nonuniformEXT(_142)]._member0[_144] & 65535u;
	                    int _1377;
	                    if (_3317 > 32767u)
	                    {
	                        _1377 = int(4294901760u | _3317);
	                    }
	                    else
	                    {
	                        _1377 = int(_3317);
	                    }
	                    uint _3330 = (g_Vertices_3[nonuniformEXT(_142)]._member0[_144] & 4294901760u) >> uint(16);
	                    int _1376;
	                    if (_3330 > 32767u)
	                    {
	                        _1376 = int(4294901760u | _3330);
	                    }
	                    else
	                    {
	                        _1376 = int(_3330);
	                    }
	                    _1392[0] = vec2(max(float(_1377) * 3.0518509447574615478515625e-05, -1.0), max(float(_1376) * 3.0518509447574615478515625e-05, -1.0));
	                    uint _147 = _3304.y / 4u;
	                    uint _3344 = g_Vertices_3[nonuniformEXT(_142)]._member0[_147] & 65535u;
	                    int _1375;
	                    if (_3344 > 32767u)
	                    {
	                        _1375 = int(4294901760u | _3344);
	                    }
	                    else
	                    {
	                        _1375 = int(_3344);
	                    }
	                    uint _3357 = (g_Vertices_3[nonuniformEXT(_142)]._member0[_147] & 4294901760u) >> uint(16);
	                    int _1374;
	                    if (_3357 > 32767u)
	                    {
	                        _1374 = int(4294901760u | _3357);
	                    }
	                    else
	                    {
	                        _1374 = int(_3357);
	                    }
	                    _1392[1] = vec2(max(float(_1375) * 3.0518509447574615478515625e-05, -1.0), max(float(_1374) * 3.0518509447574615478515625e-05, -1.0));
	                    uint _150 = _3304.z / 4u;
	                    uint _3371 = g_Vertices_3[nonuniformEXT(_142)]._member0[_150] & 65535u;
	                    int _1373;
	                    if (_3371 > 32767u)
	                    {
	                        _1373 = int(4294901760u | _3371);
	                    }
	                    else
	                    {
	                        _1373 = int(_3371);
	                    }
	                    uint _3384 = (g_Vertices_3[nonuniformEXT(_142)]._member0[_150] & 4294901760u) >> uint(16);
	                    int _1372;
	                    if (_3384 > 32767u)
	                    {
	                        _1372 = int(4294901760u | _3384);
	                    }
	                    else
	                    {
	                        _1372 = int(_3384);
	                    }
	                    _1392[2] = vec2(max(float(_1373) * 3.0518509447574615478515625e-05, -1.0), max(float(_1372) * 3.0518509447574615478515625e-05, -1.0));
	                }
	            }
	        }
	    }
	    _1391 = 0;
	    for (;;)
	    {
	        if (!(_1391 < 3))
	        {
	            break;
	        }
	        vsInput[_1391].vTexCoord2 = _1392[_1391];
	        _1391++;
	        continue;
	    }
	    vec3 _1393[3];
	    vec4 _1394[3];
	    do
	    {
	        if (g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vNormalFieldInfo.y != 0)
	        {
	            ivec4 _1358 = g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nVertexAndIndexBuffers;
	            uint _182 = uint(_1358[g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vNormalFieldInfo.z]);
	            uint _3468 = uint(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vNormalFieldInfo.z);
	            ivec4 _1356 = g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nBufferStrideInBytes;
	            ivec4 _1357 = g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nBufferBindOffsetBytes;
	            uvec3 _3484 = (uvec3(uint(_1356[_3468])) * _1396) + uvec3(uint(_1357[_3468]) + uint(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vNormalFieldInfo.x));
	            if (g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vNormalFieldInfo.y == 6)
	            {
	                uint _3985 = _3484.x;
	                _1393[0] = vec3(g_Vertices_1[nonuniformEXT(_182)]._member0[_3985 / 4u], g_Vertices_1[nonuniformEXT(_182)]._member0[(_3985 + 4u) / 4u], g_Vertices_1[nonuniformEXT(_182)]._member0[(_3985 + 8u) / 4u]);
	                uint _3990 = _3484.y;
	                _1393[1] = vec3(g_Vertices_1[nonuniformEXT(_182)]._member0[_3990 / 4u], g_Vertices_1[nonuniformEXT(_182)]._member0[(_3990 + 4u) / 4u], g_Vertices_1[nonuniformEXT(_182)]._member0[(_3990 + 8u) / 4u]);
	                uint _3995 = _3484.z;
	                _1393[2] = vec3(g_Vertices_1[nonuniformEXT(_182)]._member0[_3995 / 4u], g_Vertices_1[nonuniformEXT(_182)]._member0[(_3995 + 4u) / 4u], g_Vertices_1[nonuniformEXT(_182)]._member0[(_3995 + 8u) / 4u]);
	            }
	            else
	            {
	                if (g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vNormalFieldInfo.y == 17)
	                {
	                    uint _3739 = _3484.x;
	                    uvec2 _3741 = uvec2(g_Vertices_3[nonuniformEXT(_182)]._member0[_3739 / 4u], g_Vertices_3[nonuniformEXT(_182)]._member0[(_3739 + 4u) / 4u]);
	                    uint _3742 = _3484.y;
	                    uvec2 _1049 = uvec2(g_Vertices_3[nonuniformEXT(_182)]._member0[_3742 / 4u], g_Vertices_3[nonuniformEXT(_182)]._member0[(_3742 + 4u) / 4u]);
	                    uint _3745 = _3484.z;
	                    uvec2 _1048 = uvec2(g_Vertices_3[nonuniformEXT(_182)]._member0[_3745 / 4u], g_Vertices_3[nonuniformEXT(_182)]._member0[(_3745 + 4u) / 4u]);
	                    uint _3751 = _3741.x;
	                    uint _3759 = _3741.y;
	                    vec2 _3769 = ((vec2(float(_3751 & 65535u), float((_3751 >> 16u) & 65535u)) * vec2(1.525902189314365386962890625e-05)) * 2.0) - vec2(1.0);
	                    float _3770 = _3769.x;
	                    float _3775 = (1.0 - abs(_3770)) - abs(_3769.y);
	                    vec3 _3776 = vec3(_3770, _3769.y, _3775);
	                    float _3778 = saturate(-_3775);
	                    vec2 _3784 = _3769 + mix(vec2(_3778), vec2(-_3778), greaterThanEqual(_3769, vec2(0.0)));
	                    _3776.x = _3784.x;
	                    _3776.y = _3784.y;
	                    vec3 _1360 = normalize(_3776);
	                    vec2 _3791 = ((vec2(float((_3759 >> uint(1)) & 32767u), float((_3759 >> 16u) & 32767u)) * vec2(3.0518509447574615478515625e-05)) * 2.0) - vec2(1.0);
	                    float _3792 = _3791.x;
	                    float _3797 = (1.0 - abs(_3792)) - abs(_3791.y);
	                    vec3 _3798 = vec3(_3792, _3791.y, _3797);
	                    float _3800 = saturate(-_3797);
	                    vec2 _3806 = _3791 + mix(vec2(_3800), vec2(-_3800), greaterThanEqual(_3791, vec2(0.0)));
	                    _3798.x = _3806.x;
	                    _3798.y = _3806.y;
	                    vec3 _1359 = normalize(_3798);
	                    float _1346;
	                    if ((_3759 & 1u) != 0u)
	                    {
	                        _1346 = 1.0;
	                    }
	                    else
	                    {
	                        _1346 = -1.0;
	                    }
	                    _1393[0] = _1360;
	                    _1394[0].w = _1346;
	                    _1394[0].x = _1359.x;
	                    _1394[0].y = _1359.y;
	                    _1394[0].z = _1359.z;
	                    vec2 _3848 = ((vec2(float(_1049.x & 65535u), float((_1049.x >> 16u) & 65535u)) * vec2(1.525902189314365386962890625e-05)) * 2.0) - vec2(1.0);
	                    float _3849 = _3848.x;
	                    float _3854 = (1.0 - abs(_3849)) - abs(_3848.y);
	                    vec3 _3855 = vec3(_3849, _3848.y, _3854);
	                    float _3857 = saturate(-_3854);
	                    vec2 _3863 = _3848 + mix(vec2(_3857), vec2(-_3857), greaterThanEqual(_3848, vec2(0.0)));
	                    _3855.x = _3863.x;
	                    _3855.y = _3863.y;
	                    vec3 _1362 = normalize(_3855);
	                    vec2 _3870 = ((vec2(float((_1049.y >> uint(1)) & 32767u), float((_1049.y >> 16u) & 32767u)) * vec2(3.0518509447574615478515625e-05)) * 2.0) - vec2(1.0);
	                    float _3871 = _3870.x;
	                    float _3876 = (1.0 - abs(_3871)) - abs(_3870.y);
	                    vec3 _3877 = vec3(_3871, _3870.y, _3876);
	                    float _3879 = saturate(-_3876);
	                    vec2 _3885 = _3870 + mix(vec2(_3879), vec2(-_3879), greaterThanEqual(_3870, vec2(0.0)));
	                    _3877.x = _3885.x;
	                    _3877.y = _3885.y;
	                    vec3 _1361 = normalize(_3877);
	                    float _1345;
	                    if ((_1049.y & 1u) != 0u)
	                    {
	                        _1345 = 1.0;
	                    }
	                    else
	                    {
	                        _1345 = -1.0;
	                    }
	                    _1393[1] = _1362;
	                    _1394[1].w = _1345;
	                    _1394[1].x = _1361.x;
	                    _1394[1].y = _1361.y;
	                    _1394[1].z = _1361.z;
	                    vec2 _3927 = ((vec2(float(_1048.x & 65535u), float((_1048.x >> 16u) & 65535u)) * vec2(1.525902189314365386962890625e-05)) * 2.0) - vec2(1.0);
	                    float _3928 = _3927.x;
	                    float _3933 = (1.0 - abs(_3928)) - abs(_3927.y);
	                    vec3 _3934 = vec3(_3928, _3927.y, _3933);
	                    float _3936 = saturate(-_3933);
	                    vec2 _3942 = _3927 + mix(vec2(_3936), vec2(-_3936), greaterThanEqual(_3927, vec2(0.0)));
	                    _3934.x = _3942.x;
	                    _3934.y = _3942.y;
	                    vec3 _1364 = normalize(_3934);
	                    vec2 _3949 = ((vec2(float((_1048.y >> uint(1)) & 32767u), float((_1048.y >> 16u) & 32767u)) * vec2(3.0518509447574615478515625e-05)) * 2.0) - vec2(1.0);
	                    float _3950 = _3949.x;
	                    float _3955 = (1.0 - abs(_3950)) - abs(_3949.y);
	                    vec3 _3956 = vec3(_3950, _3949.y, _3955);
	                    float _3958 = saturate(-_3955);
	                    vec2 _3964 = _3949 + mix(vec2(_3958), vec2(-_3958), greaterThanEqual(_3949, vec2(0.0)));
	                    _3956.x = _3964.x;
	                    _3956.y = _3964.y;
	                    vec3 _1363 = normalize(_3956);
	                    float _1344;
	                    if ((_1048.y & 1u) != 0u)
	                    {
	                        _1344 = 1.0;
	                    }
	                    else
	                    {
	                        _1344 = -1.0;
	                    }
	                    _1393[2] = _1364;
	                    _1394[2].w = _1344;
	                    _1394[2].x = _1363.x;
	                    _1394[2].y = _1363.y;
	                    _1394[2].z = _1363.z;
	                    break;
	                }
	                else
	                {
	                    uint _184 = _3484.x / 4u;
	                    vec4 _1366 = _1394[0];
	                    float _3506 = (float((g_Vertices_3[nonuniformEXT(_182)]._member0[_184] >> 12u) & 1023u) * 0.00195503421127796173095703125) - 1.0;
	                    float _3509 = (float((g_Vertices_3[nonuniformEXT(_182)]._member0[_184] >> 22u) & 1023u) * 0.00195503421127796173095703125) - 1.0;
	                    float _3513 = (1.0 - abs(_3506)) - abs(_3509);
	                    vec3 _3514 = vec3(_3506, _3509, _3513);
	                    float _3516 = saturate(-_3513);
	                    vec2 _3517 = vec2(_3506, _3509);
	                    vec2 _3523 = _3517 + mix(vec2(_3516), vec2(-_3516), greaterThanEqual(_3517, vec2(0.0)));
	                    _3514.x = _3523.x;
	                    _3514.y = _3523.y;
	                    vec3 _3528 = normalize(_3514);
	                    vec3 _1365 = _3528;
	                    float _3529 = _3528.z;
	                    float _1353;
	                    if (_3529 >= 0.0)
	                    {
	                        _1353 = 1.0;
	                    }
	                    else
	                    {
	                        _1353 = -1.0;
	                    }
	                    float _3536 = (-1.0) / (_1353 + _3529);
	                    float _3537 = _3528.x;
	                    vec3 _1354;
	                    vec3 _3545 = _1354;
	                    _3545.x = 1.0 + (((_1353 * _3537) * _3537) * _3536);
	                    _3545.y = _1353 * ((_3537 * _3528.y) * _3536);
	                    _3545.z = (-_1353) * _3537;
	                    _1354 = _3545;
	                    float _3553 = float((g_Vertices_3[nonuniformEXT(_182)]._member0[_184] >> uint(1)) & 2047u) * 0.003069460391998291015625;
	                    vec3 _3559 = (_3545 * cos(_3553)) + (cross(_3528, _3545) * sin(_3553));
	                    vec4 _3561 = _1366;
	                    _3561.x = _3559.x;
	                    _3561.y = _3559.y;
	                    _3561.z = _3559.z;
	                    _1366 = _3561;
	                    float _1355;
	                    if ((g_Vertices_3[nonuniformEXT(_182)]._member0[_184] & 1u) == 0u)
	                    {
	                        _1355 = -1.0;
	                    }
	                    else
	                    {
	                        _1355 = 1.0;
	                    }
	                    vec4 _3572 = _1366;
	                    _3572.w = _1355;
	                    _1366 = _3572;
	                    _1393[0] = _1365;
	                    _1394[0] = _3572;
	                    uint _187 = _3484.y / 4u;
	                    vec4 _1368 = _1394[1];
	                    float _3588 = (float((g_Vertices_3[nonuniformEXT(_182)]._member0[_187] >> 12u) & 1023u) * 0.00195503421127796173095703125) - 1.0;
	                    float _3591 = (float((g_Vertices_3[nonuniformEXT(_182)]._member0[_187] >> 22u) & 1023u) * 0.00195503421127796173095703125) - 1.0;
	                    float _3595 = (1.0 - abs(_3588)) - abs(_3591);
	                    vec3 _3596 = vec3(_3588, _3591, _3595);
	                    float _3598 = saturate(-_3595);
	                    vec2 _3599 = vec2(_3588, _3591);
	                    vec2 _3605 = _3599 + mix(vec2(_3598), vec2(-_3598), greaterThanEqual(_3599, vec2(0.0)));
	                    _3596.x = _3605.x;
	                    _3596.y = _3605.y;
	                    vec3 _3610 = normalize(_3596);
	                    vec3 _1367 = _3610;
	                    float _3611 = _3610.z;
	                    float _1350;
	                    if (_3611 >= 0.0)
	                    {
	                        _1350 = 1.0;
	                    }
	                    else
	                    {
	                        _1350 = -1.0;
	                    }
	                    float _3618 = (-1.0) / (_1350 + _3611);
	                    float _3619 = _3610.x;
	                    vec3 _1351;
	                    vec3 _3627 = _1351;
	                    _3627.x = 1.0 + (((_1350 * _3619) * _3619) * _3618);
	                    _3627.y = _1350 * ((_3619 * _3610.y) * _3618);
	                    _3627.z = (-_1350) * _3619;
	                    _1351 = _3627;
	                    float _3635 = float((g_Vertices_3[nonuniformEXT(_182)]._member0[_187] >> uint(1)) & 2047u) * 0.003069460391998291015625;
	                    vec3 _3641 = (_3627 * cos(_3635)) + (cross(_3610, _3627) * sin(_3635));
	                    vec4 _3643 = _1368;
	                    _3643.x = _3641.x;
	                    _3643.y = _3641.y;
	                    _3643.z = _3641.z;
	                    _1368 = _3643;
	                    float _1352;
	                    if ((g_Vertices_3[nonuniformEXT(_182)]._member0[_187] & 1u) == 0u)
	                    {
	                        _1352 = -1.0;
	                    }
	                    else
	                    {
	                        _1352 = 1.0;
	                    }
	                    vec4 _3654 = _1368;
	                    _3654.w = _1352;
	                    _1368 = _3654;
	                    _1393[1] = _1367;
	                    _1394[1] = _3654;
	                    uint _190 = _3484.z / 4u;
	                    vec4 _1370 = _1394[2];
	                    float _3670 = (float((g_Vertices_3[nonuniformEXT(_182)]._member0[_190] >> 12u) & 1023u) * 0.00195503421127796173095703125) - 1.0;
	                    float _3673 = (float((g_Vertices_3[nonuniformEXT(_182)]._member0[_190] >> 22u) & 1023u) * 0.00195503421127796173095703125) - 1.0;
	                    float _3677 = (1.0 - abs(_3670)) - abs(_3673);
	                    vec3 _3678 = vec3(_3670, _3673, _3677);
	                    float _3680 = saturate(-_3677);
	                    vec2 _3681 = vec2(_3670, _3673);
	                    vec2 _3687 = _3681 + mix(vec2(_3680), vec2(-_3680), greaterThanEqual(_3681, vec2(0.0)));
	                    _3678.x = _3687.x;
	                    _3678.y = _3687.y;
	                    vec3 _3692 = normalize(_3678);
	                    vec3 _1369 = _3692;
	                    float _3693 = _3692.z;
	                    float _1347;
	                    if (_3693 >= 0.0)
	                    {
	                        _1347 = 1.0;
	                    }
	                    else
	                    {
	                        _1347 = -1.0;
	                    }
	                    float _3700 = (-1.0) / (_1347 + _3693);
	                    float _3701 = _3692.x;
	                    vec3 _1348;
	                    vec3 _3709 = _1348;
	                    _3709.x = 1.0 + (((_1347 * _3701) * _3701) * _3700);
	                    _3709.y = _1347 * ((_3701 * _3692.y) * _3700);
	                    _3709.z = (-_1347) * _3701;
	                    _1348 = _3709;
	                    float _3717 = float((g_Vertices_3[nonuniformEXT(_182)]._member0[_190] >> uint(1)) & 2047u) * 0.003069460391998291015625;
	                    vec3 _3723 = (_3709 * cos(_3717)) + (cross(_3692, _3709) * sin(_3717));
	                    vec4 _3725 = _1370;
	                    _3725.x = _3723.x;
	                    _3725.y = _3723.y;
	                    _3725.z = _3723.z;
	                    _1370 = _3725;
	                    float _1349;
	                    if ((g_Vertices_3[nonuniformEXT(_182)]._member0[_190] & 1u) == 0u)
	                    {
	                        _1349 = -1.0;
	                    }
	                    else
	                    {
	                        _1349 = 1.0;
	                    }
	                    vec4 _3736 = _1370;
	                    _3736.w = _1349;
	                    _1370 = _3736;
	                    _1393[2] = _1369;
	                    _1394[2] = _3736;
	                    break;
	                }
	                break;
	            }
	        }
	        else
	        {
	            _1393[0] = vec3(0.0);
	            _1393[1] = vec3(0.0);
	            _1393[2] = vec3(0.0);
	        }
	        if (g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vTangentFieldInfo.y != 0)
	        {
	            ivec4 _1371 = g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nVertexAndIndexBuffers;
	            uint _240 = uint(_1371[g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vTangentFieldInfo.z]);
	            uint _4014 = uint(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vTangentFieldInfo.z);
	            ivec4 _1342 = g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nBufferStrideInBytes;
	            ivec4 _1343 = g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nBufferBindOffsetBytes;
	            uvec3 _4030 = (uvec3(uint(_1342[_4014])) * _1396) + uvec3(uint(_1343[_4014]) + uint(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vTangentFieldInfo.x));
	            uint _4032 = _4030.x;
	            _1394[0] = vec4(g_Vertices_1[nonuniformEXT(_240)]._member0[_4032 / 4u], g_Vertices_1[nonuniformEXT(_240)]._member0[(_4032 + 4u) / 4u], g_Vertices_1[nonuniformEXT(_240)]._member0[(_4032 + 8u) / 4u], g_Vertices_1[nonuniformEXT(_240)]._member0[(_4032 + 12u) / 4u]);
	            uint _4038 = _4030.y;
	            _1394[1] = vec4(g_Vertices_1[nonuniformEXT(_240)]._member0[_4038 / 4u], g_Vertices_1[nonuniformEXT(_240)]._member0[(_4038 + 4u) / 4u], g_Vertices_1[nonuniformEXT(_240)]._member0[(_4038 + 8u) / 4u], g_Vertices_1[nonuniformEXT(_240)]._member0[(_4038 + 12u) / 4u]);
	            uint _4044 = _4030.z;
	            _1394[2] = vec4(g_Vertices_1[nonuniformEXT(_240)]._member0[_4044 / 4u], g_Vertices_1[nonuniformEXT(_240)]._member0[(_4044 + 4u) / 4u], g_Vertices_1[nonuniformEXT(_240)]._member0[(_4044 + 8u) / 4u], g_Vertices_1[nonuniformEXT(_240)]._member0[(_4044 + 12u) / 4u]);
	        }
	        else
	        {
	            _1394[0] = vec4(0.0);
	            _1394[1] = vec4(0.0);
	            _1394[2] = vec4(0.0);
	        }
	        break;
	    } while(false);
	    _1391 = 0;
	    for (;;)
	    {
	        if (!(_1391 < 3))
	        {
	            break;
	        }
	        vsInput[_1391].vNormalOs = _1393[_1391];
	        vsInput[_1391].vTangentUOs_flTangentVSign = _1394[_1391];
	        _1391++;
	        continue;
	    }
	    vec4 _1395[3];
	    if (g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vColorFieldInfo.data[0].y != 0)
	    {
	        ivec4 _1341 = g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nVertexAndIndexBuffers;
	        uint _278 = uint(_1341[g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vColorFieldInfo.data[0].z]);
	        uint _4091 = uint(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vColorFieldInfo.data[0].z);
	        ivec4 _1339 = g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nBufferStrideInBytes;
	        ivec4 _1340 = g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nBufferBindOffsetBytes;
	        uvec3 _4107 = (uvec3(uint(_1339[_4091])) * _1396) + uvec3(uint(_1340[_4091]) + uint(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vColorFieldInfo.data[0].x));
	        if (g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vColorFieldInfo.data[0].y == 2)
	        {
	            uint _4149 = _4107.x;
	            _1395[0] = vec4(g_Vertices_1[nonuniformEXT(_278)]._member0[_4149 / 4u], g_Vertices_1[nonuniformEXT(_278)]._member0[(_4149 + 4u) / 4u], g_Vertices_1[nonuniformEXT(_278)]._member0[(_4149 + 8u) / 4u], g_Vertices_1[nonuniformEXT(_278)]._member0[(_4149 + 12u) / 4u]);
	            uint _4155 = _4107.y;
	            _1395[1] = vec4(g_Vertices_1[nonuniformEXT(_278)]._member0[_4155 / 4u], g_Vertices_1[nonuniformEXT(_278)]._member0[(_4155 + 4u) / 4u], g_Vertices_1[nonuniformEXT(_278)]._member0[(_4155 + 8u) / 4u], g_Vertices_1[nonuniformEXT(_278)]._member0[(_4155 + 12u) / 4u]);
	            uint _4161 = _4107.z;
	            _1395[2] = vec4(g_Vertices_1[nonuniformEXT(_278)]._member0[_4161 / 4u], g_Vertices_1[nonuniformEXT(_278)]._member0[(_4161 + 4u) / 4u], g_Vertices_1[nonuniformEXT(_278)]._member0[(_4161 + 8u) / 4u], g_Vertices_1[nonuniformEXT(_278)]._member0[(_4161 + 12u) / 4u]);
	        }
	        else
	        {
	            uint _280 = _4107.x / 4u;
	            _1395[0] = vec4(uvec4(g_Vertices_3[nonuniformEXT(_278)]._member0[_280] & 255u, (g_Vertices_3[nonuniformEXT(_278)]._member0[_280] & 65280u) >> uint(8), (g_Vertices_3[nonuniformEXT(_278)]._member0[_280] & 16711680u) >> uint(16), (g_Vertices_3[nonuniformEXT(_278)]._member0[_280] & 4278190080u) >> uint(24))) * vec4(0.0039215688593685626983642578125);
	            uint _283 = _4107.y / 4u;
	            _1395[1] = vec4(uvec4(g_Vertices_3[nonuniformEXT(_278)]._member0[_283] & 255u, (g_Vertices_3[nonuniformEXT(_278)]._member0[_283] & 65280u) >> uint(8), (g_Vertices_3[nonuniformEXT(_278)]._member0[_283] & 16711680u) >> uint(16), (g_Vertices_3[nonuniformEXT(_278)]._member0[_283] & 4278190080u) >> uint(24))) * vec4(0.0039215688593685626983642578125);
	            uint _286 = _4107.z / 4u;
	            _1395[2] = vec4(uvec4(g_Vertices_3[nonuniformEXT(_278)]._member0[_286] & 255u, (g_Vertices_3[nonuniformEXT(_278)]._member0[_286] & 65280u) >> uint(8), (g_Vertices_3[nonuniformEXT(_278)]._member0[_286] & 16711680u) >> uint(16), (g_Vertices_3[nonuniformEXT(_278)]._member0[_286] & 4278190080u) >> uint(24))) * vec4(0.0039215688593685626983642578125);
	        }
	    }
	    else
	    {
	        _1395[0] = vec4(0.0);
	        _1395[1] = vec4(0.0);
	        _1395[2] = vec4(0.0);
	    }
	    _1391 = 0;
	    for (;;)
	    {
	        if (!(_1391 < 3))
	        {
	            break;
	        }
	        vsInput[_1391].vBlendColorTint = _1395[_1391];
	        _1391++;
	        continue;
	    }
	    vec4 _1398[3];
	    _1398[0] = vec4(0.0);
	    _1398[1] = vec4(0.0);
	    _1398[2] = vec4(0.0);
	    if (g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vTexCoordFieldInfo.data[4].y != 0)
	    {
	        ivec4 _1338 = g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nVertexAndIndexBuffers;
	        uint _326 = uint(_1338[g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vTexCoordFieldInfo.data[4].z]);
	        uint _4204 = uint(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vTexCoordFieldInfo.data[4].z);
	        ivec4 _1336 = g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nBufferStrideInBytes;
	        ivec4 _1337 = g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_nBufferBindOffsetBytes;
	        uvec3 _4220 = (uvec3(uint(_1336[_4204])) * _1396) + uvec3(uint(_1337[_4204]) + uint(g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vTexCoordFieldInfo.data[4].x));
	        if (g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vTexCoordFieldInfo.data[4].y == 2)
	        {
	            uint _4261 = _4220.x;
	            _1398[0] = vec4(g_Vertices_1[nonuniformEXT(_326)]._member0[_4261 / 4u], g_Vertices_1[nonuniformEXT(_326)]._member0[(_4261 + 4u) / 4u], g_Vertices_1[nonuniformEXT(_326)]._member0[(_4261 + 8u) / 4u], g_Vertices_1[nonuniformEXT(_326)]._member0[(_4261 + 12u) / 4u]);
	            uint _4266 = _4220.y;
	            _1398[1] = vec4(g_Vertices_1[nonuniformEXT(_326)]._member0[_4266 / 4u], g_Vertices_1[nonuniformEXT(_326)]._member0[(_4266 + 4u) / 4u], g_Vertices_1[nonuniformEXT(_326)]._member0[(_4266 + 8u) / 4u], g_Vertices_1[nonuniformEXT(_326)]._member0[(_4266 + 12u) / 4u]);
	            uint _4271 = _4220.z;
	            _1398[2] = vec4(g_Vertices_1[nonuniformEXT(_326)]._member0[_4271 / 4u], g_Vertices_1[nonuniformEXT(_326)]._member0[(_4271 + 4u) / 4u], g_Vertices_1[nonuniformEXT(_326)]._member0[(_4271 + 8u) / 4u], g_Vertices_1[nonuniformEXT(_326)]._member0[(_4271 + 12u) / 4u]);
	        }
	        else
	        {
	            if (g_Geometries_1._member0[uint(gl_InstanceCustomIndexEXT)].m_vTexCoordFieldInfo.data[4].y == 28)
	            {
	                uint _328 = _4220.x / 4u;
	                _1398[0] = vec4(uvec4(g_Vertices_3[nonuniformEXT(_326)]._member0[_328] & 255u, (g_Vertices_3[nonuniformEXT(_326)]._member0[_328] & 65280u) >> uint(8), (g_Vertices_3[nonuniformEXT(_326)]._member0[_328] & 16711680u) >> uint(16), (g_Vertices_3[nonuniformEXT(_326)]._member0[_328] & 4278190080u) >> uint(24))) * vec4(0.0039215688593685626983642578125);
	                uint _331 = _4220.y / 4u;
	                _1398[1] = vec4(uvec4(g_Vertices_3[nonuniformEXT(_326)]._member0[_331] & 255u, (g_Vertices_3[nonuniformEXT(_326)]._member0[_331] & 65280u) >> uint(8), (g_Vertices_3[nonuniformEXT(_326)]._member0[_331] & 16711680u) >> uint(16), (g_Vertices_3[nonuniformEXT(_326)]._member0[_331] & 4278190080u) >> uint(24))) * vec4(0.0039215688593685626983642578125);
	                uint _334 = _4220.z / 4u;
	                _1398[2] = vec4(uvec4(g_Vertices_3[nonuniformEXT(_326)]._member0[_334] & 255u, (g_Vertices_3[nonuniformEXT(_326)]._member0[_334] & 65280u) >> uint(8), (g_Vertices_3[nonuniformEXT(_326)]._member0[_334] & 16711680u) >> uint(16), (g_Vertices_3[nonuniformEXT(_326)]._member0[_334] & 4278190080u) >> uint(24))) * vec4(0.0039215688593685626983642578125);
	            }
	        }
	    }
	    int _1399 = 0;
	    for (;;)
	    {
	        if (!(_1399 < 3))
	        {
	            break;
	        }
	        vsInput[_1399].vColorBlendValues = _1398[_1399];
	        _1399++;
	        continue;
	    }
	    vec2 _1070 = vsInput[0].vTexCoord;
	    vec2 _1069 = vsInput[0].vTexCoord2;
	    vec4 _1068 = vsInput[0].vBlendColorTint;
	    vec4 _1067 = vsInput[0].vColorBlendValues;
	    vec3 _1333 = vsInput[0].vNormalOs;
	    vec4 _1334;
	    vec4 _4305 = _1334;
	    _4305.x = vsInput[0].vTangentUOs_flTangentVSign.x;
	    _4305.y = vsInput[0].vTangentUOs_flTangentVSign.y;
	    _4305.z = vsInput[0].vTangentUOs_flTangentVSign.z;
	    _4305.w = vsInput[0].vTangentUOs_flTangentVSign.w;
	    _1334 = _4305;
	    vec4 _4328 = vec4(uvec4(g_instanceBuffer._member0[uint(gl_InstanceID)].nSrgbColor & 255u, (g_instanceBuffer._member0[uint(gl_InstanceID)].nSrgbColor & 65280u) >> uint(8), (g_instanceBuffer._member0[uint(gl_InstanceID)].nSrgbColor & 16711680u) >> uint(16), (g_instanceBuffer._member0[uint(gl_InstanceID)].nSrgbColor & 4278190080u) >> uint(24))) * vec4(0.0039215688593685626983642578125);
	    vec4 _1332 = _4328;
	    vec3 _4329 = _4328.xyz;
	    vec3 _4330 = _4329 * vec3(0.077399380505084991455078125);
	    vec3 _4333 = pow((_4329 * vec3(0.947867333889007568359375)) + vec3(0.052132703363895416259765625), vec3(2.400000095367431640625));
	    float _1329;
	    if (_4328.x <= 0.040449999272823333740234375)
	    {
	        _1329 = _4330.x;
	    }
	    else
	    {
	        _1329 = _4333.x;
	    }
	    float _1330;
	    if (_4328.y <= 0.040449999272823333740234375)
	    {
	        _1330 = _4330.y;
	    }
	    else
	    {
	        _1330 = _4333.y;
	    }
	    float _1331;
	    if (_4328.z <= 0.040449999272823333740234375)
	    {
	        _1331 = _4330.z;
	    }
	    else
	    {
	        _1331 = _4333.z;
	    }
	    vec3 _4358 = vec3(_1329, _1330, _1331);
	    vec4 _4360 = _1332;
	    _4360.x = _4358.x;
	    _4360.y = _4358.y;
	    _4360.z = _4358.z;
	    _1332 = _4360;
	    vec4 _1080;
	    vec4 _4367 = _1080;
	    _4367.x = _4360.x;
	    _4367.y = _4360.y;
	    _4367.z = _4360.z;
	    _4367.w = _4360.w;
	    _1080 = _4367;
	    mat3x4 _4378 = transpose(gl_WorldToObjectEXT);
	    mat3 _1328;
	    mat3 _4381 = _1328;
	    _4381[0] = _4378[0].xyz;
	    _4381[1] = _4378[1].xyz;
	    _4381[2] = _4378[2].xyz;
	    _1328 = _4381;
	    vec3 _4390 = normalize(_4381 * _1333.xyz);
	    vec3 _1081;
	    vec3 _4392 = _1081;
	    _4392.x = _4390.x;
	    _4392.y = _4390.y;
	    _4392.z = _4390.z;
	    _1081 = _4392;
	    mat3x4 _4404 = transpose(gl_WorldToObjectEXT);
	    mat3 _1327;
	    mat3 _4407 = _1327;
	    _4407[0] = _4404[0].xyz;
	    _4407[1] = _4404[1].xyz;
	    _4407[2] = _4404[2].xyz;
	    _1327 = _4407;
	    vec3 _4416 = normalize(_4407 * _1334.xyz);
	    vec4 _1079;
	    vec4 _4418 = _1079;
	    _4418.x = _4416.x;
	    _4418.y = _4416.y;
	    _4418.z = _4416.z;
	    _4418.w = _1334.w;
	    _1079 = _4418;
	    vec4 _4427 = _1070.xyxy;
	    _4427.z = _1069.x;
	    _4427.w = _1069.y;
	    vec4 _1082;
	    vec4 _1083;
	    vec4 _1078 = _1083;
	    vec4 _1077 = _1082;
	    vec3 _1076 = vec4(vsInput[0].vPositionOs.xyz, 1.0) * transpose(gl_ObjectToWorldEXT);
	    vec3 _1075 = _4392;
	    vec4 _1074 = _4427;
	    vec4 _1073 = _4367;
	    vec4 _1072 = _4418;
	    vec2 _1335;
	    if (_g_rtx_material_data_.g_nUVSet1 > 0)
	    {
	        if (_g_rtx_material_data_.g_nUVSet1 == 2)
	        {
	            _1335 = _4427.zw;
	        }
	        else
	        {
	            _1335 = _4427.xy;
	        }
	        vec4 _4450 = _1074;
	        _4450.x = _1335.x;
	        _4450.y = _1335.y;
	        vec4 _4469 = _4450;
	        _4469.x = dot(_4450.xy, _g_rtx_material_data_.g_vTexCoordXform0_1.xy) + _g_rtx_material_data_.g_vTexCoordXform0_1.w;
	        _4469.y = dot(_4450.xy, _g_rtx_material_data_.g_vTexCoordXform1_1.xy) + _g_rtx_material_data_.g_vTexCoordXform1_1.w;
	        _1074 = _4469;
	    }
	    if (_g_rtx_material_data_.g_nUVSet2 > 0)
	    {
	        if (_g_rtx_material_data_.g_nUVSet2 == 2)
	        {
	            _1335 = _4427.zw;
	        }
	        else
	        {
	            _1335 = _4427.xy;
	        }
	        vec4 _4485 = _1074;
	        _4485.z = _1335.x;
	        _4485.w = _1335.y;
	        vec4 _4504 = _4485;
	        _4504.z = dot(_4485.zw, _g_rtx_material_data_.g_vTexCoordXform0_2.xy) + _g_rtx_material_data_.g_vTexCoordXform0_2.w;
	        _4504.w = dot(_4485.zw, _g_rtx_material_data_.g_vTexCoordXform1_2.xy) + _g_rtx_material_data_.g_vTexCoordXform1_2.w;
	        _1074 = _4504;
	    }
	    vec4 _4507 = _1073;
	    vec4 _4509 = _1077;
	    _4509.x = _4507.x;
	    _4509.y = _4507.y;
	    _4509.z = _4507.z;
	    _4509.w = _g_rtx_material_data_.g_flModelTintAmount * (1.0 - min(_4509.x, min(_4509.y, _4509.z)));
	    _1077 = _4509;
	    _4507.x = _g_rtx_material_data_.g_vColorTint.x;
	    _4507.y = _g_rtx_material_data_.g_vColorTint.y;
	    _4507.z = _g_rtx_material_data_.g_vColorTint.z;
	    vec3 _4538 = _4507.xyz * mix(vec3(1.0), _1068.xyz, vec3(_1068.w));
	    vec4 _4540 = _4507;
	    _4540.x = _4538.x;
	    _4540.y = _4538.y;
	    _4540.z = _4538.z;
	    _1073 = _4540;
	    vec4 _4547 = _1078;
	    _4547.x = _1067.x;
	    _4547.y = _1067.y;
	    _4547.z = _1067.z;
	    _4547.w = _1067.w;
	    _1078 = _4547;
	    vec4 _1047 = _4547;
	    vec4 _1046 = _4509;
	    vec3 _1045 = _1076;
	    vec3 _1044 = _1075;
	    vec4 _1043 = _1074;
	    vec4 _1042 = _4540;
	    vec4 _1041 = _1072;
	    vec2 _1066 = vsInput[1].vTexCoord;
	    vec2 _1065 = vsInput[1].vTexCoord2;
	    vec4 _1064 = vsInput[1].vBlendColorTint;
	    vec4 _1063 = vsInput[1].vColorBlendValues;
	    vec3 _1324 = vsInput[1].vNormalOs;
	    vec4 _1325;
	    vec4 _4569 = _1325;
	    _4569.x = vsInput[1].vTangentUOs_flTangentVSign.x;
	    _4569.y = vsInput[1].vTangentUOs_flTangentVSign.y;
	    _4569.z = vsInput[1].vTangentUOs_flTangentVSign.z;
	    _4569.w = vsInput[1].vTangentUOs_flTangentVSign.w;
	    _1325 = _4569;
	    vec4 _4592 = vec4(uvec4(g_instanceBuffer._member0[uint(gl_InstanceID)].nSrgbColor & 255u, (g_instanceBuffer._member0[uint(gl_InstanceID)].nSrgbColor & 65280u) >> uint(8), (g_instanceBuffer._member0[uint(gl_InstanceID)].nSrgbColor & 16711680u) >> uint(16), (g_instanceBuffer._member0[uint(gl_InstanceID)].nSrgbColor & 4278190080u) >> uint(24))) * vec4(0.0039215688593685626983642578125);
	    vec4 _1323 = _4592;
	    vec3 _4593 = _4592.xyz;
	    vec3 _4594 = _4593 * vec3(0.077399380505084991455078125);
	    vec3 _4597 = pow((_4593 * vec3(0.947867333889007568359375)) + vec3(0.052132703363895416259765625), vec3(2.400000095367431640625));
	    float _1320;
	    if (_4592.x <= 0.040449999272823333740234375)
	    {
	        _1320 = _4594.x;
	    }
	    else
	    {
	        _1320 = _4597.x;
	    }
	    float _1321;
	    if (_4592.y <= 0.040449999272823333740234375)
	    {
	        _1321 = _4594.y;
	    }
	    else
	    {
	        _1321 = _4597.y;
	    }
	    float _1322;
	    if (_4592.z <= 0.040449999272823333740234375)
	    {
	        _1322 = _4594.z;
	    }
	    else
	    {
	        _1322 = _4597.z;
	    }
	    vec3 _4622 = vec3(_1320, _1321, _1322);
	    vec4 _4624 = _1323;
	    _4624.x = _4622.x;
	    _4624.y = _4622.y;
	    _4624.z = _4622.z;
	    _1323 = _4624;
	    vec4 _1092;
	    vec4 _4631 = _1092;
	    _4631.x = _4624.x;
	    _4631.y = _4624.y;
	    _4631.z = _4624.z;
	    _4631.w = _4624.w;
	    _1092 = _4631;
	    mat3x4 _4642 = transpose(gl_WorldToObjectEXT);
	    mat3 _1319;
	    mat3 _4645 = _1319;
	    _4645[0] = _4642[0].xyz;
	    _4645[1] = _4642[1].xyz;
	    _4645[2] = _4642[2].xyz;
	    _1319 = _4645;
	    vec3 _4654 = normalize(_4645 * _1324.xyz);
	    vec3 _1093;
	    vec3 _4656 = _1093;
	    _4656.x = _4654.x;
	    _4656.y = _4654.y;
	    _4656.z = _4654.z;
	    _1093 = _4656;
	    mat3x4 _4668 = transpose(gl_WorldToObjectEXT);
	    mat3 _1318;
	    mat3 _4671 = _1318;
	    _4671[0] = _4668[0].xyz;
	    _4671[1] = _4668[1].xyz;
	    _4671[2] = _4668[2].xyz;
	    _1318 = _4671;
	    vec3 _4680 = normalize(_4671 * _1325.xyz);
	    vec4 _1091;
	    vec4 _4682 = _1091;
	    _4682.x = _4680.x;
	    _4682.y = _4680.y;
	    _4682.z = _4680.z;
	    _4682.w = _1325.w;
	    _1091 = _4682;
	    vec4 _4691 = _1066.xyxy;
	    _4691.z = _1065.x;
	    _4691.w = _1065.y;
	    vec4 _1094;
	    vec4 _1095;
	    vec4 _1090 = _1095;
	    vec4 _1089 = _1094;
	    vec3 _1088 = vec4(vsInput[1].vPositionOs.xyz, 1.0) * transpose(gl_ObjectToWorldEXT);
	    vec3 _1087 = _4656;
	    vec4 _1086 = _4691;
	    vec4 _1085 = _4631;
	    vec4 _1084 = _4682;
	    vec2 _1326;
	    if (_g_rtx_material_data_.g_nUVSet1 > 0)
	    {
	        if (_g_rtx_material_data_.g_nUVSet1 == 2)
	        {
	            _1326 = _4691.zw;
	        }
	        else
	        {
	            _1326 = _4691.xy;
	        }
	        vec4 _4714 = _1086;
	        _4714.x = _1326.x;
	        _4714.y = _1326.y;
	        vec4 _4733 = _4714;
	        _4733.x = dot(_4714.xy, _g_rtx_material_data_.g_vTexCoordXform0_1.xy) + _g_rtx_material_data_.g_vTexCoordXform0_1.w;
	        _4733.y = dot(_4714.xy, _g_rtx_material_data_.g_vTexCoordXform1_1.xy) + _g_rtx_material_data_.g_vTexCoordXform1_1.w;
	        _1086 = _4733;
	    }
	    if (_g_rtx_material_data_.g_nUVSet2 > 0)
	    {
	        if (_g_rtx_material_data_.g_nUVSet2 == 2)
	        {
	            _1326 = _4691.zw;
	        }
	        else
	        {
	            _1326 = _4691.xy;
	        }
	        vec4 _4749 = _1086;
	        _4749.z = _1326.x;
	        _4749.w = _1326.y;
	        vec4 _4768 = _4749;
	        _4768.z = dot(_4749.zw, _g_rtx_material_data_.g_vTexCoordXform0_2.xy) + _g_rtx_material_data_.g_vTexCoordXform0_2.w;
	        _4768.w = dot(_4749.zw, _g_rtx_material_data_.g_vTexCoordXform1_2.xy) + _g_rtx_material_data_.g_vTexCoordXform1_2.w;
	        _1086 = _4768;
	    }
	    vec4 _4771 = _1085;
	    vec4 _4773 = _1089;
	    _4773.x = _4771.x;
	    _4773.y = _4771.y;
	    _4773.z = _4771.z;
	    _4773.w = _g_rtx_material_data_.g_flModelTintAmount * (1.0 - min(_4773.x, min(_4773.y, _4773.z)));
	    _1089 = _4773;
	    _4771.x = _g_rtx_material_data_.g_vColorTint.x;
	    _4771.y = _g_rtx_material_data_.g_vColorTint.y;
	    _4771.z = _g_rtx_material_data_.g_vColorTint.z;
	    vec3 _4802 = _4771.xyz * mix(vec3(1.0), _1064.xyz, vec3(_1064.w));
	    vec4 _4804 = _4771;
	    _4804.x = _4802.x;
	    _4804.y = _4802.y;
	    _4804.z = _4802.z;
	    _1085 = _4804;
	    vec4 _4811 = _1090;
	    _4811.x = _1063.x;
	    _4811.y = _1063.y;
	    _4811.z = _1063.z;
	    _4811.w = _1063.w;
	    _1090 = _4811;
	    vec4 _1040 = _4811;
	    vec4 _1039 = _4773;
	    vec3 _1038 = _1088;
	    vec3 _1037 = _1087;
	    vec4 _1036 = _1086;
	    vec4 _1035 = _4804;
	    vec4 _1034 = _1084;
	    vec2 _1062 = vsInput[2].vTexCoord;
	    vec2 _1061 = vsInput[2].vTexCoord2;
	    vec4 _1060 = vsInput[2].vBlendColorTint;
	    vec4 _1059 = vsInput[2].vColorBlendValues;
	    vec3 _1315 = vsInput[2].vNormalOs;
	    vec4 _1316;
	    vec4 _4833 = _1316;
	    _4833.x = vsInput[2].vTangentUOs_flTangentVSign.x;
	    _4833.y = vsInput[2].vTangentUOs_flTangentVSign.y;
	    _4833.z = vsInput[2].vTangentUOs_flTangentVSign.z;
	    _4833.w = vsInput[2].vTangentUOs_flTangentVSign.w;
	    _1316 = _4833;
	    vec4 _4856 = vec4(uvec4(g_instanceBuffer._member0[uint(gl_InstanceID)].nSrgbColor & 255u, (g_instanceBuffer._member0[uint(gl_InstanceID)].nSrgbColor & 65280u) >> uint(8), (g_instanceBuffer._member0[uint(gl_InstanceID)].nSrgbColor & 16711680u) >> uint(16), (g_instanceBuffer._member0[uint(gl_InstanceID)].nSrgbColor & 4278190080u) >> uint(24))) * vec4(0.0039215688593685626983642578125);
	    vec4 _1314 = _4856;
	    vec3 _4857 = _4856.xyz;
	    vec3 _4858 = _4857 * vec3(0.077399380505084991455078125);
	    vec3 _4861 = pow((_4857 * vec3(0.947867333889007568359375)) + vec3(0.052132703363895416259765625), vec3(2.400000095367431640625));
	    float _1311;
	    if (_4856.x <= 0.040449999272823333740234375)
	    {
	        _1311 = _4858.x;
	    }
	    else
	    {
	        _1311 = _4861.x;
	    }
	    float _1312;
	    if (_4856.y <= 0.040449999272823333740234375)
	    {
	        _1312 = _4858.y;
	    }
	    else
	    {
	        _1312 = _4861.y;
	    }
	    float _1313;
	    if (_4856.z <= 0.040449999272823333740234375)
	    {
	        _1313 = _4858.z;
	    }
	    else
	    {
	        _1313 = _4861.z;
	    }
	    vec3 _4886 = vec3(_1311, _1312, _1313);
	    vec4 _4888 = _1314;
	    _4888.x = _4886.x;
	    _4888.y = _4886.y;
	    _4888.z = _4886.z;
	    _1314 = _4888;
	    vec4 _1104;
	    vec4 _4895 = _1104;
	    _4895.x = _4888.x;
	    _4895.y = _4888.y;
	    _4895.z = _4888.z;
	    _4895.w = _4888.w;
	    _1104 = _4895;
	    mat3x4 _4906 = transpose(gl_WorldToObjectEXT);
	    mat3 _1310;
	    mat3 _4909 = _1310;
	    _4909[0] = _4906[0].xyz;
	    _4909[1] = _4906[1].xyz;
	    _4909[2] = _4906[2].xyz;
	    _1310 = _4909;
	    vec3 _4918 = normalize(_4909 * _1315.xyz);
	    vec3 _1105;
	    vec3 _4920 = _1105;
	    _4920.x = _4918.x;
	    _4920.y = _4918.y;
	    _4920.z = _4918.z;
	    _1105 = _4920;
	    mat3x4 _4932 = transpose(gl_WorldToObjectEXT);
	    mat3 _1309;
	    mat3 _4935 = _1309;
	    _4935[0] = _4932[0].xyz;
	    _4935[1] = _4932[1].xyz;
	    _4935[2] = _4932[2].xyz;
	    _1309 = _4935;
	    vec3 _4944 = normalize(_4935 * _1316.xyz);
	    vec4 _1103;
	    vec4 _4946 = _1103;
	    _4946.x = _4944.x;
	    _4946.y = _4944.y;
	    _4946.z = _4944.z;
	    _4946.w = _1316.w;
	    _1103 = _4946;
	    vec4 _4955 = _1062.xyxy;
	    _4955.z = _1061.x;
	    _4955.w = _1061.y;
	    vec4 _1106;
	    vec4 _1107;
	    vec4 _1102 = _1107;
	    vec4 _1101 = _1106;
	    vec3 _1100 = vec4(vsInput[2].vPositionOs.xyz, 1.0) * transpose(gl_ObjectToWorldEXT);
	    vec3 _1099 = _4920;
	    vec4 _1098 = _4955;
	    vec4 _1097 = _4895;
	    vec4 _1096 = _4946;
	    vec2 _1317;
	    if (_g_rtx_material_data_.g_nUVSet1 > 0)
	    {
	        if (_g_rtx_material_data_.g_nUVSet1 == 2)
	        {
	            _1317 = _4955.zw;
	        }
	        else
	        {
	            _1317 = _4955.xy;
	        }
	        vec4 _4978 = _1098;
	        _4978.x = _1317.x;
	        _4978.y = _1317.y;
	        vec4 _4997 = _4978;
	        _4997.x = dot(_4978.xy, _g_rtx_material_data_.g_vTexCoordXform0_1.xy) + _g_rtx_material_data_.g_vTexCoordXform0_1.w;
	        _4997.y = dot(_4978.xy, _g_rtx_material_data_.g_vTexCoordXform1_1.xy) + _g_rtx_material_data_.g_vTexCoordXform1_1.w;
	        _1098 = _4997;
	    }
	    if (_g_rtx_material_data_.g_nUVSet2 > 0)
	    {
	        if (_g_rtx_material_data_.g_nUVSet2 == 2)
	        {
	            _1317 = _4955.zw;
	        }
	        else
	        {
	            _1317 = _4955.xy;
	        }
	        vec4 _5013 = _1098;
	        _5013.z = _1317.x;
	        _5013.w = _1317.y;
	        vec4 _5032 = _5013;
	        _5032.z = dot(_5013.zw, _g_rtx_material_data_.g_vTexCoordXform0_2.xy) + _g_rtx_material_data_.g_vTexCoordXform0_2.w;
	        _5032.w = dot(_5013.zw, _g_rtx_material_data_.g_vTexCoordXform1_2.xy) + _g_rtx_material_data_.g_vTexCoordXform1_2.w;
	        _1098 = _5032;
	    }
	    vec4 _5035 = _1097;
	    vec4 _5037 = _1101;
	    _5037.x = _5035.x;
	    _5037.y = _5035.y;
	    _5037.z = _5035.z;
	    _5037.w = _g_rtx_material_data_.g_flModelTintAmount * (1.0 - min(_5037.x, min(_5037.y, _5037.z)));
	    _1101 = _5037;
	    _5035.x = _g_rtx_material_data_.g_vColorTint.x;
	    _5035.y = _g_rtx_material_data_.g_vColorTint.y;
	    _5035.z = _g_rtx_material_data_.g_vColorTint.z;
	    vec3 _5066 = _5035.xyz * mix(vec3(1.0), _1060.xyz, vec3(_1060.w));
	    vec4 _5068 = _5035;
	    _5068.x = _5066.x;
	    _5068.y = _5066.y;
	    _5068.z = _5066.z;
	    _1097 = _5068;
	    vec4 _5075 = _1102;
	    _5075.x = _1059.x;
	    _5075.y = _1059.y;
	    _5075.z = _1059.z;
	    _5075.w = _1059.w;
	    _1102 = _5075;
	    vec3 _1033 = _1100;
	    vec3 _1032 = _1099;
	    vec3 _5111 = ((_1044 * ((1.0 - attrs.barycentrics.x) - attrs.barycentrics.y)) + (_1037 * attrs.barycentrics.x)) + (_1099 * attrs.barycentrics.y);
	    bool _5117 = gl_HitKindEXT == 254u;
	    vec3 _1108;
	    vec4 _5154 = ((_1047 * ((1.0 - attrs.barycentrics.x) - attrs.barycentrics.y)) + (_1040 * attrs.barycentrics.x)) + (_5075 * attrs.barycentrics.y);
	    vec4 _1058 = _5154;
	    vec4 _1057 = ((_1046 * ((1.0 - attrs.barycentrics.x) - attrs.barycentrics.y)) + (_1039 * attrs.barycentrics.x)) + (_5037 * attrs.barycentrics.y);
	    vec3 _1056 = _5111;
	    vec4 _1055 = ((_1043 * ((1.0 - attrs.barycentrics.x) - attrs.barycentrics.y)) + (_1036 * attrs.barycentrics.x)) + (_1098 * attrs.barycentrics.y);
	    vec4 _1054 = ((_1042 * ((1.0 - attrs.barycentrics.x) - attrs.barycentrics.y)) + (_1035 * attrs.barycentrics.x)) + (_5068 * attrs.barycentrics.y);
	    vec4 _1053 = ((_1041 * ((1.0 - attrs.barycentrics.x) - attrs.barycentrics.y)) + (_1034 * attrs.barycentrics.x)) + (_1096 * attrs.barycentrics.y);
	    bool _1052 = _5117;
	    float _1293 = saturate((_5154.x * 1.10000002384185791015625) - 0.0500000007450580596923828125);
	    vec3 _1172 = _1108;
	    vec3 _1171 = normalize(cross(_1038 - _1045, _1100 - _1045));
	    bool _1170 = _5117;
	    vec3 _1197 = vec3(0.5);
	    vec2 _1196 = vec2(0.5);
	    float _1195 = 0.0;
	    float _1194 = 1.0;
	    vec3 _1193 = vec3(0.0);
	    float _1192 = 0.039999999105930328369140625;
	    vec3 _1191 = vec3(0.0);
	    float _1190 = 0.0;
	    vec3 _1189 = vec3(0.0);
	    vec3 _1187 = vec3(1.0);
	    bool _1186 = false;
	    vec3 _5168 = _5111.xyz;
	    vec3 _1188 = _5168;
	    if (dot(_5168, _5168) >= 1.0099999904632568359375)
	    {
	        _1188 = _1172.xyz;
	    }
	    _1192 = _g_rtx_material_data_.g_flReflectance;
	    _1187 = _1171;
	    bool _1291;
	    if (_g_rtx_material_data_.g_bRenderBackfaceNormals)
	    {
	        _1291 = !_g_rtx_material_data_.g_bDontFlipBackfaceNormals;
	    }
	    else
	    {
	        _1291 = false;
	    }
	    SPIRV_CROSS_BRANCH
	    if (_1291)
	    {
	        float _1292;
	        if (_1170)
	        {
	            _1292 = 1.0;
	        }
	        else
	        {
	            _1292 = -1.0;
	        }
	        _1188 *= _1292;
	        if (_1170)
	        {
	            _1292 = 1.0;
	        }
	        else
	        {
	            _1292 = -1.0;
	        }
	        _1187 *= _1292;
	        _1186 = !_1170;
	    }
	    vec3 _5202 = _1188;
	    vec3 _5203 = normalize(_5202);
	    _1188 = _5203;
	    vec3 _1185 = _5203;
	    vec3 _1184 = _1197;
	    vec2 _1183 = _1196;
	    float _1182 = _1195;
	    float _1181 = _1194;
	    vec3 _1180 = _1193;
	    float _1179 = _1192;
	    vec3 _1178 = _1191;
	    float _1177 = _1190;
	    vec3 _1176 = _1189;
	    vec3 _1175 = _5203;
	    vec3 _1174 = _1187;
	    bool _1173 = _1186;
	    vec2 _1169 = vec2(0.0);
	    vec2 _1168 = vec2(0.0);
	    vec2 _1167 = vec2(0.0);
	    vec2 _1166 = vec2(0.0);
	    vec2 _1165 = vec2(0.0);
	    vec2 _1164 = vec2(0.0);
	    vec2 _1163 = vec2(0.0);
	    ivec2 _1162 = ivec2(0);
	    ivec2 _1161 = ivec2(0);
	    if (_g_rtx_material_data_.bBiplanarUsedAny)
	    {
	        vec3 _5221 = abs(_1175);
	        vec3 _1286 = _5221;
	        float _5222 = _5221.x;
	        float _5223 = _5221.y;
	        bool _1287;
	        if (_5222 > _5223)
	        {
	            _1287 = _5222 > _5221.z;
	        }
	        else
	        {
	            _1287 = false;
	        }
	        ivec3 _1288;
	        if (_1287)
	        {
	            _1288 = ivec3(0, 1, 2);
	        }
	        else
	        {
	            if (_5223 > _5221.z)
	            {
	                _1288 = ivec3(1, 2, 0);
	            }
	            else
	            {
	                _1288 = ivec3(2, 0, 1);
	            }
	        }
	        if (_5222 < _5223)
	        {
	            _1287 = _5222 < _5221.z;
	        }
	        else
	        {
	            _1287 = false;
	        }
	        ivec3 _1289;
	        if (_1287)
	        {
	            _1289 = ivec3(0, 1, 2);
	        }
	        else
	        {
	            if (_5223 < _5221.z)
	            {
	                _1289 = ivec3(1, 2, 0);
	            }
	            else
	            {
	                _1289 = ivec3(2, 0, 1);
	            }
	        }
	        ivec3 _5257 = (ivec3(3) - _1289) - _1288;
	        ivec2 _1290;
	        if (_1288.x == 1)
	        {
	            _1290 = _1288.zy;
	        }
	        else
	        {
	            _1290 = _1288.yz;
	        }
	        ivec2 _5269 = _1162;
	        _5269.x = _1290.x;
	        _5269.y = _1290.y;
	        _1162 = _5269;
	        int _5273 = _5257.x;
	        if (_5273 == 1)
	        {
	            _1290 = _5257.zy;
	        }
	        else
	        {
	            _1290 = _5257.yz;
	        }
	        ivec2 _5282 = _1161;
	        _5282.x = _1290.x;
	        _5282.y = _1290.y;
	        _1161 = _5282;
	        vec2 _5293 = saturate((vec2(_1286[_1288.x], _1286[_5273]) - vec2(0.577300012111663818359375)) * vec2(2.365744113922119140625));
	        _1163 = _5293 / vec2(_5293.x + _5293.y);
	        vec3 _1277 = _1176 * _g_rtx_material_data_.g_vBiplanarTexCoordScale.xyz;
	        _1169 = vec2(_1277[_1162.x], _1277[_1162.y]);
	        vec3 _1278 = vec3(0.0);
	        vec3 _1279 = vec3(0.0);
	        _1167 = vec2(_1278[_1162.x], _1279[_1162.y]);
	        vec3 _1280 = vec3(0.0);
	        vec3 _1281 = vec3(0.0);
	        _1166 = vec2(_1280[_1162.x], _1281[_1162.y]);
	        _1168 = vec2(_1277[_5282.x], _1277[_5282.y]);
	        vec3 _1282 = vec3(0.0);
	        vec3 _1283 = vec3(0.0);
	        _1165 = vec2(_1282[_5282.x], _1283[_5282.y]);
	        vec3 _1284 = vec3(0.0);
	        vec3 _1285 = vec3(0.0);
	        _1164 = vec2(_1284[_5282.x], _1285[_5282.y]);
	    }
	    bool _1294;
	    if (_g_rtx_material_data_.g_nUVSet2 > 1)
	    {
	        _1294 = true;
	    }
	    else
	    {
	        _1294 = _g_rtx_material_data_.g_nUVSet1 > 1;
	    }
	    bool _1160 = _1052;
	    bool _1275;
	    if (_g_rtx_material_data_.g_bRenderBackfaceNormals)
	    {
	        _1275 = !_g_rtx_material_data_.g_bDontFlipBackfaceNormals;
	    }
	    else
	    {
	        _1275 = false;
	    }
	    if (_1275)
	    {
	        float _1276;
	        if (_1160)
	        {
	            _1276 = 1.0;
	        }
	        else
	        {
	            _1276 = -1.0;
	        }
	        _1275 = _1276 < 0.0;
	    }
	    else
	    {
	        _1275 = false;
	    }
	    vec3 _1201 = vec3(0.0);
	    vec3 _1200 = vec3(0.0);
	    float _1273;
	    if (_1053.w > 0.0)
	    {
	        _1273 = 1.0;
	    }
	    else
	    {
	        _1273 = -1.0;
	    }
	    float _5389 = 1.0 / length(_1056);
	    vec3 _1202 = _1056 * _5389;
	    vec3 _1051 = _1053.xyz * _5389;
	    vec3 _1050 = (cross(_1056, _1053.xyz) * _1273) * _5389;
	    if (_1275)
	    {
	        _1202 *= (-1.0);
	    }
	    vec3 _1199 = _1201 - (_1202 * dot(_1201, _1202));
	    vec3 _1198 = _1200 - (_1202 * dot(_1200, _1202));
	    int _1274;
	    if (dot(_1200, cross(_1202, _1201)) < 0.0)
	    {
	        _1274 = -1;
	    }
	    else
	    {
	        _1274 = 1;
	    }
	    vec3 _1243 = _1202;
	    vec3 _1242 = _1199;
	    vec3 _1241 = _1198;
	    float _1240 = float(_1274);
	    vec3 _1158;
	    vec3 _1159;
	    if (_1294)
	    {
	        float _1272;
	        if (false)
	        {
	            _1272 = -1.0;
	        }
	        else
	        {
	            _1272 = 1.0;
	        }
	        vec2 _5427 = vec2(0.0, -0.0) * _1272;
	        vec3 _1203 = (_1242 * _5427.x) + (_1241 * _5427.y);
	        float _5435 = abs(0.0);
	        if (_5435 > 0.0)
	        {
	            _1203 = normalize(_1203);
	        }
	        _1159 = _1203;
	        _1158 = cross(_1243, _1203) * (_1272 * _1240);
	    }
	    else
	    {
	        _1159 = vec3(0.0);
	        _1158 = vec3(0.0);
	    }
	    float _1295 = 0.0;
	    float _1297 = max(min(_1058.w + _g_rtx_material_data_.g_flBlendSoftness2, 1.0), 9.9999997473787516355514526367188e-05);
	    vec3 _1298 = vec3(0.0);
	    float _1299 = _g_rtx_material_data_.g_flHeightMapZeroPoint1;
	    float _1300 = _g_rtx_material_data_.g_flHeightMapScale1;
	    vec2 _1301 = vec2(0.0);
	    vec4 _1157 = vec4(0.0);
	    vec3 _1156 = vec3(0.0);
	    vec4 _1153 = vec4(0.0);
	    float _1152 = 0.0;
	    float _1151 = 0.0;
	    float _1150 = 0.0;
	    float _1149 = 0.0;
	    float _1148 = 0.0;
	    float _1147 = 0.0;
	    float _1146 = 0.0;
	    vec3 _5461 = vec3(0.0);
	    _5461.x = _1055.x;
	    _5461.y = _1055.y;
	    vec3 _1155 = _5461;
	    vec2 _1154 = _g_rtx_material_data_.g_vTexCoordScale1.xy;
	    vec2 _1210 = _1169;
	    vec2 _1209 = _1168;
	    vec2 _1208 = _1167;
	    vec2 _1207 = _1166;
	    vec2 _1206 = _1165;
	    vec2 _1205 = _1164;
	    vec2 _1204 = _1163;
	    vec4 _1271;
	    if (_g_rtx_material_data_.g_nUVSet1 == 0)
	    {
	        vec2 _5486 = _1210;
	        vec2 _5487 = _5486 * _1154;
	        _1210 = _5487;
	        vec2 _5488 = _1208;
	        vec2 _5489 = _5488 * _1154;
	        _1208 = _5489;
	        vec2 _5490 = _1207;
	        vec2 _5491 = _5490 * _1154;
	        _1207 = _5491;
	        vec2 _5492 = _1209;
	        vec2 _5493 = _5492 * _1154;
	        _1209 = _5493;
	        vec2 _5494 = _1206;
	        vec2 _5495 = _5494 * _1154;
	        _1206 = _5495;
	        vec2 _5496 = _1205;
	        vec2 _5497 = _5496 * _1154;
	        _1205 = _5497;
	        _1271 = (textureGrad(nonuniformEXT(sampler2D(g_bindless_Texture2D_float4[_g_rtx_material_data_.g_tHeight1], g_bindless_Sampler[_g_rtx_material_data_.g_sUserConfig])), _5487.xy, _5489.xy, _5491.xy) * _1204.x) + (textureGrad(nonuniformEXT(sampler2D(g_bindless_Texture2D_float4[_g_rtx_material_data_.g_tHeight1], g_bindless_Sampler[_g_rtx_material_data_.g_sUserConfig])), _5493.xy, _5495.xy, _5497.xy) * _1204.y);
	    }
	    else
	    {
	        _1271 = textureLod(nonuniformEXT(sampler2D(g_bindless_Texture2D_float4[_g_rtx_material_data_.g_tHeight1], g_bindless_Sampler[_g_rtx_material_data_.g_sUserConfig])), _1155.xy, 0.0).xyzw;
	    }
	    _1149 = _1271.x;
	    _1147 = _1271.y;
	    _1148 = _1271.w;
	    _1150 = _1271.x;
	    SPIRV_CROSS_BRANCH
	    if (_g_rtx_material_data_.g_bWetnessUseHeightmapAdjustments)
	    {
	        _1150 = max(0.0, ((_1150 + 0.5) - _1299) * _1300);
	    }
	    float _5536 = _1299;
	    float _5537 = _5536 + (_1295 * 0.5);
	    _1299 = _5537;
	    float _5539 = _1300;
	    float _5540 = _5539 + _1297;
	    _1300 = _5540;
	    vec2 _5543 = _1301;
	    _5543.x = (-_5537) * _5540;
	    _5543.y = (1.0 - _5537) * _5540;
	    _1301 = _5543;
	    if (false)
	    {
	        float _5552 = _1300;
	        float _5553 = _5552 - (_1297 * 2.0);
	        _1300 = _5553;
	        if (_5553 == 0.0)
	        {
	            _1300 = 9.9999997473787516355514526367188e-05;
	        }
	    }
	    _1151 = (_1149 - _1299) * _1300;
	    vec3 _1145 = _1175;
	    vec3 _1144 = _1051;
	    vec3 _1143 = _1050;
	    vec3 _1142 = _1159;
	    vec3 _1141 = _1158;
	    vec2 _1221 = _1169;
	    vec2 _1220 = _1168;
	    vec2 _1219 = _1167;
	    vec2 _1218 = _1166;
	    vec2 _1217 = _1165;
	    vec2 _1216 = _1164;
	    vec2 _1215 = _1163;
	    ivec2 _1214 = _1162;
	    ivec2 _1213 = _1161;
	    if (_g_rtx_material_data_.g_nUVSet1 == 0)
	    {
	        _1221 *= _1154;
	        _1219 *= _1154;
	        _1218 *= _1154;
	        _1220 *= _1154;
	        _1217 *= _1154;
	        _1216 *= _1154;
	        _1156 = _1145;
	        if (true)
	        {
	            _1157 = textureGrad(nonuniformEXT(sampler2D(g_bindless_Texture2D_float4[_g_rtx_material_data_.g_tColor1], g_bindless_Sampler[_g_rtx_material_data_.g_sUserConfig])), _1221.xy, _1219.xy, _1218.xy) * _1215.x;
	        }
	        if (true)
	        {
	            vec4 _5712 = textureGrad(nonuniformEXT(sampler2D(g_bindless_Texture2D_float4[_g_rtx_material_data_.g_tNormal1], g_bindless_Sampler[_g_rtx_material_data_.g_sUserConfig])), _1221.xy, _1219.xy, _1218.xy);
	            _1146 = _5712.z * _1215.x;
	            float _5717 = _5712.x;
	            float _5718 = _5712.y;
	            float _5720 = (_5717 + _5718) - 1.00392162799835205078125;
	            float _5721 = _5717 - _5718;
	            vec3 _5731 = normalize(vec3(vec2(_5720, _5721), (1.0 - abs(_5720)) - abs(_5721))).xyz * _1215.x;
	            vec4 _5733;
	            _5733.x = _5731.x;
	            _5733.y = _5731.y;
	            vec4 _5737 = _5733;
	            _5737.z = _5731.z;
	            _1156 = (_936[_1214.x] * _5733.x) + (_940[_1214.y] * _5733.y);
	        }
	        if (_1215.y > 0.0)
	        {
	            if (true)
	            {
	                _1157 += (textureGrad(nonuniformEXT(sampler2D(g_bindless_Texture2D_float4[_g_rtx_material_data_.g_tColor1], g_bindless_Sampler[_g_rtx_material_data_.g_sUserConfig])), _1220.xy, _1217.xy, _1216.xy) * _1215.y);
	            }
	            if (true)
	            {
	                vec4 _5785 = textureGrad(nonuniformEXT(sampler2D(g_bindless_Texture2D_float4[_g_rtx_material_data_.g_tNormal1], g_bindless_Sampler[_g_rtx_material_data_.g_sUserConfig])), _1220.xy, _1217.xy, _1216.xy);
	                _1146 += (_5785.z * _1215.y);
	                float _5792 = _5785.x;
	                float _5793 = _5785.y;
	                float _5795 = (_5792 + _5793) - 1.00392162799835205078125;
	                float _5796 = _5792 - _5793;
	                vec3 _5806 = normalize(vec3(vec2(_5795, _5796), (1.0 - abs(_5795)) - abs(_5796))).xyz * _1215.y;
	                vec4 _5808;
	                _5808.x = _5806.x;
	                _5808.y = _5806.y;
	                vec4 _5812 = _5808;
	                _5812.z = _5806.z;
	                _1156 += ((_936[_1213.x] * _5808.x) + (_940[_1213.y] * _5808.y));
	            }
	        }
	        _1156 = normalize(_1156 + _1145);
	    }
	    else
	    {
	        if (true)
	        {
	            _1157 = textureGrad(nonuniformEXT(sampler2D(g_bindless_Texture2D_float4[_g_rtx_material_data_.g_tColor1], g_bindless_Sampler[_g_rtx_material_data_.g_sUserConfig])), _1155.xy, _1153.xy, _1153.zw).xyzw;
	        }
	        if (true)
	        {
	            vec4 _5607 = textureGrad(nonuniformEXT(sampler2D(g_bindless_Texture2D_float4[_g_rtx_material_data_.g_tNormal1], g_bindless_Sampler[_g_rtx_material_data_.g_sUserConfig])), _1155.xy, _1153.xy, _1153.zw);
	            vec3 _5608 = _5607.xyz;
	            _1146 = _5607.z;
	            float _5610 = _5607.x;
	            float _5611 = _5607.y;
	            float _5613 = (_5610 + _5611) - 1.00392162799835205078125;
	            float _5614 = _5610 - _5611;
	            vec3 _5621 = normalize(vec3(vec2(_5613, _5614), (1.0 - abs(_5613)) - abs(_5614)));
	            _5608.x = _5621.x;
	            _5608.y = _5621.y;
	            _5608.z = _5621.z;
	            vec3 _5634 = _5608;
	            _5634.x = dot(_5608.xy, _g_rtx_material_data_.g_vNormalXform_1.xy);
	            _5634.y = dot(_5608.xy, _g_rtx_material_data_.g_vNormalXform_1.zw);
	            vec3 _1270 = _5634;
	            vec3 _1211;
	            vec3 _1212;
	            if (_g_rtx_material_data_.g_nUVSet1 > 1)
	            {
	                _1212 = _1142;
	                _1211 = _1141;
	            }
	            else
	            {
	                _1212 = _1144;
	                _1211 = _1143;
	            }
	            vec3 _5646 = abs(_1270.xyz);
	            vec2 _5659 = (-vec2(_1270.x, (-1.0) * _1270.y)) / vec2(max(_5646.z, 0.0078125 * max(_5646.x, _5646.y)));
	            _1156 = normalize(_1243 - ((_1212 * _5659.x) + (_1211 * _5659.y)));
	        }
	    }
	    _1152 = _1157.w;
	    vec3 _1140 = _1175;
	    if (true)
	    {
	        _1156 = normalize(mix(_1140, _1156, vec3(_g_rtx_material_data_.g_fTextureNormalContrast1)));
	        _1146 = saturate(((_g_rtx_material_data_.g_fTextureRoughnessContrast1 * (_1146 - 0.5)) + 0.5) * _g_rtx_material_data_.g_fTextureRoughnessBrightness1);
	    }
	    vec4 _1139 = _1057;
	    vec4 _1265;
	    if (_g_rtx_material_data_.g_bAdjustBaseColor1)
	    {
	        _1265 = vec4((vec4(_1157.xyz, 1.0) * _g_rtx_material_data_.g_mTextureAdjust1).xyz, _1157.w);
	    }
	    else
	    {
	        _1265 = _1157;
	    }
	    vec4 _5876 = _1265;
	    float _5879 = _1152;
	    float _5883 = saturate(mix(_g_rtx_material_data_.g_vAmbientOcclusionLevels1.x, _g_rtx_material_data_.g_vAmbientOcclusionLevels1.z, pow(_5879, _g_rtx_material_data_.g_vAmbientOcclusionLevels1.y)));
	    _1152 = _5883;
	    float _5885 = _1148;
	    float _5886 = _5885 * float(_g_rtx_material_data_.g_bMetalness1);
	    _1148 = _5886;
	    float _5887 = _1147;
	    float _5892 = saturate(((_g_rtx_material_data_.g_fTintMaskContrast1 * (_5887 - 0.5)) + 0.5) * _g_rtx_material_data_.g_fTintMaskBrightness1);
	    _1147 = _5892;
	    vec3 _5896 = mix(_5876.xyz, vec4((vec4(_1157.xyz, 1.0) * _g_rtx_material_data_.g_mTextureColorAdjust1).xyz, _1026).xyz, vec3(_5892));
	    vec4 _5898 = _5876;
	    _5898.x = _5896.x;
	    _5898.y = _5896.y;
	    _5898.z = _5896.z;
	    float _5910 = dot(_5898.xyz, vec3(0.2125000059604644775390625, 0.7153999805450439453125, 0.07209999859333038330078125));
	    vec3 _5913 = normalize(max(_1139.xyz, vec3(0.001000000047497451305389404296875)));
	    vec4 _5932 = vec4(saturate(mix(_5898.xyz, (_5913 * min(_5910 / dot(_5913.xyz, vec3(0.2125000059604644775390625, 0.7153999805450439453125, 0.07209999859333038330078125)), (3.0 * _5910) * max(_1139.x, max(_1139.y, _1139.z)))).xyz, vec3((_1139.w * _5892) * float(_g_rtx_material_data_.g_bModelTint1)))).xyz, _5898.w);
	    _1157 = _5932;
	    _1185 = _1156.xyz;
	    _1184 = _5932.xyz;
	    _1181 = _5883;
	    vec2 _5938 = _1183;
	    _5938.x = _1146;
	    _1183 = _5938;
	    _1182 = _5886;
	    float _1296 = _1150;
	    _1177 = _1151;
	    float _1302 = _g_rtx_material_data_.g_flHeightMapZeroPoint2;
	    float _1303 = _g_rtx_material_data_.g_flHeightMapScale2;
	    vec2 _1304 = vec2(0.0);
	    float _1305 = 0.0;
	    float _1306 = 1.0;
	    if (_g_rtx_material_data_.g_flColorOverlay2 == 0.0)
	    {
	        _1294 = _g_rtx_material_data_.g_flColorReplace2 == 0.0;
	    }
	    else
	    {
	        _1294 = false;
	    }
	    if (_1294)
	    {
	        _1294 = _g_rtx_material_data_.g_flAOCombine2 == 0.0;
	    }
	    else
	    {
	        _1294 = false;
	    }
	    bool _1307;
	    if (_1294)
	    {
	        _1307 = _g_rtx_material_data_.g_flAOReplace2 == 0.0;
	    }
	    else
	    {
	        _1307 = false;
	    }
	    if (_g_rtx_material_data_.g_flNormalCombine2 == 0.0)
	    {
	        _1294 = _g_rtx_material_data_.g_flNormalReplace2 == 0.0;
	    }
	    else
	    {
	        _1294 = false;
	    }
	    if (_1294)
	    {
	        _1294 = _g_rtx_material_data_.g_flRoughnessCombine2 == 0.0;
	    }
	    else
	    {
	        _1294 = false;
	    }
	    bool _1308;
	    if (_1294)
	    {
	        _1308 = _g_rtx_material_data_.g_flRoughnessReplace2 == 0.0;
	    }
	    else
	    {
	        _1308 = false;
	    }
	    vec4 _1138 = vec4(0.0);
	    vec3 _1137 = vec3(0.0);
	    vec3 _1136 = vec3(0.0);
	    vec2 _1135 = vec2(0.0);
	    vec4 _1134 = vec4(0.0);
	    float _1133 = 0.0;
	    float _1132 = 0.0;
	    float _1131 = 0.0;
	    float _1130 = 0.0;
	    float _1129 = 0.0;
	    float _1128 = 0.0;
	    float _1127 = 0.0;
	    vec3 _5995 = _1136;
	    _5995.x = _1055.z;
	    _5995.y = _1055.w;
	    _1136 = _5995;
	    _1135 = _g_rtx_material_data_.g_vTexCoordScale2.xy;
	    vec2 _1228 = _1169;
	    vec2 _1227 = _1168;
	    vec2 _1226 = _1167;
	    vec2 _1225 = _1166;
	    vec2 _1224 = _1165;
	    vec2 _1223 = _1164;
	    vec2 _1222 = _1163;
	    vec4 _1264;
	    if (_g_rtx_material_data_.g_nUVSet2 == 0)
	    {
	        vec2 _6021 = _1228;
	        vec2 _6022 = _6021 * _1135;
	        _1228 = _6022;
	        vec2 _6023 = _1226;
	        vec2 _6024 = _6023 * _1135;
	        _1226 = _6024;
	        vec2 _6025 = _1225;
	        vec2 _6026 = _6025 * _1135;
	        _1225 = _6026;
	        vec2 _6027 = _1227;
	        vec2 _6028 = _6027 * _1135;
	        _1227 = _6028;
	        vec2 _6029 = _1224;
	        vec2 _6030 = _6029 * _1135;
	        _1224 = _6030;
	        vec2 _6031 = _1223;
	        vec2 _6032 = _6031 * _1135;
	        _1223 = _6032;
	        _1264 = (textureGrad(nonuniformEXT(sampler2D(g_bindless_Texture2D_float4[_g_rtx_material_data_.g_tHeight2], g_bindless_Sampler[_g_rtx_material_data_.g_sUserConfig])), _6022.xy, _6024.xy, _6026.xy) * _1222.x) + (textureGrad(nonuniformEXT(sampler2D(g_bindless_Texture2D_float4[_g_rtx_material_data_.g_tHeight2], g_bindless_Sampler[_g_rtx_material_data_.g_sUserConfig])), _6028.xy, _6030.xy, _6032.xy) * _1222.y);
	    }
	    else
	    {
	        _1264 = textureLod(nonuniformEXT(sampler2D(g_bindless_Texture2D_float4[_g_rtx_material_data_.g_tHeight2], g_bindless_Sampler[_g_rtx_material_data_.g_sUserConfig])), _1136.xy, 0.0).xyzw;
	    }
	    _1130 = _1264.x;
	    _1128 = _1264.y;
	    _1129 = _1264.w;
	    _1131 = _1264.x;
	    SPIRV_CROSS_BRANCH
	    if (_g_rtx_material_data_.g_bWetnessUseHeightmapAdjustments)
	    {
	        _1131 = max(0.0, ((_1131 + 0.5) - _1302) * _1303);
	    }
	    float _6071 = _1302;
	    float _6072 = _6071 + (_1295 * 0.5);
	    _1302 = _6072;
	    float _6074 = _1303;
	    float _6075 = _6074 + _1297;
	    _1303 = _6075;
	    vec2 _6078 = _1304;
	    _6078.x = (-_6072) * _6075;
	    _6078.y = (1.0 - _6072) * _6075;
	    _1304 = _6078;
	    if (true)
	    {
	        float _6087 = _1303;
	        float _6088 = _6087 - (_1297 * 2.0);
	        _1303 = _6088;
	        if (_6088 == 0.0)
	        {
	            _1303 = 9.9999997473787516355514526367188e-05;
	        }
	    }
	    _1132 = (_1130 - _1302) * _1303;
	    vec3 _1126 = _1185;
	    float _1125 = _1177;
	    vec3 _1124 = _1175;
	    SPIRV_CROSS_BRANCH
	    if (_g_rtx_material_data_.bBlendByFacingDirection2)
	    {
	        _1293 *= saturate((((dot(_g_rtx_material_data_.g_vFacingDirection2.xyz, mix(_1124.xyz, _1126, vec3(_g_rtx_material_data_.g_vFacingDirectionMaskNormalMapStrength2)).xyz) - 1.0) + (_g_rtx_material_data_.g_flFacingDirectionMaskSpread2 * 2.0)) / (_g_rtx_material_data_.g_vFacingDirectionMaskSoftness2 * 2.0)) + 0.5);
	    }
	    float _6139 = _1132 + mix((_1301.x - _1304.y) - _1297, _1301.y - _1304.x, _1293);
	    _1306 = saturate((_6139 + _1302) - _1125);
	    float _6144 = max(_1125, _6139);
	    if (true)
	    {
	        vec3 _6174 = _1298;
	        _6174.x = _1125;
	        _6174.y = _6139;
	        _1298 = _6174;
	        vec2 _6182 = max((_6174.xy - vec2(_6144)) + vec2(_1297), vec2(0.0));
	        _6182.x = _6182.x + 9.9999997473787516355514526367188e-05;
	        _1305 = (_6182 / vec2(_6182.x + _6182.y)).y;
	    }
	    else
	    {
	        if (false)
	        {
	            vec3 _6150 = _1298;
	            _6150.z = _6139;
	            _1298 = _6150;
	            vec3 _6157 = max((_6150.xyz - vec3(_6144)) + vec3(_1297), vec3(0.0));
	            _6157.x = _6157.x + 9.9999997473787516355514526367188e-05;
	            vec3 _6172;
	            _6172.z = (_6157.xyz / vec3((_6157.x + _6157.y) + _6157.z)).z;
	            _1305 = _6172.z;
	        }
	    }
	    float _6192 = _1305;
	    float _6197 = saturate((_6192 * mix(0.5, _1130, _g_rtx_material_data_.g_flMaskWithHeight2)) * 2.0);
	    _1305 = _6197;
	    bool _6198 = _6197 > 0.0500000007450580596923828125;
	    SPIRV_CROSS_BRANCH
	    if (_6198)
	    {
	        vec3 _1123 = _1175;
	        vec3 _1122 = _1051;
	        vec3 _1121 = _1050;
	        vec3 _1120 = _1159;
	        vec3 _1119 = _1158;
	        vec2 _1239 = _1169;
	        vec2 _1238 = _1168;
	        vec2 _1237 = _1167;
	        vec2 _1236 = _1166;
	        vec2 _1235 = _1165;
	        vec2 _1234 = _1164;
	        vec2 _1233 = _1163;
	        ivec2 _1232 = _1162;
	        ivec2 _1231 = _1161;
	        if (_g_rtx_material_data_.g_nUVSet2 == 0)
	        {
	            _1239 *= _1135;
	            _1237 *= _1135;
	            _1236 *= _1135;
	            _1238 *= _1135;
	            _1235 *= _1135;
	            _1234 *= _1135;
	            _1137 = _1123;
	            bool _6327 = !_1307;
	            if (_6327)
	            {
	                _1138 = textureGrad(nonuniformEXT(sampler2D(g_bindless_Texture2D_float4[_g_rtx_material_data_.g_tColor2], g_bindless_Sampler[_g_rtx_material_data_.g_sUserConfig])), _1239.xy, _1237.xy, _1236.xy) * _1233.x;
	            }
	            bool _6344 = !_1308;
	            if (_6344)
	            {
	                vec4 _6357 = textureGrad(nonuniformEXT(sampler2D(g_bindless_Texture2D_float4[_g_rtx_material_data_.g_tNormal2], g_bindless_Sampler[_g_rtx_material_data_.g_sUserConfig])), _1239.xy, _1237.xy, _1236.xy);
	                _1127 = _6357.z * _1233.x;
	                float _6362 = _6357.x;
	                float _6363 = _6357.y;
	                float _6365 = (_6362 + _6363) - 1.00392162799835205078125;
	                float _6366 = _6362 - _6363;
	                vec3 _6376 = normalize(vec3(vec2(_6365, _6366), (1.0 - abs(_6365)) - abs(_6366))).xyz * _1233.x;
	                vec4 _6378;
	                _6378.x = _6376.x;
	                _6378.y = _6376.y;
	                vec4 _6382 = _6378;
	                _6382.z = _6376.z;
	                _1137 = (_936[_1232.x] * _6378.x) + (_940[_1232.y] * _6378.y);
	            }
	            if (_1233.y > 0.0)
	            {
	                if (_6327)
	                {
	                    _1138 += (textureGrad(nonuniformEXT(sampler2D(g_bindless_Texture2D_float4[_g_rtx_material_data_.g_tColor2], g_bindless_Sampler[_g_rtx_material_data_.g_sUserConfig])), _1238.xy, _1235.xy, _1234.xy) * _1233.y);
	                }
	                if (_6344)
	                {
	                    vec4 _6430 = textureGrad(nonuniformEXT(sampler2D(g_bindless_Texture2D_float4[_g_rtx_material_data_.g_tNormal2], g_bindless_Sampler[_g_rtx_material_data_.g_sUserConfig])), _1238.xy, _1235.xy, _1234.xy);
	                    _1127 += (_6430.z * _1233.y);
	                    float _6437 = _6430.x;
	                    float _6438 = _6430.y;
	                    float _6440 = (_6437 + _6438) - 1.00392162799835205078125;
	                    float _6441 = _6437 - _6438;
	                    vec3 _6451 = normalize(vec3(vec2(_6440, _6441), (1.0 - abs(_6440)) - abs(_6441))).xyz * _1233.y;
	                    vec4 _6453;
	                    _6453.x = _6451.x;
	                    _6453.y = _6451.y;
	                    vec4 _6457 = _6453;
	                    _6457.z = _6451.z;
	                    _1137 += ((_936[_1231.x] * _6453.x) + (_940[_1231.y] * _6453.y));
	                }
	            }
	            _1137 = normalize(_1137 + _1123);
	        }
	        else
	        {
	            if (!_1307)
	            {
	                _1138 = textureGrad(nonuniformEXT(sampler2D(g_bindless_Texture2D_float4[_g_rtx_material_data_.g_tColor2], g_bindless_Sampler[_g_rtx_material_data_.g_sUserConfig])), _1136.xy, _1134.xy, _1134.zw).xyzw;
	            }
	            if (!_1308)
	            {
	                vec4 _6250 = textureGrad(nonuniformEXT(sampler2D(g_bindless_Texture2D_float4[_g_rtx_material_data_.g_tNormal2], g_bindless_Sampler[_g_rtx_material_data_.g_sUserConfig])), _1136.xy, _1134.xy, _1134.zw);
	                vec3 _6251 = _6250.xyz;
	                _1127 = _6250.z;
	                float _6253 = _6250.x;
	                float _6254 = _6250.y;
	                float _6256 = (_6253 + _6254) - 1.00392162799835205078125;
	                float _6257 = _6253 - _6254;
	                vec3 _6264 = normalize(vec3(vec2(_6256, _6257), (1.0 - abs(_6256)) - abs(_6257)));
	                _6251.x = _6264.x;
	                _6251.y = _6264.y;
	                _6251.z = _6264.z;
	                vec3 _6277 = _6251;
	                _6277.x = dot(_6251.xy, _g_rtx_material_data_.g_vNormalXform_2.xy);
	                _6277.y = dot(_6251.xy, _g_rtx_material_data_.g_vNormalXform_2.zw);
	                vec3 _1263 = _6277;
	                vec3 _1229;
	                vec3 _1230;
	                if (_g_rtx_material_data_.g_nUVSet2 > 1)
	                {
	                    _1230 = _1120;
	                    _1229 = _1119;
	                }
	                else
	                {
	                    _1230 = _1122;
	                    _1229 = _1121;
	                }
	                vec3 _6289 = abs(_1263.xyz);
	                vec2 _6302 = (-vec2(_1263.x, (-1.0) * _1263.y)) / vec2(max(_6289.z, 0.0078125 * max(_6289.x, _6289.y)));
	                _1137 = normalize(_1243 - ((_1230 * _6302.x) + (_1229 * _6302.y)));
	            }
	        }
	        _1133 = _1138.w;
	        vec3 _1118 = _1175;
	        if (!_1308)
	        {
	            _1137 = normalize(mix(_1118, _1137, vec3(_g_rtx_material_data_.g_fTextureNormalContrast2)));
	            _1127 = saturate(((_g_rtx_material_data_.g_fTextureRoughnessContrast2 * (_1127 - 0.5)) + 0.5) * _g_rtx_material_data_.g_fTextureRoughnessBrightness2);
	        }
	        vec4 _1117 = _1057;
	        vec4 _1258;
	        if (_g_rtx_material_data_.g_bAdjustBaseColor2)
	        {
	            _1258 = vec4((vec4(_1138.xyz, 1.0) * _g_rtx_material_data_.g_mTextureAdjust2).xyz, _1138.w);
	        }
	        else
	        {
	            _1258 = _1138;
	        }
	        vec4 _6523 = _1258;
	        _1133 = saturate(mix(_g_rtx_material_data_.g_vAmbientOcclusionLevels2.x, _g_rtx_material_data_.g_vAmbientOcclusionLevels2.z, pow(_1133, _g_rtx_material_data_.g_vAmbientOcclusionLevels2.y)));
	        _1129 *= float(_g_rtx_material_data_.g_bMetalness2);
	        float _6534 = _1128;
	        float _6539 = saturate(((_g_rtx_material_data_.g_fTintMaskContrast2 * (_6534 - 0.5)) + 0.5) * _g_rtx_material_data_.g_fTintMaskBrightness2);
	        _1128 = _6539;
	        vec3 _6543 = mix(_6523.xyz, vec4((vec4(_1138.xyz, 1.0) * _g_rtx_material_data_.g_mTextureColorAdjust2).xyz, _1026).xyz, vec3(_6539));
	        vec4 _6545 = _6523;
	        _6545.x = _6543.x;
	        _6545.y = _6543.y;
	        _6545.z = _6543.z;
	        float _6557 = dot(_6545.xyz, vec3(0.2125000059604644775390625, 0.7153999805450439453125, 0.07209999859333038330078125));
	        vec3 _6560 = normalize(max(_1117.xyz, vec3(0.001000000047497451305389404296875)));
	        _1138 = vec4(saturate(mix(_6545.xyz, (_6560 * min(_6557 / dot(_6560.xyz, vec3(0.2125000059604644775390625, 0.7153999805450439453125, 0.07209999859333038330078125)), (3.0 * _6557) * max(_1117.x, max(_1117.y, _1117.z)))).xyz, vec3((_1117.w * _6539) * float(_g_rtx_material_data_.g_bModelTint2)))).xyz, _6545.w);
	    }
	    SPIRV_CROSS_BRANCH
	    if (_6198)
	    {
	        vec4 _1116 = _1138;
	        vec3 _1115 = _1137;
	        float _1114 = _1133;
	        float _1113 = _1132;
	        float _1112 = _1131;
	        float _1111 = _1129;
	        float _1110 = _1127;
	        if (!_1307)
	        {
	            vec3 _6610 = _1116.xyz * 12.9200000762939453125;
	            vec3 _6613 = (pow(_1116.xyz, vec3(0.4166666567325592041015625)) * 1.05499994754791259765625) - vec3(0.054999999701976776123046875);
	            float _1255;
	            if (_1116.x <= 0.003130800090730190277099609375)
	            {
	                _1255 = _6610.x;
	            }
	            else
	            {
	                _1255 = _6613.x;
	            }
	            float _1256;
	            if (_1116.y <= 0.003130800090730190277099609375)
	            {
	                _1256 = _6610.y;
	            }
	            else
	            {
	                _1256 = _6613.y;
	            }
	            float _1257;
	            if (_1116.z <= 0.003130800090730190277099609375)
	            {
	                _1257 = _6610.z;
	            }
	            else
	            {
	                _1257 = _6613.z;
	            }
	            _1184 = mix(_1184 * mix(vec3(1.0), vec3(_1255, _1256, _1257) * 2.0, vec3(_1305 * _g_rtx_material_data_.g_flColorOverlay2)), _1116.xyz, vec3(_1305 * _g_rtx_material_data_.g_flColorReplace2));
	            _1181 = mix(_1181 * mix(1.0, _1114, _1305 * _g_rtx_material_data_.g_flAOCombine2), _1114, _1305 * _g_rtx_material_data_.g_flAOReplace2);
	        }
	        if (!_1308)
	        {
	            _1185 = mix(mix(_1185, normalize(mix(_1175, (_1185 + _1115.xyz) * vec3(0.5), vec3(2.0))), vec3(_1305 * _g_rtx_material_data_.g_flNormalCombine2)), _1115.xyz, vec3((_1305 * _1306) * _g_rtx_material_data_.g_flNormalReplace2));
	            vec2 _6674 = _1183;
	            _6674.x = _6674.x * (1.0 + ((((_1110 - _6674.x) * 2.0) * _1305) * _g_rtx_material_data_.g_flRoughnessCombine2));
	            _6674.x = mix(_6674.x, _1110, _1305 * _g_rtx_material_data_.g_flRoughnessReplace2);
	            _1183 = _6674;
	        }
	        _1182 = mix(_1182 * mix(1.0, _1111 * 2.0, _1305 * _g_rtx_material_data_.g_flMetalnessCombine2), _1111, _1305 * _g_rtx_material_data_.g_flMetalnessReplace2);
	        _1296 = mix(_1296, _1112, _1305);
	        _1177 = mix(_1177, _1113, _1305);
	    }
	    float _6705 = saturate(1.0 - _1305);
	    _1184 *= mix(vec3(1.0), _1054.xyz, vec3(saturate(saturate(((float(!_g_rtx_material_data_.g_bMaskVertexColor1) * _6705) + (float(!_g_rtx_material_data_.g_bMaskVertexColor2) * _1305)) + ((_1147 * _6705) + (_1128 * _1305))) * ((float(_g_rtx_material_data_.g_bVertexColorEnabled1) * _6705) + (float(_g_rtx_material_data_.g_bVertexColorEnabled2) * _1305)))));
	    vec2 _6738 = _1183;
	    vec2 _6740 = _6738;
	    _6740.x = _6738.x;
	    _6740.y = _6738.x;
	    _1183 = _6740;
	    vec4 _1109 = _1058;
	    bool _1252;
	    if (_g_rtx_material_data_.g_bWetness)
	    {
	        _1252 = (_g_rtx_material_data_.g_fPuddleStrength + _g_rtx_material_data_.g_fWetnessStrength) > 0.0;
	    }
	    else
	    {
	        _1252 = false;
	    }
	    if (_1252)
	    {
	        _1252 = _1109.z > 0.0;
	    }
	    else
	    {
	        _1252 = false;
	    }
	    SPIRV_CROSS_BRANCH
	    if (_1252)
	    {
	        vec4 _1253 = vec4(0.0, 0.0, 1.0, 0.0);
	        float _6772 = pow(max(0.0, _1175.z), 32.0);
	        float _6778 = min(min(_1109.z, 1.0), 1.0);
	        float _6780 = saturate(_6778 - 0.75);
	        float _6783 = _6778 + (4.0 * (_6780 * _6780));
	        float _6793 = saturate(_6783 * 20.0);
	        float _1254;
	        SPIRV_CROSS_BRANCH
	        if (_g_rtx_material_data_.g_bPuddlesOnVerticalSurfaces)
	        {
	            vec4 _6810 = _1253;
	            _6810.x = _1175.x;
	            _6810.y = _1175.y;
	            _6810.z = _1175.z;
	            _1253 = _6810;
	            _1254 = max(0.0, _6783 - _g_rtx_material_data_.g_fWetEdgeSpread);
	        }
	        else
	        {
	            _1254 = max(0.0, (_6783 * _6772) - _g_rtx_material_data_.g_fWetEdgeSpread);
	        }
	        float _6818 = max(0.001000000047497451305389404296875, _g_rtx_material_data_.g_fPuddleBlendSoftness);
	        float _6826 = smoothstep(_1254 + _6818, _1254 - (_1109.w + (_6818 * 2.0)), _1296) * _6793;
	        float _6829 = max((smoothstep(_6778, (_6783 - _g_rtx_material_data_.g_fWetEdgeSpread) - (0.20000000298023223876953125 * _6783), _1296) * _g_rtx_material_data_.g_fWetEdgeStrength) * _6793, _6826) * _g_rtx_material_data_.g_fPuddleStrength;
	        float _6831 = (_6778 - 1.0) - _1296;
	        float _6837 = (saturate(_6831 + _g_rtx_material_data_.g_fPuddleSedimentHeight) * _g_rtx_material_data_.g_fPuddleSedimentOpacity) * _6826;
	        _1185 = mix(_1185, _1253.xyz, vec3(_6829 * _6837));
	        float _6857 = max(saturate(((saturate((((_6783 * 2.0) - (mix(0.5, 0.5, saturate(_6772 * 20.0)) * 0.5)) - (_1296 * 0.5)) + 0.25) * _g_rtx_material_data_.g_fWetnessStrength) * _6793) + _6826), _6829);
	        vec2 _6861 = _1183;
	        vec3 _6869 = mix(_1184, pow(_1184, vec3(1.2999999523162841796875)) * 0.800000011920928955078125, saturate((pow(_1184, vec3(0.25)) * (_6857 * _6861.x)) * 8.0) * mix(_g_rtx_material_data_.g_flWetnessDarkeningStrength1, _g_rtx_material_data_.g_flWetnessDarkeningStrength2, _1305 * _g_rtx_material_data_.g_flColorReplace2));
	        _1184 = fma(mix((mix(_6869, _6869 * 0.5, vec3(saturate(_6826 * 1.5))) * mix(1.0, _1181, _6829)) * mix(1.0, 1.0 - _6831, _6837), _g_rtx_material_data_.g_vPuddleSedimentColor, vec3(_6837 * _6829)), vec3(1.0), vec3(0.0));
	        _1181 = mix(_1181, 1.0, _6829);
	        vec2 _6892 = saturate(mix(_6861.xx, vec2(_g_rtx_material_data_.g_fPuddleRoughness), vec2(_6857)));
	        vec2 _6894 = _6861;
	        _6894.x = _6892.x;
	        _6894.y = _6892.y;
	        _1183 = _6894;
	        _1179 = mix(_1179, 0.0350000001490116119384765625, _6857);
	    }
	    _1181 = max(_1181, 0.0);
	    payload.nInstance = int(uint(gl_InstanceID));
	    payload.flHitT = gl_RayTmaxEXT;
	    payload.vFaceNormalWs = _1174;
	    payload.vInterpolatedNormalWs = _1175;
	    vec3 _1250[3] = vec3[](_1045, _1038, _1033);
	    vec3 _1251[3] = vec3[](_1044, _1037, _1032);
	    vec3 _6942 = ((_1250[0] * ((1.0 - attrs.barycentrics.x) - attrs.barycentrics.y)) + (_1250[1] * attrs.barycentrics.x)) + (_1250[2] * attrs.barycentrics.y);
	    vec3 _1244[3];
	    _1244[0] = _6942 - (_1251[0] * dot(_6942 - _1250[0], _1251[0]));
	    _1244[1] = _6942 - (_1251[1] * dot(_6942 - _1250[1], _1251[1]));
	    _1244[2] = _6942 - (_1251[2] * dot(_6942 - _1250[2], _1251[2]));
	    vec3 _6982 = ((_1244[0] * ((1.0 - attrs.barycentrics.x) - attrs.barycentrics.y)) + (_1244[1] * attrs.barycentrics.x)) + (_1244[2] * attrs.barycentrics.y);
	    vec3 _1245[3];
	    _1245[0] = cross(_1250[0] - _1250[1], _1174);
	    _1245[1] = cross(_1250[1] - _1250[2], _1174);
	    _1245[2] = cross(_1250[2] - _1250[0], _1174);
	    float _1246 = dot(_6982 - _6942, _1174);
	    vec3 _1247 = _6982;
	    int _1248 = 0;
	    for (;;)
	    {
	        bool _6998_ladder_break = false;
	        do
	        {
	            if (!(_1248 < 3))
	            {
	                _6998_ladder_break = true;
	                break;
	            }
	            if (_1246 > 0.00999999977648258209228515625)
	            {
	                _6998_ladder_break = true;
	                break;
	            }
	            if (dot(_1245[_1248], _1245[_1248]) == 0.0)
	            {
	                break;
	            }
	            _1245[_1248] = normalize(_1245[_1248]);
	            int _1249 = 0;
	            for (;;)
	            {
	                if (!(_1249 < 3))
	                {
	                    break;
	                }
	                vec3 _7036 = _1251[_1249] - (_1245[_1248] * dot(_1245[_1248], _1251[_1249]));
	                _1244[_1249] = _6942 - (_7036 * dot(_6942 - _1250[_1249], _7036));
	                _1249++;
	                continue;
	            }
	            vec3 _7060 = ((_1244[0] * ((1.0 - attrs.barycentrics.x) - attrs.barycentrics.y)) + (_1244[1] * attrs.barycentrics.x)) + (_1244[2] * attrs.barycentrics.y);
	            _1246 = dot(_7060 - _6942, _1174);
	            _1247 = _7060;
	            break;
	        } while(false);
	        if (_6998_ladder_break)
	        {
	            break;
	        }
	        _1248++;
	        continue;
	    }
	    if (!(_1246 > 0.00999999977648258209228515625))
	    {
	        _1247 = vec3(3.4028234663852885981170418348452e+38);
	    }
	    payload.vSmoothPositionWs = _1247;
	    payload.bFlippedNormal = _1173;
	    f16vec3 _7073 = f16vec3(vec3(0.0));
	    payload.material = MaterialDataMinimal_t(_7073, float16_t(0.0), f16vec3(vec3(1.0, 0.0, 1.0)), float16_t(1.0), _7073, float16_t(0.040008544921875), 0u, f16vec4(ivec4(0)));
	    payload.material.vNormalWs = f16vec3(_1185);
	    payload.material.vAlbedo = f16vec3(_1184);
	    payload.material.vEmissive = f16vec3(_1180);
	    payload.material.flReflectance = float16_t(_1179);
	    payload.material.flMetalness = float16_t(_1182);
	    payload.material.flRoughness = float16_t(dot(_1183, vec2(0.5)));
	    if (any(greaterThan(_1178, vec3(0.0))))
	    {
	        payload.material.nMaterialTypeAndFlags = (payload.material.nMaterialTypeAndFlags & 4294901760u) | 1u;
	        f16vec3 _7099 = f16vec3(_1178);
	        payload.material.vMaterialBits.x = _7099.x;
	        payload.material.vMaterialBits.y = _7099.y;
	        payload.material.vMaterialBits.z = _7099.z;
	    }
	}
	
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
	
	BoolAttribute(BindlessResources, true);
	IntAttribute(RayTypeCount, 2);
	BoolAttribute(GroupDefaultCollapseState_TextureTransform, true);
	BoolAttribute(GroupDefaultCollapseState_DetailTextureTransform, true);
	IntAttribute(TexCoord2ScaleByModelU, g_nScaleTexCoord2UByModelScaleAxis-1);
	IntAttribute(TexCoord2ScaleByModelV, g_nScaleTexCoord2VByModelScaleAxis-1);
	BoolAttribute(CanBatchWithDynamicShaderConstants, true);
	IntAttribute(TexCoordScaleByModelU, g_nScaleTexCoordUByModelScaleAxis-1);
	IntAttribute(TexCoordScaleByModelV, g_nScaleTexCoordVByModelScaleAxis-1);
	Float3Attribute(LightSim_MaterialTint, g_vColorTint);
	BoolAttribute(VertexPaintUIPickColor, true);
	BoolAttribute(VertexpaintUIPuddles, (F_WETNESS==1) ? 1 : 0);
	BoolAttribute(VertexPaintUIAlphaBlendFactor, true);
	BoolAttribute(SupportsAggregateInstancing, true);
	BoolAttribute(SupportsMaterialLayerSampling, true);
	BoolAttribute(NeedsLightProbe, true);
	BoolAttribute(DoNotCastShadows, F_DO_NOT_CAST_SHADOWS ? 1 : 0);
	BoolAttribute(SupportsMappingDimensions, true);
	BoolAttribute(renderbackfaces, F_RENDER_BACKFACES ? 1 : 0);
	FloatAttribute(_dummyMakeVisiblePropMaskBias1, g_flDetailPropMaskBias1);
	FloatAttribute(_dummyMakeVisiblePropPuddleReduction1, g_flDetailPropPuddleReduction1);
	FloatAttribute(_dummyMakeVisiblePropMaskBias2, g_flDetailPropMaskBias2);
	FloatAttribute(_dummyMakeVisiblePropMaskSoftness2, g_flDetailPropMaskSoftness2);
	FloatAttribute(_dummyMakeVisiblePropPuddleReduction2, g_flDetailPropPuddleReduction2);
	
	#if (S_SHARED_COLOR_OVERLAY == 1)
		BoolAttribute(HasTexcoordTransform, (g_nUVSet1>0 && (g_vTexCoordScale1.x!=1 || g_vTexCoordScale1.y!=1 || g_flTexCoordRotation1!=0) || g_nUVSet2>0 && (g_vTexCoordScale2.x!=1 || g_vTexCoordScale2.y!=1 || g_flTexCoordRotation2!=0) || g_nUVSet3>0 && (g_vTexCoordScale3.x!=1 || g_vTexCoordScale3.y!=1 || g_flTexCoordRotation3!=0) || g_nColorOverlayUVSet>0 && (g_vOverlayTexCoordScale.x!=1 || g_vOverlayTexCoordScale.y!=1 || g_flOverlayTexCoordRotation!=0)) ? 1 : 0);
		BoolAttribute(VertexPaintUI2Layer, false);
		BoolAttribute(VertexPaintUI3Layer, true);
		FloatAttribute(_dummyMakeVisiblePropMaskBias3, g_flDetailPropMaskBias3);
		FloatAttribute(_dummyMakeVisiblePropMaskSoftness3, g_flDetailPropMaskSoftness3);
		FloatAttribute(_dummyMakeVisiblePropPuddleReduction3, g_flDetailPropPuddleReduction3);
	#endif
	#if (S_ENABLE_LAYER_3 == 0)
		BoolAttribute(VertexPaintUI2Layer, true);
		BoolAttribute(VertexPaintUI3Layer, false);
	#endif
	#if (S_ALPHA_TEST == 1)
		BoolAttribute(alphatest, true);
		BoolAttribute(NoZPrepass, true);
		BoolAttribute(AlphaTestZPrepass, true);
	#endif
	#if (S_ALPHA_TEST == 0)
		BoolAttribute(NoZPrepass, F_DISABLE_Z_PREPASS ? 1 : 0);
	#endif
	#if (S_BLEND_EFFECTS_3 == 1)
		BoolAttribute(VertexPaintUI2Layer, false);
		BoolAttribute(VertexPaintUI3Layer, true);
		FloatAttribute(_dummyMakeVisiblePropMaskBias3, g_flDetailPropMaskBias3);
		FloatAttribute(_dummyMakeVisiblePropMaskSoftness3, g_flDetailPropMaskSoftness3);
		FloatAttribute(_dummyMakeVisiblePropPuddleReduction3, g_flDetailPropPuddleReduction3);
	#endif
	#if (S_MODE_DEPTH == 0)
		BoolAttribute(VertexPaintUI2Layer, false);
		BoolAttribute(VertexPaintUI3Layer, true);
		FloatAttribute(_dummyMakeVisiblePropMaskBias3, g_flDetailPropMaskBias3);
		FloatAttribute(_dummyMakeVisiblePropMaskSoftness3, g_flDetailPropMaskSoftness3);
		FloatAttribute(_dummyMakeVisiblePropPuddleReduction3, g_flDetailPropPuddleReduction3);
	#endif
	#if (S_DETAIL_NORMAL == 0)
		BoolAttribute(VertexPaintUI2Layer, false);
		BoolAttribute(VertexPaintUI3Layer, true);
		FloatAttribute(_dummyMakeVisiblePropMaskBias3, g_flDetailPropMaskBias3);
		FloatAttribute(_dummyMakeVisiblePropMaskSoftness3, g_flDetailPropMaskSoftness3);
		FloatAttribute(_dummyMakeVisiblePropPuddleReduction3, g_flDetailPropPuddleReduction3);
	#endif
	#if (S_ENABLE_LAYER_3 == 1)
		BoolAttribute(VertexPaintUI2Layer, false);
		BoolAttribute(VertexPaintUI3Layer, true);
		FloatAttribute(_dummyMakeVisiblePropMaskBias3, g_flDetailPropMaskBias3);
		FloatAttribute(_dummyMakeVisiblePropMaskSoftness3, g_flDetailPropMaskSoftness3);
		FloatAttribute(_dummyMakeVisiblePropPuddleReduction3, g_flDetailPropPuddleReduction3);
	#endif
	#if (S_BLEND_EFFECTS_3 == 0)
		BoolAttribute(alphatest, true);
		BoolAttribute(NoZPrepass, true);
		BoolAttribute(AlphaTestZPrepass, true);
	#endif
	#if (S_MODE_TOOLS_VIS == 0)
		BoolAttribute(VertexPaintUI2Layer, false);
		BoolAttribute(VertexPaintUI3Layer, true);
		FloatAttribute(_dummyMakeVisiblePropMaskBias3, g_flDetailPropMaskBias3);
		FloatAttribute(_dummyMakeVisiblePropMaskSoftness3, g_flDetailPropMaskSoftness3);
		FloatAttribute(_dummyMakeVisiblePropPuddleReduction3, g_flDetailPropPuddleReduction3);
	#endif
	#if (S_SHARED_COLOR_OVERLAY == 0)
		BoolAttribute(HasTexcoordTransform, (g_nUVSet1>0 && (g_vTexCoordScale1.x!=1 || g_vTexCoordScale1.y!=1 || g_flTexCoordRotation1!=0) || g_nUVSet2>0 && (g_vTexCoordScale2.x!=1 || g_vTexCoordScale2.y!=1 || g_flTexCoordRotation2!=0) || g_nUVSet3>0 && (g_vTexCoordScale3.x!=1 || g_vTexCoordScale3.y!=1 || g_flTexCoordRotation3!=0)) ? 1 : 0);
		BoolAttribute(VertexPaintUI2Layer, false);
		BoolAttribute(VertexPaintUI3Layer, true);
		FloatAttribute(_dummyMakeVisiblePropMaskBias3, g_flDetailPropMaskBias3);
		FloatAttribute(_dummyMakeVisiblePropMaskSoftness3, g_flDetailPropMaskSoftness3);
		FloatAttribute(_dummyMakeVisiblePropPuddleReduction3, g_flDetailPropPuddleReduction3);
	#endif
	#if (S_SHADER_QUALITY == 0)
		BoolAttribute(VertexPaintUI2Layer, false);
		BoolAttribute(VertexPaintUI3Layer, true);
		FloatAttribute(_dummyMakeVisiblePropMaskBias3, g_flDetailPropMaskBias3);
		FloatAttribute(_dummyMakeVisiblePropMaskSoftness3, g_flDetailPropMaskSoftness3);
		FloatAttribute(_dummyMakeVisiblePropPuddleReduction3, g_flDetailPropPuddleReduction3);
	#endif
	
	// Variant Attributes
	BoolAttribute(HasTexcoordTransform, (g_nUVSet1>0 && (g_vTexCoordScale1.x!=1 || g_vTexCoordScale1.y!=1 || g_flTexCoordRotation1!=0) || g_nUVSet2>0 && (g_vTexCoordScale2.x!=1 || g_vTexCoordScale2.y!=1 || g_flTexCoordRotation2!=0)) ? 1 : 0);
	BoolAttribute(HasTexcoordTransform, (g_nUVSet1>0 && (g_vTexCoordScale1.x!=1 || g_vTexCoordScale1.y!=1 || g_flTexCoordRotation1!=0) || g_nUVSet2>0 && (g_vTexCoordScale2.x!=1 || g_vTexCoordScale2.y!=1 || g_flTexCoordRotation2!=0) || g_nColorOverlayUVSet>0 && (g_vOverlayTexCoordScale.x!=1 || g_vOverlayTexCoordScale.y!=1 || g_flOverlayTexCoordRotation!=0)) ? 1 : 0);
}
