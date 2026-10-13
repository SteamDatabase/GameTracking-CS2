//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Non MSAA Resolve - i.e. copy, but with conversion to reversible tonemap space. Optional DoF CoC in output alpha channel";
	DevShader = true;
	Version = 2;
	
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
	float4 vPositionPs : POSITION0  < Semantic( position ); >;                                    
};

VS
{
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	static float4 gl_Position;
	static float2 vPositionPs;
	
	struct VS_INPUT
	{
	    float2 vPositionPs : POSITION0;
	};
	
	struct PS_INPUT
	{
	    float4 gl_Position : SV_Position;
	};
	
	void MainVs_inner()
	{
	    float4 _15970 = float4(vPositionPs.xy, 0.0f, 1.0f);
	    _15970.y = -vPositionPs.y;
	    gl_Position = _15970;
	}
	
	PS_INPUT MainVs(VS_INPUT stage_input)
	{
	    vPositionPs = stage_input.vPositionPs;
	    MainVs_inner();
	    PS_INPUT stage_output;
	    stage_output.gl_Position = gl_Position;
	    return stage_output;
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
}

PS
{
	DynamicCombo( D_OUTPUT_TONEMAP_SPACE, 0..2 );
	DynamicCombo( D_WRITE_COC, 0..1 );
	DynamicCombo( D_DITHER_NOISE, 0..2 );
	
	RenderState(StencilRef, 1);
	float g_flDitherNoiseAmount < Attribute("DitherNoiseAmount"); UiType(Slider); >;
	float g_flExposureBiasScaleFactor < Default(1); Attribute("ExposureBiasScaleFactor"); UiType(Slider); >;
	float4x4 g_invViewProjMatrix < Attribute("InvViewProjMatrix"); >;
	Texture2D g_tBlueNoise < Attribute("BlueNoise"); SrgbRead(false); >;
	Texture2D g_tSceneDepth < Attribute("SceneDepth"); SrgbRead(false); >;
	Texture2D g_tSource < Attribute("InputTexture"); SrgbRead(false); >;
	float4 g_vBlueNoiseDitherParams < UiType(VectorText); Expression(bluenoiseditherparams); >;
	float4 g_vLensPlane < Attribute("LensPlane"); UiType(VectorText); >;
	float4 g_vNearFarScaleBias < Attribute("NearFarScaleBias"); UiType(VectorText); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	Texture2D<float4> g_tSource : register(t31, space1);
	
	static float4 gl_FragCoord;
	static float4 output_0;
	
	struct PS_INPUT
	{
	    float4 gl_FragCoord : SV_Position;
	};
	
	struct PS_OUTPUT
	{
	    float4 output_0 : SV_Target0;
	};
	
	void MainPs_inner()
	{
	    int3 _16480 = int3(uint3(uint2(gl_FragCoord.xy), 0u).xyz);
	    float4 _3300 = g_tSource.Load(int3(_16480.xy, _16480.z));
	    output_0 = float4(clamp(_3300.xyz, 0.0f.xxx, 65504.0f.xxx), _3300.w);
	}
	
	PS_OUTPUT MainPs(PS_INPUT stage_input)
	{
	    gl_FragCoord = stage_input.gl_FragCoord;
	    gl_FragCoord.w = 1.0 / gl_FragCoord.w;
	    MainPs_inner();
	    PS_OUTPUT stage_output;
	    stage_output.output_0 = output_0;
	    return stage_output;
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
}
