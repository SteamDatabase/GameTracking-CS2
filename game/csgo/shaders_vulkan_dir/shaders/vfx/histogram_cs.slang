//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Histogram";
	DevShader = true;
	Version = 0;
	
	// Platform: VULKAN_SM_50
	// Programs: cs
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

CS
{
	DynamicCombo( D_HISTOGRAM_MODE, 0..2 );
	DynamicCombo( D_MSAA_SAMPLES, 0..3 );
	DynamicCombo( D_TONEMAP_BLEND, 0..3 );
	DynamicCombo( D_DITHER_NOISE, 0..2 );
	
	RWBuffer<float4> g_bAverageLuminance < Attribute("AverageLuminance"); >;
	RWBuffer<float4> g_bHistogramBins < Attribute("HistogramBins"); >;
	float g_flDitherNoiseAmount < Attribute("DitherNoiseAmount"); UiType(Slider); >;
	float g_flExposureBiasScaleFactor < Default(1); Attribute("ExposureBiasScaleFactor"); UiType(Slider); >;
	Texture2D g_tBlueNoise < Attribute("BlueNoise"); SrgbRead(false); >;
	Texture2D g_tInput < Attribute("Input"); SrgbRead(false); >;
	RWTexture2D<float4> g_tOutput < Attribute("Output"); >;
	float4 g_vBlueNoiseDitherParams < UiType(VectorText); Expression(bluenoiseditherparams); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	cbuffer Histogram_t : register(b2, space0)
	{
	    uint2 Histogram_t_1_m0 : packoffset(c0);
	    float Histogram_t_1_m1 : packoffset(c0.z);
	    float Histogram_t_1_m2 : packoffset(c1);
	    uint Histogram_t_1_m3 : packoffset(c1.y);
	};
	
	Texture2D<float4> g_tInput : register(t31, space0);
	RWTexture2D<float4> g_tOutput : register(u158, space0);
	RWBuffer<uint> g_bHistogramBins : register(u159, space0);
	
	static uint3 gl_GlobalInvocationID;
	static uint gl_LocalInvocationIndex;
	struct SPIRV_Cross_Input
	{
	    uint3 gl_GlobalInvocationID : SV_DispatchThreadID;
	    uint gl_LocalInvocationIndex : SV_GroupIndex;
	};
	
	groupshared uint _5922[256];
	
	void MainCs_inner()
	{
	    _5922[gl_LocalInvocationIndex] = 0u;
	    GroupMemoryBarrierWithGroupSync();
	    uint2 _15770 = gl_GlobalInvocationID.xy * Histogram_t_1_m3.xx;
	    uint _21567;
	    uint _13039 = 0u;
	    for (;;)
	    {
	        if (!(_13039 < Histogram_t_1_m3))
	        {
	            break;
	        }
	        uint _23989;
	        uint _13040 = 0u;
	        for (;;)
	        {
	            bool _7956_ladder_break = false;
	            do
	            {
	                if (!(_13040 < Histogram_t_1_m3))
	                {
	                    _7956_ladder_break = true;
	                    break;
	                }
	                uint2 _4370 = _15770 + uint2(_13040, _13039);
	                bool _12885;
	                if (_4370.x >= Histogram_t_1_m0.x)
	                {
	                    _12885 = true;
	                }
	                else
	                {
	                    _12885 = _4370.y >= Histogram_t_1_m0.y;
	                }
	                if (_12885)
	                {
	                    break;
	                }
	                float4 _3300 = g_tInput.Load(int3(int3(int2(_4370), 0).xy, 0), int2(0, 0));
	                float3 _22086 = _3300.xyz;
	                uint _19618;
	                InterlockedAdd(_5922[uint(saturate((log2(max(dot(_22086, float3(0.2125000059604644775390625f, 0.7153999805450439453125f, 0.07209999859333038330078125f)), 0.004999999888241291046142578125f)) - Histogram_t_1_m1) * Histogram_t_1_m2) * 255.0f)], 1u, _19618);
	                g_tOutput[_4370] = float4(clamp(_22086, 0.0f.xxx, 65504.0f.xxx), _3300.w);
	                break;
	            } while(false);
	            if (_7956_ladder_break)
	            {
	                break;
	            }
	            _23989 = _13040 + 1u;
	            _13040 = _23989;
	            continue;
	        }
	        _21567 = _13039 + 1u;
	        _13039 = _21567;
	        continue;
	    }
	    GroupMemoryBarrierWithGroupSync();
	    if (_5922[gl_LocalInvocationIndex] > 0u)
	    {
	        uint _16104;
	        InterlockedAdd(g_bHistogramBins[gl_LocalInvocationIndex], _5922[gl_LocalInvocationIndex], _16104);
	    }
	}
	
	[numthreads(16, 16, 1)]
	void MainCs(SPIRV_Cross_Input stage_input)
	{
	    gl_GlobalInvocationID = stage_input.gl_GlobalInvocationID;
	    gl_LocalInvocationIndex = stage_input.gl_LocalInvocationIndex;
	    MainCs_inner();
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
}
