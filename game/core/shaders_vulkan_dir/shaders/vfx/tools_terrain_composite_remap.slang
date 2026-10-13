//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Terrain composite shader wich remaps values";
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
	float3 vPosition : POSITION0  < Semantic( PosXyz ); >;                                        
	float2 vTexCoord : TEXCOORD0  < Semantic( LowPrecisionUv ); >;                                
};

VS
{
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	static float _2;
	
	static float4 gl_Position;
	static float3 vPosition;
	static float2 vTexCoord;
	static float2 output_0;
	
	struct VS_INPUT
	{
	    float3 vPosition : POSITION0;
	    float2 vTexCoord : TEXCOORD0;
	};
	
	struct PS_INPUT
	{
	    float2 output_0 : TEXCOORD0;
	    float4 gl_Position : SV_Position;
	};
	
	void MainVs_inner()
	{
	    float4 _14456 = float4(vPosition.x, _2, 1.0f, 1.0f);
	    output_0 = vTexCoord;
	    _14456.y = vPosition.y;
	    gl_Position = _14456;
	}
	
	PS_INPUT MainVs(VS_INPUT stage_input)
	{
	    vPosition = stage_input.vPosition;
	    vTexCoord = stage_input.vTexCoord;
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
	
	
	// Inputs
	Texture2D g_tInput < Attribute("Source"); SrgbRead(false); >;
	
	// Parameters
	float g_vInputMax < Default(1); Attribute("Input Maximum"); UiType(Slider); UiGroup("Parameters"); >;
	float g_vInputMin < Attribute("Input Minimum"); UiType(Slider); UiGroup("Parameters"); >;
	float g_vOutputMax < Default(1); Attribute("Output Maximum"); UiType(Slider); UiGroup("Parameters"); >;
	float g_vOutputMin < Attribute("Output Minimum"); UiType(Slider); UiGroup("Parameters"); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	cbuffer _Globals_ : register(b0, space1)
	{
	    float _Globals_1_g_vInputMin : packoffset(c0);
	    float _Globals_1_g_vInputMax : packoffset(c0.y);
	    float _Globals_1_g_vOutputMin : packoffset(c0.z);
	    float _Globals_1_g_vOutputMax : packoffset(c0.w);
	};
	
	Texture2D<float4> g_tInput : register(t30, space1);
	SamplerState AddressU_Clamp_AddressV_Clamp_Filter_MinMagMipPoint : register(s14, space1);
	
	static float2 input_0;
	static float4 output_0;
	
	struct PS_INPUT
	{
	    float2 input_0 : TEXCOORD0;
	};
	
	struct PS_OUTPUT
	{
	    float4 output_0 : SV_Target0;
	};
	
	void MainPs_inner()
	{
	    output_0 = lerp(_Globals_1_g_vOutputMin.xxxx, _Globals_1_g_vOutputMax.xxxx, min(1.0f.xxxx, max(0.0f.xxxx, g_tInput.Sample(AddressU_Clamp_AddressV_Clamp_Filter_MinMagMipPoint, input_0.xy) - _Globals_1_g_vInputMin.xxxx) / (_Globals_1_g_vInputMax - _Globals_1_g_vInputMin).xxxx));
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
	
	
	
	BoolAttribute(terrain_composite, true);
	
}
