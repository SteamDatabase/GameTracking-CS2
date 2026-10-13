//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Compacts indirect draw requests";
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
	DynamicCombo( D_DEBUG_OUTPUT_STATS, 0..1 );
	DynamicCombo( D_WAVEOPS, 0..1 );
	
	RWBuffer<float4> g_Counts < Attribute("CompactedCounts"); >;
	RWStructuredBuffer g_GlobalStats < Attribute("GlobalStats"); >;
	Buffer g_Input < Attribute("InputDraws"); SrgbRead(false); >;
	RWBuffer<float4> g_Output < Attribute("OutputDraws"); >;
	StructuredBuffer g_Requests < Attribute("CompactionRequests"); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	struct _990
	{
	    uint _m0;
	    uint _m1;
	};
	
	ByteAddressBuffer g_Requests : register(t30, space0);
	Buffer<uint4> g_Input : register(t31, space0);
	RWBuffer<uint> g_Output : register(u158, space0);
	RWBuffer<uint> g_Counts : register(u159, space0);
	
	static uint3 gl_LocalInvocationID;
	static uint3 gl_GlobalInvocationID;
	struct SPIRV_Cross_Input
	{
	    uint3 gl_LocalInvocationID : SV_GroupThreadID;
	    uint3 gl_GlobalInvocationID : SV_DispatchThreadID;
	};
	
	groupshared uint _5866[4];
	
	void MainCs_inner()
	{
	    uint _8524 = g_Requests.Load<uint>(gl_GlobalInvocationID.x * 8 + 0);
	    uint _23745 = g_Requests.Load<uint>(gl_GlobalInvocationID.x * 8 + 4);
	    uint _17472 = _8524 >> uint(8);
	    uint _6021 = _8524 & 255u;
	    bool _21645 = gl_LocalInvocationID.y == 0u;
	    if (_21645)
	    {
	        _5866[gl_LocalInvocationID.x] = 0u;
	    }
	    GroupMemoryBarrierWithGroupSync();
	    uint _4283;
	    uint _13039 = gl_LocalInvocationID.y;
	    for (;;)
	    {
	        if (!(_13039 < _6021))
	        {
	            break;
	        }
	        uint _18763 = (_17472 + _13039) * 5u;
	        uint4 _8527 = g_Input.Load(int(_18763));
	        uint _7919 = _8527.x;
	        uint4 _8603 = g_Input.Load(int(_18763 + 1u));
	        uint _8120 = _8603.x;
	        if ((_7919 * _8120) != 0u)
	        {
	            uint _8060;
	            InterlockedAdd(_5866[gl_LocalInvocationID.x], 1u, _8060);
	            uint _25189 = (_23745 + _8060) * 5u;
	            g_Output[_25189] = _7919.x;
	            g_Output[_25189 + 1u] = _8120.x;
	            g_Output[_25189 + 2u] = g_Input.Load(int(_18763 + 2u)).x.x;
	            g_Output[_25189 + 3u] = g_Input.Load(int(_18763 + 3u)).x.x;
	            g_Output[_25189 + 4u] = g_Input.Load(int(_18763 + 4u)).x.x;
	        }
	        _4283 = _13039 + 16u;
	        _13039 = _4283;
	        continue;
	    }
	    GroupMemoryBarrierWithGroupSync();
	    bool _12885;
	    if (_21645)
	    {
	        _12885 = _6021 != 0u;
	    }
	    else
	    {
	        _12885 = false;
	    }
	    if (_12885)
	    {
	        g_Counts[_23745] = _5866[gl_LocalInvocationID.x].x;
	    }
	}
	
	[numthreads(4, 16, 1)]
	void MainCs(SPIRV_Cross_Input stage_input)
	{
	    gl_LocalInvocationID = stage_input.gl_LocalInvocationID;
	    gl_GlobalInvocationID = stage_input.gl_GlobalInvocationID;
	    MainCs_inner();
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
}
