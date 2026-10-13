//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Bloom downsample, shape, and blur";
	DevShader = true;
	Version = 0;
	
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
	float3 vPositionPs : POSITION0  < Semantic( PosXyz ); >;                                      
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
	    float4 _22489 = float4(vPositionPs, 0.0f, 1.0f);
	    _22489.y = -vPositionPs.y;
	    gl_Position = _22489;
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
	DynamicCombo( D_DOWNSAMPLE_4X, 0..1 );
	DynamicCombo( D_KAWASE_BLUR, 0..1 );
	DynamicComboRule( Allow1( D_DOWNSAMPLE_4X, D_KAWASE_BLUR ) );
	
	float g_flKawaseStep < Attribute("flKawaseStep"); UiType(Slider); >;
	Texture2D g_tInputBuffer < Attribute("InputBuffer"); SrgbRead(false); >;
	float4 g_vInvTexDim < Source(InvTextureDim); SourceArg(g_tInputBuffer) UiType(VectorText); >;
	
	// Color Tint
	float g_flBrightness < Default(1); Range(0, 4); UiType(Slider); UiGroup("Color Tint"); >;
	float g_flExponent < Default(2); Range(0.1, 8); UiType(Slider); UiGroup("Color Tint"); >;
	float3 g_vColorTint < Default3(1, 1, 1); UiType(Color); UiGroup("Color Tint"); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	cbuffer _Globals_ : register(b0, space1)
	{
	    float4 _Globals_1_g_vInvTexDim : packoffset(c0);
	};
	
	Texture2D<float4> g_tInputBuffer : register(t30, space1);
	SamplerState AddressU_Clamp_AddressV_Clamp_Filter_MinMagLinearMipPoint : register(s14, space1);
	
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
	    output_0 = g_tInputBuffer.SampleLevel(AddressU_Clamp_AddressV_Clamp_Filter_MinMagLinearMipPoint, (gl_FragCoord.xy * _Globals_1_g_vInvTexDim.xy).xy, 0.0f);
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
