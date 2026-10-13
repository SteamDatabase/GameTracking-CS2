//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Device Generated Command test shader for rendersystemtest";
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
	float4 vColor      : COLOR0     < Semantic( Color ); >;                                       
	float4 vPositionOs : POSITION0  < Semantic( Pos ); >;                                         
};

VS
{
	DynamicCombo( D_SHADER_VARIANT, 0..1 );
	
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	cbuffer DGCTestPushConstant
	{
	    float4 DGCTestPushConstant_1_m0 : packoffset(c0);
	    float4 DGCTestPushConstant_1_m1 : packoffset(c1);
	};
	
	
	static float4 gl_Position;
	static float3 vPositionOs;
	static float4 vColor;
	static float4 output_0;
	
	struct VS_INPUT
	{
	    float3 vPositionOs : POSITION0;
	    float4 vColor : COLOR0;
	};
	
	struct PS_INPUT
	{
	    float4 output_0 : TEXCOORD0;
	    float4 gl_Position : SV_Position;
	};
	
	void MainVs_inner()
	{
	    float3 _7673 = vPositionOs.xyz + DGCTestPushConstant_1_m0.xyz;
	    float4 _13745 = float4(_7673, 1.0f);
	    output_0 = DGCTestPushConstant_1_m1.xyzw * vColor;
	    _13745.y = -_7673.y;
	    gl_Position = _13745;
	}
	
	PS_INPUT MainVs(VS_INPUT stage_input)
	{
	    vPositionOs = stage_input.vPositionOs;
	    vColor = stage_input.vColor;
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
	DynamicCombo( D_SHADER_VARIANT, 0..1 );
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	static float4 input_0;
	static float4 output_0;
	
	struct PS_INPUT
	{
	    float4 input_0 : TEXCOORD0;
	};
	
	struct PS_OUTPUT
	{
	    float4 output_0 : SV_Target0;
	};
	
	void MainPs_inner()
	{
	    output_0 = input_0;
	}
	
	PS_OUTPUT MainPs(PS_INPUT stage_input)
	{
	    input_0 = stage_input.input_0;
	    MainPs_inner();
	    PS_OUTPUT stage_output;
	    stage_output.output_0 = output_0;
	    return stage_output;
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
}
