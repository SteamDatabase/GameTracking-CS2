//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "SHARC radiance cache resolve for rtx_pathtracer";
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
	
	RWStructuredBuffer g_SharcAccumulation < Attribute("SharcAccumulationBuffer"); >;
	RWStructuredBuffer g_SharcHashEntries < Attribute("SharcHashEntriesBuffer"); >;
	RWStructuredBuffer g_SharcResolved < Attribute("SharcResolvedBuffer"); >;
	float g_flSharcRadianceScale < Attribute("SharcRadianceScale"); UiType(Slider); >;
	int g_nSharcAccumulationFrameCount < Attribute("SharcAccumulationFrameCount"); UiType(Slider); >;
	int g_nSharcHashEntriesCount < Attribute("SharcHashEntriesCount"); UiType(Slider); >;
	int g_nSharcStaleFrameMax < Attribute("SharcStaleFrameMax"); UiType(Slider); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	struct _1005
	{
	    uint4 _m0;
	};
	
	struct _1038
	{
	    half4 _m0;
	    uint _m1;
	    uint _m2;
	};
	
	cbuffer _Globals_ : register(b0, space0)
	{
	    uint _Globals_1_g_nSharcHashEntriesCount : packoffset(c0);
	    float _Globals_1_g_flSharcRadianceScale : packoffset(c0.y);
	    uint _Globals_1_g_nSharcAccumulationFrameCount : packoffset(c0.z);
	    uint _Globals_1_g_nSharcStaleFrameMax : packoffset(c0.w);
	};
	
	RWByteAddressBuffer g_SharcHashEntries : register(u158, space0);
	RWByteAddressBuffer g_SharcAccumulation : register(u159, space0);
	RWByteAddressBuffer g_SharcResolved : register(u160, space0);
	
	static uint3 gl_GlobalInvocationID;
	struct SPIRV_Cross_Input
	{
	    uint3 gl_GlobalInvocationID : SV_DispatchThreadID;
	};
	
	void MainCs_inner()
	{
	    uint _4860 = gl_GlobalInvocationID.x + (gl_GlobalInvocationID.y * 512u);
	    do
	    {
	        if (_4860 >= _Globals_1_g_nSharcHashEntriesCount)
	        {
	            break;
	        }
	        uint64_t _15571 = g_SharcHashEntries.Load<uint64_t>(_4860 * 8 + 0);
	        if (_15571 == 0ull)
	        {
	            break;
	        }
	        uint4 _8600 = g_SharcAccumulation.Load<uint4>(_4860 * 16 + 0);
	        half4 _8524 = g_SharcResolved.Load<half4>(_4860 * 16 + 0);
	        uint _24371 = g_SharcResolved.Load<uint>(_4860 * 16 + 8);
	        uint _22627 = g_SharcResolved.Load<uint>(_4860 * 16 + 12);
	        float3 _15551 = float3(float(_8524.x), float(_8524.y), float(_8524.z));
	        float _13893 = float(_8524.w);
	        float _8594 = float(_8600.w);
	        uint _8387 = (_24371 & 65535u) + 1u;
	        uint _22587;
	        if (_8594 != 0.0f)
	        {
	            _22587 = 0u;
	        }
	        else
	        {
	            _22587 = ((_24371 >> uint(16)) & 65535u) + 1u;
	        }
	        if (_22587 >= clamp(_Globals_1_g_nSharcStaleFrameMax, 8u, 1024u))
	        {
	            g_SharcHashEntries.Store<uint64_t>(_4860 * 8 + 0, 0ull);
	            g_SharcAccumulation.Store<uint4>(_4860 * 16 + 0, uint4(0u, 0u, 0u, 0u));
	            g_SharcResolved.Store<half4>(_4860 * 16 + 0, half(0.0).xxxx);
	            g_SharcResolved.Store<uint>(_4860 * 16 + 8, 0u);
	            g_SharcResolved.Store<uint>(_4860 * 16 + 12, 0u);
	            break;
	        }
	        else
	        {
	            if (_8594 == 0.0f)
	            {
	                g_SharcResolved.Store<uint>(_4860 * 16 + 8, _24371 + 65537u);
	                break;
	            }
	        }
	        uint _13137;
	        uint _13960;
	        uint _16306;
	        float _17115;
	        float3 _24234;
	        if (_13893 == 0.0f)
	        {
	            uint _21405 = _4860 + 1u;
	            uint _20147 = min((_4860 + 9u), _Globals_1_g_nSharcHashEntriesCount);
	            uint _23989;
	            uint _13136;
	            uint _16305;
	            float3 _16479;
	            float _17114;
	            uint _17190;
	            uint _13039 = _21405;
	            for (;;)
	            {
	                if (!(_13039 < _20147))
	                {
	                    _13136 = _22587;
	                    _16305 = _22627;
	                    _17114 = _13893;
	                    _17190 = _8387;
	                    _16479 = _15551;
	                    break;
	                }
	                if (g_SharcHashEntries.Load<uint64_t>(_13039 * 8 + 0) == _15571)
	                {
	                    _13136 = 0u;
	                    _16305 = g_SharcResolved.Load<uint>(_13039 * 16 + 12);
	                    _17114 = float(g_SharcResolved.Load<half4>(_13039 * 16 + 0).w);
	                    _17190 = (g_SharcResolved.Load<uint>(_13039 * 16 + 8) & 65535u) + 1u;
	                    _16479 = float3(float(g_SharcResolved.Load<half4>(_13039 * 16 + 0).x), float(g_SharcResolved.Load<half4>(_13039 * 16 + 0).y), float(g_SharcResolved.Load<half4>(_13039 * 16 + 0).z));
	                    break;
	                }
	                _23989 = _13039 + 1u;
	                _13039 = _23989;
	                continue;
	            }
	            _13137 = _13136;
	            _16306 = _16305;
	            _17115 = _17114;
	            _13960 = _17190;
	            _24234 = _16479;
	        }
	        else
	        {
	            _13137 = _22587;
	            _16306 = _22627;
	            _17115 = _13893;
	            _13960 = _8387;
	            _24234 = _15551;
	        }
	        uint _24755 = clamp(_Globals_1_g_nSharcAccumulationFrameCount, 1u, 1024u);
	        bool _6797 = _13960 > _24755;
	        float _24080;
	        if (_6797)
	        {
	            _24080 = _17115 * (float(_24755) / float(_13960));
	        }
	        else
	        {
	            _24080 = _17115;
	        }
	        float _13263 = _24080 + _8594;
	        float _8580 = 1.0f / _13263;
	        float3 _8538 = (_24234 * (_24080 * _8580)) + ((float3(_8600.xyz) * (1.0f / (_Globals_1_g_flSharcRadianceScale * max(_8594, 9.9999999747524270787835121154785e-07f)))) * (_8594 * _8580));
	        g_SharcResolved.Store<half4>(_4860 * 16 + 0, half4(half(min(_8538.x, 65504.0f)), half(min(_8538.y, 65504.0f)), half(min(_8538.z, 65504.0f)), half(min(_13263, 65504.0f))));
	        g_SharcResolved.Store<uint>(_4860 * 16 + 8, (_6797 ? _24755 : _13960) | (_13137 << uint(16)));
	        g_SharcResolved.Store<uint>(_4860 * 16 + 12, _16306);
	        g_SharcAccumulation.Store<uint4>(_4860 * 16 + 0, uint4(0u, 0u, 0u, 0u));
	        break;
	    } while(false);
	}
	
	[numthreads(8, 8, 1)]
	void MainCs(SPIRV_Cross_Input stage_input)
	{
	    gl_GlobalInvocationID = stage_input.gl_GlobalInvocationID;
	    MainCs_inner();
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
}
