//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Texture Generator for Position Map";
	DevShader = true;
	Version = 0;
	
	// Platform: VULKAN_SM_50
	// Programs: ps, vs
}

MODES
{
	Default();
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
	float4 vNormalOs : NORMAL0    < Semantic( Normal ); >;                                        
	float3 vPosition : POSITION0  < Semantic( PosXyz ); >;                                        
	float2 vTexCoord : TEXCOORD0  < Semantic( LowPrecisionUv ); >;                                
};

VS
{
	
	float g_flNormalOffset < Attribute("NormalBias"); UiType(Slider); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	cbuffer _Globals_ : register(b0, space0)
	{
	    float _Globals_1_g_flNormalOffset : packoffset(c0);
	};
	
	
	static float4 gl_Position;
	static float2 vTexCoord;
	static float3 vPosition;
	static float3 vNormalOs;
	static float3 output_0;
	
	struct VS_INPUT
	{
	    float3 vPosition : POSITION0;
	    float2 vTexCoord : TEXCOORD0;
	    float3 vNormalOs : NORMAL0;
	};
	
	struct PS_INPUT
	{
	    float3 output_0 : TEXCOORD0;
	    float4 gl_Position : SV_Position;
	};
	
	void MainVs_inner()
	{
	    float2 _7080 = (float2(vTexCoord.x, 1.0f - vTexCoord.y) - 0.5f.xx) * 2.0f;
	    float4 _14779 = float4(_7080, 1.0f, 1.0f);
	    float3 _23482;
	    if (_Globals_1_g_flNormalOffset != 0.0f)
	    {
	        _23482 = vPosition.xyz + (normalize(vNormalOs.xyz) * _Globals_1_g_flNormalOffset);
	    }
	    else
	    {
	        _23482 = vPosition.xyz;
	    }
	    output_0 = _23482;
	    _14779.y = -_7080.y;
	    gl_Position = _14779;
	}
	
	PS_INPUT MainVs(VS_INPUT stage_input)
	{
	    vTexCoord = stage_input.vTexCoord;
	    vPosition = stage_input.vPosition;
	    vNormalOs = stage_input.vNormalOs;
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
	DynamicCombo( D_SOURCE1SWIZZLE, 0..1 );
	
	float g_flBoundsScale < Default(1); Attribute("BoundsScale"); UiType(Slider); >;
	float3 g_vBoundsOffset < Attribute("BoundsOffset"); UiType(VectorText); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	cbuffer _Globals_ : register(b0, space1)
	{
	    float3 _Globals_1_g_vBoundsOffset : packoffset(c0);
	    float _Globals_1_g_flBoundsScale : packoffset(c0.w);
	};
	
	
	static float3 input_0;
	static float4 output_0;
	
	struct PS_INPUT
	{
	    float3 input_0 : TEXCOORD0;
	};
	
	struct PS_OUTPUT
	{
	    float4 output_0 : SV_Target0;
	};
	
	void MainPs_inner()
	{
	    output_0 = float4((input_0.xyz + _Globals_1_g_vBoundsOffset) * _Globals_1_g_flBoundsScale, 1.0f);
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
