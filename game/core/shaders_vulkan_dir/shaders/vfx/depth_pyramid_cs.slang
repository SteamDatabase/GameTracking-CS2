//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Depth Mip Pyramid Computation CS";
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
	DynamicCombo( D_REVERSE_DEPTH, 0..1 );
	
	ExternalDescriptorSet g_downsampleDescSet < Source(ExternalDescSet); Attribute("g_downsampleDescSet"); >;
	RWStructuredBuffer g_spdGlobalAtomic < Source(ExternalDescSet); >;
	RWTexture2D<float4> g_tImgDst < Attribute("Dummy"); >;
	RWTexture2D<float4> g_tImgDst6 < Attribute("Dummy"); >;
	Texture2D g_tInputDepth < Attribute("Dummy"); SrgbRead(false); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	struct _981
	{
	    uint _m0;
	};
	
	globallycoherent RWByteAddressBuffer g_spdGlobalAtomic : register(u158, space3);
	cbuffer DownsamplePushConstants_t
	{
	    uint DownsamplePushConstants_t_1_m0 : packoffset(c0);
	    uint DownsamplePushConstants_t_1_m1 : packoffset(c0.y);
	};
	
	Texture2D<float4> g_tInputDepth : register(t30, space3);
	globallycoherent RWTexture2D<float4> g_tImgDst6 : register(u159, space3);
	RWTexture2D<float4> g_tImgDst[13] : register(u160, space3);
	
	static uint3 gl_WorkGroupID;
	static uint gl_LocalInvocationIndex;
	struct SPIRV_Cross_Input
	{
	    uint3 gl_WorkGroupID : SV_GroupID;
	    uint gl_LocalInvocationIndex : SV_GroupIndex;
	};
	
	groupshared float _3286[256];
	groupshared uint _3044;
	
	void MainCs_inner()
	{
	    do
	    {
	        uint2 _6312;
	        uint _10507;
	        uint _11495;
	        int _12461;
	        int2 _16009;
	        int2 _17277;
	        int _22460;
	        uint _17662 = gl_LocalInvocationIndex % 64u;
	        uint _18055 = ((_17662 & 1u) | ((_17662 >> 2u) & 6u)) + (8u * ((gl_LocalInvocationIndex >> uint(6)) % 2u));
	        uint _21604 = (((_17662 >> 1u) & 3u) | ((_17662 >> 3u) & 4u)) + (8u * (gl_LocalInvocationIndex >> uint(7)));
	        do
	        {
	            _6312 = gl_WorkGroupID.xy;
	            int2 _15224 = int2(_6312 * uint2(64u, 64u));
	            _11495 = _18055 * 2u;
	            _22460 = int(_11495);
	            _10507 = _21604 * 2u;
	            _12461 = int(_10507);
	            _17277 = int2(_22460, _12461);
	            int2 _16450 = _15224 + _17277;
	            int2 _20613 = int2(_6312 * uint2(32u, 32u));
	            int _18838 = int(_18055);
	            int _8296 = int(_21604);
	            _16009 = int2(_18838, _8296);
	            float4 _20274[4];
	            uint2 _19109 = uint2(_16450);
	            float4 _13482 = max(max(g_tInputDepth.Load(int3(int3(_16450, 0).xy, 0)).x.xxxx, g_tInputDepth.Load(int3(int3(int2(_19109 + uint2(0u, 1u)), 0).xy, 0)).x.xxxx), max(g_tInputDepth.Load(int3(int3(int2(_19109 + uint2(1u, 0u)), 0).xy, 0)).x.xxxx, g_tInputDepth.Load(int3(int3(int2(_19109 + uint2(1u, 1u)), 0).xy, 0)).x.xxxx));
	            _20274[0] = _13482;
	            g_tImgDst[1u][uint2(_20613 + _16009)] = _13482.x.xxxx;
	            int _15894 = int(_11495 + 32u);
	            int2 _17142 = _15224 + int2(_15894, _12461);
	            int _16683 = int(_18055 + 16u);
	            uint2 _19110 = uint2(_17142);
	            float4 _14603 = max(max(g_tInputDepth.Load(int3(int3(_17142, 0).xy, 0)).x.xxxx, g_tInputDepth.Load(int3(int3(int2(_19110 + uint2(0u, 1u)), 0).xy, 0)).x.xxxx), max(g_tInputDepth.Load(int3(int3(int2(_19110 + uint2(1u, 0u)), 0).xy, 0)).x.xxxx, g_tInputDepth.Load(int3(int3(int2(_19110 + uint2(1u, 1u)), 0).xy, 0)).x.xxxx));
	            _20274[1] = _14603;
	            g_tImgDst[1u][uint2(_20613 + int2(_16683, _8296))] = _14603.x.xxxx;
	            int _15895 = int(_10507 + 32u);
	            int2 _17143 = _15224 + int2(_22460, _15895);
	            int _16684 = int(_21604 + 16u);
	            uint2 _19111 = uint2(_17143);
	            float4 _14604 = max(max(g_tInputDepth.Load(int3(int3(_17143, 0).xy, 0)).x.xxxx, g_tInputDepth.Load(int3(int3(int2(_19111 + uint2(0u, 1u)), 0).xy, 0)).x.xxxx), max(g_tInputDepth.Load(int3(int3(int2(_19111 + uint2(1u, 0u)), 0).xy, 0)).x.xxxx, g_tInputDepth.Load(int3(int3(int2(_19111 + uint2(1u, 1u)), 0).xy, 0)).x.xxxx));
	            _20274[2] = _14604;
	            g_tImgDst[1u][uint2(_20613 + int2(_18838, _16684))] = _14604.x.xxxx;
	            int2 _21502 = _15224 + int2(_15894, _15895);
	            uint2 _19112 = uint2(_21502);
	            float4 _14605 = max(max(g_tInputDepth.Load(int3(int3(_21502, 0).xy, 0)).x.xxxx, g_tInputDepth.Load(int3(int3(int2(_19112 + uint2(0u, 1u)), 0).xy, 0)).x.xxxx), max(g_tInputDepth.Load(int3(int3(int2(_19112 + uint2(1u, 0u)), 0).xy, 0)).x.xxxx, g_tInputDepth.Load(int3(int3(int2(_19112 + uint2(1u, 1u)), 0).xy, 0)).x.xxxx));
	            _20274[3] = _14605;
	            g_tImgDst[1u][uint2(_20613 + int2(_16683, _16684))] = _14605.x.xxxx;
	            if (DownsamplePushConstants_t_1_m0 <= 1u)
	            {
	                break;
	            }
	            int _7459;
	            int _13039 = 0;
	            for (;;)
	            {
	                if (!(_13039 < 4))
	                {
	                    break;
	                }
	                _3286[_18055 + (16u * _21604)] = _20274[_13039].x;
	                GroupMemoryBarrierWithGroupSync();
	                if (gl_LocalInvocationIndex < 64u)
	                {
	                    uint _21225 = _11495 + 1u;
	                    uint _17922 = _21604 * 32u;
	                    uint _12552 = 16u * (_10507 + 1u);
	                    float4 _14755 = max(max(_3286[_11495 + _17922].xxxx, _3286[_21225 + _17922].xxxx), max(_3286[_11495 + _12552].xxxx, _3286[_21225 + _12552].xxxx));
	                    _20274[_13039] = _14755;
	                    g_tImgDst[2u][uint2(int2(_6312 * uint2(16u, 16u)) + int2(int(_18055 + uint((_13039 - 2 * (_13039 / 2)) * 8)), int(_21604 + uint((_13039 / 2) * 8))))] = _14755.x.xxxx;
	                }
	                GroupMemoryBarrierWithGroupSync();
	                _7459 = _13039 + 1;
	                _13039 = _7459;
	                continue;
	            }
	            if (gl_LocalInvocationIndex < 64u)
	            {
	                uint _17259 = 16u * _21604;
	                _3286[_18055 + _17259] = _20274[0].x;
	                uint _15354 = _18055 + 8u;
	                _3286[_15354 + _17259] = _20274[1].x;
	                uint _17034 = 16u * (_21604 + 8u);
	                _3286[_18055 + _17034] = _20274[2].x;
	                _3286[_15354 + _17034] = _20274[3].x;
	            }
	            break;
	        } while(false);
	        do
	        {
	            if (DownsamplePushConstants_t_1_m0 <= 2u)
	            {
	                break;
	            }
	            GroupMemoryBarrierWithGroupSync();
	            if (gl_LocalInvocationIndex < 64u)
	            {
	                uint _21226 = _11495 + 1u;
	                uint _17923 = _21604 * 32u;
	                uint _12553 = 16u * (_10507 + 1u);
	                float4 _21564 = max(max(_3286[_11495 + _17923].xxxx, _3286[_21226 + _17923].xxxx), max(_3286[_11495 + _12553].xxxx, _3286[_21226 + _12553].xxxx));
	                float _14081 = _21564.x;
	                g_tImgDst[3u][uint2(int2(_6312 * uint2(8u, 8u)) + _16009)] = _14081.xxxx;
	                _3286[(_11495 + (_21604 % 2u)) + _17923] = _14081;
	            }
	            if (DownsamplePushConstants_t_1_m0 <= 3u)
	            {
	                break;
	            }
	            GroupMemoryBarrierWithGroupSync();
	            if (gl_LocalInvocationIndex < 16u)
	            {
	                uint _6756 = _18055 * 4u;
	                uint _17924 = _21604 * 64u;
	                uint _12554 = 16u * ((_21604 * 4u) + 2u);
	                float4 _21565 = max(max(_3286[_6756 + _17924].xxxx, _3286[(_6756 + 2u) + _17924].xxxx), max(_3286[(_6756 + 1u) + _12554].xxxx, _3286[(_6756 + 3u) + _12554].xxxx));
	                float _14082 = _21565.x;
	                g_tImgDst[4u][uint2(int2(_6312 * uint2(4u, 4u)) + _16009)] = _14082.xxxx;
	                _3286[(_6756 + _21604) + _17924] = _14082;
	            }
	            if (DownsamplePushConstants_t_1_m0 <= 4u)
	            {
	                break;
	            }
	            GroupMemoryBarrierWithGroupSync();
	            if (gl_LocalInvocationIndex < 4u)
	            {
	                uint _7524 = _18055 * 8u;
	                uint _17925 = _21604 * 128u;
	                uint _12555 = 16u * ((_21604 * 8u) + 4u);
	                float4 _21566 = max(max(_3286[(_7524 + _10507) + _17925].xxxx, _3286[((_7524 + 4u) + _10507) + _17925].xxxx), max(_3286[((_7524 + 1u) + _10507) + _12555].xxxx, _3286[((_7524 + 5u) + _10507) + _12555].xxxx));
	                float _14083 = _21566.x;
	                g_tImgDst[5u][uint2(int2(_6312 * uint2(2u, 2u)) + _16009)] = _14083.xxxx;
	                _3286[_18055 + _10507] = _14083;
	            }
	            if (DownsamplePushConstants_t_1_m0 <= 5u)
	            {
	                break;
	            }
	            GroupMemoryBarrierWithGroupSync();
	            if (gl_LocalInvocationIndex < 1u)
	            {
	                g_tImgDst6[_6312] = max(max(_3286[0u].xxxx, _3286[1u].xxxx), max(_3286[2u].xxxx, _3286[3u].xxxx)).x.xxxx;
	            }
	            break;
	        } while(false);
	        if (DownsamplePushConstants_t_1_m0 <= 6u)
	        {
	            break;
	        }
	        if (gl_LocalInvocationIndex == 0u)
	        {
	            uint _12637;
	            g_spdGlobalAtomic.InterlockedAdd(0, 1u, _12637);
	            _3044 = _12637;
	        }
	        GroupMemoryBarrierWithGroupSync();
	        if (_3044 != (DownsamplePushConstants_t_1_m1 - 1u))
	        {
	            break;
	        }
	        uint _12251;
	        uint _16998;
	        uint _16999;
	        uint _21382;
	        uint _21383;
	        g_spdGlobalAtomic.Store<uint>(0, 0u);
	        do
	        {
	            _12251 = _18055 * 4u;
	            int _19466 = int(_12251);
	            uint _10508 = _21604 * 4u;
	            int _12385 = int(_10508);
	            int2 _17893 = int2(_19466, _12385);
	            uint2 _11848 = uint2(_17893);
	            float4 _17947 = g_tImgDst6[_17893];
	            float4 _21178 = g_tImgDst6[int2(_11848 + uint2(0u, 1u))];
	            float4 _21179 = g_tImgDst6[int2(_11848 + uint2(1u, 0u))];
	            float4 _21180 = g_tImgDst6[int2(_11848 + uint2(1u, 1u))];
	            float4 _14084 = max(max(_17947.x.xxxx, _21178.x.xxxx), max(_21179.x.xxxx, _21180.x.xxxx));
	            g_tImgDst[7u][uint2(_17277)] = _14084.x.xxxx;
	            _21382 = _12251 + 2u;
	            int _15896 = int(_21382);
	            int2 _20356 = int2(_15896, _12385);
	            _16998 = _11495 + 1u;
	            int _10180 = int(_16998);
	            uint2 _11849 = uint2(_20356);
	            float4 _17948 = g_tImgDst6[_20356];
	            float4 _21181 = g_tImgDst6[int2(_11849 + uint2(0u, 1u))];
	            float4 _21182 = g_tImgDst6[int2(_11849 + uint2(1u, 0u))];
	            float4 _21183 = g_tImgDst6[int2(_11849 + uint2(1u, 1u))];
	            float4 _22131 = max(max(_17948.x.xxxx, _21181.x.xxxx), max(_21182.x.xxxx, _21183.x.xxxx));
	            g_tImgDst[7u][uint2(int2(_10180, _12461))] = _22131.x.xxxx;
	            _21383 = _10508 + 2u;
	            int _15897 = int(_21383);
	            int2 _20357 = int2(_19466, _15897);
	            _16999 = _10507 + 1u;
	            int _10181 = int(_16999);
	            uint2 _11850 = uint2(_20357);
	            float4 _17949 = g_tImgDst6[_20357];
	            float4 _21184 = g_tImgDst6[int2(_11850 + uint2(0u, 1u))];
	            float4 _21185 = g_tImgDst6[int2(_11850 + uint2(1u, 0u))];
	            float4 _21186 = g_tImgDst6[int2(_11850 + uint2(1u, 1u))];
	            float4 _22132 = max(max(_17949.x.xxxx, _21184.x.xxxx), max(_21185.x.xxxx, _21186.x.xxxx));
	            g_tImgDst[7u][uint2(int2(_22460, _10181))] = _22132.x.xxxx;
	            int2 _22601 = int2(_15896, _15897);
	            uint2 _8647 = uint2(_22601);
	            float4 _17950 = g_tImgDst6[_22601];
	            float4 _21187 = g_tImgDst6[int2(_8647 + uint2(0u, 1u))];
	            float4 _21188 = g_tImgDst6[int2(_8647 + uint2(1u, 0u))];
	            float4 _21189 = g_tImgDst6[int2(_8647 + uint2(1u, 1u))];
	            float4 _22133 = max(max(_17950.x.xxxx, _21187.x.xxxx), max(_21188.x.xxxx, _21189.x.xxxx));
	            g_tImgDst[7u][uint2(int2(_10180, _10181))] = _22133.x.xxxx;
	            if (DownsamplePushConstants_t_1_m0 <= 7u)
	            {
	                break;
	            }
	            float4 _14086 = max(max(_14084, _22131), max(_22132, _22133));
	            float _14087 = _14086.x;
	            g_tImgDst[8u][uint2(_16009)] = _14087.xxxx;
	            _3286[_18055 + (16u * _21604)] = _14087;
	            break;
	        } while(false);
	        do
	        {
	            if (DownsamplePushConstants_t_1_m0 <= 8u)
	            {
	                break;
	            }
	            GroupMemoryBarrierWithGroupSync();
	            if (gl_LocalInvocationIndex < 64u)
	            {
	                uint _6251 = _21604 * 32u;
	                uint _12556 = 16u * _16999;
	                float4 _14088 = max(max(_3286[_11495 + _6251].xxxx, _3286[_16998 + _6251].xxxx), max(_3286[_11495 + _12556].xxxx, _3286[_16998 + _12556].xxxx));
	                float _14089 = _14088.x;
	                g_tImgDst[9u][uint2(_16009)] = _14089.xxxx;
	                _3286[(_11495 + (_21604 % 2u)) + _6251] = _14089;
	            }
	            if (DownsamplePushConstants_t_1_m0 <= 9u)
	            {
	                break;
	            }
	            GroupMemoryBarrierWithGroupSync();
	            if (gl_LocalInvocationIndex < 16u)
	            {
	                uint _17926 = _21604 * 64u;
	                uint _12557 = 16u * _21383;
	                float4 _14092 = max(max(_3286[_12251 + _17926].xxxx, _3286[_21382 + _17926].xxxx), max(_3286[(_12251 + 1u) + _12557].xxxx, _3286[(_12251 + 3u) + _12557].xxxx));
	                float _14093 = _14092.x;
	                g_tImgDst[10u][uint2(_16009)] = _14093.xxxx;
	                _3286[(_12251 + _21604) + _17926] = _14093;
	            }
	            if (DownsamplePushConstants_t_1_m0 <= 10u)
	            {
	                break;
	            }
	            GroupMemoryBarrierWithGroupSync();
	            if (gl_LocalInvocationIndex < 4u)
	            {
	                uint _7525 = _18055 * 8u;
	                uint _17927 = _21604 * 128u;
	                uint _12558 = 16u * ((_21604 * 8u) + 4u);
	                float4 _14094 = max(max(_3286[(_7525 + _10507) + _17927].xxxx, _3286[((_7525 + 4u) + _10507) + _17927].xxxx), max(_3286[((_7525 + 1u) + _10507) + _12558].xxxx, _3286[((_7525 + 5u) + _10507) + _12558].xxxx));
	                float _14095 = _14094.x;
	                g_tImgDst[11u][uint2(_16009)] = _14095.xxxx;
	                _3286[_18055 + _10507] = _14095;
	            }
	            if (DownsamplePushConstants_t_1_m0 <= 11u)
	            {
	                break;
	            }
	            GroupMemoryBarrierWithGroupSync();
	            if (gl_LocalInvocationIndex < 1u)
	            {
	                g_tImgDst[12u][uint2(0u, 0u)] = max(max(_3286[0u].xxxx, _3286[1u].xxxx), max(_3286[2u].xxxx, _3286[3u].xxxx)).x.xxxx;
	            }
	            break;
	        } while(false);
	        break;
	    } while(false);
	}
	
	[numthreads(256, 1, 1)]
	void MainCs(SPIRV_Cross_Input stage_input)
	{
	    gl_WorkGroupID = stage_input.gl_WorkGroupID;
	    gl_LocalInvocationIndex = stage_input.gl_LocalInvocationIndex;
	    MainCs_inner();
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
}
