//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Shader used by occlusion query proxy rendering";
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
	Feature( F_DEPTH_TEST, 0..1, "" );
	Feature( F_DEBUG_DRAW_OCCLUDER, 0..1, "" );
}

COMMON
{
	#include "system.fxc"
}

struct VS_INPUT
{
	float3 m_vPositionWs : POSITION0  < Semantic( PosXyz ); >;                                    
};

VS
{
	
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	cbuffer PerViewConstantBuffer_t : register(b0, space0)
	{
	    column_major float4x4 PerViewConstantBuffer_t_1_m0 : packoffset(c0);
	    float4 PerViewConstantBuffer_t_1_m1 : packoffset(c24);
	};
	
	
	static float4 gl_Position;
	static float3 m_vPositionWs;
	
	struct VS_INPUT
	{
	    float3 m_vPositionWs : POSITION0;
	};
	
	struct PS_INPUT
	{
	    float4 gl_Position : SV_Position;
	};
	
	void MainVs_inner()
	{
	    float4 _19149 = mul(PerViewConstantBuffer_t_1_m0, (float4(m_vPositionWs.xyz, 1.0f) + (PerViewConstantBuffer_t_1_m1 * 1.0f)).xyzw);
	    _19149.y = -_19149.y;
	    gl_Position = _19149;
	}
	
	PS_INPUT MainVs(VS_INPUT stage_input)
	{
	    m_vPositionWs = stage_input.m_vPositionWs;
	    MainVs_inner();
	    PS_INPUT stage_output;
	    stage_output.gl_Position = gl_Position;
	    return stage_output;
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
}

PS
{
	StaticCombo( S_DEPTH_TEST, F_DEPTH_TEST );
	StaticCombo( S_DEBUG_DRAW_OCCLUDER, F_DEBUG_DRAW_OCCLUDER );
	StaticCombo( S_REVERSE_DEPTH_BUFFER, 0..1 );
	
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
