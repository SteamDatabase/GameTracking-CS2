//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Not a real shader, a place to test out slang syntax and make sure it works with our parser.";
	DevShader = true;
	Version = 0;
	
	// Platform: VULKAN_SM_60
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
	float4 vNormalOs   : NORMAL0    < Semantic( Normal ); >;                                      
	float4 vPositionOs : POSITION0  < Semantic( Pos ); >;                                         
	float4 vUv0        : TEXCOORD0  < Semantic( TexCoord ); >;                                    
};

VS
{
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	static float4 gl_Position;
	static float3 vPositionOs;
	static float2 vUv0;
	static float4 vNormalOs;
	static float3 output_0;
	static float2 output_1;
	
	struct VS_INPUT
	{
	    float3 vPositionOs : POSITION0;
	    float4 vNormalOs : NORMAL0;
	    float2 vUv0 : TEXCOORD0;
	};
	
	struct PS_INPUT
	{
	    float3 output_0 : TEXCOORD0;
	    float2 output_1 : TEXCOORD1;
	    float4 gl_Position : SV_Position;
	};
	
	void MainVs_inner()
	{
	    float4 _14437 = float4(vPositionOs, 1.0f);
	    output_0 = float3(vNormalOs.xyz);
	    output_1 = vUv0;
	    _14437.y = -vPositionOs.y;
	    gl_Position = _14437;
	}
	
	PS_INPUT MainVs(VS_INPUT stage_input)
	{
	    vPositionOs = stage_input.vPositionOs;
	    vUv0 = stage_input.vUv0;
	    vNormalOs = stage_input.vNormalOs;
	    MainVs_inner();
	    PS_INPUT stage_output;
	    stage_output.gl_Position = gl_Position;
	    stage_output.output_0 = output_0;
	    stage_output.output_1 = output_1;
	    return stage_output;
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
}

PS
{
	
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
