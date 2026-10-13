//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Stats gathering for aggregate culling";
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
	StaticCombo( S_SUBGROUP_WAVE_OPS, 0..1 );
	
	RWStructuredBuffer g_CullStats < Attribute("FragmentStats"); >;
	RWStructuredBuffer g_GlobalStats < Attribute("GlobalStats"); >;
	Buffer g_nDrawCount < Attribute("FragmentDrawCount"); SrgbRead(false); >;
	int g_nNumFragments < Attribute("NumFragments"); UiType(Slider); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	struct _1245
	{
	    uint _m0;
	    uint _m1;
	    uint _m2;
	    uint _m3;
	    uint _m4;
	    uint _m5;
	    uint _m6;
	    uint _m7;
	    uint _m8;
	    uint _m9;
	    uint _m10;
	    uint _m11;
	};
	
	cbuffer _Globals_ : register(b0, space0)
	{
	    uint _Globals_1_g_nNumFragments : packoffset(c0);
	};
	
	RWByteAddressBuffer g_CullStats : register(u158, space0);
	RWByteAddressBuffer g_GlobalStats : register(u159, space0);
	Buffer<uint4> g_nDrawCount : register(t30, space0);
	
	static uint3 gl_WorkGroupID;
	static uint3 gl_LocalInvocationID;
	struct SPIRV_Cross_Input
	{
	    uint3 gl_WorkGroupID : SV_GroupID;
	    uint3 gl_LocalInvocationID : SV_GroupThreadID;
	};
	
	void MainCs_inner()
	{
	    uint _13918 = gl_WorkGroupID.x * 256u;
	    uint _13136;
	    uint _16305;
	    uint _17114;
	    uint _17115;
	    uint _17116;
	    uint _17117;
	    uint _17118;
	    uint _17119;
	    uint _17120;
	    uint _17121;
	    uint _17133;
	    _13136 = 0u;
	    _16305 = 0u;
	    _17114 = 0u;
	    _17115 = 0u;
	    _17116 = 0u;
	    _17117 = 0u;
	    _17118 = 0u;
	    _17119 = 0u;
	    _17120 = 0u;
	    _17121 = 0u;
	    _17133 = 0u;
	    uint _3985;
	    uint _13137;
	    uint _14891;
	    uint _16306;
	    uint _17122;
	    uint _17123;
	    uint _17124;
	    uint _17125;
	    uint _17126;
	    uint _17127;
	    uint _17128;
	    uint _18360;
	    uint _17017 = 0u;
	    for (;;)
	    {
	        if (!(_17017 < 4u))
	        {
	            break;
	        }
	        uint _5211 = (_13918 + gl_LocalInvocationID.x) + (_17017 * 64u);
	        if (_5211 < _Globals_1_g_nNumFragments)
	        {
	            uint _18241 = (g_nDrawCount.Load(int(_5211 / 4u)).x >> ((_5211 % 4u) * 8u)) & 255u;
	            uint _17277 = g_CullStats.Load<uint>(_5211 * 48 + 0);
	            uint _7045 = g_CullStats.Load<uint>(_5211 * 48 + 8);
	            uint _7046 = g_CullStats.Load<uint>(_5211 * 48 + 4);
	            uint _7047 = g_CullStats.Load<uint>(_5211 * 48 + 12);
	            uint _7048 = g_CullStats.Load<uint>(_5211 * 48 + 16);
	            uint _7049 = g_CullStats.Load<uint>(_5211 * 48 + 20);
	            uint _7050 = g_CullStats.Load<uint>(_5211 * 48 + 24);
	            uint _7051 = g_CullStats.Load<uint>(_5211 * 48 + 36);
	            uint _7052 = g_CullStats.Load<uint>(_5211 * 48 + 40);
	            uint _6540 = g_CullStats.Load<uint>(_5211 * 48 + 28);
	            uint _6483 = g_CullStats.Load<uint>(_5211 * 48 + 32);
	            g_CullStats.Store<uint>(_5211 * 48 + 0, 0u);
	            g_CullStats.Store<uint>(_5211 * 48 + 4, 0u);
	            g_CullStats.Store<uint>(_5211 * 48 + 8, 0u);
	            g_CullStats.Store<uint>(_5211 * 48 + 12, 0u);
	            g_CullStats.Store<uint>(_5211 * 48 + 16, 0u);
	            g_CullStats.Store<uint>(_5211 * 48 + 20, 0u);
	            g_CullStats.Store<uint>(_5211 * 48 + 24, 0u);
	            g_CullStats.Store<uint>(_5211 * 48 + 28, 0u);
	            g_CullStats.Store<uint>(_5211 * 48 + 32, 0u);
	            g_CullStats.Store<uint>(_5211 * 48 + 36, 0u);
	            g_CullStats.Store<uint>(_5211 * 48 + 40, 0u);
	            g_CullStats.Store<uint>(_5211 * 48 + 44, 0u);
	            _13137 = _13136 + (_17277 * _18241);
	            _16306 = _16305 + (_7046 * _18241);
	            _17122 = _17114 + (_7045 * _18241);
	            _17123 = _17115 + (_7047 * _18241);
	            _17124 = _17116 + (_7048 * _18241);
	            _17125 = _17117 + (_7049 * _18241);
	            _17126 = _17118 + (_7050 * _18241);
	            _17127 = _17119 + _6540;
	            _17128 = _17120 + _6483;
	            _14891 = _17121 + (_7051 * _18241);
	            _18360 = _17133 + (_7052 * _18241);
	        }
	        else
	        {
	            _13137 = _13136;
	            _16306 = _16305;
	            _17122 = _17114;
	            _17123 = _17115;
	            _17124 = _17116;
	            _17125 = _17117;
	            _17126 = _17118;
	            _17127 = _17119;
	            _17128 = _17120;
	            _14891 = _17121;
	            _18360 = _17133;
	        }
	        _3985 = _17017 + 1u;
	        _13136 = _13137;
	        _16305 = _16306;
	        _17114 = _17122;
	        _17115 = _17123;
	        _17116 = _17124;
	        _17117 = _17125;
	        _17118 = _17126;
	        _17119 = _17127;
	        _17120 = _17128;
	        _17121 = _14891;
	        _17133 = _18360;
	        _17017 = _3985;
	        continue;
	    }
	    uint _11833;
	    g_GlobalStats.InterlockedAdd(0, _13136, _11833);
	    uint _16063;
	    g_GlobalStats.InterlockedAdd(8, _17114, _16063);
	    uint _16064;
	    g_GlobalStats.InterlockedAdd(4, _16305, _16064);
	    uint _16065;
	    g_GlobalStats.InterlockedAdd(12, _17115, _16065);
	    uint _16066;
	    g_GlobalStats.InterlockedAdd(16, _17116, _16066);
	    uint _16067;
	    g_GlobalStats.InterlockedAdd(20, _17117, _16067);
	    uint _16068;
	    g_GlobalStats.InterlockedAdd(24, _17118, _16068);
	    uint _16069;
	    g_GlobalStats.InterlockedAdd(28, _17119, _16069);
	    uint _16070;
	    g_GlobalStats.InterlockedAdd(32, _17120, _16070);
	    uint _16071;
	    g_GlobalStats.InterlockedAdd(36, _17121, _16071);
	    uint _21947;
	    g_GlobalStats.InterlockedAdd(40, _17133, _21947);
	}
	
	[numthreads(64, 1, 1)]
	void MainCs(SPIRV_Cross_Input stage_input)
	{
	    gl_WorkGroupID = stage_input.gl_WorkGroupID;
	    gl_LocalInvocationID = stage_input.gl_LocalInvocationID;
	    MainCs_inner();
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
}
