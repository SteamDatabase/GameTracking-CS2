//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Skybox Blur";
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
	
	[[layer_constant]] ExternalDescriptorSet g_globalLateBoundBindlessSet < Source(ExternalDescSet); Attribute("g_globalLateBoundBindlessSet"); >;
	[[layer_constant]] ExternalDescriptorSet g_lightBinnerGpuSet < Source(ExternalDescSet); Attribute("g_lightBinnerGpuSet"); >;
	
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
	
	float g_flBlurStrength < Default(0.03); Attribute("SkyboxBlurStrength"); UiType(Slider); >;
	[[layer_constant]] ExternalDescriptorSet g_globalLateBoundBindlessSet < Source(ExternalDescSet); Attribute("g_globalLateBoundBindlessSet"); >;
	[[layer_constant]] ExternalDescriptorSet g_lightBinnerGpuSet < Source(ExternalDescSet); Attribute("g_lightBinnerGpuSet"); >;
	Texture2D g_tBlueNoise < Attribute("BlueNoise"); SrgbRead(false); >;
	Texture2D g_tFramebufferColor < Attribute("FramebufferInputColor"); SrgbRead(true); >;
	Texture2D g_tPreSkyboxDepth < Attribute("PreSkyboxDepth"); SrgbRead(false); >;
	float3 g_vBlurOriginSS < Attribute("BlurOriginSS"); UiType(VectorText); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	cbuffer PerViewConstantBuffer_t : register(b1, space1)
	{
	    float PerViewConstantBuffer_t_1_m0 : packoffset(c18.w);
	    float2 PerViewConstantBuffer_t_1_m1 : packoffset(c19);
	    float2 PerViewConstantBuffer_t_1_m2 : packoffset(c20);
	    float2 PerViewConstantBuffer_t_1_m3 : packoffset(c21);
	    float4 PerViewConstantBuffer_t_1_m4 : packoffset(c22);
	    float PerViewConstantBuffer_t_1_m5 : packoffset(c23);
	    float PerViewConstantBuffer_t_1_m6 : packoffset(c23.y);
	};
	
	cbuffer _Globals_ : register(b0, space1)
	{
	    float3 _Globals_1_g_vBlurOriginSS : packoffset(c0);
	    float _Globals_1_g_flBlurStrength : packoffset(c0.w);
	};
	
	cbuffer PerViewConstantBufferCsgo_t : register(b2, space1)
	{
	    int2 PerViewConstantBufferCsgo_t_1_m0 : packoffset(c11);
	};
	
	Texture2D<float4> g_tFramebufferColor : register(t30, space1);
	Texture2D<float4> g_tPreSkyboxDepth : register(t31, space1);
	Texture2D<float4> g_tBlueNoise : register(t32, space1);
	
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
	    int2 _17364 = int2(gl_FragCoord.xy);
	    int2 _11700 = int3(_17364, 0).xy;
	    float _10955 = PerViewConstantBuffer_t_1_m6 - PerViewConstantBuffer_t_1_m5;
	    if (!(saturate((g_tPreSkyboxDepth.Load(int3(_11700, 0)).x - PerViewConstantBuffer_t_1_m5) / _10955) >= 0.99989998340606689453125f))
	    {
	        discard;
	    }
	    float2 _4328 = ((gl_FragCoord.xy - PerViewConstantBuffer_t_1_m2.xy).xy * PerViewConstantBuffer_t_1_m3.xy).xy * PerViewConstantBuffer_t_1_m1;
	    float2 _5182 = (_Globals_1_g_vBlurOriginSS.xy * PerViewConstantBuffer_t_1_m1) - _4328.xy;
	    float _16749 = saturate(length(_5182));
	    if (_16749 < 9.9999997473787516355514526367188e-06f)
	    {
	        discard;
	    }
	    float2 _7717 = normalize(_5182);
	    float _10825 = _Globals_1_g_flBlurStrength * saturate(_16749 * 2.0f);
	    float _6835 = frac(PerViewConstantBuffer_t_1_m0 + g_tBlueNoise.Load(int3(int3(_17364 & PerViewConstantBufferCsgo_t_1_m0, 0).xy, 0)).y) - 0.5f;
	    float3 _13136;
	    float _16324;
	    _13136 = 0.0f.xxx;
	    _16324 = 0.0f;
	    float _3716;
	    float3 _4692;
	    int _11496;
	    int _17017 = 0;
	    for (;;)
	    {
	        if (!(_17017 < 32))
	        {
	            break;
	        }
	        int2 _11701 = int3(int2((clamp(_4328 + ((_7717 * _10825) * ((float(_17017 - 16) * 0.03125f) + _6835)), 0.0f.xx, 1.0f.xx) / PerViewConstantBuffer_t_1_m4.xy) + PerViewConstantBuffer_t_1_m2.xy), 0).xy;
	        float _3841 = float(saturate((g_tPreSkyboxDepth.Load(int3(_11701, 0)).x - PerViewConstantBuffer_t_1_m5) / _10955) >= 0.99989998340606689453125f);
	        _4692 = _13136 + (g_tFramebufferColor.Load(int3(_11701, 0)).xyz * _3841);
	        _3716 = _16324 + _3841;
	        _11496 = _17017 + 1;
	        _13136 = _4692;
	        _16324 = _3716;
	        _17017 = _11496;
	        continue;
	    }
	    float3 _19321;
	    if (_16324 > 0.0f)
	    {
	        _19321 = _13136 / _16324.xxx;
	    }
	    else
	    {
	        _19321 = g_tFramebufferColor.Load(int3(_11700, 0)).xyz;
	    }
	    output_0 = float4(_19321, 1.0f);
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
