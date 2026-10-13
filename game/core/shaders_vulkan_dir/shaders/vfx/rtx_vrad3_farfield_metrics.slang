//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Farfield metrics computation shader";
	DevShader = true;
	Version = 0;
	
	// Platform: VULKAN_SM_60
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
	
	RWStructuredBuffer g_CellSamples < Attribute("CellSamples"); >;
	StructuredBuffer g_Grids < Attribute("Grids"); >;
	StructuredBuffer g_OccupiedMask < Attribute("OccupiedMask"); >;
	float g_fRayLength < Attribute("RayLength"); UiType(Slider); >;
	int g_nTotalSamples < Attribute("TotalSampleCount"); UiType(Slider); >;
	ExternalDescriptorSet g_rtxAccelSet < Source(ExternalDescSet); Attribute("g_rtxAccelSet"); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	struct _1626
	{
	    column_major float4x3 _m0;
	    column_major float4x3 _m1;
	    float4 _m2;
	    float4 _m3;
	    uint3 _m4;
	};
	
	struct _1035
	{
	    float _m0;
	    float _m1;
	    float _m2;
	    uint _m3;
	};
	
	cbuffer _Globals_ : register(b0, space0)
	{
	    float _Globals_1_g_fRayLength : packoffset(c0);
	    uint _Globals_1_g_nTotalSamples : packoffset(c0.y);
	};
	
	ByteAddressBuffer g_Grids : register(t30, space0);
	ByteAddressBuffer g_OccupiedMask : register(t31, space0);
	RWByteAddressBuffer g_CellSamples : register(u159, space0);
	uniform RaytracingAccelerationStructure _5615 : register(t30, space3);
	
	static uint3 gl_GlobalInvocationID;
	struct SPIRV_Cross_Input
	{
	    uint3 gl_GlobalInvocationID : SV_DispatchThreadID;
	};
	
	void MainCs_inner()
	{
	    do
	    {
	        uint _5053 = gl_GlobalInvocationID.x + (gl_GlobalInvocationID.y * 512u);
	        if (_5053 >= _Globals_1_g_nTotalSamples)
	        {
	            break;
	        }
	        uint _3077 = _5053 / 8u;
	        uint _5746 = _5053 % 8u;
	        uint _8746 = _3077 % g_Grids.Load<uint3>(128).x;
	        uint _12559 = _3077 / g_Grids.Load<uint3>(128).x;
	        uint _19174 = _12559 % g_Grids.Load<uint3>(128).y;
	        uint _12732 = _12559 / g_Grids.Load<uint3>(128).y;
	        float4x3 _16509 = float4x3(g_Grids.Load<float>(48), g_Grids.Load<float>(64), g_Grids.Load<float>(80), g_Grids.Load<float>(52), g_Grids.Load<float>(68), g_Grids.Load<float>(84), g_Grids.Load<float>(56), g_Grids.Load<float>(72), g_Grids.Load<float>(88), g_Grids.Load<float>(60), g_Grids.Load<float>(76), g_Grids.Load<float>(92));
	        float3 _16496 = mul(float4(float3(uint3(_8746, _19174, _12732)) + float3((float(_5746 % 2u) + 0.5f) * 0.5f, (float((_5746 / 2u) % 2u) + 0.5f) * 0.5f, (float(_5746 / 4u) + 0.5f) * 0.5f), 1.0f), _16509).xyz;
	        uint _12752 = _8746 + (g_Grids.Load<uint3>(128).x * (_19174 + (g_Grids.Load<uint3>(128).y * _12732)));
	        uint _6692;
	        float _13138;
	        float _13694;
	        float _16307;
	        if (((g_OccupiedMask.Load<uint>((_12752 >> uint(5)) * 4 + 0) >> (_12752 & 31u)) & 1u) == 0u)
	        {
	            _13138 = 0.0f;
	            _16307 = 0.0f;
	            _13694 = 0.0f;
	            _6692 = 2u;
	        }
	        else
	        {
	            uint2 _8076 = (_5746.xx * uint2(1664525u, 1664525u)) + uint2(1013904223u, 1013904223u);
	            uint _19041 = _8076.y;
	            uint _16272 = _8076.x + (_19041 * 1664525u);
	            uint2 _18731 = uint2(_16272, _19041 + (_16272 * 1664525u));
	            uint2 _15286 = _18731 ^ (_18731 >> uint2(16u, 16u));
	            uint _11372 = _15286.y;
	            uint _16273 = _15286.x + (_11372 * 1664525u);
	            uint2 _18732 = uint2(_16273, _11372 + (_16273 * 1664525u));
	            float2 _23478 = float2(_18732 ^ (_18732 >> uint2(16u, 16u))) * 2.3283064365386962890625e-10f.xx;
	            uint _13136;
	            uint _16305;
	            float _17114;
	            float _17115;
	            float _17133;
	            _13136 = 0u;
	            _16305 = 0u;
	            _17114 = 0.0f;
	            _17115 = 0.0f;
	            _17133 = _Globals_1_g_fRayLength;
	            float _3843;
	            uint _4516;
	            uint _13137;
	            float _14891;
	            uint _16306;
	            float _18360;
	            uint _17017 = 0u;
	            for (;;)
	            {
	                bool _7956_ladder_break = false;
	                do
	                {
	                    if (!(_17017 < 64u))
	                    {
	                        _7956_ladder_break = true;
	                        break;
	                    }
	                    int _14764 = int(_17017);
	                    float2 _9144 = frac(_23478 + (float2(float(_14764 * 12664745), float(_14764 * 9560333)) * 5.9604644775390625e-08f.xx));
	                    float _16410 = (2.0f * _9144.x) - 1.0f;
	                    float _15914 = sqrt(max(0.0f, 1.0f - (_16410 * _16410)));
	                    float _12707 = 6.283185482025146484375f * _9144.y;
	                    float _14204;
	                    do
	                    {
	                        RayQuery<RAY_FLAG_NONE> _10701;
	                        RayDesc _1ident = {_16496, 0.100000001490116119384765625f, float3(_15914 * cos(_12707), _15914 * sin(_12707), _16410), _Globals_1_g_fRayLength};
	                        _10701.TraceRayInline(_5615, 513u, 16u, _1ident);
	                        bool _19681 = _10701.Proceed();
	                        uint _21978 = _10701.CommittedStatus();
	                        if (_21978 == 1u)
	                        {
	                            bool _24609 = _10701.CommittedTriangleFrontFace();
	                            if (_24609)
	                            {
	                                float _24363 = _10701.CommittedRayT();
	                                _14204 = _24363;
	                                break;
	                            }
	                            else
	                            {
	                                float _11381 = _10701.CommittedRayT();
	                                _14204 = -_11381;
	                                break;
	                            }
	                            break; // unreachable workaround
	                        }
	                        else
	                        {
	                            _14204 = _Globals_1_g_fRayLength;
	                            break;
	                        }
	                        break; // unreachable workaround
	                    } while(false);
	                    _3843 = _17114 + float(max(_14204, 0.0f) >= (_Globals_1_g_fRayLength * 0.9900000095367431640625f));
	                    if (_14204 < 0.0f)
	                    {
	                        _13137 = _13136;
	                        _16306 = _16305 + 1u;
	                        _14891 = _17115;
	                        _18360 = _17133;
	                        break;
	                    }
	                    uint _18609;
	                    if (_14204 < _Globals_1_g_fRayLength)
	                    {
	                        _18609 = _13136 + 1u;
	                    }
	                    else
	                    {
	                        _18609 = _13136;
	                    }
	                    _13137 = _18609;
	                    _16306 = _16305;
	                    _14891 = max(_17115, _14204);
	                    _18360 = min(_17133, _14204);
	                    break;
	                } while(false);
	                if (_7956_ladder_break)
	                {
	                    break;
	                }
	                _4516 = _17017 + 1u;
	                _13136 = _13137;
	                _16305 = _16306;
	                _17114 = _3843;
	                _17115 = _14891;
	                _17133 = _18360;
	                _17017 = _4516;
	                continue;
	            }
	            uint _5226 = _16305 + _13136;
	            bool _7289;
	            if (_5226 > 0u)
	            {
	                _7289 = _16305 > uint(0.4000000059604644775390625f * float(_5226));
	            }
	            else
	            {
	                _7289 = false;
	            }
	            _13138 = _17133;
	            _16307 = _17115;
	            _13694 = _17114 * 0.015625f;
	            _6692 = uint(_7289);
	        }
	        g_CellSamples.Store<float>(_5053 * 16 + 0, _13138);
	        g_CellSamples.Store<float>(_5053 * 16 + 4, _16307);
	        g_CellSamples.Store<float>(_5053 * 16 + 8, _13694);
	        g_CellSamples.Store<uint>(_5053 * 16 + 12, _6692);
	        break;
	    } while(false);
	}
	
	[numthreads(64, 1, 1)]
	void MainCs(SPIRV_Cross_Input stage_input)
	{
	    gl_GlobalInvocationID = stage_input.gl_GlobalInvocationID;
	    MainCs_inner();
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
}
