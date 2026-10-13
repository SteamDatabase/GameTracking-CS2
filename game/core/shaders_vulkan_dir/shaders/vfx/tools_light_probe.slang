//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Shader used in tools to render the reflection from an environment map. Meant to look like Paul Debevec's light probes. See www.debevec.org/probes";
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
	float4 vNormalWs   : NORMAL0    < Semantic( Normal ); >;                                      
	float3 vPositionWs : POSITION0  < Semantic( PosXyz ); >;                                      
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
	static float4 vPositionWs;
	static float4 vNormalWs;
	static float3 output_0;
	static float3 output_1;
	
	struct VS_INPUT
	{
	    float4 vPositionWs : POSITION0;
	    float4 vNormalWs : NORMAL0;
	};
	
	struct PS_INPUT
	{
	    float3 output_0 : TEXCOORD0;
	    float3 output_1 : TEXCOORD1;
	    float4 gl_Position : SV_Position;
	};
	
	void MainVs_inner()
	{
	    float4 _18241 = mul(PerViewConstantBuffer_t_1_m0, (float4(vPositionWs.xyz, 1.0f) + (PerViewConstantBuffer_t_1_m1 * 1.0f)).xyzw);
	    output_0 = vPositionWs.xyz;
	    output_1 = vNormalWs.xyz;
	    _18241.y = -_18241.y;
	    gl_Position = _18241;
	}
	
	PS_INPUT MainVs(VS_INPUT stage_input)
	{
	    vPositionWs = stage_input.vPositionWs;
	    vNormalWs = stage_input.vNormalWs;
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
	
	Texture2D g_tSkyRadiance < Attribute("CustomTexture0"); SrgbRead(false); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	cbuffer PerViewConstantBuffer_t : register(b0, space1)
	{
	    float3 PerViewConstantBuffer_t_1_m0 : packoffset(c26);
	};
	
	SamplerState AddressU_Wrap_AddressV_Clamp_Filter_MinMagMipLinear : register(s14, space1);
	Texture2D<float4> g_tSkyRadiance : register(t30, space1);
	
	static float3 input_1;
	static float3 input_0;
	static float4 output_0;
	
	struct PS_INPUT
	{
	    float3 input_0 : TEXCOORD0;
	    float3 input_1 : TEXCOORD1;
	};
	
	struct PS_OUTPUT
	{
	    float4 output_0 : SV_Target0;
	};
	
	void MainPs_inner()
	{
	    float3 _19258 = normalize(reflect(input_0.xyz - PerViewConstantBuffer_t_1_m0.xyz, normalize(input_1)));
	    float _7511 = acos(_19258.z) * 0.3183098733425140380859375f;
	    float2 _16582 = _19258.xy;
	    output_0 = g_tSkyRadiance.SampleGrad(AddressU_Wrap_AddressV_Clamp_Filter_MinMagMipLinear, float2(atan2(_19258.y, _19258.x) * 0.15915493667125701904296875f, _7511), float2(length(ddx(_16582)) * 0.15915493667125701904296875f, ddx(_7511)), float2(length(ddy(_16582)) * 0.15915493667125701904296875f, ddy(_7511)));
	}
	
	PS_OUTPUT MainPs(PS_INPUT stage_input)
	{
	    input_1 = stage_input.input_1;
	    input_0 = stage_input.input_0;
	    MainPs_inner();
	    PS_OUTPUT stage_output;
	    stage_output.output_0 = output_0;
	    return stage_output;
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
}
