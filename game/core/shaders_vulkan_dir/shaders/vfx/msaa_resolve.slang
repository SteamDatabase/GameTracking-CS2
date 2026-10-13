//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "MSAA Resolve, optional DoF CoC in output alpha channel";
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
	DynamicCombo( D_MSAA_SAMPLES, 0..2 );
	DynamicCombo( D_TONEMAP_BLEND, 0..3 );
	DynamicCombo( D_WRITE_COC, 0..1 );
	DynamicCombo( D_DITHER_NOISE, 0..2 );
	
	RenderState(StencilRef, 1);
	float g_flDitherNoiseAmount < Attribute("DitherNoiseAmount"); UiType(Slider); >;
	float g_flExposureBiasScaleFactor < Default(1); Attribute("ExposureBiasScaleFactor"); UiType(Slider); >;
	float4x4 g_invViewProjMatrix < Attribute("InvViewProjMatrix"); >;
	Texture2D g_tBlueNoise < Attribute("BlueNoise"); SrgbRead(false); >;
	Texture2D g_tSceneDepth < Attribute("SceneDepth"); SrgbRead(false); >;
	Texture2D g_tSourceMsaa < Attribute("InputTexture"); SrgbRead(false); >;
	float4 g_vBlueNoiseDitherParams < UiType(VectorText); Expression(bluenoiseditherparams); >;
	float4 g_vLensPlane < Attribute("LensPlane"); UiType(VectorText); >;
	float4 g_vNearFarScaleBias < Attribute("NearFarScaleBias"); UiType(VectorText); >;
	float2 g_vSourceOffset < Attribute("SourceOffset"); UiType(VectorText); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	static float4 _3;
	
	cbuffer _Globals_ : register(b0, space1)
	{
	    float2 _Globals_1_g_vSourceOffset : packoffset(c7.z);
	};
	
	Texture2DMS<float4> g_tSourceMsaa : register(t31, space1);
	
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
	    float4 _13155;
	    _13155 = 0.0f.xxxx;
	    int _9913;
	    float4 _10794;
	    int _16208 = 0;
	    for (;;)
	    {
	        if (!(_16208 < 2))
	        {
	            break;
	        }
	        float4 _3300 = g_tSourceMsaa.Load(int2((gl_FragCoord.xy - _Globals_1_g_vSourceOffset.xy).xy), _16208);
	        float3 _12039 = clamp(_3300.xyz, 0.0f.xxx, 65504.0f.xxx);
	        float4 _13514;
	        _13514.x = _12039.x;
	        _13514.y = _12039.y;
	        _13514.z = _12039.z;
	        _10794 = _13155.xyzw + float4(_13514.xyz * 0.5f, _3300.w * 0.5f).xyzw;
	        _9913 = _16208 + 1;
	        _13155 = _10794;
	        _16208 = _9913;
	        continue;
	    }
	    output_0 = _13155;
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
