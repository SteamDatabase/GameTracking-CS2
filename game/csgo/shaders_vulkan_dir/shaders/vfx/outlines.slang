//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Outlines Postprocess";
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
	DynamicCombo( D_PULSE, 0..1 );
	
	float g_flKernelWidth < Default(0.00065); Attribute("OutlineWidth"); UiType(Slider); >;
	Texture2D g_tOutlineInput < Attribute("OutlineInput"); SrgbRead(false); >;
	Texture2D g_tPulse < Channel(RGBA, None(PulseTexture), Linear); OutputFormat(DXT1); SrgbRead(true); >;
	
	// Color
	CreateInputTexture2D(PulseTexture, Srgb, 8, "", "", "Color", Default4(1, 1, 1, 0));
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	static const float2 _2495[5] = { float2(2.0f, 1.0f), float2(1.0f, -2.0f), float2(-2.0f, -1.0f), float2(-1.0f, 2.0f), 0.0f.xx };
	
	cbuffer PerViewConstantBuffer_t : register(b1, space1)
	{
	    float4 PerViewConstantBuffer_t_1_m0 : packoffset(c22);
	};
	
	cbuffer _Globals_ : register(b0, space1)
	{
	    float _Globals_1_g_flKernelWidth : packoffset(c0);
	};
	
	Texture2D<float4> g_tOutlineInput : register(t30, space1);
	SamplerState Filter_MinMagMipPoint : register(s14, space1);
	
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
	    float2 _21411 = gl_FragCoord.xy * PerViewConstantBuffer_t_1_m0.xy;
	    float2 _11542 = _21411.xy;
	    float _18441 = length(_21411.xy - 0.5f.xx);
	    float _25006 = lerp(_Globals_1_g_flKernelWidth, 0.0f, _18441);
	    float4 _13136;
	    float _16324;
	    _13136 = 0.0f.xxxx;
	    _16324 = 0.0f;
	    int _9583;
	    float _18147;
	    float4 _22315;
	    int _17017 = 0;
	    for (;;)
	    {
	        if (!(_17017 < 5))
	        {
	            break;
	        }
	        float4 _3300 = g_tOutlineInput.Sample(Filter_MinMagMipPoint, (_11542 + (_2495[_17017] * _25006)).xy);
	        _22315 = _13136 + _3300;
	        _18147 = _16324 + step((_3300.x + _3300.y) + _3300.z, 0.0f);
	        _9583 = _17017 + 1;
	        _13136 = _22315;
	        _16324 = _18147;
	        _17017 = _9583;
	        continue;
	    }
	    float4 _22348 = _13136 * 0.20000000298023223876953125f;
	    float _17342 = abs((_16324 * 0.20000000298023223876953125f) - 0.5f) * 2.0f;
	    if ((0.999000012874603271484375f - _17342) < 0.0f)
	    {
	        discard;
	    }
	    float3 _12939 = (_22348.xyz * ((1.0f - _17342) * 4.0f)) * smoothstep(-0.20000000298023223876953125f, 0.4000000059604644775390625f, 0.60000002384185791015625f - _18441);
	    float4 _8673 = _22348;
	    _8673.x = _12939.x;
	    _8673.y = _12939.y;
	    _8673.z = _12939.z;
	    output_0 = _8673;
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
