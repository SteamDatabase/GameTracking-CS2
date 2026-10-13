//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Computes culling bits for depth bins";
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
	
	StructuredBuffer g_CullItems < Attribute("CullItems"); >;
	RWStructuredBuffer g_OutputCullBits < Attribute("OutputCullBits"); >;
	[[layer_constant]] ExternalDescriptorSet g_lightBinnerGpuSet < Source(ExternalDescSet); Attribute("g_lightBinnerGpuSet"); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	struct _1017
	{
	    uint _m0;
	    uint _m1;
	    uint _m2;
	    uint _m3;
	};
	
	struct _1528
	{
	    _1017 _m0[3];
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
	
	cbuffer CullParams_t : register(b1, space0)
	{
	    float CullParams_t_1_m0 : packoffset(c2.y);
	    float CullParams_t_1_m1 : packoffset(c2.z);
	    float CullParams_t_1_m2 : packoffset(c2.w);
	    uint4 CullParams_t_1_m3 : packoffset(c3);
	    _1528 CullParams_t_1_m4 : packoffset(c7);
	};
	
	ByteAddressBuffer g_CullItems : register(t30, space0);
	RWByteAddressBuffer g_OutputCullBits : register(u158, space0);
	
	static uint3 gl_WorkGroupID;
	static uint3 gl_GlobalInvocationID;
	struct SPIRV_Cross_Input
	{
	    uint3 gl_WorkGroupID : SV_GroupID;
	    uint3 gl_GlobalInvocationID : SV_DispatchThreadID;
	};
	
	void MainCs_inner()
	{
	    uint _22151 = (gl_WorkGroupID.y >= CullParams_t_1_m3.z) ? 2u : uint(gl_WorkGroupID.y >= CullParams_t_1_m3.y);
	    uint _3251 = gl_WorkGroupID.y - CullParams_t_1_m3[_22151];
	    float _17281 = (CullParams_t_1_m2 + (float(gl_GlobalInvocationID.x) * CullParams_t_1_m0)) - CullParams_t_1_m1;
	    float _15813 = (CullParams_t_1_m2 + (float(gl_GlobalInvocationID.x + 1u) * CullParams_t_1_m0)) + CullParams_t_1_m1;
	    uint _5249 = CullParams_t_1_m4._m0[_22151]._m2 + (_3251 * 32u);
	    uint _19037 = min(CullParams_t_1_m4._m0[_22151]._m3, (_5249 + 32u));
	    uint _13155;
	    _13155 = 0u;
	    uint _4284;
	    uint _14382;
	    uint _16208 = _5249;
	    for (;;)
	    {
	        if (!(_16208 < _19037))
	        {
	            break;
	        }
	        bool _12885;
	        if (g_CullItems.Load<float>(_16208 * 80 + 32) <= _15813)
	        {
	            _12885 = g_CullItems.Load<float>(_16208 * 80 + 36) >= _17281;
	        }
	        else
	        {
	            _12885 = false;
	        }
	        if (_12885)
	        {
	            _14382 = _13155 | (1u << (_16208 - _5249));
	        }
	        else
	        {
	            _14382 = _13155;
	        }
	        _4284 = _16208 + 1u;
	        _13155 = _14382;
	        _16208 = _4284;
	        continue;
	    }
	    g_OutputCullBits.Store<uint>(((CullParams_t_1_m4._m0[_22151]._m0 + (gl_GlobalInvocationID.x * CullParams_t_1_m4._m0[_22151]._m1)) + _3251) * 4 + 0, _13155);
	}
	
	[numthreads(32, 1, 1)]
	void MainCs(SPIRV_Cross_Input stage_input)
	{
	    gl_WorkGroupID = stage_input.gl_WorkGroupID;
	    gl_GlobalInvocationID = stage_input.gl_GlobalInvocationID;
	    MainCs_inner();
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
}
