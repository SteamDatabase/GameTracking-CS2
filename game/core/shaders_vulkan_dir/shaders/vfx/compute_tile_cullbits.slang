//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Computes culling bits for screen space tiles";
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
	DynamicCombo( D_SUBGROUP_SIZE_32, 0..1 );
	
	StructuredBuffer g_CullItems < Attribute("CullItems"); >;
	StructuredBuffer g_CullPlanes < Attribute("CullPlanes"); >;
	RWStructuredBuffer g_OutputCullBits < Attribute("OutputCullBits"); >;
	[[layer_constant]] ExternalDescriptorSet g_lightBinnerGpuSet < Source(ExternalDescSet); Attribute("g_lightBinnerGpuSet"); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	struct _1002
	{
	    uint _m0;
	    uint _m1;
	    uint _m2;
	};
	
	struct _1724
	{
	    _1002 _m0[3];
	};
	
	struct _1935
	{
	    uint _m0;
	    uint _m1;
	    uint _m2;
	    uint _m3;
	    float2 _m4;
	    float2 _m5;
	    float _m6;
	    float _m7;
	    float2 _m8;
	    float _m9;
	    float _m10;
	    float _m11;
	    float _m12;
	    float _m13;
	    float _m14;
	    float _m15;
	    float _m16;
	};
	
	struct _1032
	{
	    float2 _m0;
	    float _m1;
	    float _m2;
	};
	
	static bool _5;
	
	cbuffer CullParams_t : register(b1, space0)
	{
	    uint CullParams_t_1_m0 : packoffset(c0.y);
	    uint CullParams_t_1_m1 : packoffset(c0.z);
	    float2 CullParams_t_1_m2 : packoffset(c1);
	    float2 CullParams_t_1_m3 : packoffset(c1.z);
	    uint4 CullParams_t_1_m4 : packoffset(c3);
	    _1724 CullParams_t_1_m5 : packoffset(c4);
	};
	
	ByteAddressBuffer g_CullItems : register(t31, space0);
	ByteAddressBuffer g_CullPlanes : register(t30, space0);
	RWByteAddressBuffer g_OutputCullBits : register(u158, space0);
	
	static uint3 gl_WorkGroupID;
	static uint3 gl_LocalInvocationID;
	static uint3 gl_GlobalInvocationID;
	struct SPIRV_Cross_Input
	{
	    uint3 gl_WorkGroupID : SV_GroupID;
	    uint3 gl_LocalInvocationID : SV_GroupThreadID;
	    uint3 gl_GlobalInvocationID : SV_DispatchThreadID;
	};
	
	groupshared uint _5602;
	
	void MainCs_inner()
	{
	    uint _22151 = (gl_WorkGroupID.z >= CullParams_t_1_m4.z) ? 2u : uint(gl_WorkGroupID.z >= CullParams_t_1_m4.y);
	    uint _3251 = gl_WorkGroupID.z - CullParams_t_1_m4[_22151];
	    float2 _11958 = abs(CullParams_t_1_m2) * 0.5f;
	    float2 _23453 = (float2(gl_GlobalInvocationID.xy) * CullParams_t_1_m2) + CullParams_t_1_m3;
	    uint2 _7433 = gl_WorkGroupID.xy * uint2(8u, 4u);
	    float2 _16631 = (float2(_7433) * CullParams_t_1_m2) + CullParams_t_1_m3;
	    float2 _17028 = (float2(_7433 + uint2(7u, 3u)) * CullParams_t_1_m2) + CullParams_t_1_m3;
	    float2 _4823 = (_17028 + _16631) * 0.5f;
	    float2 _3512 = abs(_17028 - _16631) * 0.5f;
	    uint _3716 = (gl_LocalInvocationID.y * 8u) + gl_LocalInvocationID.x;
	    if (all(bool3(gl_LocalInvocationID.x == uint3(0u, 0u, 0u).x, gl_LocalInvocationID.y == uint3(0u, 0u, 0u).y, gl_LocalInvocationID.z == uint3(0u, 0u, 0u).z)))
	    {
	        _5602 = 0u;
	    }
	    uint _24395 = CullParams_t_1_m5._m0[_22151]._m2 + (_3251 * 32u);
	    uint _7606 = _24395 + _3716;
	    float2 _4241 = g_CullItems.Load<float2>(_7606 * 80 + 16) - _3512;
	    float2 _5212 = g_CullItems.Load<float2>(_7606 * 80 + 24) + _3512;
	    bool2 _17472 = bool2(_4823.x >= _4241.x, _4823.y >= _4241.y);
	    bool2 _8020 = bool2(_5212.x >= _4823.x, _5212.y >= _4823.y);
	    uint _15363;
	    if (all(bool2(_17472.x && _8020.x, _17472.y && _8020.y)))
	    {
	        _15363 = 1u << _3716;
	    }
	    else
	    {
	        _15363 = 0u;
	    }
	    GroupMemoryBarrierWithGroupSync();
	    if (_15363 != 0u)
	    {
	        uint _23780;
	        InterlockedOr(_5602, _15363, _23780);
	    }
	    GroupMemoryBarrierWithGroupSync();
	    uint _17133;
	    _17133 = 0u;
	    uint _3461;
	    uint _12503;
	    bool _13175;
	    bool _13177;
	    bool _13136 = false;
	    bool _16305 = false;
	    uint _17017 = _5602;
	    for (;;)
	    {
	        if (!(_17017 != 0u))
	        {
	            break;
	        }
	        uint _17426 = firstbitlow(_17017);
	        _3461 = _17017 & (_17017 - 1u);
	        uint _24956 = _24395 + _17426;
	        bool _12885;
	        do
	        {
	            if (g_CullItems.Load<float>(_24956 * 80 + 72) == 0.0f)
	            {
	                _12885 = true;
	                break;
	            }
	            float _16377 = _23453.x;
	            float _23301 = _23453.y;
	            float _7753 = g_CullItems.Load<float>(_24956 * 80 + 48) * _16377;
	            float _19133 = g_CullItems.Load<float>(_24956 * 80 + 52) * _23301;
	            float _22329 = g_CullItems.Load<float>(_24956 * 80 + 56) * _16377;
	            _12885 = ((((((((_7753 * _16377) + (_19133 * _23301)) + (_22329 * _23301)) + (g_CullItems.Load<float>(_24956 * 80 + 60) * _16377)) + (g_CullItems.Load<float>(_24956 * 80 + 64) * _23301)) + g_CullItems.Load<float>(_24956 * 80 + 68)) + (abs(((2.0f * _7753) + (g_CullItems.Load<float>(_24956 * 80 + 56) * _23301)) + g_CullItems.Load<float>(_24956 * 80 + 60)) * _11958.x)) + (abs(((2.0f * _19133) + _22329) + g_CullItems.Load<float>(_24956 * 80 + 64)) * _11958.y)) >= 0.0f;
	            break;
	        } while(false);
	        bool _16055;
	        if (_12885)
	        {
	            bool _12501;
	            do
	            {
	                uint _23989;
	                bool _13174;
	                bool _16054;
	                uint _13039 = 0u;
	                for (;;)
	                {
	                    if (!(_13039 < g_CullItems.Load<uint>(_24956 * 80 + 8)))
	                    {
	                        _13174 = _16305;
	                        _16054 = false;
	                        break;
	                    }
	                    uint _14202 = g_CullItems.Load<uint>(_24956 * 80 + 0) + _13039;
	                    if ((dot(g_CullPlanes.Load<float2>(_14202 * 16 + 0), _23453) + g_CullPlanes.Load<float>(_14202 * 16 + 8)) < 0.0f)
	                    {
	                        _13174 = false;
	                        _16054 = true;
	                        break;
	                    }
	                    _23989 = _13039 + 1u;
	                    _13039 = _23989;
	                    continue;
	                }
	                if (_16054)
	                {
	                    _12501 = _13174;
	                    break;
	                }
	                _12501 = true;
	                break;
	            } while(false);
	            _13175 = _12501;
	            _16055 = _12501;
	        }
	        else
	        {
	            _13175 = _16305;
	            _16055 = false;
	        }
	        bool _16057;
	        if (_16055)
	        {
	            uint _24392 = g_CullItems.Load<uint>(_24956 * 80 + 0) + g_CullItems.Load<uint>(_24956 * 80 + 8);
	            bool _12502;
	            do
	            {
	                uint _23990;
	                bool _13176;
	                bool _16056;
	                uint _13040 = 0u;
	                for (;;)
	                {
	                    if (!(_13040 < g_CullItems.Load<uint>(_24956 * 80 + 12)))
	                    {
	                        _13176 = _13136;
	                        _16056 = false;
	                        break;
	                    }
	                    uint _14203 = _24392 + _13040;
	                    if ((dot(g_CullPlanes.Load<float2>(_14203 * 16 + 0), _23453) + g_CullPlanes.Load<float>(_14203 * 16 + 8)) < 0.0f)
	                    {
	                        _13176 = false;
	                        _16056 = true;
	                        break;
	                    }
	                    _23990 = _13040 + 1u;
	                    _13040 = _23990;
	                    continue;
	                }
	                if (_16056)
	                {
	                    _12502 = _13176;
	                    break;
	                }
	                _12502 = true;
	                break;
	            } while(false);
	            _13177 = _12502;
	            _16057 = _12502;
	        }
	        else
	        {
	            _13177 = _13136;
	            _16057 = false;
	        }
	        if (_16057)
	        {
	            _12503 = _17133 | (1u << _17426);
	        }
	        else
	        {
	            _12503 = _17133;
	        }
	        _13136 = _13177;
	        _16305 = _13175;
	        _17133 = _12503;
	        _17017 = _3461;
	        continue;
	    }
	    bool _12886;
	    if (gl_GlobalInvocationID.x < CullParams_t_1_m0)
	    {
	        _12886 = gl_GlobalInvocationID.y < CullParams_t_1_m1;
	    }
	    else
	    {
	        _12886 = false;
	    }
	    if (_12886)
	    {
	        g_OutputCullBits.Store<uint>(((CullParams_t_1_m5._m0[_22151]._m0 + (((gl_GlobalInvocationID.y * CullParams_t_1_m0) + gl_GlobalInvocationID.x) * CullParams_t_1_m5._m0[_22151]._m1)) + _3251) * 4 + 0, _17133);
	    }
	}
	
	[numthreads(8, 4, 1)]
	void MainCs(SPIRV_Cross_Input stage_input)
	{
	    gl_WorkGroupID = stage_input.gl_WorkGroupID;
	    gl_LocalInvocationID = stage_input.gl_LocalInvocationID;
	    gl_GlobalInvocationID = stage_input.gl_GlobalInvocationID;
	    MainCs_inner();
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
}
