//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Compute Shader for accelerated mipmap generation.";
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
	DynamicCombo( D_NON_POWER_OF_TWO, 0..3 );
	DynamicCombo( D_CONVERT_TO_SRGB, 0..1 );
	
	RWTexture2D<float4> OutMip1 < Attribute("OutMip1"); >;
	RWTexture2D<float4> OutMip2 < Attribute("OutMip2"); >;
	RWTexture2D<float4> OutMip3 < Attribute("OutMip3"); >;
	RWTexture2D<float4> OutMip4 < Attribute("OutMip4"); >;
	Texture2D g_tSrcMip < Attribute("SrcMip"); SrgbRead(false); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	cbuffer MipConstantBuffer_t : register(b0, space0)
	{
	    float MipConstantBuffer_t_1_m0 : packoffset(c0);
	    float MipConstantBuffer_t_1_m1 : packoffset(c0.y);
	    float2 MipConstantBuffer_t_1_m2 : packoffset(c0.z);
	};
	
	Texture2D<float4> g_tSrcMip : register(t30, space0);
	SamplerState AddressU_Clamp_AddressV_Clamp_Filter_MinMagLinearMipPoint : register(s14, space0);
	RWTexture2D<float4> OutMip1 : register(u158, space0);
	RWTexture2D<float4> OutMip2 : register(u159, space0);
	RWTexture2D<float4> OutMip3 : register(u160, space0);
	RWTexture2D<float4> OutMip4 : register(u161, space0);
	
	static uint3 gl_GlobalInvocationID;
	static uint gl_LocalInvocationIndex;
	struct SPIRV_Cross_Input
	{
	    uint3 gl_GlobalInvocationID : SV_DispatchThreadID;
	    uint gl_LocalInvocationIndex : SV_GroupIndex;
	};
	
	groupshared float _4128[64];
	groupshared float _4117[64];
	groupshared float _4112[64];
	groupshared float _4111[64];
	
	void MainCs_inner()
	{
	    do
	    {
	        uint _3962 = uint(MipConstantBuffer_t_1_m1);
	        float4 _3300 = g_tSrcMip.SampleLevel(AddressU_Clamp_AddressV_Clamp_Filter_MinMagLinearMipPoint, (MipConstantBuffer_t_1_m2 * (float2(gl_GlobalInvocationID.xy) + 0.5f.xx)).xy, float(uint(MipConstantBuffer_t_1_m0)));
	        OutMip1[gl_GlobalInvocationID.xy] = _3300;
	        if (_3962 == 1u)
	        {
	            break;
	        }
	        _4128[gl_LocalInvocationIndex] = _3300.x;
	        _4117[gl_LocalInvocationIndex] = _3300.y;
	        _4112[gl_LocalInvocationIndex] = _3300.z;
	        _4111[gl_LocalInvocationIndex] = _3300.w;
	        GroupMemoryBarrierWithGroupSync();
	        float4 _7078;
	        if ((gl_LocalInvocationIndex & 9u) == 0u)
	        {
	            uint _11704 = gl_LocalInvocationIndex + 1u;
	            float _17363 = _4128[_11704];
	            float _24369 = _4117[_11704];
	            float _24370 = _4112[_11704];
	            float _23047 = _4111[_11704];
	            uint _18005 = gl_LocalInvocationIndex + 8u;
	            float _17364 = _4128[_18005];
	            float _24371 = _4117[_18005];
	            float _24372 = _4112[_18005];
	            float _23048 = _4111[_18005];
	            uint _18006 = gl_LocalInvocationIndex + 9u;
	            float _17365 = _4128[_18006];
	            float _24373 = _4117[_18006];
	            float _24374 = _4112[_18006];
	            float _23066 = _4111[_18006];
	            float4 _8491 = (((_3300 + float4(_17363, _24369, _24370, _23047)) + float4(_17364, _24371, _24372, _23048)) + float4(_17365, _24373, _24374, _23066)) * 0.25f;
	            OutMip2[gl_GlobalInvocationID.xy / uint2(2u, 2u)] = _8491;
	            _4128[gl_LocalInvocationIndex] = _8491.x;
	            _4117[gl_LocalInvocationIndex] = _8491.y;
	            _4112[gl_LocalInvocationIndex] = _8491.z;
	            _4111[gl_LocalInvocationIndex] = _8491.w;
	            _7078 = _8491;
	        }
	        else
	        {
	            _7078 = _3300;
	        }
	        if (_3962 == 2u)
	        {
	            break;
	        }
	        GroupMemoryBarrierWithGroupSync();
	        float4 _7079;
	        if ((gl_LocalInvocationIndex & 27u) == 0u)
	        {
	            uint _11705 = gl_LocalInvocationIndex + 2u;
	            float _17366 = _4128[_11705];
	            float _24375 = _4117[_11705];
	            float _24376 = _4112[_11705];
	            float _23049 = _4111[_11705];
	            uint _18007 = gl_LocalInvocationIndex + 16u;
	            float _17367 = _4128[_18007];
	            float _24377 = _4117[_18007];
	            float _24378 = _4112[_18007];
	            float _23050 = _4111[_18007];
	            uint _18008 = gl_LocalInvocationIndex + 18u;
	            float _17368 = _4128[_18008];
	            float _24379 = _4117[_18008];
	            float _24380 = _4112[_18008];
	            float _23067 = _4111[_18008];
	            float4 _8492 = (((_7078 + float4(_17366, _24375, _24376, _23049)) + float4(_17367, _24377, _24378, _23050)) + float4(_17368, _24379, _24380, _23067)) * 0.25f;
	            OutMip3[gl_GlobalInvocationID.xy / uint2(4u, 4u)] = _8492;
	            _4128[gl_LocalInvocationIndex] = _8492.x;
	            _4117[gl_LocalInvocationIndex] = _8492.y;
	            _4112[gl_LocalInvocationIndex] = _8492.z;
	            _4111[gl_LocalInvocationIndex] = _8492.w;
	            _7079 = _8492;
	        }
	        else
	        {
	            _7079 = _7078;
	        }
	        if (_3962 == 3u)
	        {
	            break;
	        }
	        GroupMemoryBarrierWithGroupSync();
	        if (gl_LocalInvocationIndex == 0u)
	        {
	            uint _11706 = gl_LocalInvocationIndex + 4u;
	            uint _18009 = gl_LocalInvocationIndex + 32u;
	            uint _18010 = gl_LocalInvocationIndex + 36u;
	            OutMip4[gl_GlobalInvocationID.xy / uint2(8u, 8u)] = (((_7079 + float4(_4128[_11706], _4117[_11706], _4112[_11706], _4111[_11706])) + float4(_4128[_18009], _4117[_18009], _4112[_18009], _4111[_18009])) + float4(_4128[_18010], _4117[_18010], _4112[_18010], _4111[_18010])) * 0.25f;
	        }
	        break;
	    } while(false);
	}
	
	[numthreads(8, 8, 1)]
	void MainCs(SPIRV_Cross_Input stage_input)
	{
	    gl_GlobalInvocationID = stage_input.gl_GlobalInvocationID;
	    gl_LocalInvocationIndex = stage_input.gl_LocalInvocationIndex;
	    MainCs_inner();
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
}
