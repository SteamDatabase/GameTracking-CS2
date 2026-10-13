//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Shader to downsample rendertargets for outline glows in CSGO, assumes non MSAA render targets (src & dst)";
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
	float3 vPositionSs : POSITION0  < Semantic( PosXyz ); >;                                      
};

VS
{
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	static float4 gl_Position;
	static float3 vPositionSs;
	
	struct VS_INPUT
	{
	    float3 vPositionSs : POSITION0;
	};
	
	struct PS_INPUT
	{
	    float4 gl_Position : SV_Position;
	};
	
	void MainVs_inner()
	{
	    float4 _22489 = float4(vPositionSs, 1.0f);
	    _22489.y = -vPositionSs.y;
	    gl_Position = _22489;
	}
	
	PS_INPUT MainVs(VS_INPUT stage_input)
	{
	    vPositionSs = stage_input.vPositionSs;
	    MainVs_inner();
	    PS_INPUT stage_output;
	    stage_output.gl_Position = gl_Position;
	    return stage_output;
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
}

PS
{
	DynamicCombo( D_DOWNSAMPLE_MODE, 0..1 );
	
	Texture2D g_tInput < Attribute("InputTexture"); SrgbRead(true); >;
	float4 g_vInvTexDim < Source(InvTextureDim); SourceArg(g_tInput) UiType(VectorText); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	cbuffer _Globals_ : register(b0, space1)
	{
	    float4 _Globals_1_g_vInvTexDim : packoffset(c0);
	};
	
	Texture2D<float4> g_tInput : register(t30, space1);
	SamplerState Filter_MinMagLinearMipPoint : register(s14, space1);
	
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
	    output_0 = g_tInput.SampleLevel(Filter_MinMagLinearMipPoint, (gl_FragCoord.xy * (_Globals_1_g_vInvTexDim.xy * 2.0f)).xy, 0.0f);
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
