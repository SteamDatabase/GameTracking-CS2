//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Player Visibility Stencil Proxy (box version of player model)";
	DevShader = true;
	Version = 1;
	
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
	float3 vPositionOs : POSITION0  < Semantic( PosXyz ); >;                                      
};

VS
{
	
	float g_flProxyScale < Default(1); Attribute("g_flProxyScale"); UiType(Slider); >;
	[[layer_constant]] ExternalDescriptorSet g_globalLateBoundBindlessSet < Source(ExternalDescSet); Attribute("g_globalLateBoundBindlessSet"); >;
	[[layer_constant]] ExternalDescriptorSet g_lightBinnerGpuSet < Source(ExternalDescSet); Attribute("g_lightBinnerGpuSet"); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	struct _791
	{
	    column_major float4x3 _m0[32];
	};
	
	cbuffer _Globals_ : register(b0, space0)
	{
	    float _Globals_1_g_flProxyScale : packoffset(c0);
	};
	
	cbuffer StencilProxyConstantBuffer_t : register(b3, space0)
	{
	    _791 StencilProxyConstantBuffer_t_1_m0 : packoffset(c0);
	};
	
	cbuffer PerViewConstantBuffer_t : register(b1, space0)
	{
	    column_major float4x4 PerViewConstantBuffer_t_1_m0 : packoffset(c0);
	    float4 PerViewConstantBuffer_t_1_m1 : packoffset(c24);
	    float3 PerViewConstantBuffer_t_1_m2 : packoffset(c26);
	};
	
	
	static float4 gl_Position;
	static int gl_InstanceIndex;
	static int gl_BaseInstanceARB;
	cbuffer SPIRV_Cross_VertexInfo
	{
	    int SPIRV_Cross_BaseVertex;
	    int SPIRV_Cross_BaseInstance;
	};
	
	static float3 vPositionOs;
	
	struct VS_INPUT
	{
	    float3 vPositionOs : POSITION0;
	    uint gl_InstanceIndex : SV_InstanceID;
	};
	
	struct PS_INPUT
	{
	    float4 gl_Position : SV_Position;
	};
	
	void MainVs_inner()
	{
	    float3 _13397 = mul(float4(vPositionOs.xyz * _Globals_1_g_flProxyScale, 1.0f), StencilProxyConstantBuffer_t_1_m0._m0[uint(gl_InstanceIndex - gl_BaseInstanceARB)]).xyz;
	    float4 _19149 = mul(PerViewConstantBuffer_t_1_m0, (float4((_13397 + (normalize(PerViewConstantBuffer_t_1_m2.xyz - _13397) * 8.0f)).xyz, 1.0f) + (PerViewConstantBuffer_t_1_m1 * 1.0f)).xyzw);
	    _19149.y = -_19149.y;
	    gl_Position = _19149;
	}
	
	PS_INPUT MainVs(VS_INPUT stage_input)
	{
	    gl_InstanceIndex = int(stage_input.gl_InstanceIndex);
	    gl_BaseInstanceARB = SPIRV_Cross_BaseInstance;
	    vPositionOs = stage_input.vPositionOs;
	    MainVs_inner();
	    PS_INPUT stage_output;
	    stage_output.gl_Position = gl_Position;
	    return stage_output;
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
}

PS
{
	
	RenderState(StencilRef, 1);
	[[layer_constant]] ExternalDescriptorSet g_globalLateBoundBindlessSet < Source(ExternalDescSet); Attribute("g_globalLateBoundBindlessSet"); >;
	[[layer_constant]] ExternalDescriptorSet g_lightBinnerGpuSet < Source(ExternalDescSet); Attribute("g_lightBinnerGpuSet"); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	static float4 output_0;
	
	struct PS_OUTPUT
	{
	    float4 output_0 : SV_Target0;
	};
	
	void MainPs_inner()
	{
	    output_0 = float4(1.0f, 0.0f, 0.0f, 1.0f);
	}
	
	PS_OUTPUT MainPs()
	{
	    MainPs_inner();
	    PS_OUTPUT stage_output;
	    stage_output.output_0 = output_0;
	    return stage_output;
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
}
