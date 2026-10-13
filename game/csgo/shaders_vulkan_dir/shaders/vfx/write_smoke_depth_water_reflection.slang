//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Write Smoke Depth Water Reflection";
	DevShader = true;
	Version = 2;
	
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
	
	bool g_bForceMixedResolution < Attribute("ForcedMixedResolution"); UiType(CheckBox); >;
	[[layer_constant]] ExternalDescriptorSet g_globalLateBoundBindlessSet < Source(ExternalDescSet); Attribute("g_globalLateBoundBindlessSet"); >;
	[[layer_constant]] ExternalDescriptorSet g_lightBinnerGpuSet < Source(ExternalDescSet); Attribute("g_lightBinnerGpuSet"); >;
	Texture2D g_tBlueNoise < Attribute("BlueNoise"); SrgbRead(false); >;
	Texture2D g_tSmokeDepthHalf < Attribute("SmokeHalfDepth"); SrgbRead(false); >;
	Texture2D g_tSmokeDepthQuarter < Attribute("SmokeQuarterDepth"); SrgbRead(false); >;
	Texture2D g_tZeroth_Moment < Attribute("zeroth_moment"); SrgbRead(true); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	cbuffer _Globals_ : register(b0, space1)
	{
	    int _Globals_1_g_bForceMixedResolution : packoffset(c0);
	};
	
	cbuffer PerViewConstantBufferCsgo_t : register(b2, space1)
	{
	    int2 PerViewConstantBufferCsgo_t_1_m0 : packoffset(c11);
	};
	
	cbuffer PerViewConstantBuffer_t : register(b1, space1)
	{
	    column_major float4x4 PerViewConstantBuffer_t_1_m0 : packoffset(c8);
	    float PerViewConstantBuffer_t_1_m1 : packoffset(c23);
	    float PerViewConstantBuffer_t_1_m2 : packoffset(c23.y);
	    float PerViewConstantBuffer_t_1_m3 : packoffset(c23.z);
	    float PerViewConstantBuffer_t_1_m4 : packoffset(c23.w);
	    float3 PerViewConstantBuffer_t_1_m5 : packoffset(c26);
	    float3 PerViewConstantBuffer_t_1_m6 : packoffset(c28);
	    float3 PerViewConstantBuffer_t_1_m7 : packoffset(c29);
	};
	
	Texture2D<float4> g_tZeroth_Moment : register(t34, space1);
	Texture2D<float4> g_tBlueNoise : register(t30, space1);
	Texture2D<float4> g_tSmokeDepthHalf : register(t32, space1);
	Texture2D<float4> g_tSmokeDepthQuarter : register(t33, space1);
	
	static float4 gl_FragCoord;
	static float gl_FragDepth;
	struct PS_INPUT
	{
	    float4 gl_FragCoord : SV_Position;
	};
	
	struct PS_OUTPUT
	{
	    float gl_FragDepth : SV_Depth;
	};
	
	void MainPs_inner()
	{
	    float4 _21464 = g_tZeroth_Moment.Load(int3(int3(int2(gl_FragCoord.xy * ((_Globals_1_g_bForceMixedResolution != 0) ? 0.5f : 1.0f)), 0).xy, 0));
	    float _5649 = _21464.x;
	    float _6805;
	    if (_5649 > 0.0f)
	    {
	        float _12502;
	        if ((1.0f - exp(-_5649)) > lerp(0.800000011920928955078125f, g_tBlueNoise.Load(int3(int3(int2(gl_FragCoord.xy) & PerViewConstantBufferCsgo_t_1_m0, 0).xy, 0)).x, 0.20000000298023223876953125f))
	        {
	            float _16170 = min(g_tSmokeDepthHalf.Load(int3(int3(int2(gl_FragCoord.xy * 0.5f.xx), 0).xy, 0)).x, g_tSmokeDepthQuarter.Load(int3(int3(int2(gl_FragCoord.xy * 0.25f.xx), 0).xy, 0)).x);
	            float _12501;
	            if (_16170 != 2.0f)
	            {
	                float _17238 = log(PerViewConstantBuffer_t_1_m3);
	                _12501 = (saturate(((PerViewConstantBuffer_t_1_m7.x / mul(PerViewConstantBuffer_t_1_m0, float4((PerViewConstantBuffer_t_1_m5 + (PerViewConstantBuffer_t_1_m6 * ((exp((((_16170 + 1.0f) * 0.5f) * (log(PerViewConstantBuffer_t_1_m4) - _17238)) + _17238) * 1.03999996185302734375f) + 70.0f))).xyz, 1.0f).xyzw).z) - PerViewConstantBuffer_t_1_m7.z) / PerViewConstantBuffer_t_1_m7.y) * (PerViewConstantBuffer_t_1_m2 - PerViewConstantBuffer_t_1_m1)) + PerViewConstantBuffer_t_1_m1;
	            }
	            else
	            {
	                _12501 = 1.0f;
	            }
	            _12502 = _12501;
	        }
	        else
	        {
	            _12502 = 1.0f;
	        }
	        _6805 = _12502;
	    }
	    else
	    {
	        _6805 = 1.0f;
	    }
	    gl_FragDepth = _6805;
	}
	
	PS_OUTPUT MainPs(PS_INPUT stage_input)
	{
	    gl_FragCoord = stage_input.gl_FragCoord;
	    gl_FragCoord.w = 1.0 / gl_FragCoord.w;
	    MainPs_inner();
	    PS_OUTPUT stage_output;
	    stage_output.gl_FragDepth = gl_FragDepth;
	    return stage_output;
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
}
