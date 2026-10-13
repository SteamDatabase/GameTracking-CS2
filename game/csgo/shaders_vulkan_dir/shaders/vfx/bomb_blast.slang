//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Bomb Blast";
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
	float4 vTexCoord   : TEXCOORD0  < Semantic( texcoord ); >;                                    
};

VS
{
	
	[[layer_constant]] ExternalDescriptorSet g_globalLateBoundBindlessSet < Source(ExternalDescSet); Attribute("g_globalLateBoundBindlessSet"); >;
	[[layer_constant]] ExternalDescriptorSet g_lightBinnerGpuSet < Source(ExternalDescSet); Attribute("g_lightBinnerGpuSet"); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	cbuffer PerViewConstantBuffer_t : register(b0, space0)
	{
	    column_major float4x4 PerViewConstantBuffer_t_1_m0 : packoffset(c4);
	    float3 PerViewConstantBuffer_t_1_m1 : packoffset(c26);
	};
	
	
	static float4 gl_Position;
	static float3 vPositionSs;
	static float2 vTexCoord;
	static float3 output_0;
	
	struct VS_INPUT
	{
	    float3 vPositionSs : POSITION0;
	    float2 vTexCoord : TEXCOORD0;
	};
	
	struct PS_INPUT
	{
	    float3 output_0 : TEXCOORD0;
	    float4 gl_Position : SV_Position;
	};
	
	void MainVs_inner()
	{
	    float4 _14817 = float4(vPositionSs, 1.0f);
	    float4 _14015 = mul(PerViewConstantBuffer_t_1_m0, float4((vTexCoord.x * 2.0f) - 1.0f, ((1.0f - vTexCoord.y) * 2.0f) - 1.0f, 1.0f, 1.0f));
	    _14817.y = -vPositionSs.y;
	    gl_Position = _14817;
	    output_0 = normalize((_14015.xyz / _14015.w.xxx) - PerViewConstantBuffer_t_1_m1);
	}
	
	PS_INPUT MainVs(VS_INPUT stage_input)
	{
	    vPositionSs = stage_input.vPositionSs;
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
	
	[[layer_constant]] ExternalDescriptorSet g_globalLateBoundBindlessSet < Source(ExternalDescSet); Attribute("g_globalLateBoundBindlessSet"); >;
	[[layer_constant]] ExternalDescriptorSet g_lightBinnerGpuSet < Source(ExternalDescSet); Attribute("g_lightBinnerGpuSet"); >;
	Texture2D g_tBlueNoise < Attribute("BlueNoise"); SrgbRead(false); >;
	Texture2D g_tFramebufferColor < Attribute("FramebufferInputColor"); SrgbRead(true); >;
	Texture2D g_tFramebufferDepth < Attribute("FramebufferInputDepth"); SrgbRead(false); >;
	float3 g_vBlastPosSS < Attribute("BlastPosSS"); UiType(VectorText); >;
	float4 g_vBlastPosWSAndTime < Attribute("BlastPosWS"); UiType(VectorText); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	static float4 _3;
	
	cbuffer _Globals_ : register(b0, space1)
	{
	    float4 _Globals_1_g_vBlastPosWSAndTime : packoffset(c0);
	    float3 _Globals_1_g_vBlastPosSS : packoffset(c1);
	};
	
	cbuffer PerViewConstantBuffer_t : register(b1, space1)
	{
	    float4 PerViewConstantBuffer_t_1_m0 : packoffset(c16);
	    float PerViewConstantBuffer_t_1_m1 : packoffset(c18.w);
	    float2 PerViewConstantBuffer_t_1_m2 : packoffset(c19);
	    float2 PerViewConstantBuffer_t_1_m3 : packoffset(c20);
	    float2 PerViewConstantBuffer_t_1_m4 : packoffset(c21);
	    float PerViewConstantBuffer_t_1_m5 : packoffset(c23);
	    float PerViewConstantBuffer_t_1_m6 : packoffset(c23.y);
	    float3 PerViewConstantBuffer_t_1_m7 : packoffset(c26);
	    float3 PerViewConstantBuffer_t_1_m8 : packoffset(c28);
	};
	
	cbuffer PerViewConstantBufferCsgo_t : register(b2, space1)
	{
	    int2 PerViewConstantBufferCsgo_t_1_m0 : packoffset(c11);
	};
	
	Texture2D<float4> g_tFramebufferDepth : register(t31, space1);
	Texture2D<float4> g_tBlueNoise : register(t32, space1);
	Texture2D<float4> g_tFramebufferColor : register(t30, space1);
	SamplerState DefaultSamplerState_0 : register(s14, space1);
	
	static float4 gl_FragCoord;
	static float3 input_0;
	static float4 output_0;
	
	struct PS_INPUT
	{
	    float3 input_0 : TEXCOORD0;
	    float4 gl_FragCoord : SV_Position;
	};
	
	struct PS_OUTPUT
	{
	    float4 output_0 : SV_Target0;
	};
	
	void MainPs_inner()
	{
	    float _6552 = clamp(_Globals_1_g_vBlastPosWSAndTime.w, 0.0f, 10.0f);
	    int2 _17364 = int2(gl_FragCoord.xy);
	    int2 _11700 = int3(_17364, 0).xy;
	    float3 _12686 = (-normalize(input_0.xyz)).xyz;
	    float3 _13517 = (PerViewConstantBuffer_t_1_m7.xyz + (_12686 * (1.0f / (((saturate((g_tFramebufferDepth.Load(int3(_11700, 0)).x - PerViewConstantBuffer_t_1_m5) / (PerViewConstantBuffer_t_1_m6 - PerViewConstantBuffer_t_1_m5)) * PerViewConstantBuffer_t_1_m0.z) + PerViewConstantBuffer_t_1_m0.w) * dot(PerViewConstantBuffer_t_1_m8.xyz, _12686))))).xyz;
	    float _23870 = distance(PerViewConstantBuffer_t_1_m7, _13517);
	    float _12116 = _6552 * 3000.0f;
	    float _19346 = distance(_Globals_1_g_vBlastPosWSAndTime.xyz, _13517);
	    float _3109 = smoothstep(_12116 + 40.0f, _12116, _19346) * pow(smoothstep(_12116 - 3000.0f, _12116, _19346), 2.0f);
	    float2 _4328 = ((gl_FragCoord.xy - PerViewConstantBuffer_t_1_m3.xy).xy * PerViewConstantBuffer_t_1_m4.xy).xy * PerViewConstantBuffer_t_1_m2;
	    float2 _5763 = (_Globals_1_g_vBlastPosSS.xy * PerViewConstantBuffer_t_1_m2) - _4328.xy;
	    float2 _18815 = normalize(_5763);
	    float _21107 = (_3109 * 0.02999999932944774627685546875f) * ((saturate(saturate(length(_5763)) * 2.0f) * 0.99989998340606689453125f) + 9.9999997473787516355514526367188e-05f);
	    float _6835 = frac(PerViewConstantBuffer_t_1_m1 + g_tBlueNoise.Load(int3(int3(_17364 & PerViewConstantBufferCsgo_t_1_m0, 0).xy, 0)).y) - 0.5f;
	    float4 _13155;
	    _13155 = 0.0f.xxxx;
	    int _9908;
	    float4 _17376;
	    int _16208 = 0;
	    for (;;)
	    {
	        if (!(_16208 < 32))
	        {
	            break;
	        }
	        _17376 = _13155 + g_tFramebufferColor.Sample(DefaultSamplerState_0, lerp(clamp(_4328 + ((_18815 * _21107) * ((float(_16208 - 16) * 0.0625f) + _6835)), 0.0f.xx, 1.0f.xx), 0.5f.xx, 0.02999999932944774627685546875f.xx).xy);
	        _9908 = _16208 + 1;
	        _13155 = _17376;
	        _16208 = _9908;
	        continue;
	    }
	    float3 _12937 = (_13155 * 0.03125f).xyz;
	    float3 _22087 = _12937 + pow(_12937, 8.0f.xxx);
	    float4 _20488;
	    _20488.x = _22087.x;
	    _20488.y = _22087.y;
	    _20488.z = _22087.z;
	    float3 _10910 = lerp(lerp(g_tFramebufferColor.Load(int3(_11700, 0)).xyz, _20488.xyz, ((_3109 * smoothstep(30.0f, 80.0f, _23870)) * smoothstep(6000.0f, 5000.0f, _23870)).xxx).xyz, float3(0.310000002384185791015625f, 0.300000011920928955078125f, 0.2899999916553497314453125f), (pow(smoothstep(_12116, _12116 - 5000.0f, distance(_Globals_1_g_vBlastPosWSAndTime.xyz, PerViewConstantBuffer_t_1_m7)), 2.0f) * 0.20000000298023223876953125f).xxx);
	    output_0 = float4(_10910, smoothstep(10.0f, 3.0f, _6552));
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
