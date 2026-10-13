//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Health Boost Postprocess Effect";
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
	
	float g_flAmount < Attribute("HealthBoostEffectAmount"); UiType(Slider); >;
	Texture2D g_tFramebuffer < Attribute("FramebufferInput"); SrgbRead(true); >;
	Texture2D g_tHealthBoost < Channel(RGBA, None(HealthBoostTexture), Linear); OutputFormat(DXT1); SrgbRead(false); >;
	
	// Color
	CreateInputTexture2D(HealthBoostTexture, Srgb, 8, "", "", "Color", Default4(1, 1, 1, 0));
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	cbuffer PerViewConstantBuffer_t : register(b1, space1)
	{
	    float2 PerViewConstantBuffer_t_1_m0 : packoffset(c19);
	    float2 PerViewConstantBuffer_t_1_m1 : packoffset(c20);
	    float2 PerViewConstantBuffer_t_1_m2 : packoffset(c21);
	};
	
	cbuffer _Globals_ : register(b0, space1)
	{
	    float _Globals_1_g_flAmount : packoffset(c0);
	};
	
	Texture2D<float4> g_tFramebuffer : register(t31, space1);
	SamplerState DefaultSamplerState_0 : register(s15, space1);
	Texture2D<float4> g_tHealthBoost : register(t30, space1);
	SamplerState AddressU_Clamp_AddressV_Clamp : register(s14, space1);
	
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
	    float2 _22399 = (gl_FragCoord.xy - PerViewConstantBuffer_t_1_m1.xy).xy * PerViewConstantBuffer_t_1_m2.xy;
	    float2 _19425 = _22399.xy;
	    float2 _3363 = _19425 - 0.5f.xx;
	    float2 _11825 = normalize(_3363);
	    float _24990 = length(_3363);
	    float2 _4328 = _19425 - (((_11825 * pow(_24990, 5.0f)) * _Globals_1_g_flAmount) * 0.60000002384185791015625f);
	    float2 _3280 = (_11825 * pow(smoothstep(0.0500000007450580596923828125f, 1.0f, _24990), 0.5f)) * _Globals_1_g_flAmount;
	    float3 _22360 = float3(g_tFramebuffer.Sample(DefaultSamplerState_0, (PerViewConstantBuffer_t_1_m0 * (_4328 - (_3280 * 0.014999999664723873138427734375f))).xy).x, g_tFramebuffer.Sample(DefaultSamplerState_0, (PerViewConstantBuffer_t_1_m0 * (_4328 - (_3280 * 0.0199999995529651641845703125f))).xy).y, g_tFramebuffer.Sample(DefaultSamplerState_0, (PerViewConstantBuffer_t_1_m0 * (_4328 - (_3280 * 0.02500000037252902984619140625f))).xy).z) + ((g_tHealthBoost.Sample(AddressU_Clamp_AddressV_Clamp, _22399.xy).xyz * _Globals_1_g_flAmount) * 0.5f);
	    float3 _7213 = _22360 * 1.5f;
	    _7213.x = _7213.x * 0.800000011920928955078125f;
	    output_0 = float4(lerp(_22360.xyz, _7213, _Globals_1_g_flAmount.xxx), 1.0f);
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
