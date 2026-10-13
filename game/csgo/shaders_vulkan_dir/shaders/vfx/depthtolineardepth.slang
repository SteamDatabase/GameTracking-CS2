//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "MBOIT final combine with scene";
	DevShader = true;
	Version = 0;
	
	// Platform: VULKAN_SM_50
	// Programs: ps, vs
}

MODES
{
	Default();
	CsgoForward();
	ToolsVis();
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
	float4 vPositionPs            : POSITION0  < Semantic( position ); >;                         
	float4 vCameraToFarPlaneRayWs : TEXCOORD0  < Semantic( CameraToFarPlaneRayWs ); >;            
};

VS
{
	DynamicCombo( D_UPSCALE_MIXED, 0..1 );
	
	[[layer_constant]] ExternalDescriptorSet g_globalLateBoundBindlessSet < Source(ExternalDescSet); Attribute("g_globalLateBoundBindlessSet"); >;
	[[layer_constant]] ExternalDescriptorSet g_lightBinnerGpuSet < Source(ExternalDescSet); Attribute("g_lightBinnerGpuSet"); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	static float4 gl_Position;
	static float2 vPositionPs;
	static float3 vCameraToFarPlaneRayWs;
	static float3 output_0;
	
	struct VS_INPUT
	{
	    float2 vPositionPs : POSITION0;
	    float3 vCameraToFarPlaneRayWs : TEXCOORD0;
	};
	
	struct PS_INPUT
	{
	    float3 output_0 : TEXCOORD0;
	    float4 gl_Position : SV_Position;
	};
	
	void MainVs_inner()
	{
	    float4 _14456 = float4(vPositionPs, 0.0f, 1.0f);
	    output_0 = vCameraToFarPlaneRayWs;
	    _14456.y = -vPositionPs.y;
	    gl_Position = _14456;
	}
	
	PS_INPUT MainVs(VS_INPUT stage_input)
	{
	    vPositionPs = stage_input.vPositionPs;
	    vCameraToFarPlaneRayWs = stage_input.vCameraToFarPlaneRayWs;
	    MainVs_inner();
	    PS_INPUT stage_output;
	    stage_output.gl_Position = gl_Position;
	    stage_output.output_0 = output_0;
	    return stage_output;
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
}

PS
{
	DynamicCombo( D_UPSCALE_MIXED, 0..1 );
	
	[[layer_constant]] ExternalDescriptorSet g_globalLateBoundBindlessSet < Source(ExternalDescSet); Attribute("g_globalLateBoundBindlessSet"); >;
	[[layer_constant]] ExternalDescriptorSet g_lightBinnerGpuSet < Source(ExternalDescSet); Attribute("g_lightBinnerGpuSet"); >;
	Texture2D g_tDepthTexture < Attribute("SceneDepth"); SrgbRead(false); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	cbuffer PerViewConstantBuffer_t : register(b0, space1)
	{
	    float4 PerViewConstantBuffer_t_1_m0 : packoffset(c16);
	    float PerViewConstantBuffer_t_1_m1 : packoffset(c23);
	    float PerViewConstantBuffer_t_1_m2 : packoffset(c23.y);
	    float3 PerViewConstantBuffer_t_1_m3 : packoffset(c28);
	};
	
	Texture2D<float4> g_tDepthTexture : register(t30, space1);
	
	static float4 gl_FragCoord;
	static float3 input_0;
	static float output_0;
	
	struct PS_INPUT
	{
	    float3 input_0 : TEXCOORD0;
	    float4 gl_FragCoord : SV_Position;
	};
	
	struct PS_OUTPUT
	{
	    float output_0 : SV_Target0;
	};
	
	void MainPs_inner()
	{
	    output_0 = 1.0f / (((saturate((g_tDepthTexture.Load(int3(int3(int2(gl_FragCoord.xy), 0).xy, 0)).x - PerViewConstantBuffer_t_1_m1) / (PerViewConstantBuffer_t_1_m2 - PerViewConstantBuffer_t_1_m1)) * PerViewConstantBuffer_t_1_m0.z) + PerViewConstantBuffer_t_1_m0.w) * dot(PerViewConstantBuffer_t_1_m3.xyz, normalize(input_0)));
	}
	
	PS_OUTPUT MainPs(PS_INPUT stage_input)
	{
	    gl_FragCoord = stage_input.gl_FragCoord;
	    gl_FragCoord.w = 1.0 / gl_FragCoord.w;
	    input_0 = stage_input.input_0;
	    MainPs_inner();
	    PS_OUTPUT stage_output;
	    stage_output.output_0 = output_0;
	    return stage_output;
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
}
