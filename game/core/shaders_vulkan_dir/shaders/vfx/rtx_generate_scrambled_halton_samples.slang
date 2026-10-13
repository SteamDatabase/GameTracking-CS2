//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Generates scrambled halton samples";
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
	
	RWTexture3D<float4> g_RandomSamples < Attribute("g_RandomSamples"); >;
	StructuredBuffer g_ScrambledHaltonPermutations < Attribute("g_ScrambledHaltonPermutations"); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	static float _2;
	
	ByteAddressBuffer g_ScrambledHaltonPermutations : register(t30, space0);
	cbuffer PushConstants_t
	{
	    uint4 PushConstants_t_1_m0 : packoffset(c0);
	    uint4 PushConstants_t_1_m1 : packoffset(c1);
	    uint4 PushConstants_t_1_m2 : packoffset(c2);
	};
	
	RWTexture3D<float4> g_RandomSamples : register(u158, space0);
	
	static uint3 gl_GlobalInvocationID;
	struct SPIRV_Cross_Input
	{
	    uint3 gl_GlobalInvocationID : SV_DispatchThreadID;
	};
	
	void MainCs_inner()
	{
	    uint _22467 = gl_GlobalInvocationID.x & PushConstants_t_1_m0.x;
	    uint _16394 = gl_GlobalInvocationID.y & PushConstants_t_1_m0.x;
	    uint _20351 = (_22467 << uint(16)) | (_22467 >> uint(16));
	    uint _19542 = ((_20351 & 16711935u) << uint(8)) | ((_20351 & 4278255360u) >> uint(8));
	    uint _19543 = ((_19542 & 252645135u) << uint(4)) | ((_19542 & 4042322160u) >> uint(4));
	    uint _19544 = ((_19543 & 858993459u) << uint(2)) | ((_19543 & 3435973836u) >> uint(2));
	    uint _16324;
	    _16324 = 0u;
	    uint _6216;
	    uint _9062;
	    uint _19853;
	    uint _13136 = _16394;
	    uint _17017 = 0u;
	    for (;;)
	    {
	        if (!(_17017 < PushConstants_t_1_m0.z))
	        {
	            break;
	        }
	        _19853 = (_16324 * 3u) + (_13136 % 3u);
	        _9062 = _13136 / 3u;
	        _6216 = _17017 + 1u;
	        _13136 = _9062;
	        _16324 = _19853;
	        _17017 = _6216;
	        continue;
	    }
	    uint _12091 = uint(((uint64_t((((_19544 & 1431655765u) << uint(1)) | ((_19544 & 2863311530u) >> uint(1))) >> (32u - PushConstants_t_1_m0.y)) * uint64_t(PushConstants_t_1_m0.w)) + (uint64_t(_16324) * uint64_t(PushConstants_t_1_m1.x))) % uint64_t(PushConstants_t_1_m1.y)) + ((PushConstants_t_1_m2.x + 1u) * PushConstants_t_1_m1.y);
	    uint _7315 = 2u * gl_GlobalInvocationID.z;
	    float _19097;
	    do
	    {
	        float _19095;
	        bool _19096;
	        switch (_7315)
	        {
	            case 0u:
	            {
	                uint _20847 = (_12091 << uint(16)) | (_12091 >> uint(16));
	                uint _19545 = ((_20847 & 16711935u) << uint(8)) | ((_20847 & 4278255360u) >> uint(8));
	                uint _19546 = ((_19545 & 252645135u) << uint(4)) | ((_19545 & 4042322160u) >> uint(4));
	                uint _19547 = ((_19546 & 858993459u) << uint(2)) | ((_19546 & 3435973836u) >> uint(2));
	                _19095 = asfloat(1065353216u | ((((_19547 & 1431655765u) << uint(1)) | ((_19547 & 2863311530u) >> uint(1))) >> uint(9))) - 1.0f;
	                _19096 = true;
	                break;
	            }
	            case 1u:
	            {
	                uint _23883 = _12091 % 243u;
	                uint _19052 = _23883 / 2u;
	                uint _19059;
	                if ((_23883 & 1u) != 0u)
	                {
	                    _19059 = g_ScrambledHaltonPermutations.Load<uint>(_19052 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19059 = g_ScrambledHaltonPermutations.Load<uint>(_19052 * 4 + 0) & 65535u;
	                }
	                uint _9662 = (_12091 / 243u) % 243u;
	                uint _21793 = _9662 / 2u;
	                uint _19068;
	                if ((_9662 & 1u) != 0u)
	                {
	                    _19068 = g_ScrambledHaltonPermutations.Load<uint>(_21793 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19068 = g_ScrambledHaltonPermutations.Load<uint>(_21793 * 4 + 0) & 65535u;
	                }
	                uint _25181 = (_12091 / 59049u) % 243u;
	                uint _21795 = _25181 / 2u;
	                uint _19076;
	                if ((_25181 & 1u) != 0u)
	                {
	                    _19076 = g_ScrambledHaltonPermutations.Load<uint>(_21795 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19076 = g_ScrambledHaltonPermutations.Load<uint>(_21795 * 4 + 0) & 65535u;
	                }
	                uint _25182 = (_12091 / 14348907u) % 243u;
	                uint _21797 = _25182 / 2u;
	                uint _19084;
	                if ((_25182 & 1u) != 0u)
	                {
	                    _19084 = g_ScrambledHaltonPermutations.Load<uint>(_21797 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19084 = g_ScrambledHaltonPermutations.Load<uint>(_21797 * 4 + 0) & 65535u;
	                }
	                _19095 = float((((_19059 * 14348907u) + (_19068 * 59049u)) + (_19076 * 243u)) + _19084) * 2.8679716934654209126165369525552e-10f;
	                _19096 = true;
	                break;
	            }
	            case 2u:
	            {
	                uint _19011 = 243u + (_12091 % 125u);
	                uint _19012 = _19011 / 2u;
	                uint _19020;
	                if ((_19011 & 1u) != 0u)
	                {
	                    _19020 = g_ScrambledHaltonPermutations.Load<uint>(_19012 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19020 = g_ScrambledHaltonPermutations.Load<uint>(_19012 * 4 + 0) & 65535u;
	                }
	                uint _20844 = 243u + ((_12091 / 125u) % 125u);
	                uint _19024 = _20844 / 2u;
	                uint _19031;
	                if ((_20844 & 1u) != 0u)
	                {
	                    _19031 = g_ScrambledHaltonPermutations.Load<uint>(_19024 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19031 = g_ScrambledHaltonPermutations.Load<uint>(_19024 * 4 + 0) & 65535u;
	                }
	                uint _20845 = 243u + ((_12091 / 15625u) % 125u);
	                uint _19033 = _20845 / 2u;
	                uint _19040;
	                if ((_20845 & 1u) != 0u)
	                {
	                    _19040 = g_ScrambledHaltonPermutations.Load<uint>(_19033 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19040 = g_ScrambledHaltonPermutations.Load<uint>(_19033 * 4 + 0) & 65535u;
	                }
	                uint _20846 = 243u + ((_12091 / 1953125u) % 125u);
	                uint _19042 = _20846 / 2u;
	                uint _19049;
	                if ((_20846 & 1u) != 0u)
	                {
	                    _19049 = g_ScrambledHaltonPermutations.Load<uint>(_19042 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19049 = g_ScrambledHaltonPermutations.Load<uint>(_19042 * 4 + 0) & 65535u;
	                }
	                _19095 = float((((_19020 * 1953125u) + (_19031 * 15625u)) + (_19040 * 125u)) + _19049) * 4.0959995395439818821614608168602e-09f;
	                _19096 = true;
	                break;
	            }
	            case 3u:
	            {
	                uint _9640 = _12091 % 343u;
	                uint _18981 = (368u + _9640) / 2u;
	                uint _18988;
	                if ((_9640 & 1u) != 0u)
	                {
	                    _18988 = g_ScrambledHaltonPermutations.Load<uint>(_18981 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18988 = g_ScrambledHaltonPermutations.Load<uint>(_18981 * 4 + 0) & 65535u;
	                }
	                uint _18991 = (_12091 / 343u) % 343u;
	                uint _18992 = (368u + _18991) / 2u;
	                uint _18999;
	                if ((_18991 & 1u) != 0u)
	                {
	                    _18999 = g_ScrambledHaltonPermutations.Load<uint>(_18992 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18999 = g_ScrambledHaltonPermutations.Load<uint>(_18992 * 4 + 0) & 65535u;
	                }
	                uint _9645 = (_12091 / 117649u) % 343u;
	                uint _19001 = (368u + _9645) / 2u;
	                uint _19008;
	                if ((_9645 & 1u) != 0u)
	                {
	                    _19008 = g_ScrambledHaltonPermutations.Load<uint>(_19001 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19008 = g_ScrambledHaltonPermutations.Load<uint>(_19001 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_18988 * 117649u) + (_18999 * 343u)) + _19008) * 2.47809293085765602882020175457e-08f;
	                _19096 = true;
	                break;
	            }
	            case 4u:
	            {
	                uint _18940 = 711u + (_12091 % 121u);
	                uint _18941 = _18940 / 2u;
	                uint _18948;
	                if ((_18940 & 1u) != 0u)
	                {
	                    _18948 = g_ScrambledHaltonPermutations.Load<uint>(_18941 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18948 = g_ScrambledHaltonPermutations.Load<uint>(_18941 * 4 + 0) & 65535u;
	                }
	                uint _20839 = 711u + ((_12091 / 121u) % 121u);
	                uint _18952 = _20839 / 2u;
	                uint _18959;
	                if ((_20839 & 1u) != 0u)
	                {
	                    _18959 = g_ScrambledHaltonPermutations.Load<uint>(_18952 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18959 = g_ScrambledHaltonPermutations.Load<uint>(_18952 * 4 + 0) & 65535u;
	                }
	                uint _20840 = 711u + ((_12091 / 14641u) % 121u);
	                uint _18961 = _20840 / 2u;
	                uint _18968;
	                if ((_20840 & 1u) != 0u)
	                {
	                    _18968 = g_ScrambledHaltonPermutations.Load<uint>(_18961 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18968 = g_ScrambledHaltonPermutations.Load<uint>(_18961 * 4 + 0) & 65535u;
	                }
	                uint _20841 = 711u + ((_12091 / 1771561u) % 121u);
	                uint _18970 = _20841 / 2u;
	                uint _18977;
	                if ((_20841 & 1u) != 0u)
	                {
	                    _18977 = g_ScrambledHaltonPermutations.Load<uint>(_18970 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18977 = g_ScrambledHaltonPermutations.Load<uint>(_18970 * 4 + 0) & 65535u;
	                }
	                _19095 = float((((_18948 * 1771561u) + (_18959 * 14641u)) + (_18968 * 121u)) + _18977) * 4.6650732166142461210256442427635e-09f;
	                _19096 = true;
	                break;
	            }
	            case 5u:
	            {
	                uint _9616 = _12091 % 169u;
	                uint _18901 = (832u + _9616) / 2u;
	                uint _18908;
	                if ((_9616 & 1u) != 0u)
	                {
	                    _18908 = g_ScrambledHaltonPermutations.Load<uint>(_18901 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18908 = g_ScrambledHaltonPermutations.Load<uint>(_18901 * 4 + 0) & 65535u;
	                }
	                uint _18911 = (_12091 / 169u) % 169u;
	                uint _18912 = (832u + _18911) / 2u;
	                uint _18919;
	                if ((_18911 & 1u) != 0u)
	                {
	                    _18919 = g_ScrambledHaltonPermutations.Load<uint>(_18912 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18919 = g_ScrambledHaltonPermutations.Load<uint>(_18912 * 4 + 0) & 65535u;
	                }
	                uint _9621 = (_12091 / 28561u) % 169u;
	                uint _18921 = (832u + _9621) / 2u;
	                uint _18928;
	                if ((_9621 & 1u) != 0u)
	                {
	                    _18928 = g_ScrambledHaltonPermutations.Load<uint>(_18921 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18928 = g_ScrambledHaltonPermutations.Load<uint>(_18921 * 4 + 0) & 65535u;
	                }
	                uint _9624 = (_12091 / 4826809u) % 169u;
	                uint _18930 = (832u + _9624) / 2u;
	                uint _18937;
	                if ((_9624 & 1u) != 0u)
	                {
	                    _18937 = g_ScrambledHaltonPermutations.Load<uint>(_18930 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18937 = g_ScrambledHaltonPermutations.Load<uint>(_18930 * 4 + 0) & 65535u;
	                }
	                _19095 = float((((_18908 * 4826809u) + (_18919 * 28561u)) + (_18928 * 169u)) + _18937) * 1.2258944970255924999946728348732e-09f;
	                _19096 = true;
	                break;
	            }
	            case 6u:
	            {
	                uint _18870 = 1001u + (_12091 % 289u);
	                uint _18871 = _18870 / 2u;
	                uint _18878;
	                if ((_18870 & 1u) != 0u)
	                {
	                    _18878 = g_ScrambledHaltonPermutations.Load<uint>(_18871 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18878 = g_ScrambledHaltonPermutations.Load<uint>(_18871 * 4 + 0) & 65535u;
	                }
	                uint _20834 = 1001u + ((_12091 / 289u) % 289u);
	                uint _18882 = _20834 / 2u;
	                uint _18889;
	                if ((_20834 & 1u) != 0u)
	                {
	                    _18889 = g_ScrambledHaltonPermutations.Load<uint>(_18882 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18889 = g_ScrambledHaltonPermutations.Load<uint>(_18882 * 4 + 0) & 65535u;
	                }
	                uint _20835 = 1001u + ((_12091 / 83521u) % 289u);
	                uint _18891 = _20835 / 2u;
	                uint _18898;
	                if ((_20835 & 1u) != 0u)
	                {
	                    _18898 = g_ScrambledHaltonPermutations.Load<uint>(_18891 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18898 = g_ScrambledHaltonPermutations.Load<uint>(_18891 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_18878 * 83521u) + (_18889 * 289u)) + _18898) * 4.1429188968322705477476119995117e-08f;
	                _19096 = true;
	                break;
	            }
	            case 7u:
	            {
	                uint _9598 = _12091 % 361u;
	                uint _18841 = (1290u + _9598) / 2u;
	                uint _18848;
	                if ((_9598 & 1u) != 0u)
	                {
	                    _18848 = g_ScrambledHaltonPermutations.Load<uint>(_18841 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18848 = g_ScrambledHaltonPermutations.Load<uint>(_18841 * 4 + 0) & 65535u;
	                }
	                uint _18851 = (_12091 / 361u) % 361u;
	                uint _18852 = (1290u + _18851) / 2u;
	                uint _18859;
	                if ((_18851 & 1u) != 0u)
	                {
	                    _18859 = g_ScrambledHaltonPermutations.Load<uint>(_18852 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18859 = g_ScrambledHaltonPermutations.Load<uint>(_18852 * 4 + 0) & 65535u;
	                }
	                uint _9603 = (_12091 / 130321u) % 361u;
	                uint _18861 = (1290u + _9603) / 2u;
	                uint _18868;
	                if ((_9603 & 1u) != 0u)
	                {
	                    _18868 = g_ScrambledHaltonPermutations.Load<uint>(_18861 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18868 = g_ScrambledHaltonPermutations.Load<uint>(_18861 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_18848 * 130321u) + (_18859 * 361u)) + _18868) * 2.1255843307699251454323530197144e-08f;
	                _19096 = true;
	                break;
	            }
	            case 8u:
	            {
	                uint _18774 = 1651u + (_12091 % 23u);
	                uint _18775 = _18774 / 2u;
	                uint _18782;
	                if ((_18774 & 1u) != 0u)
	                {
	                    _18782 = g_ScrambledHaltonPermutations.Load<uint>(_18775 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18782 = g_ScrambledHaltonPermutations.Load<uint>(_18775 * 4 + 0) & 65535u;
	                }
	                uint _20826 = 1651u + ((_12091 / 23u) % 23u);
	                uint _18786 = _20826 / 2u;
	                uint _18793;
	                if ((_20826 & 1u) != 0u)
	                {
	                    _18793 = g_ScrambledHaltonPermutations.Load<uint>(_18786 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18793 = g_ScrambledHaltonPermutations.Load<uint>(_18786 * 4 + 0) & 65535u;
	                }
	                uint _20827 = 1651u + ((_12091 / 529u) % 23u);
	                uint _18795 = _20827 / 2u;
	                uint _18802;
	                if ((_20827 & 1u) != 0u)
	                {
	                    _18802 = g_ScrambledHaltonPermutations.Load<uint>(_18795 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18802 = g_ScrambledHaltonPermutations.Load<uint>(_18795 * 4 + 0) & 65535u;
	                }
	                uint _20828 = 1651u + ((_12091 / 12167u) % 23u);
	                uint _18804 = _20828 / 2u;
	                uint _18811;
	                if ((_20828 & 1u) != 0u)
	                {
	                    _18811 = g_ScrambledHaltonPermutations.Load<uint>(_18804 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18811 = g_ScrambledHaltonPermutations.Load<uint>(_18804 * 4 + 0) & 65535u;
	                }
	                uint _20829 = 1651u + ((_12091 / 279841u) % 23u);
	                uint _18813 = _20829 / 2u;
	                uint _18820;
	                if ((_20829 & 1u) != 0u)
	                {
	                    _18820 = g_ScrambledHaltonPermutations.Load<uint>(_18813 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18820 = g_ScrambledHaltonPermutations.Load<uint>(_18813 * 4 + 0) & 65535u;
	                }
	                uint _20830 = 1651u + ((_12091 / 6436343u) % 23u);
	                uint _18822 = _20830 / 2u;
	                uint _18829;
	                if ((_20830 & 1u) != 0u)
	                {
	                    _18829 = g_ScrambledHaltonPermutations.Load<uint>(_18822 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18829 = g_ScrambledHaltonPermutations.Load<uint>(_18822 * 4 + 0) & 65535u;
	                }
	                uint _20831 = 1651u + ((_12091 / 148035889u) % 23u);
	                uint _18831 = _20831 / 2u;
	                uint _18838;
	                if ((_20831 & 1u) != 0u)
	                {
	                    _18838 = g_ScrambledHaltonPermutations.Load<uint>(_18831 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18838 = g_ScrambledHaltonPermutations.Load<uint>(_18831 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((((((_18782 * 148035889u) + (_18793 * 6436343u)) + (_18802 * 279841u)) + (_18811 * 12167u)) + (_18820 * 529u)) + (_18829 * 23u)) + _18838) * 2.9370078591384185529022943228483e-10f;
	                _19096 = true;
	                break;
	            }
	            case 9u:
	            {
	                uint _9559 = _12091 % 29u;
	                uint _18718 = (1674u + _9559) / 2u;
	                uint _18725;
	                if ((_9559 & 1u) != 0u)
	                {
	                    _18725 = g_ScrambledHaltonPermutations.Load<uint>(_18718 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18725 = g_ScrambledHaltonPermutations.Load<uint>(_18718 * 4 + 0) & 65535u;
	                }
	                uint _18728 = (_12091 / 29u) % 29u;
	                uint _18729 = (1674u + _18728) / 2u;
	                uint _18736;
	                if ((_18728 & 1u) != 0u)
	                {
	                    _18736 = g_ScrambledHaltonPermutations.Load<uint>(_18729 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18736 = g_ScrambledHaltonPermutations.Load<uint>(_18729 * 4 + 0) & 65535u;
	                }
	                uint _9564 = (_12091 / 841u) % 29u;
	                uint _18738 = (1674u + _9564) / 2u;
	                uint _18745;
	                if ((_9564 & 1u) != 0u)
	                {
	                    _18745 = g_ScrambledHaltonPermutations.Load<uint>(_18738 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18745 = g_ScrambledHaltonPermutations.Load<uint>(_18738 * 4 + 0) & 65535u;
	                }
	                uint _9567 = (_12091 / 24389u) % 29u;
	                uint _18747 = (1674u + _9567) / 2u;
	                uint _18754;
	                if ((_9567 & 1u) != 0u)
	                {
	                    _18754 = g_ScrambledHaltonPermutations.Load<uint>(_18747 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18754 = g_ScrambledHaltonPermutations.Load<uint>(_18747 * 4 + 0) & 65535u;
	                }
	                uint _9570 = (_12091 / 707281u) % 29u;
	                uint _18756 = (1674u + _9570) / 2u;
	                uint _18763;
	                if ((_9570 & 1u) != 0u)
	                {
	                    _18763 = g_ScrambledHaltonPermutations.Load<uint>(_18756 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18763 = g_ScrambledHaltonPermutations.Load<uint>(_18756 * 4 + 0) & 65535u;
	                }
	                uint _9573 = (_12091 / 20511149u) % 29u;
	                uint _18765 = (1674u + _9573) / 2u;
	                uint _18772;
	                if ((_9573 & 1u) != 0u)
	                {
	                    _18772 = g_ScrambledHaltonPermutations.Load<uint>(_18765 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18772 = g_ScrambledHaltonPermutations.Load<uint>(_18765 * 4 + 0) & 65535u;
	                }
	                _19095 = float((((((_18725 * 20511149u) + (_18736 * 707281u)) + (_18745 * 24389u)) + (_18754 * 841u)) + (_18763 * 29u)) + _18772) * 1.6811713132725003561063203960657e-09f;
	                _19096 = true;
	                break;
	            }
	            case 10u:
	            {
	                uint _18660 = 1703u + (_12091 % 31u);
	                uint _18661 = _18660 / 2u;
	                uint _18668;
	                if ((_18660 & 1u) != 0u)
	                {
	                    _18668 = g_ScrambledHaltonPermutations.Load<uint>(_18661 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18668 = g_ScrambledHaltonPermutations.Load<uint>(_18661 * 4 + 0) & 65535u;
	                }
	                uint _20816 = 1703u + ((_12091 / 31u) % 31u);
	                uint _18672 = _20816 / 2u;
	                uint _18679;
	                if ((_20816 & 1u) != 0u)
	                {
	                    _18679 = g_ScrambledHaltonPermutations.Load<uint>(_18672 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18679 = g_ScrambledHaltonPermutations.Load<uint>(_18672 * 4 + 0) & 65535u;
	                }
	                uint _20817 = 1703u + ((_12091 / 961u) % 31u);
	                uint _18681 = _20817 / 2u;
	                uint _18688;
	                if ((_20817 & 1u) != 0u)
	                {
	                    _18688 = g_ScrambledHaltonPermutations.Load<uint>(_18681 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18688 = g_ScrambledHaltonPermutations.Load<uint>(_18681 * 4 + 0) & 65535u;
	                }
	                uint _20818 = 1703u + ((_12091 / 29791u) % 31u);
	                uint _18690 = _20818 / 2u;
	                uint _18697;
	                if ((_20818 & 1u) != 0u)
	                {
	                    _18697 = g_ScrambledHaltonPermutations.Load<uint>(_18690 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18697 = g_ScrambledHaltonPermutations.Load<uint>(_18690 * 4 + 0) & 65535u;
	                }
	                uint _20819 = 1703u + ((_12091 / 923521u) % 31u);
	                uint _18699 = _20819 / 2u;
	                uint _18706;
	                if ((_20819 & 1u) != 0u)
	                {
	                    _18706 = g_ScrambledHaltonPermutations.Load<uint>(_18699 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18706 = g_ScrambledHaltonPermutations.Load<uint>(_18699 * 4 + 0) & 65535u;
	                }
	                uint _20820 = 1703u + ((_12091 / 28629151u) % 31u);
	                uint _18708 = _20820 / 2u;
	                uint _18715;
	                if ((_20820 & 1u) != 0u)
	                {
	                    _18715 = g_ScrambledHaltonPermutations.Load<uint>(_18708 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18715 = g_ScrambledHaltonPermutations.Load<uint>(_18708 * 4 + 0) & 65535u;
	                }
	                _19095 = float((((((_18668 * 28629151u) + (_18679 * 923521u)) + (_18688 * 29791u)) + (_18697 * 961u)) + (_18706 * 31u)) + _18715) * 1.126755799774059596529696136713e-09f;
	                _19096 = true;
	                break;
	            }
	            case 11u:
	            {
	                uint _9523 = _12091 % 37u;
	                uint _18603 = (1734u + _9523) / 2u;
	                uint _18610;
	                if ((_9523 & 1u) != 0u)
	                {
	                    _18610 = g_ScrambledHaltonPermutations.Load<uint>(_18603 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18610 = g_ScrambledHaltonPermutations.Load<uint>(_18603 * 4 + 0) & 65535u;
	                }
	                uint _18613 = (_12091 / 37u) % 37u;
	                uint _18614 = (1734u + _18613) / 2u;
	                uint _18622;
	                if ((_18613 & 1u) != 0u)
	                {
	                    _18622 = g_ScrambledHaltonPermutations.Load<uint>(_18614 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18622 = g_ScrambledHaltonPermutations.Load<uint>(_18614 * 4 + 0) & 65535u;
	                }
	                uint _9528 = (_12091 / 1369u) % 37u;
	                uint _18624 = (1734u + _9528) / 2u;
	                uint _18631;
	                if ((_9528 & 1u) != 0u)
	                {
	                    _18631 = g_ScrambledHaltonPermutations.Load<uint>(_18624 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18631 = g_ScrambledHaltonPermutations.Load<uint>(_18624 * 4 + 0) & 65535u;
	                }
	                uint _9531 = (_12091 / 50653u) % 37u;
	                uint _18633 = (1734u + _9531) / 2u;
	                uint _18640;
	                if ((_9531 & 1u) != 0u)
	                {
	                    _18640 = g_ScrambledHaltonPermutations.Load<uint>(_18633 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18640 = g_ScrambledHaltonPermutations.Load<uint>(_18633 * 4 + 0) & 65535u;
	                }
	                uint _9534 = (_12091 / 1874161u) % 37u;
	                uint _18642 = (1734u + _9534) / 2u;
	                uint _18649;
	                if ((_9534 & 1u) != 0u)
	                {
	                    _18649 = g_ScrambledHaltonPermutations.Load<uint>(_18642 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18649 = g_ScrambledHaltonPermutations.Load<uint>(_18642 * 4 + 0) & 65535u;
	                }
	                uint _9537 = (_12091 / 69343957u) % 37u;
	                uint _18651 = (1734u + _9537) / 2u;
	                uint _18658;
	                if ((_9537 & 1u) != 0u)
	                {
	                    _18658 = g_ScrambledHaltonPermutations.Load<uint>(_18651 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18658 = g_ScrambledHaltonPermutations.Load<uint>(_18651 * 4 + 0) & 65535u;
	                }
	                _19095 = float((((((_18610 * 69343957u) + (_18622 * 1874161u)) + (_18631 * 50653u)) + (_18640 * 1369u)) + (_18649 * 37u)) + _18658) * 3.8975311866806805483065545558929e-10f;
	                _19096 = true;
	                break;
	            }
	            case 12u:
	            {
	                uint _18551 = 1771u + (_12091 % 41u);
	                uint _18552 = _18551 / 2u;
	                uint _18559;
	                if ((_18551 & 1u) != 0u)
	                {
	                    _18559 = g_ScrambledHaltonPermutations.Load<uint>(_18552 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18559 = g_ScrambledHaltonPermutations.Load<uint>(_18552 * 4 + 0) & 65535u;
	                }
	                uint _20807 = 1771u + ((_12091 / 41u) % 41u);
	                uint _18566 = _20807 / 2u;
	                uint _18573;
	                if ((_20807 & 1u) != 0u)
	                {
	                    _18573 = g_ScrambledHaltonPermutations.Load<uint>(_18566 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18573 = g_ScrambledHaltonPermutations.Load<uint>(_18566 * 4 + 0) & 65535u;
	                }
	                uint _20808 = 1771u + ((_12091 / 1681u) % 41u);
	                uint _18575 = _20808 / 2u;
	                uint _18582;
	                if ((_20808 & 1u) != 0u)
	                {
	                    _18582 = g_ScrambledHaltonPermutations.Load<uint>(_18575 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18582 = g_ScrambledHaltonPermutations.Load<uint>(_18575 * 4 + 0) & 65535u;
	                }
	                uint _20809 = 1771u + ((_12091 / 68921u) % 41u);
	                uint _18584 = _20809 / 2u;
	                uint _18591;
	                if ((_20809 & 1u) != 0u)
	                {
	                    _18591 = g_ScrambledHaltonPermutations.Load<uint>(_18584 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18591 = g_ScrambledHaltonPermutations.Load<uint>(_18584 * 4 + 0) & 65535u;
	                }
	                uint _20810 = 1771u + ((_12091 / 2825761u) % 41u);
	                uint _18593 = _20810 / 2u;
	                uint _18600;
	                if ((_20810 & 1u) != 0u)
	                {
	                    _18600 = g_ScrambledHaltonPermutations.Load<uint>(_18593 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18600 = g_ScrambledHaltonPermutations.Load<uint>(_18593 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((((_18559 * 2825761u) + (_18573 * 68921u)) + (_18582 * 1681u)) + (_18591 * 41u)) + _18600) * 8.631388936919393017888069152832e-09f;
	                _19096 = true;
	                break;
	            }
	            case 13u:
	            {
	                uint _9493 = _12091 % 43u;
	                uint _18504 = (1812u + _9493) / 2u;
	                uint _18511;
	                if ((_9493 & 1u) != 0u)
	                {
	                    _18511 = g_ScrambledHaltonPermutations.Load<uint>(_18504 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18511 = g_ScrambledHaltonPermutations.Load<uint>(_18504 * 4 + 0) & 65535u;
	                }
	                uint _18514 = (_12091 / 43u) % 43u;
	                uint _18515 = (1812u + _18514) / 2u;
	                uint _18522;
	                if ((_18514 & 1u) != 0u)
	                {
	                    _18522 = g_ScrambledHaltonPermutations.Load<uint>(_18515 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18522 = g_ScrambledHaltonPermutations.Load<uint>(_18515 * 4 + 0) & 65535u;
	                }
	                uint _9498 = (_12091 / 1849u) % 43u;
	                uint _18524 = (1812u + _9498) / 2u;
	                uint _18531;
	                if ((_9498 & 1u) != 0u)
	                {
	                    _18531 = g_ScrambledHaltonPermutations.Load<uint>(_18524 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18531 = g_ScrambledHaltonPermutations.Load<uint>(_18524 * 4 + 0) & 65535u;
	                }
	                uint _9501 = (_12091 / 79507u) % 43u;
	                uint _18533 = (1812u + _9501) / 2u;
	                uint _18540;
	                if ((_9501 & 1u) != 0u)
	                {
	                    _18540 = g_ScrambledHaltonPermutations.Load<uint>(_18533 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18540 = g_ScrambledHaltonPermutations.Load<uint>(_18533 * 4 + 0) & 65535u;
	                }
	                uint _9504 = (_12091 / 3418801u) % 43u;
	                uint _18542 = (1812u + _9504) / 2u;
	                uint _18549;
	                if ((_9504 & 1u) != 0u)
	                {
	                    _18549 = g_ScrambledHaltonPermutations.Load<uint>(_18542 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18549 = g_ScrambledHaltonPermutations.Load<uint>(_18542 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((((_18511 * 3418801u) + (_18522 * 79507u)) + (_18531 * 1849u)) + (_18540 * 43u)) + _18549) * 6.8023293664509765221737325191498e-09f;
	                _19096 = true;
	                break;
	            }
	            case 14u:
	            {
	                uint _18455 = 1855u + (_12091 % 47u);
	                uint _18456 = _18455 / 2u;
	                uint _18463;
	                if ((_18455 & 1u) != 0u)
	                {
	                    _18463 = g_ScrambledHaltonPermutations.Load<uint>(_18456 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18463 = g_ScrambledHaltonPermutations.Load<uint>(_18456 * 4 + 0) & 65535u;
	                }
	                uint _20799 = 1855u + ((_12091 / 47u) % 47u);
	                uint _18467 = _20799 / 2u;
	                uint _18474;
	                if ((_20799 & 1u) != 0u)
	                {
	                    _18474 = g_ScrambledHaltonPermutations.Load<uint>(_18467 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18474 = g_ScrambledHaltonPermutations.Load<uint>(_18467 * 4 + 0) & 65535u;
	                }
	                uint _20800 = 1855u + ((_12091 / 2209u) % 47u);
	                uint _18476 = _20800 / 2u;
	                uint _18483;
	                if ((_20800 & 1u) != 0u)
	                {
	                    _18483 = g_ScrambledHaltonPermutations.Load<uint>(_18476 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18483 = g_ScrambledHaltonPermutations.Load<uint>(_18476 * 4 + 0) & 65535u;
	                }
	                uint _20801 = 1855u + ((_12091 / 103823u) % 47u);
	                uint _18485 = _20801 / 2u;
	                uint _18492;
	                if ((_20801 & 1u) != 0u)
	                {
	                    _18492 = g_ScrambledHaltonPermutations.Load<uint>(_18485 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18492 = g_ScrambledHaltonPermutations.Load<uint>(_18485 * 4 + 0) & 65535u;
	                }
	                uint _20802 = 1855u + ((_12091 / 4879681u) % 47u);
	                uint _18494 = _20802 / 2u;
	                uint _18501;
	                if ((_20802 & 1u) != 0u)
	                {
	                    _18501 = g_ScrambledHaltonPermutations.Load<uint>(_18494 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18501 = g_ScrambledHaltonPermutations.Load<uint>(_18494 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((((_18463 * 4879681u) + (_18474 * 103823u)) + (_18483 * 2209u)) + (_18492 * 47u)) + _18501) * 4.3602428334565956902224570512772e-09f;
	                _19096 = true;
	                break;
	            }
	            case 15u:
	            {
	                uint _9463 = _12091 % 53u;
	                uint _18408 = (1902u + _9463) / 2u;
	                uint _18415;
	                if ((_9463 & 1u) != 0u)
	                {
	                    _18415 = g_ScrambledHaltonPermutations.Load<uint>(_18408 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18415 = g_ScrambledHaltonPermutations.Load<uint>(_18408 * 4 + 0) & 65535u;
	                }
	                uint _18418 = (_12091 / 53u) % 53u;
	                uint _18419 = (1902u + _18418) / 2u;
	                uint _18426;
	                if ((_18418 & 1u) != 0u)
	                {
	                    _18426 = g_ScrambledHaltonPermutations.Load<uint>(_18419 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18426 = g_ScrambledHaltonPermutations.Load<uint>(_18419 * 4 + 0) & 65535u;
	                }
	                uint _9468 = (_12091 / 2809u) % 53u;
	                uint _18428 = (1902u + _9468) / 2u;
	                uint _18435;
	                if ((_9468 & 1u) != 0u)
	                {
	                    _18435 = g_ScrambledHaltonPermutations.Load<uint>(_18428 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18435 = g_ScrambledHaltonPermutations.Load<uint>(_18428 * 4 + 0) & 65535u;
	                }
	                uint _9471 = (_12091 / 148877u) % 53u;
	                uint _18437 = (1902u + _9471) / 2u;
	                uint _18444;
	                if ((_9471 & 1u) != 0u)
	                {
	                    _18444 = g_ScrambledHaltonPermutations.Load<uint>(_18437 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18444 = g_ScrambledHaltonPermutations.Load<uint>(_18437 * 4 + 0) & 65535u;
	                }
	                uint _9474 = (_12091 / 7890481u) % 53u;
	                uint _18446 = (1902u + _9474) / 2u;
	                uint _18453;
	                if ((_9474 & 1u) != 0u)
	                {
	                    _18453 = g_ScrambledHaltonPermutations.Load<uint>(_18446 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18453 = g_ScrambledHaltonPermutations.Load<uint>(_18446 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((((_18415 * 7890481u) + (_18426 * 148877u)) + (_18435 * 2809u)) + (_18444 * 53u)) + _18453) * 2.3912258839686728606466203927994e-09f;
	                _19096 = true;
	                break;
	            }
	            case 16u:
	            {
	                uint _18359 = 1955u + (_12091 % 59u);
	                uint _18360 = _18359 / 2u;
	                uint _18367;
	                if ((_18359 & 1u) != 0u)
	                {
	                    _18367 = g_ScrambledHaltonPermutations.Load<uint>(_18360 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18367 = g_ScrambledHaltonPermutations.Load<uint>(_18360 * 4 + 0) & 65535u;
	                }
	                uint _20791 = 1955u + ((_12091 / 59u) % 59u);
	                uint _18371 = _20791 / 2u;
	                uint _18378;
	                if ((_20791 & 1u) != 0u)
	                {
	                    _18378 = g_ScrambledHaltonPermutations.Load<uint>(_18371 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18378 = g_ScrambledHaltonPermutations.Load<uint>(_18371 * 4 + 0) & 65535u;
	                }
	                uint _20792 = 1955u + ((_12091 / 3481u) % 59u);
	                uint _18380 = _20792 / 2u;
	                uint _18387;
	                if ((_20792 & 1u) != 0u)
	                {
	                    _18387 = g_ScrambledHaltonPermutations.Load<uint>(_18380 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18387 = g_ScrambledHaltonPermutations.Load<uint>(_18380 * 4 + 0) & 65535u;
	                }
	                uint _20793 = 1955u + ((_12091 / 205379u) % 59u);
	                uint _18389 = _20793 / 2u;
	                uint _18396;
	                if ((_20793 & 1u) != 0u)
	                {
	                    _18396 = g_ScrambledHaltonPermutations.Load<uint>(_18389 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18396 = g_ScrambledHaltonPermutations.Load<uint>(_18389 * 4 + 0) & 65535u;
	                }
	                uint _20794 = 1955u + ((_12091 / 12117361u) % 59u);
	                uint _18398 = _20794 / 2u;
	                uint _18405;
	                if ((_20794 & 1u) != 0u)
	                {
	                    _18405 = g_ScrambledHaltonPermutations.Load<uint>(_18398 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18405 = g_ScrambledHaltonPermutations.Load<uint>(_18398 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((((_18367 * 12117361u) + (_18378 * 205379u)) + (_18387 * 3481u)) + (_18396 * 59u)) + _18405) * 1.3987493385769766973680816590786e-09f;
	                _19096 = true;
	                break;
	            }
	            case 17u:
	            {
	                uint _9433 = _12091 % 61u;
	                uint _18312 = (2014u + _9433) / 2u;
	                uint _18319;
	                if ((_9433 & 1u) != 0u)
	                {
	                    _18319 = g_ScrambledHaltonPermutations.Load<uint>(_18312 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18319 = g_ScrambledHaltonPermutations.Load<uint>(_18312 * 4 + 0) & 65535u;
	                }
	                uint _18322 = (_12091 / 61u) % 61u;
	                uint _18323 = (2014u + _18322) / 2u;
	                uint _18330;
	                if ((_18322 & 1u) != 0u)
	                {
	                    _18330 = g_ScrambledHaltonPermutations.Load<uint>(_18323 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18330 = g_ScrambledHaltonPermutations.Load<uint>(_18323 * 4 + 0) & 65535u;
	                }
	                uint _9438 = (_12091 / 3721u) % 61u;
	                uint _18332 = (2014u + _9438) / 2u;
	                uint _18339;
	                if ((_9438 & 1u) != 0u)
	                {
	                    _18339 = g_ScrambledHaltonPermutations.Load<uint>(_18332 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18339 = g_ScrambledHaltonPermutations.Load<uint>(_18332 * 4 + 0) & 65535u;
	                }
	                uint _9441 = (_12091 / 226981u) % 61u;
	                uint _18341 = (2014u + _9441) / 2u;
	                uint _18348;
	                if ((_9441 & 1u) != 0u)
	                {
	                    _18348 = g_ScrambledHaltonPermutations.Load<uint>(_18341 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18348 = g_ScrambledHaltonPermutations.Load<uint>(_18341 * 4 + 0) & 65535u;
	                }
	                uint _9444 = (_12091 / 13845841u) % 61u;
	                uint _18350 = (2014u + _9444) / 2u;
	                uint _18357;
	                if ((_9444 & 1u) != 0u)
	                {
	                    _18357 = g_ScrambledHaltonPermutations.Load<uint>(_18350 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18357 = g_ScrambledHaltonPermutations.Load<uint>(_18350 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((((_18319 * 13845841u) + (_18330 * 226981u)) + (_18339 * 3721u)) + (_18348 * 61u)) + _18357) * 1.1839974556338006550504360347986e-09f;
	                _19096 = true;
	                break;
	            }
	            case 18u:
	            {
	                uint _18263 = 2075u + (_12091 % 67u);
	                uint _18264 = _18263 / 2u;
	                uint _18271;
	                if ((_18263 & 1u) != 0u)
	                {
	                    _18271 = g_ScrambledHaltonPermutations.Load<uint>(_18264 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18271 = g_ScrambledHaltonPermutations.Load<uint>(_18264 * 4 + 0) & 65535u;
	                }
	                uint _20783 = 2075u + ((_12091 / 67u) % 67u);
	                uint _18275 = _20783 / 2u;
	                uint _18282;
	                if ((_20783 & 1u) != 0u)
	                {
	                    _18282 = g_ScrambledHaltonPermutations.Load<uint>(_18275 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18282 = g_ScrambledHaltonPermutations.Load<uint>(_18275 * 4 + 0) & 65535u;
	                }
	                uint _20784 = 2075u + ((_12091 / 4489u) % 67u);
	                uint _18284 = _20784 / 2u;
	                uint _18291;
	                if ((_20784 & 1u) != 0u)
	                {
	                    _18291 = g_ScrambledHaltonPermutations.Load<uint>(_18284 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18291 = g_ScrambledHaltonPermutations.Load<uint>(_18284 * 4 + 0) & 65535u;
	                }
	                uint _20785 = 2075u + ((_12091 / 300763u) % 67u);
	                uint _18293 = _20785 / 2u;
	                uint _18300;
	                if ((_20785 & 1u) != 0u)
	                {
	                    _18300 = g_ScrambledHaltonPermutations.Load<uint>(_18293 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18300 = g_ScrambledHaltonPermutations.Load<uint>(_18293 * 4 + 0) & 65535u;
	                }
	                uint _20786 = 2075u + ((_12091 / 20151121u) % 67u);
	                uint _18302 = _20786 / 2u;
	                uint _18309;
	                if ((_20786 & 1u) != 0u)
	                {
	                    _18309 = g_ScrambledHaltonPermutations.Load<uint>(_18302 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18309 = g_ScrambledHaltonPermutations.Load<uint>(_18302 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((((_18271 * 20151121u) + (_18282 * 300763u)) + (_18291 * 4489u)) + (_18300 * 67u)) + _18309) * 7.4067202371352891532296780496836e-10f;
	                _19096 = true;
	                break;
	            }
	            case 19u:
	            {
	                uint _9403 = _12091 % 71u;
	                uint _18216 = (2142u + _9403) / 2u;
	                uint _18223;
	                if ((_9403 & 1u) != 0u)
	                {
	                    _18223 = g_ScrambledHaltonPermutations.Load<uint>(_18216 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18223 = g_ScrambledHaltonPermutations.Load<uint>(_18216 * 4 + 0) & 65535u;
	                }
	                uint _18226 = (_12091 / 71u) % 71u;
	                uint _18227 = (2142u + _18226) / 2u;
	                uint _18234;
	                if ((_18226 & 1u) != 0u)
	                {
	                    _18234 = g_ScrambledHaltonPermutations.Load<uint>(_18227 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18234 = g_ScrambledHaltonPermutations.Load<uint>(_18227 * 4 + 0) & 65535u;
	                }
	                uint _9408 = (_12091 / 5041u) % 71u;
	                uint _18236 = (2142u + _9408) / 2u;
	                uint _18243;
	                if ((_9408 & 1u) != 0u)
	                {
	                    _18243 = g_ScrambledHaltonPermutations.Load<uint>(_18236 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18243 = g_ScrambledHaltonPermutations.Load<uint>(_18236 * 4 + 0) & 65535u;
	                }
	                uint _9411 = (_12091 / 357911u) % 71u;
	                uint _18245 = (2142u + _9411) / 2u;
	                uint _18252;
	                if ((_9411 & 1u) != 0u)
	                {
	                    _18252 = g_ScrambledHaltonPermutations.Load<uint>(_18245 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18252 = g_ScrambledHaltonPermutations.Load<uint>(_18245 * 4 + 0) & 65535u;
	                }
	                uint _9414 = (_12091 / 25411681u) % 71u;
	                uint _18254 = (2142u + _9414) / 2u;
	                uint _18261;
	                if ((_9414 & 1u) != 0u)
	                {
	                    _18261 = g_ScrambledHaltonPermutations.Load<uint>(_18254 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18261 = g_ScrambledHaltonPermutations.Load<uint>(_18254 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((((_18223 * 25411681u) + (_18234 * 357911u)) + (_18243 * 5041u)) + (_18252 * 71u)) + _18261) * 5.5425319889224056169041432440281e-10f;
	                _19096 = true;
	                break;
	            }
	            case 20u:
	            {
	                uint _18167 = 2213u + (_12091 % 73u);
	                uint _18168 = _18167 / 2u;
	                uint _18175;
	                if ((_18167 & 1u) != 0u)
	                {
	                    _18175 = g_ScrambledHaltonPermutations.Load<uint>(_18168 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18175 = g_ScrambledHaltonPermutations.Load<uint>(_18168 * 4 + 0) & 65535u;
	                }
	                uint _20775 = 2213u + ((_12091 / 73u) % 73u);
	                uint _18179 = _20775 / 2u;
	                uint _18186;
	                if ((_20775 & 1u) != 0u)
	                {
	                    _18186 = g_ScrambledHaltonPermutations.Load<uint>(_18179 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18186 = g_ScrambledHaltonPermutations.Load<uint>(_18179 * 4 + 0) & 65535u;
	                }
	                uint _20776 = 2213u + ((_12091 / 5329u) % 73u);
	                uint _18188 = _20776 / 2u;
	                uint _18195;
	                if ((_20776 & 1u) != 0u)
	                {
	                    _18195 = g_ScrambledHaltonPermutations.Load<uint>(_18188 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18195 = g_ScrambledHaltonPermutations.Load<uint>(_18188 * 4 + 0) & 65535u;
	                }
	                uint _20777 = 2213u + ((_12091 / 389017u) % 73u);
	                uint _18197 = _20777 / 2u;
	                uint _18204;
	                if ((_20777 & 1u) != 0u)
	                {
	                    _18204 = g_ScrambledHaltonPermutations.Load<uint>(_18197 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18204 = g_ScrambledHaltonPermutations.Load<uint>(_18197 * 4 + 0) & 65535u;
	                }
	                uint _20778 = 2213u + ((_12091 / 28398241u) % 73u);
	                uint _18206 = _20778 / 2u;
	                uint _18213;
	                if ((_20778 & 1u) != 0u)
	                {
	                    _18213 = g_ScrambledHaltonPermutations.Load<uint>(_18206 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18213 = g_ScrambledHaltonPermutations.Load<uint>(_18206 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((((_18175 * 28398241u) + (_18186 * 389017u)) + (_18195 * 5329u)) + (_18204 * 73u)) + _18213) * 4.8237597249922714581771288067102e-10f;
	                _19096 = true;
	                break;
	            }
	            case 21u:
	            {
	                uint _9373 = _12091 % 79u;
	                uint _18120 = (2286u + _9373) / 2u;
	                uint _18127;
	                if ((_9373 & 1u) != 0u)
	                {
	                    _18127 = g_ScrambledHaltonPermutations.Load<uint>(_18120 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18127 = g_ScrambledHaltonPermutations.Load<uint>(_18120 * 4 + 0) & 65535u;
	                }
	                uint _18130 = (_12091 / 79u) % 79u;
	                uint _18131 = (2286u + _18130) / 2u;
	                uint _18138;
	                if ((_18130 & 1u) != 0u)
	                {
	                    _18138 = g_ScrambledHaltonPermutations.Load<uint>(_18131 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18138 = g_ScrambledHaltonPermutations.Load<uint>(_18131 * 4 + 0) & 65535u;
	                }
	                uint _9378 = (_12091 / 6241u) % 79u;
	                uint _18140 = (2286u + _9378) / 2u;
	                uint _18147;
	                if ((_9378 & 1u) != 0u)
	                {
	                    _18147 = g_ScrambledHaltonPermutations.Load<uint>(_18140 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18147 = g_ScrambledHaltonPermutations.Load<uint>(_18140 * 4 + 0) & 65535u;
	                }
	                uint _9381 = (_12091 / 493039u) % 79u;
	                uint _18149 = (2286u + _9381) / 2u;
	                uint _18156;
	                if ((_9381 & 1u) != 0u)
	                {
	                    _18156 = g_ScrambledHaltonPermutations.Load<uint>(_18149 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18156 = g_ScrambledHaltonPermutations.Load<uint>(_18149 * 4 + 0) & 65535u;
	                }
	                uint _9384 = (_12091 / 38950081u) % 79u;
	                uint _18158 = (2286u + _9384) / 2u;
	                uint _18165;
	                if ((_9384 & 1u) != 0u)
	                {
	                    _18165 = g_ScrambledHaltonPermutations.Load<uint>(_18158 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18165 = g_ScrambledHaltonPermutations.Load<uint>(_18158 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((((_18127 * 38950081u) + (_18138 * 493039u)) + (_18147 * 6241u)) + (_18156 * 79u)) + _18165) * 3.2498587154705660395848099142313e-10f;
	                _19096 = true;
	                break;
	            }
	            case 22u:
	            {
	                uint _18070 = 2365u + (_12091 % 83u);
	                uint _18071 = _18070 / 2u;
	                uint _18078;
	                if ((_18070 & 1u) != 0u)
	                {
	                    _18078 = g_ScrambledHaltonPermutations.Load<uint>(_18071 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18078 = g_ScrambledHaltonPermutations.Load<uint>(_18071 * 4 + 0) & 65535u;
	                }
	                uint _20767 = 2365u + ((_12091 / 83u) % 83u);
	                uint _18082 = _20767 / 2u;
	                uint _18089;
	                if ((_20767 & 1u) != 0u)
	                {
	                    _18089 = g_ScrambledHaltonPermutations.Load<uint>(_18082 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18089 = g_ScrambledHaltonPermutations.Load<uint>(_18082 * 4 + 0) & 65535u;
	                }
	                uint _20768 = 2365u + ((_12091 / 6889u) % 83u);
	                uint _18091 = _20768 / 2u;
	                uint _18098;
	                if ((_20768 & 1u) != 0u)
	                {
	                    _18098 = g_ScrambledHaltonPermutations.Load<uint>(_18091 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18098 = g_ScrambledHaltonPermutations.Load<uint>(_18091 * 4 + 0) & 65535u;
	                }
	                uint _20769 = 2365u + ((_12091 / 571787u) % 83u);
	                uint _18100 = _20769 / 2u;
	                uint _18107;
	                if ((_20769 & 1u) != 0u)
	                {
	                    _18107 = g_ScrambledHaltonPermutations.Load<uint>(_18100 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18107 = g_ScrambledHaltonPermutations.Load<uint>(_18100 * 4 + 0) & 65535u;
	                }
	                uint _20770 = 2365u + ((_12091 / 47458321u) % 83u);
	                uint _18109 = _20770 / 2u;
	                uint _18116;
	                if ((_20770 & 1u) != 0u)
	                {
	                    _18116 = g_ScrambledHaltonPermutations.Load<uint>(_18109 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18116 = g_ScrambledHaltonPermutations.Load<uint>(_18109 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((((_18078 * 47458321u) + (_18089 * 571787u)) + (_18098 * 6889u)) + (_18107 * 83u)) + _18116) * 2.5386887037015526402683462947607e-10f;
	                _19096 = true;
	                break;
	            }
	            case 23u:
	            {
	                uint _9346 = _12091 % 89u;
	                uint _18032 = (2448u + _9346) / 2u;
	                uint _18039;
	                if ((_9346 & 1u) != 0u)
	                {
	                    _18039 = g_ScrambledHaltonPermutations.Load<uint>(_18032 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18039 = g_ScrambledHaltonPermutations.Load<uint>(_18032 * 4 + 0) & 65535u;
	                }
	                uint _18042 = (_12091 / 89u) % 89u;
	                uint _18043 = (2448u + _18042) / 2u;
	                uint _18050;
	                if ((_18042 & 1u) != 0u)
	                {
	                    _18050 = g_ScrambledHaltonPermutations.Load<uint>(_18043 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18050 = g_ScrambledHaltonPermutations.Load<uint>(_18043 * 4 + 0) & 65535u;
	                }
	                uint _9351 = (_12091 / 7921u) % 89u;
	                uint _18052 = (2448u + _9351) / 2u;
	                uint _18059;
	                if ((_9351 & 1u) != 0u)
	                {
	                    _18059 = g_ScrambledHaltonPermutations.Load<uint>(_18052 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18059 = g_ScrambledHaltonPermutations.Load<uint>(_18052 * 4 + 0) & 65535u;
	                }
	                uint _9354 = (_12091 / 704969u) % 89u;
	                uint _18061 = (2448u + _9354) / 2u;
	                uint _18068;
	                if ((_9354 & 1u) != 0u)
	                {
	                    _18068 = g_ScrambledHaltonPermutations.Load<uint>(_18061 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18068 = g_ScrambledHaltonPermutations.Load<uint>(_18061 * 4 + 0) & 65535u;
	                }
	                _19095 = float((((_18039 * 704969u) + (_18050 * 7921u)) + (_18059 * 89u)) + _18068) * 1.593822496204211347503587603569e-08f;
	                _19096 = true;
	                break;
	            }
	            case 24u:
	            {
	                uint _17992 = 2537u + (_12091 % 97u);
	                uint _17993 = _17992 / 2u;
	                uint _18000;
	                if ((_17992 & 1u) != 0u)
	                {
	                    _18000 = g_ScrambledHaltonPermutations.Load<uint>(_17993 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18000 = g_ScrambledHaltonPermutations.Load<uint>(_17993 * 4 + 0) & 65535u;
	                }
	                uint _20761 = 2537u + ((_12091 / 97u) % 97u);
	                uint _18004 = _20761 / 2u;
	                uint _18011;
	                if ((_20761 & 1u) != 0u)
	                {
	                    _18011 = g_ScrambledHaltonPermutations.Load<uint>(_18004 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18011 = g_ScrambledHaltonPermutations.Load<uint>(_18004 * 4 + 0) & 65535u;
	                }
	                uint _20762 = 2537u + ((_12091 / 9409u) % 97u);
	                uint _18013 = _20762 / 2u;
	                uint _18020;
	                if ((_20762 & 1u) != 0u)
	                {
	                    _18020 = g_ScrambledHaltonPermutations.Load<uint>(_18013 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18020 = g_ScrambledHaltonPermutations.Load<uint>(_18013 * 4 + 0) & 65535u;
	                }
	                uint _20763 = 2537u + ((_12091 / 912673u) % 97u);
	                uint _18022 = _20763 / 2u;
	                uint _18029;
	                if ((_20763 & 1u) != 0u)
	                {
	                    _18029 = g_ScrambledHaltonPermutations.Load<uint>(_18022 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _18029 = g_ScrambledHaltonPermutations.Load<uint>(_18022 * 4 + 0) & 65535u;
	                }
	                _19095 = float((((_18000 * 912673u) + (_18011 * 9409u)) + (_18020 * 97u)) + _18029) * 1.1295696822344325482845306396484e-08f;
	                _19096 = true;
	                break;
	            }
	            case 25u:
	            {
	                uint _9322 = _12091 % 101u;
	                uint _17954 = (2634u + _9322) / 2u;
	                uint _17961;
	                if ((_9322 & 1u) != 0u)
	                {
	                    _17961 = g_ScrambledHaltonPermutations.Load<uint>(_17954 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17961 = g_ScrambledHaltonPermutations.Load<uint>(_17954 * 4 + 0) & 65535u;
	                }
	                uint _17964 = (_12091 / 101u) % 101u;
	                uint _17965 = (2634u + _17964) / 2u;
	                uint _17972;
	                if ((_17964 & 1u) != 0u)
	                {
	                    _17972 = g_ScrambledHaltonPermutations.Load<uint>(_17965 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17972 = g_ScrambledHaltonPermutations.Load<uint>(_17965 * 4 + 0) & 65535u;
	                }
	                uint _9327 = (_12091 / 10201u) % 101u;
	                uint _17974 = (2634u + _9327) / 2u;
	                uint _17981;
	                if ((_9327 & 1u) != 0u)
	                {
	                    _17981 = g_ScrambledHaltonPermutations.Load<uint>(_17974 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17981 = g_ScrambledHaltonPermutations.Load<uint>(_17974 * 4 + 0) & 65535u;
	                }
	                uint _9330 = (_12091 / 1030301u) % 101u;
	                uint _17983 = (2634u + _9330) / 2u;
	                uint _17990;
	                if ((_9330 & 1u) != 0u)
	                {
	                    _17990 = g_ScrambledHaltonPermutations.Load<uint>(_17983 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17990 = g_ScrambledHaltonPermutations.Load<uint>(_17983 * 4 + 0) & 65535u;
	                }
	                _19095 = float((((_17961 * 1030301u) + (_17972 * 10201u)) + (_17981 * 101u)) + _17990) * 9.6098027313473721733316779136658e-09f;
	                _19096 = true;
	                break;
	            }
	            case 26u:
	            {
	                uint _17914 = 2735u + (_12091 % 103u);
	                uint _17915 = _17914 / 2u;
	                uint _17922;
	                if ((_17914 & 1u) != 0u)
	                {
	                    _17922 = g_ScrambledHaltonPermutations.Load<uint>(_17915 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17922 = g_ScrambledHaltonPermutations.Load<uint>(_17915 * 4 + 0) & 65535u;
	                }
	                uint _20755 = 2735u + ((_12091 / 103u) % 103u);
	                uint _17926 = _20755 / 2u;
	                uint _17933;
	                if ((_20755 & 1u) != 0u)
	                {
	                    _17933 = g_ScrambledHaltonPermutations.Load<uint>(_17926 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17933 = g_ScrambledHaltonPermutations.Load<uint>(_17926 * 4 + 0) & 65535u;
	                }
	                uint _20756 = 2735u + ((_12091 / 10609u) % 103u);
	                uint _17935 = _20756 / 2u;
	                uint _17942;
	                if ((_20756 & 1u) != 0u)
	                {
	                    _17942 = g_ScrambledHaltonPermutations.Load<uint>(_17935 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17942 = g_ScrambledHaltonPermutations.Load<uint>(_17935 * 4 + 0) & 65535u;
	                }
	                uint _20757 = 2735u + ((_12091 / 1092727u) % 103u);
	                uint _17944 = _20757 / 2u;
	                uint _17951;
	                if ((_20757 & 1u) != 0u)
	                {
	                    _17951 = g_ScrambledHaltonPermutations.Load<uint>(_17944 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17951 = g_ScrambledHaltonPermutations.Load<uint>(_17944 * 4 + 0) & 65535u;
	                }
	                _19095 = float((((_17922 * 1092727u) + (_17933 * 10609u)) + (_17942 * 103u)) + _17951) * 8.8848697288312905584461987018585e-09f;
	                _19096 = true;
	                break;
	            }
	            case 27u:
	            {
	                uint _9298 = _12091 % 107u;
	                uint _17876 = (2838u + _9298) / 2u;
	                uint _17883;
	                if ((_9298 & 1u) != 0u)
	                {
	                    _17883 = g_ScrambledHaltonPermutations.Load<uint>(_17876 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17883 = g_ScrambledHaltonPermutations.Load<uint>(_17876 * 4 + 0) & 65535u;
	                }
	                uint _17886 = (_12091 / 107u) % 107u;
	                uint _17887 = (2838u + _17886) / 2u;
	                uint _17894;
	                if ((_17886 & 1u) != 0u)
	                {
	                    _17894 = g_ScrambledHaltonPermutations.Load<uint>(_17887 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17894 = g_ScrambledHaltonPermutations.Load<uint>(_17887 * 4 + 0) & 65535u;
	                }
	                uint _9303 = (_12091 / 11449u) % 107u;
	                uint _17896 = (2838u + _9303) / 2u;
	                uint _17903;
	                if ((_9303 & 1u) != 0u)
	                {
	                    _17903 = g_ScrambledHaltonPermutations.Load<uint>(_17896 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17903 = g_ScrambledHaltonPermutations.Load<uint>(_17896 * 4 + 0) & 65535u;
	                }
	                uint _9306 = (_12091 / 1225043u) % 107u;
	                uint _17905 = (2838u + _9306) / 2u;
	                uint _17912;
	                if ((_9306 & 1u) != 0u)
	                {
	                    _17912 = g_ScrambledHaltonPermutations.Load<uint>(_17905 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17912 = g_ScrambledHaltonPermutations.Load<uint>(_17905 * 4 + 0) & 65535u;
	                }
	                _19095 = float((((_17883 * 1225043u) + (_17894 * 11449u)) + (_17903 * 107u)) + _17912) * 7.6289516925953648751601576805115e-09f;
	                _19096 = true;
	                break;
	            }
	            case 28u:
	            {
	                uint _17836 = 2945u + (_12091 % 109u);
	                uint _17837 = _17836 / 2u;
	                uint _17844;
	                if ((_17836 & 1u) != 0u)
	                {
	                    _17844 = g_ScrambledHaltonPermutations.Load<uint>(_17837 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17844 = g_ScrambledHaltonPermutations.Load<uint>(_17837 * 4 + 0) & 65535u;
	                }
	                uint _20749 = 2945u + ((_12091 / 109u) % 109u);
	                uint _17848 = _20749 / 2u;
	                uint _17855;
	                if ((_20749 & 1u) != 0u)
	                {
	                    _17855 = g_ScrambledHaltonPermutations.Load<uint>(_17848 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17855 = g_ScrambledHaltonPermutations.Load<uint>(_17848 * 4 + 0) & 65535u;
	                }
	                uint _20750 = 2945u + ((_12091 / 11881u) % 109u);
	                uint _17857 = _20750 / 2u;
	                uint _17864;
	                if ((_20750 & 1u) != 0u)
	                {
	                    _17864 = g_ScrambledHaltonPermutations.Load<uint>(_17857 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17864 = g_ScrambledHaltonPermutations.Load<uint>(_17857 * 4 + 0) & 65535u;
	                }
	                uint _20751 = 2945u + ((_12091 / 1295029u) % 109u);
	                uint _17866 = _20751 / 2u;
	                uint _17873;
	                if ((_20751 & 1u) != 0u)
	                {
	                    _17873 = g_ScrambledHaltonPermutations.Load<uint>(_17866 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17873 = g_ScrambledHaltonPermutations.Load<uint>(_17866 * 4 + 0) & 65535u;
	                }
	                _19095 = float((((_17844 * 1295029u) + (_17855 * 11881u)) + (_17864 * 109u)) + _17873) * 7.0842514077185114729218184947968e-09f;
	                _19096 = true;
	                break;
	            }
	            case 29u:
	            {
	                uint _9274 = _12091 % 113u;
	                uint _17798 = (3054u + _9274) / 2u;
	                uint _17805;
	                if ((_9274 & 1u) != 0u)
	                {
	                    _17805 = g_ScrambledHaltonPermutations.Load<uint>(_17798 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17805 = g_ScrambledHaltonPermutations.Load<uint>(_17798 * 4 + 0) & 65535u;
	                }
	                uint _17808 = (_12091 / 113u) % 113u;
	                uint _17809 = (3054u + _17808) / 2u;
	                uint _17816;
	                if ((_17808 & 1u) != 0u)
	                {
	                    _17816 = g_ScrambledHaltonPermutations.Load<uint>(_17809 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17816 = g_ScrambledHaltonPermutations.Load<uint>(_17809 * 4 + 0) & 65535u;
	                }
	                uint _9279 = (_12091 / 12769u) % 113u;
	                uint _17818 = (3054u + _9279) / 2u;
	                uint _17825;
	                if ((_9279 & 1u) != 0u)
	                {
	                    _17825 = g_ScrambledHaltonPermutations.Load<uint>(_17818 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17825 = g_ScrambledHaltonPermutations.Load<uint>(_17818 * 4 + 0) & 65535u;
	                }
	                uint _9282 = (_12091 / 1442897u) % 113u;
	                uint _17827 = (3054u + _9282) / 2u;
	                uint _17834;
	                if ((_9282 & 1u) != 0u)
	                {
	                    _17834 = g_ScrambledHaltonPermutations.Load<uint>(_17827 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17834 = g_ScrambledHaltonPermutations.Load<uint>(_17827 * 4 + 0) & 65535u;
	                }
	                _19095 = float((((_17805 * 1442897u) + (_17816 * 12769u)) + (_17825 * 113u)) + _17834) * 6.1331864031899385736323893070221e-09f;
	                _19096 = true;
	                break;
	            }
	            case 30u:
	            {
	                uint _17758 = 3167u + (_12091 % 127u);
	                uint _17759 = _17758 / 2u;
	                uint _17766;
	                if ((_17758 & 1u) != 0u)
	                {
	                    _17766 = g_ScrambledHaltonPermutations.Load<uint>(_17759 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17766 = g_ScrambledHaltonPermutations.Load<uint>(_17759 * 4 + 0) & 65535u;
	                }
	                uint _20743 = 3167u + ((_12091 / 127u) % 127u);
	                uint _17770 = _20743 / 2u;
	                uint _17777;
	                if ((_20743 & 1u) != 0u)
	                {
	                    _17777 = g_ScrambledHaltonPermutations.Load<uint>(_17770 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17777 = g_ScrambledHaltonPermutations.Load<uint>(_17770 * 4 + 0) & 65535u;
	                }
	                uint _20744 = 3167u + ((_12091 / 16129u) % 127u);
	                uint _17779 = _20744 / 2u;
	                uint _17786;
	                if ((_20744 & 1u) != 0u)
	                {
	                    _17786 = g_ScrambledHaltonPermutations.Load<uint>(_17779 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17786 = g_ScrambledHaltonPermutations.Load<uint>(_17779 * 4 + 0) & 65535u;
	                }
	                uint _20745 = 3167u + ((_12091 / 2048383u) % 127u);
	                uint _17788 = _20745 / 2u;
	                uint _17795;
	                if ((_20745 & 1u) != 0u)
	                {
	                    _17795 = g_ScrambledHaltonPermutations.Load<uint>(_17788 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17795 = g_ScrambledHaltonPermutations.Load<uint>(_17788 * 4 + 0) & 65535u;
	                }
	                _19095 = float((((_17766 * 2048383u) + (_17777 * 16129u)) + (_17786 * 127u)) + _17795) * 3.8440148841800692025572061538696e-09f;
	                _19096 = true;
	                break;
	            }
	            case 31u:
	            {
	                uint _9249 = _12091 % 131u;
	                uint _17720 = (3294u + _9249) / 2u;
	                uint _17727;
	                if ((_9249 & 1u) != 0u)
	                {
	                    _17727 = g_ScrambledHaltonPermutations.Load<uint>(_17720 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17727 = g_ScrambledHaltonPermutations.Load<uint>(_17720 * 4 + 0) & 65535u;
	                }
	                uint _17730 = (_12091 / 131u) % 131u;
	                uint _17731 = (3294u + _17730) / 2u;
	                uint _17738;
	                if ((_17730 & 1u) != 0u)
	                {
	                    _17738 = g_ScrambledHaltonPermutations.Load<uint>(_17731 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17738 = g_ScrambledHaltonPermutations.Load<uint>(_17731 * 4 + 0) & 65535u;
	                }
	                uint _9254 = (_12091 / 17161u) % 131u;
	                uint _17740 = (3294u + _9254) / 2u;
	                uint _17747;
	                if ((_9254 & 1u) != 0u)
	                {
	                    _17747 = g_ScrambledHaltonPermutations.Load<uint>(_17740 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17747 = g_ScrambledHaltonPermutations.Load<uint>(_17740 * 4 + 0) & 65535u;
	                }
	                uint _9257 = (_12091 / 2248091u) % 131u;
	                uint _17749 = (3294u + _9257) / 2u;
	                uint _17756;
	                if ((_9257 & 1u) != 0u)
	                {
	                    _17756 = g_ScrambledHaltonPermutations.Load<uint>(_17749 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17756 = g_ScrambledHaltonPermutations.Load<uint>(_17749 * 4 + 0) & 65535u;
	                }
	                _19095 = float((((_17727 * 2248091u) + (_17738 * 17161u)) + (_17747 * 131u)) + _17756) * 3.3955860345713517745025455951691e-09f;
	                _19096 = true;
	                break;
	            }
	            case 32u:
	            {
	                uint _17680 = 3425u + (_12091 % 137u);
	                uint _17681 = _17680 / 2u;
	                uint _17688;
	                if ((_17680 & 1u) != 0u)
	                {
	                    _17688 = g_ScrambledHaltonPermutations.Load<uint>(_17681 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17688 = g_ScrambledHaltonPermutations.Load<uint>(_17681 * 4 + 0) & 65535u;
	                }
	                uint _20737 = 3425u + ((_12091 / 137u) % 137u);
	                uint _17692 = _20737 / 2u;
	                uint _17699;
	                if ((_20737 & 1u) != 0u)
	                {
	                    _17699 = g_ScrambledHaltonPermutations.Load<uint>(_17692 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17699 = g_ScrambledHaltonPermutations.Load<uint>(_17692 * 4 + 0) & 65535u;
	                }
	                uint _20738 = 3425u + ((_12091 / 18769u) % 137u);
	                uint _17701 = _20738 / 2u;
	                uint _17708;
	                if ((_20738 & 1u) != 0u)
	                {
	                    _17708 = g_ScrambledHaltonPermutations.Load<uint>(_17701 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17708 = g_ScrambledHaltonPermutations.Load<uint>(_17701 * 4 + 0) & 65535u;
	                }
	                uint _20739 = 3425u + ((_12091 / 2571353u) % 137u);
	                uint _17710 = _20739 / 2u;
	                uint _17717;
	                if ((_20739 & 1u) != 0u)
	                {
	                    _17717 = g_ScrambledHaltonPermutations.Load<uint>(_17710 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17717 = g_ScrambledHaltonPermutations.Load<uint>(_17710 * 4 + 0) & 65535u;
	                }
	                _19095 = float((((_17688 * 2571353u) + (_17699 * 18769u)) + (_17708 * 137u)) + _17717) * 2.8386881734121516274171881377697e-09f;
	                _19096 = true;
	                break;
	            }
	            case 33u:
	            {
	                uint _9225 = _12091 % 139u;
	                uint _17642 = (3562u + _9225) / 2u;
	                uint _17649;
	                if ((_9225 & 1u) != 0u)
	                {
	                    _17649 = g_ScrambledHaltonPermutations.Load<uint>(_17642 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17649 = g_ScrambledHaltonPermutations.Load<uint>(_17642 * 4 + 0) & 65535u;
	                }
	                uint _17652 = (_12091 / 139u) % 139u;
	                uint _17653 = (3562u + _17652) / 2u;
	                uint _17660;
	                if ((_17652 & 1u) != 0u)
	                {
	                    _17660 = g_ScrambledHaltonPermutations.Load<uint>(_17653 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17660 = g_ScrambledHaltonPermutations.Load<uint>(_17653 * 4 + 0) & 65535u;
	                }
	                uint _9230 = (_12091 / 19321u) % 139u;
	                uint _17662 = (3562u + _9230) / 2u;
	                uint _17669;
	                if ((_9230 & 1u) != 0u)
	                {
	                    _17669 = g_ScrambledHaltonPermutations.Load<uint>(_17662 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17669 = g_ScrambledHaltonPermutations.Load<uint>(_17662 * 4 + 0) & 65535u;
	                }
	                uint _9233 = (_12091 / 2685619u) % 139u;
	                uint _17671 = (3562u + _9233) / 2u;
	                uint _17678;
	                if ((_9233 & 1u) != 0u)
	                {
	                    _17678 = g_ScrambledHaltonPermutations.Load<uint>(_17671 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17678 = g_ScrambledHaltonPermutations.Load<uint>(_17671 * 4 + 0) & 65535u;
	                }
	                _19095 = float((((_17649 * 2685619u) + (_17660 * 19321u)) + (_17669 * 139u)) + _17678) * 2.6788027351898335837177000939846e-09f;
	                _19096 = true;
	                break;
	            }
	            case 34u:
	            {
	                uint _17602 = 3701u + (_12091 % 149u);
	                uint _17603 = _17602 / 2u;
	                uint _17610;
	                if ((_17602 & 1u) != 0u)
	                {
	                    _17610 = g_ScrambledHaltonPermutations.Load<uint>(_17603 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17610 = g_ScrambledHaltonPermutations.Load<uint>(_17603 * 4 + 0) & 65535u;
	                }
	                uint _20731 = 3701u + ((_12091 / 149u) % 149u);
	                uint _17614 = _20731 / 2u;
	                uint _17621;
	                if ((_20731 & 1u) != 0u)
	                {
	                    _17621 = g_ScrambledHaltonPermutations.Load<uint>(_17614 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17621 = g_ScrambledHaltonPermutations.Load<uint>(_17614 * 4 + 0) & 65535u;
	                }
	                uint _20732 = 3701u + ((_12091 / 22201u) % 149u);
	                uint _17623 = _20732 / 2u;
	                uint _17630;
	                if ((_20732 & 1u) != 0u)
	                {
	                    _17630 = g_ScrambledHaltonPermutations.Load<uint>(_17623 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17630 = g_ScrambledHaltonPermutations.Load<uint>(_17623 * 4 + 0) & 65535u;
	                }
	                uint _20733 = 3701u + ((_12091 / 3307949u) % 149u);
	                uint _17632 = _20733 / 2u;
	                uint _17639;
	                if ((_20733 & 1u) != 0u)
	                {
	                    _17639 = g_ScrambledHaltonPermutations.Load<uint>(_17632 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17639 = g_ScrambledHaltonPermutations.Load<uint>(_17632 * 4 + 0) & 65535u;
	                }
	                _19095 = float((((_17610 * 3307949u) + (_17621 * 22201u)) + (_17630 * 149u)) + _17639) * 2.0288730695483536692336201667786e-09f;
	                _19096 = true;
	                break;
	            }
	            case 35u:
	            {
	                uint _9201 = _12091 % 151u;
	                uint _17564 = (3850u + _9201) / 2u;
	                uint _17571;
	                if ((_9201 & 1u) != 0u)
	                {
	                    _17571 = g_ScrambledHaltonPermutations.Load<uint>(_17564 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17571 = g_ScrambledHaltonPermutations.Load<uint>(_17564 * 4 + 0) & 65535u;
	                }
	                uint _17574 = (_12091 / 151u) % 151u;
	                uint _17575 = (3850u + _17574) / 2u;
	                uint _17582;
	                if ((_17574 & 1u) != 0u)
	                {
	                    _17582 = g_ScrambledHaltonPermutations.Load<uint>(_17575 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17582 = g_ScrambledHaltonPermutations.Load<uint>(_17575 * 4 + 0) & 65535u;
	                }
	                uint _9206 = (_12091 / 22801u) % 151u;
	                uint _17584 = (3850u + _9206) / 2u;
	                uint _17591;
	                if ((_9206 & 1u) != 0u)
	                {
	                    _17591 = g_ScrambledHaltonPermutations.Load<uint>(_17584 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17591 = g_ScrambledHaltonPermutations.Load<uint>(_17584 * 4 + 0) & 65535u;
	                }
	                uint _9209 = (_12091 / 3442951u) % 151u;
	                uint _17593 = (3850u + _9209) / 2u;
	                uint _17600;
	                if ((_9209 & 1u) != 0u)
	                {
	                    _17600 = g_ScrambledHaltonPermutations.Load<uint>(_17593 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17600 = g_ScrambledHaltonPermutations.Load<uint>(_17593 * 4 + 0) & 65535u;
	                }
	                _19095 = float((((_17571 * 3442951u) + (_17582 * 22801u)) + (_17591 * 151u)) + _17600) * 1.9234998038797357367002405226231e-09f;
	                _19096 = true;
	                break;
	            }
	            case 36u:
	            {
	                uint _17524 = 4001u + (_12091 % 157u);
	                uint _17525 = _17524 / 2u;
	                uint _17532;
	                if ((_17524 & 1u) != 0u)
	                {
	                    _17532 = g_ScrambledHaltonPermutations.Load<uint>(_17525 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17532 = g_ScrambledHaltonPermutations.Load<uint>(_17525 * 4 + 0) & 65535u;
	                }
	                uint _20725 = 4001u + ((_12091 / 157u) % 157u);
	                uint _17536 = _20725 / 2u;
	                uint _17543;
	                if ((_20725 & 1u) != 0u)
	                {
	                    _17543 = g_ScrambledHaltonPermutations.Load<uint>(_17536 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17543 = g_ScrambledHaltonPermutations.Load<uint>(_17536 * 4 + 0) & 65535u;
	                }
	                uint _20726 = 4001u + ((_12091 / 24649u) % 157u);
	                uint _17545 = _20726 / 2u;
	                uint _17552;
	                if ((_20726 & 1u) != 0u)
	                {
	                    _17552 = g_ScrambledHaltonPermutations.Load<uint>(_17545 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17552 = g_ScrambledHaltonPermutations.Load<uint>(_17545 * 4 + 0) & 65535u;
	                }
	                uint _20727 = 4001u + ((_12091 / 3869893u) % 157u);
	                uint _17554 = _20727 / 2u;
	                uint _17561;
	                if ((_20727 & 1u) != 0u)
	                {
	                    _17561 = g_ScrambledHaltonPermutations.Load<uint>(_17554 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17561 = g_ScrambledHaltonPermutations.Load<uint>(_17554 * 4 + 0) & 65535u;
	                }
	                _19095 = float((((_17532 * 3869893u) + (_17543 * 24649u)) + (_17552 * 157u)) + _17561) * 1.6458920892858941442682407796383e-09f;
	                _19096 = true;
	                break;
	            }
	            case 37u:
	            {
	                uint _9176 = _12091 % 163u;
	                uint _17486 = (4158u + _9176) / 2u;
	                uint _17493;
	                if ((_9176 & 1u) != 0u)
	                {
	                    _17493 = g_ScrambledHaltonPermutations.Load<uint>(_17486 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17493 = g_ScrambledHaltonPermutations.Load<uint>(_17486 * 4 + 0) & 65535u;
	                }
	                uint _17496 = (_12091 / 163u) % 163u;
	                uint _17497 = (4158u + _17496) / 2u;
	                uint _17504;
	                if ((_17496 & 1u) != 0u)
	                {
	                    _17504 = g_ScrambledHaltonPermutations.Load<uint>(_17497 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17504 = g_ScrambledHaltonPermutations.Load<uint>(_17497 * 4 + 0) & 65535u;
	                }
	                uint _9181 = (_12091 / 26569u) % 163u;
	                uint _17506 = (4158u + _9181) / 2u;
	                uint _17513;
	                if ((_9181 & 1u) != 0u)
	                {
	                    _17513 = g_ScrambledHaltonPermutations.Load<uint>(_17506 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17513 = g_ScrambledHaltonPermutations.Load<uint>(_17506 * 4 + 0) & 65535u;
	                }
	                uint _9185 = (_12091 / 4330747u) % 163u;
	                uint _17515 = (4158u + _9185) / 2u;
	                uint _17522;
	                if ((_9185 & 1u) != 0u)
	                {
	                    _17522 = g_ScrambledHaltonPermutations.Load<uint>(_17515 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17522 = g_ScrambledHaltonPermutations.Load<uint>(_17515 * 4 + 0) & 65535u;
	                }
	                _19095 = float((((_17493 * 4330747u) + (_17504 * 26569u)) + (_17513 * 163u)) + _17522) * 1.4166074979726772653521038591862e-09f;
	                _19096 = true;
	                break;
	            }
	            case 38u:
	            {
	                uint _17446 = 4321u + (_12091 % 167u);
	                uint _17447 = _17446 / 2u;
	                uint _17454;
	                if ((_17446 & 1u) != 0u)
	                {
	                    _17454 = g_ScrambledHaltonPermutations.Load<uint>(_17447 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17454 = g_ScrambledHaltonPermutations.Load<uint>(_17447 * 4 + 0) & 65535u;
	                }
	                uint _20719 = 4321u + ((_12091 / 167u) % 167u);
	                uint _17458 = _20719 / 2u;
	                uint _17465;
	                if ((_20719 & 1u) != 0u)
	                {
	                    _17465 = g_ScrambledHaltonPermutations.Load<uint>(_17458 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17465 = g_ScrambledHaltonPermutations.Load<uint>(_17458 * 4 + 0) & 65535u;
	                }
	                uint _20720 = 4321u + ((_12091 / 27889u) % 167u);
	                uint _17467 = _20720 / 2u;
	                uint _17474;
	                if ((_20720 & 1u) != 0u)
	                {
	                    _17474 = g_ScrambledHaltonPermutations.Load<uint>(_17467 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17474 = g_ScrambledHaltonPermutations.Load<uint>(_17467 * 4 + 0) & 65535u;
	                }
	                uint _20721 = 4321u + ((_12091 / 4657463u) % 167u);
	                uint _17476 = _20721 / 2u;
	                uint _17483;
	                if ((_20721 & 1u) != 0u)
	                {
	                    _17483 = g_ScrambledHaltonPermutations.Load<uint>(_17476 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17483 = g_ScrambledHaltonPermutations.Load<uint>(_17476 * 4 + 0) & 65535u;
	                }
	                _19095 = float((((_17454 * 4657463u) + (_17465 * 27889u)) + (_17474 * 167u)) + _17483) * 1.2856834485930335176817607134581e-09f;
	                _19096 = true;
	                break;
	            }
	            case 39u:
	            {
	                uint _9152 = _12091 % 173u;
	                uint _17408 = (4488u + _9152) / 2u;
	                uint _17415;
	                if ((_9152 & 1u) != 0u)
	                {
	                    _17415 = g_ScrambledHaltonPermutations.Load<uint>(_17408 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17415 = g_ScrambledHaltonPermutations.Load<uint>(_17408 * 4 + 0) & 65535u;
	                }
	                uint _17418 = (_12091 / 173u) % 173u;
	                uint _17419 = (4488u + _17418) / 2u;
	                uint _17426;
	                if ((_17418 & 1u) != 0u)
	                {
	                    _17426 = g_ScrambledHaltonPermutations.Load<uint>(_17419 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17426 = g_ScrambledHaltonPermutations.Load<uint>(_17419 * 4 + 0) & 65535u;
	                }
	                uint _9157 = (_12091 / 29929u) % 173u;
	                uint _17428 = (4488u + _9157) / 2u;
	                uint _17435;
	                if ((_9157 & 1u) != 0u)
	                {
	                    _17435 = g_ScrambledHaltonPermutations.Load<uint>(_17428 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17435 = g_ScrambledHaltonPermutations.Load<uint>(_17428 * 4 + 0) & 65535u;
	                }
	                uint _9160 = (_12091 / 5177717u) % 173u;
	                uint _17437 = (4488u + _9160) / 2u;
	                uint _17444;
	                if ((_9160 & 1u) != 0u)
	                {
	                    _17444 = g_ScrambledHaltonPermutations.Load<uint>(_17437 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17444 = g_ScrambledHaltonPermutations.Load<uint>(_17437 * 4 + 0) & 65535u;
	                }
	                _19095 = float((((_17415 * 5177717u) + (_17426 * 29929u)) + (_17435 * 173u)) + _17444) * 1.1163889812593197348178364336491e-09f;
	                _19096 = true;
	                break;
	            }
	            case 40u:
	            {
	                uint _17368 = 4661u + (_12091 % 179u);
	                uint _17369 = _17368 / 2u;
	                uint _17376;
	                if ((_17368 & 1u) != 0u)
	                {
	                    _17376 = g_ScrambledHaltonPermutations.Load<uint>(_17369 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17376 = g_ScrambledHaltonPermutations.Load<uint>(_17369 * 4 + 0) & 65535u;
	                }
	                uint _20713 = 4661u + ((_12091 / 179u) % 179u);
	                uint _17380 = _20713 / 2u;
	                uint _17387;
	                if ((_20713 & 1u) != 0u)
	                {
	                    _17387 = g_ScrambledHaltonPermutations.Load<uint>(_17380 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17387 = g_ScrambledHaltonPermutations.Load<uint>(_17380 * 4 + 0) & 65535u;
	                }
	                uint _20714 = 4661u + ((_12091 / 32041u) % 179u);
	                uint _17389 = _20714 / 2u;
	                uint _17396;
	                if ((_20714 & 1u) != 0u)
	                {
	                    _17396 = g_ScrambledHaltonPermutations.Load<uint>(_17389 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17396 = g_ScrambledHaltonPermutations.Load<uint>(_17389 * 4 + 0) & 65535u;
	                }
	                uint _20715 = 4661u + ((_12091 / 5735339u) % 179u);
	                uint _17398 = _20715 / 2u;
	                uint _17405;
	                if ((_20715 & 1u) != 0u)
	                {
	                    _17405 = g_ScrambledHaltonPermutations.Load<uint>(_17398 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17405 = g_ScrambledHaltonPermutations.Load<uint>(_17398 * 4 + 0) & 65535u;
	                }
	                _19095 = float((((_17376 * 5735339u) + (_17387 * 32041u)) + (_17396 * 179u)) + _17405) * 9.7406471777361502972780726850033e-10f;
	                _19096 = true;
	                break;
	            }
	            case 41u:
	            {
	                uint _9128 = _12091 % 181u;
	                uint _17330 = (4840u + _9128) / 2u;
	                uint _17337;
	                if ((_9128 & 1u) != 0u)
	                {
	                    _17337 = g_ScrambledHaltonPermutations.Load<uint>(_17330 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17337 = g_ScrambledHaltonPermutations.Load<uint>(_17330 * 4 + 0) & 65535u;
	                }
	                uint _17340 = (_12091 / 181u) % 181u;
	                uint _17341 = (4840u + _17340) / 2u;
	                uint _17348;
	                if ((_17340 & 1u) != 0u)
	                {
	                    _17348 = g_ScrambledHaltonPermutations.Load<uint>(_17341 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17348 = g_ScrambledHaltonPermutations.Load<uint>(_17341 * 4 + 0) & 65535u;
	                }
	                uint _9133 = (_12091 / 32761u) % 181u;
	                uint _17350 = (4840u + _9133) / 2u;
	                uint _17357;
	                if ((_9133 & 1u) != 0u)
	                {
	                    _17357 = g_ScrambledHaltonPermutations.Load<uint>(_17350 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17357 = g_ScrambledHaltonPermutations.Load<uint>(_17350 * 4 + 0) & 65535u;
	                }
	                uint _9136 = (_12091 / 5929741u) % 181u;
	                uint _17359 = (4840u + _9136) / 2u;
	                uint _17366;
	                if ((_9136 & 1u) != 0u)
	                {
	                    _17366 = g_ScrambledHaltonPermutations.Load<uint>(_17359 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17366 = g_ScrambledHaltonPermutations.Load<uint>(_17359 * 4 + 0) & 65535u;
	                }
	                _19095 = float((((_17337 * 5929741u) + (_17348 * 32761u)) + (_17357 * 181u)) + _17366) * 9.3172047854750417172908782958984e-10f;
	                _19096 = true;
	                break;
	            }
	            case 42u:
	            {
	                uint _17290 = 5021u + (_12091 % 191u);
	                uint _17291 = _17290 / 2u;
	                uint _17298;
	                if ((_17290 & 1u) != 0u)
	                {
	                    _17298 = g_ScrambledHaltonPermutations.Load<uint>(_17291 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17298 = g_ScrambledHaltonPermutations.Load<uint>(_17291 * 4 + 0) & 65535u;
	                }
	                uint _20707 = 5021u + ((_12091 / 191u) % 191u);
	                uint _17302 = _20707 / 2u;
	                uint _17309;
	                if ((_20707 & 1u) != 0u)
	                {
	                    _17309 = g_ScrambledHaltonPermutations.Load<uint>(_17302 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17309 = g_ScrambledHaltonPermutations.Load<uint>(_17302 * 4 + 0) & 65535u;
	                }
	                uint _20708 = 5021u + ((_12091 / 36481u) % 191u);
	                uint _17311 = _20708 / 2u;
	                uint _17318;
	                if ((_20708 & 1u) != 0u)
	                {
	                    _17318 = g_ScrambledHaltonPermutations.Load<uint>(_17311 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17318 = g_ScrambledHaltonPermutations.Load<uint>(_17311 * 4 + 0) & 65535u;
	                }
	                uint _20709 = 5021u + ((_12091 / 6967871u) % 191u);
	                uint _17320 = _20709 / 2u;
	                uint _17327;
	                if ((_20709 & 1u) != 0u)
	                {
	                    _17327 = g_ScrambledHaltonPermutations.Load<uint>(_17320 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17327 = g_ScrambledHaltonPermutations.Load<uint>(_17320 * 4 + 0) & 65535u;
	                }
	                _19095 = float((((_17298 * 6967871u) + (_17309 * 36481u)) + (_17318 * 191u)) + _17327) * 7.5139183763894834555685520172119e-10f;
	                _19096 = true;
	                break;
	            }
	            case 43u:
	            {
	                uint _8233 = _12091 % 193u;
	                uint _17252 = (5212u + _8233) / 2u;
	                uint _17259;
	                if ((_8233 & 1u) != 0u)
	                {
	                    _17259 = g_ScrambledHaltonPermutations.Load<uint>(_17252 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17259 = g_ScrambledHaltonPermutations.Load<uint>(_17252 * 4 + 0) & 65535u;
	                }
	                uint _17262 = (_12091 / 193u) % 193u;
	                uint _17263 = (5212u + _17262) / 2u;
	                uint _17270;
	                if ((_17262 & 1u) != 0u)
	                {
	                    _17270 = g_ScrambledHaltonPermutations.Load<uint>(_17263 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17270 = g_ScrambledHaltonPermutations.Load<uint>(_17263 * 4 + 0) & 65535u;
	                }
	                uint _9111 = (_12091 / 37249u) % 193u;
	                uint _17272 = (5212u + _9111) / 2u;
	                uint _17279;
	                if ((_9111 & 1u) != 0u)
	                {
	                    _17279 = g_ScrambledHaltonPermutations.Load<uint>(_17272 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17279 = g_ScrambledHaltonPermutations.Load<uint>(_17272 * 4 + 0) & 65535u;
	                }
	                uint _9113 = (_12091 / 7189057u) % 193u;
	                uint _17281 = (5212u + _9113) / 2u;
	                uint _17288;
	                if ((_9113 & 1u) != 0u)
	                {
	                    _17288 = g_ScrambledHaltonPermutations.Load<uint>(_17281 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17288 = g_ScrambledHaltonPermutations.Load<uint>(_17281 * 4 + 0) & 65535u;
	                }
	                _19095 = float((((_17259 * 7189057u) + (_17270 * 37249u)) + (_17279 * 193u)) + _17288) * 7.2072686707613797807425726205111e-10f;
	                _19096 = true;
	                break;
	            }
	            case 44u:
	            {
	                uint _17211 = 5405u + (_12091 % 197u);
	                uint _17212 = _17211 / 2u;
	                uint _17219;
	                if ((_17211 & 1u) != 0u)
	                {
	                    _17219 = g_ScrambledHaltonPermutations.Load<uint>(_17212 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17219 = g_ScrambledHaltonPermutations.Load<uint>(_17212 * 4 + 0) & 65535u;
	                }
	                uint _20701 = 5405u + ((_12091 / 197u) % 197u);
	                uint _17223 = _20701 / 2u;
	                uint _17230;
	                if ((_20701 & 1u) != 0u)
	                {
	                    _17230 = g_ScrambledHaltonPermutations.Load<uint>(_17223 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17230 = g_ScrambledHaltonPermutations.Load<uint>(_17223 * 4 + 0) & 65535u;
	                }
	                uint _20702 = 5405u + ((_12091 / 38809u) % 197u);
	                uint _17232 = _20702 / 2u;
	                uint _17239;
	                if ((_20702 & 1u) != 0u)
	                {
	                    _17239 = g_ScrambledHaltonPermutations.Load<uint>(_17232 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17239 = g_ScrambledHaltonPermutations.Load<uint>(_17232 * 4 + 0) & 65535u;
	                }
	                uint _20703 = 5405u + ((_12091 / 7645373u) % 197u);
	                uint _17241 = _20703 / 2u;
	                uint _17248;
	                if ((_20703 & 1u) != 0u)
	                {
	                    _17248 = g_ScrambledHaltonPermutations.Load<uint>(_17241 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17248 = g_ScrambledHaltonPermutations.Load<uint>(_17241 * 4 + 0) & 65535u;
	                }
	                _19095 = float((((_17219 * 7645373u) + (_17230 * 38809u)) + (_17239 * 197u)) + _17248) * 6.6394950648529516001872252672911e-10f;
	                _19096 = true;
	                break;
	            }
	            case 45u:
	            {
	                uint _8221 = _12091 % 199u;
	                uint _17173 = (5602u + _8221) / 2u;
	                uint _17180;
	                if ((_8221 & 1u) != 0u)
	                {
	                    _17180 = g_ScrambledHaltonPermutations.Load<uint>(_17173 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17180 = g_ScrambledHaltonPermutations.Load<uint>(_17173 * 4 + 0) & 65535u;
	                }
	                uint _17183 = (_12091 / 199u) % 199u;
	                uint _17184 = (5602u + _17183) / 2u;
	                uint _17191;
	                if ((_17183 & 1u) != 0u)
	                {
	                    _17191 = g_ScrambledHaltonPermutations.Load<uint>(_17184 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17191 = g_ScrambledHaltonPermutations.Load<uint>(_17184 * 4 + 0) & 65535u;
	                }
	                uint _9099 = (_12091 / 39601u) % 199u;
	                uint _17193 = (5602u + _9099) / 2u;
	                uint _17200;
	                if ((_9099 & 1u) != 0u)
	                {
	                    _17200 = g_ScrambledHaltonPermutations.Load<uint>(_17193 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17200 = g_ScrambledHaltonPermutations.Load<uint>(_17193 * 4 + 0) & 65535u;
	                }
	                uint _9101 = (_12091 / 7880599u) % 199u;
	                uint _17202 = (5602u + _9101) / 2u;
	                uint _17209;
	                if ((_9101 & 1u) != 0u)
	                {
	                    _17209 = g_ScrambledHaltonPermutations.Load<uint>(_17202 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17209 = g_ScrambledHaltonPermutations.Load<uint>(_17202 * 4 + 0) & 65535u;
	                }
	                _19095 = float((((_17180 * 7880599u) + (_17191 * 39601u)) + (_17200 * 199u)) + _17209) * 6.3765775992763451540668029338121e-10f;
	                _19096 = true;
	                break;
	            }
	            case 46u:
	            {
	                uint _17133 = 5801u + (_12091 % 211u);
	                uint _17134 = _17133 / 2u;
	                uint _17141;
	                if ((_17133 & 1u) != 0u)
	                {
	                    _17141 = g_ScrambledHaltonPermutations.Load<uint>(_17134 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17141 = g_ScrambledHaltonPermutations.Load<uint>(_17134 * 4 + 0) & 65535u;
	                }
	                uint _20695 = 5801u + ((_12091 / 211u) % 211u);
	                uint _17145 = _20695 / 2u;
	                uint _17152;
	                if ((_20695 & 1u) != 0u)
	                {
	                    _17152 = g_ScrambledHaltonPermutations.Load<uint>(_17145 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17152 = g_ScrambledHaltonPermutations.Load<uint>(_17145 * 4 + 0) & 65535u;
	                }
	                uint _20696 = 5801u + ((_12091 / 44521u) % 211u);
	                uint _17154 = _20696 / 2u;
	                uint _17161;
	                if ((_20696 & 1u) != 0u)
	                {
	                    _17161 = g_ScrambledHaltonPermutations.Load<uint>(_17154 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17161 = g_ScrambledHaltonPermutations.Load<uint>(_17154 * 4 + 0) & 65535u;
	                }
	                uint _20697 = 5801u + ((_12091 / 9393931u) % 211u);
	                uint _17163 = _20697 / 2u;
	                uint _17170;
	                if ((_20697 & 1u) != 0u)
	                {
	                    _17170 = g_ScrambledHaltonPermutations.Load<uint>(_17163 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17170 = g_ScrambledHaltonPermutations.Load<uint>(_17163 * 4 + 0) & 65535u;
	                }
	                _19095 = float((((_17141 * 9393931u) + (_17152 * 44521u)) + (_17161 * 211u)) + _17170) * 5.0451043343002766050631180405617e-10f;
	                _19096 = true;
	                break;
	            }
	            case 47u:
	            {
	                uint _8209 = _12091 % 223u;
	                uint _17095 = (6012u + _8209) / 2u;
	                uint _17102;
	                if ((_8209 & 1u) != 0u)
	                {
	                    _17102 = g_ScrambledHaltonPermutations.Load<uint>(_17095 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17102 = g_ScrambledHaltonPermutations.Load<uint>(_17095 * 4 + 0) & 65535u;
	                }
	                uint _17105 = (_12091 / 223u) % 223u;
	                uint _17106 = (6012u + _17105) / 2u;
	                uint _17113;
	                if ((_17105 & 1u) != 0u)
	                {
	                    _17113 = g_ScrambledHaltonPermutations.Load<uint>(_17106 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17113 = g_ScrambledHaltonPermutations.Load<uint>(_17106 * 4 + 0) & 65535u;
	                }
	                uint _9087 = (_12091 / 49729u) % 223u;
	                uint _17115 = (6012u + _9087) / 2u;
	                uint _17122;
	                if ((_9087 & 1u) != 0u)
	                {
	                    _17122 = g_ScrambledHaltonPermutations.Load<uint>(_17115 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17122 = g_ScrambledHaltonPermutations.Load<uint>(_17115 * 4 + 0) & 65535u;
	                }
	                uint _9089 = (_12091 / 11089567u) % 223u;
	                uint _17124 = (6012u + _9089) / 2u;
	                uint _17131;
	                if ((_9089 & 1u) != 0u)
	                {
	                    _17131 = g_ScrambledHaltonPermutations.Load<uint>(_17124 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17131 = g_ScrambledHaltonPermutations.Load<uint>(_17124 * 4 + 0) & 65535u;
	                }
	                _19095 = float((((_17102 * 11089567u) + (_17113 * 49729u)) + (_17122 * 223u)) + _17131) * 4.0437145298888310662732692435384e-10f;
	                _19096 = true;
	                break;
	            }
	            case 48u:
	            {
	                uint _17055 = 6235u + (_12091 % 227u);
	                uint _17056 = _17055 / 2u;
	                uint _17063;
	                if ((_17055 & 1u) != 0u)
	                {
	                    _17063 = g_ScrambledHaltonPermutations.Load<uint>(_17056 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17063 = g_ScrambledHaltonPermutations.Load<uint>(_17056 * 4 + 0) & 65535u;
	                }
	                uint _20689 = 6235u + ((_12091 / 227u) % 227u);
	                uint _17067 = _20689 / 2u;
	                uint _17074;
	                if ((_20689 & 1u) != 0u)
	                {
	                    _17074 = g_ScrambledHaltonPermutations.Load<uint>(_17067 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17074 = g_ScrambledHaltonPermutations.Load<uint>(_17067 * 4 + 0) & 65535u;
	                }
	                uint _20690 = 6235u + ((_12091 / 51529u) % 227u);
	                uint _17076 = _20690 / 2u;
	                uint _17083;
	                if ((_20690 & 1u) != 0u)
	                {
	                    _17083 = g_ScrambledHaltonPermutations.Load<uint>(_17076 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17083 = g_ScrambledHaltonPermutations.Load<uint>(_17076 * 4 + 0) & 65535u;
	                }
	                uint _20691 = 6235u + ((_12091 / 11697083u) % 227u);
	                uint _17085 = _20691 / 2u;
	                uint _17092;
	                if ((_20691 & 1u) != 0u)
	                {
	                    _17092 = g_ScrambledHaltonPermutations.Load<uint>(_17085 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17092 = g_ScrambledHaltonPermutations.Load<uint>(_17085 * 4 + 0) & 65535u;
	                }
	                _19095 = float((((_17063 * 11697083u) + (_17074 * 51529u)) + (_17083 * 227u)) + _17092) * 3.7661404550526356160844443365932e-10f;
	                _19096 = true;
	                break;
	            }
	            case 49u:
	            {
	                uint _8197 = _12091 % 229u;
	                uint _17016 = (6462u + _8197) / 2u;
	                uint _17024;
	                if ((_8197 & 1u) != 0u)
	                {
	                    _17024 = g_ScrambledHaltonPermutations.Load<uint>(_17016 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17024 = g_ScrambledHaltonPermutations.Load<uint>(_17016 * 4 + 0) & 65535u;
	                }
	                uint _17027 = (_12091 / 229u) % 229u;
	                uint _17028 = (6462u + _17027) / 2u;
	                uint _17035;
	                if ((_17027 & 1u) != 0u)
	                {
	                    _17035 = g_ScrambledHaltonPermutations.Load<uint>(_17028 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17035 = g_ScrambledHaltonPermutations.Load<uint>(_17028 * 4 + 0) & 65535u;
	                }
	                uint _9075 = (_12091 / 52441u) % 229u;
	                uint _17037 = (6462u + _9075) / 2u;
	                uint _17044;
	                if ((_9075 & 1u) != 0u)
	                {
	                    _17044 = g_ScrambledHaltonPermutations.Load<uint>(_17037 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17044 = g_ScrambledHaltonPermutations.Load<uint>(_17037 * 4 + 0) & 65535u;
	                }
	                uint _9077 = (_12091 / 12008989u) % 229u;
	                uint _17046 = (6462u + _9077) / 2u;
	                uint _17053;
	                if ((_9077 & 1u) != 0u)
	                {
	                    _17053 = g_ScrambledHaltonPermutations.Load<uint>(_17046 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17053 = g_ScrambledHaltonPermutations.Load<uint>(_17046 * 4 + 0) & 65535u;
	                }
	                _19095 = float((((_17024 * 12008989u) + (_17035 * 52441u)) + (_17044 * 229u)) + _17053) * 3.6362857169791595879360102117062e-10f;
	                _19096 = true;
	                break;
	            }
	            case 50u:
	            {
	                uint _16356 = 6691u + (_12091 % 233u);
	                uint _17009 = _16356 / 2u;
	                uint _16363;
	                if ((_16356 & 1u) != 0u)
	                {
	                    _16363 = g_ScrambledHaltonPermutations.Load<uint>(_17009 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _16363 = g_ScrambledHaltonPermutations.Load<uint>(_17009 * 4 + 0) & 65535u;
	                }
	                uint _20683 = 6691u + ((_12091 / 233u) % 233u);
	                uint _17010 = _20683 / 2u;
	                uint _16373;
	                if ((_20683 & 1u) != 0u)
	                {
	                    _16373 = g_ScrambledHaltonPermutations.Load<uint>(_17010 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _16373 = g_ScrambledHaltonPermutations.Load<uint>(_17010 * 4 + 0) & 65535u;
	                }
	                uint _20684 = 6691u + ((_12091 / 54289u) % 233u);
	                uint _17011 = _20684 / 2u;
	                uint _16381;
	                if ((_20684 & 1u) != 0u)
	                {
	                    _16381 = g_ScrambledHaltonPermutations.Load<uint>(_17011 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _16381 = g_ScrambledHaltonPermutations.Load<uint>(_17011 * 4 + 0) & 65535u;
	                }
	                uint _20685 = 6691u + ((_12091 / 12649337u) % 233u);
	                uint _17012 = _20685 / 2u;
	                uint _17013;
	                if ((_20685 & 1u) != 0u)
	                {
	                    _17013 = g_ScrambledHaltonPermutations.Load<uint>(_17012 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _17013 = g_ScrambledHaltonPermutations.Load<uint>(_17012 * 4 + 0) & 65535u;
	                }
	                _19095 = float((((_16363 * 12649337u) + (_16373 * 54289u)) + (_16381 * 233u)) + _17013) * 3.3929406506594261827558511868119e-10f;
	                _19096 = true;
	                break;
	            }
	            case 51u:
	            {
	                uint _8185 = _12091 % 239u;
	                uint _17005 = (6924u + _8185) / 2u;
	                uint _16328;
	                if ((_8185 & 1u) != 0u)
	                {
	                    _16328 = g_ScrambledHaltonPermutations.Load<uint>(_17005 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _16328 = g_ScrambledHaltonPermutations.Load<uint>(_17005 * 4 + 0) & 65535u;
	                }
	                uint _16331 = (_12091 / 239u) % 239u;
	                uint _17006 = (6924u + _16331) / 2u;
	                uint _16338;
	                if ((_16331 & 1u) != 0u)
	                {
	                    _16338 = g_ScrambledHaltonPermutations.Load<uint>(_17006 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _16338 = g_ScrambledHaltonPermutations.Load<uint>(_17006 * 4 + 0) & 65535u;
	                }
	                uint _9063 = (_12091 / 57121u) % 239u;
	                uint _17007 = (6924u + _9063) / 2u;
	                uint _16346;
	                if ((_9063 & 1u) != 0u)
	                {
	                    _16346 = g_ScrambledHaltonPermutations.Load<uint>(_17007 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _16346 = g_ScrambledHaltonPermutations.Load<uint>(_17007 * 4 + 0) & 65535u;
	                }
	                uint _9065 = (_12091 / 13651919u) % 239u;
	                uint _17008 = (6924u + _9065) / 2u;
	                uint _16354;
	                if ((_9065 & 1u) != 0u)
	                {
	                    _16354 = g_ScrambledHaltonPermutations.Load<uint>(_17008 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _16354 = g_ScrambledHaltonPermutations.Load<uint>(_17008 * 4 + 0) & 65535u;
	                }
	                _19095 = float((((_16328 * 13651919u) + (_16338 * 57121u)) + (_16346 * 239u)) + _16354) * 3.0648439341973698901711031794548e-10f;
	                _19096 = true;
	                break;
	            }
	            case 52u:
	            {
	                uint _16284 = 7163u + (_12091 % 241u);
	                uint _17001 = _16284 / 2u;
	                uint _16291;
	                if ((_16284 & 1u) != 0u)
	                {
	                    _16291 = g_ScrambledHaltonPermutations.Load<uint>(_17001 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _16291 = g_ScrambledHaltonPermutations.Load<uint>(_17001 * 4 + 0) & 65535u;
	                }
	                uint _20677 = 7163u + ((_12091 / 241u) % 241u);
	                uint _17002 = _20677 / 2u;
	                uint _16301;
	                if ((_20677 & 1u) != 0u)
	                {
	                    _16301 = g_ScrambledHaltonPermutations.Load<uint>(_17002 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _16301 = g_ScrambledHaltonPermutations.Load<uint>(_17002 * 4 + 0) & 65535u;
	                }
	                uint _20678 = 7163u + ((_12091 / 58081u) % 241u);
	                uint _17003 = _20678 / 2u;
	                uint _16310;
	                if ((_20678 & 1u) != 0u)
	                {
	                    _16310 = g_ScrambledHaltonPermutations.Load<uint>(_17003 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _16310 = g_ScrambledHaltonPermutations.Load<uint>(_17003 * 4 + 0) & 65535u;
	                }
	                uint _20679 = 7163u + ((_12091 / 13997521u) % 241u);
	                uint _17004 = _20679 / 2u;
	                uint _16318;
	                if ((_20679 & 1u) != 0u)
	                {
	                    _16318 = g_ScrambledHaltonPermutations.Load<uint>(_17004 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _16318 = g_ScrambledHaltonPermutations.Load<uint>(_17004 * 4 + 0) & 65535u;
	                }
	                _19095 = float((((_16291 * 13997521u) + (_16301 * 58081u)) + (_16310 * 241u)) + _16318) * 2.9643656973554755040822783485055e-10f;
	                _19096 = true;
	                break;
	            }
	            case 53u:
	            {
	                uint _7365 = _12091 % 251u;
	                uint _16997 = (7404u + _7365) / 2u;
	                uint _16256;
	                if ((_7365 & 1u) != 0u)
	                {
	                    _16256 = g_ScrambledHaltonPermutations.Load<uint>(_16997 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _16256 = g_ScrambledHaltonPermutations.Load<uint>(_16997 * 4 + 0) & 65535u;
	                }
	                uint _16259 = (_12091 / 251u) % 251u;
	                uint _16998 = (7404u + _16259) / 2u;
	                uint _16266;
	                if ((_16259 & 1u) != 0u)
	                {
	                    _16266 = g_ScrambledHaltonPermutations.Load<uint>(_16998 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _16266 = g_ScrambledHaltonPermutations.Load<uint>(_16998 * 4 + 0) & 65535u;
	                }
	                uint _9050 = (_12091 / 63001u) % 251u;
	                uint _16999 = (7404u + _9050) / 2u;
	                uint _16274;
	                if ((_9050 & 1u) != 0u)
	                {
	                    _16274 = g_ScrambledHaltonPermutations.Load<uint>(_16999 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _16274 = g_ScrambledHaltonPermutations.Load<uint>(_16999 * 4 + 0) & 65535u;
	                }
	                uint _9052 = (_12091 / 15813251u) % 251u;
	                uint _17000 = (7404u + _9052) / 2u;
	                uint _16282;
	                if ((_9052 & 1u) != 0u)
	                {
	                    _16282 = g_ScrambledHaltonPermutations.Load<uint>(_17000 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _16282 = g_ScrambledHaltonPermutations.Load<uint>(_17000 * 4 + 0) & 65535u;
	                }
	                _19095 = float((((_16256 * 15813251u) + (_16266 * 63001u)) + (_16274 * 251u)) + _16282) * 2.5194460406829932708205888047814e-10f;
	                _19096 = true;
	                break;
	            }
	            case 54u:
	            {
	                uint _16224 = 7655u + (_12091 % 257u);
	                uint _16994 = _16224 / 2u;
	                uint _16230;
	                if ((_16224 & 1u) != 0u)
	                {
	                    _16230 = g_ScrambledHaltonPermutations.Load<uint>(_16994 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _16230 = g_ScrambledHaltonPermutations.Load<uint>(_16994 * 4 + 0) & 65535u;
	                }
	                uint _20672 = 7655u + ((_12091 / 257u) % 257u);
	                uint _16995 = _20672 / 2u;
	                uint _16239;
	                if ((_20672 & 1u) != 0u)
	                {
	                    _16239 = g_ScrambledHaltonPermutations.Load<uint>(_16995 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _16239 = g_ScrambledHaltonPermutations.Load<uint>(_16995 * 4 + 0) & 65535u;
	                }
	                uint _20673 = 7655u + ((_12091 / 66049u) % 257u);
	                uint _16996 = _20673 / 2u;
	                uint _16247;
	                if ((_20673 & 1u) != 0u)
	                {
	                    _16247 = g_ScrambledHaltonPermutations.Load<uint>(_16996 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _16247 = g_ScrambledHaltonPermutations.Load<uint>(_16996 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_16230 * 66049u) + (_16239 * 257u)) + _16247) * 5.891157073278918687719851732254e-08f;
	                _19096 = true;
	                break;
	            }
	            case 55u:
	            {
	                uint _7363 = _12091 % 263u;
	                uint _16991 = (7912u + _7363) / 2u;
	                uint _16206;
	                if ((_7363 & 1u) != 0u)
	                {
	                    _16206 = g_ScrambledHaltonPermutations.Load<uint>(_16991 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _16206 = g_ScrambledHaltonPermutations.Load<uint>(_16991 * 4 + 0) & 65535u;
	                }
	                uint _16209 = (_12091 / 263u) % 263u;
	                uint _16992 = (7912u + _16209) / 2u;
	                uint _16215;
	                if ((_16209 & 1u) != 0u)
	                {
	                    _16215 = g_ScrambledHaltonPermutations.Load<uint>(_16992 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _16215 = g_ScrambledHaltonPermutations.Load<uint>(_16992 * 4 + 0) & 65535u;
	                }
	                uint _9042 = (_12091 / 69169u) % 263u;
	                uint _16993 = (7912u + _9042) / 2u;
	                uint _16222;
	                if ((_9042 & 1u) != 0u)
	                {
	                    _16222 = g_ScrambledHaltonPermutations.Load<uint>(_16993 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _16222 = g_ScrambledHaltonPermutations.Load<uint>(_16993 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_16206 * 69169u) + (_16215 * 263u)) + _16222) * 5.4970879403981598443351686000824e-08f;
	                _19096 = true;
	                break;
	            }
	            case 56u:
	            {
	                uint _16179 = 8175u + (_12091 % 269u);
	                uint _16988 = _16179 / 2u;
	                uint _16182;
	                if ((_16179 & 1u) != 0u)
	                {
	                    _16182 = g_ScrambledHaltonPermutations.Load<uint>(_16988 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _16182 = g_ScrambledHaltonPermutations.Load<uint>(_16988 * 4 + 0) & 65535u;
	                }
	                uint _20668 = 8175u + ((_12091 / 269u) % 269u);
	                uint _16989 = _20668 / 2u;
	                uint _16191;
	                if ((_20668 & 1u) != 0u)
	                {
	                    _16191 = g_ScrambledHaltonPermutations.Load<uint>(_16989 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _16191 = g_ScrambledHaltonPermutations.Load<uint>(_16989 * 4 + 0) & 65535u;
	                }
	                uint _20669 = 8175u + ((_12091 / 72361u) % 269u);
	                uint _16990 = _20669 / 2u;
	                uint _16198;
	                if ((_20669 & 1u) != 0u)
	                {
	                    _16198 = g_ScrambledHaltonPermutations.Load<uint>(_16990 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _16198 = g_ScrambledHaltonPermutations.Load<uint>(_16990 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_16182 * 72361u) + (_16191 * 269u)) + _16198) * 5.137396996701681928243488073349e-08f;
	                _19096 = true;
	                break;
	            }
	            case 57u:
	            {
	                uint _7361 = _12091 % 271u;
	                uint _16985 = (8444u + _7361) / 2u;
	                uint _15364;
	                if ((_7361 & 1u) != 0u)
	                {
	                    _15364 = g_ScrambledHaltonPermutations.Load<uint>(_16985 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _15364 = g_ScrambledHaltonPermutations.Load<uint>(_16985 * 4 + 0) & 65535u;
	                }
	                uint _15367 = (_12091 / 271u) % 271u;
	                uint _16986 = (8444u + _15367) / 2u;
	                uint _15372;
	                if ((_15367 & 1u) != 0u)
	                {
	                    _15372 = g_ScrambledHaltonPermutations.Load<uint>(_16986 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _15372 = g_ScrambledHaltonPermutations.Load<uint>(_16986 * 4 + 0) & 65535u;
	                }
	                uint _9034 = (_12091 / 73441u) % 271u;
	                uint _16987 = (8444u + _9034) / 2u;
	                uint _15378;
	                if ((_9034 & 1u) != 0u)
	                {
	                    _15378 = g_ScrambledHaltonPermutations.Load<uint>(_16987 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _15378 = g_ScrambledHaltonPermutations.Load<uint>(_16987 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_15364 * 73441u) + (_15372 * 271u)) + _15378) * 5.0244906901752983685582876205444e-08f;
	                _19096 = true;
	                break;
	            }
	            case 58u:
	            {
	                uint _16171 = 8715u + (_12091 % 277u);
	                uint _16982 = _16171 / 2u;
	                uint _15344;
	                if ((_16171 & 1u) != 0u)
	                {
	                    _15344 = g_ScrambledHaltonPermutations.Load<uint>(_16982 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _15344 = g_ScrambledHaltonPermutations.Load<uint>(_16982 * 4 + 0) & 65535u;
	                }
	                uint _20664 = 8715u + ((_12091 / 277u) % 277u);
	                uint _16983 = _20664 / 2u;
	                uint _15352;
	                if ((_20664 & 1u) != 0u)
	                {
	                    _15352 = g_ScrambledHaltonPermutations.Load<uint>(_16983 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _15352 = g_ScrambledHaltonPermutations.Load<uint>(_16983 * 4 + 0) & 65535u;
	                }
	                uint _20665 = 8715u + ((_12091 / 76729u) % 277u);
	                uint _16984 = _20665 / 2u;
	                uint _15358;
	                if ((_20665 & 1u) != 0u)
	                {
	                    _15358 = g_ScrambledHaltonPermutations.Load<uint>(_16984 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _15358 = g_ScrambledHaltonPermutations.Load<uint>(_16984 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_15344 * 76729u) + (_15352 * 277u)) + _15358) * 4.705011136252323922235518693924e-08f;
	                _19096 = true;
	                break;
	            }
	            case 59u:
	            {
	                uint _7359 = _12091 % 281u;
	                uint _16979 = (8992u + _7359) / 2u;
	                uint _15324;
	                if ((_7359 & 1u) != 0u)
	                {
	                    _15324 = g_ScrambledHaltonPermutations.Load<uint>(_16979 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _15324 = g_ScrambledHaltonPermutations.Load<uint>(_16979 * 4 + 0) & 65535u;
	                }
	                uint _15327 = (_12091 / 281u) % 281u;
	                uint _16980 = (8992u + _15327) / 2u;
	                uint _15332;
	                if ((_15327 & 1u) != 0u)
	                {
	                    _15332 = g_ScrambledHaltonPermutations.Load<uint>(_16980 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _15332 = g_ScrambledHaltonPermutations.Load<uint>(_16980 * 4 + 0) & 65535u;
	                }
	                uint _9026 = (_12091 / 78961u) % 281u;
	                uint _16981 = (8992u + _9026) / 2u;
	                uint _15338;
	                if ((_9026 & 1u) != 0u)
	                {
	                    _15338 = g_ScrambledHaltonPermutations.Load<uint>(_16981 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _15338 = g_ScrambledHaltonPermutations.Load<uint>(_16981 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_15324 * 78961u) + (_15332 * 281u)) + _15338) * 4.5069320719903771532699465751648e-08f;
	                _19096 = true;
	                break;
	            }
	            case 60u:
	            {
	                uint _16163 = 9273u + (_12091 % 283u);
	                uint _16976 = _16163 / 2u;
	                uint _15304;
	                if ((_16163 & 1u) != 0u)
	                {
	                    _15304 = g_ScrambledHaltonPermutations.Load<uint>(_16976 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _15304 = g_ScrambledHaltonPermutations.Load<uint>(_16976 * 4 + 0) & 65535u;
	                }
	                uint _20660 = 9273u + ((_12091 / 283u) % 283u);
	                uint _16977 = _20660 / 2u;
	                uint _15312;
	                if ((_20660 & 1u) != 0u)
	                {
	                    _15312 = g_ScrambledHaltonPermutations.Load<uint>(_16977 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _15312 = g_ScrambledHaltonPermutations.Load<uint>(_16977 * 4 + 0) & 65535u;
	                }
	                uint _20661 = 9273u + ((_12091 / 80089u) % 283u);
	                uint _16978 = _20661 / 2u;
	                uint _15318;
	                if ((_20661 & 1u) != 0u)
	                {
	                    _15318 = g_ScrambledHaltonPermutations.Load<uint>(_16978 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _15318 = g_ScrambledHaltonPermutations.Load<uint>(_16978 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_15304 * 80089u) + (_15312 * 283u)) + _15318) * 4.4120518793988594552502036094666e-08f;
	                _19096 = true;
	                break;
	            }
	            case 61u:
	            {
	                uint _7357 = _12091 % 293u;
	                uint _16973 = (9556u + _7357) / 2u;
	                uint _15284;
	                if ((_7357 & 1u) != 0u)
	                {
	                    _15284 = g_ScrambledHaltonPermutations.Load<uint>(_16973 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _15284 = g_ScrambledHaltonPermutations.Load<uint>(_16973 * 4 + 0) & 65535u;
	                }
	                uint _15287 = (_12091 / 293u) % 293u;
	                uint _16974 = (9556u + _15287) / 2u;
	                uint _15292;
	                if ((_15287 & 1u) != 0u)
	                {
	                    _15292 = g_ScrambledHaltonPermutations.Load<uint>(_16974 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _15292 = g_ScrambledHaltonPermutations.Load<uint>(_16974 * 4 + 0) & 65535u;
	                }
	                uint _9018 = (_12091 / 85849u) % 293u;
	                uint _16975 = (9556u + _9018) / 2u;
	                uint _15298;
	                if ((_9018 & 1u) != 0u)
	                {
	                    _15298 = g_ScrambledHaltonPermutations.Load<uint>(_16975 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _15298 = g_ScrambledHaltonPermutations.Load<uint>(_16975 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_15284 * 85849u) + (_15292 * 293u)) + _15298) * 3.975548779067139548715204000473e-08f;
	                _19096 = true;
	                break;
	            }
	            case 62u:
	            {
	                uint _16155 = 9849u + (_12091 % 307u);
	                uint _16970 = _16155 / 2u;
	                uint _15263;
	                if ((_16155 & 1u) != 0u)
	                {
	                    _15263 = g_ScrambledHaltonPermutations.Load<uint>(_16970 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _15263 = g_ScrambledHaltonPermutations.Load<uint>(_16970 * 4 + 0) & 65535u;
	                }
	                uint _20656 = 9849u + ((_12091 / 307u) % 307u);
	                uint _16971 = _20656 / 2u;
	                uint _15271;
	                if ((_20656 & 1u) != 0u)
	                {
	                    _15271 = g_ScrambledHaltonPermutations.Load<uint>(_16971 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _15271 = g_ScrambledHaltonPermutations.Load<uint>(_16971 * 4 + 0) & 65535u;
	                }
	                uint _20657 = 9849u + ((_12091 / 94249u) % 307u);
	                uint _16972 = _20657 / 2u;
	                uint _15278;
	                if ((_20657 & 1u) != 0u)
	                {
	                    _15278 = g_ScrambledHaltonPermutations.Load<uint>(_16972 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _15278 = g_ScrambledHaltonPermutations.Load<uint>(_16972 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_15263 * 94249u) + (_15271 * 307u)) + _15278) * 3.4560880379785885452292859554291e-08f;
	                _19096 = true;
	                break;
	            }
	            case 63u:
	            {
	                uint _7355 = _12091 % 311u;
	                uint _16967 = (10156u + _7355) / 2u;
	                uint _15243;
	                if ((_7355 & 1u) != 0u)
	                {
	                    _15243 = g_ScrambledHaltonPermutations.Load<uint>(_16967 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _15243 = g_ScrambledHaltonPermutations.Load<uint>(_16967 * 4 + 0) & 65535u;
	                }
	                uint _15246 = (_12091 / 311u) % 311u;
	                uint _16968 = (10156u + _15246) / 2u;
	                uint _15251;
	                if ((_15246 & 1u) != 0u)
	                {
	                    _15251 = g_ScrambledHaltonPermutations.Load<uint>(_16968 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _15251 = g_ScrambledHaltonPermutations.Load<uint>(_16968 * 4 + 0) & 65535u;
	                }
	                uint _9010 = (_12091 / 96721u) % 311u;
	                uint _16969 = (10156u + _9010) / 2u;
	                uint _15257;
	                if ((_9010 & 1u) != 0u)
	                {
	                    _15257 = g_ScrambledHaltonPermutations.Load<uint>(_16969 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _15257 = g_ScrambledHaltonPermutations.Load<uint>(_16969 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_15243 * 96721u) + (_15251 * 311u)) + _15257) * 3.3244418773392681032419204711914e-08f;
	                _19096 = true;
	                break;
	            }
	            case 64u:
	            {
	                uint _16147 = 10467u + (_12091 % 313u);
	                uint _16964 = _16147 / 2u;
	                uint _15223;
	                if ((_16147 & 1u) != 0u)
	                {
	                    _15223 = g_ScrambledHaltonPermutations.Load<uint>(_16964 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _15223 = g_ScrambledHaltonPermutations.Load<uint>(_16964 * 4 + 0) & 65535u;
	                }
	                uint _20652 = 10467u + ((_12091 / 313u) % 313u);
	                uint _16965 = _20652 / 2u;
	                uint _15231;
	                if ((_20652 & 1u) != 0u)
	                {
	                    _15231 = g_ScrambledHaltonPermutations.Load<uint>(_16965 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _15231 = g_ScrambledHaltonPermutations.Load<uint>(_16965 * 4 + 0) & 65535u;
	                }
	                uint _20653 = 10467u + ((_12091 / 97969u) % 313u);
	                uint _16966 = _20653 / 2u;
	                uint _15237;
	                if ((_20653 & 1u) != 0u)
	                {
	                    _15237 = g_ScrambledHaltonPermutations.Load<uint>(_16966 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _15237 = g_ScrambledHaltonPermutations.Load<uint>(_16966 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_15223 * 97969u) + (_15231 * 313u)) + _15237) * 3.2611211508992710150778293609619e-08f;
	                _19096 = true;
	                break;
	            }
	            case 65u:
	            {
	                uint _7353 = _12091 % 317u;
	                uint _16961 = (10780u + _7353) / 2u;
	                uint _15203;
	                if ((_7353 & 1u) != 0u)
	                {
	                    _15203 = g_ScrambledHaltonPermutations.Load<uint>(_16961 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _15203 = g_ScrambledHaltonPermutations.Load<uint>(_16961 * 4 + 0) & 65535u;
	                }
	                uint _15206 = (_12091 / 317u) % 317u;
	                uint _16962 = (10780u + _15206) / 2u;
	                uint _15211;
	                if ((_15206 & 1u) != 0u)
	                {
	                    _15211 = g_ScrambledHaltonPermutations.Load<uint>(_16962 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _15211 = g_ScrambledHaltonPermutations.Load<uint>(_16962 * 4 + 0) & 65535u;
	                }
	                uint _9002 = (_12091 / 100489u) % 317u;
	                uint _16963 = (10780u + _9002) / 2u;
	                uint _15217;
	                if ((_9002 & 1u) != 0u)
	                {
	                    _15217 = g_ScrambledHaltonPermutations.Load<uint>(_16963 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _15217 = g_ScrambledHaltonPermutations.Load<uint>(_16963 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_15203 * 100489u) + (_15211 * 317u)) + _15217) * 3.1392229260518433875404298305511e-08f;
	                _19096 = true;
	                break;
	            }
	            case 66u:
	            {
	                uint _16139 = 11097u + (_12091 % 331u);
	                uint _16958 = _16139 / 2u;
	                uint _15183;
	                if ((_16139 & 1u) != 0u)
	                {
	                    _15183 = g_ScrambledHaltonPermutations.Load<uint>(_16958 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _15183 = g_ScrambledHaltonPermutations.Load<uint>(_16958 * 4 + 0) & 65535u;
	                }
	                uint _20648 = 11097u + ((_12091 / 331u) % 331u);
	                uint _16959 = _20648 / 2u;
	                uint _15191;
	                if ((_20648 & 1u) != 0u)
	                {
	                    _15191 = g_ScrambledHaltonPermutations.Load<uint>(_16959 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _15191 = g_ScrambledHaltonPermutations.Load<uint>(_16959 * 4 + 0) & 65535u;
	                }
	                uint _20649 = 11097u + ((_12091 / 109561u) % 331u);
	                uint _16960 = _20649 / 2u;
	                uint _15197;
	                if ((_20649 & 1u) != 0u)
	                {
	                    _15197 = g_ScrambledHaltonPermutations.Load<uint>(_16960 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _15197 = g_ScrambledHaltonPermutations.Load<uint>(_16960 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_15183 * 109561u) + (_15191 * 331u)) + _15197) * 2.7575026706472272053360939025879e-08f;
	                _19096 = true;
	                break;
	            }
	            case 67u:
	            {
	                uint _7351 = _12091 % 337u;
	                uint _16955 = (11428u + _7351) / 2u;
	                uint _15163;
	                if ((_7351 & 1u) != 0u)
	                {
	                    _15163 = g_ScrambledHaltonPermutations.Load<uint>(_16955 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _15163 = g_ScrambledHaltonPermutations.Load<uint>(_16955 * 4 + 0) & 65535u;
	                }
	                uint _15166 = (_12091 / 337u) % 337u;
	                uint _16956 = (11428u + _15166) / 2u;
	                uint _15171;
	                if ((_15166 & 1u) != 0u)
	                {
	                    _15171 = g_ScrambledHaltonPermutations.Load<uint>(_16956 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _15171 = g_ScrambledHaltonPermutations.Load<uint>(_16956 * 4 + 0) & 65535u;
	                }
	                uint _8994 = (_12091 / 113569u) % 337u;
	                uint _16957 = (11428u + _8994) / 2u;
	                uint _15177;
	                if ((_8994 & 1u) != 0u)
	                {
	                    _15177 = g_ScrambledHaltonPermutations.Load<uint>(_16957 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _15177 = g_ScrambledHaltonPermutations.Load<uint>(_16957 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_15163 * 113569u) + (_15171 * 337u)) + _15177) * 2.6128246233270147058647125959396e-08f;
	                _19096 = true;
	                break;
	            }
	            case 68u:
	            {
	                uint _16131 = 11765u + (_12091 % 347u);
	                uint _16952 = _16131 / 2u;
	                uint _15143;
	                if ((_16131 & 1u) != 0u)
	                {
	                    _15143 = g_ScrambledHaltonPermutations.Load<uint>(_16952 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _15143 = g_ScrambledHaltonPermutations.Load<uint>(_16952 * 4 + 0) & 65535u;
	                }
	                uint _20644 = 11765u + ((_12091 / 347u) % 347u);
	                uint _16953 = _20644 / 2u;
	                uint _15151;
	                if ((_20644 & 1u) != 0u)
	                {
	                    _15151 = g_ScrambledHaltonPermutations.Load<uint>(_16953 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _15151 = g_ScrambledHaltonPermutations.Load<uint>(_16953 * 4 + 0) & 65535u;
	                }
	                uint _20645 = 11765u + ((_12091 / 120409u) % 347u);
	                uint _16954 = _20645 / 2u;
	                uint _15157;
	                if ((_20645 & 1u) != 0u)
	                {
	                    _15157 = g_ScrambledHaltonPermutations.Load<uint>(_16954 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _15157 = g_ScrambledHaltonPermutations.Load<uint>(_16954 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_15143 * 120409u) + (_15151 * 347u)) + _15157) * 2.3933791837293938442599028348923e-08f;
	                _19096 = true;
	                break;
	            }
	            case 69u:
	            {
	                uint _7349 = _12091 % 349u;
	                uint _16949 = (12112u + _7349) / 2u;
	                uint _15123;
	                if ((_7349 & 1u) != 0u)
	                {
	                    _15123 = g_ScrambledHaltonPermutations.Load<uint>(_16949 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _15123 = g_ScrambledHaltonPermutations.Load<uint>(_16949 * 4 + 0) & 65535u;
	                }
	                uint _15126 = (_12091 / 349u) % 349u;
	                uint _16950 = (12112u + _15126) / 2u;
	                uint _15131;
	                if ((_15126 & 1u) != 0u)
	                {
	                    _15131 = g_ScrambledHaltonPermutations.Load<uint>(_16950 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _15131 = g_ScrambledHaltonPermutations.Load<uint>(_16950 * 4 + 0) & 65535u;
	                }
	                uint _8986 = (_12091 / 121801u) % 349u;
	                uint _16951 = (12112u + _8986) / 2u;
	                uint _15137;
	                if ((_8986 & 1u) != 0u)
	                {
	                    _15137 = g_ScrambledHaltonPermutations.Load<uint>(_16951 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _15137 = g_ScrambledHaltonPermutations.Load<uint>(_16951 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_15123 * 121801u) + (_15131 * 349u)) + _15137) * 2.3524677317254827357828617095947e-08f;
	                _19096 = true;
	                break;
	            }
	            case 70u:
	            {
	                uint _16123 = 12461u + (_12091 % 353u);
	                uint _16946 = _16123 / 2u;
	                uint _15103;
	                if ((_16123 & 1u) != 0u)
	                {
	                    _15103 = g_ScrambledHaltonPermutations.Load<uint>(_16946 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _15103 = g_ScrambledHaltonPermutations.Load<uint>(_16946 * 4 + 0) & 65535u;
	                }
	                uint _20640 = 12461u + ((_12091 / 353u) % 353u);
	                uint _16947 = _20640 / 2u;
	                uint _15111;
	                if ((_20640 & 1u) != 0u)
	                {
	                    _15111 = g_ScrambledHaltonPermutations.Load<uint>(_16947 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _15111 = g_ScrambledHaltonPermutations.Load<uint>(_16947 * 4 + 0) & 65535u;
	                }
	                uint _20641 = 12461u + ((_12091 / 124609u) % 353u);
	                uint _16948 = _20641 / 2u;
	                uint _15117;
	                if ((_20641 & 1u) != 0u)
	                {
	                    _15117 = g_ScrambledHaltonPermutations.Load<uint>(_16948 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _15117 = g_ScrambledHaltonPermutations.Load<uint>(_16948 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_15103 * 124609u) + (_15111 * 353u)) + _15117) * 2.2733999571755703072994947433472e-08f;
	                _19096 = true;
	                break;
	            }
	            case 71u:
	            {
	                uint _7347 = _12091 % 359u;
	                uint _16943 = (12814u + _7347) / 2u;
	                uint _15083;
	                if ((_7347 & 1u) != 0u)
	                {
	                    _15083 = g_ScrambledHaltonPermutations.Load<uint>(_16943 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _15083 = g_ScrambledHaltonPermutations.Load<uint>(_16943 * 4 + 0) & 65535u;
	                }
	                uint _15086 = (_12091 / 359u) % 359u;
	                uint _16944 = (12814u + _15086) / 2u;
	                uint _15091;
	                if ((_15086 & 1u) != 0u)
	                {
	                    _15091 = g_ScrambledHaltonPermutations.Load<uint>(_16944 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _15091 = g_ScrambledHaltonPermutations.Load<uint>(_16944 * 4 + 0) & 65535u;
	                }
	                uint _8978 = (_12091 / 128881u) % 359u;
	                uint _16945 = (12814u + _8978) / 2u;
	                uint _15097;
	                if ((_8978 & 1u) != 0u)
	                {
	                    _15097 = g_ScrambledHaltonPermutations.Load<uint>(_16945 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _15097 = g_ScrambledHaltonPermutations.Load<uint>(_16945 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_15083 * 128881u) + (_15091 * 359u)) + _15097) * 2.1613075773529999423772096633911e-08f;
	                _19096 = true;
	                break;
	            }
	            case 72u:
	            {
	                uint _16115 = 13173u + (_12091 % 367u);
	                uint _16940 = _16115 / 2u;
	                uint _15063;
	                if ((_16115 & 1u) != 0u)
	                {
	                    _15063 = g_ScrambledHaltonPermutations.Load<uint>(_16940 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _15063 = g_ScrambledHaltonPermutations.Load<uint>(_16940 * 4 + 0) & 65535u;
	                }
	                uint _20636 = 13173u + ((_12091 / 367u) % 367u);
	                uint _16941 = _20636 / 2u;
	                uint _15071;
	                if ((_20636 & 1u) != 0u)
	                {
	                    _15071 = g_ScrambledHaltonPermutations.Load<uint>(_16941 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _15071 = g_ScrambledHaltonPermutations.Load<uint>(_16941 * 4 + 0) & 65535u;
	                }
	                uint _20637 = 13173u + ((_12091 / 134689u) % 367u);
	                uint _16942 = _20637 / 2u;
	                uint _15077;
	                if ((_20637 & 1u) != 0u)
	                {
	                    _15077 = g_ScrambledHaltonPermutations.Load<uint>(_16942 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _15077 = g_ScrambledHaltonPermutations.Load<uint>(_16942 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_15063 * 134689u) + (_15071 * 367u)) + _15077) * 2.0230272568255713849794119596481e-08f;
	                _19096 = true;
	                break;
	            }
	            case 73u:
	            {
	                uint _7345 = _12091 % 373u;
	                uint _16937 = (13540u + _7345) / 2u;
	                uint _15043;
	                if ((_7345 & 1u) != 0u)
	                {
	                    _15043 = g_ScrambledHaltonPermutations.Load<uint>(_16937 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _15043 = g_ScrambledHaltonPermutations.Load<uint>(_16937 * 4 + 0) & 65535u;
	                }
	                uint _15046 = (_12091 / 373u) % 373u;
	                uint _16938 = (13540u + _15046) / 2u;
	                uint _15051;
	                if ((_15046 & 1u) != 0u)
	                {
	                    _15051 = g_ScrambledHaltonPermutations.Load<uint>(_16938 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _15051 = g_ScrambledHaltonPermutations.Load<uint>(_16938 * 4 + 0) & 65535u;
	                }
	                uint _8970 = (_12091 / 139129u) % 373u;
	                uint _16939 = (13540u + _8970) / 2u;
	                uint _15057;
	                if ((_8970 & 1u) != 0u)
	                {
	                    _15057 = g_ScrambledHaltonPermutations.Load<uint>(_16939 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _15057 = g_ScrambledHaltonPermutations.Load<uint>(_16939 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_15043 * 139129u) + (_15051 * 373u)) + _15057) * 1.9269633000362773600500077009201e-08f;
	                _19096 = true;
	                break;
	            }
	            case 74u:
	            {
	                uint _16107 = 13913u + (_12091 % 379u);
	                uint _16934 = _16107 / 2u;
	                uint _15023;
	                if ((_16107 & 1u) != 0u)
	                {
	                    _15023 = g_ScrambledHaltonPermutations.Load<uint>(_16934 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _15023 = g_ScrambledHaltonPermutations.Load<uint>(_16934 * 4 + 0) & 65535u;
	                }
	                uint _20632 = 13913u + ((_12091 / 379u) % 379u);
	                uint _16935 = _20632 / 2u;
	                uint _15031;
	                if ((_20632 & 1u) != 0u)
	                {
	                    _15031 = g_ScrambledHaltonPermutations.Load<uint>(_16935 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _15031 = g_ScrambledHaltonPermutations.Load<uint>(_16935 * 4 + 0) & 65535u;
	                }
	                uint _20633 = 13913u + ((_12091 / 143641u) % 379u);
	                uint _16936 = _20633 / 2u;
	                uint _15037;
	                if ((_20633 & 1u) != 0u)
	                {
	                    _15037 = g_ScrambledHaltonPermutations.Load<uint>(_16936 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _15037 = g_ScrambledHaltonPermutations.Load<uint>(_16936 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_15023 * 143641u) + (_15031 * 379u)) + _15037) * 1.8368863763384979392867535352707e-08f;
	                _19096 = true;
	                break;
	            }
	            case 75u:
	            {
	                uint _7343 = _12091 % 383u;
	                uint _16931 = (14292u + _7343) / 2u;
	                uint _15003;
	                if ((_7343 & 1u) != 0u)
	                {
	                    _15003 = g_ScrambledHaltonPermutations.Load<uint>(_16931 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _15003 = g_ScrambledHaltonPermutations.Load<uint>(_16931 * 4 + 0) & 65535u;
	                }
	                uint _15006 = (_12091 / 383u) % 383u;
	                uint _16932 = (14292u + _15006) / 2u;
	                uint _15011;
	                if ((_15006 & 1u) != 0u)
	                {
	                    _15011 = g_ScrambledHaltonPermutations.Load<uint>(_16932 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _15011 = g_ScrambledHaltonPermutations.Load<uint>(_16932 * 4 + 0) & 65535u;
	                }
	                uint _8962 = (_12091 / 146689u) % 383u;
	                uint _16933 = (14292u + _8962) / 2u;
	                uint _15017;
	                if ((_8962 & 1u) != 0u)
	                {
	                    _15017 = g_ScrambledHaltonPermutations.Load<uint>(_16933 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _15017 = g_ScrambledHaltonPermutations.Load<uint>(_16933 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_15003 * 146689u) + (_15011 * 383u)) + _15017) * 1.779932823353647108888253569603e-08f;
	                _19096 = true;
	                break;
	            }
	            case 76u:
	            {
	                uint _16099 = 14675u + (_12091 % 389u);
	                uint _16928 = _16099 / 2u;
	                uint _13548;
	                if ((_16099 & 1u) != 0u)
	                {
	                    _13548 = g_ScrambledHaltonPermutations.Load<uint>(_16928 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13548 = g_ScrambledHaltonPermutations.Load<uint>(_16928 * 4 + 0) & 65535u;
	                }
	                uint _20628 = 14675u + ((_12091 / 389u) % 389u);
	                uint _16929 = _20628 / 2u;
	                uint _14991;
	                if ((_20628 & 1u) != 0u)
	                {
	                    _14991 = g_ScrambledHaltonPermutations.Load<uint>(_16929 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _14991 = g_ScrambledHaltonPermutations.Load<uint>(_16929 * 4 + 0) & 65535u;
	                }
	                uint _20629 = 14675u + ((_12091 / 151321u) % 389u);
	                uint _16930 = _20629 / 2u;
	                uint _14997;
	                if ((_20629 & 1u) != 0u)
	                {
	                    _14997 = g_ScrambledHaltonPermutations.Load<uint>(_16930 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _14997 = g_ScrambledHaltonPermutations.Load<uint>(_16930 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_13548 * 151321u) + (_14991 * 389u)) + _14997) * 1.6988348505719841341488063335419e-08f;
	                _19096 = true;
	                break;
	            }
	            case 77u:
	            {
	                uint _7341 = _12091 % 397u;
	                uint _16925 = (15064u + _7341) / 2u;
	                uint _13536;
	                if ((_7341 & 1u) != 0u)
	                {
	                    _13536 = g_ScrambledHaltonPermutations.Load<uint>(_16925 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13536 = g_ScrambledHaltonPermutations.Load<uint>(_16925 * 4 + 0) & 65535u;
	                }
	                uint _13538 = (_12091 / 397u) % 397u;
	                uint _16926 = (15064u + _13538) / 2u;
	                uint _13541;
	                if ((_13538 & 1u) != 0u)
	                {
	                    _13541 = g_ScrambledHaltonPermutations.Load<uint>(_16926 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13541 = g_ScrambledHaltonPermutations.Load<uint>(_16926 * 4 + 0) & 65535u;
	                }
	                uint _8954 = (_12091 / 157609u) % 397u;
	                uint _16927 = (15064u + _8954) / 2u;
	                uint _13545;
	                if ((_8954 & 1u) != 0u)
	                {
	                    _13545 = g_ScrambledHaltonPermutations.Load<uint>(_16927 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13545 = g_ScrambledHaltonPermutations.Load<uint>(_16927 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_13536 * 157609u) + (_13541 * 397u)) + _13545) * 1.5981900247652447433210909366608e-08f;
	                _19096 = true;
	                break;
	            }
	            case 78u:
	            {
	                uint _16091 = 15461u + (_12091 % 401u);
	                uint _16922 = _16091 / 2u;
	                uint _13524;
	                if ((_16091 & 1u) != 0u)
	                {
	                    _13524 = g_ScrambledHaltonPermutations.Load<uint>(_16922 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13524 = g_ScrambledHaltonPermutations.Load<uint>(_16922 * 4 + 0) & 65535u;
	                }
	                uint _20624 = 15461u + ((_12091 / 401u) % 401u);
	                uint _16923 = _20624 / 2u;
	                uint _13529;
	                if ((_20624 & 1u) != 0u)
	                {
	                    _13529 = g_ScrambledHaltonPermutations.Load<uint>(_16923 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13529 = g_ScrambledHaltonPermutations.Load<uint>(_16923 * 4 + 0) & 65535u;
	                }
	                uint _20625 = 15461u + ((_12091 / 160801u) % 401u);
	                uint _16924 = _20625 / 2u;
	                uint _13533;
	                if ((_20625 & 1u) != 0u)
	                {
	                    _13533 = g_ScrambledHaltonPermutations.Load<uint>(_16924 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13533 = g_ScrambledHaltonPermutations.Load<uint>(_16924 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_13524 * 160801u) + (_13529 * 401u)) + _13533) * 1.5508394568541916669346392154694e-08f;
	                _19096 = true;
	                break;
	            }
	            case 79u:
	            {
	                uint _7339 = _12091 % 409u;
	                uint _16919 = (15862u + _7339) / 2u;
	                uint _13512;
	                if ((_7339 & 1u) != 0u)
	                {
	                    _13512 = g_ScrambledHaltonPermutations.Load<uint>(_16919 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13512 = g_ScrambledHaltonPermutations.Load<uint>(_16919 * 4 + 0) & 65535u;
	                }
	                uint _13514 = (_12091 / 409u) % 409u;
	                uint _16920 = (15862u + _13514) / 2u;
	                uint _13517;
	                if ((_13514 & 1u) != 0u)
	                {
	                    _13517 = g_ScrambledHaltonPermutations.Load<uint>(_16920 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13517 = g_ScrambledHaltonPermutations.Load<uint>(_16920 * 4 + 0) & 65535u;
	                }
	                uint _8946 = (_12091 / 167281u) % 409u;
	                uint _16921 = (15862u + _8946) / 2u;
	                uint _13521;
	                if ((_8946 & 1u) != 0u)
	                {
	                    _13521 = g_ScrambledHaltonPermutations.Load<uint>(_16921 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13521 = g_ScrambledHaltonPermutations.Load<uint>(_16921 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_13512 * 167281u) + (_13517 * 409u)) + _13521) * 1.4616050592053397849667817354202e-08f;
	                _19096 = true;
	                break;
	            }
	            case 80u:
	            {
	                uint _16083 = 16271u + (_12091 % 419u);
	                uint _16916 = _16083 / 2u;
	                uint _13500;
	                if ((_16083 & 1u) != 0u)
	                {
	                    _13500 = g_ScrambledHaltonPermutations.Load<uint>(_16916 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13500 = g_ScrambledHaltonPermutations.Load<uint>(_16916 * 4 + 0) & 65535u;
	                }
	                uint _20620 = 16271u + ((_12091 / 419u) % 419u);
	                uint _16917 = _20620 / 2u;
	                uint _13505;
	                if ((_20620 & 1u) != 0u)
	                {
	                    _13505 = g_ScrambledHaltonPermutations.Load<uint>(_16917 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13505 = g_ScrambledHaltonPermutations.Load<uint>(_16917 * 4 + 0) & 65535u;
	                }
	                uint _20621 = 16271u + ((_12091 / 175561u) % 419u);
	                uint _16918 = _20621 / 2u;
	                uint _13509;
	                if ((_20621 & 1u) != 0u)
	                {
	                    _13509 = g_ScrambledHaltonPermutations.Load<uint>(_16918 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13509 = g_ScrambledHaltonPermutations.Load<uint>(_16918 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_13500 * 175561u) + (_13505 * 419u)) + _13509) * 1.3594332770594519388396292924881e-08f;
	                _19096 = true;
	                break;
	            }
	            case 81u:
	            {
	                uint _7337 = _12091 % 421u;
	                uint _16913 = (16690u + _7337) / 2u;
	                uint _13488;
	                if ((_7337 & 1u) != 0u)
	                {
	                    _13488 = g_ScrambledHaltonPermutations.Load<uint>(_16913 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13488 = g_ScrambledHaltonPermutations.Load<uint>(_16913 * 4 + 0) & 65535u;
	                }
	                uint _13490 = (_12091 / 421u) % 421u;
	                uint _16914 = (16690u + _13490) / 2u;
	                uint _13493;
	                if ((_13490 & 1u) != 0u)
	                {
	                    _13493 = g_ScrambledHaltonPermutations.Load<uint>(_16914 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13493 = g_ScrambledHaltonPermutations.Load<uint>(_16914 * 4 + 0) & 65535u;
	                }
	                uint _8937 = (_12091 / 177241u) % 421u;
	                uint _16915 = (16690u + _8937) / 2u;
	                uint _13497;
	                if ((_8937 & 1u) != 0u)
	                {
	                    _13497 = g_ScrambledHaltonPermutations.Load<uint>(_16915 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13497 = g_ScrambledHaltonPermutations.Load<uint>(_16915 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_13488 * 177241u) + (_13493 * 421u)) + _13497) * 1.3401507459320782800205051898956e-08f;
	                _19096 = true;
	                break;
	            }
	            case 82u:
	            {
	                uint _16075 = 17111u + (_12091 % 431u);
	                uint _16910 = _16075 / 2u;
	                uint _13476;
	                if ((_16075 & 1u) != 0u)
	                {
	                    _13476 = g_ScrambledHaltonPermutations.Load<uint>(_16910 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13476 = g_ScrambledHaltonPermutations.Load<uint>(_16910 * 4 + 0) & 65535u;
	                }
	                uint _20616 = 17111u + ((_12091 / 431u) % 431u);
	                uint _16911 = _20616 / 2u;
	                uint _13481;
	                if ((_20616 & 1u) != 0u)
	                {
	                    _13481 = g_ScrambledHaltonPermutations.Load<uint>(_16911 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13481 = g_ScrambledHaltonPermutations.Load<uint>(_16911 * 4 + 0) & 65535u;
	                }
	                uint _20617 = 17111u + ((_12091 / 185761u) % 431u);
	                uint _16912 = _20617 / 2u;
	                uint _13485;
	                if ((_20617 & 1u) != 0u)
	                {
	                    _13485 = g_ScrambledHaltonPermutations.Load<uint>(_16912 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13485 = g_ScrambledHaltonPermutations.Load<uint>(_16912 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_13476 * 185761u) + (_13481 * 431u)) + _13485) * 1.249016357007803890155628323555e-08f;
	                _19096 = true;
	                break;
	            }
	            case 83u:
	            {
	                uint _7335 = _12091 % 433u;
	                uint _16907 = (17542u + _7335) / 2u;
	                uint _13464;
	                if ((_7335 & 1u) != 0u)
	                {
	                    _13464 = g_ScrambledHaltonPermutations.Load<uint>(_16907 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13464 = g_ScrambledHaltonPermutations.Load<uint>(_16907 * 4 + 0) & 65535u;
	                }
	                uint _13466 = (_12091 / 433u) % 433u;
	                uint _16908 = (17542u + _13466) / 2u;
	                uint _13469;
	                if ((_13466 & 1u) != 0u)
	                {
	                    _13469 = g_ScrambledHaltonPermutations.Load<uint>(_16908 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13469 = g_ScrambledHaltonPermutations.Load<uint>(_16908 * 4 + 0) & 65535u;
	                }
	                uint _8929 = (_12091 / 187489u) % 433u;
	                uint _16909 = (17542u + _8929) / 2u;
	                uint _13473;
	                if ((_8929 & 1u) != 0u)
	                {
	                    _13473 = g_ScrambledHaltonPermutations.Load<uint>(_16909 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13473 = g_ScrambledHaltonPermutations.Load<uint>(_16909 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_13464 * 187489u) + (_13469 * 433u)) + _13473) * 1.2317888042900904110865667462349e-08f;
	                _19096 = true;
	                break;
	            }
	            case 84u:
	            {
	                uint _16067 = 17975u + (_12091 % 439u);
	                uint _16904 = _16067 / 2u;
	                uint _13452;
	                if ((_16067 & 1u) != 0u)
	                {
	                    _13452 = g_ScrambledHaltonPermutations.Load<uint>(_16904 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13452 = g_ScrambledHaltonPermutations.Load<uint>(_16904 * 4 + 0) & 65535u;
	                }
	                uint _20612 = 17975u + ((_12091 / 439u) % 439u);
	                uint _16905 = _20612 / 2u;
	                uint _13457;
	                if ((_20612 & 1u) != 0u)
	                {
	                    _13457 = g_ScrambledHaltonPermutations.Load<uint>(_16905 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13457 = g_ScrambledHaltonPermutations.Load<uint>(_16905 * 4 + 0) & 65535u;
	                }
	                uint _20613 = 17975u + ((_12091 / 192721u) % 439u);
	                uint _16906 = _20613 / 2u;
	                uint _13461;
	                if ((_20613 & 1u) != 0u)
	                {
	                    _13461 = g_ScrambledHaltonPermutations.Load<uint>(_16906 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13461 = g_ScrambledHaltonPermutations.Load<uint>(_16906 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_13452 * 192721u) + (_13457 * 439u)) + _13461) * 1.1819698109150067466543987393379e-08f;
	                _19096 = true;
	                break;
	            }
	            case 85u:
	            {
	                uint _7333 = _12091 % 443u;
	                uint _16901 = (18414u + _7333) / 2u;
	                uint _13440;
	                if ((_7333 & 1u) != 0u)
	                {
	                    _13440 = g_ScrambledHaltonPermutations.Load<uint>(_16901 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13440 = g_ScrambledHaltonPermutations.Load<uint>(_16901 * 4 + 0) & 65535u;
	                }
	                uint _13442 = (_12091 / 443u) % 443u;
	                uint _16902 = (18414u + _13442) / 2u;
	                uint _13445;
	                if ((_13442 & 1u) != 0u)
	                {
	                    _13445 = g_ScrambledHaltonPermutations.Load<uint>(_16902 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13445 = g_ScrambledHaltonPermutations.Load<uint>(_16902 * 4 + 0) & 65535u;
	                }
	                uint _8921 = (_12091 / 196249u) % 443u;
	                uint _16903 = (18414u + _8921) / 2u;
	                uint _13449;
	                if ((_8921 & 1u) != 0u)
	                {
	                    _13449 = g_ScrambledHaltonPermutations.Load<uint>(_16903 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13449 = g_ScrambledHaltonPermutations.Load<uint>(_16903 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_13440 * 196249u) + (_13445 * 443u)) + _13449) * 1.1502408803210073529044166207314e-08f;
	                _19096 = true;
	                break;
	            }
	            case 86u:
	            {
	                uint _16059 = 18857u + (_12091 % 449u);
	                uint _16898 = _16059 / 2u;
	                uint _13428;
	                if ((_16059 & 1u) != 0u)
	                {
	                    _13428 = g_ScrambledHaltonPermutations.Load<uint>(_16898 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13428 = g_ScrambledHaltonPermutations.Load<uint>(_16898 * 4 + 0) & 65535u;
	                }
	                uint _20608 = 18857u + ((_12091 / 449u) % 449u);
	                uint _16899 = _20608 / 2u;
	                uint _13433;
	                if ((_20608 & 1u) != 0u)
	                {
	                    _13433 = g_ScrambledHaltonPermutations.Load<uint>(_16899 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13433 = g_ScrambledHaltonPermutations.Load<uint>(_16899 * 4 + 0) & 65535u;
	                }
	                uint _20609 = 18857u + ((_12091 / 201601u) % 449u);
	                uint _16900 = _20609 / 2u;
	                uint _13437;
	                if ((_20609 & 1u) != 0u)
	                {
	                    _13437 = g_ScrambledHaltonPermutations.Load<uint>(_16900 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13437 = g_ScrambledHaltonPermutations.Load<uint>(_16900 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_13428 * 201601u) + (_13433 * 449u)) + _13437) * 1.1047421644150290376273915171623e-08f;
	                _19096 = true;
	                break;
	            }
	            case 87u:
	            {
	                uint _7331 = _12091 % 457u;
	                uint _16895 = (19306u + _7331) / 2u;
	                uint _13416;
	                if ((_7331 & 1u) != 0u)
	                {
	                    _13416 = g_ScrambledHaltonPermutations.Load<uint>(_16895 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13416 = g_ScrambledHaltonPermutations.Load<uint>(_16895 * 4 + 0) & 65535u;
	                }
	                uint _13418 = (_12091 / 457u) % 457u;
	                uint _16896 = (19306u + _13418) / 2u;
	                uint _13421;
	                if ((_13418 & 1u) != 0u)
	                {
	                    _13421 = g_ScrambledHaltonPermutations.Load<uint>(_16896 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13421 = g_ScrambledHaltonPermutations.Load<uint>(_16896 * 4 + 0) & 65535u;
	                }
	                uint _8913 = (_12091 / 208849u) % 457u;
	                uint _16897 = (19306u + _8913) / 2u;
	                uint _13425;
	                if ((_8913 & 1u) != 0u)
	                {
	                    _13425 = g_ScrambledHaltonPermutations.Load<uint>(_16897 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13425 = g_ScrambledHaltonPermutations.Load<uint>(_16897 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_13416 * 208849u) + (_13421 * 457u)) + _13425) * 1.0477347878179443796398118138313e-08f;
	                _19096 = true;
	                break;
	            }
	            case 88u:
	            {
	                uint _16051 = 19763u + (_12091 % 461u);
	                uint _16892 = _16051 / 2u;
	                uint _13404;
	                if ((_16051 & 1u) != 0u)
	                {
	                    _13404 = g_ScrambledHaltonPermutations.Load<uint>(_16892 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13404 = g_ScrambledHaltonPermutations.Load<uint>(_16892 * 4 + 0) & 65535u;
	                }
	                uint _20604 = 19763u + ((_12091 / 461u) % 461u);
	                uint _16893 = _20604 / 2u;
	                uint _13409;
	                if ((_20604 & 1u) != 0u)
	                {
	                    _13409 = g_ScrambledHaltonPermutations.Load<uint>(_16893 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13409 = g_ScrambledHaltonPermutations.Load<uint>(_16893 * 4 + 0) & 65535u;
	                }
	                uint _20605 = 19763u + ((_12091 / 212521u) % 461u);
	                uint _16894 = _20605 / 2u;
	                uint _13413;
	                if ((_20605 & 1u) != 0u)
	                {
	                    _13413 = g_ScrambledHaltonPermutations.Load<uint>(_16894 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13413 = g_ScrambledHaltonPermutations.Load<uint>(_16894 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_13404 * 212521u) + (_13409 * 461u)) + _13413) * 1.0206977485438528674421831965446e-08f;
	                _19096 = true;
	                break;
	            }
	            case 89u:
	            {
	                uint _7329 = _12091 % 463u;
	                uint _16889 = (20224u + _7329) / 2u;
	                uint _13392;
	                if ((_7329 & 1u) != 0u)
	                {
	                    _13392 = g_ScrambledHaltonPermutations.Load<uint>(_16889 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13392 = g_ScrambledHaltonPermutations.Load<uint>(_16889 * 4 + 0) & 65535u;
	                }
	                uint _13394 = (_12091 / 463u) % 463u;
	                uint _16890 = (20224u + _13394) / 2u;
	                uint _13397;
	                if ((_13394 & 1u) != 0u)
	                {
	                    _13397 = g_ScrambledHaltonPermutations.Load<uint>(_16890 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13397 = g_ScrambledHaltonPermutations.Load<uint>(_16890 * 4 + 0) & 65535u;
	                }
	                uint _8905 = (_12091 / 214369u) % 463u;
	                uint _16891 = (20224u + _8905) / 2u;
	                uint _13401;
	                if ((_8905 & 1u) != 0u)
	                {
	                    _13401 = g_ScrambledHaltonPermutations.Load<uint>(_16891 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13401 = g_ScrambledHaltonPermutations.Load<uint>(_16891 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_13392 * 214369u) + (_13397 * 463u)) + _13401) * 1.007527661300855470472015440464e-08f;
	                _19096 = true;
	                break;
	            }
	            case 90u:
	            {
	                uint _16043 = 20687u + (_12091 % 467u);
	                uint _16886 = _16043 / 2u;
	                uint _13380;
	                if ((_16043 & 1u) != 0u)
	                {
	                    _13380 = g_ScrambledHaltonPermutations.Load<uint>(_16886 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13380 = g_ScrambledHaltonPermutations.Load<uint>(_16886 * 4 + 0) & 65535u;
	                }
	                uint _20600 = 20687u + ((_12091 / 467u) % 467u);
	                uint _16887 = _20600 / 2u;
	                uint _13385;
	                if ((_20600 & 1u) != 0u)
	                {
	                    _13385 = g_ScrambledHaltonPermutations.Load<uint>(_16887 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13385 = g_ScrambledHaltonPermutations.Load<uint>(_16887 * 4 + 0) & 65535u;
	                }
	                uint _20601 = 20687u + ((_12091 / 218089u) % 467u);
	                uint _16888 = _20601 / 2u;
	                uint _13389;
	                if ((_20601 & 1u) != 0u)
	                {
	                    _13389 = g_ScrambledHaltonPermutations.Load<uint>(_16888 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13389 = g_ScrambledHaltonPermutations.Load<uint>(_16888 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_13380 * 218089u) + (_13385 * 467u)) + _13389) * 9.8185948260720579128246754407883e-09f;
	                _19096 = true;
	                break;
	            }
	            case 91u:
	            {
	                uint _7327 = _12091 % 479u;
	                uint _16883 = (21154u + _7327) / 2u;
	                uint _13368;
	                if ((_7327 & 1u) != 0u)
	                {
	                    _13368 = g_ScrambledHaltonPermutations.Load<uint>(_16883 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13368 = g_ScrambledHaltonPermutations.Load<uint>(_16883 * 4 + 0) & 65535u;
	                }
	                uint _13370 = (_12091 / 479u) % 479u;
	                uint _16884 = (21154u + _13370) / 2u;
	                uint _13373;
	                if ((_13370 & 1u) != 0u)
	                {
	                    _13373 = g_ScrambledHaltonPermutations.Load<uint>(_16884 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13373 = g_ScrambledHaltonPermutations.Load<uint>(_16884 * 4 + 0) & 65535u;
	                }
	                uint _8897 = (_12091 / 229441u) % 479u;
	                uint _16885 = (21154u + _8897) / 2u;
	                uint _13377;
	                if ((_8897 & 1u) != 0u)
	                {
	                    _13377 = g_ScrambledHaltonPermutations.Load<uint>(_16885 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13377 = g_ScrambledHaltonPermutations.Load<uint>(_16885 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_13368 * 229441u) + (_13373 * 479u)) + _13377) * 9.0989944467878558498341590166092e-09f;
	                _19096 = true;
	                break;
	            }
	            case 92u:
	            {
	                uint _16035 = 21633u + (_12091 % 487u);
	                uint _16880 = _16035 / 2u;
	                uint _13356;
	                if ((_16035 & 1u) != 0u)
	                {
	                    _13356 = g_ScrambledHaltonPermutations.Load<uint>(_16880 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13356 = g_ScrambledHaltonPermutations.Load<uint>(_16880 * 4 + 0) & 65535u;
	                }
	                uint _20596 = 21633u + ((_12091 / 487u) % 487u);
	                uint _16881 = _20596 / 2u;
	                uint _13361;
	                if ((_20596 & 1u) != 0u)
	                {
	                    _13361 = g_ScrambledHaltonPermutations.Load<uint>(_16881 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13361 = g_ScrambledHaltonPermutations.Load<uint>(_16881 * 4 + 0) & 65535u;
	                }
	                uint _20597 = 21633u + ((_12091 / 237169u) % 487u);
	                uint _16882 = _20597 / 2u;
	                uint _13365;
	                if ((_20597 & 1u) != 0u)
	                {
	                    _13365 = g_ScrambledHaltonPermutations.Load<uint>(_16882 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13365 = g_ScrambledHaltonPermutations.Load<uint>(_16882 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_13356 * 237169u) + (_13361 * 487u)) + _13365) * 8.6579099445316387573257088661194e-09f;
	                _19096 = true;
	                break;
	            }
	            case 93u:
	            {
	                uint _7325 = _12091 % 491u;
	                uint _16877 = (22120u + _7325) / 2u;
	                uint _13344;
	                if ((_7325 & 1u) != 0u)
	                {
	                    _13344 = g_ScrambledHaltonPermutations.Load<uint>(_16877 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13344 = g_ScrambledHaltonPermutations.Load<uint>(_16877 * 4 + 0) & 65535u;
	                }
	                uint _13346 = (_12091 / 491u) % 491u;
	                uint _16878 = (22120u + _13346) / 2u;
	                uint _13349;
	                if ((_13346 & 1u) != 0u)
	                {
	                    _13349 = g_ScrambledHaltonPermutations.Load<uint>(_16878 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13349 = g_ScrambledHaltonPermutations.Load<uint>(_16878 * 4 + 0) & 65535u;
	                }
	                uint _8889 = (_12091 / 241081u) % 491u;
	                uint _16879 = (22120u + _8889) / 2u;
	                uint _13353;
	                if ((_8889 & 1u) != 0u)
	                {
	                    _13353 = g_ScrambledHaltonPermutations.Load<uint>(_16879 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13353 = g_ScrambledHaltonPermutations.Load<uint>(_16879 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_13344 * 241081u) + (_13349 * 491u)) + _13353) * 8.4480307194212400645483285188675e-09f;
	                _19096 = true;
	                break;
	            }
	            case 94u:
	            {
	                uint _16027 = 22611u + (_12091 % 499u);
	                uint _16874 = _16027 / 2u;
	                uint _13332;
	                if ((_16027 & 1u) != 0u)
	                {
	                    _13332 = g_ScrambledHaltonPermutations.Load<uint>(_16874 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13332 = g_ScrambledHaltonPermutations.Load<uint>(_16874 * 4 + 0) & 65535u;
	                }
	                uint _20592 = 22611u + ((_12091 / 499u) % 499u);
	                uint _16875 = _20592 / 2u;
	                uint _13337;
	                if ((_20592 & 1u) != 0u)
	                {
	                    _13337 = g_ScrambledHaltonPermutations.Load<uint>(_16875 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13337 = g_ScrambledHaltonPermutations.Load<uint>(_16875 * 4 + 0) & 65535u;
	                }
	                uint _20593 = 22611u + ((_12091 / 249001u) % 499u);
	                uint _16876 = _20593 / 2u;
	                uint _13341;
	                if ((_20593 & 1u) != 0u)
	                {
	                    _13341 = g_ScrambledHaltonPermutations.Load<uint>(_16876 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13341 = g_ScrambledHaltonPermutations.Load<uint>(_16876 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_13332 * 249001u) + (_13337 * 499u)) + _13341) * 8.0481914466190573875792324542999e-09f;
	                _19096 = true;
	                break;
	            }
	            case 95u:
	            {
	                uint _7323 = _12091 % 503u;
	                uint _16871 = (23110u + _7323) / 2u;
	                uint _13320;
	                if ((_7323 & 1u) != 0u)
	                {
	                    _13320 = g_ScrambledHaltonPermutations.Load<uint>(_16871 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13320 = g_ScrambledHaltonPermutations.Load<uint>(_16871 * 4 + 0) & 65535u;
	                }
	                uint _13322 = (_12091 / 503u) % 503u;
	                uint _16872 = (23110u + _13322) / 2u;
	                uint _13325;
	                if ((_13322 & 1u) != 0u)
	                {
	                    _13325 = g_ScrambledHaltonPermutations.Load<uint>(_16872 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13325 = g_ScrambledHaltonPermutations.Load<uint>(_16872 * 4 + 0) & 65535u;
	                }
	                uint _8881 = (_12091 / 253009u) % 503u;
	                uint _16873 = (23110u + _8881) / 2u;
	                uint _13329;
	                if ((_8881 & 1u) != 0u)
	                {
	                    _13329 = g_ScrambledHaltonPermutations.Load<uint>(_16873 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13329 = g_ScrambledHaltonPermutations.Load<uint>(_16873 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_13320 * 253009u) + (_13325 * 503u)) + _13329) * 7.8577100381949094298761337995529e-09f;
	                _19096 = true;
	                break;
	            }
	            case 96u:
	            {
	                uint _16019 = 23613u + (_12091 % 509u);
	                uint _16868 = _16019 / 2u;
	                uint _13148;
	                if ((_16019 & 1u) != 0u)
	                {
	                    _13148 = g_ScrambledHaltonPermutations.Load<uint>(_16868 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13148 = g_ScrambledHaltonPermutations.Load<uint>(_16868 * 4 + 0) & 65535u;
	                }
	                uint _20588 = 23613u + ((_12091 / 509u) % 509u);
	                uint _16869 = _20588 / 2u;
	                uint _13313;
	                if ((_20588 & 1u) != 0u)
	                {
	                    _13313 = g_ScrambledHaltonPermutations.Load<uint>(_16869 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13313 = g_ScrambledHaltonPermutations.Load<uint>(_16869 * 4 + 0) & 65535u;
	                }
	                uint _20589 = 23613u + ((_12091 / 259081u) % 509u);
	                uint _16870 = _20589 / 2u;
	                uint _13317;
	                if ((_20589 & 1u) != 0u)
	                {
	                    _13317 = g_ScrambledHaltonPermutations.Load<uint>(_16870 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13317 = g_ScrambledHaltonPermutations.Load<uint>(_16870 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_13148 * 259081u) + (_13313 * 509u)) + _13317) * 7.5830968171430868096649646759033e-09f;
	                _19096 = true;
	                break;
	            }
	            case 97u:
	            {
	                uint _7321 = _12091 % 521u;
	                uint _16865 = (24122u + _7321) / 2u;
	                uint _13137;
	                if ((_7321 & 1u) != 0u)
	                {
	                    _13137 = g_ScrambledHaltonPermutations.Load<uint>(_16865 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13137 = g_ScrambledHaltonPermutations.Load<uint>(_16865 * 4 + 0) & 65535u;
	                }
	                uint _13139 = (_12091 / 521u) % 521u;
	                uint _16866 = (24122u + _13139) / 2u;
	                uint _13142;
	                if ((_13139 & 1u) != 0u)
	                {
	                    _13142 = g_ScrambledHaltonPermutations.Load<uint>(_16866 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13142 = g_ScrambledHaltonPermutations.Load<uint>(_16866 * 4 + 0) & 65535u;
	                }
	                uint _8873 = (_12091 / 271441u) % 521u;
	                uint _16867 = (24122u + _8873) / 2u;
	                uint _13145;
	                if ((_8873 & 1u) != 0u)
	                {
	                    _13145 = g_ScrambledHaltonPermutations.Load<uint>(_16867 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13145 = g_ScrambledHaltonPermutations.Load<uint>(_16867 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_13137 * 271441u) + (_13142 * 521u)) + _13145) * 7.0710965971443329181056469678879e-09f;
	                _19096 = true;
	                break;
	            }
	            case 98u:
	            {
	                uint _16011 = 24643u + (_12091 % 523u);
	                uint _16862 = _16011 / 2u;
	                uint _13125;
	                if ((_16011 & 1u) != 0u)
	                {
	                    _13125 = g_ScrambledHaltonPermutations.Load<uint>(_16862 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13125 = g_ScrambledHaltonPermutations.Load<uint>(_16862 * 4 + 0) & 65535u;
	                }
	                uint _20584 = 24643u + ((_12091 / 523u) % 523u);
	                uint _16863 = _20584 / 2u;
	                uint _13130;
	                if ((_20584 & 1u) != 0u)
	                {
	                    _13130 = g_ScrambledHaltonPermutations.Load<uint>(_16863 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13130 = g_ScrambledHaltonPermutations.Load<uint>(_16863 * 4 + 0) & 65535u;
	                }
	                uint _20585 = 24643u + ((_12091 / 273529u) % 523u);
	                uint _16864 = _20585 / 2u;
	                uint _13133;
	                if ((_20585 & 1u) != 0u)
	                {
	                    _13133 = g_ScrambledHaltonPermutations.Load<uint>(_16864 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13133 = g_ScrambledHaltonPermutations.Load<uint>(_16864 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_13125 * 273529u) + (_13130 * 523u)) + _13133) * 6.9902852395387071737786754965782e-09f;
	                _19096 = true;
	                break;
	            }
	            case 99u:
	            {
	                uint _7319 = _12091 % 541u;
	                uint _16859 = (25166u + _7319) / 2u;
	                uint _13114;
	                if ((_7319 & 1u) != 0u)
	                {
	                    _13114 = g_ScrambledHaltonPermutations.Load<uint>(_16859 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13114 = g_ScrambledHaltonPermutations.Load<uint>(_16859 * 4 + 0) & 65535u;
	                }
	                uint _13116 = (_12091 / 541u) % 541u;
	                uint _16860 = (25166u + _13116) / 2u;
	                uint _13119;
	                if ((_13116 & 1u) != 0u)
	                {
	                    _13119 = g_ScrambledHaltonPermutations.Load<uint>(_16860 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13119 = g_ScrambledHaltonPermutations.Load<uint>(_16860 * 4 + 0) & 65535u;
	                }
	                uint _8865 = (_12091 / 292681u) % 541u;
	                uint _16861 = (25166u + _8865) / 2u;
	                uint _13122;
	                if ((_8865 & 1u) != 0u)
	                {
	                    _13122 = g_ScrambledHaltonPermutations.Load<uint>(_16861 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13122 = g_ScrambledHaltonPermutations.Load<uint>(_16861 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_13114 * 292681u) + (_13119 * 541u)) + _13122) * 6.3155063401154620805755257606506e-09f;
	                _19096 = true;
	                break;
	            }
	            case 100u:
	            {
	                uint _16003 = 25707u + (_12091 % 547u);
	                uint _16856 = _16003 / 2u;
	                uint _13103;
	                if ((_16003 & 1u) != 0u)
	                {
	                    _13103 = g_ScrambledHaltonPermutations.Load<uint>(_16856 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13103 = g_ScrambledHaltonPermutations.Load<uint>(_16856 * 4 + 0) & 65535u;
	                }
	                uint _20580 = 25707u + ((_12091 / 547u) % 547u);
	                uint _16857 = _20580 / 2u;
	                uint _13108;
	                if ((_20580 & 1u) != 0u)
	                {
	                    _13108 = g_ScrambledHaltonPermutations.Load<uint>(_16857 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13108 = g_ScrambledHaltonPermutations.Load<uint>(_16857 * 4 + 0) & 65535u;
	                }
	                uint _20581 = 25707u + ((_12091 / 299209u) % 547u);
	                uint _16858 = _20581 / 2u;
	                uint _13111;
	                if ((_20581 & 1u) != 0u)
	                {
	                    _13111 = g_ScrambledHaltonPermutations.Load<uint>(_16858 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13111 = g_ScrambledHaltonPermutations.Load<uint>(_16858 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_13103 * 299209u) + (_13108 * 547u)) + _13111) * 6.1099543202658423979301005601883e-09f;
	                _19096 = true;
	                break;
	            }
	            case 101u:
	            {
	                uint _7317 = _12091 % 557u;
	                uint _16853 = (26254u + _7317) / 2u;
	                uint _13092;
	                if ((_7317 & 1u) != 0u)
	                {
	                    _13092 = g_ScrambledHaltonPermutations.Load<uint>(_16853 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13092 = g_ScrambledHaltonPermutations.Load<uint>(_16853 * 4 + 0) & 65535u;
	                }
	                uint _13094 = (_12091 / 557u) % 557u;
	                uint _16854 = (26254u + _13094) / 2u;
	                uint _13097;
	                if ((_13094 & 1u) != 0u)
	                {
	                    _13097 = g_ScrambledHaltonPermutations.Load<uint>(_16854 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13097 = g_ScrambledHaltonPermutations.Load<uint>(_16854 * 4 + 0) & 65535u;
	                }
	                uint _8857 = (_12091 / 310249u) % 557u;
	                uint _16855 = (26254u + _8857) / 2u;
	                uint _13100;
	                if ((_8857 & 1u) != 0u)
	                {
	                    _13100 = g_ScrambledHaltonPermutations.Load<uint>(_16855 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13100 = g_ScrambledHaltonPermutations.Load<uint>(_16855 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_13092 * 310249u) + (_13097 * 557u)) + _13100) * 5.7867453051585471257567405700684e-09f;
	                _19096 = true;
	                break;
	            }
	            case 102u:
	            {
	                uint _15995 = 26811u + (_12091 % 563u);
	                uint _16850 = _15995 / 2u;
	                uint _13081;
	                if ((_15995 & 1u) != 0u)
	                {
	                    _13081 = g_ScrambledHaltonPermutations.Load<uint>(_16850 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13081 = g_ScrambledHaltonPermutations.Load<uint>(_16850 * 4 + 0) & 65535u;
	                }
	                uint _20576 = 26811u + ((_12091 / 563u) % 563u);
	                uint _16851 = _20576 / 2u;
	                uint _13086;
	                if ((_20576 & 1u) != 0u)
	                {
	                    _13086 = g_ScrambledHaltonPermutations.Load<uint>(_16851 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13086 = g_ScrambledHaltonPermutations.Load<uint>(_16851 * 4 + 0) & 65535u;
	                }
	                uint _20577 = 26811u + ((_12091 / 316969u) % 563u);
	                uint _16852 = _20577 / 2u;
	                uint _13089;
	                if ((_20577 & 1u) != 0u)
	                {
	                    _13089 = g_ScrambledHaltonPermutations.Load<uint>(_16852 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13089 = g_ScrambledHaltonPermutations.Load<uint>(_16852 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_13081 * 316969u) + (_13086 * 563u)) + _13089) * 5.6036983941964990663109347224236e-09f;
	                _19096 = true;
	                break;
	            }
	            case 103u:
	            {
	                uint _7314 = _12091 % 569u;
	                uint _16847 = (27374u + _7314) / 2u;
	                uint _13070;
	                if ((_7314 & 1u) != 0u)
	                {
	                    _13070 = g_ScrambledHaltonPermutations.Load<uint>(_16847 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13070 = g_ScrambledHaltonPermutations.Load<uint>(_16847 * 4 + 0) & 65535u;
	                }
	                uint _13072 = (_12091 / 569u) % 569u;
	                uint _16848 = (27374u + _13072) / 2u;
	                uint _13075;
	                if ((_13072 & 1u) != 0u)
	                {
	                    _13075 = g_ScrambledHaltonPermutations.Load<uint>(_16848 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13075 = g_ScrambledHaltonPermutations.Load<uint>(_16848 * 4 + 0) & 65535u;
	                }
	                uint _8849 = (_12091 / 323761u) % 569u;
	                uint _16849 = (27374u + _8849) / 2u;
	                uint _13078;
	                if ((_8849 & 1u) != 0u)
	                {
	                    _13078 = g_ScrambledHaltonPermutations.Load<uint>(_16849 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13078 = g_ScrambledHaltonPermutations.Load<uint>(_16849 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_13070 * 323761u) + (_13075 * 569u)) + _13078) * 5.4282911499115016340510919690132e-09f;
	                _19096 = true;
	                break;
	            }
	            case 104u:
	            {
	                uint _15987 = 27943u + (_12091 % 571u);
	                uint _16844 = _15987 / 2u;
	                uint _13059;
	                if ((_15987 & 1u) != 0u)
	                {
	                    _13059 = g_ScrambledHaltonPermutations.Load<uint>(_16844 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13059 = g_ScrambledHaltonPermutations.Load<uint>(_16844 * 4 + 0) & 65535u;
	                }
	                uint _20572 = 27943u + ((_12091 / 571u) % 571u);
	                uint _16845 = _20572 / 2u;
	                uint _13064;
	                if ((_20572 & 1u) != 0u)
	                {
	                    _13064 = g_ScrambledHaltonPermutations.Load<uint>(_16845 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13064 = g_ScrambledHaltonPermutations.Load<uint>(_16845 * 4 + 0) & 65535u;
	                }
	                uint _20573 = 27943u + ((_12091 / 326041u) % 571u);
	                uint _16846 = _20573 / 2u;
	                uint _13067;
	                if ((_20573 & 1u) != 0u)
	                {
	                    _13067 = g_ScrambledHaltonPermutations.Load<uint>(_16846 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13067 = g_ScrambledHaltonPermutations.Load<uint>(_16846 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_13059 * 326041u) + (_13064 * 571u)) + _13067) * 5.3714512837643724196823313832283e-09f;
	                _19096 = true;
	                break;
	            }
	            case 105u:
	            {
	                uint _7312 = _12091 % 577u;
	                uint _16841 = (28514u + _7312) / 2u;
	                uint _11991;
	                if ((_7312 & 1u) != 0u)
	                {
	                    _11991 = g_ScrambledHaltonPermutations.Load<uint>(_16841 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11991 = g_ScrambledHaltonPermutations.Load<uint>(_16841 * 4 + 0) & 65535u;
	                }
	                uint _11992 = (_12091 / 577u) % 577u;
	                uint _16842 = (28514u + _11992) / 2u;
	                uint _11993;
	                if ((_11992 & 1u) != 0u)
	                {
	                    _11993 = g_ScrambledHaltonPermutations.Load<uint>(_16842 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11993 = g_ScrambledHaltonPermutations.Load<uint>(_16842 * 4 + 0) & 65535u;
	                }
	                uint _8841 = (_12091 / 332929u) % 577u;
	                uint _16843 = (28514u + _8841) / 2u;
	                uint _13056;
	                if ((_8841 & 1u) != 0u)
	                {
	                    _13056 = g_ScrambledHaltonPermutations.Load<uint>(_16843 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _13056 = g_ScrambledHaltonPermutations.Load<uint>(_16843 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11991 * 332929u) + (_11993 * 577u)) + _13056) * 5.2056203792005817376775667071342e-09f;
	                _19096 = true;
	                break;
	            }
	            case 106u:
	            {
	                uint _15979 = 29091u + (_12091 % 587u);
	                uint _16838 = _15979 / 2u;
	                uint _11987;
	                if ((_15979 & 1u) != 0u)
	                {
	                    _11987 = g_ScrambledHaltonPermutations.Load<uint>(_16838 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11987 = g_ScrambledHaltonPermutations.Load<uint>(_16838 * 4 + 0) & 65535u;
	                }
	                uint _20568 = 29091u + ((_12091 / 587u) % 587u);
	                uint _16839 = _20568 / 2u;
	                uint _11989;
	                if ((_20568 & 1u) != 0u)
	                {
	                    _11989 = g_ScrambledHaltonPermutations.Load<uint>(_16839 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11989 = g_ScrambledHaltonPermutations.Load<uint>(_16839 * 4 + 0) & 65535u;
	                }
	                uint _20569 = 29091u + ((_12091 / 344569u) % 587u);
	                uint _16840 = _20569 / 2u;
	                uint _11990;
	                if ((_20569 & 1u) != 0u)
	                {
	                    _11990 = g_ScrambledHaltonPermutations.Load<uint>(_16840 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11990 = g_ScrambledHaltonPermutations.Load<uint>(_16840 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11987 * 344569u) + (_11989 * 587u)) + _11990) * 4.9440820326651646610116586089134e-09f;
	                _19096 = true;
	                break;
	            }
	            case 107u:
	            {
	                uint _7310 = _12091 % 593u;
	                uint _16835 = (29678u + _7310) / 2u;
	                uint _11983;
	                if ((_7310 & 1u) != 0u)
	                {
	                    _11983 = g_ScrambledHaltonPermutations.Load<uint>(_16835 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11983 = g_ScrambledHaltonPermutations.Load<uint>(_16835 * 4 + 0) & 65535u;
	                }
	                uint _11984 = (_12091 / 593u) % 593u;
	                uint _16836 = (29678u + _11984) / 2u;
	                uint _11985;
	                if ((_11984 & 1u) != 0u)
	                {
	                    _11985 = g_ScrambledHaltonPermutations.Load<uint>(_16836 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11985 = g_ScrambledHaltonPermutations.Load<uint>(_16836 * 4 + 0) & 65535u;
	                }
	                uint _8833 = (_12091 / 351649u) % 593u;
	                uint _16837 = (29678u + _8833) / 2u;
	                uint _11986;
	                if ((_8833 & 1u) != 0u)
	                {
	                    _11986 = g_ScrambledHaltonPermutations.Load<uint>(_16837 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11986 = g_ScrambledHaltonPermutations.Load<uint>(_16837 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11983 * 351649u) + (_11985 * 593u)) + _11986) * 4.7955217574724429141497239470482e-09f;
	                _19096 = true;
	                break;
	            }
	            case 108u:
	            {
	                uint _15971 = 30271u + (_12091 % 599u);
	                uint _16832 = _15971 / 2u;
	                uint _11979;
	                if ((_15971 & 1u) != 0u)
	                {
	                    _11979 = g_ScrambledHaltonPermutations.Load<uint>(_16832 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11979 = g_ScrambledHaltonPermutations.Load<uint>(_16832 * 4 + 0) & 65535u;
	                }
	                uint _20564 = 30271u + ((_12091 / 599u) % 599u);
	                uint _16833 = _20564 / 2u;
	                uint _11981;
	                if ((_20564 & 1u) != 0u)
	                {
	                    _11981 = g_ScrambledHaltonPermutations.Load<uint>(_16833 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11981 = g_ScrambledHaltonPermutations.Load<uint>(_16833 * 4 + 0) & 65535u;
	                }
	                uint _20565 = 30271u + ((_12091 / 358801u) % 599u);
	                uint _16834 = _20565 / 2u;
	                uint _11982;
	                if ((_20565 & 1u) != 0u)
	                {
	                    _11982 = g_ScrambledHaltonPermutations.Load<uint>(_16834 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11982 = g_ScrambledHaltonPermutations.Load<uint>(_16834 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11979 * 358801u) + (_11981 * 599u)) + _11982) * 4.6528545460944314982043579220772e-09f;
	                _19096 = true;
	                break;
	            }
	            case 109u:
	            {
	                uint _7308 = _12091 % 601u;
	                uint _16829 = (30870u + _7308) / 2u;
	                uint _11683;
	                if ((_7308 & 1u) != 0u)
	                {
	                    _11683 = g_ScrambledHaltonPermutations.Load<uint>(_16829 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11683 = g_ScrambledHaltonPermutations.Load<uint>(_16829 * 4 + 0) & 65535u;
	                }
	                uint _11977 = (_12091 / 601u) % 601u;
	                uint _16830 = (30870u + _11977) / 2u;
	                uint _11684;
	                if ((_11977 & 1u) != 0u)
	                {
	                    _11684 = g_ScrambledHaltonPermutations.Load<uint>(_16830 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11684 = g_ScrambledHaltonPermutations.Load<uint>(_16830 * 4 + 0) & 65535u;
	                }
	                uint _8825 = (_12091 / 361201u) % 601u;
	                uint _16831 = (30870u + _8825) / 2u;
	                uint _11978;
	                if ((_8825 & 1u) != 0u)
	                {
	                    _11978 = g_ScrambledHaltonPermutations.Load<uint>(_16831 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11978 = g_ScrambledHaltonPermutations.Load<uint>(_16831 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11683 * 361201u) + (_11684 * 601u)) + _11978) * 4.6065578018783526204060763120651e-09f;
	                _19096 = true;
	                break;
	            }
	            case 110u:
	            {
	                uint _15963 = 31471u + (_12091 % 607u);
	                uint _16826 = _15963 / 2u;
	                uint _11681;
	                if ((_15963 & 1u) != 0u)
	                {
	                    _11681 = g_ScrambledHaltonPermutations.Load<uint>(_16826 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11681 = g_ScrambledHaltonPermutations.Load<uint>(_16826 * 4 + 0) & 65535u;
	                }
	                uint _20560 = 31471u + ((_12091 / 607u) % 607u);
	                uint _16827 = _20560 / 2u;
	                uint _11682;
	                if ((_20560 & 1u) != 0u)
	                {
	                    _11682 = g_ScrambledHaltonPermutations.Load<uint>(_16827 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11682 = g_ScrambledHaltonPermutations.Load<uint>(_16827 * 4 + 0) & 65535u;
	                }
	                uint _20561 = 31471u + ((_12091 / 368449u) % 607u);
	                uint _16828 = _20561 / 2u;
	                uint _11976;
	                if ((_20561 & 1u) != 0u)
	                {
	                    _11976 = g_ScrambledHaltonPermutations.Load<uint>(_16828 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11976 = g_ScrambledHaltonPermutations.Load<uint>(_16828 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11681 * 368449u) + (_11682 * 607u)) + _11976) * 4.4713006630558993492741137742996e-09f;
	                _19096 = true;
	                break;
	            }
	            case 111u:
	            {
	                uint _7306 = _12091 % 613u;
	                uint _16823 = (32078u + _7306) / 2u;
	                uint _11679;
	                if ((_7306 & 1u) != 0u)
	                {
	                    _11679 = g_ScrambledHaltonPermutations.Load<uint>(_16823 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11679 = g_ScrambledHaltonPermutations.Load<uint>(_16823 * 4 + 0) & 65535u;
	                }
	                uint _11973 = (_12091 / 613u) % 613u;
	                uint _16824 = (32078u + _11973) / 2u;
	                uint _11680;
	                if ((_11973 & 1u) != 0u)
	                {
	                    _11680 = g_ScrambledHaltonPermutations.Load<uint>(_16824 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11680 = g_ScrambledHaltonPermutations.Load<uint>(_16824 * 4 + 0) & 65535u;
	                }
	                uint _8817 = (_12091 / 375769u) % 613u;
	                uint _16825 = (32078u + _8817) / 2u;
	                uint _11974;
	                if ((_8817 & 1u) != 0u)
	                {
	                    _11974 = g_ScrambledHaltonPermutations.Load<uint>(_16825 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11974 = g_ScrambledHaltonPermutations.Load<uint>(_16825 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11679 * 375769u) + (_11680 * 613u)) + _11974) * 4.3412873296233556175138801336288e-09f;
	                _19096 = true;
	                break;
	            }
	            case 112u:
	            {
	                uint _15955 = 32691u + (_12091 % 617u);
	                uint _16820 = _15955 / 2u;
	                uint _11677;
	                if ((_15955 & 1u) != 0u)
	                {
	                    _11677 = g_ScrambledHaltonPermutations.Load<uint>(_16820 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11677 = g_ScrambledHaltonPermutations.Load<uint>(_16820 * 4 + 0) & 65535u;
	                }
	                uint _20556 = 32691u + ((_12091 / 617u) % 617u);
	                uint _16821 = _20556 / 2u;
	                uint _11678;
	                if ((_20556 & 1u) != 0u)
	                {
	                    _11678 = g_ScrambledHaltonPermutations.Load<uint>(_16821 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11678 = g_ScrambledHaltonPermutations.Load<uint>(_16821 * 4 + 0) & 65535u;
	                }
	                uint _20557 = 32691u + ((_12091 / 380689u) % 617u);
	                uint _16822 = _20557 / 2u;
	                uint _11972;
	                if ((_20557 & 1u) != 0u)
	                {
	                    _11972 = g_ScrambledHaltonPermutations.Load<uint>(_16822 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11972 = g_ScrambledHaltonPermutations.Load<uint>(_16822 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11677 * 380689u) + (_11678 * 617u)) + _11972) * 4.2573997660610984894447028636932e-09f;
	                _19096 = true;
	                break;
	            }
	            case 113u:
	            {
	                uint _7304 = _12091 % 619u;
	                uint _16817 = (33308u + _7304) / 2u;
	                uint _11675;
	                if ((_7304 & 1u) != 0u)
	                {
	                    _11675 = g_ScrambledHaltonPermutations.Load<uint>(_16817 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11675 = g_ScrambledHaltonPermutations.Load<uint>(_16817 * 4 + 0) & 65535u;
	                }
	                uint _11969 = (_12091 / 619u) % 619u;
	                uint _16818 = (33308u + _11969) / 2u;
	                uint _11676;
	                if ((_11969 & 1u) != 0u)
	                {
	                    _11676 = g_ScrambledHaltonPermutations.Load<uint>(_16818 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11676 = g_ScrambledHaltonPermutations.Load<uint>(_16818 * 4 + 0) & 65535u;
	                }
	                uint _8809 = (_12091 / 383161u) % 619u;
	                uint _16819 = (33308u + _8809) / 2u;
	                uint _11970;
	                if ((_8809 & 1u) != 0u)
	                {
	                    _11970 = g_ScrambledHaltonPermutations.Load<uint>(_16819 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11970 = g_ScrambledHaltonPermutations.Load<uint>(_16819 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11675 * 383161u) + (_11676 * 619u)) + _11970) * 4.2162660029987364396220073103905e-09f;
	                _19096 = true;
	                break;
	            }
	            case 114u:
	            {
	                uint _15947 = 33927u + (_12091 % 631u);
	                uint _16814 = _15947 / 2u;
	                uint _11673;
	                if ((_15947 & 1u) != 0u)
	                {
	                    _11673 = g_ScrambledHaltonPermutations.Load<uint>(_16814 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11673 = g_ScrambledHaltonPermutations.Load<uint>(_16814 * 4 + 0) & 65535u;
	                }
	                uint _20552 = 33927u + ((_12091 / 631u) % 631u);
	                uint _16815 = _20552 / 2u;
	                uint _11674;
	                if ((_20552 & 1u) != 0u)
	                {
	                    _11674 = g_ScrambledHaltonPermutations.Load<uint>(_16815 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11674 = g_ScrambledHaltonPermutations.Load<uint>(_16815 * 4 + 0) & 65535u;
	                }
	                uint _20553 = 33927u + ((_12091 / 398161u) % 631u);
	                uint _16816 = _20553 / 2u;
	                uint _11968;
	                if ((_20553 & 1u) != 0u)
	                {
	                    _11968 = g_ScrambledHaltonPermutations.Load<uint>(_16816 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11968 = g_ScrambledHaltonPermutations.Load<uint>(_16816 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11673 * 398161u) + (_11674 * 631u)) + _11968) * 3.9802641182973275135736912488937e-09f;
	                _19096 = true;
	                break;
	            }
	            case 115u:
	            {
	                uint _7302 = _12091 % 641u;
	                uint _16811 = (34558u + _7302) / 2u;
	                uint _11671;
	                if ((_7302 & 1u) != 0u)
	                {
	                    _11671 = g_ScrambledHaltonPermutations.Load<uint>(_16811 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11671 = g_ScrambledHaltonPermutations.Load<uint>(_16811 * 4 + 0) & 65535u;
	                }
	                uint _11965 = (_12091 / 641u) % 641u;
	                uint _16812 = (34558u + _11965) / 2u;
	                uint _11672;
	                if ((_11965 & 1u) != 0u)
	                {
	                    _11672 = g_ScrambledHaltonPermutations.Load<uint>(_16812 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11672 = g_ScrambledHaltonPermutations.Load<uint>(_16812 * 4 + 0) & 65535u;
	                }
	                uint _8801 = (_12091 / 410881u) % 641u;
	                uint _16813 = (34558u + _8801) / 2u;
	                uint _11966;
	                if ((_8801 & 1u) != 0u)
	                {
	                    _11966 = g_ScrambledHaltonPermutations.Load<uint>(_16813 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11966 = g_ScrambledHaltonPermutations.Load<uint>(_16813 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11671 * 410881u) + (_11672 * 641u)) + _11966) * 3.7968712618408062553498893976212e-09f;
	                _19096 = true;
	                break;
	            }
	            case 116u:
	            {
	                uint _15939 = 35199u + (_12091 % 643u);
	                uint _16808 = _15939 / 2u;
	                uint _11669;
	                if ((_15939 & 1u) != 0u)
	                {
	                    _11669 = g_ScrambledHaltonPermutations.Load<uint>(_16808 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11669 = g_ScrambledHaltonPermutations.Load<uint>(_16808 * 4 + 0) & 65535u;
	                }
	                uint _20548 = 35199u + ((_12091 / 643u) % 643u);
	                uint _16809 = _20548 / 2u;
	                uint _11670;
	                if ((_20548 & 1u) != 0u)
	                {
	                    _11670 = g_ScrambledHaltonPermutations.Load<uint>(_16809 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11670 = g_ScrambledHaltonPermutations.Load<uint>(_16809 * 4 + 0) & 65535u;
	                }
	                uint _20549 = 35199u + ((_12091 / 413449u) % 643u);
	                uint _16810 = _20549 / 2u;
	                uint _11964;
	                if ((_20549 & 1u) != 0u)
	                {
	                    _11964 = g_ScrambledHaltonPermutations.Load<uint>(_16810 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11964 = g_ScrambledHaltonPermutations.Load<uint>(_16810 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11669 * 413449u) + (_11670 * 643u)) + _11964) * 3.7615515147138012252980843186378e-09f;
	                _19096 = true;
	                break;
	            }
	            case 117u:
	            {
	                uint _7300 = _12091 % 647u;
	                uint _16805 = (35842u + _7300) / 2u;
	                uint _11667;
	                if ((_7300 & 1u) != 0u)
	                {
	                    _11667 = g_ScrambledHaltonPermutations.Load<uint>(_16805 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11667 = g_ScrambledHaltonPermutations.Load<uint>(_16805 * 4 + 0) & 65535u;
	                }
	                uint _11961 = (_12091 / 647u) % 647u;
	                uint _16806 = (35842u + _11961) / 2u;
	                uint _11668;
	                if ((_11961 & 1u) != 0u)
	                {
	                    _11668 = g_ScrambledHaltonPermutations.Load<uint>(_16806 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11668 = g_ScrambledHaltonPermutations.Load<uint>(_16806 * 4 + 0) & 65535u;
	                }
	                uint _8793 = (_12091 / 418609u) % 647u;
	                uint _16807 = (35842u + _8793) / 2u;
	                uint _11962;
	                if ((_8793 & 1u) != 0u)
	                {
	                    _11962 = g_ScrambledHaltonPermutations.Load<uint>(_16807 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11962 = g_ScrambledHaltonPermutations.Load<uint>(_16807 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11667 * 418609u) + (_11668 * 647u)) + _11962) * 3.6922158663799109490355476737022e-09f;
	                _19096 = true;
	                break;
	            }
	            case 118u:
	            {
	                uint _15931 = 36489u + (_12091 % 653u);
	                uint _16802 = _15931 / 2u;
	                uint _11665;
	                if ((_15931 & 1u) != 0u)
	                {
	                    _11665 = g_ScrambledHaltonPermutations.Load<uint>(_16802 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11665 = g_ScrambledHaltonPermutations.Load<uint>(_16802 * 4 + 0) & 65535u;
	                }
	                uint _20544 = 36489u + ((_12091 / 653u) % 653u);
	                uint _16803 = _20544 / 2u;
	                uint _11666;
	                if ((_20544 & 1u) != 0u)
	                {
	                    _11666 = g_ScrambledHaltonPermutations.Load<uint>(_16803 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11666 = g_ScrambledHaltonPermutations.Load<uint>(_16803 * 4 + 0) & 65535u;
	                }
	                uint _20545 = 36489u + ((_12091 / 426409u) % 653u);
	                uint _16804 = _20545 / 2u;
	                uint _11960;
	                if ((_20545 & 1u) != 0u)
	                {
	                    _11960 = g_ScrambledHaltonPermutations.Load<uint>(_16804 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11960 = g_ScrambledHaltonPermutations.Load<uint>(_16804 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11665 * 426409u) + (_11666 * 653u)) + _11960) * 3.5913718665625538051244802772999e-09f;
	                _19096 = true;
	                break;
	            }
	            case 119u:
	            {
	                uint _7298 = _12091 % 659u;
	                uint _16799 = (37142u + _7298) / 2u;
	                uint _11663;
	                if ((_7298 & 1u) != 0u)
	                {
	                    _11663 = g_ScrambledHaltonPermutations.Load<uint>(_16799 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11663 = g_ScrambledHaltonPermutations.Load<uint>(_16799 * 4 + 0) & 65535u;
	                }
	                uint _11957 = (_12091 / 659u) % 659u;
	                uint _16800 = (37142u + _11957) / 2u;
	                uint _11664;
	                if ((_11957 & 1u) != 0u)
	                {
	                    _11664 = g_ScrambledHaltonPermutations.Load<uint>(_16800 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11664 = g_ScrambledHaltonPermutations.Load<uint>(_16800 * 4 + 0) & 65535u;
	                }
	                uint _8785 = (_12091 / 434281u) % 659u;
	                uint _16801 = (37142u + _8785) / 2u;
	                uint _11958;
	                if ((_8785 & 1u) != 0u)
	                {
	                    _11958 = g_ScrambledHaltonPermutations.Load<uint>(_16801 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11958 = g_ScrambledHaltonPermutations.Load<uint>(_16801 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11663 * 434281u) + (_11664 * 659u)) + _11958) * 3.4941673998645228493842296302319e-09f;
	                _19096 = true;
	                break;
	            }
	            case 120u:
	            {
	                uint _15923 = 37801u + (_12091 % 661u);
	                uint _16796 = _15923 / 2u;
	                uint _11661;
	                if ((_15923 & 1u) != 0u)
	                {
	                    _11661 = g_ScrambledHaltonPermutations.Load<uint>(_16796 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11661 = g_ScrambledHaltonPermutations.Load<uint>(_16796 * 4 + 0) & 65535u;
	                }
	                uint _20540 = 37801u + ((_12091 / 661u) % 661u);
	                uint _16797 = _20540 / 2u;
	                uint _11662;
	                if ((_20540 & 1u) != 0u)
	                {
	                    _11662 = g_ScrambledHaltonPermutations.Load<uint>(_16797 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11662 = g_ScrambledHaltonPermutations.Load<uint>(_16797 * 4 + 0) & 65535u;
	                }
	                uint _20541 = 37801u + ((_12091 / 436921u) % 661u);
	                uint _16798 = _20541 / 2u;
	                uint _11956;
	                if ((_20541 & 1u) != 0u)
	                {
	                    _11956 = g_ScrambledHaltonPermutations.Load<uint>(_16798 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11956 = g_ScrambledHaltonPermutations.Load<uint>(_16798 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11661 * 436921u) + (_11662 * 661u)) + _11956) * 3.4625462497217540658311918377876e-09f;
	                _19096 = true;
	                break;
	            }
	            case 121u:
	            {
	                uint _7296 = _12091 % 673u;
	                uint _16793 = (38462u + _7296) / 2u;
	                uint _11659;
	                if ((_7296 & 1u) != 0u)
	                {
	                    _11659 = g_ScrambledHaltonPermutations.Load<uint>(_16793 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11659 = g_ScrambledHaltonPermutations.Load<uint>(_16793 * 4 + 0) & 65535u;
	                }
	                uint _11953 = (_12091 / 673u) % 673u;
	                uint _16794 = (38462u + _11953) / 2u;
	                uint _11660;
	                if ((_11953 & 1u) != 0u)
	                {
	                    _11660 = g_ScrambledHaltonPermutations.Load<uint>(_16794 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11660 = g_ScrambledHaltonPermutations.Load<uint>(_16794 * 4 + 0) & 65535u;
	                }
	                uint _8777 = (_12091 / 452929u) % 673u;
	                uint _16795 = (38462u + _8777) / 2u;
	                uint _11954;
	                if ((_8777 & 1u) != 0u)
	                {
	                    _11954 = g_ScrambledHaltonPermutations.Load<uint>(_16795 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11954 = g_ScrambledHaltonPermutations.Load<uint>(_16795 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11659 * 452929u) + (_11660 * 673u)) + _11954) * 3.2806111160965656381449662148952e-09f;
	                _19096 = true;
	                break;
	            }
	            case 122u:
	            {
	                uint _15915 = 39135u + (_12091 % 677u);
	                uint _16790 = _15915 / 2u;
	                uint _11657;
	                if ((_15915 & 1u) != 0u)
	                {
	                    _11657 = g_ScrambledHaltonPermutations.Load<uint>(_16790 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11657 = g_ScrambledHaltonPermutations.Load<uint>(_16790 * 4 + 0) & 65535u;
	                }
	                uint _20536 = 39135u + ((_12091 / 677u) % 677u);
	                uint _16791 = _20536 / 2u;
	                uint _11658;
	                if ((_20536 & 1u) != 0u)
	                {
	                    _11658 = g_ScrambledHaltonPermutations.Load<uint>(_16791 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11658 = g_ScrambledHaltonPermutations.Load<uint>(_16791 * 4 + 0) & 65535u;
	                }
	                uint _20537 = 39135u + ((_12091 / 458329u) % 677u);
	                uint _16792 = _20537 / 2u;
	                uint _11952;
	                if ((_20537 & 1u) != 0u)
	                {
	                    _11952 = g_ScrambledHaltonPermutations.Load<uint>(_16792 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11952 = g_ScrambledHaltonPermutations.Load<uint>(_16792 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11657 * 458329u) + (_11658 * 677u)) + _11952) * 3.2228042456949879124294966459274e-09f;
	                _19096 = true;
	                break;
	            }
	            case 123u:
	            {
	                uint _7294 = _12091 % 683u;
	                uint _16787 = (39812u + _7294) / 2u;
	                uint _11655;
	                if ((_7294 & 1u) != 0u)
	                {
	                    _11655 = g_ScrambledHaltonPermutations.Load<uint>(_16787 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11655 = g_ScrambledHaltonPermutations.Load<uint>(_16787 * 4 + 0) & 65535u;
	                }
	                uint _11949 = (_12091 / 683u) % 683u;
	                uint _16788 = (39812u + _11949) / 2u;
	                uint _11656;
	                if ((_11949 & 1u) != 0u)
	                {
	                    _11656 = g_ScrambledHaltonPermutations.Load<uint>(_16788 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11656 = g_ScrambledHaltonPermutations.Load<uint>(_16788 * 4 + 0) & 65535u;
	                }
	                uint _8768 = (_12091 / 466489u) % 683u;
	                uint _16789 = (39812u + _8768) / 2u;
	                uint _11950;
	                if ((_8768 & 1u) != 0u)
	                {
	                    _11950 = g_ScrambledHaltonPermutations.Load<uint>(_16789 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11950 = g_ScrambledHaltonPermutations.Load<uint>(_16789 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11655 * 466489u) + (_11656 * 683u)) + _11950) * 3.1386133692024031915934756398201e-09f;
	                _19096 = true;
	                break;
	            }
	            case 124u:
	            {
	                uint _15907 = 40495u + (_12091 % 691u);
	                uint _16784 = _15907 / 2u;
	                uint _11653;
	                if ((_15907 & 1u) != 0u)
	                {
	                    _11653 = g_ScrambledHaltonPermutations.Load<uint>(_16784 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11653 = g_ScrambledHaltonPermutations.Load<uint>(_16784 * 4 + 0) & 65535u;
	                }
	                uint _20532 = 40495u + ((_12091 / 691u) % 691u);
	                uint _16785 = _20532 / 2u;
	                uint _11654;
	                if ((_20532 & 1u) != 0u)
	                {
	                    _11654 = g_ScrambledHaltonPermutations.Load<uint>(_16785 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11654 = g_ScrambledHaltonPermutations.Load<uint>(_16785 * 4 + 0) & 65535u;
	                }
	                uint _20533 = 40495u + ((_12091 / 477481u) % 691u);
	                uint _16786 = _20533 / 2u;
	                uint _11948;
	                if ((_20533 & 1u) != 0u)
	                {
	                    _11948 = g_ScrambledHaltonPermutations.Load<uint>(_16786 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11948 = g_ScrambledHaltonPermutations.Load<uint>(_16786 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11653 * 477481u) + (_11654 * 691u)) + _11948) * 3.0308595633243839984061196446419e-09f;
	                _19096 = true;
	                break;
	            }
	            case 125u:
	            {
	                uint _7292 = _12091 % 701u;
	                uint _16781 = (41186u + _7292) / 2u;
	                uint _11651;
	                if ((_7292 & 1u) != 0u)
	                {
	                    _11651 = g_ScrambledHaltonPermutations.Load<uint>(_16781 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11651 = g_ScrambledHaltonPermutations.Load<uint>(_16781 * 4 + 0) & 65535u;
	                }
	                uint _11945 = (_12091 / 701u) % 701u;
	                uint _16782 = (41186u + _11945) / 2u;
	                uint _11652;
	                if ((_11945 & 1u) != 0u)
	                {
	                    _11652 = g_ScrambledHaltonPermutations.Load<uint>(_16782 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11652 = g_ScrambledHaltonPermutations.Load<uint>(_16782 * 4 + 0) & 65535u;
	                }
	                uint _8760 = (_12091 / 491401u) % 701u;
	                uint _16783 = (41186u + _8760) / 2u;
	                uint _11946;
	                if ((_8760 & 1u) != 0u)
	                {
	                    _11946 = g_ScrambledHaltonPermutations.Load<uint>(_16783 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11946 = g_ScrambledHaltonPermutations.Load<uint>(_16783 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11651 * 491401u) + (_11652 * 701u)) + _11946) * 2.9029925130430456192698329687119e-09f;
	                _19096 = true;
	                break;
	            }
	            case 126u:
	            {
	                uint _15899 = 41887u + (_12091 % 709u);
	                uint _16778 = _15899 / 2u;
	                uint _11649;
	                if ((_15899 & 1u) != 0u)
	                {
	                    _11649 = g_ScrambledHaltonPermutations.Load<uint>(_16778 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11649 = g_ScrambledHaltonPermutations.Load<uint>(_16778 * 4 + 0) & 65535u;
	                }
	                uint _20528 = 41887u + ((_12091 / 709u) % 709u);
	                uint _16779 = _20528 / 2u;
	                uint _11650;
	                if ((_20528 & 1u) != 0u)
	                {
	                    _11650 = g_ScrambledHaltonPermutations.Load<uint>(_16779 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11650 = g_ScrambledHaltonPermutations.Load<uint>(_16779 * 4 + 0) & 65535u;
	                }
	                uint _20529 = 41887u + ((_12091 / 502681u) % 709u);
	                uint _16780 = _20529 / 2u;
	                uint _11944;
	                if ((_20529 & 1u) != 0u)
	                {
	                    _11944 = g_ScrambledHaltonPermutations.Load<uint>(_16780 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11944 = g_ScrambledHaltonPermutations.Load<uint>(_16780 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11649 * 502681u) + (_11650 * 709u)) + _11944) * 2.8058293466415307193528860807419e-09f;
	                _19096 = true;
	                break;
	            }
	            case 127u:
	            {
	                uint _7290 = _12091 % 719u;
	                uint _16775 = (42596u + _7290) / 2u;
	                uint _11647;
	                if ((_7290 & 1u) != 0u)
	                {
	                    _11647 = g_ScrambledHaltonPermutations.Load<uint>(_16775 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11647 = g_ScrambledHaltonPermutations.Load<uint>(_16775 * 4 + 0) & 65535u;
	                }
	                uint _11941 = (_12091 / 719u) % 719u;
	                uint _16776 = (42596u + _11941) / 2u;
	                uint _11648;
	                if ((_11941 & 1u) != 0u)
	                {
	                    _11648 = g_ScrambledHaltonPermutations.Load<uint>(_16776 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11648 = g_ScrambledHaltonPermutations.Load<uint>(_16776 * 4 + 0) & 65535u;
	                }
	                uint _8752 = (_12091 / 516961u) % 719u;
	                uint _16777 = (42596u + _8752) / 2u;
	                uint _11942;
	                if ((_8752 & 1u) != 0u)
	                {
	                    _11942 = g_ScrambledHaltonPermutations.Load<uint>(_16777 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11942 = g_ScrambledHaltonPermutations.Load<uint>(_16777 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11647 * 516961u) + (_11648 * 719u)) + _11942) * 2.6903779204445754658081568777561e-09f;
	                _19096 = true;
	                break;
	            }
	            case 128u:
	            {
	                uint _15891 = 43315u + (_12091 % 727u);
	                uint _16772 = _15891 / 2u;
	                uint _11645;
	                if ((_15891 & 1u) != 0u)
	                {
	                    _11645 = g_ScrambledHaltonPermutations.Load<uint>(_16772 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11645 = g_ScrambledHaltonPermutations.Load<uint>(_16772 * 4 + 0) & 65535u;
	                }
	                uint _20524 = 43315u + ((_12091 / 727u) % 727u);
	                uint _16773 = _20524 / 2u;
	                uint _11646;
	                if ((_20524 & 1u) != 0u)
	                {
	                    _11646 = g_ScrambledHaltonPermutations.Load<uint>(_16773 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11646 = g_ScrambledHaltonPermutations.Load<uint>(_16773 * 4 + 0) & 65535u;
	                }
	                uint _20525 = 43315u + ((_12091 / 528529u) % 727u);
	                uint _16774 = _20525 / 2u;
	                uint _11940;
	                if ((_20525 & 1u) != 0u)
	                {
	                    _11940 = g_ScrambledHaltonPermutations.Load<uint>(_16774 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11940 = g_ScrambledHaltonPermutations.Load<uint>(_16774 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11645 * 528529u) + (_11646 * 727u)) + _11940) * 2.6025359645132084551732987165451e-09f;
	                _19096 = true;
	                break;
	            }
	            case 129u:
	            {
	                uint _7288 = _12091 % 733u;
	                uint _16769 = (44042u + _7288) / 2u;
	                uint _11643;
	                if ((_7288 & 1u) != 0u)
	                {
	                    _11643 = g_ScrambledHaltonPermutations.Load<uint>(_16769 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11643 = g_ScrambledHaltonPermutations.Load<uint>(_16769 * 4 + 0) & 65535u;
	                }
	                uint _11937 = (_12091 / 733u) % 733u;
	                uint _16770 = (44042u + _11937) / 2u;
	                uint _11644;
	                if ((_11937 & 1u) != 0u)
	                {
	                    _11644 = g_ScrambledHaltonPermutations.Load<uint>(_16770 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11644 = g_ScrambledHaltonPermutations.Load<uint>(_16770 * 4 + 0) & 65535u;
	                }
	                uint _8744 = (_12091 / 537289u) % 733u;
	                uint _16771 = (44042u + _8744) / 2u;
	                uint _11938;
	                if ((_8744 & 1u) != 0u)
	                {
	                    _11938 = g_ScrambledHaltonPermutations.Load<uint>(_16771 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11938 = g_ScrambledHaltonPermutations.Load<uint>(_16771 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11643 * 537289u) + (_11644 * 733u)) + _11938) * 2.5391480029668400675291195511818e-09f;
	                _19096 = true;
	                break;
	            }
	            case 130u:
	            {
	                uint _15883 = 44775u + (_12091 % 739u);
	                uint _16766 = _15883 / 2u;
	                uint _11641;
	                if ((_15883 & 1u) != 0u)
	                {
	                    _11641 = g_ScrambledHaltonPermutations.Load<uint>(_16766 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11641 = g_ScrambledHaltonPermutations.Load<uint>(_16766 * 4 + 0) & 65535u;
	                }
	                uint _20520 = 44775u + ((_12091 / 739u) % 739u);
	                uint _16767 = _20520 / 2u;
	                uint _11642;
	                if ((_20520 & 1u) != 0u)
	                {
	                    _11642 = g_ScrambledHaltonPermutations.Load<uint>(_16767 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11642 = g_ScrambledHaltonPermutations.Load<uint>(_16767 * 4 + 0) & 65535u;
	                }
	                uint _20521 = 44775u + ((_12091 / 546121u) % 739u);
	                uint _16768 = _20521 / 2u;
	                uint _11936;
	                if ((_20521 & 1u) != 0u)
	                {
	                    _11936 = g_ScrambledHaltonPermutations.Load<uint>(_16768 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11936 = g_ScrambledHaltonPermutations.Load<uint>(_16768 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11641 * 546121u) + (_11642 * 739u)) + _11936) * 2.4778021856519671928253956139088e-09f;
	                _19096 = true;
	                break;
	            }
	            case 131u:
	            {
	                uint _7286 = _12091 % 743u;
	                uint _16763 = (45514u + _7286) / 2u;
	                uint _11639;
	                if ((_7286 & 1u) != 0u)
	                {
	                    _11639 = g_ScrambledHaltonPermutations.Load<uint>(_16763 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11639 = g_ScrambledHaltonPermutations.Load<uint>(_16763 * 4 + 0) & 65535u;
	                }
	                uint _11933 = (_12091 / 743u) % 743u;
	                uint _16764 = (45514u + _11933) / 2u;
	                uint _11640;
	                if ((_11933 & 1u) != 0u)
	                {
	                    _11640 = g_ScrambledHaltonPermutations.Load<uint>(_16764 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11640 = g_ScrambledHaltonPermutations.Load<uint>(_16764 * 4 + 0) & 65535u;
	                }
	                uint _8736 = (_12091 / 552049u) % 743u;
	                uint _16765 = (45514u + _8736) / 2u;
	                uint _11934;
	                if ((_8736 & 1u) != 0u)
	                {
	                    _11934 = g_ScrambledHaltonPermutations.Load<uint>(_16765 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11934 = g_ScrambledHaltonPermutations.Load<uint>(_16765 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11639 * 552049u) + (_11640 * 743u)) + _11934) * 2.437998913862315930600743740797e-09f;
	                _19096 = true;
	                break;
	            }
	            case 132u:
	            {
	                uint _15875 = 46257u + (_12091 % 751u);
	                uint _16760 = _15875 / 2u;
	                uint _11637;
	                if ((_15875 & 1u) != 0u)
	                {
	                    _11637 = g_ScrambledHaltonPermutations.Load<uint>(_16760 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11637 = g_ScrambledHaltonPermutations.Load<uint>(_16760 * 4 + 0) & 65535u;
	                }
	                uint _20516 = 46257u + ((_12091 / 751u) % 751u);
	                uint _16761 = _20516 / 2u;
	                uint _11638;
	                if ((_20516 & 1u) != 0u)
	                {
	                    _11638 = g_ScrambledHaltonPermutations.Load<uint>(_16761 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11638 = g_ScrambledHaltonPermutations.Load<uint>(_16761 * 4 + 0) & 65535u;
	                }
	                uint _20517 = 46257u + ((_12091 / 564001u) % 751u);
	                uint _16762 = _20517 / 2u;
	                uint _11932;
	                if ((_20517 & 1u) != 0u)
	                {
	                    _11932 = g_ScrambledHaltonPermutations.Load<uint>(_16762 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11932 = g_ScrambledHaltonPermutations.Load<uint>(_16762 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11637 * 564001u) + (_11638 * 751u)) + _11932) * 2.3609139088165420616860501468182e-09f;
	                _19096 = true;
	                break;
	            }
	            case 133u:
	            {
	                uint _7284 = _12091 % 757u;
	                uint _16757 = (47008u + _7284) / 2u;
	                uint _11635;
	                if ((_7284 & 1u) != 0u)
	                {
	                    _11635 = g_ScrambledHaltonPermutations.Load<uint>(_16757 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11635 = g_ScrambledHaltonPermutations.Load<uint>(_16757 * 4 + 0) & 65535u;
	                }
	                uint _11929 = (_12091 / 757u) % 757u;
	                uint _16758 = (47008u + _11929) / 2u;
	                uint _11636;
	                if ((_11929 & 1u) != 0u)
	                {
	                    _11636 = g_ScrambledHaltonPermutations.Load<uint>(_16758 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11636 = g_ScrambledHaltonPermutations.Load<uint>(_16758 * 4 + 0) & 65535u;
	                }
	                uint _8728 = (_12091 / 573049u) % 757u;
	                uint _16759 = (47008u + _8728) / 2u;
	                uint _11930;
	                if ((_8728 & 1u) != 0u)
	                {
	                    _11930 = g_ScrambledHaltonPermutations.Load<uint>(_16759 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11930 = g_ScrambledHaltonPermutations.Load<uint>(_16759 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11635 * 573049u) + (_11636 * 757u)) + _11930) * 2.3052197928308260088670067489147e-09f;
	                _19096 = true;
	                break;
	            }
	            case 134u:
	            {
	                uint _15867 = 47765u + (_12091 % 761u);
	                uint _16754 = _15867 / 2u;
	                uint _11633;
	                if ((_15867 & 1u) != 0u)
	                {
	                    _11633 = g_ScrambledHaltonPermutations.Load<uint>(_16754 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11633 = g_ScrambledHaltonPermutations.Load<uint>(_16754 * 4 + 0) & 65535u;
	                }
	                uint _20512 = 47765u + ((_12091 / 761u) % 761u);
	                uint _16755 = _20512 / 2u;
	                uint _11634;
	                if ((_20512 & 1u) != 0u)
	                {
	                    _11634 = g_ScrambledHaltonPermutations.Load<uint>(_16755 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11634 = g_ScrambledHaltonPermutations.Load<uint>(_16755 * 4 + 0) & 65535u;
	                }
	                uint _20513 = 47765u + ((_12091 / 579121u) % 761u);
	                uint _16756 = _20513 / 2u;
	                uint _11928;
	                if ((_20513 & 1u) != 0u)
	                {
	                    _11928 = g_ScrambledHaltonPermutations.Load<uint>(_16756 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11928 = g_ScrambledHaltonPermutations.Load<uint>(_16756 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11633 * 579121u) + (_11634 * 761u)) + _11928) * 2.2690600509633895853767171502113e-09f;
	                _19096 = true;
	                break;
	            }
	            case 135u:
	            {
	                uint _7282 = _12091 % 769u;
	                uint _16751 = (48526u + _7282) / 2u;
	                uint _11631;
	                if ((_7282 & 1u) != 0u)
	                {
	                    _11631 = g_ScrambledHaltonPermutations.Load<uint>(_16751 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11631 = g_ScrambledHaltonPermutations.Load<uint>(_16751 * 4 + 0) & 65535u;
	                }
	                uint _11925 = (_12091 / 769u) % 769u;
	                uint _16752 = (48526u + _11925) / 2u;
	                uint _11632;
	                if ((_11925 & 1u) != 0u)
	                {
	                    _11632 = g_ScrambledHaltonPermutations.Load<uint>(_16752 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11632 = g_ScrambledHaltonPermutations.Load<uint>(_16752 * 4 + 0) & 65535u;
	                }
	                uint _8720 = (_12091 / 591361u) % 769u;
	                uint _16753 = (48526u + _8720) / 2u;
	                uint _11926;
	                if ((_8720 & 1u) != 0u)
	                {
	                    _11926 = g_ScrambledHaltonPermutations.Load<uint>(_16753 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11926 = g_ScrambledHaltonPermutations.Load<uint>(_16753 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11631 * 591361u) + (_11632 * 769u)) + _11926) * 2.1989783327569512039190158247948e-09f;
	                _19096 = true;
	                break;
	            }
	            case 136u:
	            {
	                uint _15859 = 49295u + (_12091 % 773u);
	                uint _16748 = _15859 / 2u;
	                uint _11629;
	                if ((_15859 & 1u) != 0u)
	                {
	                    _11629 = g_ScrambledHaltonPermutations.Load<uint>(_16748 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11629 = g_ScrambledHaltonPermutations.Load<uint>(_16748 * 4 + 0) & 65535u;
	                }
	                uint _20508 = 49295u + ((_12091 / 773u) % 773u);
	                uint _16749 = _20508 / 2u;
	                uint _11630;
	                if ((_20508 & 1u) != 0u)
	                {
	                    _11630 = g_ScrambledHaltonPermutations.Load<uint>(_16749 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11630 = g_ScrambledHaltonPermutations.Load<uint>(_16749 * 4 + 0) & 65535u;
	                }
	                uint _20509 = 49295u + ((_12091 / 597529u) % 773u);
	                uint _16750 = _20509 / 2u;
	                uint _11924;
	                if ((_20509 & 1u) != 0u)
	                {
	                    _11924 = g_ScrambledHaltonPermutations.Load<uint>(_16750 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11924 = g_ScrambledHaltonPermutations.Load<uint>(_16750 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11629 * 597529u) + (_11630 * 773u)) + _11924) * 2.1650177206566922905039973556995e-09f;
	                _19096 = true;
	                break;
	            }
	            case 137u:
	            {
	                uint _7280 = _12091 % 787u;
	                uint _16745 = (50068u + _7280) / 2u;
	                uint _11627;
	                if ((_7280 & 1u) != 0u)
	                {
	                    _11627 = g_ScrambledHaltonPermutations.Load<uint>(_16745 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11627 = g_ScrambledHaltonPermutations.Load<uint>(_16745 * 4 + 0) & 65535u;
	                }
	                uint _11921 = (_12091 / 787u) % 787u;
	                uint _16746 = (50068u + _11921) / 2u;
	                uint _11628;
	                if ((_11921 & 1u) != 0u)
	                {
	                    _11628 = g_ScrambledHaltonPermutations.Load<uint>(_16746 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11628 = g_ScrambledHaltonPermutations.Load<uint>(_16746 * 4 + 0) & 65535u;
	                }
	                uint _8712 = (_12091 / 619369u) % 787u;
	                uint _16747 = (50068u + _8712) / 2u;
	                uint _11922;
	                if ((_8712 & 1u) != 0u)
	                {
	                    _11922 = g_ScrambledHaltonPermutations.Load<uint>(_16747 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11922 = g_ScrambledHaltonPermutations.Load<uint>(_16747 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11627 * 619369u) + (_11628 * 787u)) + _11922) * 2.0515200649384723874391056597233e-09f;
	                _19096 = true;
	                break;
	            }
	            case 138u:
	            {
	                uint _15851 = 50855u + (_12091 % 797u);
	                uint _16742 = _15851 / 2u;
	                uint _11625;
	                if ((_15851 & 1u) != 0u)
	                {
	                    _11625 = g_ScrambledHaltonPermutations.Load<uint>(_16742 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11625 = g_ScrambledHaltonPermutations.Load<uint>(_16742 * 4 + 0) & 65535u;
	                }
	                uint _20504 = 50855u + ((_12091 / 797u) % 797u);
	                uint _16743 = _20504 / 2u;
	                uint _11626;
	                if ((_20504 & 1u) != 0u)
	                {
	                    _11626 = g_ScrambledHaltonPermutations.Load<uint>(_16743 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11626 = g_ScrambledHaltonPermutations.Load<uint>(_16743 * 4 + 0) & 65535u;
	                }
	                uint _20505 = 50855u + ((_12091 / 635209u) % 797u);
	                uint _16744 = _20505 / 2u;
	                uint _11920;
	                if ((_20505 & 1u) != 0u)
	                {
	                    _11920 = g_ScrambledHaltonPermutations.Load<uint>(_16744 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11920 = g_ScrambledHaltonPermutations.Load<uint>(_16744 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11625 * 635209u) + (_11626 * 797u)) + _11920) * 1.9752632862690688853035680949688e-09f;
	                _19096 = true;
	                break;
	            }
	            case 139u:
	            {
	                uint _7278 = _12091 % 809u;
	                uint _16739 = (51652u + _7278) / 2u;
	                uint _11623;
	                if ((_7278 & 1u) != 0u)
	                {
	                    _11623 = g_ScrambledHaltonPermutations.Load<uint>(_16739 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11623 = g_ScrambledHaltonPermutations.Load<uint>(_16739 * 4 + 0) & 65535u;
	                }
	                uint _11917 = (_12091 / 809u) % 809u;
	                uint _16740 = (51652u + _11917) / 2u;
	                uint _11624;
	                if ((_11917 & 1u) != 0u)
	                {
	                    _11624 = g_ScrambledHaltonPermutations.Load<uint>(_16740 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11624 = g_ScrambledHaltonPermutations.Load<uint>(_16740 * 4 + 0) & 65535u;
	                }
	                uint _8704 = (_12091 / 654481u) % 809u;
	                uint _16741 = (51652u + _8704) / 2u;
	                uint _11918;
	                if ((_8704 & 1u) != 0u)
	                {
	                    _11918 = g_ScrambledHaltonPermutations.Load<uint>(_16741 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11918 = g_ScrambledHaltonPermutations.Load<uint>(_16741 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11623 * 654481u) + (_11624 * 809u)) + _11918) * 1.8886625596792327996809035539627e-09f;
	                _19096 = true;
	                break;
	            }
	            case 140u:
	            {
	                uint _15843 = 52461u + (_12091 % 811u);
	                uint _16736 = _15843 / 2u;
	                uint _11621;
	                if ((_15843 & 1u) != 0u)
	                {
	                    _11621 = g_ScrambledHaltonPermutations.Load<uint>(_16736 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11621 = g_ScrambledHaltonPermutations.Load<uint>(_16736 * 4 + 0) & 65535u;
	                }
	                uint _20500 = 52461u + ((_12091 / 811u) % 811u);
	                uint _16737 = _20500 / 2u;
	                uint _11622;
	                if ((_20500 & 1u) != 0u)
	                {
	                    _11622 = g_ScrambledHaltonPermutations.Load<uint>(_16737 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11622 = g_ScrambledHaltonPermutations.Load<uint>(_16737 * 4 + 0) & 65535u;
	                }
	                uint _20501 = 52461u + ((_12091 / 657721u) % 811u);
	                uint _16738 = _20501 / 2u;
	                uint _11916;
	                if ((_20501 & 1u) != 0u)
	                {
	                    _11916 = g_ScrambledHaltonPermutations.Load<uint>(_16738 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11916 = g_ScrambledHaltonPermutations.Load<uint>(_16738 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11621 * 657721u) + (_11622 * 811u)) + _11916) * 1.8747241536942738093785010278225e-09f;
	                _19096 = true;
	                break;
	            }
	            case 141u:
	            {
	                uint _7276 = _12091 % 821u;
	                uint _16733 = (53272u + _7276) / 2u;
	                uint _11619;
	                if ((_7276 & 1u) != 0u)
	                {
	                    _11619 = g_ScrambledHaltonPermutations.Load<uint>(_16733 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11619 = g_ScrambledHaltonPermutations.Load<uint>(_16733 * 4 + 0) & 65535u;
	                }
	                uint _11913 = (_12091 / 821u) % 821u;
	                uint _16734 = (53272u + _11913) / 2u;
	                uint _11620;
	                if ((_11913 & 1u) != 0u)
	                {
	                    _11620 = g_ScrambledHaltonPermutations.Load<uint>(_16734 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11620 = g_ScrambledHaltonPermutations.Load<uint>(_16734 * 4 + 0) & 65535u;
	                }
	                uint _8696 = (_12091 / 674041u) % 821u;
	                uint _16735 = (53272u + _8696) / 2u;
	                uint _11914;
	                if ((_8696 & 1u) != 0u)
	                {
	                    _11914 = g_ScrambledHaltonPermutations.Load<uint>(_16735 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11914 = g_ScrambledHaltonPermutations.Load<uint>(_16735 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11619 * 674041u) + (_11620 * 821u)) + _11914) * 1.8070512863843646300665568560362e-09f;
	                _19096 = true;
	                break;
	            }
	            case 142u:
	            {
	                uint _15835 = 54093u + (_12091 % 823u);
	                uint _16730 = _15835 / 2u;
	                uint _11618;
	                if ((_15835 & 1u) != 0u)
	                {
	                    _11618 = g_ScrambledHaltonPermutations.Load<uint>(_16730 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11618 = g_ScrambledHaltonPermutations.Load<uint>(_16730 * 4 + 0) & 65535u;
	                }
	                uint _20496 = 54093u + ((_12091 / 823u) % 823u);
	                uint _16731 = _20496 / 2u;
	                uint _11504;
	                if ((_20496 & 1u) != 0u)
	                {
	                    _11504 = g_ScrambledHaltonPermutations.Load<uint>(_16731 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11504 = g_ScrambledHaltonPermutations.Load<uint>(_16731 * 4 + 0) & 65535u;
	                }
	                uint _20497 = 54093u + ((_12091 / 677329u) % 823u);
	                uint _16732 = _20497 / 2u;
	                uint _11912;
	                if ((_20497 & 1u) != 0u)
	                {
	                    _11912 = g_ScrambledHaltonPermutations.Load<uint>(_16732 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11912 = g_ScrambledHaltonPermutations.Load<uint>(_16732 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11618 * 677329u) + (_11504 * 823u)) + _11912) * 1.7939090213303643395192921161652e-09f;
	                _19096 = true;
	                break;
	            }
	            case 143u:
	            {
	                uint _7274 = _12091 % 827u;
	                uint _16727 = (54916u + _7274) / 2u;
	                uint _11617;
	                if ((_7274 & 1u) != 0u)
	                {
	                    _11617 = g_ScrambledHaltonPermutations.Load<uint>(_16727 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11617 = g_ScrambledHaltonPermutations.Load<uint>(_16727 * 4 + 0) & 65535u;
	                }
	                uint _11909 = (_12091 / 827u) % 827u;
	                uint _16728 = (54916u + _11909) / 2u;
	                uint _11503;
	                if ((_11909 & 1u) != 0u)
	                {
	                    _11503 = g_ScrambledHaltonPermutations.Load<uint>(_16728 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11503 = g_ScrambledHaltonPermutations.Load<uint>(_16728 * 4 + 0) & 65535u;
	                }
	                uint _8688 = (_12091 / 683929u) % 827u;
	                uint _16729 = (54916u + _8688) / 2u;
	                uint _11910;
	                if ((_8688 & 1u) != 0u)
	                {
	                    _11910 = g_ScrambledHaltonPermutations.Load<uint>(_16729 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11910 = g_ScrambledHaltonPermutations.Load<uint>(_16729 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11617 * 683929u) + (_11503 * 827u)) + _11910) * 1.7680047426082978745398577302694e-09f;
	                _19096 = true;
	                break;
	            }
	            case 144u:
	            {
	                uint _15827 = 55743u + (_12091 % 829u);
	                uint _16724 = _15827 / 2u;
	                uint _11616;
	                if ((_15827 & 1u) != 0u)
	                {
	                    _11616 = g_ScrambledHaltonPermutations.Load<uint>(_16724 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11616 = g_ScrambledHaltonPermutations.Load<uint>(_16724 * 4 + 0) & 65535u;
	                }
	                uint _20492 = 55743u + ((_12091 / 829u) % 829u);
	                uint _16725 = _20492 / 2u;
	                uint _11502;
	                if ((_20492 & 1u) != 0u)
	                {
	                    _11502 = g_ScrambledHaltonPermutations.Load<uint>(_16725 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11502 = g_ScrambledHaltonPermutations.Load<uint>(_16725 * 4 + 0) & 65535u;
	                }
	                uint _20493 = 55743u + ((_12091 / 687241u) % 829u);
	                uint _16726 = _20493 / 2u;
	                uint _11908;
	                if ((_20493 & 1u) != 0u)
	                {
	                    _11908 = g_ScrambledHaltonPermutations.Load<uint>(_16726 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11908 = g_ScrambledHaltonPermutations.Load<uint>(_16726 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11616 * 687241u) + (_11502 * 829u)) + _11908) * 1.7552392872488553621224127709866e-09f;
	                _19096 = true;
	                break;
	            }
	            case 145u:
	            {
	                uint _7272 = _12091 % 839u;
	                uint _16721 = (56572u + _7272) / 2u;
	                uint _11615;
	                if ((_7272 & 1u) != 0u)
	                {
	                    _11615 = g_ScrambledHaltonPermutations.Load<uint>(_16721 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11615 = g_ScrambledHaltonPermutations.Load<uint>(_16721 * 4 + 0) & 65535u;
	                }
	                uint _11905 = (_12091 / 839u) % 839u;
	                uint _16722 = (56572u + _11905) / 2u;
	                uint _11501;
	                if ((_11905 & 1u) != 0u)
	                {
	                    _11501 = g_ScrambledHaltonPermutations.Load<uint>(_16722 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11501 = g_ScrambledHaltonPermutations.Load<uint>(_16722 * 4 + 0) & 65535u;
	                }
	                uint _8680 = (_12091 / 703921u) % 839u;
	                uint _16723 = (56572u + _8680) / 2u;
	                uint _11906;
	                if ((_8680 & 1u) != 0u)
	                {
	                    _11906 = g_ScrambledHaltonPermutations.Load<uint>(_16723 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11906 = g_ScrambledHaltonPermutations.Load<uint>(_16723 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11615 * 703921u) + (_11501 * 839u)) + _11906) * 1.6932226731825039678369648754597e-09f;
	                _19096 = true;
	                break;
	            }
	            case 146u:
	            {
	                uint _15819 = 57411u + (_12091 % 853u);
	                uint _16718 = _15819 / 2u;
	                uint _11614;
	                if ((_15819 & 1u) != 0u)
	                {
	                    _11614 = g_ScrambledHaltonPermutations.Load<uint>(_16718 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11614 = g_ScrambledHaltonPermutations.Load<uint>(_16718 * 4 + 0) & 65535u;
	                }
	                uint _20488 = 57411u + ((_12091 / 853u) % 853u);
	                uint _16719 = _20488 / 2u;
	                uint _11500;
	                if ((_20488 & 1u) != 0u)
	                {
	                    _11500 = g_ScrambledHaltonPermutations.Load<uint>(_16719 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11500 = g_ScrambledHaltonPermutations.Load<uint>(_16719 * 4 + 0) & 65535u;
	                }
	                uint _20489 = 57411u + ((_12091 / 727609u) % 853u);
	                uint _16720 = _20489 / 2u;
	                uint _11904;
	                if ((_20489 & 1u) != 0u)
	                {
	                    _11904 = g_ScrambledHaltonPermutations.Load<uint>(_16720 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11904 = g_ScrambledHaltonPermutations.Load<uint>(_16720 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11614 * 727609u) + (_11500 * 853u)) + _11904) * 1.611212607777190441993298009038e-09f;
	                _19096 = true;
	                break;
	            }
	            case 147u:
	            {
	                uint _7270 = _12091 % 857u;
	                uint _16715 = (58264u + _7270) / 2u;
	                uint _11613;
	                if ((_7270 & 1u) != 0u)
	                {
	                    _11613 = g_ScrambledHaltonPermutations.Load<uint>(_16715 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11613 = g_ScrambledHaltonPermutations.Load<uint>(_16715 * 4 + 0) & 65535u;
	                }
	                uint _11901 = (_12091 / 857u) % 857u;
	                uint _16716 = (58264u + _11901) / 2u;
	                uint _11499;
	                if ((_11901 & 1u) != 0u)
	                {
	                    _11499 = g_ScrambledHaltonPermutations.Load<uint>(_16716 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11499 = g_ScrambledHaltonPermutations.Load<uint>(_16716 * 4 + 0) & 65535u;
	                }
	                uint _8672 = (_12091 / 734449u) % 857u;
	                uint _16717 = (58264u + _8672) / 2u;
	                uint _11902;
	                if ((_8672 & 1u) != 0u)
	                {
	                    _11902 = g_ScrambledHaltonPermutations.Load<uint>(_16717 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11902 = g_ScrambledHaltonPermutations.Load<uint>(_16717 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11613 * 734449u) + (_11499 * 857u)) + _11902) * 1.5887570148365171007753815501928e-09f;
	                _19096 = true;
	                break;
	            }
	            case 148u:
	            {
	                uint _15811 = 59121u + (_12091 % 859u);
	                uint _16712 = _15811 / 2u;
	                uint _11612;
	                if ((_15811 & 1u) != 0u)
	                {
	                    _11612 = g_ScrambledHaltonPermutations.Load<uint>(_16712 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11612 = g_ScrambledHaltonPermutations.Load<uint>(_16712 * 4 + 0) & 65535u;
	                }
	                uint _20484 = 59121u + ((_12091 / 859u) % 859u);
	                uint _16713 = _20484 / 2u;
	                uint _11498;
	                if ((_20484 & 1u) != 0u)
	                {
	                    _11498 = g_ScrambledHaltonPermutations.Load<uint>(_16713 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11498 = g_ScrambledHaltonPermutations.Load<uint>(_16713 * 4 + 0) & 65535u;
	                }
	                uint _20485 = 59121u + ((_12091 / 737881u) % 859u);
	                uint _16714 = _20485 / 2u;
	                uint _11900;
	                if ((_20485 & 1u) != 0u)
	                {
	                    _11900 = g_ScrambledHaltonPermutations.Load<uint>(_16714 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11900 = g_ScrambledHaltonPermutations.Load<uint>(_16714 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11612 * 737881u) + (_11498 * 859u)) + _11900) * 1.5776855377680476522073149681091e-09f;
	                _19096 = true;
	                break;
	            }
	            case 149u:
	            {
	                uint _7268 = _12091 % 863u;
	                uint _16709 = (59980u + _7268) / 2u;
	                uint _11611;
	                if ((_7268 & 1u) != 0u)
	                {
	                    _11611 = g_ScrambledHaltonPermutations.Load<uint>(_16709 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11611 = g_ScrambledHaltonPermutations.Load<uint>(_16709 * 4 + 0) & 65535u;
	                }
	                uint _11897 = (_12091 / 863u) % 863u;
	                uint _16710 = (59980u + _11897) / 2u;
	                uint _11497;
	                if ((_11897 & 1u) != 0u)
	                {
	                    _11497 = g_ScrambledHaltonPermutations.Load<uint>(_16710 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11497 = g_ScrambledHaltonPermutations.Load<uint>(_16710 * 4 + 0) & 65535u;
	                }
	                uint _8664 = (_12091 / 744769u) % 863u;
	                uint _16711 = (59980u + _8664) / 2u;
	                uint _11898;
	                if ((_8664 & 1u) != 0u)
	                {
	                    _11898 = g_ScrambledHaltonPermutations.Load<uint>(_16711 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11898 = g_ScrambledHaltonPermutations.Load<uint>(_16711 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11611 * 744769u) + (_11497 * 863u)) + _11898) * 1.5558494492751151483389548957348e-09f;
	                _19096 = true;
	                break;
	            }
	            case 150u:
	            {
	                uint _15803 = 60843u + (_12091 % 877u);
	                uint _16706 = _15803 / 2u;
	                uint _11610;
	                if ((_15803 & 1u) != 0u)
	                {
	                    _11610 = g_ScrambledHaltonPermutations.Load<uint>(_16706 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11610 = g_ScrambledHaltonPermutations.Load<uint>(_16706 * 4 + 0) & 65535u;
	                }
	                uint _20480 = 60843u + ((_12091 / 877u) % 877u);
	                uint _16707 = _20480 / 2u;
	                uint _11496;
	                if ((_20480 & 1u) != 0u)
	                {
	                    _11496 = g_ScrambledHaltonPermutations.Load<uint>(_16707 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11496 = g_ScrambledHaltonPermutations.Load<uint>(_16707 * 4 + 0) & 65535u;
	                }
	                uint _20481 = 60843u + ((_12091 / 769129u) % 877u);
	                uint _16708 = _20481 / 2u;
	                uint _11896;
	                if ((_20481 & 1u) != 0u)
	                {
	                    _11896 = g_ScrambledHaltonPermutations.Load<uint>(_16708 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11896 = g_ScrambledHaltonPermutations.Load<uint>(_16708 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11610 * 769129u) + (_11496 * 877u)) + _11896) * 1.4825219940561851217353250831366e-09f;
	                _19096 = true;
	                break;
	            }
	            case 151u:
	            {
	                uint _7266 = _12091 % 881u;
	                uint _16703 = (61720u + _7266) / 2u;
	                uint _11609;
	                if ((_7266 & 1u) != 0u)
	                {
	                    _11609 = g_ScrambledHaltonPermutations.Load<uint>(_16703 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11609 = g_ScrambledHaltonPermutations.Load<uint>(_16703 * 4 + 0) & 65535u;
	                }
	                uint _11893 = (_12091 / 881u) % 881u;
	                uint _16704 = (61720u + _11893) / 2u;
	                uint _11495;
	                if ((_11893 & 1u) != 0u)
	                {
	                    _11495 = g_ScrambledHaltonPermutations.Load<uint>(_16704 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11495 = g_ScrambledHaltonPermutations.Load<uint>(_16704 * 4 + 0) & 65535u;
	                }
	                uint _8656 = (_12091 / 776161u) % 881u;
	                uint _16705 = (61720u + _8656) / 2u;
	                uint _11894;
	                if ((_8656 & 1u) != 0u)
	                {
	                    _11894 = g_ScrambledHaltonPermutations.Load<uint>(_16705 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11894 = g_ScrambledHaltonPermutations.Load<uint>(_16705 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11609 * 776161u) + (_11495 * 881u)) + _11894) * 1.4624204069946244999300688505173e-09f;
	                _19096 = true;
	                break;
	            }
	            case 152u:
	            {
	                uint _15795 = 62601u + (_12091 % 883u);
	                uint _16700 = _15795 / 2u;
	                uint _11608;
	                if ((_15795 & 1u) != 0u)
	                {
	                    _11608 = g_ScrambledHaltonPermutations.Load<uint>(_16700 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11608 = g_ScrambledHaltonPermutations.Load<uint>(_16700 * 4 + 0) & 65535u;
	                }
	                uint _20476 = 62601u + ((_12091 / 883u) % 883u);
	                uint _16701 = _20476 / 2u;
	                uint _11494;
	                if ((_20476 & 1u) != 0u)
	                {
	                    _11494 = g_ScrambledHaltonPermutations.Load<uint>(_16701 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11494 = g_ScrambledHaltonPermutations.Load<uint>(_16701 * 4 + 0) & 65535u;
	                }
	                uint _20477 = 62601u + ((_12091 / 779689u) % 883u);
	                uint _16702 = _20477 / 2u;
	                uint _11892;
	                if ((_20477 & 1u) != 0u)
	                {
	                    _11892 = g_ScrambledHaltonPermutations.Load<uint>(_16702 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11892 = g_ScrambledHaltonPermutations.Load<uint>(_16702 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11608 * 779689u) + (_11494 * 883u)) + _11892) * 1.4525056712955120019614696502686e-09f;
	                _19096 = true;
	                break;
	            }
	            case 153u:
	            {
	                uint _7264 = _12091 % 887u;
	                uint _16697 = (63484u + _7264) / 2u;
	                uint _11607;
	                if ((_7264 & 1u) != 0u)
	                {
	                    _11607 = g_ScrambledHaltonPermutations.Load<uint>(_16697 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11607 = g_ScrambledHaltonPermutations.Load<uint>(_16697 * 4 + 0) & 65535u;
	                }
	                uint _11889 = (_12091 / 887u) % 887u;
	                uint _16698 = (63484u + _11889) / 2u;
	                uint _11493;
	                if ((_11889 & 1u) != 0u)
	                {
	                    _11493 = g_ScrambledHaltonPermutations.Load<uint>(_16698 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11493 = g_ScrambledHaltonPermutations.Load<uint>(_16698 * 4 + 0) & 65535u;
	                }
	                uint _8648 = (_12091 / 786769u) % 887u;
	                uint _16699 = (63484u + _8648) / 2u;
	                uint _11890;
	                if ((_8648 & 1u) != 0u)
	                {
	                    _11890 = g_ScrambledHaltonPermutations.Load<uint>(_16699 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11890 = g_ScrambledHaltonPermutations.Load<uint>(_16699 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11607 * 786769u) + (_11493 * 887u)) + _11890) * 1.4329435416016167437192052602768e-09f;
	                _19096 = true;
	                break;
	            }
	            case 154u:
	            {
	                uint _15787 = 64371u + (_12091 % 907u);
	                uint _16693 = _15787 / 2u;
	                uint _11606;
	                if ((_15787 & 1u) != 0u)
	                {
	                    _11606 = g_ScrambledHaltonPermutations.Load<uint>(_16693 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11606 = g_ScrambledHaltonPermutations.Load<uint>(_16693 * 4 + 0) & 65535u;
	                }
	                uint _20472 = 64371u + ((_12091 / 907u) % 907u);
	                uint _16694 = _20472 / 2u;
	                uint _11492;
	                if ((_20472 & 1u) != 0u)
	                {
	                    _11492 = g_ScrambledHaltonPermutations.Load<uint>(_16694 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11492 = g_ScrambledHaltonPermutations.Load<uint>(_16694 * 4 + 0) & 65535u;
	                }
	                uint _20473 = 64371u + ((_12091 / 822649u) % 907u);
	                uint _16695 = _20473 / 2u;
	                uint _11888;
	                if ((_20473 & 1u) != 0u)
	                {
	                    _11888 = g_ScrambledHaltonPermutations.Load<uint>(_16695 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11888 = g_ScrambledHaltonPermutations.Load<uint>(_16695 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11606 * 822649u) + (_11492 * 907u)) + _11888) * 1.3402261522799108206527307629585e-09f;
	                _19096 = true;
	                break;
	            }
	            case 155u:
	            {
	                uint _7262 = _12091 % 911u;
	                uint _16690 = (65278u + _7262) / 2u;
	                uint _11605;
	                if ((_7262 & 1u) != 0u)
	                {
	                    _11605 = g_ScrambledHaltonPermutations.Load<uint>(_16690 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11605 = g_ScrambledHaltonPermutations.Load<uint>(_16690 * 4 + 0) & 65535u;
	                }
	                uint _11885 = (_12091 / 911u) % 911u;
	                uint _16691 = (65278u + _11885) / 2u;
	                uint _11491;
	                if ((_11885 & 1u) != 0u)
	                {
	                    _11491 = g_ScrambledHaltonPermutations.Load<uint>(_16691 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11491 = g_ScrambledHaltonPermutations.Load<uint>(_16691 * 4 + 0) & 65535u;
	                }
	                uint _8640 = (_12091 / 829921u) % 911u;
	                uint _16692 = (65278u + _8640) / 2u;
	                uint _11886;
	                if ((_8640 & 1u) != 0u)
	                {
	                    _11886 = g_ScrambledHaltonPermutations.Load<uint>(_16692 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11886 = g_ScrambledHaltonPermutations.Load<uint>(_16692 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11605 * 829921u) + (_11491 * 911u)) + _11886) * 1.3226496564655576548830140382051e-09f;
	                _19096 = true;
	                break;
	            }
	            case 156u:
	            {
	                uint _15779 = 66189u + (_12091 % 919u);
	                uint _16687 = _15779 / 2u;
	                uint _11604;
	                if ((_15779 & 1u) != 0u)
	                {
	                    _11604 = g_ScrambledHaltonPermutations.Load<uint>(_16687 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11604 = g_ScrambledHaltonPermutations.Load<uint>(_16687 * 4 + 0) & 65535u;
	                }
	                uint _20468 = 66189u + ((_12091 / 919u) % 919u);
	                uint _16688 = _20468 / 2u;
	                uint _11490;
	                if ((_20468 & 1u) != 0u)
	                {
	                    _11490 = g_ScrambledHaltonPermutations.Load<uint>(_16688 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11490 = g_ScrambledHaltonPermutations.Load<uint>(_16688 * 4 + 0) & 65535u;
	                }
	                uint _20469 = 66189u + ((_12091 / 844561u) % 919u);
	                uint _16689 = _20469 / 2u;
	                uint _11884;
	                if ((_20469 & 1u) != 0u)
	                {
	                    _11884 = g_ScrambledHaltonPermutations.Load<uint>(_16689 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11884 = g_ScrambledHaltonPermutations.Load<uint>(_16689 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11604 * 844561u) + (_11490 * 919u)) + _11884) * 1.2884080469177661143476143479347e-09f;
	                _19096 = true;
	                break;
	            }
	            case 157u:
	            {
	                uint _7260 = _12091 % 929u;
	                uint _16684 = (67108u + _7260) / 2u;
	                uint _11603;
	                if ((_7260 & 1u) != 0u)
	                {
	                    _11603 = g_ScrambledHaltonPermutations.Load<uint>(_16684 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11603 = g_ScrambledHaltonPermutations.Load<uint>(_16684 * 4 + 0) & 65535u;
	                }
	                uint _11881 = (_12091 / 929u) % 929u;
	                uint _16685 = (67108u + _11881) / 2u;
	                uint _11489;
	                if ((_11881 & 1u) != 0u)
	                {
	                    _11489 = g_ScrambledHaltonPermutations.Load<uint>(_16685 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11489 = g_ScrambledHaltonPermutations.Load<uint>(_16685 * 4 + 0) & 65535u;
	                }
	                uint _8632 = (_12091 / 863041u) % 929u;
	                uint _16686 = (67108u + _8632) / 2u;
	                uint _11882;
	                if ((_8632 & 1u) != 0u)
	                {
	                    _11882 = g_ScrambledHaltonPermutations.Load<uint>(_16686 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11882 = g_ScrambledHaltonPermutations.Load<uint>(_16686 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11603 * 863041u) + (_11489 * 929u)) + _11882) * 1.2472479715697204483149107545614e-09f;
	                _19096 = true;
	                break;
	            }
	            case 158u:
	            {
	                uint _15771 = 68037u + (_12091 % 937u);
	                uint _16681 = _15771 / 2u;
	                uint _11602;
	                if ((_15771 & 1u) != 0u)
	                {
	                    _11602 = g_ScrambledHaltonPermutations.Load<uint>(_16681 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11602 = g_ScrambledHaltonPermutations.Load<uint>(_16681 * 4 + 0) & 65535u;
	                }
	                uint _20464 = 68037u + ((_12091 / 937u) % 937u);
	                uint _16682 = _20464 / 2u;
	                uint _11488;
	                if ((_20464 & 1u) != 0u)
	                {
	                    _11488 = g_ScrambledHaltonPermutations.Load<uint>(_16682 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11488 = g_ScrambledHaltonPermutations.Load<uint>(_16682 * 4 + 0) & 65535u;
	                }
	                uint _20465 = 68037u + ((_12091 / 877969u) % 937u);
	                uint _16683 = _20465 / 2u;
	                uint _11880;
	                if ((_20465 & 1u) != 0u)
	                {
	                    _11880 = g_ScrambledHaltonPermutations.Load<uint>(_16683 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11880 = g_ScrambledHaltonPermutations.Load<uint>(_16683 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11602 * 877969u) + (_11488 * 937u)) + _11880) * 1.2155733086771647322166245430708e-09f;
	                _19096 = true;
	                break;
	            }
	            case 159u:
	            {
	                uint _7258 = _12091 % 941u;
	                uint _16678 = (68974u + _7258) / 2u;
	                uint _11601;
	                if ((_7258 & 1u) != 0u)
	                {
	                    _11601 = g_ScrambledHaltonPermutations.Load<uint>(_16678 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11601 = g_ScrambledHaltonPermutations.Load<uint>(_16678 * 4 + 0) & 65535u;
	                }
	                uint _11877 = (_12091 / 941u) % 941u;
	                uint _16679 = (68974u + _11877) / 2u;
	                uint _11487;
	                if ((_11877 & 1u) != 0u)
	                {
	                    _11487 = g_ScrambledHaltonPermutations.Load<uint>(_16679 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11487 = g_ScrambledHaltonPermutations.Load<uint>(_16679 * 4 + 0) & 65535u;
	                }
	                uint _8624 = (_12091 / 885481u) % 941u;
	                uint _16680 = (68974u + _8624) / 2u;
	                uint _11878;
	                if ((_8624 & 1u) != 0u)
	                {
	                    _11878 = g_ScrambledHaltonPermutations.Load<uint>(_16680 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11878 = g_ScrambledHaltonPermutations.Load<uint>(_16680 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11601 * 885481u) + (_11487 * 941u)) + _11878) * 1.200137655921196255803806707263e-09f;
	                _19096 = true;
	                break;
	            }
	            case 160u:
	            {
	                uint _15763 = 69915u + (_12091 % 947u);
	                uint _16675 = _15763 / 2u;
	                uint _11600;
	                if ((_15763 & 1u) != 0u)
	                {
	                    _11600 = g_ScrambledHaltonPermutations.Load<uint>(_16675 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11600 = g_ScrambledHaltonPermutations.Load<uint>(_16675 * 4 + 0) & 65535u;
	                }
	                uint _20460 = 69915u + ((_12091 / 947u) % 947u);
	                uint _16676 = _20460 / 2u;
	                uint _11486;
	                if ((_20460 & 1u) != 0u)
	                {
	                    _11486 = g_ScrambledHaltonPermutations.Load<uint>(_16676 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11486 = g_ScrambledHaltonPermutations.Load<uint>(_16676 * 4 + 0) & 65535u;
	                }
	                uint _20461 = 69915u + ((_12091 / 896809u) % 947u);
	                uint _16677 = _20461 / 2u;
	                uint _11876;
	                if ((_20461 & 1u) != 0u)
	                {
	                    _11876 = g_ScrambledHaltonPermutations.Load<uint>(_16677 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11876 = g_ScrambledHaltonPermutations.Load<uint>(_16677 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11600 * 896809u) + (_11486 * 947u)) + _11876) * 1.1774704544720293597492855042219e-09f;
	                _19096 = true;
	                break;
	            }
	            case 161u:
	            {
	                uint _7256 = _12091 % 953u;
	                uint _16672 = (70862u + _7256) / 2u;
	                uint _11599;
	                if ((_7256 & 1u) != 0u)
	                {
	                    _11599 = g_ScrambledHaltonPermutations.Load<uint>(_16672 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11599 = g_ScrambledHaltonPermutations.Load<uint>(_16672 * 4 + 0) & 65535u;
	                }
	                uint _11873 = (_12091 / 953u) % 953u;
	                uint _16673 = (70862u + _11873) / 2u;
	                uint _11485;
	                if ((_11873 & 1u) != 0u)
	                {
	                    _11485 = g_ScrambledHaltonPermutations.Load<uint>(_16673 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11485 = g_ScrambledHaltonPermutations.Load<uint>(_16673 * 4 + 0) & 65535u;
	                }
	                uint _8616 = (_12091 / 908209u) % 953u;
	                uint _16674 = (70862u + _8616) / 2u;
	                uint _11874;
	                if ((_8616 & 1u) != 0u)
	                {
	                    _11874 = g_ScrambledHaltonPermutations.Load<uint>(_16674 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11874 = g_ScrambledHaltonPermutations.Load<uint>(_16674 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11599 * 908209u) + (_11485 * 953u)) + _11874) * 1.1553703549438409936556126922369e-09f;
	                _19096 = true;
	                break;
	            }
	            case 162u:
	            {
	                uint _15755 = 71815u + (_12091 % 967u);
	                uint _16669 = _15755 / 2u;
	                uint _11598;
	                if ((_15755 & 1u) != 0u)
	                {
	                    _11598 = g_ScrambledHaltonPermutations.Load<uint>(_16669 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11598 = g_ScrambledHaltonPermutations.Load<uint>(_16669 * 4 + 0) & 65535u;
	                }
	                uint _20456 = 71815u + ((_12091 / 967u) % 967u);
	                uint _16670 = _20456 / 2u;
	                uint _11484;
	                if ((_20456 & 1u) != 0u)
	                {
	                    _11484 = g_ScrambledHaltonPermutations.Load<uint>(_16670 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11484 = g_ScrambledHaltonPermutations.Load<uint>(_16670 * 4 + 0) & 65535u;
	                }
	                uint _20457 = 71815u + ((_12091 / 935089u) % 967u);
	                uint _16671 = _20457 / 2u;
	                uint _11872;
	                if ((_20457 & 1u) != 0u)
	                {
	                    _11872 = g_ScrambledHaltonPermutations.Load<uint>(_16671 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11872 = g_ScrambledHaltonPermutations.Load<uint>(_16671 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11598 * 935089u) + (_11484 * 967u)) + _11872) * 1.1059119175982345950615126639605e-09f;
	                _19096 = true;
	                break;
	            }
	            case 163u:
	            {
	                uint _7254 = _12091 % 971u;
	                uint _16666 = (72782u + _7254) / 2u;
	                uint _11597;
	                if ((_7254 & 1u) != 0u)
	                {
	                    _11597 = g_ScrambledHaltonPermutations.Load<uint>(_16666 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11597 = g_ScrambledHaltonPermutations.Load<uint>(_16666 * 4 + 0) & 65535u;
	                }
	                uint _11777 = (_12091 / 971u) % 971u;
	                uint _16667 = (72782u + _11777) / 2u;
	                uint _11483;
	                if ((_11777 & 1u) != 0u)
	                {
	                    _11483 = g_ScrambledHaltonPermutations.Load<uint>(_16667 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11483 = g_ScrambledHaltonPermutations.Load<uint>(_16667 * 4 + 0) & 65535u;
	                }
	                uint _8608 = (_12091 / 942841u) % 971u;
	                uint _16668 = (72782u + _8608) / 2u;
	                uint _11871;
	                if ((_8608 & 1u) != 0u)
	                {
	                    _11871 = g_ScrambledHaltonPermutations.Load<uint>(_16668 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11871 = g_ScrambledHaltonPermutations.Load<uint>(_16668 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11597 * 942841u) + (_11483 * 971u)) + _11871) * 1.092300805360935100907227024436e-09f;
	                _19096 = true;
	                break;
	            }
	            case 164u:
	            {
	                uint _15747 = 73753u + (_12091 % 977u);
	                uint _16663 = _15747 / 2u;
	                uint _11596;
	                if ((_15747 & 1u) != 0u)
	                {
	                    _11596 = g_ScrambledHaltonPermutations.Load<uint>(_16663 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11596 = g_ScrambledHaltonPermutations.Load<uint>(_16663 * 4 + 0) & 65535u;
	                }
	                uint _20452 = 73753u + ((_12091 / 977u) % 977u);
	                uint _16664 = _20452 / 2u;
	                uint _11482;
	                if ((_20452 & 1u) != 0u)
	                {
	                    _11482 = g_ScrambledHaltonPermutations.Load<uint>(_16664 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11482 = g_ScrambledHaltonPermutations.Load<uint>(_16664 * 4 + 0) & 65535u;
	                }
	                uint _20453 = 73753u + ((_12091 / 954529u) % 977u);
	                uint _16665 = _20453 / 2u;
	                uint _11870;
	                if ((_20453 & 1u) != 0u)
	                {
	                    _11870 = g_ScrambledHaltonPermutations.Load<uint>(_16665 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11870 = g_ScrambledHaltonPermutations.Load<uint>(_16665 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11596 * 954529u) + (_11482 * 977u)) + _11870) * 1.072299915527707980800187215209e-09f;
	                _19096 = true;
	                break;
	            }
	            case 165u:
	            {
	                uint _7252 = _12091 % 983u;
	                uint _16660 = (74730u + _7252) / 2u;
	                uint _11595;
	                if ((_7252 & 1u) != 0u)
	                {
	                    _11595 = g_ScrambledHaltonPermutations.Load<uint>(_16660 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11595 = g_ScrambledHaltonPermutations.Load<uint>(_16660 * 4 + 0) & 65535u;
	                }
	                uint _11775 = (_12091 / 983u) % 983u;
	                uint _16661 = (74730u + _11775) / 2u;
	                uint _11481;
	                if ((_11775 & 1u) != 0u)
	                {
	                    _11481 = g_ScrambledHaltonPermutations.Load<uint>(_16661 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11481 = g_ScrambledHaltonPermutations.Load<uint>(_16661 * 4 + 0) & 65535u;
	                }
	                uint _8600 = (_12091 / 966289u) % 983u;
	                uint _16662 = (74730u + _8600) / 2u;
	                uint _11869;
	                if ((_8600 & 1u) != 0u)
	                {
	                    _11869 = g_ScrambledHaltonPermutations.Load<uint>(_16662 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11869 = g_ScrambledHaltonPermutations.Load<uint>(_16662 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11595 * 966289u) + (_11481 * 983u)) + _11869) * 1.0527843041785445166169665753841e-09f;
	                _19096 = true;
	                break;
	            }
	            case 166u:
	            {
	                uint _15744 = 75713u + (_12091 % 991u);
	                uint _16657 = _15744 / 2u;
	                uint _11594;
	                if ((_15744 & 1u) != 0u)
	                {
	                    _11594 = g_ScrambledHaltonPermutations.Load<uint>(_16657 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11594 = g_ScrambledHaltonPermutations.Load<uint>(_16657 * 4 + 0) & 65535u;
	                }
	                uint _20448 = 75713u + ((_12091 / 991u) % 991u);
	                uint _16658 = _20448 / 2u;
	                uint _11480;
	                if ((_20448 & 1u) != 0u)
	                {
	                    _11480 = g_ScrambledHaltonPermutations.Load<uint>(_16658 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11480 = g_ScrambledHaltonPermutations.Load<uint>(_16658 * 4 + 0) & 65535u;
	                }
	                uint _20449 = 75713u + ((_12091 / 982081u) % 991u);
	                uint _16659 = _20449 / 2u;
	                uint _11868;
	                if ((_20449 & 1u) != 0u)
	                {
	                    _11868 = g_ScrambledHaltonPermutations.Load<uint>(_16659 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11868 = g_ScrambledHaltonPermutations.Load<uint>(_16659 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11594 * 982081u) + (_11480 * 991u)) + _11868) * 1.0274933126552809881104622036219e-09f;
	                _19096 = true;
	                break;
	            }
	            case 167u:
	            {
	                uint _7250 = _12091 % 997u;
	                uint _16654 = (76704u + _7250) / 2u;
	                uint _11593;
	                if ((_7250 & 1u) != 0u)
	                {
	                    _11593 = g_ScrambledHaltonPermutations.Load<uint>(_16654 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11593 = g_ScrambledHaltonPermutations.Load<uint>(_16654 * 4 + 0) & 65535u;
	                }
	                uint _11773 = (_12091 / 997u) % 997u;
	                uint _16655 = (76704u + _11773) / 2u;
	                uint _11479;
	                if ((_11773 & 1u) != 0u)
	                {
	                    _11479 = g_ScrambledHaltonPermutations.Load<uint>(_16655 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11479 = g_ScrambledHaltonPermutations.Load<uint>(_16655 * 4 + 0) & 65535u;
	                }
	                uint _8592 = (_12091 / 994009u) % 997u;
	                uint _16656 = (76704u + _8592) / 2u;
	                uint _11867;
	                if ((_8592 & 1u) != 0u)
	                {
	                    _11867 = g_ScrambledHaltonPermutations.Load<uint>(_16656 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11867 = g_ScrambledHaltonPermutations.Load<uint>(_16656 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11593 * 994009u) + (_11479 * 997u)) + _11867) * 1.0090541735507940757088363170624e-09f;
	                _19096 = true;
	                break;
	            }
	            case 168u:
	            {
	                uint _15742 = 77701u + (_12091 % 1009u);
	                uint _16651 = _15742 / 2u;
	                uint _11592;
	                if ((_15742 & 1u) != 0u)
	                {
	                    _11592 = g_ScrambledHaltonPermutations.Load<uint>(_16651 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11592 = g_ScrambledHaltonPermutations.Load<uint>(_16651 * 4 + 0) & 65535u;
	                }
	                uint _20444 = 77701u + ((_12091 / 1009u) % 1009u);
	                uint _16652 = _20444 / 2u;
	                uint _11478;
	                if ((_20444 & 1u) != 0u)
	                {
	                    _11478 = g_ScrambledHaltonPermutations.Load<uint>(_16652 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11478 = g_ScrambledHaltonPermutations.Load<uint>(_16652 * 4 + 0) & 65535u;
	                }
	                uint _20445 = 77701u + ((_12091 / 1018081u) % 1009u);
	                uint _16653 = _20445 / 2u;
	                uint _11866;
	                if ((_20445 & 1u) != 0u)
	                {
	                    _11866 = g_ScrambledHaltonPermutations.Load<uint>(_16653 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11866 = g_ScrambledHaltonPermutations.Load<uint>(_16653 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11592 * 1018081u) + (_11478 * 1009u)) + _11866) * 9.7347874206121787210577167570591e-10f;
	                _19096 = true;
	                break;
	            }
	            case 169u:
	            {
	                uint _7248 = _12091 % 1013u;
	                uint _16648 = (78710u + _7248) / 2u;
	                uint _11591;
	                if ((_7248 & 1u) != 0u)
	                {
	                    _11591 = g_ScrambledHaltonPermutations.Load<uint>(_16648 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11591 = g_ScrambledHaltonPermutations.Load<uint>(_16648 * 4 + 0) & 65535u;
	                }
	                uint _11771 = (_12091 / 1013u) % 1013u;
	                uint _16649 = (78710u + _11771) / 2u;
	                uint _11477;
	                if ((_11771 & 1u) != 0u)
	                {
	                    _11477 = g_ScrambledHaltonPermutations.Load<uint>(_16649 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11477 = g_ScrambledHaltonPermutations.Load<uint>(_16649 * 4 + 0) & 65535u;
	                }
	                uint _8584 = (_12091 / 1026169u) % 1013u;
	                uint _16650 = (78710u + _8584) / 2u;
	                uint _11865;
	                if ((_8584 & 1u) != 0u)
	                {
	                    _11865 = g_ScrambledHaltonPermutations.Load<uint>(_16650 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11865 = g_ScrambledHaltonPermutations.Load<uint>(_16650 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11591 * 1026169u) + (_11477 * 1013u)) + _11865) * 9.6199237464844600253854878246784e-10f;
	                _19096 = true;
	                break;
	            }
	            case 170u:
	            {
	                uint _15740 = 79723u + (_12091 % 1019u);
	                uint _16645 = _15740 / 2u;
	                uint _11590;
	                if ((_15740 & 1u) != 0u)
	                {
	                    _11590 = g_ScrambledHaltonPermutations.Load<uint>(_16645 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11590 = g_ScrambledHaltonPermutations.Load<uint>(_16645 * 4 + 0) & 65535u;
	                }
	                uint _20440 = 79723u + ((_12091 / 1019u) % 1019u);
	                uint _16646 = _20440 / 2u;
	                uint _11476;
	                if ((_20440 & 1u) != 0u)
	                {
	                    _11476 = g_ScrambledHaltonPermutations.Load<uint>(_16646 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11476 = g_ScrambledHaltonPermutations.Load<uint>(_16646 * 4 + 0) & 65535u;
	                }
	                uint _20441 = 79723u + ((_12091 / 1038361u) % 1019u);
	                uint _16647 = _20441 / 2u;
	                uint _11864;
	                if ((_20441 & 1u) != 0u)
	                {
	                    _11864 = g_ScrambledHaltonPermutations.Load<uint>(_16647 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11864 = g_ScrambledHaltonPermutations.Load<uint>(_16647 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11590 * 1038361u) + (_11476 * 1019u)) + _11864) * 9.4509922110574962061946280300617e-10f;
	                _19096 = true;
	                break;
	            }
	            case 171u:
	            {
	                uint _7246 = _12091 % 1021u;
	                uint _16642 = (80742u + _7246) / 2u;
	                uint _11589;
	                if ((_7246 & 1u) != 0u)
	                {
	                    _11589 = g_ScrambledHaltonPermutations.Load<uint>(_16642 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11589 = g_ScrambledHaltonPermutations.Load<uint>(_16642 * 4 + 0) & 65535u;
	                }
	                uint _11769 = (_12091 / 1021u) % 1021u;
	                uint _16643 = (80742u + _11769) / 2u;
	                uint _11475;
	                if ((_11769 & 1u) != 0u)
	                {
	                    _11475 = g_ScrambledHaltonPermutations.Load<uint>(_16643 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11475 = g_ScrambledHaltonPermutations.Load<uint>(_16643 * 4 + 0) & 65535u;
	                }
	                uint _8576 = (_12091 / 1042441u) % 1021u;
	                uint _16644 = (80742u + _8576) / 2u;
	                uint _11863;
	                if ((_8576 & 1u) != 0u)
	                {
	                    _11863 = g_ScrambledHaltonPermutations.Load<uint>(_16644 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11863 = g_ScrambledHaltonPermutations.Load<uint>(_16644 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11589 * 1042441u) + (_11475 * 1021u)) + _11863) * 9.3955609958840113904443569481373e-10f;
	                _19096 = true;
	                break;
	            }
	            case 172u:
	            {
	                uint _15738 = 81763u + (_12091 % 1031u);
	                uint _16639 = _15738 / 2u;
	                uint _11588;
	                if ((_15738 & 1u) != 0u)
	                {
	                    _11588 = g_ScrambledHaltonPermutations.Load<uint>(_16639 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11588 = g_ScrambledHaltonPermutations.Load<uint>(_16639 * 4 + 0) & 65535u;
	                }
	                uint _20436 = 81763u + ((_12091 / 1031u) % 1031u);
	                uint _16640 = _20436 / 2u;
	                uint _11474;
	                if ((_20436 & 1u) != 0u)
	                {
	                    _11474 = g_ScrambledHaltonPermutations.Load<uint>(_16640 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11474 = g_ScrambledHaltonPermutations.Load<uint>(_16640 * 4 + 0) & 65535u;
	                }
	                uint _20437 = 81763u + ((_12091 / 1062961u) % 1031u);
	                uint _16641 = _20437 / 2u;
	                uint _11862;
	                if ((_20437 & 1u) != 0u)
	                {
	                    _11862 = g_ScrambledHaltonPermutations.Load<uint>(_16641 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11862 = g_ScrambledHaltonPermutations.Load<uint>(_16641 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11588 * 1062961u) + (_11474 * 1031u)) + _11862) * 9.1248120170916990900877863168716e-10f;
	                _19096 = true;
	                break;
	            }
	            case 173u:
	            {
	                uint _7244 = _12091 % 1033u;
	                uint _16636 = (82794u + _7244) / 2u;
	                uint _11587;
	                if ((_7244 & 1u) != 0u)
	                {
	                    _11587 = g_ScrambledHaltonPermutations.Load<uint>(_16636 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11587 = g_ScrambledHaltonPermutations.Load<uint>(_16636 * 4 + 0) & 65535u;
	                }
	                uint _11767 = (_12091 / 1033u) % 1033u;
	                uint _16637 = (82794u + _11767) / 2u;
	                uint _11473;
	                if ((_11767 & 1u) != 0u)
	                {
	                    _11473 = g_ScrambledHaltonPermutations.Load<uint>(_16637 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11473 = g_ScrambledHaltonPermutations.Load<uint>(_16637 * 4 + 0) & 65535u;
	                }
	                uint _8568 = (_12091 / 1067089u) % 1033u;
	                uint _16638 = (82794u + _8568) / 2u;
	                uint _11861;
	                if ((_8568 & 1u) != 0u)
	                {
	                    _11861 = g_ScrambledHaltonPermutations.Load<uint>(_16638 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11861 = g_ScrambledHaltonPermutations.Load<uint>(_16638 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11587 * 1067089u) + (_11473 * 1033u)) + _11861) * 9.0719148859719211941410321742296e-10f;
	                _19096 = true;
	                break;
	            }
	            case 174u:
	            {
	                uint _15736 = 83827u + (_12091 % 1039u);
	                uint _16633 = _15736 / 2u;
	                uint _11586;
	                if ((_15736 & 1u) != 0u)
	                {
	                    _11586 = g_ScrambledHaltonPermutations.Load<uint>(_16633 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11586 = g_ScrambledHaltonPermutations.Load<uint>(_16633 * 4 + 0) & 65535u;
	                }
	                uint _20432 = 83827u + ((_12091 / 1039u) % 1039u);
	                uint _16634 = _20432 / 2u;
	                uint _11472;
	                if ((_20432 & 1u) != 0u)
	                {
	                    _11472 = g_ScrambledHaltonPermutations.Load<uint>(_16634 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11472 = g_ScrambledHaltonPermutations.Load<uint>(_16634 * 4 + 0) & 65535u;
	                }
	                uint _20433 = 83827u + ((_12091 / 1079521u) % 1039u);
	                uint _16635 = _20433 / 2u;
	                uint _11860;
	                if ((_20433 & 1u) != 0u)
	                {
	                    _11860 = g_ScrambledHaltonPermutations.Load<uint>(_16635 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11860 = g_ScrambledHaltonPermutations.Load<uint>(_16635 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11586 * 1079521u) + (_11472 * 1039u)) + _11860) * 8.9156565463710535368591081351042e-10f;
	                _19096 = true;
	                break;
	            }
	            case 175u:
	            {
	                uint _7242 = _12091 % 1049u;
	                uint _16630 = (84866u + _7242) / 2u;
	                uint _11585;
	                if ((_7242 & 1u) != 0u)
	                {
	                    _11585 = g_ScrambledHaltonPermutations.Load<uint>(_16630 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11585 = g_ScrambledHaltonPermutations.Load<uint>(_16630 * 4 + 0) & 65535u;
	                }
	                uint _11765 = (_12091 / 1049u) % 1049u;
	                uint _16631 = (84866u + _11765) / 2u;
	                uint _11471;
	                if ((_11765 & 1u) != 0u)
	                {
	                    _11471 = g_ScrambledHaltonPermutations.Load<uint>(_16631 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11471 = g_ScrambledHaltonPermutations.Load<uint>(_16631 * 4 + 0) & 65535u;
	                }
	                uint _8560 = (_12091 / 1100401u) % 1049u;
	                uint _16632 = (84866u + _8560) / 2u;
	                uint _11859;
	                if ((_8560 & 1u) != 0u)
	                {
	                    _11859 = g_ScrambledHaltonPermutations.Load<uint>(_16632 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11859 = g_ScrambledHaltonPermutations.Load<uint>(_16632 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11585 * 1100401u) + (_11471 * 1049u)) + _11859) * 8.6631030127293229270435404032469e-10f;
	                _19096 = true;
	                break;
	            }
	            case 176u:
	            {
	                uint _15734 = 85915u + (_12091 % 1051u);
	                uint _16627 = _15734 / 2u;
	                uint _11584;
	                if ((_15734 & 1u) != 0u)
	                {
	                    _11584 = g_ScrambledHaltonPermutations.Load<uint>(_16627 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11584 = g_ScrambledHaltonPermutations.Load<uint>(_16627 * 4 + 0) & 65535u;
	                }
	                uint _20428 = 85915u + ((_12091 / 1051u) % 1051u);
	                uint _16628 = _20428 / 2u;
	                uint _11470;
	                if ((_20428 & 1u) != 0u)
	                {
	                    _11470 = g_ScrambledHaltonPermutations.Load<uint>(_16628 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11470 = g_ScrambledHaltonPermutations.Load<uint>(_16628 * 4 + 0) & 65535u;
	                }
	                uint _20429 = 85915u + ((_12091 / 1104601u) % 1051u);
	                uint _16629 = _20429 / 2u;
	                uint _11858;
	                if ((_20429 & 1u) != 0u)
	                {
	                    _11858 = g_ScrambledHaltonPermutations.Load<uint>(_16629 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11858 = g_ScrambledHaltonPermutations.Load<uint>(_16629 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11584 * 1104601u) + (_11470 * 1051u)) + _11858) * 8.6137408317199515295214951038361e-10f;
	                _19096 = true;
	                break;
	            }
	            case 177u:
	            {
	                uint _7240 = _12091 % 1061u;
	                uint _16624 = (86966u + _7240) / 2u;
	                uint _11583;
	                if ((_7240 & 1u) != 0u)
	                {
	                    _11583 = g_ScrambledHaltonPermutations.Load<uint>(_16624 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11583 = g_ScrambledHaltonPermutations.Load<uint>(_16624 * 4 + 0) & 65535u;
	                }
	                uint _11763 = (_12091 / 1061u) % 1061u;
	                uint _16625 = (86966u + _11763) / 2u;
	                uint _11469;
	                if ((_11763 & 1u) != 0u)
	                {
	                    _11469 = g_ScrambledHaltonPermutations.Load<uint>(_16625 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11469 = g_ScrambledHaltonPermutations.Load<uint>(_16625 * 4 + 0) & 65535u;
	                }
	                uint _8552 = (_12091 / 1125721u) % 1061u;
	                uint _16626 = (86966u + _8552) / 2u;
	                uint _11857;
	                if ((_8552 & 1u) != 0u)
	                {
	                    _11857 = g_ScrambledHaltonPermutations.Load<uint>(_16626 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11857 = g_ScrambledHaltonPermutations.Load<uint>(_16626 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11583 * 1125721u) + (_11469 * 1061u)) + _11857) * 8.3724732702350479485176037997007e-10f;
	                _19096 = true;
	                break;
	            }
	            case 178u:
	            {
	                uint _15732 = 88027u + (_12091 % 1063u);
	                uint _16621 = _15732 / 2u;
	                uint _11582;
	                if ((_15732 & 1u) != 0u)
	                {
	                    _11582 = g_ScrambledHaltonPermutations.Load<uint>(_16621 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11582 = g_ScrambledHaltonPermutations.Load<uint>(_16621 * 4 + 0) & 65535u;
	                }
	                uint _20424 = 88027u + ((_12091 / 1063u) % 1063u);
	                uint _16622 = _20424 / 2u;
	                uint _11468;
	                if ((_20424 & 1u) != 0u)
	                {
	                    _11468 = g_ScrambledHaltonPermutations.Load<uint>(_16622 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11468 = g_ScrambledHaltonPermutations.Load<uint>(_16622 * 4 + 0) & 65535u;
	                }
	                uint _20425 = 88027u + ((_12091 / 1129969u) % 1063u);
	                uint _16623 = _20425 / 2u;
	                uint _11856;
	                if ((_20425 & 1u) != 0u)
	                {
	                    _11856 = g_ScrambledHaltonPermutations.Load<uint>(_16623 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11856 = g_ScrambledHaltonPermutations.Load<uint>(_16623 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11582 * 1129969u) + (_11468 * 1063u)) + _11856) * 8.3253054450338481728977058082819e-10f;
	                _19096 = true;
	                break;
	            }
	            case 179u:
	            {
	                uint _7238 = _12091 % 1069u;
	                uint _16618 = (89090u + _7238) / 2u;
	                uint _11581;
	                if ((_7238 & 1u) != 0u)
	                {
	                    _11581 = g_ScrambledHaltonPermutations.Load<uint>(_16618 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11581 = g_ScrambledHaltonPermutations.Load<uint>(_16618 * 4 + 0) & 65535u;
	                }
	                uint _11761 = (_12091 / 1069u) % 1069u;
	                uint _16619 = (89090u + _11761) / 2u;
	                uint _11467;
	                if ((_11761 & 1u) != 0u)
	                {
	                    _11467 = g_ScrambledHaltonPermutations.Load<uint>(_16619 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11467 = g_ScrambledHaltonPermutations.Load<uint>(_16619 * 4 + 0) & 65535u;
	                }
	                uint _8544 = (_12091 / 1142761u) % 1069u;
	                uint _16620 = (89090u + _8544) / 2u;
	                uint _11855;
	                if ((_8544 & 1u) != 0u)
	                {
	                    _11855 = g_ScrambledHaltonPermutations.Load<uint>(_16620 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11855 = g_ScrambledHaltonPermutations.Load<uint>(_16620 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11581 * 1142761u) + (_11467 * 1069u)) + _11855) * 8.1859075073964504554169252514839e-10f;
	                _19096 = true;
	                break;
	            }
	            case 180u:
	            {
	                uint _15730 = 90159u + (_12091 % 1087u);
	                uint _16615 = _15730 / 2u;
	                uint _11580;
	                if ((_15730 & 1u) != 0u)
	                {
	                    _11580 = g_ScrambledHaltonPermutations.Load<uint>(_16615 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11580 = g_ScrambledHaltonPermutations.Load<uint>(_16615 * 4 + 0) & 65535u;
	                }
	                uint _20420 = 90159u + ((_12091 / 1087u) % 1087u);
	                uint _16616 = _20420 / 2u;
	                uint _11466;
	                if ((_20420 & 1u) != 0u)
	                {
	                    _11466 = g_ScrambledHaltonPermutations.Load<uint>(_16616 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11466 = g_ScrambledHaltonPermutations.Load<uint>(_16616 * 4 + 0) & 65535u;
	                }
	                uint _20421 = 90159u + ((_12091 / 1181569u) % 1087u);
	                uint _16617 = _20421 / 2u;
	                uint _11854;
	                if ((_20421 & 1u) != 0u)
	                {
	                    _11854 = g_ScrambledHaltonPermutations.Load<uint>(_16617 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11854 = g_ScrambledHaltonPermutations.Load<uint>(_16617 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11580 * 1181569u) + (_11466 * 1087u)) + _11854) * 7.7859452218831393111031502485275e-10f;
	                _19096 = true;
	                break;
	            }
	            case 181u:
	            {
	                uint _7236 = _12091 % 1091u;
	                uint _16612 = (91246u + _7236) / 2u;
	                uint _11579;
	                if ((_7236 & 1u) != 0u)
	                {
	                    _11579 = g_ScrambledHaltonPermutations.Load<uint>(_16612 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11579 = g_ScrambledHaltonPermutations.Load<uint>(_16612 * 4 + 0) & 65535u;
	                }
	                uint _11759 = (_12091 / 1091u) % 1091u;
	                uint _16613 = (91246u + _11759) / 2u;
	                uint _11465;
	                if ((_11759 & 1u) != 0u)
	                {
	                    _11465 = g_ScrambledHaltonPermutations.Load<uint>(_16613 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11465 = g_ScrambledHaltonPermutations.Load<uint>(_16613 * 4 + 0) & 65535u;
	                }
	                uint _8536 = (_12091 / 1190281u) % 1091u;
	                uint _16614 = (91246u + _8536) / 2u;
	                uint _11853;
	                if ((_8536 & 1u) != 0u)
	                {
	                    _11853 = g_ScrambledHaltonPermutations.Load<uint>(_16614 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11853 = g_ScrambledHaltonPermutations.Load<uint>(_16614 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11579 * 1190281u) + (_11465 * 1091u)) + _11853) * 7.7006195864370852177671622484922e-10f;
	                _19096 = true;
	                break;
	            }
	            case 182u:
	            {
	                uint _15728 = 92337u + (_12091 % 1093u);
	                uint _16609 = _15728 / 2u;
	                uint _11578;
	                if ((_15728 & 1u) != 0u)
	                {
	                    _11578 = g_ScrambledHaltonPermutations.Load<uint>(_16609 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11578 = g_ScrambledHaltonPermutations.Load<uint>(_16609 * 4 + 0) & 65535u;
	                }
	                uint _20416 = 92337u + ((_12091 / 1093u) % 1093u);
	                uint _16610 = _20416 / 2u;
	                uint _11464;
	                if ((_20416 & 1u) != 0u)
	                {
	                    _11464 = g_ScrambledHaltonPermutations.Load<uint>(_16610 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11464 = g_ScrambledHaltonPermutations.Load<uint>(_16610 * 4 + 0) & 65535u;
	                }
	                uint _20417 = 92337u + ((_12091 / 1194649u) % 1093u);
	                uint _16611 = _20417 / 2u;
	                uint _11852;
	                if ((_20417 & 1u) != 0u)
	                {
	                    _11852 = g_ScrambledHaltonPermutations.Load<uint>(_16611 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11852 = g_ScrambledHaltonPermutations.Load<uint>(_16611 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11578 * 1194649u) + (_11464 * 1093u)) + _11852) * 7.6584255603862061434483621269464e-10f;
	                _19096 = true;
	                break;
	            }
	            case 183u:
	            {
	                uint _7234 = _12091 % 1097u;
	                uint _16606 = (93430u + _7234) / 2u;
	                uint _11577;
	                if ((_7234 & 1u) != 0u)
	                {
	                    _11577 = g_ScrambledHaltonPermutations.Load<uint>(_16606 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11577 = g_ScrambledHaltonPermutations.Load<uint>(_16606 * 4 + 0) & 65535u;
	                }
	                uint _11757 = (_12091 / 1097u) % 1097u;
	                uint _16607 = (93430u + _11757) / 2u;
	                uint _11463;
	                if ((_11757 & 1u) != 0u)
	                {
	                    _11463 = g_ScrambledHaltonPermutations.Load<uint>(_16607 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11463 = g_ScrambledHaltonPermutations.Load<uint>(_16607 * 4 + 0) & 65535u;
	                }
	                uint _8531 = (_12091 / 1203409u) % 1097u;
	                uint _16608 = (93430u + _8531) / 2u;
	                uint _11851;
	                if ((_8531 & 1u) != 0u)
	                {
	                    _11851 = g_ScrambledHaltonPermutations.Load<uint>(_16608 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11851 = g_ScrambledHaltonPermutations.Load<uint>(_16608 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11577 * 1203409u) + (_11463 * 1097u)) + _11851) * 7.5749551076143006866914220154285e-10f;
	                _19096 = true;
	                break;
	            }
	            case 184u:
	            {
	                uint _15726 = 94527u + (_12091 % 1103u);
	                uint _16603 = _15726 / 2u;
	                uint _11576;
	                if ((_15726 & 1u) != 0u)
	                {
	                    _11576 = g_ScrambledHaltonPermutations.Load<uint>(_16603 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11576 = g_ScrambledHaltonPermutations.Load<uint>(_16603 * 4 + 0) & 65535u;
	                }
	                uint _20412 = 94527u + ((_12091 / 1103u) % 1103u);
	                uint _16604 = _20412 / 2u;
	                uint _11462;
	                if ((_20412 & 1u) != 0u)
	                {
	                    _11462 = g_ScrambledHaltonPermutations.Load<uint>(_16604 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11462 = g_ScrambledHaltonPermutations.Load<uint>(_16604 * 4 + 0) & 65535u;
	                }
	                uint _20413 = 94527u + ((_12091 / 1216609u) % 1103u);
	                uint _16605 = _20413 / 2u;
	                uint _11850;
	                if ((_20413 & 1u) != 0u)
	                {
	                    _11850 = g_ScrambledHaltonPermutations.Load<uint>(_16605 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11850 = g_ScrambledHaltonPermutations.Load<uint>(_16605 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11576 * 1216609u) + (_11462 * 1103u)) + _11850) * 7.45200956497882316398317925632e-10f;
	                _19096 = true;
	                break;
	            }
	            case 185u:
	            {
	                uint _7232 = _12091 % 1109u;
	                uint _16600 = (95630u + _7232) / 2u;
	                uint _11575;
	                if ((_7232 & 1u) != 0u)
	                {
	                    _11575 = g_ScrambledHaltonPermutations.Load<uint>(_16600 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11575 = g_ScrambledHaltonPermutations.Load<uint>(_16600 * 4 + 0) & 65535u;
	                }
	                uint _11755 = (_12091 / 1109u) % 1109u;
	                uint _16601 = (95630u + _11755) / 2u;
	                uint _11461;
	                if ((_11755 & 1u) != 0u)
	                {
	                    _11461 = g_ScrambledHaltonPermutations.Load<uint>(_16601 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11461 = g_ScrambledHaltonPermutations.Load<uint>(_16601 * 4 + 0) & 65535u;
	                }
	                uint _8529 = (_12091 / 1229881u) % 1109u;
	                uint _16602 = (95630u + _8529) / 2u;
	                uint _11849;
	                if ((_8529 & 1u) != 0u)
	                {
	                    _11849 = g_ScrambledHaltonPermutations.Load<uint>(_16602 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11849 = g_ScrambledHaltonPermutations.Load<uint>(_16602 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11575 * 1229881u) + (_11461 * 1109u)) + _11849) * 7.3317102389225397018890362232924e-10f;
	                _19096 = true;
	                break;
	            }
	            case 186u:
	            {
	                uint _15724 = 96739u + (_12091 % 1117u);
	                uint _16597 = _15724 / 2u;
	                uint _11574;
	                if ((_15724 & 1u) != 0u)
	                {
	                    _11574 = g_ScrambledHaltonPermutations.Load<uint>(_16597 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11574 = g_ScrambledHaltonPermutations.Load<uint>(_16597 * 4 + 0) & 65535u;
	                }
	                uint _20408 = 96739u + ((_12091 / 1117u) % 1117u);
	                uint _16598 = _20408 / 2u;
	                uint _11460;
	                if ((_20408 & 1u) != 0u)
	                {
	                    _11460 = g_ScrambledHaltonPermutations.Load<uint>(_16598 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11460 = g_ScrambledHaltonPermutations.Load<uint>(_16598 * 4 + 0) & 65535u;
	                }
	                uint _20409 = 96739u + ((_12091 / 1247689u) % 1117u);
	                uint _16599 = _20409 / 2u;
	                uint _11848;
	                if ((_20409 & 1u) != 0u)
	                {
	                    _11848 = g_ScrambledHaltonPermutations.Load<uint>(_16599 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11848 = g_ScrambledHaltonPermutations.Load<uint>(_16599 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11574 * 1247689u) + (_11460 * 1117u)) + _11848) * 7.1753059049939338365220464766026e-10f;
	                _19096 = true;
	                break;
	            }
	            case 187u:
	            {
	                uint _7230 = _12091 % 1123u;
	                uint _16594 = (97856u + _7230) / 2u;
	                uint _11573;
	                if ((_7230 & 1u) != 0u)
	                {
	                    _11573 = g_ScrambledHaltonPermutations.Load<uint>(_16594 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11573 = g_ScrambledHaltonPermutations.Load<uint>(_16594 * 4 + 0) & 65535u;
	                }
	                uint _11753 = (_12091 / 1123u) % 1123u;
	                uint _16595 = (97856u + _11753) / 2u;
	                uint _11459;
	                if ((_11753 & 1u) != 0u)
	                {
	                    _11459 = g_ScrambledHaltonPermutations.Load<uint>(_16595 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11459 = g_ScrambledHaltonPermutations.Load<uint>(_16595 * 4 + 0) & 65535u;
	                }
	                uint _8527 = (_12091 / 1261129u) % 1123u;
	                uint _16596 = (97856u + _8527) / 2u;
	                uint _11847;
	                if ((_8527 & 1u) != 0u)
	                {
	                    _11847 = g_ScrambledHaltonPermutations.Load<uint>(_16596 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11847 = g_ScrambledHaltonPermutations.Load<uint>(_16596 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11573 * 1261129u) + (_11459 * 1123u)) + _11847) * 7.06091018987109464433160610497e-10f;
	                _19096 = true;
	                break;
	            }
	            case 188u:
	            {
	                uint _15722 = 98979u + (_12091 % 1129u);
	                uint _16591 = _15722 / 2u;
	                uint _11572;
	                if ((_15722 & 1u) != 0u)
	                {
	                    _11572 = g_ScrambledHaltonPermutations.Load<uint>(_16591 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11572 = g_ScrambledHaltonPermutations.Load<uint>(_16591 * 4 + 0) & 65535u;
	                }
	                uint _20404 = 98979u + ((_12091 / 1129u) % 1129u);
	                uint _16592 = _20404 / 2u;
	                uint _11458;
	                if ((_20404 & 1u) != 0u)
	                {
	                    _11458 = g_ScrambledHaltonPermutations.Load<uint>(_16592 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11458 = g_ScrambledHaltonPermutations.Load<uint>(_16592 * 4 + 0) & 65535u;
	                }
	                uint _20405 = 98979u + ((_12091 / 1274641u) % 1129u);
	                uint _16593 = _20405 / 2u;
	                uint _11846;
	                if ((_20405 & 1u) != 0u)
	                {
	                    _11846 = g_ScrambledHaltonPermutations.Load<uint>(_16593 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11846 = g_ScrambledHaltonPermutations.Load<uint>(_16593 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11572 * 1274641u) + (_11458 * 1129u)) + _11846) * 6.9489330956074013556644786149263e-10f;
	                _19096 = true;
	                break;
	            }
	            case 189u:
	            {
	                uint _7228 = _12091 % 1151u;
	                uint _16588 = (100108u + _7228) / 2u;
	                uint _11571;
	                if ((_7228 & 1u) != 0u)
	                {
	                    _11571 = g_ScrambledHaltonPermutations.Load<uint>(_16588 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11571 = g_ScrambledHaltonPermutations.Load<uint>(_16588 * 4 + 0) & 65535u;
	                }
	                uint _11751 = (_12091 / 1151u) % 1151u;
	                uint _16589 = (100108u + _11751) / 2u;
	                uint _11457;
	                if ((_11751 & 1u) != 0u)
	                {
	                    _11457 = g_ScrambledHaltonPermutations.Load<uint>(_16589 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11457 = g_ScrambledHaltonPermutations.Load<uint>(_16589 * 4 + 0) & 65535u;
	                }
	                uint _8525 = (_12091 / 1324801u) % 1151u;
	                uint _16590 = (100108u + _8525) / 2u;
	                uint _11845;
	                if ((_8525 & 1u) != 0u)
	                {
	                    _11845 = g_ScrambledHaltonPermutations.Load<uint>(_16590 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11845 = g_ScrambledHaltonPermutations.Load<uint>(_16590 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11571 * 1324801u) + (_11457 * 1151u)) + _11845) * 6.5580385566477161773946136236191e-10f;
	                _19096 = true;
	                break;
	            }
	            case 190u:
	            {
	                uint _15720 = 101259u + (_12091 % 1153u);
	                uint _16585 = _15720 / 2u;
	                uint _11570;
	                if ((_15720 & 1u) != 0u)
	                {
	                    _11570 = g_ScrambledHaltonPermutations.Load<uint>(_16585 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11570 = g_ScrambledHaltonPermutations.Load<uint>(_16585 * 4 + 0) & 65535u;
	                }
	                uint _20400 = 101259u + ((_12091 / 1153u) % 1153u);
	                uint _16586 = _20400 / 2u;
	                uint _11456;
	                if ((_20400 & 1u) != 0u)
	                {
	                    _11456 = g_ScrambledHaltonPermutations.Load<uint>(_16586 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11456 = g_ScrambledHaltonPermutations.Load<uint>(_16586 * 4 + 0) & 65535u;
	                }
	                uint _20401 = 101259u + ((_12091 / 1329409u) % 1153u);
	                uint _16587 = _20401 / 2u;
	                uint _11844;
	                if ((_20401 & 1u) != 0u)
	                {
	                    _11844 = g_ScrambledHaltonPermutations.Load<uint>(_16587 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11844 = g_ScrambledHaltonPermutations.Load<uint>(_16587 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11570 * 1329409u) + (_11456 * 1153u)) + _11844) * 6.5239708080255809363734442740679e-10f;
	                _19096 = true;
	                break;
	            }
	            case 191u:
	            {
	                uint _7226 = _12091 % 1163u;
	                uint _16582 = (102412u + _7226) / 2u;
	                uint _11569;
	                if ((_7226 & 1u) != 0u)
	                {
	                    _11569 = g_ScrambledHaltonPermutations.Load<uint>(_16582 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11569 = g_ScrambledHaltonPermutations.Load<uint>(_16582 * 4 + 0) & 65535u;
	                }
	                uint _11749 = (_12091 / 1163u) % 1163u;
	                uint _16583 = (102412u + _11749) / 2u;
	                uint _11455;
	                if ((_11749 & 1u) != 0u)
	                {
	                    _11455 = g_ScrambledHaltonPermutations.Load<uint>(_16583 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11455 = g_ScrambledHaltonPermutations.Load<uint>(_16583 * 4 + 0) & 65535u;
	                }
	                uint _8523 = (_12091 / 1352569u) % 1163u;
	                uint _16584 = (102412u + _8523) / 2u;
	                uint _11843;
	                if ((_8523 & 1u) != 0u)
	                {
	                    _11843 = g_ScrambledHaltonPermutations.Load<uint>(_16584 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11843 = g_ScrambledHaltonPermutations.Load<uint>(_16584 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11569 * 1352569u) + (_11455 * 1163u)) + _11843) * 6.3571259367734000989003106951714e-10f;
	                _19096 = true;
	                break;
	            }
	            case 192u:
	            {
	                uint _15718 = 103575u + (_12091 % 1171u);
	                uint _16579 = _15718 / 2u;
	                uint _11568;
	                if ((_15718 & 1u) != 0u)
	                {
	                    _11568 = g_ScrambledHaltonPermutations.Load<uint>(_16579 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11568 = g_ScrambledHaltonPermutations.Load<uint>(_16579 * 4 + 0) & 65535u;
	                }
	                uint _20396 = 103575u + ((_12091 / 1171u) % 1171u);
	                uint _16580 = _20396 / 2u;
	                uint _11454;
	                if ((_20396 & 1u) != 0u)
	                {
	                    _11454 = g_ScrambledHaltonPermutations.Load<uint>(_16580 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11454 = g_ScrambledHaltonPermutations.Load<uint>(_16580 * 4 + 0) & 65535u;
	                }
	                uint _20397 = 103575u + ((_12091 / 1371241u) % 1171u);
	                uint _16581 = _20397 / 2u;
	                uint _11842;
	                if ((_20397 & 1u) != 0u)
	                {
	                    _11842 = g_ScrambledHaltonPermutations.Load<uint>(_16581 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11842 = g_ScrambledHaltonPermutations.Load<uint>(_16581 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11568 * 1371241u) + (_11454 * 1171u)) + _11842) * 6.2277222268036780405964236706495e-10f;
	                _19096 = true;
	                break;
	            }
	            case 193u:
	            {
	                uint _7224 = _12091 % 1181u;
	                uint _16576 = (104746u + _7224) / 2u;
	                uint _11567;
	                if ((_7224 & 1u) != 0u)
	                {
	                    _11567 = g_ScrambledHaltonPermutations.Load<uint>(_16576 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11567 = g_ScrambledHaltonPermutations.Load<uint>(_16576 * 4 + 0) & 65535u;
	                }
	                uint _11747 = (_12091 / 1181u) % 1181u;
	                uint _16577 = (104746u + _11747) / 2u;
	                uint _11453;
	                if ((_11747 & 1u) != 0u)
	                {
	                    _11453 = g_ScrambledHaltonPermutations.Load<uint>(_16577 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11453 = g_ScrambledHaltonPermutations.Load<uint>(_16577 * 4 + 0) & 65535u;
	                }
	                uint _8521 = (_12091 / 1394761u) % 1181u;
	                uint _16578 = (104746u + _8521) / 2u;
	                uint _11841;
	                if ((_8521 & 1u) != 0u)
	                {
	                    _11841 = g_ScrambledHaltonPermutations.Load<uint>(_16578 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11841 = g_ScrambledHaltonPermutations.Load<uint>(_16578 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11567 * 1394761u) + (_11453 * 1181u)) + _11841) * 6.0708604809889266107347793877125e-10f;
	                _19096 = true;
	                break;
	            }
	            case 194u:
	            {
	                uint _15716 = 105927u + (_12091 % 1187u);
	                uint _16573 = _15716 / 2u;
	                uint _11566;
	                if ((_15716 & 1u) != 0u)
	                {
	                    _11566 = g_ScrambledHaltonPermutations.Load<uint>(_16573 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11566 = g_ScrambledHaltonPermutations.Load<uint>(_16573 * 4 + 0) & 65535u;
	                }
	                uint _20392 = 105927u + ((_12091 / 1187u) % 1187u);
	                uint _16574 = _20392 / 2u;
	                uint _11452;
	                if ((_20392 & 1u) != 0u)
	                {
	                    _11452 = g_ScrambledHaltonPermutations.Load<uint>(_16574 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11452 = g_ScrambledHaltonPermutations.Load<uint>(_16574 * 4 + 0) & 65535u;
	                }
	                uint _20393 = 105927u + ((_12091 / 1408969u) % 1187u);
	                uint _16575 = _20393 / 2u;
	                uint _11840;
	                if ((_20393 & 1u) != 0u)
	                {
	                    _11840 = g_ScrambledHaltonPermutations.Load<uint>(_16575 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11840 = g_ScrambledHaltonPermutations.Load<uint>(_16575 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11566 * 1408969u) + (_11452 * 1187u)) + _11840) * 5.9792648610113019458367489278316e-10f;
	                _19096 = true;
	                break;
	            }
	            case 195u:
	            {
	                uint _7222 = _12091 % 1193u;
	                uint _16570 = (107114u + _7222) / 2u;
	                uint _11565;
	                if ((_7222 & 1u) != 0u)
	                {
	                    _11565 = g_ScrambledHaltonPermutations.Load<uint>(_16570 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11565 = g_ScrambledHaltonPermutations.Load<uint>(_16570 * 4 + 0) & 65535u;
	                }
	                uint _11745 = (_12091 / 1193u) % 1193u;
	                uint _16571 = (107114u + _11745) / 2u;
	                uint _11451;
	                if ((_11745 & 1u) != 0u)
	                {
	                    _11451 = g_ScrambledHaltonPermutations.Load<uint>(_16571 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11451 = g_ScrambledHaltonPermutations.Load<uint>(_16571 * 4 + 0) & 65535u;
	                }
	                uint _8519 = (_12091 / 1423249u) % 1193u;
	                uint _16572 = (107114u + _8519) / 2u;
	                uint _11839;
	                if ((_8519 & 1u) != 0u)
	                {
	                    _11839 = g_ScrambledHaltonPermutations.Load<uint>(_16572 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11839 = g_ScrambledHaltonPermutations.Load<uint>(_16572 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11565 * 1423249u) + (_11451 * 1193u)) + _11839) * 5.8895027743588457269652280956507e-10f;
	                _19096 = true;
	                break;
	            }
	            case 196u:
	            {
	                uint _15714 = 108307u + (_12091 % 1201u);
	                uint _16567 = _15714 / 2u;
	                uint _11564;
	                if ((_15714 & 1u) != 0u)
	                {
	                    _11564 = g_ScrambledHaltonPermutations.Load<uint>(_16567 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11564 = g_ScrambledHaltonPermutations.Load<uint>(_16567 * 4 + 0) & 65535u;
	                }
	                uint _20388 = 108307u + ((_12091 / 1201u) % 1201u);
	                uint _16568 = _20388 / 2u;
	                uint _11450;
	                if ((_20388 & 1u) != 0u)
	                {
	                    _11450 = g_ScrambledHaltonPermutations.Load<uint>(_16568 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11450 = g_ScrambledHaltonPermutations.Load<uint>(_16568 * 4 + 0) & 65535u;
	                }
	                uint _20389 = 108307u + ((_12091 / 1442401u) % 1201u);
	                uint _16569 = _20389 / 2u;
	                uint _11838;
	                if ((_20389 & 1u) != 0u)
	                {
	                    _11838 = g_ScrambledHaltonPermutations.Load<uint>(_16569 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11838 = g_ScrambledHaltonPermutations.Load<uint>(_16569 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11564 * 1442401u) + (_11450 * 1201u)) + _11838) * 5.7725929591967428677889984101057e-10f;
	                _19096 = true;
	                break;
	            }
	            case 197u:
	            {
	                uint _7219 = _12091 % 1213u;
	                uint _16564 = (109508u + _7219) / 2u;
	                uint _11563;
	                if ((_7219 & 1u) != 0u)
	                {
	                    _11563 = g_ScrambledHaltonPermutations.Load<uint>(_16564 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11563 = g_ScrambledHaltonPermutations.Load<uint>(_16564 * 4 + 0) & 65535u;
	                }
	                uint _11743 = (_12091 / 1213u) % 1213u;
	                uint _16565 = (109508u + _11743) / 2u;
	                uint _11449;
	                if ((_11743 & 1u) != 0u)
	                {
	                    _11449 = g_ScrambledHaltonPermutations.Load<uint>(_16565 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11449 = g_ScrambledHaltonPermutations.Load<uint>(_16565 * 4 + 0) & 65535u;
	                }
	                uint _8517 = (_12091 / 1471369u) % 1213u;
	                uint _16566 = (109508u + _8517) / 2u;
	                uint _11837;
	                if ((_8517 & 1u) != 0u)
	                {
	                    _11837 = g_ScrambledHaltonPermutations.Load<uint>(_16566 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11837 = g_ScrambledHaltonPermutations.Load<uint>(_16566 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11563 * 1471369u) + (_11449 * 1213u)) + _11837) * 5.6029603179297282622428610920906e-10f;
	                _19096 = true;
	                break;
	            }
	            case 198u:
	            {
	                uint _15712 = 110721u + (_12091 % 1217u);
	                uint _16561 = _15712 / 2u;
	                uint _11562;
	                if ((_15712 & 1u) != 0u)
	                {
	                    _11562 = g_ScrambledHaltonPermutations.Load<uint>(_16561 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11562 = g_ScrambledHaltonPermutations.Load<uint>(_16561 * 4 + 0) & 65535u;
	                }
	                uint _20384 = 110721u + ((_12091 / 1217u) % 1217u);
	                uint _16562 = _20384 / 2u;
	                uint _11448;
	                if ((_20384 & 1u) != 0u)
	                {
	                    _11448 = g_ScrambledHaltonPermutations.Load<uint>(_16562 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11448 = g_ScrambledHaltonPermutations.Load<uint>(_16562 * 4 + 0) & 65535u;
	                }
	                uint _20385 = 110721u + ((_12091 / 1481089u) % 1217u);
	                uint _16563 = _20385 / 2u;
	                uint _11836;
	                if ((_20385 & 1u) != 0u)
	                {
	                    _11836 = g_ScrambledHaltonPermutations.Load<uint>(_16563 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11836 = g_ScrambledHaltonPermutations.Load<uint>(_16563 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11562 * 1481089u) + (_11448 * 1217u)) + _11836) * 5.547894366131345122994389384985e-10f;
	                _19096 = true;
	                break;
	            }
	            case 199u:
	            {
	                uint _7217 = _12091 % 1223u;
	                uint _16558 = (111938u + _7217) / 2u;
	                uint _11561;
	                if ((_7217 & 1u) != 0u)
	                {
	                    _11561 = g_ScrambledHaltonPermutations.Load<uint>(_16558 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11561 = g_ScrambledHaltonPermutations.Load<uint>(_16558 * 4 + 0) & 65535u;
	                }
	                uint _11741 = (_12091 / 1223u) % 1223u;
	                uint _16559 = (111938u + _11741) / 2u;
	                uint _11447;
	                if ((_11741 & 1u) != 0u)
	                {
	                    _11447 = g_ScrambledHaltonPermutations.Load<uint>(_16559 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11447 = g_ScrambledHaltonPermutations.Load<uint>(_16559 * 4 + 0) & 65535u;
	                }
	                uint _8515 = (_12091 / 1495729u) % 1223u;
	                uint _16560 = (111938u + _8515) / 2u;
	                uint _11835;
	                if ((_8515 & 1u) != 0u)
	                {
	                    _11835 = g_ScrambledHaltonPermutations.Load<uint>(_16560 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11835 = g_ScrambledHaltonPermutations.Load<uint>(_16560 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11561 * 1495729u) + (_11447 * 1223u)) + _11835) * 5.4666415838511284164269454777241e-10f;
	                _19096 = true;
	                break;
	            }
	            case 200u:
	            {
	                uint _15710 = 113161u + (_12091 % 1229u);
	                uint _16555 = _15710 / 2u;
	                uint _11560;
	                if ((_15710 & 1u) != 0u)
	                {
	                    _11560 = g_ScrambledHaltonPermutations.Load<uint>(_16555 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11560 = g_ScrambledHaltonPermutations.Load<uint>(_16555 * 4 + 0) & 65535u;
	                }
	                uint _20380 = 113161u + ((_12091 / 1229u) % 1229u);
	                uint _16556 = _20380 / 2u;
	                uint _11446;
	                if ((_20380 & 1u) != 0u)
	                {
	                    _11446 = g_ScrambledHaltonPermutations.Load<uint>(_16556 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11446 = g_ScrambledHaltonPermutations.Load<uint>(_16556 * 4 + 0) & 65535u;
	                }
	                uint _20381 = 113161u + ((_12091 / 1510441u) % 1229u);
	                uint _16557 = _20381 / 2u;
	                uint _11834;
	                if ((_20381 & 1u) != 0u)
	                {
	                    _11834 = g_ScrambledHaltonPermutations.Load<uint>(_16557 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11834 = g_ScrambledHaltonPermutations.Load<uint>(_16557 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11560 * 1510441u) + (_11446 * 1229u)) + _11834) * 5.3869664284889040573034435510635e-10f;
	                _19096 = true;
	                break;
	            }
	            case 201u:
	            {
	                uint _7215 = _12091 % 1231u;
	                uint _16552 = (114390u + _7215) / 2u;
	                uint _11559;
	                if ((_7215 & 1u) != 0u)
	                {
	                    _11559 = g_ScrambledHaltonPermutations.Load<uint>(_16552 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11559 = g_ScrambledHaltonPermutations.Load<uint>(_16552 * 4 + 0) & 65535u;
	                }
	                uint _11739 = (_12091 / 1231u) % 1231u;
	                uint _16553 = (114390u + _11739) / 2u;
	                uint _11445;
	                if ((_11739 & 1u) != 0u)
	                {
	                    _11445 = g_ScrambledHaltonPermutations.Load<uint>(_16553 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11445 = g_ScrambledHaltonPermutations.Load<uint>(_16553 * 4 + 0) & 65535u;
	                }
	                uint _8513 = (_12091 / 1515361u) % 1231u;
	                uint _16554 = (114390u + _8513) / 2u;
	                uint _11833;
	                if ((_8513 & 1u) != 0u)
	                {
	                    _11833 = g_ScrambledHaltonPermutations.Load<uint>(_16554 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11833 = g_ScrambledHaltonPermutations.Load<uint>(_16554 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11559 * 1515361u) + (_11445 * 1231u)) + _11833) * 5.3607529526544794862275011837482e-10f;
	                _19096 = true;
	                break;
	            }
	            case 202u:
	            {
	                uint _15708 = 115621u + (_12091 % 1237u);
	                uint _16549 = _15708 / 2u;
	                uint _11558;
	                if ((_15708 & 1u) != 0u)
	                {
	                    _11558 = g_ScrambledHaltonPermutations.Load<uint>(_16549 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11558 = g_ScrambledHaltonPermutations.Load<uint>(_16549 * 4 + 0) & 65535u;
	                }
	                uint _20376 = 115621u + ((_12091 / 1237u) % 1237u);
	                uint _16550 = _20376 / 2u;
	                uint _11444;
	                if ((_20376 & 1u) != 0u)
	                {
	                    _11444 = g_ScrambledHaltonPermutations.Load<uint>(_16550 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11444 = g_ScrambledHaltonPermutations.Load<uint>(_16550 * 4 + 0) & 65535u;
	                }
	                uint _20377 = 115621u + ((_12091 / 1530169u) % 1237u);
	                uint _16551 = _20377 / 2u;
	                uint _11832;
	                if ((_20377 & 1u) != 0u)
	                {
	                    _11832 = g_ScrambledHaltonPermutations.Load<uint>(_16551 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11832 = g_ScrambledHaltonPermutations.Load<uint>(_16551 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11558 * 1530169u) + (_11444 * 1237u)) + _11832) * 5.2831244934381516031862702220678e-10f;
	                _19096 = true;
	                break;
	            }
	            case 203u:
	            {
	                uint _7213 = _12091 % 1249u;
	                uint _16546 = (116858u + _7213) / 2u;
	                uint _11557;
	                if ((_7213 & 1u) != 0u)
	                {
	                    _11557 = g_ScrambledHaltonPermutations.Load<uint>(_16546 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11557 = g_ScrambledHaltonPermutations.Load<uint>(_16546 * 4 + 0) & 65535u;
	                }
	                uint _11737 = (_12091 / 1249u) % 1249u;
	                uint _16547 = (116858u + _11737) / 2u;
	                uint _11443;
	                if ((_11737 & 1u) != 0u)
	                {
	                    _11443 = g_ScrambledHaltonPermutations.Load<uint>(_16547 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11443 = g_ScrambledHaltonPermutations.Load<uint>(_16547 * 4 + 0) & 65535u;
	                }
	                uint _8511 = (_12091 / 1560001u) % 1249u;
	                uint _16548 = (116858u + _8511) / 2u;
	                uint _11831;
	                if ((_8511 & 1u) != 0u)
	                {
	                    _11831 = g_ScrambledHaltonPermutations.Load<uint>(_16548 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11831 = g_ScrambledHaltonPermutations.Load<uint>(_16548 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11557 * 1560001u) + (_11443 * 1249u)) + _11831) * 5.1323073568809718381089624017477e-10f;
	                _19096 = true;
	                break;
	            }
	            case 204u:
	            {
	                uint _15706 = 118107u + (_12091 % 1259u);
	                uint _16543 = _15706 / 2u;
	                uint _11556;
	                if ((_15706 & 1u) != 0u)
	                {
	                    _11556 = g_ScrambledHaltonPermutations.Load<uint>(_16543 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11556 = g_ScrambledHaltonPermutations.Load<uint>(_16543 * 4 + 0) & 65535u;
	                }
	                uint _20372 = 118107u + ((_12091 / 1259u) % 1259u);
	                uint _16544 = _20372 / 2u;
	                uint _11442;
	                if ((_20372 & 1u) != 0u)
	                {
	                    _11442 = g_ScrambledHaltonPermutations.Load<uint>(_16544 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11442 = g_ScrambledHaltonPermutations.Load<uint>(_16544 * 4 + 0) & 65535u;
	                }
	                uint _20373 = 118107u + ((_12091 / 1585081u) % 1259u);
	                uint _16545 = _20373 / 2u;
	                uint _11830;
	                if ((_20373 & 1u) != 0u)
	                {
	                    _11830 = g_ScrambledHaltonPermutations.Load<uint>(_16545 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11830 = g_ScrambledHaltonPermutations.Load<uint>(_16545 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11556 * 1585081u) + (_11442 * 1259u)) + _11830) * 5.0109810745269101062149275094271e-10f;
	                _19096 = true;
	                break;
	            }
	            case 205u:
	            {
	                uint _7211 = _12091 % 1277u;
	                uint _16540 = (119366u + _7211) / 2u;
	                uint _11555;
	                if ((_7211 & 1u) != 0u)
	                {
	                    _11555 = g_ScrambledHaltonPermutations.Load<uint>(_16540 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11555 = g_ScrambledHaltonPermutations.Load<uint>(_16540 * 4 + 0) & 65535u;
	                }
	                uint _11735 = (_12091 / 1277u) % 1277u;
	                uint _16541 = (119366u + _11735) / 2u;
	                uint _11441;
	                if ((_11735 & 1u) != 0u)
	                {
	                    _11441 = g_ScrambledHaltonPermutations.Load<uint>(_16541 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11441 = g_ScrambledHaltonPermutations.Load<uint>(_16541 * 4 + 0) & 65535u;
	                }
	                uint _8509 = (_12091 / 1630729u) % 1277u;
	                uint _16542 = (119366u + _8509) / 2u;
	                uint _11829;
	                if ((_8509 & 1u) != 0u)
	                {
	                    _11829 = g_ScrambledHaltonPermutations.Load<uint>(_16542 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11829 = g_ScrambledHaltonPermutations.Load<uint>(_16542 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11555 * 1630729u) + (_11441 * 1277u)) + _11829) * 4.8020565301953865855466574430466e-10f;
	                _19096 = true;
	                break;
	            }
	            case 206u:
	            {
	                uint _15704 = 120643u + (_12091 % 1279u);
	                uint _16537 = _15704 / 2u;
	                uint _11554;
	                if ((_15704 & 1u) != 0u)
	                {
	                    _11554 = g_ScrambledHaltonPermutations.Load<uint>(_16537 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11554 = g_ScrambledHaltonPermutations.Load<uint>(_16537 * 4 + 0) & 65535u;
	                }
	                uint _20368 = 120643u + ((_12091 / 1279u) % 1279u);
	                uint _16538 = _20368 / 2u;
	                uint _11440;
	                if ((_20368 & 1u) != 0u)
	                {
	                    _11440 = g_ScrambledHaltonPermutations.Load<uint>(_16538 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11440 = g_ScrambledHaltonPermutations.Load<uint>(_16538 * 4 + 0) & 65535u;
	                }
	                uint _20369 = 120643u + ((_12091 / 1635841u) % 1279u);
	                uint _16539 = _20369 / 2u;
	                uint _11828;
	                if ((_20369 & 1u) != 0u)
	                {
	                    _11828 = g_ScrambledHaltonPermutations.Load<uint>(_16539 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11828 = g_ScrambledHaltonPermutations.Load<uint>(_16539 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11554 * 1635841u) + (_11440 * 1279u)) + _11828) * 4.7795645219395055391942150890827e-10f;
	                _19096 = true;
	                break;
	            }
	            case 207u:
	            {
	                uint _7209 = _12091 % 1283u;
	                uint _16534 = (121922u + _7209) / 2u;
	                uint _11553;
	                if ((_7209 & 1u) != 0u)
	                {
	                    _11553 = g_ScrambledHaltonPermutations.Load<uint>(_16534 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11553 = g_ScrambledHaltonPermutations.Load<uint>(_16534 * 4 + 0) & 65535u;
	                }
	                uint _11733 = (_12091 / 1283u) % 1283u;
	                uint _16535 = (121922u + _11733) / 2u;
	                uint _11439;
	                if ((_11733 & 1u) != 0u)
	                {
	                    _11439 = g_ScrambledHaltonPermutations.Load<uint>(_16535 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11439 = g_ScrambledHaltonPermutations.Load<uint>(_16535 * 4 + 0) & 65535u;
	                }
	                uint _8507 = (_12091 / 1646089u) % 1283u;
	                uint _16536 = (121922u + _8507) / 2u;
	                uint _11827;
	                if ((_8507 & 1u) != 0u)
	                {
	                    _11827 = g_ScrambledHaltonPermutations.Load<uint>(_16536 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11827 = g_ScrambledHaltonPermutations.Load<uint>(_16536 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11553 * 1646089u) + (_11439 * 1283u)) + _11827) * 4.7350001697310517556616105139256e-10f;
	                _19096 = true;
	                break;
	            }
	            case 208u:
	            {
	                uint _15702 = 123205u + (_12091 % 1289u);
	                uint _16531 = _15702 / 2u;
	                uint _11552;
	                if ((_15702 & 1u) != 0u)
	                {
	                    _11552 = g_ScrambledHaltonPermutations.Load<uint>(_16531 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11552 = g_ScrambledHaltonPermutations.Load<uint>(_16531 * 4 + 0) & 65535u;
	                }
	                uint _20364 = 123205u + ((_12091 / 1289u) % 1289u);
	                uint _16532 = _20364 / 2u;
	                uint _11438;
	                if ((_20364 & 1u) != 0u)
	                {
	                    _11438 = g_ScrambledHaltonPermutations.Load<uint>(_16532 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11438 = g_ScrambledHaltonPermutations.Load<uint>(_16532 * 4 + 0) & 65535u;
	                }
	                uint _20365 = 123205u + ((_12091 / 1661521u) % 1289u);
	                uint _16533 = _20365 / 2u;
	                uint _11826;
	                if ((_20365 & 1u) != 0u)
	                {
	                    _11826 = g_ScrambledHaltonPermutations.Load<uint>(_16533 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11826 = g_ScrambledHaltonPermutations.Load<uint>(_16533 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11552 * 1661521u) + (_11438 * 1289u)) + _11826) * 4.6691861488312724759452976286411e-10f;
	                _19096 = true;
	                break;
	            }
	            case 209u:
	            {
	                uint _7207 = _12091 % 1291u;
	                uint _16528 = (124494u + _7207) / 2u;
	                uint _11551;
	                if ((_7207 & 1u) != 0u)
	                {
	                    _11551 = g_ScrambledHaltonPermutations.Load<uint>(_16528 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11551 = g_ScrambledHaltonPermutations.Load<uint>(_16528 * 4 + 0) & 65535u;
	                }
	                uint _11731 = (_12091 / 1291u) % 1291u;
	                uint _16529 = (124494u + _11731) / 2u;
	                uint _11437;
	                if ((_11731 & 1u) != 0u)
	                {
	                    _11437 = g_ScrambledHaltonPermutations.Load<uint>(_16529 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11437 = g_ScrambledHaltonPermutations.Load<uint>(_16529 * 4 + 0) & 65535u;
	                }
	                uint _8505 = (_12091 / 1666681u) % 1291u;
	                uint _16530 = (124494u + _8505) / 2u;
	                uint _11825;
	                if ((_8505 & 1u) != 0u)
	                {
	                    _11825 = g_ScrambledHaltonPermutations.Load<uint>(_16530 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11825 = g_ScrambledHaltonPermutations.Load<uint>(_16530 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11551 * 1666681u) + (_11437 * 1291u)) + _11825) * 4.6475195913942002334806602448225e-10f;
	                _19096 = true;
	                break;
	            }
	            case 210u:
	            {
	                uint _15700 = 125785u + (_12091 % 1297u);
	                uint _16525 = _15700 / 2u;
	                uint _11550;
	                if ((_15700 & 1u) != 0u)
	                {
	                    _11550 = g_ScrambledHaltonPermutations.Load<uint>(_16525 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11550 = g_ScrambledHaltonPermutations.Load<uint>(_16525 * 4 + 0) & 65535u;
	                }
	                uint _20360 = 125785u + ((_12091 / 1297u) % 1297u);
	                uint _16526 = _20360 / 2u;
	                uint _11436;
	                if ((_20360 & 1u) != 0u)
	                {
	                    _11436 = g_ScrambledHaltonPermutations.Load<uint>(_16526 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11436 = g_ScrambledHaltonPermutations.Load<uint>(_16526 * 4 + 0) & 65535u;
	                }
	                uint _20361 = 125785u + ((_12091 / 1682209u) % 1297u);
	                uint _16527 = _20361 / 2u;
	                uint _11824;
	                if ((_20361 & 1u) != 0u)
	                {
	                    _11824 = g_ScrambledHaltonPermutations.Load<uint>(_16527 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11824 = g_ScrambledHaltonPermutations.Load<uint>(_16527 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11550 * 1682209u) + (_11436 * 1297u)) + _11824) * 4.5833184469934451499284477904439e-10f;
	                _19096 = true;
	                break;
	            }
	            case 211u:
	            {
	                uint _7205 = _12091 % 1301u;
	                uint _16522 = (127082u + _7205) / 2u;
	                uint _11549;
	                if ((_7205 & 1u) != 0u)
	                {
	                    _11549 = g_ScrambledHaltonPermutations.Load<uint>(_16522 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11549 = g_ScrambledHaltonPermutations.Load<uint>(_16522 * 4 + 0) & 65535u;
	                }
	                uint _11729 = (_12091 / 1301u) % 1301u;
	                uint _16523 = (127082u + _11729) / 2u;
	                uint _11435;
	                if ((_11729 & 1u) != 0u)
	                {
	                    _11435 = g_ScrambledHaltonPermutations.Load<uint>(_16523 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11435 = g_ScrambledHaltonPermutations.Load<uint>(_16523 * 4 + 0) & 65535u;
	                }
	                uint _8503 = (_12091 / 1692601u) % 1301u;
	                uint _16524 = (127082u + _8503) / 2u;
	                uint _11823;
	                if ((_8503 & 1u) != 0u)
	                {
	                    _11823 = g_ScrambledHaltonPermutations.Load<uint>(_16524 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11823 = g_ScrambledHaltonPermutations.Load<uint>(_16524 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11549 * 1692601u) + (_11435 * 1301u)) + _11823) * 4.5411732707556495824974263086915e-10f;
	                _19096 = true;
	                break;
	            }
	            case 212u:
	            {
	                uint _15698 = 128383u + (_12091 % 1303u);
	                uint _16519 = _15698 / 2u;
	                uint _11548;
	                if ((_15698 & 1u) != 0u)
	                {
	                    _11548 = g_ScrambledHaltonPermutations.Load<uint>(_16519 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11548 = g_ScrambledHaltonPermutations.Load<uint>(_16519 * 4 + 0) & 65535u;
	                }
	                uint _20356 = 128383u + ((_12091 / 1303u) % 1303u);
	                uint _16520 = _20356 / 2u;
	                uint _11434;
	                if ((_20356 & 1u) != 0u)
	                {
	                    _11434 = g_ScrambledHaltonPermutations.Load<uint>(_16520 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11434 = g_ScrambledHaltonPermutations.Load<uint>(_16520 * 4 + 0) & 65535u;
	                }
	                uint _20357 = 128383u + ((_12091 / 1697809u) % 1303u);
	                uint _16521 = _20357 / 2u;
	                uint _11822;
	                if ((_20357 & 1u) != 0u)
	                {
	                    _11822 = g_ScrambledHaltonPermutations.Load<uint>(_16521 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11822 = g_ScrambledHaltonPermutations.Load<uint>(_16521 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11548 * 1697809u) + (_11434 * 1303u)) + _11822) * 4.5202938614430365760199492797256e-10f;
	                _19096 = true;
	                break;
	            }
	            case 213u:
	            {
	                uint _7203 = _12091 % 1307u;
	                uint _16516 = (129686u + _7203) / 2u;
	                uint _11547;
	                if ((_7203 & 1u) != 0u)
	                {
	                    _11547 = g_ScrambledHaltonPermutations.Load<uint>(_16516 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11547 = g_ScrambledHaltonPermutations.Load<uint>(_16516 * 4 + 0) & 65535u;
	                }
	                uint _11727 = (_12091 / 1307u) % 1307u;
	                uint _16517 = (129686u + _11727) / 2u;
	                uint _11433;
	                if ((_11727 & 1u) != 0u)
	                {
	                    _11433 = g_ScrambledHaltonPermutations.Load<uint>(_16517 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11433 = g_ScrambledHaltonPermutations.Load<uint>(_16517 * 4 + 0) & 65535u;
	                }
	                uint _8501 = (_12091 / 1708249u) % 1307u;
	                uint _16518 = (129686u + _8501) / 2u;
	                uint _11821;
	                if ((_8501 & 1u) != 0u)
	                {
	                    _11821 = g_ScrambledHaltonPermutations.Load<uint>(_16518 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11821 = g_ScrambledHaltonPermutations.Load<uint>(_16518 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11547 * 1708249u) + (_11433 * 1307u)) + _11821) * 4.478918624872818554649711586535e-10f;
	                _19096 = true;
	                break;
	            }
	            case 214u:
	            {
	                uint _15696 = 130993u + (_12091 % 1319u);
	                uint _16513 = _15696 / 2u;
	                uint _11546;
	                if ((_15696 & 1u) != 0u)
	                {
	                    _11546 = g_ScrambledHaltonPermutations.Load<uint>(_16513 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11546 = g_ScrambledHaltonPermutations.Load<uint>(_16513 * 4 + 0) & 65535u;
	                }
	                uint _20352 = 130993u + ((_12091 / 1319u) % 1319u);
	                uint _16514 = _20352 / 2u;
	                uint _11432;
	                if ((_20352 & 1u) != 0u)
	                {
	                    _11432 = g_ScrambledHaltonPermutations.Load<uint>(_16514 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11432 = g_ScrambledHaltonPermutations.Load<uint>(_16514 * 4 + 0) & 65535u;
	                }
	                uint _20353 = 130993u + ((_12091 / 1739761u) % 1319u);
	                uint _16515 = _20353 / 2u;
	                uint _11820;
	                if ((_20353 & 1u) != 0u)
	                {
	                    _11820 = g_ScrambledHaltonPermutations.Load<uint>(_16515 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11820 = g_ScrambledHaltonPermutations.Load<uint>(_16515 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11546 * 1739761u) + (_11432 * 1319u)) + _11820) * 4.3577824682117238808132242411375e-10f;
	                _19096 = true;
	                break;
	            }
	            case 215u:
	            {
	                uint _7201 = _12091 % 1321u;
	                uint _16510 = (132312u + _7201) / 2u;
	                uint _11545;
	                if ((_7201 & 1u) != 0u)
	                {
	                    _11545 = g_ScrambledHaltonPermutations.Load<uint>(_16510 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11545 = g_ScrambledHaltonPermutations.Load<uint>(_16510 * 4 + 0) & 65535u;
	                }
	                uint _11725 = (_12091 / 1321u) % 1321u;
	                uint _16511 = (132312u + _11725) / 2u;
	                uint _11431;
	                if ((_11725 & 1u) != 0u)
	                {
	                    _11431 = g_ScrambledHaltonPermutations.Load<uint>(_16511 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11431 = g_ScrambledHaltonPermutations.Load<uint>(_16511 * 4 + 0) & 65535u;
	                }
	                uint _8499 = (_12091 / 1745041u) % 1321u;
	                uint _16512 = (132312u + _8499) / 2u;
	                uint _11819;
	                if ((_8499 & 1u) != 0u)
	                {
	                    _11819 = g_ScrambledHaltonPermutations.Load<uint>(_16512 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11819 = g_ScrambledHaltonPermutations.Load<uint>(_16512 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11545 * 1745041u) + (_11431 * 1321u)) + _11819) * 4.3380196657061276255262782797217e-10f;
	                _19096 = true;
	                break;
	            }
	            case 216u:
	            {
	                uint _15694 = 133633u + (_12091 % 1327u);
	                uint _16507 = _15694 / 2u;
	                uint _11544;
	                if ((_15694 & 1u) != 0u)
	                {
	                    _11544 = g_ScrambledHaltonPermutations.Load<uint>(_16507 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11544 = g_ScrambledHaltonPermutations.Load<uint>(_16507 * 4 + 0) & 65535u;
	                }
	                uint _20347 = 133633u + ((_12091 / 1327u) % 1327u);
	                uint _16508 = _20347 / 2u;
	                uint _11430;
	                if ((_20347 & 1u) != 0u)
	                {
	                    _11430 = g_ScrambledHaltonPermutations.Load<uint>(_16508 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11430 = g_ScrambledHaltonPermutations.Load<uint>(_16508 * 4 + 0) & 65535u;
	                }
	                uint _20348 = 133633u + ((_12091 / 1760929u) % 1327u);
	                uint _16509 = _20348 / 2u;
	                uint _11818;
	                if ((_20348 & 1u) != 0u)
	                {
	                    _11818 = g_ScrambledHaltonPermutations.Load<uint>(_16509 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11818 = g_ScrambledHaltonPermutations.Load<uint>(_16509 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11544 * 1760929u) + (_11430 * 1327u)) + _11818) * 4.2794420784808551161404466256499e-10f;
	                _19096 = true;
	                break;
	            }
	            case 217u:
	            {
	                uint _7199 = _12091 % 1361u;
	                uint _16504 = (134960u + _7199) / 2u;
	                uint _11543;
	                if ((_7199 & 1u) != 0u)
	                {
	                    _11543 = g_ScrambledHaltonPermutations.Load<uint>(_16504 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11543 = g_ScrambledHaltonPermutations.Load<uint>(_16504 * 4 + 0) & 65535u;
	                }
	                uint _11723 = (_12091 / 1361u) % 1361u;
	                uint _16505 = (134960u + _11723) / 2u;
	                uint _11429;
	                if ((_11723 & 1u) != 0u)
	                {
	                    _11429 = g_ScrambledHaltonPermutations.Load<uint>(_16505 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11429 = g_ScrambledHaltonPermutations.Load<uint>(_16505 * 4 + 0) & 65535u;
	                }
	                uint _8497 = (_12091 / 1852321u) % 1361u;
	                uint _16506 = (134960u + _8497) / 2u;
	                uint _11817;
	                if ((_8497 & 1u) != 0u)
	                {
	                    _11817 = g_ScrambledHaltonPermutations.Load<uint>(_16506 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11817 = g_ScrambledHaltonPermutations.Load<uint>(_16506 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11543 * 1852321u) + (_11429 * 1361u)) + _11817) * 3.9666653295356013586570043116808e-10f;
	                _19096 = true;
	                break;
	            }
	            case 218u:
	            {
	                uint _15692 = 136321u + (_12091 % 1367u);
	                uint _16501 = _15692 / 2u;
	                uint _11542;
	                if ((_15692 & 1u) != 0u)
	                {
	                    _11542 = g_ScrambledHaltonPermutations.Load<uint>(_16501 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11542 = g_ScrambledHaltonPermutations.Load<uint>(_16501 * 4 + 0) & 65535u;
	                }
	                uint _20343 = 136321u + ((_12091 / 1367u) % 1367u);
	                uint _16502 = _20343 / 2u;
	                uint _11428;
	                if ((_20343 & 1u) != 0u)
	                {
	                    _11428 = g_ScrambledHaltonPermutations.Load<uint>(_16502 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11428 = g_ScrambledHaltonPermutations.Load<uint>(_16502 * 4 + 0) & 65535u;
	                }
	                uint _20344 = 136321u + ((_12091 / 1868689u) % 1367u);
	                uint _16503 = _20344 / 2u;
	                uint _11816;
	                if ((_20344 & 1u) != 0u)
	                {
	                    _11816 = g_ScrambledHaltonPermutations.Load<uint>(_16503 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11816 = g_ScrambledHaltonPermutations.Load<uint>(_16503 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11542 * 1868689u) + (_11428 * 1367u)) + _11816) * 3.9146633157294274951709667220712e-10f;
	                _19096 = true;
	                break;
	            }
	            case 219u:
	            {
	                uint _7197 = _12091 % 1373u;
	                uint _16498 = (137688u + _7197) / 2u;
	                uint _11541;
	                if ((_7197 & 1u) != 0u)
	                {
	                    _11541 = g_ScrambledHaltonPermutations.Load<uint>(_16498 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11541 = g_ScrambledHaltonPermutations.Load<uint>(_16498 * 4 + 0) & 65535u;
	                }
	                uint _11721 = (_12091 / 1373u) % 1373u;
	                uint _16499 = (137688u + _11721) / 2u;
	                uint _11427;
	                if ((_11721 & 1u) != 0u)
	                {
	                    _11427 = g_ScrambledHaltonPermutations.Load<uint>(_16499 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11427 = g_ScrambledHaltonPermutations.Load<uint>(_16499 * 4 + 0) & 65535u;
	                }
	                uint _8495 = (_12091 / 1885129u) % 1373u;
	                uint _16500 = (137688u + _8495) / 2u;
	                uint _11815;
	                if ((_8495 & 1u) != 0u)
	                {
	                    _11815 = g_ScrambledHaltonPermutations.Load<uint>(_16500 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11815 = g_ScrambledHaltonPermutations.Load<uint>(_16500 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11541 * 1885129u) + (_11427 * 1373u)) + _11815) * 3.863566133688323134265374392271e-10f;
	                _19096 = true;
	                break;
	            }
	            case 220u:
	            {
	                uint _15690 = 139061u + (_12091 % 1381u);
	                uint _16495 = _15690 / 2u;
	                uint _11540;
	                if ((_15690 & 1u) != 0u)
	                {
	                    _11540 = g_ScrambledHaltonPermutations.Load<uint>(_16495 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11540 = g_ScrambledHaltonPermutations.Load<uint>(_16495 * 4 + 0) & 65535u;
	                }
	                uint _20339 = 139061u + ((_12091 / 1381u) % 1381u);
	                uint _16496 = _20339 / 2u;
	                uint _11426;
	                if ((_20339 & 1u) != 0u)
	                {
	                    _11426 = g_ScrambledHaltonPermutations.Load<uint>(_16496 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11426 = g_ScrambledHaltonPermutations.Load<uint>(_16496 * 4 + 0) & 65535u;
	                }
	                uint _20340 = 139061u + ((_12091 / 1907161u) % 1381u);
	                uint _16497 = _20340 / 2u;
	                uint _11814;
	                if ((_20340 & 1u) != 0u)
	                {
	                    _11814 = g_ScrambledHaltonPermutations.Load<uint>(_16497 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11814 = g_ScrambledHaltonPermutations.Load<uint>(_16497 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11540 * 1907161u) + (_11426 * 1381u)) + _11814) * 3.7968103661079055655136471614242e-10f;
	                _19096 = true;
	                break;
	            }
	            case 221u:
	            {
	                uint _7195 = _12091 % 1399u;
	                uint _16492 = (140442u + _7195) / 2u;
	                uint _11539;
	                if ((_7195 & 1u) != 0u)
	                {
	                    _11539 = g_ScrambledHaltonPermutations.Load<uint>(_16492 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11539 = g_ScrambledHaltonPermutations.Load<uint>(_16492 * 4 + 0) & 65535u;
	                }
	                uint _11719 = (_12091 / 1399u) % 1399u;
	                uint _16493 = (140442u + _11719) / 2u;
	                uint _11425;
	                if ((_11719 & 1u) != 0u)
	                {
	                    _11425 = g_ScrambledHaltonPermutations.Load<uint>(_16493 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11425 = g_ScrambledHaltonPermutations.Load<uint>(_16493 * 4 + 0) & 65535u;
	                }
	                uint _8493 = (_12091 / 1957201u) % 1399u;
	                uint _16494 = (140442u + _8493) / 2u;
	                uint _11813;
	                if ((_8493 & 1u) != 0u)
	                {
	                    _11813 = g_ScrambledHaltonPermutations.Load<uint>(_16494 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11813 = g_ScrambledHaltonPermutations.Load<uint>(_16494 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11539 * 1957201u) + (_11425 * 1399u)) + _11813) * 3.652134705767196010128827765584e-10f;
	                _19096 = true;
	                break;
	            }
	            case 222u:
	            {
	                uint _15688 = 141841u + (_12091 % 1409u);
	                uint _16489 = _15688 / 2u;
	                uint _11538;
	                if ((_15688 & 1u) != 0u)
	                {
	                    _11538 = g_ScrambledHaltonPermutations.Load<uint>(_16489 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11538 = g_ScrambledHaltonPermutations.Load<uint>(_16489 * 4 + 0) & 65535u;
	                }
	                uint _20335 = 141841u + ((_12091 / 1409u) % 1409u);
	                uint _16490 = _20335 / 2u;
	                uint _11424;
	                if ((_20335 & 1u) != 0u)
	                {
	                    _11424 = g_ScrambledHaltonPermutations.Load<uint>(_16490 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11424 = g_ScrambledHaltonPermutations.Load<uint>(_16490 * 4 + 0) & 65535u;
	                }
	                uint _20336 = 141841u + ((_12091 / 1985281u) % 1409u);
	                uint _16491 = _20336 / 2u;
	                uint _11812;
	                if ((_20336 & 1u) != 0u)
	                {
	                    _11812 = g_ScrambledHaltonPermutations.Load<uint>(_16491 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11812 = g_ScrambledHaltonPermutations.Load<uint>(_16491 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11538 * 1985281u) + (_11424 * 1409u)) + _11812) * 3.5749250781869079673924716189504e-10f;
	                _19096 = true;
	                break;
	            }
	            case 223u:
	            {
	                uint _7193 = _12091 % 1423u;
	                uint _16486 = (143250u + _7193) / 2u;
	                uint _11537;
	                if ((_7193 & 1u) != 0u)
	                {
	                    _11537 = g_ScrambledHaltonPermutations.Load<uint>(_16486 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11537 = g_ScrambledHaltonPermutations.Load<uint>(_16486 * 4 + 0) & 65535u;
	                }
	                uint _11717 = (_12091 / 1423u) % 1423u;
	                uint _16487 = (143250u + _11717) / 2u;
	                uint _11423;
	                if ((_11717 & 1u) != 0u)
	                {
	                    _11423 = g_ScrambledHaltonPermutations.Load<uint>(_16487 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11423 = g_ScrambledHaltonPermutations.Load<uint>(_16487 * 4 + 0) & 65535u;
	                }
	                uint _8491 = (_12091 / 2024929u) % 1423u;
	                uint _16488 = (143250u + _8491) / 2u;
	                uint _11811;
	                if ((_8491 & 1u) != 0u)
	                {
	                    _11811 = g_ScrambledHaltonPermutations.Load<uint>(_16488 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11811 = g_ScrambledHaltonPermutations.Load<uint>(_16488 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11537 * 2024929u) + (_11423 * 1423u)) + _11811) * 3.4704455975642645171319600194693e-10f;
	                _19096 = true;
	                break;
	            }
	            case 224u:
	            {
	                uint _15686 = 144673u + (_12091 % 1427u);
	                uint _16483 = _15686 / 2u;
	                uint _11536;
	                if ((_15686 & 1u) != 0u)
	                {
	                    _11536 = g_ScrambledHaltonPermutations.Load<uint>(_16483 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11536 = g_ScrambledHaltonPermutations.Load<uint>(_16483 * 4 + 0) & 65535u;
	                }
	                uint _20331 = 144673u + ((_12091 / 1427u) % 1427u);
	                uint _16484 = _20331 / 2u;
	                uint _11422;
	                if ((_20331 & 1u) != 0u)
	                {
	                    _11422 = g_ScrambledHaltonPermutations.Load<uint>(_16484 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11422 = g_ScrambledHaltonPermutations.Load<uint>(_16484 * 4 + 0) & 65535u;
	                }
	                uint _20332 = 144673u + ((_12091 / 2036329u) % 1427u);
	                uint _16485 = _20332 / 2u;
	                uint _11810;
	                if ((_20332 & 1u) != 0u)
	                {
	                    _11810 = g_ScrambledHaltonPermutations.Load<uint>(_16485 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11810 = g_ScrambledHaltonPermutations.Load<uint>(_16485 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11536 * 2036329u) + (_11422 * 1427u)) + _11810) * 3.4413435989755214450269704684615e-10f;
	                _19096 = true;
	                break;
	            }
	            case 225u:
	            {
	                uint _7191 = _12091 % 1429u;
	                uint _16480 = (146100u + _7191) / 2u;
	                uint _11535;
	                if ((_7191 & 1u) != 0u)
	                {
	                    _11535 = g_ScrambledHaltonPermutations.Load<uint>(_16480 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11535 = g_ScrambledHaltonPermutations.Load<uint>(_16480 * 4 + 0) & 65535u;
	                }
	                uint _11715 = (_12091 / 1429u) % 1429u;
	                uint _16481 = (146100u + _11715) / 2u;
	                uint _11421;
	                if ((_11715 & 1u) != 0u)
	                {
	                    _11421 = g_ScrambledHaltonPermutations.Load<uint>(_16481 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11421 = g_ScrambledHaltonPermutations.Load<uint>(_16481 * 4 + 0) & 65535u;
	                }
	                uint _8489 = (_12091 / 2042041u) % 1429u;
	                uint _16482 = (146100u + _8489) / 2u;
	                uint _11809;
	                if ((_8489 & 1u) != 0u)
	                {
	                    _11809 = g_ScrambledHaltonPermutations.Load<uint>(_16482 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11809 = g_ScrambledHaltonPermutations.Load<uint>(_16482 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11535 * 2042041u) + (_11421 * 1429u)) + _11809) * 3.4269143078802244417602196335793e-10f;
	                _19096 = true;
	                break;
	            }
	            case 226u:
	            {
	                uint _15684 = 147529u + (_12091 % 1433u);
	                uint _16477 = _15684 / 2u;
	                uint _11534;
	                if ((_15684 & 1u) != 0u)
	                {
	                    _11534 = g_ScrambledHaltonPermutations.Load<uint>(_16477 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11534 = g_ScrambledHaltonPermutations.Load<uint>(_16477 * 4 + 0) & 65535u;
	                }
	                uint _20327 = 147529u + ((_12091 / 1433u) % 1433u);
	                uint _16478 = _20327 / 2u;
	                uint _11420;
	                if ((_20327 & 1u) != 0u)
	                {
	                    _11420 = g_ScrambledHaltonPermutations.Load<uint>(_16478 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11420 = g_ScrambledHaltonPermutations.Load<uint>(_16478 * 4 + 0) & 65535u;
	                }
	                uint _20328 = 147529u + ((_12091 / 2053489u) % 1433u);
	                uint _16479 = _20328 / 2u;
	                uint _11808;
	                if ((_20328 & 1u) != 0u)
	                {
	                    _11808 = g_ScrambledHaltonPermutations.Load<uint>(_16479 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11808 = g_ScrambledHaltonPermutations.Load<uint>(_16479 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11534 * 2053489u) + (_11420 * 1433u)) + _11808) * 3.3982971991974864067742601037025e-10f;
	                _19096 = true;
	                break;
	            }
	            case 227u:
	            {
	                uint _7189 = _12091 % 1439u;
	                uint _16474 = (148962u + _7189) / 2u;
	                uint _11533;
	                if ((_7189 & 1u) != 0u)
	                {
	                    _11533 = g_ScrambledHaltonPermutations.Load<uint>(_16474 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11533 = g_ScrambledHaltonPermutations.Load<uint>(_16474 * 4 + 0) & 65535u;
	                }
	                uint _11713 = (_12091 / 1439u) % 1439u;
	                uint _16475 = (148962u + _11713) / 2u;
	                uint _11419;
	                if ((_11713 & 1u) != 0u)
	                {
	                    _11419 = g_ScrambledHaltonPermutations.Load<uint>(_16475 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11419 = g_ScrambledHaltonPermutations.Load<uint>(_16475 * 4 + 0) & 65535u;
	                }
	                uint _8487 = (_12091 / 2070721u) % 1439u;
	                uint _16476 = (148962u + _8487) / 2u;
	                uint _11807;
	                if ((_8487 & 1u) != 0u)
	                {
	                    _11807 = g_ScrambledHaltonPermutations.Load<uint>(_16476 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11807 = g_ScrambledHaltonPermutations.Load<uint>(_16476 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11533 * 2070721u) + (_11419 * 1439u)) + _11807) * 3.3559660606030661256227176636457e-10f;
	                _19096 = true;
	                break;
	            }
	            case 228u:
	            {
	                uint _15682 = 150401u + (_12091 % 1447u);
	                uint _16471 = _15682 / 2u;
	                uint _11532;
	                if ((_15682 & 1u) != 0u)
	                {
	                    _11532 = g_ScrambledHaltonPermutations.Load<uint>(_16471 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11532 = g_ScrambledHaltonPermutations.Load<uint>(_16471 * 4 + 0) & 65535u;
	                }
	                uint _20323 = 150401u + ((_12091 / 1447u) % 1447u);
	                uint _16472 = _20323 / 2u;
	                uint _11418;
	                if ((_20323 & 1u) != 0u)
	                {
	                    _11418 = g_ScrambledHaltonPermutations.Load<uint>(_16472 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11418 = g_ScrambledHaltonPermutations.Load<uint>(_16472 * 4 + 0) & 65535u;
	                }
	                uint _20324 = 150401u + ((_12091 / 2093809u) % 1447u);
	                uint _16473 = _20324 / 2u;
	                uint _11806;
	                if ((_20324 & 1u) != 0u)
	                {
	                    _11806 = g_ScrambledHaltonPermutations.Load<uint>(_16473 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11806 = g_ScrambledHaltonPermutations.Load<uint>(_16473 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11532 * 2093809u) + (_11418 * 1447u)) + _11806) * 3.3006111732625242893846007063985e-10f;
	                _19096 = true;
	                break;
	            }
	            case 229u:
	            {
	                uint _7187 = _12091 % 1451u;
	                uint _16468 = (151848u + _7187) / 2u;
	                uint _11531;
	                if ((_7187 & 1u) != 0u)
	                {
	                    _11531 = g_ScrambledHaltonPermutations.Load<uint>(_16468 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11531 = g_ScrambledHaltonPermutations.Load<uint>(_16468 * 4 + 0) & 65535u;
	                }
	                uint _11711 = (_12091 / 1451u) % 1451u;
	                uint _16469 = (151848u + _11711) / 2u;
	                uint _11417;
	                if ((_11711 & 1u) != 0u)
	                {
	                    _11417 = g_ScrambledHaltonPermutations.Load<uint>(_16469 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11417 = g_ScrambledHaltonPermutations.Load<uint>(_16469 * 4 + 0) & 65535u;
	                }
	                uint _8485 = (_12091 / 2105401u) % 1451u;
	                uint _16470 = (151848u + _8485) / 2u;
	                uint _11805;
	                if ((_8485 & 1u) != 0u)
	                {
	                    _11805 = g_ScrambledHaltonPermutations.Load<uint>(_16470 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11805 = g_ScrambledHaltonPermutations.Load<uint>(_16470 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11531 * 2105401u) + (_11417 * 1451u)) + _11805) * 3.2733896149217400761699536815286e-10f;
	                _19096 = true;
	                break;
	            }
	            case 230u:
	            {
	                uint _15680 = 153299u + (_12091 % 1453u);
	                uint _16465 = _15680 / 2u;
	                uint _11530;
	                if ((_15680 & 1u) != 0u)
	                {
	                    _11530 = g_ScrambledHaltonPermutations.Load<uint>(_16465 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11530 = g_ScrambledHaltonPermutations.Load<uint>(_16465 * 4 + 0) & 65535u;
	                }
	                uint _20319 = 153299u + ((_12091 / 1453u) % 1453u);
	                uint _16466 = _20319 / 2u;
	                uint _11416;
	                if ((_20319 & 1u) != 0u)
	                {
	                    _11416 = g_ScrambledHaltonPermutations.Load<uint>(_16466 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11416 = g_ScrambledHaltonPermutations.Load<uint>(_16466 * 4 + 0) & 65535u;
	                }
	                uint _20320 = 153299u + ((_12091 / 2111209u) % 1453u);
	                uint _16467 = _20320 / 2u;
	                uint _11804;
	                if ((_20320 & 1u) != 0u)
	                {
	                    _11804 = g_ScrambledHaltonPermutations.Load<uint>(_16467 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11804 = g_ScrambledHaltonPermutations.Load<uint>(_16467 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11530 * 2111209u) + (_11416 * 1453u)) + _11804) * 3.2598912458325912666623480618e-10f;
	                _19096 = true;
	                break;
	            }
	            case 231u:
	            {
	                uint _7185 = _12091 % 1459u;
	                uint _16462 = (154752u + _7185) / 2u;
	                uint _11529;
	                if ((_7185 & 1u) != 0u)
	                {
	                    _11529 = g_ScrambledHaltonPermutations.Load<uint>(_16462 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11529 = g_ScrambledHaltonPermutations.Load<uint>(_16462 * 4 + 0) & 65535u;
	                }
	                uint _11709 = (_12091 / 1459u) % 1459u;
	                uint _16463 = (154752u + _11709) / 2u;
	                uint _11415;
	                if ((_11709 & 1u) != 0u)
	                {
	                    _11415 = g_ScrambledHaltonPermutations.Load<uint>(_16463 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11415 = g_ScrambledHaltonPermutations.Load<uint>(_16463 * 4 + 0) & 65535u;
	                }
	                uint _8483 = (_12091 / 2128681u) % 1459u;
	                uint _16464 = (154752u + _8483) / 2u;
	                uint _11803;
	                if ((_8483 & 1u) != 0u)
	                {
	                    _11803 = g_ScrambledHaltonPermutations.Load<uint>(_16464 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11803 = g_ScrambledHaltonPermutations.Load<uint>(_16464 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11529 * 2128681u) + (_11415 * 1459u)) + _11803) * 3.2198382848847018067317549139261e-10f;
	                _19096 = true;
	                break;
	            }
	            case 232u:
	            {
	                uint _15678 = 156211u + (_12091 % 1471u);
	                uint _16459 = _15678 / 2u;
	                uint _11528;
	                if ((_15678 & 1u) != 0u)
	                {
	                    _11528 = g_ScrambledHaltonPermutations.Load<uint>(_16459 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11528 = g_ScrambledHaltonPermutations.Load<uint>(_16459 * 4 + 0) & 65535u;
	                }
	                uint _20315 = 156211u + ((_12091 / 1471u) % 1471u);
	                uint _16460 = _20315 / 2u;
	                uint _11414;
	                if ((_20315 & 1u) != 0u)
	                {
	                    _11414 = g_ScrambledHaltonPermutations.Load<uint>(_16460 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11414 = g_ScrambledHaltonPermutations.Load<uint>(_16460 * 4 + 0) & 65535u;
	                }
	                uint _20316 = 156211u + ((_12091 / 2163841u) % 1471u);
	                uint _16461 = _20316 / 2u;
	                uint _11802;
	                if ((_20316 & 1u) != 0u)
	                {
	                    _11802 = g_ScrambledHaltonPermutations.Load<uint>(_16461 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11802 = g_ScrambledHaltonPermutations.Load<uint>(_16461 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11528 * 2163841u) + (_11414 * 1471u)) + _11802) * 3.1416799717298715677316067740321e-10f;
	                _19096 = true;
	                break;
	            }
	            case 233u:
	            {
	                uint _7183 = _12091 % 1481u;
	                uint _16456 = (157682u + _7183) / 2u;
	                uint _11527;
	                if ((_7183 & 1u) != 0u)
	                {
	                    _11527 = g_ScrambledHaltonPermutations.Load<uint>(_16456 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11527 = g_ScrambledHaltonPermutations.Load<uint>(_16456 * 4 + 0) & 65535u;
	                }
	                uint _11707 = (_12091 / 1481u) % 1481u;
	                uint _16457 = (157682u + _11707) / 2u;
	                uint _11413;
	                if ((_11707 & 1u) != 0u)
	                {
	                    _11413 = g_ScrambledHaltonPermutations.Load<uint>(_16457 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11413 = g_ScrambledHaltonPermutations.Load<uint>(_16457 * 4 + 0) & 65535u;
	                }
	                uint _8481 = (_12091 / 2193361u) % 1481u;
	                uint _16458 = (157682u + _8481) / 2u;
	                uint _11801;
	                if ((_8481 & 1u) != 0u)
	                {
	                    _11801 = g_ScrambledHaltonPermutations.Load<uint>(_16458 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11801 = g_ScrambledHaltonPermutations.Load<uint>(_16458 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11527 * 2193361u) + (_11413 * 1481u)) + _11801) * 3.0784688687113259675243170931935e-10f;
	                _19096 = true;
	                break;
	            }
	            case 234u:
	            {
	                uint _15676 = 159163u + (_12091 % 1483u);
	                uint _16453 = _15676 / 2u;
	                uint _11526;
	                if ((_15676 & 1u) != 0u)
	                {
	                    _11526 = g_ScrambledHaltonPermutations.Load<uint>(_16453 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11526 = g_ScrambledHaltonPermutations.Load<uint>(_16453 * 4 + 0) & 65535u;
	                }
	                uint _20311 = 159163u + ((_12091 / 1483u) % 1483u);
	                uint _16454 = _20311 / 2u;
	                uint _11412;
	                if ((_20311 & 1u) != 0u)
	                {
	                    _11412 = g_ScrambledHaltonPermutations.Load<uint>(_16454 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11412 = g_ScrambledHaltonPermutations.Load<uint>(_16454 * 4 + 0) & 65535u;
	                }
	                uint _20312 = 159163u + ((_12091 / 2199289u) % 1483u);
	                uint _16455 = _20312 / 2u;
	                uint _11800;
	                if ((_20312 & 1u) != 0u)
	                {
	                    _11800 = g_ScrambledHaltonPermutations.Load<uint>(_16455 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11800 = g_ScrambledHaltonPermutations.Load<uint>(_16455 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11526 * 2199289u) + (_11412 * 1483u)) + _11800) * 3.066030762610694182512816041708e-10f;
	                _19096 = true;
	                break;
	            }
	            case 235u:
	            {
	                uint _7181 = _12091 % 1487u;
	                uint _16450 = (160646u + _7181) / 2u;
	                uint _11525;
	                if ((_7181 & 1u) != 0u)
	                {
	                    _11525 = g_ScrambledHaltonPermutations.Load<uint>(_16450 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11525 = g_ScrambledHaltonPermutations.Load<uint>(_16450 * 4 + 0) & 65535u;
	                }
	                uint _11705 = (_12091 / 1487u) % 1487u;
	                uint _16451 = (160646u + _11705) / 2u;
	                uint _11411;
	                if ((_11705 & 1u) != 0u)
	                {
	                    _11411 = g_ScrambledHaltonPermutations.Load<uint>(_16451 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11411 = g_ScrambledHaltonPermutations.Load<uint>(_16451 * 4 + 0) & 65535u;
	                }
	                uint _8479 = (_12091 / 2211169u) % 1487u;
	                uint _16452 = (160646u + _8479) / 2u;
	                uint _11799;
	                if ((_8479 & 1u) != 0u)
	                {
	                    _11799 = g_ScrambledHaltonPermutations.Load<uint>(_16452 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11799 = g_ScrambledHaltonPermutations.Load<uint>(_16452 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11525 * 2211169u) + (_11411 * 1487u)) + _11799) * 3.0413546681096192969562252983451e-10f;
	                _19096 = true;
	                break;
	            }
	            case 236u:
	            {
	                uint _15674 = 162133u + (_12091 % 1489u);
	                uint _16447 = _15674 / 2u;
	                uint _11524;
	                if ((_15674 & 1u) != 0u)
	                {
	                    _11524 = g_ScrambledHaltonPermutations.Load<uint>(_16447 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11524 = g_ScrambledHaltonPermutations.Load<uint>(_16447 * 4 + 0) & 65535u;
	                }
	                uint _20307 = 162133u + ((_12091 / 1489u) % 1489u);
	                uint _16448 = _20307 / 2u;
	                uint _11410;
	                if ((_20307 & 1u) != 0u)
	                {
	                    _11410 = g_ScrambledHaltonPermutations.Load<uint>(_16448 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11410 = g_ScrambledHaltonPermutations.Load<uint>(_16448 * 4 + 0) & 65535u;
	                }
	                uint _20308 = 162133u + ((_12091 / 2217121u) % 1489u);
	                uint _16449 = _20308 / 2u;
	                uint _11798;
	                if ((_20308 & 1u) != 0u)
	                {
	                    _11798 = g_ScrambledHaltonPermutations.Load<uint>(_16449 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11798 = g_ScrambledHaltonPermutations.Load<uint>(_16449 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11524 * 2217121u) + (_11410 * 1489u)) + _11798) * 3.029115847041907727543730288744e-10f;
	                _19096 = true;
	                break;
	            }
	            case 237u:
	            {
	                uint _7179 = _12091 % 1493u;
	                uint _16444 = (163622u + _7179) / 2u;
	                uint _11523;
	                if ((_7179 & 1u) != 0u)
	                {
	                    _11523 = g_ScrambledHaltonPermutations.Load<uint>(_16444 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11523 = g_ScrambledHaltonPermutations.Load<uint>(_16444 * 4 + 0) & 65535u;
	                }
	                uint _11703 = (_12091 / 1493u) % 1493u;
	                uint _16445 = (163622u + _11703) / 2u;
	                uint _11409;
	                if ((_11703 & 1u) != 0u)
	                {
	                    _11409 = g_ScrambledHaltonPermutations.Load<uint>(_16445 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11409 = g_ScrambledHaltonPermutations.Load<uint>(_16445 * 4 + 0) & 65535u;
	                }
	                uint _8477 = (_12091 / 2229049u) % 1493u;
	                uint _16446 = (163622u + _8477) / 2u;
	                uint _11797;
	                if ((_8477 & 1u) != 0u)
	                {
	                    _11797 = g_ScrambledHaltonPermutations.Load<uint>(_16446 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11797 = g_ScrambledHaltonPermutations.Load<uint>(_16446 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11523 * 2229049u) + (_11409 * 1493u)) + _11797) * 3.0048344368260870851372601464391e-10f;
	                _19096 = true;
	                break;
	            }
	            case 238u:
	            {
	                uint _15672 = 165115u + (_12091 % 1499u);
	                uint _16441 = _15672 / 2u;
	                uint _11522;
	                if ((_15672 & 1u) != 0u)
	                {
	                    _11522 = g_ScrambledHaltonPermutations.Load<uint>(_16441 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11522 = g_ScrambledHaltonPermutations.Load<uint>(_16441 * 4 + 0) & 65535u;
	                }
	                uint _20303 = 165115u + ((_12091 / 1499u) % 1499u);
	                uint _16442 = _20303 / 2u;
	                uint _11408;
	                if ((_20303 & 1u) != 0u)
	                {
	                    _11408 = g_ScrambledHaltonPermutations.Load<uint>(_16442 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11408 = g_ScrambledHaltonPermutations.Load<uint>(_16442 * 4 + 0) & 65535u;
	                }
	                uint _20304 = 165115u + ((_12091 / 2247001u) % 1499u);
	                uint _16443 = _20304 / 2u;
	                uint _11796;
	                if ((_20304 & 1u) != 0u)
	                {
	                    _11796 = g_ScrambledHaltonPermutations.Load<uint>(_16443 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11796 = g_ScrambledHaltonPermutations.Load<uint>(_16443 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11522 * 2247001u) + (_11408 * 1499u)) + _11796) * 2.968896517518970767923747189343e-10f;
	                _19096 = true;
	                break;
	            }
	            case 239u:
	            {
	                uint _7177 = _12091 % 1511u;
	                uint _16438 = (166614u + _7177) / 2u;
	                uint _11521;
	                if ((_7177 & 1u) != 0u)
	                {
	                    _11521 = g_ScrambledHaltonPermutations.Load<uint>(_16438 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11521 = g_ScrambledHaltonPermutations.Load<uint>(_16438 * 4 + 0) & 65535u;
	                }
	                uint _11701 = (_12091 / 1511u) % 1511u;
	                uint _16439 = (166614u + _11701) / 2u;
	                uint _11407;
	                if ((_11701 & 1u) != 0u)
	                {
	                    _11407 = g_ScrambledHaltonPermutations.Load<uint>(_16439 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11407 = g_ScrambledHaltonPermutations.Load<uint>(_16439 * 4 + 0) & 65535u;
	                }
	                uint _8475 = (_12091 / 2283121u) % 1511u;
	                uint _16440 = (166614u + _8475) / 2u;
	                uint _11795;
	                if ((_8475 & 1u) != 0u)
	                {
	                    _11795 = g_ScrambledHaltonPermutations.Load<uint>(_16440 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11795 = g_ScrambledHaltonPermutations.Load<uint>(_16440 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11521 * 2283121u) + (_11407 * 1511u)) + _11795) * 2.8987218181342200296057853847742e-10f;
	                _19096 = true;
	                break;
	            }
	            case 240u:
	            {
	                uint _15670 = 168125u + (_12091 % 1523u);
	                uint _16435 = _15670 / 2u;
	                uint _11520;
	                if ((_15670 & 1u) != 0u)
	                {
	                    _11520 = g_ScrambledHaltonPermutations.Load<uint>(_16435 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11520 = g_ScrambledHaltonPermutations.Load<uint>(_16435 * 4 + 0) & 65535u;
	                }
	                uint _20299 = 168125u + ((_12091 / 1523u) % 1523u);
	                uint _16436 = _20299 / 2u;
	                uint _11406;
	                if ((_20299 & 1u) != 0u)
	                {
	                    _11406 = g_ScrambledHaltonPermutations.Load<uint>(_16436 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11406 = g_ScrambledHaltonPermutations.Load<uint>(_16436 * 4 + 0) & 65535u;
	                }
	                uint _20300 = 168125u + ((_12091 / 2319529u) % 1523u);
	                uint _16437 = _20300 / 2u;
	                uint _11794;
	                if ((_20300 & 1u) != 0u)
	                {
	                    _11794 = g_ScrambledHaltonPermutations.Load<uint>(_16437 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11794 = g_ScrambledHaltonPermutations.Load<uint>(_16437 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11520 * 2319529u) + (_11406 * 1523u)) + _11794) * 2.8307417521133970694791059941053e-10f;
	                _19096 = true;
	                break;
	            }
	            case 241u:
	            {
	                uint _7175 = _12091 % 1531u;
	                uint _16432 = (169648u + _7175) / 2u;
	                uint _11519;
	                if ((_7175 & 1u) != 0u)
	                {
	                    _11519 = g_ScrambledHaltonPermutations.Load<uint>(_16432 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11519 = g_ScrambledHaltonPermutations.Load<uint>(_16432 * 4 + 0) & 65535u;
	                }
	                uint _11699 = (_12091 / 1531u) % 1531u;
	                uint _16433 = (169648u + _11699) / 2u;
	                uint _11405;
	                if ((_11699 & 1u) != 0u)
	                {
	                    _11405 = g_ScrambledHaltonPermutations.Load<uint>(_16433 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11405 = g_ScrambledHaltonPermutations.Load<uint>(_16433 * 4 + 0) & 65535u;
	                }
	                uint _8473 = (_12091 / 2343961u) % 1531u;
	                uint _16434 = (169648u + _8473) / 2u;
	                uint _11793;
	                if ((_8473 & 1u) != 0u)
	                {
	                    _11793 = g_ScrambledHaltonPermutations.Load<uint>(_16434 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11793 = g_ScrambledHaltonPermutations.Load<uint>(_16434 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11519 * 2343961u) + (_11405 * 1531u)) + _11793) * 2.7865981744312762202753219753504e-10f;
	                _19096 = true;
	                break;
	            }
	            case 242u:
	            {
	                uint _15668 = 171179u + (_12091 % 1543u);
	                uint _16429 = _15668 / 2u;
	                uint _11518;
	                if ((_15668 & 1u) != 0u)
	                {
	                    _11518 = g_ScrambledHaltonPermutations.Load<uint>(_16429 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11518 = g_ScrambledHaltonPermutations.Load<uint>(_16429 * 4 + 0) & 65535u;
	                }
	                uint _20295 = 171179u + ((_12091 / 1543u) % 1543u);
	                uint _16430 = _20295 / 2u;
	                uint _11404;
	                if ((_20295 & 1u) != 0u)
	                {
	                    _11404 = g_ScrambledHaltonPermutations.Load<uint>(_16430 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11404 = g_ScrambledHaltonPermutations.Load<uint>(_16430 * 4 + 0) & 65535u;
	                }
	                uint _20296 = 171179u + ((_12091 / 2380849u) % 1543u);
	                uint _16431 = _20296 / 2u;
	                uint _11792;
	                if ((_20296 & 1u) != 0u)
	                {
	                    _11792 = g_ScrambledHaltonPermutations.Load<uint>(_16431 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11792 = g_ScrambledHaltonPermutations.Load<uint>(_16431 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11518 * 2380849u) + (_11404 * 1543u)) + _11792) * 2.7220881104739191869157366454601e-10f;
	                _19096 = true;
	                break;
	            }
	            case 243u:
	            {
	                uint _7173 = _12091 % 1549u;
	                uint _16426 = (172722u + _7173) / 2u;
	                uint _11517;
	                if ((_7173 & 1u) != 0u)
	                {
	                    _11517 = g_ScrambledHaltonPermutations.Load<uint>(_16426 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11517 = g_ScrambledHaltonPermutations.Load<uint>(_16426 * 4 + 0) & 65535u;
	                }
	                uint _11697 = (_12091 / 1549u) % 1549u;
	                uint _16427 = (172722u + _11697) / 2u;
	                uint _11403;
	                if ((_11697 & 1u) != 0u)
	                {
	                    _11403 = g_ScrambledHaltonPermutations.Load<uint>(_16427 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11403 = g_ScrambledHaltonPermutations.Load<uint>(_16427 * 4 + 0) & 65535u;
	                }
	                uint _8471 = (_12091 / 2399401u) % 1549u;
	                uint _16428 = (172722u + _8471) / 2u;
	                uint _11791;
	                if ((_8471 & 1u) != 0u)
	                {
	                    _11791 = g_ScrambledHaltonPermutations.Load<uint>(_16428 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11791 = g_ScrambledHaltonPermutations.Load<uint>(_16428 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11517 * 2399401u) + (_11403 * 1549u)) + _11791) * 2.6905785932562764628528384491801e-10f;
	                _19096 = true;
	                break;
	            }
	            case 244u:
	            {
	                uint _15666 = 174271u + (_12091 % 1553u);
	                uint _16423 = _15666 / 2u;
	                uint _11516;
	                if ((_15666 & 1u) != 0u)
	                {
	                    _11516 = g_ScrambledHaltonPermutations.Load<uint>(_16423 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11516 = g_ScrambledHaltonPermutations.Load<uint>(_16423 * 4 + 0) & 65535u;
	                }
	                uint _20291 = 174271u + ((_12091 / 1553u) % 1553u);
	                uint _16424 = _20291 / 2u;
	                uint _11402;
	                if ((_20291 & 1u) != 0u)
	                {
	                    _11402 = g_ScrambledHaltonPermutations.Load<uint>(_16424 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11402 = g_ScrambledHaltonPermutations.Load<uint>(_16424 * 4 + 0) & 65535u;
	                }
	                uint _20292 = 174271u + ((_12091 / 2411809u) % 1553u);
	                uint _16425 = _20292 / 2u;
	                uint _11790;
	                if ((_20292 & 1u) != 0u)
	                {
	                    _11790 = g_ScrambledHaltonPermutations.Load<uint>(_16425 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11790 = g_ScrambledHaltonPermutations.Load<uint>(_16425 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11516 * 2411809u) + (_11402 * 1553u)) + _11790) * 2.6698421251580839452799409627914e-10f;
	                _19096 = true;
	                break;
	            }
	            case 245u:
	            {
	                uint _7171 = _12091 % 1559u;
	                uint _16420 = (175824u + _7171) / 2u;
	                uint _11515;
	                if ((_7171 & 1u) != 0u)
	                {
	                    _11515 = g_ScrambledHaltonPermutations.Load<uint>(_16420 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11515 = g_ScrambledHaltonPermutations.Load<uint>(_16420 * 4 + 0) & 65535u;
	                }
	                uint _11695 = (_12091 / 1559u) % 1559u;
	                uint _16421 = (175824u + _11695) / 2u;
	                uint _11401;
	                if ((_11695 & 1u) != 0u)
	                {
	                    _11401 = g_ScrambledHaltonPermutations.Load<uint>(_16421 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11401 = g_ScrambledHaltonPermutations.Load<uint>(_16421 * 4 + 0) & 65535u;
	                }
	                uint _8469 = (_12091 / 2430481u) % 1559u;
	                uint _16422 = (175824u + _8469) / 2u;
	                uint _11789;
	                if ((_8469 & 1u) != 0u)
	                {
	                    _11789 = g_ScrambledHaltonPermutations.Load<uint>(_16422 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11789 = g_ScrambledHaltonPermutations.Load<uint>(_16422 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11515 * 2430481u) + (_11401 * 1559u)) + _11789) * 2.6391350216314890531066339462996e-10f;
	                _19096 = true;
	                break;
	            }
	            case 246u:
	            {
	                uint _15664 = 177383u + (_12091 % 1567u);
	                uint _16417 = _15664 / 2u;
	                uint _11514;
	                if ((_15664 & 1u) != 0u)
	                {
	                    _11514 = g_ScrambledHaltonPermutations.Load<uint>(_16417 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11514 = g_ScrambledHaltonPermutations.Load<uint>(_16417 * 4 + 0) & 65535u;
	                }
	                uint _20287 = 177383u + ((_12091 / 1567u) % 1567u);
	                uint _16418 = _20287 / 2u;
	                uint _11400;
	                if ((_20287 & 1u) != 0u)
	                {
	                    _11400 = g_ScrambledHaltonPermutations.Load<uint>(_16418 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11400 = g_ScrambledHaltonPermutations.Load<uint>(_16418 * 4 + 0) & 65535u;
	                }
	                uint _20288 = 177383u + ((_12091 / 2455489u) % 1567u);
	                uint _16419 = _20288 / 2u;
	                uint _11788;
	                if ((_20288 & 1u) != 0u)
	                {
	                    _11788 = g_ScrambledHaltonPermutations.Load<uint>(_16419 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11788 = g_ScrambledHaltonPermutations.Load<uint>(_16419 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11514 * 2455489u) + (_11400 * 1567u)) + _11788) * 2.5989202456777604766102740541101e-10f;
	                _19096 = true;
	                break;
	            }
	            case 247u:
	            {
	                uint _7169 = _12091 % 1571u;
	                uint _16414 = (178950u + _7169) / 2u;
	                uint _11513;
	                if ((_7169 & 1u) != 0u)
	                {
	                    _11513 = g_ScrambledHaltonPermutations.Load<uint>(_16414 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11513 = g_ScrambledHaltonPermutations.Load<uint>(_16414 * 4 + 0) & 65535u;
	                }
	                uint _11693 = (_12091 / 1571u) % 1571u;
	                uint _16415 = (178950u + _11693) / 2u;
	                uint _11399;
	                if ((_11693 & 1u) != 0u)
	                {
	                    _11399 = g_ScrambledHaltonPermutations.Load<uint>(_16415 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11399 = g_ScrambledHaltonPermutations.Load<uint>(_16415 * 4 + 0) & 65535u;
	                }
	                uint _8467 = (_12091 / 2468041u) % 1571u;
	                uint _16416 = (178950u + _8467) / 2u;
	                uint _11787;
	                if ((_8467 & 1u) != 0u)
	                {
	                    _11787 = g_ScrambledHaltonPermutations.Load<uint>(_16416 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11787 = g_ScrambledHaltonPermutations.Load<uint>(_16416 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11513 * 2468041u) + (_11399 * 1571u)) + _11787) * 2.5791191404778146534226834774017e-10f;
	                _19096 = true;
	                break;
	            }
	            case 248u:
	            {
	                uint _15662 = 180521u + (_12091 % 1579u);
	                uint _16411 = _15662 / 2u;
	                uint _11512;
	                if ((_15662 & 1u) != 0u)
	                {
	                    _11512 = g_ScrambledHaltonPermutations.Load<uint>(_16411 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11512 = g_ScrambledHaltonPermutations.Load<uint>(_16411 * 4 + 0) & 65535u;
	                }
	                uint _20283 = 180521u + ((_12091 / 1579u) % 1579u);
	                uint _16412 = _20283 / 2u;
	                uint _11398;
	                if ((_20283 & 1u) != 0u)
	                {
	                    _11398 = g_ScrambledHaltonPermutations.Load<uint>(_16412 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11398 = g_ScrambledHaltonPermutations.Load<uint>(_16412 * 4 + 0) & 65535u;
	                }
	                uint _20284 = 180521u + ((_12091 / 2493241u) % 1579u);
	                uint _16413 = _20284 / 2u;
	                uint _11786;
	                if ((_20284 & 1u) != 0u)
	                {
	                    _11786 = g_ScrambledHaltonPermutations.Load<uint>(_16413 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11786 = g_ScrambledHaltonPermutations.Load<uint>(_16413 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11512 * 2493241u) + (_11398 * 1579u)) + _11786) * 2.54011589539970827900106087327e-10f;
	                _19096 = true;
	                break;
	            }
	            case 249u:
	            {
	                uint _7167 = _12091 % 1583u;
	                uint _16408 = (182100u + _7167) / 2u;
	                uint _11511;
	                if ((_7167 & 1u) != 0u)
	                {
	                    _11511 = g_ScrambledHaltonPermutations.Load<uint>(_16408 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11511 = g_ScrambledHaltonPermutations.Load<uint>(_16408 * 4 + 0) & 65535u;
	                }
	                uint _11691 = (_12091 / 1583u) % 1583u;
	                uint _16409 = (182100u + _11691) / 2u;
	                uint _11397;
	                if ((_11691 & 1u) != 0u)
	                {
	                    _11397 = g_ScrambledHaltonPermutations.Load<uint>(_16409 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11397 = g_ScrambledHaltonPermutations.Load<uint>(_16409 * 4 + 0) & 65535u;
	                }
	                uint _8465 = (_12091 / 2505889u) % 1583u;
	                uint _16410 = (182100u + _8465) / 2u;
	                uint _11785;
	                if ((_8465 & 1u) != 0u)
	                {
	                    _11785 = g_ScrambledHaltonPermutations.Load<uint>(_16410 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11785 = g_ScrambledHaltonPermutations.Load<uint>(_16410 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11511 * 2505889u) + (_11397 * 1583u)) + _11785) * 2.5209090370736930708517320454121e-10f;
	                _19096 = true;
	                break;
	            }
	            case 250u:
	            {
	                uint _15660 = 183683u + (_12091 % 1597u);
	                uint _16405 = _15660 / 2u;
	                uint _11510;
	                if ((_15660 & 1u) != 0u)
	                {
	                    _11510 = g_ScrambledHaltonPermutations.Load<uint>(_16405 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11510 = g_ScrambledHaltonPermutations.Load<uint>(_16405 * 4 + 0) & 65535u;
	                }
	                uint _20279 = 183683u + ((_12091 / 1597u) % 1597u);
	                uint _16406 = _20279 / 2u;
	                uint _11396;
	                if ((_20279 & 1u) != 0u)
	                {
	                    _11396 = g_ScrambledHaltonPermutations.Load<uint>(_16406 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11396 = g_ScrambledHaltonPermutations.Load<uint>(_16406 * 4 + 0) & 65535u;
	                }
	                uint _20280 = 183683u + ((_12091 / 2550409u) % 1597u);
	                uint _16407 = _20280 / 2u;
	                uint _11784;
	                if ((_20280 & 1u) != 0u)
	                {
	                    _11784 = g_ScrambledHaltonPermutations.Load<uint>(_16407 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11784 = g_ScrambledHaltonPermutations.Load<uint>(_16407 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11510 * 2550409u) + (_11396 * 1597u)) + _11784) * 2.4551904953540315545978955924511e-10f;
	                _19096 = true;
	                break;
	            }
	            case 251u:
	            {
	                uint _7165 = _12091 % 1601u;
	                uint _16402 = (185280u + _7165) / 2u;
	                uint _11509;
	                if ((_7165 & 1u) != 0u)
	                {
	                    _11509 = g_ScrambledHaltonPermutations.Load<uint>(_16402 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11509 = g_ScrambledHaltonPermutations.Load<uint>(_16402 * 4 + 0) & 65535u;
	                }
	                uint _11689 = (_12091 / 1601u) % 1601u;
	                uint _16403 = (185280u + _11689) / 2u;
	                uint _11395;
	                if ((_11689 & 1u) != 0u)
	                {
	                    _11395 = g_ScrambledHaltonPermutations.Load<uint>(_16403 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11395 = g_ScrambledHaltonPermutations.Load<uint>(_16403 * 4 + 0) & 65535u;
	                }
	                uint _8463 = (_12091 / 2563201u) % 1601u;
	                uint _16404 = (185280u + _8463) / 2u;
	                uint _11783;
	                if ((_8463 & 1u) != 0u)
	                {
	                    _11783 = g_ScrambledHaltonPermutations.Load<uint>(_16404 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11783 = g_ScrambledHaltonPermutations.Load<uint>(_16404 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11509 * 2563201u) + (_11395 * 1601u)) + _11783) * 2.4368340678648792163585312664509e-10f;
	                _19096 = true;
	                break;
	            }
	            case 252u:
	            {
	                uint _15658 = 186881u + (_12091 % 1607u);
	                uint _16399 = _15658 / 2u;
	                uint _11508;
	                if ((_15658 & 1u) != 0u)
	                {
	                    _11508 = g_ScrambledHaltonPermutations.Load<uint>(_16399 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11508 = g_ScrambledHaltonPermutations.Load<uint>(_16399 * 4 + 0) & 65535u;
	                }
	                uint _20275 = 186881u + ((_12091 / 1607u) % 1607u);
	                uint _16400 = _20275 / 2u;
	                uint _11394;
	                if ((_20275 & 1u) != 0u)
	                {
	                    _11394 = g_ScrambledHaltonPermutations.Load<uint>(_16400 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11394 = g_ScrambledHaltonPermutations.Load<uint>(_16400 * 4 + 0) & 65535u;
	                }
	                uint _20276 = 186881u + ((_12091 / 2582449u) % 1607u);
	                uint _16401 = _20276 / 2u;
	                uint _11782;
	                if ((_20276 & 1u) != 0u)
	                {
	                    _11782 = g_ScrambledHaltonPermutations.Load<uint>(_16401 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11782 = g_ScrambledHaltonPermutations.Load<uint>(_16401 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11508 * 2582449u) + (_11394 * 1607u)) + _11782) * 2.4096408202112229446356650441885e-10f;
	                _19096 = true;
	                break;
	            }
	            case 253u:
	            {
	                uint _7162 = _12091 % 1609u;
	                uint _16396 = (188488u + _7162) / 2u;
	                uint _11507;
	                if ((_7162 & 1u) != 0u)
	                {
	                    _11507 = g_ScrambledHaltonPermutations.Load<uint>(_16396 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11507 = g_ScrambledHaltonPermutations.Load<uint>(_16396 * 4 + 0) & 65535u;
	                }
	                uint _11687 = (_12091 / 1609u) % 1609u;
	                uint _16397 = (188488u + _11687) / 2u;
	                uint _11393;
	                if ((_11687 & 1u) != 0u)
	                {
	                    _11393 = g_ScrambledHaltonPermutations.Load<uint>(_16397 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11393 = g_ScrambledHaltonPermutations.Load<uint>(_16397 * 4 + 0) & 65535u;
	                }
	                uint _8461 = (_12091 / 2588881u) % 1609u;
	                uint _16398 = (188488u + _8461) / 2u;
	                uint _11781;
	                if ((_8461 & 1u) != 0u)
	                {
	                    _11781 = g_ScrambledHaltonPermutations.Load<uint>(_16398 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11781 = g_ScrambledHaltonPermutations.Load<uint>(_16398 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11507 * 2588881u) + (_11393 * 1609u)) + _11781) * 2.4006663323916654917411506175995e-10f;
	                _19096 = true;
	                break;
	            }
	            case 254u:
	            {
	                uint _15656 = 190097u + (_12091 % 1613u);
	                uint _16392 = _15656 / 2u;
	                uint _11506;
	                if ((_15656 & 1u) != 0u)
	                {
	                    _11506 = g_ScrambledHaltonPermutations.Load<uint>(_16392 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11506 = g_ScrambledHaltonPermutations.Load<uint>(_16392 * 4 + 0) & 65535u;
	                }
	                uint _20271 = 190097u + ((_12091 / 1613u) % 1613u);
	                uint _16393 = _20271 / 2u;
	                uint _11392;
	                if ((_20271 & 1u) != 0u)
	                {
	                    _11392 = g_ScrambledHaltonPermutations.Load<uint>(_16393 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11392 = g_ScrambledHaltonPermutations.Load<uint>(_16393 * 4 + 0) & 65535u;
	                }
	                uint _20272 = 190097u + ((_12091 / 2601769u) % 1613u);
	                uint _16395 = _20272 / 2u;
	                uint _11780;
	                if ((_20272 & 1u) != 0u)
	                {
	                    _11780 = g_ScrambledHaltonPermutations.Load<uint>(_16395 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11780 = g_ScrambledHaltonPermutations.Load<uint>(_16395 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11506 * 2601769u) + (_11392 * 1613u)) + _11780) * 2.3828508610712617610261077061296e-10f;
	                _19096 = true;
	                break;
	            }
	            case 255u:
	            {
	                uint _8774 = _12091 % 1619u;
	                uint _16389 = (191710u + _8774) / 2u;
	                uint _11505;
	                if ((_8774 & 1u) != 0u)
	                {
	                    _11505 = g_ScrambledHaltonPermutations.Load<uint>(_16389 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11505 = g_ScrambledHaltonPermutations.Load<uint>(_16389 * 4 + 0) & 65535u;
	                }
	                uint _11685 = (_12091 / 1619u) % 1619u;
	                uint _16390 = (191710u + _11685) / 2u;
	                uint _11391;
	                if ((_11685 & 1u) != 0u)
	                {
	                    _11391 = g_ScrambledHaltonPermutations.Load<uint>(_16390 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11391 = g_ScrambledHaltonPermutations.Load<uint>(_16390 * 4 + 0) & 65535u;
	                }
	                uint _8459 = (_12091 / 2621161u) % 1619u;
	                uint _16391 = (191710u + _8459) / 2u;
	                uint _11779;
	                if ((_8459 & 1u) != 0u)
	                {
	                    _11779 = g_ScrambledHaltonPermutations.Load<uint>(_16391 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _11779 = g_ScrambledHaltonPermutations.Load<uint>(_16391 * 4 + 0) & 65535u;
	                }
	                _19095 = float(((_11505 * 2621161u) + (_11391 * 1619u)) + _11779) * 2.3564564188838232894340762868524e-10f;
	                _19096 = true;
	                break;
	            }
	            default:
	            {
	                _19095 = _2;
	                _19096 = false;
	                break;
	            }
	        }
	        if (_19096)
	        {
	            _19097 = _19095;
	            break;
	        }
	        _19097 = 0.0f;
	        break;
	    } while(false);
	    float _33363;
	    do
	    {
	        float _33359;
	        bool _33360;
	        switch (_7315 + 1u)
	        {
	            case 0u:
	            {
	                uint _33332 = (_12091 << uint(16)) | (_12091 >> uint(16));
	                uint _33337 = ((_33332 & 16711935u) << uint(8)) | ((_33332 & 4278255360u) >> uint(8));
	                uint _33342 = ((_33337 & 252645135u) << uint(4)) | ((_33337 & 4042322160u) >> uint(4));
	                uint _33347 = ((_33342 & 858993459u) << uint(2)) | ((_33342 & 3435973836u) >> uint(2));
	                _33359 = asfloat(1065353216u | ((((_33347 & 1431655765u) << uint(1)) | ((_33347 & 2863311530u) >> uint(1))) >> uint(9))) - 1.0f;
	                _33360 = true;
	                break;
	            }
	            case 1u:
	            {
	                uint _33272 = _12091 % 243u;
	                uint _33273 = _33272 / 2u;
	                uint _33283;
	                if ((_33272 & 1u) != 0u)
	                {
	                    _33283 = g_ScrambledHaltonPermutations.Load<uint>(_33273 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _33283 = g_ScrambledHaltonPermutations.Load<uint>(_33273 * 4 + 0) & 65535u;
	                }
	                uint _33286 = (_12091 / 243u) % 243u;
	                uint _33287 = _33286 / 2u;
	                uint _33297;
	                if ((_33286 & 1u) != 0u)
	                {
	                    _33297 = g_ScrambledHaltonPermutations.Load<uint>(_33287 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _33297 = g_ScrambledHaltonPermutations.Load<uint>(_33287 * 4 + 0) & 65535u;
	                }
	                uint _33300 = (_12091 / 59049u) % 243u;
	                uint _33301 = _33300 / 2u;
	                uint _33311;
	                if ((_33300 & 1u) != 0u)
	                {
	                    _33311 = g_ScrambledHaltonPermutations.Load<uint>(_33301 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _33311 = g_ScrambledHaltonPermutations.Load<uint>(_33301 * 4 + 0) & 65535u;
	                }
	                uint _33314 = (_12091 / 14348907u) % 243u;
	                uint _33315 = _33314 / 2u;
	                uint _33325;
	                if ((_33314 & 1u) != 0u)
	                {
	                    _33325 = g_ScrambledHaltonPermutations.Load<uint>(_33315 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _33325 = g_ScrambledHaltonPermutations.Load<uint>(_33315 * 4 + 0) & 65535u;
	                }
	                _33359 = float((((_33283 * 14348907u) + (_33297 * 59049u)) + (_33311 * 243u)) + _33325) * 2.8679716934654209126165369525552e-10f;
	                _33360 = true;
	                break;
	            }
	            case 2u:
	            {
	                uint _33211 = 243u + (_12091 % 125u);
	                uint _33212 = _33211 / 2u;
	                uint _33222;
	                if ((_33211 & 1u) != 0u)
	                {
	                    _33222 = g_ScrambledHaltonPermutations.Load<uint>(_33212 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _33222 = g_ScrambledHaltonPermutations.Load<uint>(_33212 * 4 + 0) & 65535u;
	                }
	                uint _33226 = 243u + ((_12091 / 125u) % 125u);
	                uint _33227 = _33226 / 2u;
	                uint _33237;
	                if ((_33226 & 1u) != 0u)
	                {
	                    _33237 = g_ScrambledHaltonPermutations.Load<uint>(_33227 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _33237 = g_ScrambledHaltonPermutations.Load<uint>(_33227 * 4 + 0) & 65535u;
	                }
	                uint _33241 = 243u + ((_12091 / 15625u) % 125u);
	                uint _33242 = _33241 / 2u;
	                uint _33252;
	                if ((_33241 & 1u) != 0u)
	                {
	                    _33252 = g_ScrambledHaltonPermutations.Load<uint>(_33242 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _33252 = g_ScrambledHaltonPermutations.Load<uint>(_33242 * 4 + 0) & 65535u;
	                }
	                uint _33256 = 243u + ((_12091 / 1953125u) % 125u);
	                uint _33257 = _33256 / 2u;
	                uint _33267;
	                if ((_33256 & 1u) != 0u)
	                {
	                    _33267 = g_ScrambledHaltonPermutations.Load<uint>(_33257 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _33267 = g_ScrambledHaltonPermutations.Load<uint>(_33257 * 4 + 0) & 65535u;
	                }
	                _33359 = float((((_33222 * 1953125u) + (_33237 * 15625u)) + (_33252 * 125u)) + _33267) * 4.0959995395439818821614608168602e-09f;
	                _33360 = true;
	                break;
	            }
	            case 3u:
	            {
	                uint _33163 = _12091 % 343u;
	                uint _33165 = (368u + _33163) / 2u;
	                uint _33175;
	                if ((_33163 & 1u) != 0u)
	                {
	                    _33175 = g_ScrambledHaltonPermutations.Load<uint>(_33165 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _33175 = g_ScrambledHaltonPermutations.Load<uint>(_33165 * 4 + 0) & 65535u;
	                }
	                uint _33178 = (_12091 / 343u) % 343u;
	                uint _33180 = (368u + _33178) / 2u;
	                uint _33190;
	                if ((_33178 & 1u) != 0u)
	                {
	                    _33190 = g_ScrambledHaltonPermutations.Load<uint>(_33180 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _33190 = g_ScrambledHaltonPermutations.Load<uint>(_33180 * 4 + 0) & 65535u;
	                }
	                uint _33193 = (_12091 / 117649u) % 343u;
	                uint _33195 = (368u + _33193) / 2u;
	                uint _33205;
	                if ((_33193 & 1u) != 0u)
	                {
	                    _33205 = g_ScrambledHaltonPermutations.Load<uint>(_33195 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _33205 = g_ScrambledHaltonPermutations.Load<uint>(_33195 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_33175 * 117649u) + (_33190 * 343u)) + _33205) * 2.47809293085765602882020175457e-08f;
	                _33360 = true;
	                break;
	            }
	            case 4u:
	            {
	                uint _33102 = 711u + (_12091 % 121u);
	                uint _33103 = _33102 / 2u;
	                uint _33113;
	                if ((_33102 & 1u) != 0u)
	                {
	                    _33113 = g_ScrambledHaltonPermutations.Load<uint>(_33103 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _33113 = g_ScrambledHaltonPermutations.Load<uint>(_33103 * 4 + 0) & 65535u;
	                }
	                uint _33117 = 711u + ((_12091 / 121u) % 121u);
	                uint _33118 = _33117 / 2u;
	                uint _33128;
	                if ((_33117 & 1u) != 0u)
	                {
	                    _33128 = g_ScrambledHaltonPermutations.Load<uint>(_33118 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _33128 = g_ScrambledHaltonPermutations.Load<uint>(_33118 * 4 + 0) & 65535u;
	                }
	                uint _33132 = 711u + ((_12091 / 14641u) % 121u);
	                uint _33133 = _33132 / 2u;
	                uint _33143;
	                if ((_33132 & 1u) != 0u)
	                {
	                    _33143 = g_ScrambledHaltonPermutations.Load<uint>(_33133 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _33143 = g_ScrambledHaltonPermutations.Load<uint>(_33133 * 4 + 0) & 65535u;
	                }
	                uint _33147 = 711u + ((_12091 / 1771561u) % 121u);
	                uint _33148 = _33147 / 2u;
	                uint _33158;
	                if ((_33147 & 1u) != 0u)
	                {
	                    _33158 = g_ScrambledHaltonPermutations.Load<uint>(_33148 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _33158 = g_ScrambledHaltonPermutations.Load<uint>(_33148 * 4 + 0) & 65535u;
	                }
	                _33359 = float((((_33113 * 1771561u) + (_33128 * 14641u)) + (_33143 * 121u)) + _33158) * 4.6650732166142461210256442427635e-09f;
	                _33360 = true;
	                break;
	            }
	            case 5u:
	            {
	                uint _33039 = _12091 % 169u;
	                uint _33041 = (832u + _33039) / 2u;
	                uint _33051;
	                if ((_33039 & 1u) != 0u)
	                {
	                    _33051 = g_ScrambledHaltonPermutations.Load<uint>(_33041 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _33051 = g_ScrambledHaltonPermutations.Load<uint>(_33041 * 4 + 0) & 65535u;
	                }
	                uint _33054 = (_12091 / 169u) % 169u;
	                uint _33056 = (832u + _33054) / 2u;
	                uint _33066;
	                if ((_33054 & 1u) != 0u)
	                {
	                    _33066 = g_ScrambledHaltonPermutations.Load<uint>(_33056 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _33066 = g_ScrambledHaltonPermutations.Load<uint>(_33056 * 4 + 0) & 65535u;
	                }
	                uint _33069 = (_12091 / 28561u) % 169u;
	                uint _33071 = (832u + _33069) / 2u;
	                uint _33081;
	                if ((_33069 & 1u) != 0u)
	                {
	                    _33081 = g_ScrambledHaltonPermutations.Load<uint>(_33071 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _33081 = g_ScrambledHaltonPermutations.Load<uint>(_33071 * 4 + 0) & 65535u;
	                }
	                uint _33084 = (_12091 / 4826809u) % 169u;
	                uint _33086 = (832u + _33084) / 2u;
	                uint _33096;
	                if ((_33084 & 1u) != 0u)
	                {
	                    _33096 = g_ScrambledHaltonPermutations.Load<uint>(_33086 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _33096 = g_ScrambledHaltonPermutations.Load<uint>(_33086 * 4 + 0) & 65535u;
	                }
	                _33359 = float((((_33051 * 4826809u) + (_33066 * 28561u)) + (_33081 * 169u)) + _33096) * 1.2258944970255924999946728348732e-09f;
	                _33360 = true;
	                break;
	            }
	            case 6u:
	            {
	                uint _32993 = 1001u + (_12091 % 289u);
	                uint _32994 = _32993 / 2u;
	                uint _33004;
	                if ((_32993 & 1u) != 0u)
	                {
	                    _33004 = g_ScrambledHaltonPermutations.Load<uint>(_32994 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _33004 = g_ScrambledHaltonPermutations.Load<uint>(_32994 * 4 + 0) & 65535u;
	                }
	                uint _33008 = 1001u + ((_12091 / 289u) % 289u);
	                uint _33009 = _33008 / 2u;
	                uint _33019;
	                if ((_33008 & 1u) != 0u)
	                {
	                    _33019 = g_ScrambledHaltonPermutations.Load<uint>(_33009 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _33019 = g_ScrambledHaltonPermutations.Load<uint>(_33009 * 4 + 0) & 65535u;
	                }
	                uint _33023 = 1001u + ((_12091 / 83521u) % 289u);
	                uint _33024 = _33023 / 2u;
	                uint _33034;
	                if ((_33023 & 1u) != 0u)
	                {
	                    _33034 = g_ScrambledHaltonPermutations.Load<uint>(_33024 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _33034 = g_ScrambledHaltonPermutations.Load<uint>(_33024 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_33004 * 83521u) + (_33019 * 289u)) + _33034) * 4.1429188968322705477476119995117e-08f;
	                _33360 = true;
	                break;
	            }
	            case 7u:
	            {
	                uint _32945 = _12091 % 361u;
	                uint _32947 = (1290u + _32945) / 2u;
	                uint _32957;
	                if ((_32945 & 1u) != 0u)
	                {
	                    _32957 = g_ScrambledHaltonPermutations.Load<uint>(_32947 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _32957 = g_ScrambledHaltonPermutations.Load<uint>(_32947 * 4 + 0) & 65535u;
	                }
	                uint _32960 = (_12091 / 361u) % 361u;
	                uint _32962 = (1290u + _32960) / 2u;
	                uint _32972;
	                if ((_32960 & 1u) != 0u)
	                {
	                    _32972 = g_ScrambledHaltonPermutations.Load<uint>(_32962 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _32972 = g_ScrambledHaltonPermutations.Load<uint>(_32962 * 4 + 0) & 65535u;
	                }
	                uint _32975 = (_12091 / 130321u) % 361u;
	                uint _32977 = (1290u + _32975) / 2u;
	                uint _32987;
	                if ((_32975 & 1u) != 0u)
	                {
	                    _32987 = g_ScrambledHaltonPermutations.Load<uint>(_32977 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _32987 = g_ScrambledHaltonPermutations.Load<uint>(_32977 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_32957 * 130321u) + (_32972 * 361u)) + _32987) * 2.1255843307699251454323530197144e-08f;
	                _33360 = true;
	                break;
	            }
	            case 8u:
	            {
	                uint _32839 = 1651u + (_12091 % 23u);
	                uint _32840 = _32839 / 2u;
	                uint _32850;
	                if ((_32839 & 1u) != 0u)
	                {
	                    _32850 = g_ScrambledHaltonPermutations.Load<uint>(_32840 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _32850 = g_ScrambledHaltonPermutations.Load<uint>(_32840 * 4 + 0) & 65535u;
	                }
	                uint _32854 = 1651u + ((_12091 / 23u) % 23u);
	                uint _32855 = _32854 / 2u;
	                uint _32865;
	                if ((_32854 & 1u) != 0u)
	                {
	                    _32865 = g_ScrambledHaltonPermutations.Load<uint>(_32855 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _32865 = g_ScrambledHaltonPermutations.Load<uint>(_32855 * 4 + 0) & 65535u;
	                }
	                uint _32869 = 1651u + ((_12091 / 529u) % 23u);
	                uint _32870 = _32869 / 2u;
	                uint _32880;
	                if ((_32869 & 1u) != 0u)
	                {
	                    _32880 = g_ScrambledHaltonPermutations.Load<uint>(_32870 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _32880 = g_ScrambledHaltonPermutations.Load<uint>(_32870 * 4 + 0) & 65535u;
	                }
	                uint _32884 = 1651u + ((_12091 / 12167u) % 23u);
	                uint _32885 = _32884 / 2u;
	                uint _32895;
	                if ((_32884 & 1u) != 0u)
	                {
	                    _32895 = g_ScrambledHaltonPermutations.Load<uint>(_32885 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _32895 = g_ScrambledHaltonPermutations.Load<uint>(_32885 * 4 + 0) & 65535u;
	                }
	                uint _32899 = 1651u + ((_12091 / 279841u) % 23u);
	                uint _32900 = _32899 / 2u;
	                uint _32910;
	                if ((_32899 & 1u) != 0u)
	                {
	                    _32910 = g_ScrambledHaltonPermutations.Load<uint>(_32900 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _32910 = g_ScrambledHaltonPermutations.Load<uint>(_32900 * 4 + 0) & 65535u;
	                }
	                uint _32914 = 1651u + ((_12091 / 6436343u) % 23u);
	                uint _32915 = _32914 / 2u;
	                uint _32925;
	                if ((_32914 & 1u) != 0u)
	                {
	                    _32925 = g_ScrambledHaltonPermutations.Load<uint>(_32915 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _32925 = g_ScrambledHaltonPermutations.Load<uint>(_32915 * 4 + 0) & 65535u;
	                }
	                uint _32929 = 1651u + ((_12091 / 148035889u) % 23u);
	                uint _32930 = _32929 / 2u;
	                uint _32940;
	                if ((_32929 & 1u) != 0u)
	                {
	                    _32940 = g_ScrambledHaltonPermutations.Load<uint>(_32930 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _32940 = g_ScrambledHaltonPermutations.Load<uint>(_32930 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((((((_32850 * 148035889u) + (_32865 * 6436343u)) + (_32880 * 279841u)) + (_32895 * 12167u)) + (_32910 * 529u)) + (_32925 * 23u)) + _32940) * 2.9370078591384185529022943228483e-10f;
	                _33360 = true;
	                break;
	            }
	            case 9u:
	            {
	                uint _32746 = _12091 % 29u;
	                uint _32748 = (1674u + _32746) / 2u;
	                uint _32758;
	                if ((_32746 & 1u) != 0u)
	                {
	                    _32758 = g_ScrambledHaltonPermutations.Load<uint>(_32748 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _32758 = g_ScrambledHaltonPermutations.Load<uint>(_32748 * 4 + 0) & 65535u;
	                }
	                uint _32761 = (_12091 / 29u) % 29u;
	                uint _32763 = (1674u + _32761) / 2u;
	                uint _32773;
	                if ((_32761 & 1u) != 0u)
	                {
	                    _32773 = g_ScrambledHaltonPermutations.Load<uint>(_32763 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _32773 = g_ScrambledHaltonPermutations.Load<uint>(_32763 * 4 + 0) & 65535u;
	                }
	                uint _32776 = (_12091 / 841u) % 29u;
	                uint _32778 = (1674u + _32776) / 2u;
	                uint _32788;
	                if ((_32776 & 1u) != 0u)
	                {
	                    _32788 = g_ScrambledHaltonPermutations.Load<uint>(_32778 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _32788 = g_ScrambledHaltonPermutations.Load<uint>(_32778 * 4 + 0) & 65535u;
	                }
	                uint _32791 = (_12091 / 24389u) % 29u;
	                uint _32793 = (1674u + _32791) / 2u;
	                uint _32803;
	                if ((_32791 & 1u) != 0u)
	                {
	                    _32803 = g_ScrambledHaltonPermutations.Load<uint>(_32793 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _32803 = g_ScrambledHaltonPermutations.Load<uint>(_32793 * 4 + 0) & 65535u;
	                }
	                uint _32806 = (_12091 / 707281u) % 29u;
	                uint _32808 = (1674u + _32806) / 2u;
	                uint _32818;
	                if ((_32806 & 1u) != 0u)
	                {
	                    _32818 = g_ScrambledHaltonPermutations.Load<uint>(_32808 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _32818 = g_ScrambledHaltonPermutations.Load<uint>(_32808 * 4 + 0) & 65535u;
	                }
	                uint _32821 = (_12091 / 20511149u) % 29u;
	                uint _32823 = (1674u + _32821) / 2u;
	                uint _32833;
	                if ((_32821 & 1u) != 0u)
	                {
	                    _32833 = g_ScrambledHaltonPermutations.Load<uint>(_32823 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _32833 = g_ScrambledHaltonPermutations.Load<uint>(_32823 * 4 + 0) & 65535u;
	                }
	                _33359 = float((((((_32758 * 20511149u) + (_32773 * 707281u)) + (_32788 * 24389u)) + (_32803 * 841u)) + (_32818 * 29u)) + _32833) * 1.6811713132725003561063203960657e-09f;
	                _33360 = true;
	                break;
	            }
	            case 10u:
	            {
	                uint _32655 = 1703u + (_12091 % 31u);
	                uint _32656 = _32655 / 2u;
	                uint _32666;
	                if ((_32655 & 1u) != 0u)
	                {
	                    _32666 = g_ScrambledHaltonPermutations.Load<uint>(_32656 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _32666 = g_ScrambledHaltonPermutations.Load<uint>(_32656 * 4 + 0) & 65535u;
	                }
	                uint _32670 = 1703u + ((_12091 / 31u) % 31u);
	                uint _32671 = _32670 / 2u;
	                uint _32681;
	                if ((_32670 & 1u) != 0u)
	                {
	                    _32681 = g_ScrambledHaltonPermutations.Load<uint>(_32671 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _32681 = g_ScrambledHaltonPermutations.Load<uint>(_32671 * 4 + 0) & 65535u;
	                }
	                uint _32685 = 1703u + ((_12091 / 961u) % 31u);
	                uint _32686 = _32685 / 2u;
	                uint _32696;
	                if ((_32685 & 1u) != 0u)
	                {
	                    _32696 = g_ScrambledHaltonPermutations.Load<uint>(_32686 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _32696 = g_ScrambledHaltonPermutations.Load<uint>(_32686 * 4 + 0) & 65535u;
	                }
	                uint _32700 = 1703u + ((_12091 / 29791u) % 31u);
	                uint _32701 = _32700 / 2u;
	                uint _32711;
	                if ((_32700 & 1u) != 0u)
	                {
	                    _32711 = g_ScrambledHaltonPermutations.Load<uint>(_32701 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _32711 = g_ScrambledHaltonPermutations.Load<uint>(_32701 * 4 + 0) & 65535u;
	                }
	                uint _32715 = 1703u + ((_12091 / 923521u) % 31u);
	                uint _32716 = _32715 / 2u;
	                uint _32726;
	                if ((_32715 & 1u) != 0u)
	                {
	                    _32726 = g_ScrambledHaltonPermutations.Load<uint>(_32716 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _32726 = g_ScrambledHaltonPermutations.Load<uint>(_32716 * 4 + 0) & 65535u;
	                }
	                uint _32730 = 1703u + ((_12091 / 28629151u) % 31u);
	                uint _32731 = _32730 / 2u;
	                uint _32741;
	                if ((_32730 & 1u) != 0u)
	                {
	                    _32741 = g_ScrambledHaltonPermutations.Load<uint>(_32731 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _32741 = g_ScrambledHaltonPermutations.Load<uint>(_32731 * 4 + 0) & 65535u;
	                }
	                _33359 = float((((((_32666 * 28629151u) + (_32681 * 923521u)) + (_32696 * 29791u)) + (_32711 * 961u)) + (_32726 * 31u)) + _32741) * 1.126755799774059596529696136713e-09f;
	                _33360 = true;
	                break;
	            }
	            case 11u:
	            {
	                uint _32562 = _12091 % 37u;
	                uint _32564 = (1734u + _32562) / 2u;
	                uint _32574;
	                if ((_32562 & 1u) != 0u)
	                {
	                    _32574 = g_ScrambledHaltonPermutations.Load<uint>(_32564 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _32574 = g_ScrambledHaltonPermutations.Load<uint>(_32564 * 4 + 0) & 65535u;
	                }
	                uint _32577 = (_12091 / 37u) % 37u;
	                uint _32579 = (1734u + _32577) / 2u;
	                uint _32589;
	                if ((_32577 & 1u) != 0u)
	                {
	                    _32589 = g_ScrambledHaltonPermutations.Load<uint>(_32579 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _32589 = g_ScrambledHaltonPermutations.Load<uint>(_32579 * 4 + 0) & 65535u;
	                }
	                uint _32592 = (_12091 / 1369u) % 37u;
	                uint _32594 = (1734u + _32592) / 2u;
	                uint _32604;
	                if ((_32592 & 1u) != 0u)
	                {
	                    _32604 = g_ScrambledHaltonPermutations.Load<uint>(_32594 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _32604 = g_ScrambledHaltonPermutations.Load<uint>(_32594 * 4 + 0) & 65535u;
	                }
	                uint _32607 = (_12091 / 50653u) % 37u;
	                uint _32609 = (1734u + _32607) / 2u;
	                uint _32619;
	                if ((_32607 & 1u) != 0u)
	                {
	                    _32619 = g_ScrambledHaltonPermutations.Load<uint>(_32609 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _32619 = g_ScrambledHaltonPermutations.Load<uint>(_32609 * 4 + 0) & 65535u;
	                }
	                uint _32622 = (_12091 / 1874161u) % 37u;
	                uint _32624 = (1734u + _32622) / 2u;
	                uint _32634;
	                if ((_32622 & 1u) != 0u)
	                {
	                    _32634 = g_ScrambledHaltonPermutations.Load<uint>(_32624 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _32634 = g_ScrambledHaltonPermutations.Load<uint>(_32624 * 4 + 0) & 65535u;
	                }
	                uint _32637 = (_12091 / 69343957u) % 37u;
	                uint _32639 = (1734u + _32637) / 2u;
	                uint _32649;
	                if ((_32637 & 1u) != 0u)
	                {
	                    _32649 = g_ScrambledHaltonPermutations.Load<uint>(_32639 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _32649 = g_ScrambledHaltonPermutations.Load<uint>(_32639 * 4 + 0) & 65535u;
	                }
	                _33359 = float((((((_32574 * 69343957u) + (_32589 * 1874161u)) + (_32604 * 50653u)) + (_32619 * 1369u)) + (_32634 * 37u)) + _32649) * 3.8975311866806805483065545558929e-10f;
	                _33360 = true;
	                break;
	            }
	            case 12u:
	            {
	                uint _32486 = 1771u + (_12091 % 41u);
	                uint _32487 = _32486 / 2u;
	                uint _32497;
	                if ((_32486 & 1u) != 0u)
	                {
	                    _32497 = g_ScrambledHaltonPermutations.Load<uint>(_32487 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _32497 = g_ScrambledHaltonPermutations.Load<uint>(_32487 * 4 + 0) & 65535u;
	                }
	                uint _32501 = 1771u + ((_12091 / 41u) % 41u);
	                uint _32502 = _32501 / 2u;
	                uint _32512;
	                if ((_32501 & 1u) != 0u)
	                {
	                    _32512 = g_ScrambledHaltonPermutations.Load<uint>(_32502 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _32512 = g_ScrambledHaltonPermutations.Load<uint>(_32502 * 4 + 0) & 65535u;
	                }
	                uint _32516 = 1771u + ((_12091 / 1681u) % 41u);
	                uint _32517 = _32516 / 2u;
	                uint _32527;
	                if ((_32516 & 1u) != 0u)
	                {
	                    _32527 = g_ScrambledHaltonPermutations.Load<uint>(_32517 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _32527 = g_ScrambledHaltonPermutations.Load<uint>(_32517 * 4 + 0) & 65535u;
	                }
	                uint _32531 = 1771u + ((_12091 / 68921u) % 41u);
	                uint _32532 = _32531 / 2u;
	                uint _32542;
	                if ((_32531 & 1u) != 0u)
	                {
	                    _32542 = g_ScrambledHaltonPermutations.Load<uint>(_32532 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _32542 = g_ScrambledHaltonPermutations.Load<uint>(_32532 * 4 + 0) & 65535u;
	                }
	                uint _32546 = 1771u + ((_12091 / 2825761u) % 41u);
	                uint _32547 = _32546 / 2u;
	                uint _32557;
	                if ((_32546 & 1u) != 0u)
	                {
	                    _32557 = g_ScrambledHaltonPermutations.Load<uint>(_32547 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _32557 = g_ScrambledHaltonPermutations.Load<uint>(_32547 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((((_32497 * 2825761u) + (_32512 * 68921u)) + (_32527 * 1681u)) + (_32542 * 41u)) + _32557) * 8.631388936919393017888069152832e-09f;
	                _33360 = true;
	                break;
	            }
	            case 13u:
	            {
	                uint _32408 = _12091 % 43u;
	                uint _32410 = (1812u + _32408) / 2u;
	                uint _32420;
	                if ((_32408 & 1u) != 0u)
	                {
	                    _32420 = g_ScrambledHaltonPermutations.Load<uint>(_32410 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _32420 = g_ScrambledHaltonPermutations.Load<uint>(_32410 * 4 + 0) & 65535u;
	                }
	                uint _32423 = (_12091 / 43u) % 43u;
	                uint _32425 = (1812u + _32423) / 2u;
	                uint _32435;
	                if ((_32423 & 1u) != 0u)
	                {
	                    _32435 = g_ScrambledHaltonPermutations.Load<uint>(_32425 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _32435 = g_ScrambledHaltonPermutations.Load<uint>(_32425 * 4 + 0) & 65535u;
	                }
	                uint _32438 = (_12091 / 1849u) % 43u;
	                uint _32440 = (1812u + _32438) / 2u;
	                uint _32450;
	                if ((_32438 & 1u) != 0u)
	                {
	                    _32450 = g_ScrambledHaltonPermutations.Load<uint>(_32440 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _32450 = g_ScrambledHaltonPermutations.Load<uint>(_32440 * 4 + 0) & 65535u;
	                }
	                uint _32453 = (_12091 / 79507u) % 43u;
	                uint _32455 = (1812u + _32453) / 2u;
	                uint _32465;
	                if ((_32453 & 1u) != 0u)
	                {
	                    _32465 = g_ScrambledHaltonPermutations.Load<uint>(_32455 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _32465 = g_ScrambledHaltonPermutations.Load<uint>(_32455 * 4 + 0) & 65535u;
	                }
	                uint _32468 = (_12091 / 3418801u) % 43u;
	                uint _32470 = (1812u + _32468) / 2u;
	                uint _32480;
	                if ((_32468 & 1u) != 0u)
	                {
	                    _32480 = g_ScrambledHaltonPermutations.Load<uint>(_32470 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _32480 = g_ScrambledHaltonPermutations.Load<uint>(_32470 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((((_32420 * 3418801u) + (_32435 * 79507u)) + (_32450 * 1849u)) + (_32465 * 43u)) + _32480) * 6.8023293664509765221737325191498e-09f;
	                _33360 = true;
	                break;
	            }
	            case 14u:
	            {
	                uint _32332 = 1855u + (_12091 % 47u);
	                uint _32333 = _32332 / 2u;
	                uint _32343;
	                if ((_32332 & 1u) != 0u)
	                {
	                    _32343 = g_ScrambledHaltonPermutations.Load<uint>(_32333 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _32343 = g_ScrambledHaltonPermutations.Load<uint>(_32333 * 4 + 0) & 65535u;
	                }
	                uint _32347 = 1855u + ((_12091 / 47u) % 47u);
	                uint _32348 = _32347 / 2u;
	                uint _32358;
	                if ((_32347 & 1u) != 0u)
	                {
	                    _32358 = g_ScrambledHaltonPermutations.Load<uint>(_32348 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _32358 = g_ScrambledHaltonPermutations.Load<uint>(_32348 * 4 + 0) & 65535u;
	                }
	                uint _32362 = 1855u + ((_12091 / 2209u) % 47u);
	                uint _32363 = _32362 / 2u;
	                uint _32373;
	                if ((_32362 & 1u) != 0u)
	                {
	                    _32373 = g_ScrambledHaltonPermutations.Load<uint>(_32363 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _32373 = g_ScrambledHaltonPermutations.Load<uint>(_32363 * 4 + 0) & 65535u;
	                }
	                uint _32377 = 1855u + ((_12091 / 103823u) % 47u);
	                uint _32378 = _32377 / 2u;
	                uint _32388;
	                if ((_32377 & 1u) != 0u)
	                {
	                    _32388 = g_ScrambledHaltonPermutations.Load<uint>(_32378 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _32388 = g_ScrambledHaltonPermutations.Load<uint>(_32378 * 4 + 0) & 65535u;
	                }
	                uint _32392 = 1855u + ((_12091 / 4879681u) % 47u);
	                uint _32393 = _32392 / 2u;
	                uint _32403;
	                if ((_32392 & 1u) != 0u)
	                {
	                    _32403 = g_ScrambledHaltonPermutations.Load<uint>(_32393 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _32403 = g_ScrambledHaltonPermutations.Load<uint>(_32393 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((((_32343 * 4879681u) + (_32358 * 103823u)) + (_32373 * 2209u)) + (_32388 * 47u)) + _32403) * 4.3602428334565956902224570512772e-09f;
	                _33360 = true;
	                break;
	            }
	            case 15u:
	            {
	                uint _32254 = _12091 % 53u;
	                uint _32256 = (1902u + _32254) / 2u;
	                uint _32266;
	                if ((_32254 & 1u) != 0u)
	                {
	                    _32266 = g_ScrambledHaltonPermutations.Load<uint>(_32256 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _32266 = g_ScrambledHaltonPermutations.Load<uint>(_32256 * 4 + 0) & 65535u;
	                }
	                uint _32269 = (_12091 / 53u) % 53u;
	                uint _32271 = (1902u + _32269) / 2u;
	                uint _32281;
	                if ((_32269 & 1u) != 0u)
	                {
	                    _32281 = g_ScrambledHaltonPermutations.Load<uint>(_32271 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _32281 = g_ScrambledHaltonPermutations.Load<uint>(_32271 * 4 + 0) & 65535u;
	                }
	                uint _32284 = (_12091 / 2809u) % 53u;
	                uint _32286 = (1902u + _32284) / 2u;
	                uint _32296;
	                if ((_32284 & 1u) != 0u)
	                {
	                    _32296 = g_ScrambledHaltonPermutations.Load<uint>(_32286 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _32296 = g_ScrambledHaltonPermutations.Load<uint>(_32286 * 4 + 0) & 65535u;
	                }
	                uint _32299 = (_12091 / 148877u) % 53u;
	                uint _32301 = (1902u + _32299) / 2u;
	                uint _32311;
	                if ((_32299 & 1u) != 0u)
	                {
	                    _32311 = g_ScrambledHaltonPermutations.Load<uint>(_32301 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _32311 = g_ScrambledHaltonPermutations.Load<uint>(_32301 * 4 + 0) & 65535u;
	                }
	                uint _32314 = (_12091 / 7890481u) % 53u;
	                uint _32316 = (1902u + _32314) / 2u;
	                uint _32326;
	                if ((_32314 & 1u) != 0u)
	                {
	                    _32326 = g_ScrambledHaltonPermutations.Load<uint>(_32316 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _32326 = g_ScrambledHaltonPermutations.Load<uint>(_32316 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((((_32266 * 7890481u) + (_32281 * 148877u)) + (_32296 * 2809u)) + (_32311 * 53u)) + _32326) * 2.3912258839686728606466203927994e-09f;
	                _33360 = true;
	                break;
	            }
	            case 16u:
	            {
	                uint _32178 = 1955u + (_12091 % 59u);
	                uint _32179 = _32178 / 2u;
	                uint _32189;
	                if ((_32178 & 1u) != 0u)
	                {
	                    _32189 = g_ScrambledHaltonPermutations.Load<uint>(_32179 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _32189 = g_ScrambledHaltonPermutations.Load<uint>(_32179 * 4 + 0) & 65535u;
	                }
	                uint _32193 = 1955u + ((_12091 / 59u) % 59u);
	                uint _32194 = _32193 / 2u;
	                uint _32204;
	                if ((_32193 & 1u) != 0u)
	                {
	                    _32204 = g_ScrambledHaltonPermutations.Load<uint>(_32194 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _32204 = g_ScrambledHaltonPermutations.Load<uint>(_32194 * 4 + 0) & 65535u;
	                }
	                uint _32208 = 1955u + ((_12091 / 3481u) % 59u);
	                uint _32209 = _32208 / 2u;
	                uint _32219;
	                if ((_32208 & 1u) != 0u)
	                {
	                    _32219 = g_ScrambledHaltonPermutations.Load<uint>(_32209 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _32219 = g_ScrambledHaltonPermutations.Load<uint>(_32209 * 4 + 0) & 65535u;
	                }
	                uint _32223 = 1955u + ((_12091 / 205379u) % 59u);
	                uint _32224 = _32223 / 2u;
	                uint _32234;
	                if ((_32223 & 1u) != 0u)
	                {
	                    _32234 = g_ScrambledHaltonPermutations.Load<uint>(_32224 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _32234 = g_ScrambledHaltonPermutations.Load<uint>(_32224 * 4 + 0) & 65535u;
	                }
	                uint _32238 = 1955u + ((_12091 / 12117361u) % 59u);
	                uint _32239 = _32238 / 2u;
	                uint _32249;
	                if ((_32238 & 1u) != 0u)
	                {
	                    _32249 = g_ScrambledHaltonPermutations.Load<uint>(_32239 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _32249 = g_ScrambledHaltonPermutations.Load<uint>(_32239 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((((_32189 * 12117361u) + (_32204 * 205379u)) + (_32219 * 3481u)) + (_32234 * 59u)) + _32249) * 1.3987493385769766973680816590786e-09f;
	                _33360 = true;
	                break;
	            }
	            case 17u:
	            {
	                uint _32100 = _12091 % 61u;
	                uint _32102 = (2014u + _32100) / 2u;
	                uint _32112;
	                if ((_32100 & 1u) != 0u)
	                {
	                    _32112 = g_ScrambledHaltonPermutations.Load<uint>(_32102 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _32112 = g_ScrambledHaltonPermutations.Load<uint>(_32102 * 4 + 0) & 65535u;
	                }
	                uint _32115 = (_12091 / 61u) % 61u;
	                uint _32117 = (2014u + _32115) / 2u;
	                uint _32127;
	                if ((_32115 & 1u) != 0u)
	                {
	                    _32127 = g_ScrambledHaltonPermutations.Load<uint>(_32117 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _32127 = g_ScrambledHaltonPermutations.Load<uint>(_32117 * 4 + 0) & 65535u;
	                }
	                uint _32130 = (_12091 / 3721u) % 61u;
	                uint _32132 = (2014u + _32130) / 2u;
	                uint _32142;
	                if ((_32130 & 1u) != 0u)
	                {
	                    _32142 = g_ScrambledHaltonPermutations.Load<uint>(_32132 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _32142 = g_ScrambledHaltonPermutations.Load<uint>(_32132 * 4 + 0) & 65535u;
	                }
	                uint _32145 = (_12091 / 226981u) % 61u;
	                uint _32147 = (2014u + _32145) / 2u;
	                uint _32157;
	                if ((_32145 & 1u) != 0u)
	                {
	                    _32157 = g_ScrambledHaltonPermutations.Load<uint>(_32147 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _32157 = g_ScrambledHaltonPermutations.Load<uint>(_32147 * 4 + 0) & 65535u;
	                }
	                uint _32160 = (_12091 / 13845841u) % 61u;
	                uint _32162 = (2014u + _32160) / 2u;
	                uint _32172;
	                if ((_32160 & 1u) != 0u)
	                {
	                    _32172 = g_ScrambledHaltonPermutations.Load<uint>(_32162 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _32172 = g_ScrambledHaltonPermutations.Load<uint>(_32162 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((((_32112 * 13845841u) + (_32127 * 226981u)) + (_32142 * 3721u)) + (_32157 * 61u)) + _32172) * 1.1839974556338006550504360347986e-09f;
	                _33360 = true;
	                break;
	            }
	            case 18u:
	            {
	                uint _32024 = 2075u + (_12091 % 67u);
	                uint _32025 = _32024 / 2u;
	                uint _32035;
	                if ((_32024 & 1u) != 0u)
	                {
	                    _32035 = g_ScrambledHaltonPermutations.Load<uint>(_32025 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _32035 = g_ScrambledHaltonPermutations.Load<uint>(_32025 * 4 + 0) & 65535u;
	                }
	                uint _32039 = 2075u + ((_12091 / 67u) % 67u);
	                uint _32040 = _32039 / 2u;
	                uint _32050;
	                if ((_32039 & 1u) != 0u)
	                {
	                    _32050 = g_ScrambledHaltonPermutations.Load<uint>(_32040 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _32050 = g_ScrambledHaltonPermutations.Load<uint>(_32040 * 4 + 0) & 65535u;
	                }
	                uint _32054 = 2075u + ((_12091 / 4489u) % 67u);
	                uint _32055 = _32054 / 2u;
	                uint _32065;
	                if ((_32054 & 1u) != 0u)
	                {
	                    _32065 = g_ScrambledHaltonPermutations.Load<uint>(_32055 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _32065 = g_ScrambledHaltonPermutations.Load<uint>(_32055 * 4 + 0) & 65535u;
	                }
	                uint _32069 = 2075u + ((_12091 / 300763u) % 67u);
	                uint _32070 = _32069 / 2u;
	                uint _32080;
	                if ((_32069 & 1u) != 0u)
	                {
	                    _32080 = g_ScrambledHaltonPermutations.Load<uint>(_32070 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _32080 = g_ScrambledHaltonPermutations.Load<uint>(_32070 * 4 + 0) & 65535u;
	                }
	                uint _32084 = 2075u + ((_12091 / 20151121u) % 67u);
	                uint _32085 = _32084 / 2u;
	                uint _32095;
	                if ((_32084 & 1u) != 0u)
	                {
	                    _32095 = g_ScrambledHaltonPermutations.Load<uint>(_32085 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _32095 = g_ScrambledHaltonPermutations.Load<uint>(_32085 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((((_32035 * 20151121u) + (_32050 * 300763u)) + (_32065 * 4489u)) + (_32080 * 67u)) + _32095) * 7.4067202371352891532296780496836e-10f;
	                _33360 = true;
	                break;
	            }
	            case 19u:
	            {
	                uint _31946 = _12091 % 71u;
	                uint _31948 = (2142u + _31946) / 2u;
	                uint _31958;
	                if ((_31946 & 1u) != 0u)
	                {
	                    _31958 = g_ScrambledHaltonPermutations.Load<uint>(_31948 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _31958 = g_ScrambledHaltonPermutations.Load<uint>(_31948 * 4 + 0) & 65535u;
	                }
	                uint _31961 = (_12091 / 71u) % 71u;
	                uint _31963 = (2142u + _31961) / 2u;
	                uint _31973;
	                if ((_31961 & 1u) != 0u)
	                {
	                    _31973 = g_ScrambledHaltonPermutations.Load<uint>(_31963 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _31973 = g_ScrambledHaltonPermutations.Load<uint>(_31963 * 4 + 0) & 65535u;
	                }
	                uint _31976 = (_12091 / 5041u) % 71u;
	                uint _31978 = (2142u + _31976) / 2u;
	                uint _31988;
	                if ((_31976 & 1u) != 0u)
	                {
	                    _31988 = g_ScrambledHaltonPermutations.Load<uint>(_31978 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _31988 = g_ScrambledHaltonPermutations.Load<uint>(_31978 * 4 + 0) & 65535u;
	                }
	                uint _31991 = (_12091 / 357911u) % 71u;
	                uint _31993 = (2142u + _31991) / 2u;
	                uint _32003;
	                if ((_31991 & 1u) != 0u)
	                {
	                    _32003 = g_ScrambledHaltonPermutations.Load<uint>(_31993 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _32003 = g_ScrambledHaltonPermutations.Load<uint>(_31993 * 4 + 0) & 65535u;
	                }
	                uint _32006 = (_12091 / 25411681u) % 71u;
	                uint _32008 = (2142u + _32006) / 2u;
	                uint _32018;
	                if ((_32006 & 1u) != 0u)
	                {
	                    _32018 = g_ScrambledHaltonPermutations.Load<uint>(_32008 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _32018 = g_ScrambledHaltonPermutations.Load<uint>(_32008 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((((_31958 * 25411681u) + (_31973 * 357911u)) + (_31988 * 5041u)) + (_32003 * 71u)) + _32018) * 5.5425319889224056169041432440281e-10f;
	                _33360 = true;
	                break;
	            }
	            case 20u:
	            {
	                uint _31870 = 2213u + (_12091 % 73u);
	                uint _31871 = _31870 / 2u;
	                uint _31881;
	                if ((_31870 & 1u) != 0u)
	                {
	                    _31881 = g_ScrambledHaltonPermutations.Load<uint>(_31871 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _31881 = g_ScrambledHaltonPermutations.Load<uint>(_31871 * 4 + 0) & 65535u;
	                }
	                uint _31885 = 2213u + ((_12091 / 73u) % 73u);
	                uint _31886 = _31885 / 2u;
	                uint _31896;
	                if ((_31885 & 1u) != 0u)
	                {
	                    _31896 = g_ScrambledHaltonPermutations.Load<uint>(_31886 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _31896 = g_ScrambledHaltonPermutations.Load<uint>(_31886 * 4 + 0) & 65535u;
	                }
	                uint _31900 = 2213u + ((_12091 / 5329u) % 73u);
	                uint _31901 = _31900 / 2u;
	                uint _31911;
	                if ((_31900 & 1u) != 0u)
	                {
	                    _31911 = g_ScrambledHaltonPermutations.Load<uint>(_31901 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _31911 = g_ScrambledHaltonPermutations.Load<uint>(_31901 * 4 + 0) & 65535u;
	                }
	                uint _31915 = 2213u + ((_12091 / 389017u) % 73u);
	                uint _31916 = _31915 / 2u;
	                uint _31926;
	                if ((_31915 & 1u) != 0u)
	                {
	                    _31926 = g_ScrambledHaltonPermutations.Load<uint>(_31916 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _31926 = g_ScrambledHaltonPermutations.Load<uint>(_31916 * 4 + 0) & 65535u;
	                }
	                uint _31930 = 2213u + ((_12091 / 28398241u) % 73u);
	                uint _31931 = _31930 / 2u;
	                uint _31941;
	                if ((_31930 & 1u) != 0u)
	                {
	                    _31941 = g_ScrambledHaltonPermutations.Load<uint>(_31931 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _31941 = g_ScrambledHaltonPermutations.Load<uint>(_31931 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((((_31881 * 28398241u) + (_31896 * 389017u)) + (_31911 * 5329u)) + (_31926 * 73u)) + _31941) * 4.8237597249922714581771288067102e-10f;
	                _33360 = true;
	                break;
	            }
	            case 21u:
	            {
	                uint _31792 = _12091 % 79u;
	                uint _31794 = (2286u + _31792) / 2u;
	                uint _31804;
	                if ((_31792 & 1u) != 0u)
	                {
	                    _31804 = g_ScrambledHaltonPermutations.Load<uint>(_31794 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _31804 = g_ScrambledHaltonPermutations.Load<uint>(_31794 * 4 + 0) & 65535u;
	                }
	                uint _31807 = (_12091 / 79u) % 79u;
	                uint _31809 = (2286u + _31807) / 2u;
	                uint _31819;
	                if ((_31807 & 1u) != 0u)
	                {
	                    _31819 = g_ScrambledHaltonPermutations.Load<uint>(_31809 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _31819 = g_ScrambledHaltonPermutations.Load<uint>(_31809 * 4 + 0) & 65535u;
	                }
	                uint _31822 = (_12091 / 6241u) % 79u;
	                uint _31824 = (2286u + _31822) / 2u;
	                uint _31834;
	                if ((_31822 & 1u) != 0u)
	                {
	                    _31834 = g_ScrambledHaltonPermutations.Load<uint>(_31824 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _31834 = g_ScrambledHaltonPermutations.Load<uint>(_31824 * 4 + 0) & 65535u;
	                }
	                uint _31837 = (_12091 / 493039u) % 79u;
	                uint _31839 = (2286u + _31837) / 2u;
	                uint _31849;
	                if ((_31837 & 1u) != 0u)
	                {
	                    _31849 = g_ScrambledHaltonPermutations.Load<uint>(_31839 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _31849 = g_ScrambledHaltonPermutations.Load<uint>(_31839 * 4 + 0) & 65535u;
	                }
	                uint _31852 = (_12091 / 38950081u) % 79u;
	                uint _31854 = (2286u + _31852) / 2u;
	                uint _31864;
	                if ((_31852 & 1u) != 0u)
	                {
	                    _31864 = g_ScrambledHaltonPermutations.Load<uint>(_31854 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _31864 = g_ScrambledHaltonPermutations.Load<uint>(_31854 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((((_31804 * 38950081u) + (_31819 * 493039u)) + (_31834 * 6241u)) + (_31849 * 79u)) + _31864) * 3.2498587154705660395848099142313e-10f;
	                _33360 = true;
	                break;
	            }
	            case 22u:
	            {
	                uint _31716 = 2365u + (_12091 % 83u);
	                uint _31717 = _31716 / 2u;
	                uint _31727;
	                if ((_31716 & 1u) != 0u)
	                {
	                    _31727 = g_ScrambledHaltonPermutations.Load<uint>(_31717 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _31727 = g_ScrambledHaltonPermutations.Load<uint>(_31717 * 4 + 0) & 65535u;
	                }
	                uint _31731 = 2365u + ((_12091 / 83u) % 83u);
	                uint _31732 = _31731 / 2u;
	                uint _31742;
	                if ((_31731 & 1u) != 0u)
	                {
	                    _31742 = g_ScrambledHaltonPermutations.Load<uint>(_31732 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _31742 = g_ScrambledHaltonPermutations.Load<uint>(_31732 * 4 + 0) & 65535u;
	                }
	                uint _31746 = 2365u + ((_12091 / 6889u) % 83u);
	                uint _31747 = _31746 / 2u;
	                uint _31757;
	                if ((_31746 & 1u) != 0u)
	                {
	                    _31757 = g_ScrambledHaltonPermutations.Load<uint>(_31747 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _31757 = g_ScrambledHaltonPermutations.Load<uint>(_31747 * 4 + 0) & 65535u;
	                }
	                uint _31761 = 2365u + ((_12091 / 571787u) % 83u);
	                uint _31762 = _31761 / 2u;
	                uint _31772;
	                if ((_31761 & 1u) != 0u)
	                {
	                    _31772 = g_ScrambledHaltonPermutations.Load<uint>(_31762 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _31772 = g_ScrambledHaltonPermutations.Load<uint>(_31762 * 4 + 0) & 65535u;
	                }
	                uint _31776 = 2365u + ((_12091 / 47458321u) % 83u);
	                uint _31777 = _31776 / 2u;
	                uint _31787;
	                if ((_31776 & 1u) != 0u)
	                {
	                    _31787 = g_ScrambledHaltonPermutations.Load<uint>(_31777 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _31787 = g_ScrambledHaltonPermutations.Load<uint>(_31777 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((((_31727 * 47458321u) + (_31742 * 571787u)) + (_31757 * 6889u)) + (_31772 * 83u)) + _31787) * 2.5386887037015526402683462947607e-10f;
	                _33360 = true;
	                break;
	            }
	            case 23u:
	            {
	                uint _31653 = _12091 % 89u;
	                uint _31655 = (2448u + _31653) / 2u;
	                uint _31665;
	                if ((_31653 & 1u) != 0u)
	                {
	                    _31665 = g_ScrambledHaltonPermutations.Load<uint>(_31655 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _31665 = g_ScrambledHaltonPermutations.Load<uint>(_31655 * 4 + 0) & 65535u;
	                }
	                uint _31668 = (_12091 / 89u) % 89u;
	                uint _31670 = (2448u + _31668) / 2u;
	                uint _31680;
	                if ((_31668 & 1u) != 0u)
	                {
	                    _31680 = g_ScrambledHaltonPermutations.Load<uint>(_31670 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _31680 = g_ScrambledHaltonPermutations.Load<uint>(_31670 * 4 + 0) & 65535u;
	                }
	                uint _31683 = (_12091 / 7921u) % 89u;
	                uint _31685 = (2448u + _31683) / 2u;
	                uint _31695;
	                if ((_31683 & 1u) != 0u)
	                {
	                    _31695 = g_ScrambledHaltonPermutations.Load<uint>(_31685 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _31695 = g_ScrambledHaltonPermutations.Load<uint>(_31685 * 4 + 0) & 65535u;
	                }
	                uint _31698 = (_12091 / 704969u) % 89u;
	                uint _31700 = (2448u + _31698) / 2u;
	                uint _31710;
	                if ((_31698 & 1u) != 0u)
	                {
	                    _31710 = g_ScrambledHaltonPermutations.Load<uint>(_31700 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _31710 = g_ScrambledHaltonPermutations.Load<uint>(_31700 * 4 + 0) & 65535u;
	                }
	                _33359 = float((((_31665 * 704969u) + (_31680 * 7921u)) + (_31695 * 89u)) + _31710) * 1.593822496204211347503587603569e-08f;
	                _33360 = true;
	                break;
	            }
	            case 24u:
	            {
	                uint _31592 = 2537u + (_12091 % 97u);
	                uint _31593 = _31592 / 2u;
	                uint _31603;
	                if ((_31592 & 1u) != 0u)
	                {
	                    _31603 = g_ScrambledHaltonPermutations.Load<uint>(_31593 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _31603 = g_ScrambledHaltonPermutations.Load<uint>(_31593 * 4 + 0) & 65535u;
	                }
	                uint _31607 = 2537u + ((_12091 / 97u) % 97u);
	                uint _31608 = _31607 / 2u;
	                uint _31618;
	                if ((_31607 & 1u) != 0u)
	                {
	                    _31618 = g_ScrambledHaltonPermutations.Load<uint>(_31608 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _31618 = g_ScrambledHaltonPermutations.Load<uint>(_31608 * 4 + 0) & 65535u;
	                }
	                uint _31622 = 2537u + ((_12091 / 9409u) % 97u);
	                uint _31623 = _31622 / 2u;
	                uint _31633;
	                if ((_31622 & 1u) != 0u)
	                {
	                    _31633 = g_ScrambledHaltonPermutations.Load<uint>(_31623 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _31633 = g_ScrambledHaltonPermutations.Load<uint>(_31623 * 4 + 0) & 65535u;
	                }
	                uint _31637 = 2537u + ((_12091 / 912673u) % 97u);
	                uint _31638 = _31637 / 2u;
	                uint _31648;
	                if ((_31637 & 1u) != 0u)
	                {
	                    _31648 = g_ScrambledHaltonPermutations.Load<uint>(_31638 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _31648 = g_ScrambledHaltonPermutations.Load<uint>(_31638 * 4 + 0) & 65535u;
	                }
	                _33359 = float((((_31603 * 912673u) + (_31618 * 9409u)) + (_31633 * 97u)) + _31648) * 1.1295696822344325482845306396484e-08f;
	                _33360 = true;
	                break;
	            }
	            case 25u:
	            {
	                uint _31529 = _12091 % 101u;
	                uint _31531 = (2634u + _31529) / 2u;
	                uint _31541;
	                if ((_31529 & 1u) != 0u)
	                {
	                    _31541 = g_ScrambledHaltonPermutations.Load<uint>(_31531 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _31541 = g_ScrambledHaltonPermutations.Load<uint>(_31531 * 4 + 0) & 65535u;
	                }
	                uint _31544 = (_12091 / 101u) % 101u;
	                uint _31546 = (2634u + _31544) / 2u;
	                uint _31556;
	                if ((_31544 & 1u) != 0u)
	                {
	                    _31556 = g_ScrambledHaltonPermutations.Load<uint>(_31546 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _31556 = g_ScrambledHaltonPermutations.Load<uint>(_31546 * 4 + 0) & 65535u;
	                }
	                uint _31559 = (_12091 / 10201u) % 101u;
	                uint _31561 = (2634u + _31559) / 2u;
	                uint _31571;
	                if ((_31559 & 1u) != 0u)
	                {
	                    _31571 = g_ScrambledHaltonPermutations.Load<uint>(_31561 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _31571 = g_ScrambledHaltonPermutations.Load<uint>(_31561 * 4 + 0) & 65535u;
	                }
	                uint _31574 = (_12091 / 1030301u) % 101u;
	                uint _31576 = (2634u + _31574) / 2u;
	                uint _31586;
	                if ((_31574 & 1u) != 0u)
	                {
	                    _31586 = g_ScrambledHaltonPermutations.Load<uint>(_31576 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _31586 = g_ScrambledHaltonPermutations.Load<uint>(_31576 * 4 + 0) & 65535u;
	                }
	                _33359 = float((((_31541 * 1030301u) + (_31556 * 10201u)) + (_31571 * 101u)) + _31586) * 9.6098027313473721733316779136658e-09f;
	                _33360 = true;
	                break;
	            }
	            case 26u:
	            {
	                uint _31468 = 2735u + (_12091 % 103u);
	                uint _31469 = _31468 / 2u;
	                uint _31479;
	                if ((_31468 & 1u) != 0u)
	                {
	                    _31479 = g_ScrambledHaltonPermutations.Load<uint>(_31469 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _31479 = g_ScrambledHaltonPermutations.Load<uint>(_31469 * 4 + 0) & 65535u;
	                }
	                uint _31483 = 2735u + ((_12091 / 103u) % 103u);
	                uint _31484 = _31483 / 2u;
	                uint _31494;
	                if ((_31483 & 1u) != 0u)
	                {
	                    _31494 = g_ScrambledHaltonPermutations.Load<uint>(_31484 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _31494 = g_ScrambledHaltonPermutations.Load<uint>(_31484 * 4 + 0) & 65535u;
	                }
	                uint _31498 = 2735u + ((_12091 / 10609u) % 103u);
	                uint _31499 = _31498 / 2u;
	                uint _31509;
	                if ((_31498 & 1u) != 0u)
	                {
	                    _31509 = g_ScrambledHaltonPermutations.Load<uint>(_31499 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _31509 = g_ScrambledHaltonPermutations.Load<uint>(_31499 * 4 + 0) & 65535u;
	                }
	                uint _31513 = 2735u + ((_12091 / 1092727u) % 103u);
	                uint _31514 = _31513 / 2u;
	                uint _31524;
	                if ((_31513 & 1u) != 0u)
	                {
	                    _31524 = g_ScrambledHaltonPermutations.Load<uint>(_31514 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _31524 = g_ScrambledHaltonPermutations.Load<uint>(_31514 * 4 + 0) & 65535u;
	                }
	                _33359 = float((((_31479 * 1092727u) + (_31494 * 10609u)) + (_31509 * 103u)) + _31524) * 8.8848697288312905584461987018585e-09f;
	                _33360 = true;
	                break;
	            }
	            case 27u:
	            {
	                uint _31405 = _12091 % 107u;
	                uint _31407 = (2838u + _31405) / 2u;
	                uint _31417;
	                if ((_31405 & 1u) != 0u)
	                {
	                    _31417 = g_ScrambledHaltonPermutations.Load<uint>(_31407 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _31417 = g_ScrambledHaltonPermutations.Load<uint>(_31407 * 4 + 0) & 65535u;
	                }
	                uint _31420 = (_12091 / 107u) % 107u;
	                uint _31422 = (2838u + _31420) / 2u;
	                uint _31432;
	                if ((_31420 & 1u) != 0u)
	                {
	                    _31432 = g_ScrambledHaltonPermutations.Load<uint>(_31422 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _31432 = g_ScrambledHaltonPermutations.Load<uint>(_31422 * 4 + 0) & 65535u;
	                }
	                uint _31435 = (_12091 / 11449u) % 107u;
	                uint _31437 = (2838u + _31435) / 2u;
	                uint _31447;
	                if ((_31435 & 1u) != 0u)
	                {
	                    _31447 = g_ScrambledHaltonPermutations.Load<uint>(_31437 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _31447 = g_ScrambledHaltonPermutations.Load<uint>(_31437 * 4 + 0) & 65535u;
	                }
	                uint _31450 = (_12091 / 1225043u) % 107u;
	                uint _31452 = (2838u + _31450) / 2u;
	                uint _31462;
	                if ((_31450 & 1u) != 0u)
	                {
	                    _31462 = g_ScrambledHaltonPermutations.Load<uint>(_31452 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _31462 = g_ScrambledHaltonPermutations.Load<uint>(_31452 * 4 + 0) & 65535u;
	                }
	                _33359 = float((((_31417 * 1225043u) + (_31432 * 11449u)) + (_31447 * 107u)) + _31462) * 7.6289516925953648751601576805115e-09f;
	                _33360 = true;
	                break;
	            }
	            case 28u:
	            {
	                uint _31344 = 2945u + (_12091 % 109u);
	                uint _31345 = _31344 / 2u;
	                uint _31355;
	                if ((_31344 & 1u) != 0u)
	                {
	                    _31355 = g_ScrambledHaltonPermutations.Load<uint>(_31345 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _31355 = g_ScrambledHaltonPermutations.Load<uint>(_31345 * 4 + 0) & 65535u;
	                }
	                uint _31359 = 2945u + ((_12091 / 109u) % 109u);
	                uint _31360 = _31359 / 2u;
	                uint _31370;
	                if ((_31359 & 1u) != 0u)
	                {
	                    _31370 = g_ScrambledHaltonPermutations.Load<uint>(_31360 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _31370 = g_ScrambledHaltonPermutations.Load<uint>(_31360 * 4 + 0) & 65535u;
	                }
	                uint _31374 = 2945u + ((_12091 / 11881u) % 109u);
	                uint _31375 = _31374 / 2u;
	                uint _31385;
	                if ((_31374 & 1u) != 0u)
	                {
	                    _31385 = g_ScrambledHaltonPermutations.Load<uint>(_31375 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _31385 = g_ScrambledHaltonPermutations.Load<uint>(_31375 * 4 + 0) & 65535u;
	                }
	                uint _31389 = 2945u + ((_12091 / 1295029u) % 109u);
	                uint _31390 = _31389 / 2u;
	                uint _31400;
	                if ((_31389 & 1u) != 0u)
	                {
	                    _31400 = g_ScrambledHaltonPermutations.Load<uint>(_31390 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _31400 = g_ScrambledHaltonPermutations.Load<uint>(_31390 * 4 + 0) & 65535u;
	                }
	                _33359 = float((((_31355 * 1295029u) + (_31370 * 11881u)) + (_31385 * 109u)) + _31400) * 7.0842514077185114729218184947968e-09f;
	                _33360 = true;
	                break;
	            }
	            case 29u:
	            {
	                uint _31281 = _12091 % 113u;
	                uint _31283 = (3054u + _31281) / 2u;
	                uint _31293;
	                if ((_31281 & 1u) != 0u)
	                {
	                    _31293 = g_ScrambledHaltonPermutations.Load<uint>(_31283 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _31293 = g_ScrambledHaltonPermutations.Load<uint>(_31283 * 4 + 0) & 65535u;
	                }
	                uint _31296 = (_12091 / 113u) % 113u;
	                uint _31298 = (3054u + _31296) / 2u;
	                uint _31308;
	                if ((_31296 & 1u) != 0u)
	                {
	                    _31308 = g_ScrambledHaltonPermutations.Load<uint>(_31298 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _31308 = g_ScrambledHaltonPermutations.Load<uint>(_31298 * 4 + 0) & 65535u;
	                }
	                uint _31311 = (_12091 / 12769u) % 113u;
	                uint _31313 = (3054u + _31311) / 2u;
	                uint _31323;
	                if ((_31311 & 1u) != 0u)
	                {
	                    _31323 = g_ScrambledHaltonPermutations.Load<uint>(_31313 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _31323 = g_ScrambledHaltonPermutations.Load<uint>(_31313 * 4 + 0) & 65535u;
	                }
	                uint _31326 = (_12091 / 1442897u) % 113u;
	                uint _31328 = (3054u + _31326) / 2u;
	                uint _31338;
	                if ((_31326 & 1u) != 0u)
	                {
	                    _31338 = g_ScrambledHaltonPermutations.Load<uint>(_31328 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _31338 = g_ScrambledHaltonPermutations.Load<uint>(_31328 * 4 + 0) & 65535u;
	                }
	                _33359 = float((((_31293 * 1442897u) + (_31308 * 12769u)) + (_31323 * 113u)) + _31338) * 6.1331864031899385736323893070221e-09f;
	                _33360 = true;
	                break;
	            }
	            case 30u:
	            {
	                uint _31220 = 3167u + (_12091 % 127u);
	                uint _31221 = _31220 / 2u;
	                uint _31231;
	                if ((_31220 & 1u) != 0u)
	                {
	                    _31231 = g_ScrambledHaltonPermutations.Load<uint>(_31221 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _31231 = g_ScrambledHaltonPermutations.Load<uint>(_31221 * 4 + 0) & 65535u;
	                }
	                uint _31235 = 3167u + ((_12091 / 127u) % 127u);
	                uint _31236 = _31235 / 2u;
	                uint _31246;
	                if ((_31235 & 1u) != 0u)
	                {
	                    _31246 = g_ScrambledHaltonPermutations.Load<uint>(_31236 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _31246 = g_ScrambledHaltonPermutations.Load<uint>(_31236 * 4 + 0) & 65535u;
	                }
	                uint _31250 = 3167u + ((_12091 / 16129u) % 127u);
	                uint _31251 = _31250 / 2u;
	                uint _31261;
	                if ((_31250 & 1u) != 0u)
	                {
	                    _31261 = g_ScrambledHaltonPermutations.Load<uint>(_31251 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _31261 = g_ScrambledHaltonPermutations.Load<uint>(_31251 * 4 + 0) & 65535u;
	                }
	                uint _31265 = 3167u + ((_12091 / 2048383u) % 127u);
	                uint _31266 = _31265 / 2u;
	                uint _31276;
	                if ((_31265 & 1u) != 0u)
	                {
	                    _31276 = g_ScrambledHaltonPermutations.Load<uint>(_31266 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _31276 = g_ScrambledHaltonPermutations.Load<uint>(_31266 * 4 + 0) & 65535u;
	                }
	                _33359 = float((((_31231 * 2048383u) + (_31246 * 16129u)) + (_31261 * 127u)) + _31276) * 3.8440148841800692025572061538696e-09f;
	                _33360 = true;
	                break;
	            }
	            case 31u:
	            {
	                uint _31157 = _12091 % 131u;
	                uint _31159 = (3294u + _31157) / 2u;
	                uint _31169;
	                if ((_31157 & 1u) != 0u)
	                {
	                    _31169 = g_ScrambledHaltonPermutations.Load<uint>(_31159 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _31169 = g_ScrambledHaltonPermutations.Load<uint>(_31159 * 4 + 0) & 65535u;
	                }
	                uint _31172 = (_12091 / 131u) % 131u;
	                uint _31174 = (3294u + _31172) / 2u;
	                uint _31184;
	                if ((_31172 & 1u) != 0u)
	                {
	                    _31184 = g_ScrambledHaltonPermutations.Load<uint>(_31174 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _31184 = g_ScrambledHaltonPermutations.Load<uint>(_31174 * 4 + 0) & 65535u;
	                }
	                uint _31187 = (_12091 / 17161u) % 131u;
	                uint _31189 = (3294u + _31187) / 2u;
	                uint _31199;
	                if ((_31187 & 1u) != 0u)
	                {
	                    _31199 = g_ScrambledHaltonPermutations.Load<uint>(_31189 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _31199 = g_ScrambledHaltonPermutations.Load<uint>(_31189 * 4 + 0) & 65535u;
	                }
	                uint _31202 = (_12091 / 2248091u) % 131u;
	                uint _31204 = (3294u + _31202) / 2u;
	                uint _31214;
	                if ((_31202 & 1u) != 0u)
	                {
	                    _31214 = g_ScrambledHaltonPermutations.Load<uint>(_31204 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _31214 = g_ScrambledHaltonPermutations.Load<uint>(_31204 * 4 + 0) & 65535u;
	                }
	                _33359 = float((((_31169 * 2248091u) + (_31184 * 17161u)) + (_31199 * 131u)) + _31214) * 3.3955860345713517745025455951691e-09f;
	                _33360 = true;
	                break;
	            }
	            case 32u:
	            {
	                uint _31096 = 3425u + (_12091 % 137u);
	                uint _31097 = _31096 / 2u;
	                uint _31107;
	                if ((_31096 & 1u) != 0u)
	                {
	                    _31107 = g_ScrambledHaltonPermutations.Load<uint>(_31097 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _31107 = g_ScrambledHaltonPermutations.Load<uint>(_31097 * 4 + 0) & 65535u;
	                }
	                uint _31111 = 3425u + ((_12091 / 137u) % 137u);
	                uint _31112 = _31111 / 2u;
	                uint _31122;
	                if ((_31111 & 1u) != 0u)
	                {
	                    _31122 = g_ScrambledHaltonPermutations.Load<uint>(_31112 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _31122 = g_ScrambledHaltonPermutations.Load<uint>(_31112 * 4 + 0) & 65535u;
	                }
	                uint _31126 = 3425u + ((_12091 / 18769u) % 137u);
	                uint _31127 = _31126 / 2u;
	                uint _31137;
	                if ((_31126 & 1u) != 0u)
	                {
	                    _31137 = g_ScrambledHaltonPermutations.Load<uint>(_31127 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _31137 = g_ScrambledHaltonPermutations.Load<uint>(_31127 * 4 + 0) & 65535u;
	                }
	                uint _31141 = 3425u + ((_12091 / 2571353u) % 137u);
	                uint _31142 = _31141 / 2u;
	                uint _31152;
	                if ((_31141 & 1u) != 0u)
	                {
	                    _31152 = g_ScrambledHaltonPermutations.Load<uint>(_31142 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _31152 = g_ScrambledHaltonPermutations.Load<uint>(_31142 * 4 + 0) & 65535u;
	                }
	                _33359 = float((((_31107 * 2571353u) + (_31122 * 18769u)) + (_31137 * 137u)) + _31152) * 2.8386881734121516274171881377697e-09f;
	                _33360 = true;
	                break;
	            }
	            case 33u:
	            {
	                uint _31033 = _12091 % 139u;
	                uint _31035 = (3562u + _31033) / 2u;
	                uint _31045;
	                if ((_31033 & 1u) != 0u)
	                {
	                    _31045 = g_ScrambledHaltonPermutations.Load<uint>(_31035 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _31045 = g_ScrambledHaltonPermutations.Load<uint>(_31035 * 4 + 0) & 65535u;
	                }
	                uint _31048 = (_12091 / 139u) % 139u;
	                uint _31050 = (3562u + _31048) / 2u;
	                uint _31060;
	                if ((_31048 & 1u) != 0u)
	                {
	                    _31060 = g_ScrambledHaltonPermutations.Load<uint>(_31050 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _31060 = g_ScrambledHaltonPermutations.Load<uint>(_31050 * 4 + 0) & 65535u;
	                }
	                uint _31063 = (_12091 / 19321u) % 139u;
	                uint _31065 = (3562u + _31063) / 2u;
	                uint _31075;
	                if ((_31063 & 1u) != 0u)
	                {
	                    _31075 = g_ScrambledHaltonPermutations.Load<uint>(_31065 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _31075 = g_ScrambledHaltonPermutations.Load<uint>(_31065 * 4 + 0) & 65535u;
	                }
	                uint _31078 = (_12091 / 2685619u) % 139u;
	                uint _31080 = (3562u + _31078) / 2u;
	                uint _31090;
	                if ((_31078 & 1u) != 0u)
	                {
	                    _31090 = g_ScrambledHaltonPermutations.Load<uint>(_31080 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _31090 = g_ScrambledHaltonPermutations.Load<uint>(_31080 * 4 + 0) & 65535u;
	                }
	                _33359 = float((((_31045 * 2685619u) + (_31060 * 19321u)) + (_31075 * 139u)) + _31090) * 2.6788027351898335837177000939846e-09f;
	                _33360 = true;
	                break;
	            }
	            case 34u:
	            {
	                uint _30972 = 3701u + (_12091 % 149u);
	                uint _30973 = _30972 / 2u;
	                uint _30983;
	                if ((_30972 & 1u) != 0u)
	                {
	                    _30983 = g_ScrambledHaltonPermutations.Load<uint>(_30973 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _30983 = g_ScrambledHaltonPermutations.Load<uint>(_30973 * 4 + 0) & 65535u;
	                }
	                uint _30987 = 3701u + ((_12091 / 149u) % 149u);
	                uint _30988 = _30987 / 2u;
	                uint _30998;
	                if ((_30987 & 1u) != 0u)
	                {
	                    _30998 = g_ScrambledHaltonPermutations.Load<uint>(_30988 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _30998 = g_ScrambledHaltonPermutations.Load<uint>(_30988 * 4 + 0) & 65535u;
	                }
	                uint _31002 = 3701u + ((_12091 / 22201u) % 149u);
	                uint _31003 = _31002 / 2u;
	                uint _31013;
	                if ((_31002 & 1u) != 0u)
	                {
	                    _31013 = g_ScrambledHaltonPermutations.Load<uint>(_31003 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _31013 = g_ScrambledHaltonPermutations.Load<uint>(_31003 * 4 + 0) & 65535u;
	                }
	                uint _31017 = 3701u + ((_12091 / 3307949u) % 149u);
	                uint _31018 = _31017 / 2u;
	                uint _31028;
	                if ((_31017 & 1u) != 0u)
	                {
	                    _31028 = g_ScrambledHaltonPermutations.Load<uint>(_31018 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _31028 = g_ScrambledHaltonPermutations.Load<uint>(_31018 * 4 + 0) & 65535u;
	                }
	                _33359 = float((((_30983 * 3307949u) + (_30998 * 22201u)) + (_31013 * 149u)) + _31028) * 2.0288730695483536692336201667786e-09f;
	                _33360 = true;
	                break;
	            }
	            case 35u:
	            {
	                uint _30909 = _12091 % 151u;
	                uint _30911 = (3850u + _30909) / 2u;
	                uint _30921;
	                if ((_30909 & 1u) != 0u)
	                {
	                    _30921 = g_ScrambledHaltonPermutations.Load<uint>(_30911 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _30921 = g_ScrambledHaltonPermutations.Load<uint>(_30911 * 4 + 0) & 65535u;
	                }
	                uint _30924 = (_12091 / 151u) % 151u;
	                uint _30926 = (3850u + _30924) / 2u;
	                uint _30936;
	                if ((_30924 & 1u) != 0u)
	                {
	                    _30936 = g_ScrambledHaltonPermutations.Load<uint>(_30926 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _30936 = g_ScrambledHaltonPermutations.Load<uint>(_30926 * 4 + 0) & 65535u;
	                }
	                uint _30939 = (_12091 / 22801u) % 151u;
	                uint _30941 = (3850u + _30939) / 2u;
	                uint _30951;
	                if ((_30939 & 1u) != 0u)
	                {
	                    _30951 = g_ScrambledHaltonPermutations.Load<uint>(_30941 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _30951 = g_ScrambledHaltonPermutations.Load<uint>(_30941 * 4 + 0) & 65535u;
	                }
	                uint _30954 = (_12091 / 3442951u) % 151u;
	                uint _30956 = (3850u + _30954) / 2u;
	                uint _30966;
	                if ((_30954 & 1u) != 0u)
	                {
	                    _30966 = g_ScrambledHaltonPermutations.Load<uint>(_30956 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _30966 = g_ScrambledHaltonPermutations.Load<uint>(_30956 * 4 + 0) & 65535u;
	                }
	                _33359 = float((((_30921 * 3442951u) + (_30936 * 22801u)) + (_30951 * 151u)) + _30966) * 1.9234998038797357367002405226231e-09f;
	                _33360 = true;
	                break;
	            }
	            case 36u:
	            {
	                uint _30848 = 4001u + (_12091 % 157u);
	                uint _30849 = _30848 / 2u;
	                uint _30859;
	                if ((_30848 & 1u) != 0u)
	                {
	                    _30859 = g_ScrambledHaltonPermutations.Load<uint>(_30849 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _30859 = g_ScrambledHaltonPermutations.Load<uint>(_30849 * 4 + 0) & 65535u;
	                }
	                uint _30863 = 4001u + ((_12091 / 157u) % 157u);
	                uint _30864 = _30863 / 2u;
	                uint _30874;
	                if ((_30863 & 1u) != 0u)
	                {
	                    _30874 = g_ScrambledHaltonPermutations.Load<uint>(_30864 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _30874 = g_ScrambledHaltonPermutations.Load<uint>(_30864 * 4 + 0) & 65535u;
	                }
	                uint _30878 = 4001u + ((_12091 / 24649u) % 157u);
	                uint _30879 = _30878 / 2u;
	                uint _30889;
	                if ((_30878 & 1u) != 0u)
	                {
	                    _30889 = g_ScrambledHaltonPermutations.Load<uint>(_30879 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _30889 = g_ScrambledHaltonPermutations.Load<uint>(_30879 * 4 + 0) & 65535u;
	                }
	                uint _30893 = 4001u + ((_12091 / 3869893u) % 157u);
	                uint _30894 = _30893 / 2u;
	                uint _30904;
	                if ((_30893 & 1u) != 0u)
	                {
	                    _30904 = g_ScrambledHaltonPermutations.Load<uint>(_30894 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _30904 = g_ScrambledHaltonPermutations.Load<uint>(_30894 * 4 + 0) & 65535u;
	                }
	                _33359 = float((((_30859 * 3869893u) + (_30874 * 24649u)) + (_30889 * 157u)) + _30904) * 1.6458920892858941442682407796383e-09f;
	                _33360 = true;
	                break;
	            }
	            case 37u:
	            {
	                uint _30785 = _12091 % 163u;
	                uint _30787 = (4158u + _30785) / 2u;
	                uint _30797;
	                if ((_30785 & 1u) != 0u)
	                {
	                    _30797 = g_ScrambledHaltonPermutations.Load<uint>(_30787 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _30797 = g_ScrambledHaltonPermutations.Load<uint>(_30787 * 4 + 0) & 65535u;
	                }
	                uint _30800 = (_12091 / 163u) % 163u;
	                uint _30802 = (4158u + _30800) / 2u;
	                uint _30812;
	                if ((_30800 & 1u) != 0u)
	                {
	                    _30812 = g_ScrambledHaltonPermutations.Load<uint>(_30802 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _30812 = g_ScrambledHaltonPermutations.Load<uint>(_30802 * 4 + 0) & 65535u;
	                }
	                uint _30815 = (_12091 / 26569u) % 163u;
	                uint _30817 = (4158u + _30815) / 2u;
	                uint _30827;
	                if ((_30815 & 1u) != 0u)
	                {
	                    _30827 = g_ScrambledHaltonPermutations.Load<uint>(_30817 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _30827 = g_ScrambledHaltonPermutations.Load<uint>(_30817 * 4 + 0) & 65535u;
	                }
	                uint _30830 = (_12091 / 4330747u) % 163u;
	                uint _30832 = (4158u + _30830) / 2u;
	                uint _30842;
	                if ((_30830 & 1u) != 0u)
	                {
	                    _30842 = g_ScrambledHaltonPermutations.Load<uint>(_30832 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _30842 = g_ScrambledHaltonPermutations.Load<uint>(_30832 * 4 + 0) & 65535u;
	                }
	                _33359 = float((((_30797 * 4330747u) + (_30812 * 26569u)) + (_30827 * 163u)) + _30842) * 1.4166074979726772653521038591862e-09f;
	                _33360 = true;
	                break;
	            }
	            case 38u:
	            {
	                uint _30724 = 4321u + (_12091 % 167u);
	                uint _30725 = _30724 / 2u;
	                uint _30735;
	                if ((_30724 & 1u) != 0u)
	                {
	                    _30735 = g_ScrambledHaltonPermutations.Load<uint>(_30725 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _30735 = g_ScrambledHaltonPermutations.Load<uint>(_30725 * 4 + 0) & 65535u;
	                }
	                uint _30739 = 4321u + ((_12091 / 167u) % 167u);
	                uint _30740 = _30739 / 2u;
	                uint _30750;
	                if ((_30739 & 1u) != 0u)
	                {
	                    _30750 = g_ScrambledHaltonPermutations.Load<uint>(_30740 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _30750 = g_ScrambledHaltonPermutations.Load<uint>(_30740 * 4 + 0) & 65535u;
	                }
	                uint _30754 = 4321u + ((_12091 / 27889u) % 167u);
	                uint _30755 = _30754 / 2u;
	                uint _30765;
	                if ((_30754 & 1u) != 0u)
	                {
	                    _30765 = g_ScrambledHaltonPermutations.Load<uint>(_30755 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _30765 = g_ScrambledHaltonPermutations.Load<uint>(_30755 * 4 + 0) & 65535u;
	                }
	                uint _30769 = 4321u + ((_12091 / 4657463u) % 167u);
	                uint _30770 = _30769 / 2u;
	                uint _30780;
	                if ((_30769 & 1u) != 0u)
	                {
	                    _30780 = g_ScrambledHaltonPermutations.Load<uint>(_30770 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _30780 = g_ScrambledHaltonPermutations.Load<uint>(_30770 * 4 + 0) & 65535u;
	                }
	                _33359 = float((((_30735 * 4657463u) + (_30750 * 27889u)) + (_30765 * 167u)) + _30780) * 1.2856834485930335176817607134581e-09f;
	                _33360 = true;
	                break;
	            }
	            case 39u:
	            {
	                uint _30661 = _12091 % 173u;
	                uint _30663 = (4488u + _30661) / 2u;
	                uint _30673;
	                if ((_30661 & 1u) != 0u)
	                {
	                    _30673 = g_ScrambledHaltonPermutations.Load<uint>(_30663 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _30673 = g_ScrambledHaltonPermutations.Load<uint>(_30663 * 4 + 0) & 65535u;
	                }
	                uint _30676 = (_12091 / 173u) % 173u;
	                uint _30678 = (4488u + _30676) / 2u;
	                uint _30688;
	                if ((_30676 & 1u) != 0u)
	                {
	                    _30688 = g_ScrambledHaltonPermutations.Load<uint>(_30678 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _30688 = g_ScrambledHaltonPermutations.Load<uint>(_30678 * 4 + 0) & 65535u;
	                }
	                uint _30691 = (_12091 / 29929u) % 173u;
	                uint _30693 = (4488u + _30691) / 2u;
	                uint _30703;
	                if ((_30691 & 1u) != 0u)
	                {
	                    _30703 = g_ScrambledHaltonPermutations.Load<uint>(_30693 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _30703 = g_ScrambledHaltonPermutations.Load<uint>(_30693 * 4 + 0) & 65535u;
	                }
	                uint _30706 = (_12091 / 5177717u) % 173u;
	                uint _30708 = (4488u + _30706) / 2u;
	                uint _30718;
	                if ((_30706 & 1u) != 0u)
	                {
	                    _30718 = g_ScrambledHaltonPermutations.Load<uint>(_30708 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _30718 = g_ScrambledHaltonPermutations.Load<uint>(_30708 * 4 + 0) & 65535u;
	                }
	                _33359 = float((((_30673 * 5177717u) + (_30688 * 29929u)) + (_30703 * 173u)) + _30718) * 1.1163889812593197348178364336491e-09f;
	                _33360 = true;
	                break;
	            }
	            case 40u:
	            {
	                uint _30600 = 4661u + (_12091 % 179u);
	                uint _30601 = _30600 / 2u;
	                uint _30611;
	                if ((_30600 & 1u) != 0u)
	                {
	                    _30611 = g_ScrambledHaltonPermutations.Load<uint>(_30601 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _30611 = g_ScrambledHaltonPermutations.Load<uint>(_30601 * 4 + 0) & 65535u;
	                }
	                uint _30615 = 4661u + ((_12091 / 179u) % 179u);
	                uint _30616 = _30615 / 2u;
	                uint _30626;
	                if ((_30615 & 1u) != 0u)
	                {
	                    _30626 = g_ScrambledHaltonPermutations.Load<uint>(_30616 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _30626 = g_ScrambledHaltonPermutations.Load<uint>(_30616 * 4 + 0) & 65535u;
	                }
	                uint _30630 = 4661u + ((_12091 / 32041u) % 179u);
	                uint _30631 = _30630 / 2u;
	                uint _30641;
	                if ((_30630 & 1u) != 0u)
	                {
	                    _30641 = g_ScrambledHaltonPermutations.Load<uint>(_30631 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _30641 = g_ScrambledHaltonPermutations.Load<uint>(_30631 * 4 + 0) & 65535u;
	                }
	                uint _30645 = 4661u + ((_12091 / 5735339u) % 179u);
	                uint _30646 = _30645 / 2u;
	                uint _30656;
	                if ((_30645 & 1u) != 0u)
	                {
	                    _30656 = g_ScrambledHaltonPermutations.Load<uint>(_30646 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _30656 = g_ScrambledHaltonPermutations.Load<uint>(_30646 * 4 + 0) & 65535u;
	                }
	                _33359 = float((((_30611 * 5735339u) + (_30626 * 32041u)) + (_30641 * 179u)) + _30656) * 9.7406471777361502972780726850033e-10f;
	                _33360 = true;
	                break;
	            }
	            case 41u:
	            {
	                uint _30537 = _12091 % 181u;
	                uint _30539 = (4840u + _30537) / 2u;
	                uint _30549;
	                if ((_30537 & 1u) != 0u)
	                {
	                    _30549 = g_ScrambledHaltonPermutations.Load<uint>(_30539 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _30549 = g_ScrambledHaltonPermutations.Load<uint>(_30539 * 4 + 0) & 65535u;
	                }
	                uint _30552 = (_12091 / 181u) % 181u;
	                uint _30554 = (4840u + _30552) / 2u;
	                uint _30564;
	                if ((_30552 & 1u) != 0u)
	                {
	                    _30564 = g_ScrambledHaltonPermutations.Load<uint>(_30554 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _30564 = g_ScrambledHaltonPermutations.Load<uint>(_30554 * 4 + 0) & 65535u;
	                }
	                uint _30567 = (_12091 / 32761u) % 181u;
	                uint _30569 = (4840u + _30567) / 2u;
	                uint _30579;
	                if ((_30567 & 1u) != 0u)
	                {
	                    _30579 = g_ScrambledHaltonPermutations.Load<uint>(_30569 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _30579 = g_ScrambledHaltonPermutations.Load<uint>(_30569 * 4 + 0) & 65535u;
	                }
	                uint _30582 = (_12091 / 5929741u) % 181u;
	                uint _30584 = (4840u + _30582) / 2u;
	                uint _30594;
	                if ((_30582 & 1u) != 0u)
	                {
	                    _30594 = g_ScrambledHaltonPermutations.Load<uint>(_30584 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _30594 = g_ScrambledHaltonPermutations.Load<uint>(_30584 * 4 + 0) & 65535u;
	                }
	                _33359 = float((((_30549 * 5929741u) + (_30564 * 32761u)) + (_30579 * 181u)) + _30594) * 9.3172047854750417172908782958984e-10f;
	                _33360 = true;
	                break;
	            }
	            case 42u:
	            {
	                uint _30476 = 5021u + (_12091 % 191u);
	                uint _30477 = _30476 / 2u;
	                uint _30487;
	                if ((_30476 & 1u) != 0u)
	                {
	                    _30487 = g_ScrambledHaltonPermutations.Load<uint>(_30477 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _30487 = g_ScrambledHaltonPermutations.Load<uint>(_30477 * 4 + 0) & 65535u;
	                }
	                uint _30491 = 5021u + ((_12091 / 191u) % 191u);
	                uint _30492 = _30491 / 2u;
	                uint _30502;
	                if ((_30491 & 1u) != 0u)
	                {
	                    _30502 = g_ScrambledHaltonPermutations.Load<uint>(_30492 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _30502 = g_ScrambledHaltonPermutations.Load<uint>(_30492 * 4 + 0) & 65535u;
	                }
	                uint _30506 = 5021u + ((_12091 / 36481u) % 191u);
	                uint _30507 = _30506 / 2u;
	                uint _30517;
	                if ((_30506 & 1u) != 0u)
	                {
	                    _30517 = g_ScrambledHaltonPermutations.Load<uint>(_30507 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _30517 = g_ScrambledHaltonPermutations.Load<uint>(_30507 * 4 + 0) & 65535u;
	                }
	                uint _30521 = 5021u + ((_12091 / 6967871u) % 191u);
	                uint _30522 = _30521 / 2u;
	                uint _30532;
	                if ((_30521 & 1u) != 0u)
	                {
	                    _30532 = g_ScrambledHaltonPermutations.Load<uint>(_30522 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _30532 = g_ScrambledHaltonPermutations.Load<uint>(_30522 * 4 + 0) & 65535u;
	                }
	                _33359 = float((((_30487 * 6967871u) + (_30502 * 36481u)) + (_30517 * 191u)) + _30532) * 7.5139183763894834555685520172119e-10f;
	                _33360 = true;
	                break;
	            }
	            case 43u:
	            {
	                uint _30413 = _12091 % 193u;
	                uint _30415 = (5212u + _30413) / 2u;
	                uint _30425;
	                if ((_30413 & 1u) != 0u)
	                {
	                    _30425 = g_ScrambledHaltonPermutations.Load<uint>(_30415 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _30425 = g_ScrambledHaltonPermutations.Load<uint>(_30415 * 4 + 0) & 65535u;
	                }
	                uint _30428 = (_12091 / 193u) % 193u;
	                uint _30430 = (5212u + _30428) / 2u;
	                uint _30440;
	                if ((_30428 & 1u) != 0u)
	                {
	                    _30440 = g_ScrambledHaltonPermutations.Load<uint>(_30430 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _30440 = g_ScrambledHaltonPermutations.Load<uint>(_30430 * 4 + 0) & 65535u;
	                }
	                uint _30443 = (_12091 / 37249u) % 193u;
	                uint _30445 = (5212u + _30443) / 2u;
	                uint _30455;
	                if ((_30443 & 1u) != 0u)
	                {
	                    _30455 = g_ScrambledHaltonPermutations.Load<uint>(_30445 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _30455 = g_ScrambledHaltonPermutations.Load<uint>(_30445 * 4 + 0) & 65535u;
	                }
	                uint _30458 = (_12091 / 7189057u) % 193u;
	                uint _30460 = (5212u + _30458) / 2u;
	                uint _30470;
	                if ((_30458 & 1u) != 0u)
	                {
	                    _30470 = g_ScrambledHaltonPermutations.Load<uint>(_30460 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _30470 = g_ScrambledHaltonPermutations.Load<uint>(_30460 * 4 + 0) & 65535u;
	                }
	                _33359 = float((((_30425 * 7189057u) + (_30440 * 37249u)) + (_30455 * 193u)) + _30470) * 7.2072686707613797807425726205111e-10f;
	                _33360 = true;
	                break;
	            }
	            case 44u:
	            {
	                uint _30352 = 5405u + (_12091 % 197u);
	                uint _30353 = _30352 / 2u;
	                uint _30363;
	                if ((_30352 & 1u) != 0u)
	                {
	                    _30363 = g_ScrambledHaltonPermutations.Load<uint>(_30353 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _30363 = g_ScrambledHaltonPermutations.Load<uint>(_30353 * 4 + 0) & 65535u;
	                }
	                uint _30367 = 5405u + ((_12091 / 197u) % 197u);
	                uint _30368 = _30367 / 2u;
	                uint _30378;
	                if ((_30367 & 1u) != 0u)
	                {
	                    _30378 = g_ScrambledHaltonPermutations.Load<uint>(_30368 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _30378 = g_ScrambledHaltonPermutations.Load<uint>(_30368 * 4 + 0) & 65535u;
	                }
	                uint _30382 = 5405u + ((_12091 / 38809u) % 197u);
	                uint _30383 = _30382 / 2u;
	                uint _30393;
	                if ((_30382 & 1u) != 0u)
	                {
	                    _30393 = g_ScrambledHaltonPermutations.Load<uint>(_30383 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _30393 = g_ScrambledHaltonPermutations.Load<uint>(_30383 * 4 + 0) & 65535u;
	                }
	                uint _30397 = 5405u + ((_12091 / 7645373u) % 197u);
	                uint _30398 = _30397 / 2u;
	                uint _30408;
	                if ((_30397 & 1u) != 0u)
	                {
	                    _30408 = g_ScrambledHaltonPermutations.Load<uint>(_30398 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _30408 = g_ScrambledHaltonPermutations.Load<uint>(_30398 * 4 + 0) & 65535u;
	                }
	                _33359 = float((((_30363 * 7645373u) + (_30378 * 38809u)) + (_30393 * 197u)) + _30408) * 6.6394950648529516001872252672911e-10f;
	                _33360 = true;
	                break;
	            }
	            case 45u:
	            {
	                uint _30289 = _12091 % 199u;
	                uint _30291 = (5602u + _30289) / 2u;
	                uint _30301;
	                if ((_30289 & 1u) != 0u)
	                {
	                    _30301 = g_ScrambledHaltonPermutations.Load<uint>(_30291 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _30301 = g_ScrambledHaltonPermutations.Load<uint>(_30291 * 4 + 0) & 65535u;
	                }
	                uint _30304 = (_12091 / 199u) % 199u;
	                uint _30306 = (5602u + _30304) / 2u;
	                uint _30316;
	                if ((_30304 & 1u) != 0u)
	                {
	                    _30316 = g_ScrambledHaltonPermutations.Load<uint>(_30306 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _30316 = g_ScrambledHaltonPermutations.Load<uint>(_30306 * 4 + 0) & 65535u;
	                }
	                uint _30319 = (_12091 / 39601u) % 199u;
	                uint _30321 = (5602u + _30319) / 2u;
	                uint _30331;
	                if ((_30319 & 1u) != 0u)
	                {
	                    _30331 = g_ScrambledHaltonPermutations.Load<uint>(_30321 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _30331 = g_ScrambledHaltonPermutations.Load<uint>(_30321 * 4 + 0) & 65535u;
	                }
	                uint _30334 = (_12091 / 7880599u) % 199u;
	                uint _30336 = (5602u + _30334) / 2u;
	                uint _30346;
	                if ((_30334 & 1u) != 0u)
	                {
	                    _30346 = g_ScrambledHaltonPermutations.Load<uint>(_30336 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _30346 = g_ScrambledHaltonPermutations.Load<uint>(_30336 * 4 + 0) & 65535u;
	                }
	                _33359 = float((((_30301 * 7880599u) + (_30316 * 39601u)) + (_30331 * 199u)) + _30346) * 6.3765775992763451540668029338121e-10f;
	                _33360 = true;
	                break;
	            }
	            case 46u:
	            {
	                uint _30228 = 5801u + (_12091 % 211u);
	                uint _30229 = _30228 / 2u;
	                uint _30239;
	                if ((_30228 & 1u) != 0u)
	                {
	                    _30239 = g_ScrambledHaltonPermutations.Load<uint>(_30229 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _30239 = g_ScrambledHaltonPermutations.Load<uint>(_30229 * 4 + 0) & 65535u;
	                }
	                uint _30243 = 5801u + ((_12091 / 211u) % 211u);
	                uint _30244 = _30243 / 2u;
	                uint _30254;
	                if ((_30243 & 1u) != 0u)
	                {
	                    _30254 = g_ScrambledHaltonPermutations.Load<uint>(_30244 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _30254 = g_ScrambledHaltonPermutations.Load<uint>(_30244 * 4 + 0) & 65535u;
	                }
	                uint _30258 = 5801u + ((_12091 / 44521u) % 211u);
	                uint _30259 = _30258 / 2u;
	                uint _30269;
	                if ((_30258 & 1u) != 0u)
	                {
	                    _30269 = g_ScrambledHaltonPermutations.Load<uint>(_30259 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _30269 = g_ScrambledHaltonPermutations.Load<uint>(_30259 * 4 + 0) & 65535u;
	                }
	                uint _30273 = 5801u + ((_12091 / 9393931u) % 211u);
	                uint _30274 = _30273 / 2u;
	                uint _30284;
	                if ((_30273 & 1u) != 0u)
	                {
	                    _30284 = g_ScrambledHaltonPermutations.Load<uint>(_30274 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _30284 = g_ScrambledHaltonPermutations.Load<uint>(_30274 * 4 + 0) & 65535u;
	                }
	                _33359 = float((((_30239 * 9393931u) + (_30254 * 44521u)) + (_30269 * 211u)) + _30284) * 5.0451043343002766050631180405617e-10f;
	                _33360 = true;
	                break;
	            }
	            case 47u:
	            {
	                uint _30165 = _12091 % 223u;
	                uint _30167 = (6012u + _30165) / 2u;
	                uint _30177;
	                if ((_30165 & 1u) != 0u)
	                {
	                    _30177 = g_ScrambledHaltonPermutations.Load<uint>(_30167 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _30177 = g_ScrambledHaltonPermutations.Load<uint>(_30167 * 4 + 0) & 65535u;
	                }
	                uint _30180 = (_12091 / 223u) % 223u;
	                uint _30182 = (6012u + _30180) / 2u;
	                uint _30192;
	                if ((_30180 & 1u) != 0u)
	                {
	                    _30192 = g_ScrambledHaltonPermutations.Load<uint>(_30182 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _30192 = g_ScrambledHaltonPermutations.Load<uint>(_30182 * 4 + 0) & 65535u;
	                }
	                uint _30195 = (_12091 / 49729u) % 223u;
	                uint _30197 = (6012u + _30195) / 2u;
	                uint _30207;
	                if ((_30195 & 1u) != 0u)
	                {
	                    _30207 = g_ScrambledHaltonPermutations.Load<uint>(_30197 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _30207 = g_ScrambledHaltonPermutations.Load<uint>(_30197 * 4 + 0) & 65535u;
	                }
	                uint _30210 = (_12091 / 11089567u) % 223u;
	                uint _30212 = (6012u + _30210) / 2u;
	                uint _30222;
	                if ((_30210 & 1u) != 0u)
	                {
	                    _30222 = g_ScrambledHaltonPermutations.Load<uint>(_30212 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _30222 = g_ScrambledHaltonPermutations.Load<uint>(_30212 * 4 + 0) & 65535u;
	                }
	                _33359 = float((((_30177 * 11089567u) + (_30192 * 49729u)) + (_30207 * 223u)) + _30222) * 4.0437145298888310662732692435384e-10f;
	                _33360 = true;
	                break;
	            }
	            case 48u:
	            {
	                uint _30104 = 6235u + (_12091 % 227u);
	                uint _30105 = _30104 / 2u;
	                uint _30115;
	                if ((_30104 & 1u) != 0u)
	                {
	                    _30115 = g_ScrambledHaltonPermutations.Load<uint>(_30105 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _30115 = g_ScrambledHaltonPermutations.Load<uint>(_30105 * 4 + 0) & 65535u;
	                }
	                uint _30119 = 6235u + ((_12091 / 227u) % 227u);
	                uint _30120 = _30119 / 2u;
	                uint _30130;
	                if ((_30119 & 1u) != 0u)
	                {
	                    _30130 = g_ScrambledHaltonPermutations.Load<uint>(_30120 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _30130 = g_ScrambledHaltonPermutations.Load<uint>(_30120 * 4 + 0) & 65535u;
	                }
	                uint _30134 = 6235u + ((_12091 / 51529u) % 227u);
	                uint _30135 = _30134 / 2u;
	                uint _30145;
	                if ((_30134 & 1u) != 0u)
	                {
	                    _30145 = g_ScrambledHaltonPermutations.Load<uint>(_30135 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _30145 = g_ScrambledHaltonPermutations.Load<uint>(_30135 * 4 + 0) & 65535u;
	                }
	                uint _30149 = 6235u + ((_12091 / 11697083u) % 227u);
	                uint _30150 = _30149 / 2u;
	                uint _30160;
	                if ((_30149 & 1u) != 0u)
	                {
	                    _30160 = g_ScrambledHaltonPermutations.Load<uint>(_30150 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _30160 = g_ScrambledHaltonPermutations.Load<uint>(_30150 * 4 + 0) & 65535u;
	                }
	                _33359 = float((((_30115 * 11697083u) + (_30130 * 51529u)) + (_30145 * 227u)) + _30160) * 3.7661404550526356160844443365932e-10f;
	                _33360 = true;
	                break;
	            }
	            case 49u:
	            {
	                uint _30041 = _12091 % 229u;
	                uint _30043 = (6462u + _30041) / 2u;
	                uint _30053;
	                if ((_30041 & 1u) != 0u)
	                {
	                    _30053 = g_ScrambledHaltonPermutations.Load<uint>(_30043 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _30053 = g_ScrambledHaltonPermutations.Load<uint>(_30043 * 4 + 0) & 65535u;
	                }
	                uint _30056 = (_12091 / 229u) % 229u;
	                uint _30058 = (6462u + _30056) / 2u;
	                uint _30068;
	                if ((_30056 & 1u) != 0u)
	                {
	                    _30068 = g_ScrambledHaltonPermutations.Load<uint>(_30058 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _30068 = g_ScrambledHaltonPermutations.Load<uint>(_30058 * 4 + 0) & 65535u;
	                }
	                uint _30071 = (_12091 / 52441u) % 229u;
	                uint _30073 = (6462u + _30071) / 2u;
	                uint _30083;
	                if ((_30071 & 1u) != 0u)
	                {
	                    _30083 = g_ScrambledHaltonPermutations.Load<uint>(_30073 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _30083 = g_ScrambledHaltonPermutations.Load<uint>(_30073 * 4 + 0) & 65535u;
	                }
	                uint _30086 = (_12091 / 12008989u) % 229u;
	                uint _30088 = (6462u + _30086) / 2u;
	                uint _30098;
	                if ((_30086 & 1u) != 0u)
	                {
	                    _30098 = g_ScrambledHaltonPermutations.Load<uint>(_30088 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _30098 = g_ScrambledHaltonPermutations.Load<uint>(_30088 * 4 + 0) & 65535u;
	                }
	                _33359 = float((((_30053 * 12008989u) + (_30068 * 52441u)) + (_30083 * 229u)) + _30098) * 3.6362857169791595879360102117062e-10f;
	                _33360 = true;
	                break;
	            }
	            case 50u:
	            {
	                uint _29980 = 6691u + (_12091 % 233u);
	                uint _29981 = _29980 / 2u;
	                uint _29991;
	                if ((_29980 & 1u) != 0u)
	                {
	                    _29991 = g_ScrambledHaltonPermutations.Load<uint>(_29981 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _29991 = g_ScrambledHaltonPermutations.Load<uint>(_29981 * 4 + 0) & 65535u;
	                }
	                uint _29995 = 6691u + ((_12091 / 233u) % 233u);
	                uint _29996 = _29995 / 2u;
	                uint _30006;
	                if ((_29995 & 1u) != 0u)
	                {
	                    _30006 = g_ScrambledHaltonPermutations.Load<uint>(_29996 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _30006 = g_ScrambledHaltonPermutations.Load<uint>(_29996 * 4 + 0) & 65535u;
	                }
	                uint _30010 = 6691u + ((_12091 / 54289u) % 233u);
	                uint _30011 = _30010 / 2u;
	                uint _30021;
	                if ((_30010 & 1u) != 0u)
	                {
	                    _30021 = g_ScrambledHaltonPermutations.Load<uint>(_30011 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _30021 = g_ScrambledHaltonPermutations.Load<uint>(_30011 * 4 + 0) & 65535u;
	                }
	                uint _30025 = 6691u + ((_12091 / 12649337u) % 233u);
	                uint _30026 = _30025 / 2u;
	                uint _30036;
	                if ((_30025 & 1u) != 0u)
	                {
	                    _30036 = g_ScrambledHaltonPermutations.Load<uint>(_30026 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _30036 = g_ScrambledHaltonPermutations.Load<uint>(_30026 * 4 + 0) & 65535u;
	                }
	                _33359 = float((((_29991 * 12649337u) + (_30006 * 54289u)) + (_30021 * 233u)) + _30036) * 3.3929406506594261827558511868119e-10f;
	                _33360 = true;
	                break;
	            }
	            case 51u:
	            {
	                uint _29917 = _12091 % 239u;
	                uint _29919 = (6924u + _29917) / 2u;
	                uint _29929;
	                if ((_29917 & 1u) != 0u)
	                {
	                    _29929 = g_ScrambledHaltonPermutations.Load<uint>(_29919 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _29929 = g_ScrambledHaltonPermutations.Load<uint>(_29919 * 4 + 0) & 65535u;
	                }
	                uint _29932 = (_12091 / 239u) % 239u;
	                uint _29934 = (6924u + _29932) / 2u;
	                uint _29944;
	                if ((_29932 & 1u) != 0u)
	                {
	                    _29944 = g_ScrambledHaltonPermutations.Load<uint>(_29934 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _29944 = g_ScrambledHaltonPermutations.Load<uint>(_29934 * 4 + 0) & 65535u;
	                }
	                uint _29947 = (_12091 / 57121u) % 239u;
	                uint _29949 = (6924u + _29947) / 2u;
	                uint _29959;
	                if ((_29947 & 1u) != 0u)
	                {
	                    _29959 = g_ScrambledHaltonPermutations.Load<uint>(_29949 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _29959 = g_ScrambledHaltonPermutations.Load<uint>(_29949 * 4 + 0) & 65535u;
	                }
	                uint _29962 = (_12091 / 13651919u) % 239u;
	                uint _29964 = (6924u + _29962) / 2u;
	                uint _29974;
	                if ((_29962 & 1u) != 0u)
	                {
	                    _29974 = g_ScrambledHaltonPermutations.Load<uint>(_29964 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _29974 = g_ScrambledHaltonPermutations.Load<uint>(_29964 * 4 + 0) & 65535u;
	                }
	                _33359 = float((((_29929 * 13651919u) + (_29944 * 57121u)) + (_29959 * 239u)) + _29974) * 3.0648439341973698901711031794548e-10f;
	                _33360 = true;
	                break;
	            }
	            case 52u:
	            {
	                uint _29856 = 7163u + (_12091 % 241u);
	                uint _29857 = _29856 / 2u;
	                uint _29867;
	                if ((_29856 & 1u) != 0u)
	                {
	                    _29867 = g_ScrambledHaltonPermutations.Load<uint>(_29857 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _29867 = g_ScrambledHaltonPermutations.Load<uint>(_29857 * 4 + 0) & 65535u;
	                }
	                uint _29871 = 7163u + ((_12091 / 241u) % 241u);
	                uint _29872 = _29871 / 2u;
	                uint _29882;
	                if ((_29871 & 1u) != 0u)
	                {
	                    _29882 = g_ScrambledHaltonPermutations.Load<uint>(_29872 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _29882 = g_ScrambledHaltonPermutations.Load<uint>(_29872 * 4 + 0) & 65535u;
	                }
	                uint _29886 = 7163u + ((_12091 / 58081u) % 241u);
	                uint _29887 = _29886 / 2u;
	                uint _29897;
	                if ((_29886 & 1u) != 0u)
	                {
	                    _29897 = g_ScrambledHaltonPermutations.Load<uint>(_29887 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _29897 = g_ScrambledHaltonPermutations.Load<uint>(_29887 * 4 + 0) & 65535u;
	                }
	                uint _29901 = 7163u + ((_12091 / 13997521u) % 241u);
	                uint _29902 = _29901 / 2u;
	                uint _29912;
	                if ((_29901 & 1u) != 0u)
	                {
	                    _29912 = g_ScrambledHaltonPermutations.Load<uint>(_29902 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _29912 = g_ScrambledHaltonPermutations.Load<uint>(_29902 * 4 + 0) & 65535u;
	                }
	                _33359 = float((((_29867 * 13997521u) + (_29882 * 58081u)) + (_29897 * 241u)) + _29912) * 2.9643656973554755040822783485055e-10f;
	                _33360 = true;
	                break;
	            }
	            case 53u:
	            {
	                uint _29793 = _12091 % 251u;
	                uint _29795 = (7404u + _29793) / 2u;
	                uint _29805;
	                if ((_29793 & 1u) != 0u)
	                {
	                    _29805 = g_ScrambledHaltonPermutations.Load<uint>(_29795 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _29805 = g_ScrambledHaltonPermutations.Load<uint>(_29795 * 4 + 0) & 65535u;
	                }
	                uint _29808 = (_12091 / 251u) % 251u;
	                uint _29810 = (7404u + _29808) / 2u;
	                uint _29820;
	                if ((_29808 & 1u) != 0u)
	                {
	                    _29820 = g_ScrambledHaltonPermutations.Load<uint>(_29810 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _29820 = g_ScrambledHaltonPermutations.Load<uint>(_29810 * 4 + 0) & 65535u;
	                }
	                uint _29823 = (_12091 / 63001u) % 251u;
	                uint _29825 = (7404u + _29823) / 2u;
	                uint _29835;
	                if ((_29823 & 1u) != 0u)
	                {
	                    _29835 = g_ScrambledHaltonPermutations.Load<uint>(_29825 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _29835 = g_ScrambledHaltonPermutations.Load<uint>(_29825 * 4 + 0) & 65535u;
	                }
	                uint _29838 = (_12091 / 15813251u) % 251u;
	                uint _29840 = (7404u + _29838) / 2u;
	                uint _29850;
	                if ((_29838 & 1u) != 0u)
	                {
	                    _29850 = g_ScrambledHaltonPermutations.Load<uint>(_29840 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _29850 = g_ScrambledHaltonPermutations.Load<uint>(_29840 * 4 + 0) & 65535u;
	                }
	                _33359 = float((((_29805 * 15813251u) + (_29820 * 63001u)) + (_29835 * 251u)) + _29850) * 2.5194460406829932708205888047814e-10f;
	                _33360 = true;
	                break;
	            }
	            case 54u:
	            {
	                uint _29747 = 7655u + (_12091 % 257u);
	                uint _29748 = _29747 / 2u;
	                uint _29758;
	                if ((_29747 & 1u) != 0u)
	                {
	                    _29758 = g_ScrambledHaltonPermutations.Load<uint>(_29748 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _29758 = g_ScrambledHaltonPermutations.Load<uint>(_29748 * 4 + 0) & 65535u;
	                }
	                uint _29762 = 7655u + ((_12091 / 257u) % 257u);
	                uint _29763 = _29762 / 2u;
	                uint _29773;
	                if ((_29762 & 1u) != 0u)
	                {
	                    _29773 = g_ScrambledHaltonPermutations.Load<uint>(_29763 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _29773 = g_ScrambledHaltonPermutations.Load<uint>(_29763 * 4 + 0) & 65535u;
	                }
	                uint _29777 = 7655u + ((_12091 / 66049u) % 257u);
	                uint _29778 = _29777 / 2u;
	                uint _29788;
	                if ((_29777 & 1u) != 0u)
	                {
	                    _29788 = g_ScrambledHaltonPermutations.Load<uint>(_29778 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _29788 = g_ScrambledHaltonPermutations.Load<uint>(_29778 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_29758 * 66049u) + (_29773 * 257u)) + _29788) * 5.891157073278918687719851732254e-08f;
	                _33360 = true;
	                break;
	            }
	            case 55u:
	            {
	                uint _29699 = _12091 % 263u;
	                uint _29701 = (7912u + _29699) / 2u;
	                uint _29711;
	                if ((_29699 & 1u) != 0u)
	                {
	                    _29711 = g_ScrambledHaltonPermutations.Load<uint>(_29701 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _29711 = g_ScrambledHaltonPermutations.Load<uint>(_29701 * 4 + 0) & 65535u;
	                }
	                uint _29714 = (_12091 / 263u) % 263u;
	                uint _29716 = (7912u + _29714) / 2u;
	                uint _29726;
	                if ((_29714 & 1u) != 0u)
	                {
	                    _29726 = g_ScrambledHaltonPermutations.Load<uint>(_29716 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _29726 = g_ScrambledHaltonPermutations.Load<uint>(_29716 * 4 + 0) & 65535u;
	                }
	                uint _29729 = (_12091 / 69169u) % 263u;
	                uint _29731 = (7912u + _29729) / 2u;
	                uint _29741;
	                if ((_29729 & 1u) != 0u)
	                {
	                    _29741 = g_ScrambledHaltonPermutations.Load<uint>(_29731 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _29741 = g_ScrambledHaltonPermutations.Load<uint>(_29731 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_29711 * 69169u) + (_29726 * 263u)) + _29741) * 5.4970879403981598443351686000824e-08f;
	                _33360 = true;
	                break;
	            }
	            case 56u:
	            {
	                uint _29653 = 8175u + (_12091 % 269u);
	                uint _29654 = _29653 / 2u;
	                uint _29664;
	                if ((_29653 & 1u) != 0u)
	                {
	                    _29664 = g_ScrambledHaltonPermutations.Load<uint>(_29654 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _29664 = g_ScrambledHaltonPermutations.Load<uint>(_29654 * 4 + 0) & 65535u;
	                }
	                uint _29668 = 8175u + ((_12091 / 269u) % 269u);
	                uint _29669 = _29668 / 2u;
	                uint _29679;
	                if ((_29668 & 1u) != 0u)
	                {
	                    _29679 = g_ScrambledHaltonPermutations.Load<uint>(_29669 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _29679 = g_ScrambledHaltonPermutations.Load<uint>(_29669 * 4 + 0) & 65535u;
	                }
	                uint _29683 = 8175u + ((_12091 / 72361u) % 269u);
	                uint _29684 = _29683 / 2u;
	                uint _29694;
	                if ((_29683 & 1u) != 0u)
	                {
	                    _29694 = g_ScrambledHaltonPermutations.Load<uint>(_29684 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _29694 = g_ScrambledHaltonPermutations.Load<uint>(_29684 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_29664 * 72361u) + (_29679 * 269u)) + _29694) * 5.137396996701681928243488073349e-08f;
	                _33360 = true;
	                break;
	            }
	            case 57u:
	            {
	                uint _29605 = _12091 % 271u;
	                uint _29607 = (8444u + _29605) / 2u;
	                uint _29617;
	                if ((_29605 & 1u) != 0u)
	                {
	                    _29617 = g_ScrambledHaltonPermutations.Load<uint>(_29607 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _29617 = g_ScrambledHaltonPermutations.Load<uint>(_29607 * 4 + 0) & 65535u;
	                }
	                uint _29620 = (_12091 / 271u) % 271u;
	                uint _29622 = (8444u + _29620) / 2u;
	                uint _29632;
	                if ((_29620 & 1u) != 0u)
	                {
	                    _29632 = g_ScrambledHaltonPermutations.Load<uint>(_29622 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _29632 = g_ScrambledHaltonPermutations.Load<uint>(_29622 * 4 + 0) & 65535u;
	                }
	                uint _29635 = (_12091 / 73441u) % 271u;
	                uint _29637 = (8444u + _29635) / 2u;
	                uint _29647;
	                if ((_29635 & 1u) != 0u)
	                {
	                    _29647 = g_ScrambledHaltonPermutations.Load<uint>(_29637 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _29647 = g_ScrambledHaltonPermutations.Load<uint>(_29637 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_29617 * 73441u) + (_29632 * 271u)) + _29647) * 5.0244906901752983685582876205444e-08f;
	                _33360 = true;
	                break;
	            }
	            case 58u:
	            {
	                uint _29559 = 8715u + (_12091 % 277u);
	                uint _29560 = _29559 / 2u;
	                uint _29570;
	                if ((_29559 & 1u) != 0u)
	                {
	                    _29570 = g_ScrambledHaltonPermutations.Load<uint>(_29560 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _29570 = g_ScrambledHaltonPermutations.Load<uint>(_29560 * 4 + 0) & 65535u;
	                }
	                uint _29574 = 8715u + ((_12091 / 277u) % 277u);
	                uint _29575 = _29574 / 2u;
	                uint _29585;
	                if ((_29574 & 1u) != 0u)
	                {
	                    _29585 = g_ScrambledHaltonPermutations.Load<uint>(_29575 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _29585 = g_ScrambledHaltonPermutations.Load<uint>(_29575 * 4 + 0) & 65535u;
	                }
	                uint _29589 = 8715u + ((_12091 / 76729u) % 277u);
	                uint _29590 = _29589 / 2u;
	                uint _29600;
	                if ((_29589 & 1u) != 0u)
	                {
	                    _29600 = g_ScrambledHaltonPermutations.Load<uint>(_29590 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _29600 = g_ScrambledHaltonPermutations.Load<uint>(_29590 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_29570 * 76729u) + (_29585 * 277u)) + _29600) * 4.705011136252323922235518693924e-08f;
	                _33360 = true;
	                break;
	            }
	            case 59u:
	            {
	                uint _29511 = _12091 % 281u;
	                uint _29513 = (8992u + _29511) / 2u;
	                uint _29523;
	                if ((_29511 & 1u) != 0u)
	                {
	                    _29523 = g_ScrambledHaltonPermutations.Load<uint>(_29513 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _29523 = g_ScrambledHaltonPermutations.Load<uint>(_29513 * 4 + 0) & 65535u;
	                }
	                uint _29526 = (_12091 / 281u) % 281u;
	                uint _29528 = (8992u + _29526) / 2u;
	                uint _29538;
	                if ((_29526 & 1u) != 0u)
	                {
	                    _29538 = g_ScrambledHaltonPermutations.Load<uint>(_29528 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _29538 = g_ScrambledHaltonPermutations.Load<uint>(_29528 * 4 + 0) & 65535u;
	                }
	                uint _29541 = (_12091 / 78961u) % 281u;
	                uint _29543 = (8992u + _29541) / 2u;
	                uint _29553;
	                if ((_29541 & 1u) != 0u)
	                {
	                    _29553 = g_ScrambledHaltonPermutations.Load<uint>(_29543 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _29553 = g_ScrambledHaltonPermutations.Load<uint>(_29543 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_29523 * 78961u) + (_29538 * 281u)) + _29553) * 4.5069320719903771532699465751648e-08f;
	                _33360 = true;
	                break;
	            }
	            case 60u:
	            {
	                uint _29465 = 9273u + (_12091 % 283u);
	                uint _29466 = _29465 / 2u;
	                uint _29476;
	                if ((_29465 & 1u) != 0u)
	                {
	                    _29476 = g_ScrambledHaltonPermutations.Load<uint>(_29466 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _29476 = g_ScrambledHaltonPermutations.Load<uint>(_29466 * 4 + 0) & 65535u;
	                }
	                uint _29480 = 9273u + ((_12091 / 283u) % 283u);
	                uint _29481 = _29480 / 2u;
	                uint _29491;
	                if ((_29480 & 1u) != 0u)
	                {
	                    _29491 = g_ScrambledHaltonPermutations.Load<uint>(_29481 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _29491 = g_ScrambledHaltonPermutations.Load<uint>(_29481 * 4 + 0) & 65535u;
	                }
	                uint _29495 = 9273u + ((_12091 / 80089u) % 283u);
	                uint _29496 = _29495 / 2u;
	                uint _29506;
	                if ((_29495 & 1u) != 0u)
	                {
	                    _29506 = g_ScrambledHaltonPermutations.Load<uint>(_29496 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _29506 = g_ScrambledHaltonPermutations.Load<uint>(_29496 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_29476 * 80089u) + (_29491 * 283u)) + _29506) * 4.4120518793988594552502036094666e-08f;
	                _33360 = true;
	                break;
	            }
	            case 61u:
	            {
	                uint _29417 = _12091 % 293u;
	                uint _29419 = (9556u + _29417) / 2u;
	                uint _29429;
	                if ((_29417 & 1u) != 0u)
	                {
	                    _29429 = g_ScrambledHaltonPermutations.Load<uint>(_29419 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _29429 = g_ScrambledHaltonPermutations.Load<uint>(_29419 * 4 + 0) & 65535u;
	                }
	                uint _29432 = (_12091 / 293u) % 293u;
	                uint _29434 = (9556u + _29432) / 2u;
	                uint _29444;
	                if ((_29432 & 1u) != 0u)
	                {
	                    _29444 = g_ScrambledHaltonPermutations.Load<uint>(_29434 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _29444 = g_ScrambledHaltonPermutations.Load<uint>(_29434 * 4 + 0) & 65535u;
	                }
	                uint _29447 = (_12091 / 85849u) % 293u;
	                uint _29449 = (9556u + _29447) / 2u;
	                uint _29459;
	                if ((_29447 & 1u) != 0u)
	                {
	                    _29459 = g_ScrambledHaltonPermutations.Load<uint>(_29449 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _29459 = g_ScrambledHaltonPermutations.Load<uint>(_29449 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_29429 * 85849u) + (_29444 * 293u)) + _29459) * 3.975548779067139548715204000473e-08f;
	                _33360 = true;
	                break;
	            }
	            case 62u:
	            {
	                uint _29371 = 9849u + (_12091 % 307u);
	                uint _29372 = _29371 / 2u;
	                uint _29382;
	                if ((_29371 & 1u) != 0u)
	                {
	                    _29382 = g_ScrambledHaltonPermutations.Load<uint>(_29372 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _29382 = g_ScrambledHaltonPermutations.Load<uint>(_29372 * 4 + 0) & 65535u;
	                }
	                uint _29386 = 9849u + ((_12091 / 307u) % 307u);
	                uint _29387 = _29386 / 2u;
	                uint _29397;
	                if ((_29386 & 1u) != 0u)
	                {
	                    _29397 = g_ScrambledHaltonPermutations.Load<uint>(_29387 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _29397 = g_ScrambledHaltonPermutations.Load<uint>(_29387 * 4 + 0) & 65535u;
	                }
	                uint _29401 = 9849u + ((_12091 / 94249u) % 307u);
	                uint _29402 = _29401 / 2u;
	                uint _29412;
	                if ((_29401 & 1u) != 0u)
	                {
	                    _29412 = g_ScrambledHaltonPermutations.Load<uint>(_29402 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _29412 = g_ScrambledHaltonPermutations.Load<uint>(_29402 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_29382 * 94249u) + (_29397 * 307u)) + _29412) * 3.4560880379785885452292859554291e-08f;
	                _33360 = true;
	                break;
	            }
	            case 63u:
	            {
	                uint _29323 = _12091 % 311u;
	                uint _29325 = (10156u + _29323) / 2u;
	                uint _29335;
	                if ((_29323 & 1u) != 0u)
	                {
	                    _29335 = g_ScrambledHaltonPermutations.Load<uint>(_29325 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _29335 = g_ScrambledHaltonPermutations.Load<uint>(_29325 * 4 + 0) & 65535u;
	                }
	                uint _29338 = (_12091 / 311u) % 311u;
	                uint _29340 = (10156u + _29338) / 2u;
	                uint _29350;
	                if ((_29338 & 1u) != 0u)
	                {
	                    _29350 = g_ScrambledHaltonPermutations.Load<uint>(_29340 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _29350 = g_ScrambledHaltonPermutations.Load<uint>(_29340 * 4 + 0) & 65535u;
	                }
	                uint _29353 = (_12091 / 96721u) % 311u;
	                uint _29355 = (10156u + _29353) / 2u;
	                uint _29365;
	                if ((_29353 & 1u) != 0u)
	                {
	                    _29365 = g_ScrambledHaltonPermutations.Load<uint>(_29355 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _29365 = g_ScrambledHaltonPermutations.Load<uint>(_29355 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_29335 * 96721u) + (_29350 * 311u)) + _29365) * 3.3244418773392681032419204711914e-08f;
	                _33360 = true;
	                break;
	            }
	            case 64u:
	            {
	                uint _29277 = 10467u + (_12091 % 313u);
	                uint _29278 = _29277 / 2u;
	                uint _29288;
	                if ((_29277 & 1u) != 0u)
	                {
	                    _29288 = g_ScrambledHaltonPermutations.Load<uint>(_29278 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _29288 = g_ScrambledHaltonPermutations.Load<uint>(_29278 * 4 + 0) & 65535u;
	                }
	                uint _29292 = 10467u + ((_12091 / 313u) % 313u);
	                uint _29293 = _29292 / 2u;
	                uint _29303;
	                if ((_29292 & 1u) != 0u)
	                {
	                    _29303 = g_ScrambledHaltonPermutations.Load<uint>(_29293 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _29303 = g_ScrambledHaltonPermutations.Load<uint>(_29293 * 4 + 0) & 65535u;
	                }
	                uint _29307 = 10467u + ((_12091 / 97969u) % 313u);
	                uint _29308 = _29307 / 2u;
	                uint _29318;
	                if ((_29307 & 1u) != 0u)
	                {
	                    _29318 = g_ScrambledHaltonPermutations.Load<uint>(_29308 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _29318 = g_ScrambledHaltonPermutations.Load<uint>(_29308 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_29288 * 97969u) + (_29303 * 313u)) + _29318) * 3.2611211508992710150778293609619e-08f;
	                _33360 = true;
	                break;
	            }
	            case 65u:
	            {
	                uint _29229 = _12091 % 317u;
	                uint _29231 = (10780u + _29229) / 2u;
	                uint _29241;
	                if ((_29229 & 1u) != 0u)
	                {
	                    _29241 = g_ScrambledHaltonPermutations.Load<uint>(_29231 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _29241 = g_ScrambledHaltonPermutations.Load<uint>(_29231 * 4 + 0) & 65535u;
	                }
	                uint _29244 = (_12091 / 317u) % 317u;
	                uint _29246 = (10780u + _29244) / 2u;
	                uint _29256;
	                if ((_29244 & 1u) != 0u)
	                {
	                    _29256 = g_ScrambledHaltonPermutations.Load<uint>(_29246 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _29256 = g_ScrambledHaltonPermutations.Load<uint>(_29246 * 4 + 0) & 65535u;
	                }
	                uint _29259 = (_12091 / 100489u) % 317u;
	                uint _29261 = (10780u + _29259) / 2u;
	                uint _29271;
	                if ((_29259 & 1u) != 0u)
	                {
	                    _29271 = g_ScrambledHaltonPermutations.Load<uint>(_29261 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _29271 = g_ScrambledHaltonPermutations.Load<uint>(_29261 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_29241 * 100489u) + (_29256 * 317u)) + _29271) * 3.1392229260518433875404298305511e-08f;
	                _33360 = true;
	                break;
	            }
	            case 66u:
	            {
	                uint _29183 = 11097u + (_12091 % 331u);
	                uint _29184 = _29183 / 2u;
	                uint _29194;
	                if ((_29183 & 1u) != 0u)
	                {
	                    _29194 = g_ScrambledHaltonPermutations.Load<uint>(_29184 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _29194 = g_ScrambledHaltonPermutations.Load<uint>(_29184 * 4 + 0) & 65535u;
	                }
	                uint _29198 = 11097u + ((_12091 / 331u) % 331u);
	                uint _29199 = _29198 / 2u;
	                uint _29209;
	                if ((_29198 & 1u) != 0u)
	                {
	                    _29209 = g_ScrambledHaltonPermutations.Load<uint>(_29199 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _29209 = g_ScrambledHaltonPermutations.Load<uint>(_29199 * 4 + 0) & 65535u;
	                }
	                uint _29213 = 11097u + ((_12091 / 109561u) % 331u);
	                uint _29214 = _29213 / 2u;
	                uint _29224;
	                if ((_29213 & 1u) != 0u)
	                {
	                    _29224 = g_ScrambledHaltonPermutations.Load<uint>(_29214 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _29224 = g_ScrambledHaltonPermutations.Load<uint>(_29214 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_29194 * 109561u) + (_29209 * 331u)) + _29224) * 2.7575026706472272053360939025879e-08f;
	                _33360 = true;
	                break;
	            }
	            case 67u:
	            {
	                uint _29135 = _12091 % 337u;
	                uint _29137 = (11428u + _29135) / 2u;
	                uint _29147;
	                if ((_29135 & 1u) != 0u)
	                {
	                    _29147 = g_ScrambledHaltonPermutations.Load<uint>(_29137 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _29147 = g_ScrambledHaltonPermutations.Load<uint>(_29137 * 4 + 0) & 65535u;
	                }
	                uint _29150 = (_12091 / 337u) % 337u;
	                uint _29152 = (11428u + _29150) / 2u;
	                uint _29162;
	                if ((_29150 & 1u) != 0u)
	                {
	                    _29162 = g_ScrambledHaltonPermutations.Load<uint>(_29152 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _29162 = g_ScrambledHaltonPermutations.Load<uint>(_29152 * 4 + 0) & 65535u;
	                }
	                uint _29165 = (_12091 / 113569u) % 337u;
	                uint _29167 = (11428u + _29165) / 2u;
	                uint _29177;
	                if ((_29165 & 1u) != 0u)
	                {
	                    _29177 = g_ScrambledHaltonPermutations.Load<uint>(_29167 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _29177 = g_ScrambledHaltonPermutations.Load<uint>(_29167 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_29147 * 113569u) + (_29162 * 337u)) + _29177) * 2.6128246233270147058647125959396e-08f;
	                _33360 = true;
	                break;
	            }
	            case 68u:
	            {
	                uint _29089 = 11765u + (_12091 % 347u);
	                uint _29090 = _29089 / 2u;
	                uint _29100;
	                if ((_29089 & 1u) != 0u)
	                {
	                    _29100 = g_ScrambledHaltonPermutations.Load<uint>(_29090 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _29100 = g_ScrambledHaltonPermutations.Load<uint>(_29090 * 4 + 0) & 65535u;
	                }
	                uint _29104 = 11765u + ((_12091 / 347u) % 347u);
	                uint _29105 = _29104 / 2u;
	                uint _29115;
	                if ((_29104 & 1u) != 0u)
	                {
	                    _29115 = g_ScrambledHaltonPermutations.Load<uint>(_29105 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _29115 = g_ScrambledHaltonPermutations.Load<uint>(_29105 * 4 + 0) & 65535u;
	                }
	                uint _29119 = 11765u + ((_12091 / 120409u) % 347u);
	                uint _29120 = _29119 / 2u;
	                uint _29130;
	                if ((_29119 & 1u) != 0u)
	                {
	                    _29130 = g_ScrambledHaltonPermutations.Load<uint>(_29120 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _29130 = g_ScrambledHaltonPermutations.Load<uint>(_29120 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_29100 * 120409u) + (_29115 * 347u)) + _29130) * 2.3933791837293938442599028348923e-08f;
	                _33360 = true;
	                break;
	            }
	            case 69u:
	            {
	                uint _29041 = _12091 % 349u;
	                uint _29043 = (12112u + _29041) / 2u;
	                uint _29053;
	                if ((_29041 & 1u) != 0u)
	                {
	                    _29053 = g_ScrambledHaltonPermutations.Load<uint>(_29043 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _29053 = g_ScrambledHaltonPermutations.Load<uint>(_29043 * 4 + 0) & 65535u;
	                }
	                uint _29056 = (_12091 / 349u) % 349u;
	                uint _29058 = (12112u + _29056) / 2u;
	                uint _29068;
	                if ((_29056 & 1u) != 0u)
	                {
	                    _29068 = g_ScrambledHaltonPermutations.Load<uint>(_29058 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _29068 = g_ScrambledHaltonPermutations.Load<uint>(_29058 * 4 + 0) & 65535u;
	                }
	                uint _29071 = (_12091 / 121801u) % 349u;
	                uint _29073 = (12112u + _29071) / 2u;
	                uint _29083;
	                if ((_29071 & 1u) != 0u)
	                {
	                    _29083 = g_ScrambledHaltonPermutations.Load<uint>(_29073 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _29083 = g_ScrambledHaltonPermutations.Load<uint>(_29073 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_29053 * 121801u) + (_29068 * 349u)) + _29083) * 2.3524677317254827357828617095947e-08f;
	                _33360 = true;
	                break;
	            }
	            case 70u:
	            {
	                uint _28995 = 12461u + (_12091 % 353u);
	                uint _28996 = _28995 / 2u;
	                uint _29006;
	                if ((_28995 & 1u) != 0u)
	                {
	                    _29006 = g_ScrambledHaltonPermutations.Load<uint>(_28996 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _29006 = g_ScrambledHaltonPermutations.Load<uint>(_28996 * 4 + 0) & 65535u;
	                }
	                uint _29010 = 12461u + ((_12091 / 353u) % 353u);
	                uint _29011 = _29010 / 2u;
	                uint _29021;
	                if ((_29010 & 1u) != 0u)
	                {
	                    _29021 = g_ScrambledHaltonPermutations.Load<uint>(_29011 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _29021 = g_ScrambledHaltonPermutations.Load<uint>(_29011 * 4 + 0) & 65535u;
	                }
	                uint _29025 = 12461u + ((_12091 / 124609u) % 353u);
	                uint _29026 = _29025 / 2u;
	                uint _29036;
	                if ((_29025 & 1u) != 0u)
	                {
	                    _29036 = g_ScrambledHaltonPermutations.Load<uint>(_29026 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _29036 = g_ScrambledHaltonPermutations.Load<uint>(_29026 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_29006 * 124609u) + (_29021 * 353u)) + _29036) * 2.2733999571755703072994947433472e-08f;
	                _33360 = true;
	                break;
	            }
	            case 71u:
	            {
	                uint _28947 = _12091 % 359u;
	                uint _28949 = (12814u + _28947) / 2u;
	                uint _28959;
	                if ((_28947 & 1u) != 0u)
	                {
	                    _28959 = g_ScrambledHaltonPermutations.Load<uint>(_28949 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _28959 = g_ScrambledHaltonPermutations.Load<uint>(_28949 * 4 + 0) & 65535u;
	                }
	                uint _28962 = (_12091 / 359u) % 359u;
	                uint _28964 = (12814u + _28962) / 2u;
	                uint _28974;
	                if ((_28962 & 1u) != 0u)
	                {
	                    _28974 = g_ScrambledHaltonPermutations.Load<uint>(_28964 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _28974 = g_ScrambledHaltonPermutations.Load<uint>(_28964 * 4 + 0) & 65535u;
	                }
	                uint _28977 = (_12091 / 128881u) % 359u;
	                uint _28979 = (12814u + _28977) / 2u;
	                uint _28989;
	                if ((_28977 & 1u) != 0u)
	                {
	                    _28989 = g_ScrambledHaltonPermutations.Load<uint>(_28979 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _28989 = g_ScrambledHaltonPermutations.Load<uint>(_28979 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_28959 * 128881u) + (_28974 * 359u)) + _28989) * 2.1613075773529999423772096633911e-08f;
	                _33360 = true;
	                break;
	            }
	            case 72u:
	            {
	                uint _28901 = 13173u + (_12091 % 367u);
	                uint _28902 = _28901 / 2u;
	                uint _28912;
	                if ((_28901 & 1u) != 0u)
	                {
	                    _28912 = g_ScrambledHaltonPermutations.Load<uint>(_28902 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _28912 = g_ScrambledHaltonPermutations.Load<uint>(_28902 * 4 + 0) & 65535u;
	                }
	                uint _28916 = 13173u + ((_12091 / 367u) % 367u);
	                uint _28917 = _28916 / 2u;
	                uint _28927;
	                if ((_28916 & 1u) != 0u)
	                {
	                    _28927 = g_ScrambledHaltonPermutations.Load<uint>(_28917 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _28927 = g_ScrambledHaltonPermutations.Load<uint>(_28917 * 4 + 0) & 65535u;
	                }
	                uint _28931 = 13173u + ((_12091 / 134689u) % 367u);
	                uint _28932 = _28931 / 2u;
	                uint _28942;
	                if ((_28931 & 1u) != 0u)
	                {
	                    _28942 = g_ScrambledHaltonPermutations.Load<uint>(_28932 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _28942 = g_ScrambledHaltonPermutations.Load<uint>(_28932 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_28912 * 134689u) + (_28927 * 367u)) + _28942) * 2.0230272568255713849794119596481e-08f;
	                _33360 = true;
	                break;
	            }
	            case 73u:
	            {
	                uint _28853 = _12091 % 373u;
	                uint _28855 = (13540u + _28853) / 2u;
	                uint _28865;
	                if ((_28853 & 1u) != 0u)
	                {
	                    _28865 = g_ScrambledHaltonPermutations.Load<uint>(_28855 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _28865 = g_ScrambledHaltonPermutations.Load<uint>(_28855 * 4 + 0) & 65535u;
	                }
	                uint _28868 = (_12091 / 373u) % 373u;
	                uint _28870 = (13540u + _28868) / 2u;
	                uint _28880;
	                if ((_28868 & 1u) != 0u)
	                {
	                    _28880 = g_ScrambledHaltonPermutations.Load<uint>(_28870 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _28880 = g_ScrambledHaltonPermutations.Load<uint>(_28870 * 4 + 0) & 65535u;
	                }
	                uint _28883 = (_12091 / 139129u) % 373u;
	                uint _28885 = (13540u + _28883) / 2u;
	                uint _28895;
	                if ((_28883 & 1u) != 0u)
	                {
	                    _28895 = g_ScrambledHaltonPermutations.Load<uint>(_28885 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _28895 = g_ScrambledHaltonPermutations.Load<uint>(_28885 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_28865 * 139129u) + (_28880 * 373u)) + _28895) * 1.9269633000362773600500077009201e-08f;
	                _33360 = true;
	                break;
	            }
	            case 74u:
	            {
	                uint _28807 = 13913u + (_12091 % 379u);
	                uint _28808 = _28807 / 2u;
	                uint _28818;
	                if ((_28807 & 1u) != 0u)
	                {
	                    _28818 = g_ScrambledHaltonPermutations.Load<uint>(_28808 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _28818 = g_ScrambledHaltonPermutations.Load<uint>(_28808 * 4 + 0) & 65535u;
	                }
	                uint _28822 = 13913u + ((_12091 / 379u) % 379u);
	                uint _28823 = _28822 / 2u;
	                uint _28833;
	                if ((_28822 & 1u) != 0u)
	                {
	                    _28833 = g_ScrambledHaltonPermutations.Load<uint>(_28823 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _28833 = g_ScrambledHaltonPermutations.Load<uint>(_28823 * 4 + 0) & 65535u;
	                }
	                uint _28837 = 13913u + ((_12091 / 143641u) % 379u);
	                uint _28838 = _28837 / 2u;
	                uint _28848;
	                if ((_28837 & 1u) != 0u)
	                {
	                    _28848 = g_ScrambledHaltonPermutations.Load<uint>(_28838 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _28848 = g_ScrambledHaltonPermutations.Load<uint>(_28838 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_28818 * 143641u) + (_28833 * 379u)) + _28848) * 1.8368863763384979392867535352707e-08f;
	                _33360 = true;
	                break;
	            }
	            case 75u:
	            {
	                uint _28759 = _12091 % 383u;
	                uint _28761 = (14292u + _28759) / 2u;
	                uint _28771;
	                if ((_28759 & 1u) != 0u)
	                {
	                    _28771 = g_ScrambledHaltonPermutations.Load<uint>(_28761 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _28771 = g_ScrambledHaltonPermutations.Load<uint>(_28761 * 4 + 0) & 65535u;
	                }
	                uint _28774 = (_12091 / 383u) % 383u;
	                uint _28776 = (14292u + _28774) / 2u;
	                uint _28786;
	                if ((_28774 & 1u) != 0u)
	                {
	                    _28786 = g_ScrambledHaltonPermutations.Load<uint>(_28776 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _28786 = g_ScrambledHaltonPermutations.Load<uint>(_28776 * 4 + 0) & 65535u;
	                }
	                uint _28789 = (_12091 / 146689u) % 383u;
	                uint _28791 = (14292u + _28789) / 2u;
	                uint _28801;
	                if ((_28789 & 1u) != 0u)
	                {
	                    _28801 = g_ScrambledHaltonPermutations.Load<uint>(_28791 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _28801 = g_ScrambledHaltonPermutations.Load<uint>(_28791 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_28771 * 146689u) + (_28786 * 383u)) + _28801) * 1.779932823353647108888253569603e-08f;
	                _33360 = true;
	                break;
	            }
	            case 76u:
	            {
	                uint _28713 = 14675u + (_12091 % 389u);
	                uint _28714 = _28713 / 2u;
	                uint _28724;
	                if ((_28713 & 1u) != 0u)
	                {
	                    _28724 = g_ScrambledHaltonPermutations.Load<uint>(_28714 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _28724 = g_ScrambledHaltonPermutations.Load<uint>(_28714 * 4 + 0) & 65535u;
	                }
	                uint _28728 = 14675u + ((_12091 / 389u) % 389u);
	                uint _28729 = _28728 / 2u;
	                uint _28739;
	                if ((_28728 & 1u) != 0u)
	                {
	                    _28739 = g_ScrambledHaltonPermutations.Load<uint>(_28729 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _28739 = g_ScrambledHaltonPermutations.Load<uint>(_28729 * 4 + 0) & 65535u;
	                }
	                uint _28743 = 14675u + ((_12091 / 151321u) % 389u);
	                uint _28744 = _28743 / 2u;
	                uint _28754;
	                if ((_28743 & 1u) != 0u)
	                {
	                    _28754 = g_ScrambledHaltonPermutations.Load<uint>(_28744 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _28754 = g_ScrambledHaltonPermutations.Load<uint>(_28744 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_28724 * 151321u) + (_28739 * 389u)) + _28754) * 1.6988348505719841341488063335419e-08f;
	                _33360 = true;
	                break;
	            }
	            case 77u:
	            {
	                uint _28665 = _12091 % 397u;
	                uint _28667 = (15064u + _28665) / 2u;
	                uint _28677;
	                if ((_28665 & 1u) != 0u)
	                {
	                    _28677 = g_ScrambledHaltonPermutations.Load<uint>(_28667 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _28677 = g_ScrambledHaltonPermutations.Load<uint>(_28667 * 4 + 0) & 65535u;
	                }
	                uint _28680 = (_12091 / 397u) % 397u;
	                uint _28682 = (15064u + _28680) / 2u;
	                uint _28692;
	                if ((_28680 & 1u) != 0u)
	                {
	                    _28692 = g_ScrambledHaltonPermutations.Load<uint>(_28682 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _28692 = g_ScrambledHaltonPermutations.Load<uint>(_28682 * 4 + 0) & 65535u;
	                }
	                uint _28695 = (_12091 / 157609u) % 397u;
	                uint _28697 = (15064u + _28695) / 2u;
	                uint _28707;
	                if ((_28695 & 1u) != 0u)
	                {
	                    _28707 = g_ScrambledHaltonPermutations.Load<uint>(_28697 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _28707 = g_ScrambledHaltonPermutations.Load<uint>(_28697 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_28677 * 157609u) + (_28692 * 397u)) + _28707) * 1.5981900247652447433210909366608e-08f;
	                _33360 = true;
	                break;
	            }
	            case 78u:
	            {
	                uint _28619 = 15461u + (_12091 % 401u);
	                uint _28620 = _28619 / 2u;
	                uint _28630;
	                if ((_28619 & 1u) != 0u)
	                {
	                    _28630 = g_ScrambledHaltonPermutations.Load<uint>(_28620 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _28630 = g_ScrambledHaltonPermutations.Load<uint>(_28620 * 4 + 0) & 65535u;
	                }
	                uint _28634 = 15461u + ((_12091 / 401u) % 401u);
	                uint _28635 = _28634 / 2u;
	                uint _28645;
	                if ((_28634 & 1u) != 0u)
	                {
	                    _28645 = g_ScrambledHaltonPermutations.Load<uint>(_28635 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _28645 = g_ScrambledHaltonPermutations.Load<uint>(_28635 * 4 + 0) & 65535u;
	                }
	                uint _28649 = 15461u + ((_12091 / 160801u) % 401u);
	                uint _28650 = _28649 / 2u;
	                uint _28660;
	                if ((_28649 & 1u) != 0u)
	                {
	                    _28660 = g_ScrambledHaltonPermutations.Load<uint>(_28650 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _28660 = g_ScrambledHaltonPermutations.Load<uint>(_28650 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_28630 * 160801u) + (_28645 * 401u)) + _28660) * 1.5508394568541916669346392154694e-08f;
	                _33360 = true;
	                break;
	            }
	            case 79u:
	            {
	                uint _28571 = _12091 % 409u;
	                uint _28573 = (15862u + _28571) / 2u;
	                uint _28583;
	                if ((_28571 & 1u) != 0u)
	                {
	                    _28583 = g_ScrambledHaltonPermutations.Load<uint>(_28573 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _28583 = g_ScrambledHaltonPermutations.Load<uint>(_28573 * 4 + 0) & 65535u;
	                }
	                uint _28586 = (_12091 / 409u) % 409u;
	                uint _28588 = (15862u + _28586) / 2u;
	                uint _28598;
	                if ((_28586 & 1u) != 0u)
	                {
	                    _28598 = g_ScrambledHaltonPermutations.Load<uint>(_28588 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _28598 = g_ScrambledHaltonPermutations.Load<uint>(_28588 * 4 + 0) & 65535u;
	                }
	                uint _28601 = (_12091 / 167281u) % 409u;
	                uint _28603 = (15862u + _28601) / 2u;
	                uint _28613;
	                if ((_28601 & 1u) != 0u)
	                {
	                    _28613 = g_ScrambledHaltonPermutations.Load<uint>(_28603 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _28613 = g_ScrambledHaltonPermutations.Load<uint>(_28603 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_28583 * 167281u) + (_28598 * 409u)) + _28613) * 1.4616050592053397849667817354202e-08f;
	                _33360 = true;
	                break;
	            }
	            case 80u:
	            {
	                uint _28525 = 16271u + (_12091 % 419u);
	                uint _28526 = _28525 / 2u;
	                uint _28536;
	                if ((_28525 & 1u) != 0u)
	                {
	                    _28536 = g_ScrambledHaltonPermutations.Load<uint>(_28526 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _28536 = g_ScrambledHaltonPermutations.Load<uint>(_28526 * 4 + 0) & 65535u;
	                }
	                uint _28540 = 16271u + ((_12091 / 419u) % 419u);
	                uint _28541 = _28540 / 2u;
	                uint _28551;
	                if ((_28540 & 1u) != 0u)
	                {
	                    _28551 = g_ScrambledHaltonPermutations.Load<uint>(_28541 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _28551 = g_ScrambledHaltonPermutations.Load<uint>(_28541 * 4 + 0) & 65535u;
	                }
	                uint _28555 = 16271u + ((_12091 / 175561u) % 419u);
	                uint _28556 = _28555 / 2u;
	                uint _28566;
	                if ((_28555 & 1u) != 0u)
	                {
	                    _28566 = g_ScrambledHaltonPermutations.Load<uint>(_28556 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _28566 = g_ScrambledHaltonPermutations.Load<uint>(_28556 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_28536 * 175561u) + (_28551 * 419u)) + _28566) * 1.3594332770594519388396292924881e-08f;
	                _33360 = true;
	                break;
	            }
	            case 81u:
	            {
	                uint _28477 = _12091 % 421u;
	                uint _28479 = (16690u + _28477) / 2u;
	                uint _28489;
	                if ((_28477 & 1u) != 0u)
	                {
	                    _28489 = g_ScrambledHaltonPermutations.Load<uint>(_28479 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _28489 = g_ScrambledHaltonPermutations.Load<uint>(_28479 * 4 + 0) & 65535u;
	                }
	                uint _28492 = (_12091 / 421u) % 421u;
	                uint _28494 = (16690u + _28492) / 2u;
	                uint _28504;
	                if ((_28492 & 1u) != 0u)
	                {
	                    _28504 = g_ScrambledHaltonPermutations.Load<uint>(_28494 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _28504 = g_ScrambledHaltonPermutations.Load<uint>(_28494 * 4 + 0) & 65535u;
	                }
	                uint _28507 = (_12091 / 177241u) % 421u;
	                uint _28509 = (16690u + _28507) / 2u;
	                uint _28519;
	                if ((_28507 & 1u) != 0u)
	                {
	                    _28519 = g_ScrambledHaltonPermutations.Load<uint>(_28509 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _28519 = g_ScrambledHaltonPermutations.Load<uint>(_28509 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_28489 * 177241u) + (_28504 * 421u)) + _28519) * 1.3401507459320782800205051898956e-08f;
	                _33360 = true;
	                break;
	            }
	            case 82u:
	            {
	                uint _28431 = 17111u + (_12091 % 431u);
	                uint _28432 = _28431 / 2u;
	                uint _28442;
	                if ((_28431 & 1u) != 0u)
	                {
	                    _28442 = g_ScrambledHaltonPermutations.Load<uint>(_28432 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _28442 = g_ScrambledHaltonPermutations.Load<uint>(_28432 * 4 + 0) & 65535u;
	                }
	                uint _28446 = 17111u + ((_12091 / 431u) % 431u);
	                uint _28447 = _28446 / 2u;
	                uint _28457;
	                if ((_28446 & 1u) != 0u)
	                {
	                    _28457 = g_ScrambledHaltonPermutations.Load<uint>(_28447 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _28457 = g_ScrambledHaltonPermutations.Load<uint>(_28447 * 4 + 0) & 65535u;
	                }
	                uint _28461 = 17111u + ((_12091 / 185761u) % 431u);
	                uint _28462 = _28461 / 2u;
	                uint _28472;
	                if ((_28461 & 1u) != 0u)
	                {
	                    _28472 = g_ScrambledHaltonPermutations.Load<uint>(_28462 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _28472 = g_ScrambledHaltonPermutations.Load<uint>(_28462 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_28442 * 185761u) + (_28457 * 431u)) + _28472) * 1.249016357007803890155628323555e-08f;
	                _33360 = true;
	                break;
	            }
	            case 83u:
	            {
	                uint _28383 = _12091 % 433u;
	                uint _28385 = (17542u + _28383) / 2u;
	                uint _28395;
	                if ((_28383 & 1u) != 0u)
	                {
	                    _28395 = g_ScrambledHaltonPermutations.Load<uint>(_28385 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _28395 = g_ScrambledHaltonPermutations.Load<uint>(_28385 * 4 + 0) & 65535u;
	                }
	                uint _28398 = (_12091 / 433u) % 433u;
	                uint _28400 = (17542u + _28398) / 2u;
	                uint _28410;
	                if ((_28398 & 1u) != 0u)
	                {
	                    _28410 = g_ScrambledHaltonPermutations.Load<uint>(_28400 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _28410 = g_ScrambledHaltonPermutations.Load<uint>(_28400 * 4 + 0) & 65535u;
	                }
	                uint _28413 = (_12091 / 187489u) % 433u;
	                uint _28415 = (17542u + _28413) / 2u;
	                uint _28425;
	                if ((_28413 & 1u) != 0u)
	                {
	                    _28425 = g_ScrambledHaltonPermutations.Load<uint>(_28415 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _28425 = g_ScrambledHaltonPermutations.Load<uint>(_28415 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_28395 * 187489u) + (_28410 * 433u)) + _28425) * 1.2317888042900904110865667462349e-08f;
	                _33360 = true;
	                break;
	            }
	            case 84u:
	            {
	                uint _28337 = 17975u + (_12091 % 439u);
	                uint _28338 = _28337 / 2u;
	                uint _28348;
	                if ((_28337 & 1u) != 0u)
	                {
	                    _28348 = g_ScrambledHaltonPermutations.Load<uint>(_28338 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _28348 = g_ScrambledHaltonPermutations.Load<uint>(_28338 * 4 + 0) & 65535u;
	                }
	                uint _28352 = 17975u + ((_12091 / 439u) % 439u);
	                uint _28353 = _28352 / 2u;
	                uint _28363;
	                if ((_28352 & 1u) != 0u)
	                {
	                    _28363 = g_ScrambledHaltonPermutations.Load<uint>(_28353 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _28363 = g_ScrambledHaltonPermutations.Load<uint>(_28353 * 4 + 0) & 65535u;
	                }
	                uint _28367 = 17975u + ((_12091 / 192721u) % 439u);
	                uint _28368 = _28367 / 2u;
	                uint _28378;
	                if ((_28367 & 1u) != 0u)
	                {
	                    _28378 = g_ScrambledHaltonPermutations.Load<uint>(_28368 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _28378 = g_ScrambledHaltonPermutations.Load<uint>(_28368 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_28348 * 192721u) + (_28363 * 439u)) + _28378) * 1.1819698109150067466543987393379e-08f;
	                _33360 = true;
	                break;
	            }
	            case 85u:
	            {
	                uint _28289 = _12091 % 443u;
	                uint _28291 = (18414u + _28289) / 2u;
	                uint _28301;
	                if ((_28289 & 1u) != 0u)
	                {
	                    _28301 = g_ScrambledHaltonPermutations.Load<uint>(_28291 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _28301 = g_ScrambledHaltonPermutations.Load<uint>(_28291 * 4 + 0) & 65535u;
	                }
	                uint _28304 = (_12091 / 443u) % 443u;
	                uint _28306 = (18414u + _28304) / 2u;
	                uint _28316;
	                if ((_28304 & 1u) != 0u)
	                {
	                    _28316 = g_ScrambledHaltonPermutations.Load<uint>(_28306 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _28316 = g_ScrambledHaltonPermutations.Load<uint>(_28306 * 4 + 0) & 65535u;
	                }
	                uint _28319 = (_12091 / 196249u) % 443u;
	                uint _28321 = (18414u + _28319) / 2u;
	                uint _28331;
	                if ((_28319 & 1u) != 0u)
	                {
	                    _28331 = g_ScrambledHaltonPermutations.Load<uint>(_28321 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _28331 = g_ScrambledHaltonPermutations.Load<uint>(_28321 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_28301 * 196249u) + (_28316 * 443u)) + _28331) * 1.1502408803210073529044166207314e-08f;
	                _33360 = true;
	                break;
	            }
	            case 86u:
	            {
	                uint _28243 = 18857u + (_12091 % 449u);
	                uint _28244 = _28243 / 2u;
	                uint _28254;
	                if ((_28243 & 1u) != 0u)
	                {
	                    _28254 = g_ScrambledHaltonPermutations.Load<uint>(_28244 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _28254 = g_ScrambledHaltonPermutations.Load<uint>(_28244 * 4 + 0) & 65535u;
	                }
	                uint _28258 = 18857u + ((_12091 / 449u) % 449u);
	                uint _28259 = _28258 / 2u;
	                uint _28269;
	                if ((_28258 & 1u) != 0u)
	                {
	                    _28269 = g_ScrambledHaltonPermutations.Load<uint>(_28259 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _28269 = g_ScrambledHaltonPermutations.Load<uint>(_28259 * 4 + 0) & 65535u;
	                }
	                uint _28273 = 18857u + ((_12091 / 201601u) % 449u);
	                uint _28274 = _28273 / 2u;
	                uint _28284;
	                if ((_28273 & 1u) != 0u)
	                {
	                    _28284 = g_ScrambledHaltonPermutations.Load<uint>(_28274 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _28284 = g_ScrambledHaltonPermutations.Load<uint>(_28274 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_28254 * 201601u) + (_28269 * 449u)) + _28284) * 1.1047421644150290376273915171623e-08f;
	                _33360 = true;
	                break;
	            }
	            case 87u:
	            {
	                uint _28195 = _12091 % 457u;
	                uint _28197 = (19306u + _28195) / 2u;
	                uint _28207;
	                if ((_28195 & 1u) != 0u)
	                {
	                    _28207 = g_ScrambledHaltonPermutations.Load<uint>(_28197 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _28207 = g_ScrambledHaltonPermutations.Load<uint>(_28197 * 4 + 0) & 65535u;
	                }
	                uint _28210 = (_12091 / 457u) % 457u;
	                uint _28212 = (19306u + _28210) / 2u;
	                uint _28222;
	                if ((_28210 & 1u) != 0u)
	                {
	                    _28222 = g_ScrambledHaltonPermutations.Load<uint>(_28212 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _28222 = g_ScrambledHaltonPermutations.Load<uint>(_28212 * 4 + 0) & 65535u;
	                }
	                uint _28225 = (_12091 / 208849u) % 457u;
	                uint _28227 = (19306u + _28225) / 2u;
	                uint _28237;
	                if ((_28225 & 1u) != 0u)
	                {
	                    _28237 = g_ScrambledHaltonPermutations.Load<uint>(_28227 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _28237 = g_ScrambledHaltonPermutations.Load<uint>(_28227 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_28207 * 208849u) + (_28222 * 457u)) + _28237) * 1.0477347878179443796398118138313e-08f;
	                _33360 = true;
	                break;
	            }
	            case 88u:
	            {
	                uint _28149 = 19763u + (_12091 % 461u);
	                uint _28150 = _28149 / 2u;
	                uint _28160;
	                if ((_28149 & 1u) != 0u)
	                {
	                    _28160 = g_ScrambledHaltonPermutations.Load<uint>(_28150 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _28160 = g_ScrambledHaltonPermutations.Load<uint>(_28150 * 4 + 0) & 65535u;
	                }
	                uint _28164 = 19763u + ((_12091 / 461u) % 461u);
	                uint _28165 = _28164 / 2u;
	                uint _28175;
	                if ((_28164 & 1u) != 0u)
	                {
	                    _28175 = g_ScrambledHaltonPermutations.Load<uint>(_28165 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _28175 = g_ScrambledHaltonPermutations.Load<uint>(_28165 * 4 + 0) & 65535u;
	                }
	                uint _28179 = 19763u + ((_12091 / 212521u) % 461u);
	                uint _28180 = _28179 / 2u;
	                uint _28190;
	                if ((_28179 & 1u) != 0u)
	                {
	                    _28190 = g_ScrambledHaltonPermutations.Load<uint>(_28180 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _28190 = g_ScrambledHaltonPermutations.Load<uint>(_28180 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_28160 * 212521u) + (_28175 * 461u)) + _28190) * 1.0206977485438528674421831965446e-08f;
	                _33360 = true;
	                break;
	            }
	            case 89u:
	            {
	                uint _28101 = _12091 % 463u;
	                uint _28103 = (20224u + _28101) / 2u;
	                uint _28113;
	                if ((_28101 & 1u) != 0u)
	                {
	                    _28113 = g_ScrambledHaltonPermutations.Load<uint>(_28103 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _28113 = g_ScrambledHaltonPermutations.Load<uint>(_28103 * 4 + 0) & 65535u;
	                }
	                uint _28116 = (_12091 / 463u) % 463u;
	                uint _28118 = (20224u + _28116) / 2u;
	                uint _28128;
	                if ((_28116 & 1u) != 0u)
	                {
	                    _28128 = g_ScrambledHaltonPermutations.Load<uint>(_28118 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _28128 = g_ScrambledHaltonPermutations.Load<uint>(_28118 * 4 + 0) & 65535u;
	                }
	                uint _28131 = (_12091 / 214369u) % 463u;
	                uint _28133 = (20224u + _28131) / 2u;
	                uint _28143;
	                if ((_28131 & 1u) != 0u)
	                {
	                    _28143 = g_ScrambledHaltonPermutations.Load<uint>(_28133 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _28143 = g_ScrambledHaltonPermutations.Load<uint>(_28133 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_28113 * 214369u) + (_28128 * 463u)) + _28143) * 1.007527661300855470472015440464e-08f;
	                _33360 = true;
	                break;
	            }
	            case 90u:
	            {
	                uint _28055 = 20687u + (_12091 % 467u);
	                uint _28056 = _28055 / 2u;
	                uint _28066;
	                if ((_28055 & 1u) != 0u)
	                {
	                    _28066 = g_ScrambledHaltonPermutations.Load<uint>(_28056 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _28066 = g_ScrambledHaltonPermutations.Load<uint>(_28056 * 4 + 0) & 65535u;
	                }
	                uint _28070 = 20687u + ((_12091 / 467u) % 467u);
	                uint _28071 = _28070 / 2u;
	                uint _28081;
	                if ((_28070 & 1u) != 0u)
	                {
	                    _28081 = g_ScrambledHaltonPermutations.Load<uint>(_28071 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _28081 = g_ScrambledHaltonPermutations.Load<uint>(_28071 * 4 + 0) & 65535u;
	                }
	                uint _28085 = 20687u + ((_12091 / 218089u) % 467u);
	                uint _28086 = _28085 / 2u;
	                uint _28096;
	                if ((_28085 & 1u) != 0u)
	                {
	                    _28096 = g_ScrambledHaltonPermutations.Load<uint>(_28086 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _28096 = g_ScrambledHaltonPermutations.Load<uint>(_28086 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_28066 * 218089u) + (_28081 * 467u)) + _28096) * 9.8185948260720579128246754407883e-09f;
	                _33360 = true;
	                break;
	            }
	            case 91u:
	            {
	                uint _28007 = _12091 % 479u;
	                uint _28009 = (21154u + _28007) / 2u;
	                uint _28019;
	                if ((_28007 & 1u) != 0u)
	                {
	                    _28019 = g_ScrambledHaltonPermutations.Load<uint>(_28009 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _28019 = g_ScrambledHaltonPermutations.Load<uint>(_28009 * 4 + 0) & 65535u;
	                }
	                uint _28022 = (_12091 / 479u) % 479u;
	                uint _28024 = (21154u + _28022) / 2u;
	                uint _28034;
	                if ((_28022 & 1u) != 0u)
	                {
	                    _28034 = g_ScrambledHaltonPermutations.Load<uint>(_28024 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _28034 = g_ScrambledHaltonPermutations.Load<uint>(_28024 * 4 + 0) & 65535u;
	                }
	                uint _28037 = (_12091 / 229441u) % 479u;
	                uint _28039 = (21154u + _28037) / 2u;
	                uint _28049;
	                if ((_28037 & 1u) != 0u)
	                {
	                    _28049 = g_ScrambledHaltonPermutations.Load<uint>(_28039 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _28049 = g_ScrambledHaltonPermutations.Load<uint>(_28039 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_28019 * 229441u) + (_28034 * 479u)) + _28049) * 9.0989944467878558498341590166092e-09f;
	                _33360 = true;
	                break;
	            }
	            case 92u:
	            {
	                uint _27961 = 21633u + (_12091 % 487u);
	                uint _27962 = _27961 / 2u;
	                uint _27972;
	                if ((_27961 & 1u) != 0u)
	                {
	                    _27972 = g_ScrambledHaltonPermutations.Load<uint>(_27962 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _27972 = g_ScrambledHaltonPermutations.Load<uint>(_27962 * 4 + 0) & 65535u;
	                }
	                uint _27976 = 21633u + ((_12091 / 487u) % 487u);
	                uint _27977 = _27976 / 2u;
	                uint _27987;
	                if ((_27976 & 1u) != 0u)
	                {
	                    _27987 = g_ScrambledHaltonPermutations.Load<uint>(_27977 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _27987 = g_ScrambledHaltonPermutations.Load<uint>(_27977 * 4 + 0) & 65535u;
	                }
	                uint _27991 = 21633u + ((_12091 / 237169u) % 487u);
	                uint _27992 = _27991 / 2u;
	                uint _28002;
	                if ((_27991 & 1u) != 0u)
	                {
	                    _28002 = g_ScrambledHaltonPermutations.Load<uint>(_27992 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _28002 = g_ScrambledHaltonPermutations.Load<uint>(_27992 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_27972 * 237169u) + (_27987 * 487u)) + _28002) * 8.6579099445316387573257088661194e-09f;
	                _33360 = true;
	                break;
	            }
	            case 93u:
	            {
	                uint _27913 = _12091 % 491u;
	                uint _27915 = (22120u + _27913) / 2u;
	                uint _27925;
	                if ((_27913 & 1u) != 0u)
	                {
	                    _27925 = g_ScrambledHaltonPermutations.Load<uint>(_27915 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _27925 = g_ScrambledHaltonPermutations.Load<uint>(_27915 * 4 + 0) & 65535u;
	                }
	                uint _27928 = (_12091 / 491u) % 491u;
	                uint _27930 = (22120u + _27928) / 2u;
	                uint _27940;
	                if ((_27928 & 1u) != 0u)
	                {
	                    _27940 = g_ScrambledHaltonPermutations.Load<uint>(_27930 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _27940 = g_ScrambledHaltonPermutations.Load<uint>(_27930 * 4 + 0) & 65535u;
	                }
	                uint _27943 = (_12091 / 241081u) % 491u;
	                uint _27945 = (22120u + _27943) / 2u;
	                uint _27955;
	                if ((_27943 & 1u) != 0u)
	                {
	                    _27955 = g_ScrambledHaltonPermutations.Load<uint>(_27945 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _27955 = g_ScrambledHaltonPermutations.Load<uint>(_27945 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_27925 * 241081u) + (_27940 * 491u)) + _27955) * 8.4480307194212400645483285188675e-09f;
	                _33360 = true;
	                break;
	            }
	            case 94u:
	            {
	                uint _27867 = 22611u + (_12091 % 499u);
	                uint _27868 = _27867 / 2u;
	                uint _27878;
	                if ((_27867 & 1u) != 0u)
	                {
	                    _27878 = g_ScrambledHaltonPermutations.Load<uint>(_27868 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _27878 = g_ScrambledHaltonPermutations.Load<uint>(_27868 * 4 + 0) & 65535u;
	                }
	                uint _27882 = 22611u + ((_12091 / 499u) % 499u);
	                uint _27883 = _27882 / 2u;
	                uint _27893;
	                if ((_27882 & 1u) != 0u)
	                {
	                    _27893 = g_ScrambledHaltonPermutations.Load<uint>(_27883 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _27893 = g_ScrambledHaltonPermutations.Load<uint>(_27883 * 4 + 0) & 65535u;
	                }
	                uint _27897 = 22611u + ((_12091 / 249001u) % 499u);
	                uint _27898 = _27897 / 2u;
	                uint _27908;
	                if ((_27897 & 1u) != 0u)
	                {
	                    _27908 = g_ScrambledHaltonPermutations.Load<uint>(_27898 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _27908 = g_ScrambledHaltonPermutations.Load<uint>(_27898 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_27878 * 249001u) + (_27893 * 499u)) + _27908) * 8.0481914466190573875792324542999e-09f;
	                _33360 = true;
	                break;
	            }
	            case 95u:
	            {
	                uint _27819 = _12091 % 503u;
	                uint _27821 = (23110u + _27819) / 2u;
	                uint _27831;
	                if ((_27819 & 1u) != 0u)
	                {
	                    _27831 = g_ScrambledHaltonPermutations.Load<uint>(_27821 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _27831 = g_ScrambledHaltonPermutations.Load<uint>(_27821 * 4 + 0) & 65535u;
	                }
	                uint _27834 = (_12091 / 503u) % 503u;
	                uint _27836 = (23110u + _27834) / 2u;
	                uint _27846;
	                if ((_27834 & 1u) != 0u)
	                {
	                    _27846 = g_ScrambledHaltonPermutations.Load<uint>(_27836 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _27846 = g_ScrambledHaltonPermutations.Load<uint>(_27836 * 4 + 0) & 65535u;
	                }
	                uint _27849 = (_12091 / 253009u) % 503u;
	                uint _27851 = (23110u + _27849) / 2u;
	                uint _27861;
	                if ((_27849 & 1u) != 0u)
	                {
	                    _27861 = g_ScrambledHaltonPermutations.Load<uint>(_27851 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _27861 = g_ScrambledHaltonPermutations.Load<uint>(_27851 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_27831 * 253009u) + (_27846 * 503u)) + _27861) * 7.8577100381949094298761337995529e-09f;
	                _33360 = true;
	                break;
	            }
	            case 96u:
	            {
	                uint _27773 = 23613u + (_12091 % 509u);
	                uint _27774 = _27773 / 2u;
	                uint _27784;
	                if ((_27773 & 1u) != 0u)
	                {
	                    _27784 = g_ScrambledHaltonPermutations.Load<uint>(_27774 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _27784 = g_ScrambledHaltonPermutations.Load<uint>(_27774 * 4 + 0) & 65535u;
	                }
	                uint _27788 = 23613u + ((_12091 / 509u) % 509u);
	                uint _27789 = _27788 / 2u;
	                uint _27799;
	                if ((_27788 & 1u) != 0u)
	                {
	                    _27799 = g_ScrambledHaltonPermutations.Load<uint>(_27789 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _27799 = g_ScrambledHaltonPermutations.Load<uint>(_27789 * 4 + 0) & 65535u;
	                }
	                uint _27803 = 23613u + ((_12091 / 259081u) % 509u);
	                uint _27804 = _27803 / 2u;
	                uint _27814;
	                if ((_27803 & 1u) != 0u)
	                {
	                    _27814 = g_ScrambledHaltonPermutations.Load<uint>(_27804 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _27814 = g_ScrambledHaltonPermutations.Load<uint>(_27804 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_27784 * 259081u) + (_27799 * 509u)) + _27814) * 7.5830968171430868096649646759033e-09f;
	                _33360 = true;
	                break;
	            }
	            case 97u:
	            {
	                uint _27725 = _12091 % 521u;
	                uint _27727 = (24122u + _27725) / 2u;
	                uint _27737;
	                if ((_27725 & 1u) != 0u)
	                {
	                    _27737 = g_ScrambledHaltonPermutations.Load<uint>(_27727 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _27737 = g_ScrambledHaltonPermutations.Load<uint>(_27727 * 4 + 0) & 65535u;
	                }
	                uint _27740 = (_12091 / 521u) % 521u;
	                uint _27742 = (24122u + _27740) / 2u;
	                uint _27752;
	                if ((_27740 & 1u) != 0u)
	                {
	                    _27752 = g_ScrambledHaltonPermutations.Load<uint>(_27742 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _27752 = g_ScrambledHaltonPermutations.Load<uint>(_27742 * 4 + 0) & 65535u;
	                }
	                uint _27755 = (_12091 / 271441u) % 521u;
	                uint _27757 = (24122u + _27755) / 2u;
	                uint _27767;
	                if ((_27755 & 1u) != 0u)
	                {
	                    _27767 = g_ScrambledHaltonPermutations.Load<uint>(_27757 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _27767 = g_ScrambledHaltonPermutations.Load<uint>(_27757 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_27737 * 271441u) + (_27752 * 521u)) + _27767) * 7.0710965971443329181056469678879e-09f;
	                _33360 = true;
	                break;
	            }
	            case 98u:
	            {
	                uint _27679 = 24643u + (_12091 % 523u);
	                uint _27680 = _27679 / 2u;
	                uint _27690;
	                if ((_27679 & 1u) != 0u)
	                {
	                    _27690 = g_ScrambledHaltonPermutations.Load<uint>(_27680 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _27690 = g_ScrambledHaltonPermutations.Load<uint>(_27680 * 4 + 0) & 65535u;
	                }
	                uint _27694 = 24643u + ((_12091 / 523u) % 523u);
	                uint _27695 = _27694 / 2u;
	                uint _27705;
	                if ((_27694 & 1u) != 0u)
	                {
	                    _27705 = g_ScrambledHaltonPermutations.Load<uint>(_27695 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _27705 = g_ScrambledHaltonPermutations.Load<uint>(_27695 * 4 + 0) & 65535u;
	                }
	                uint _27709 = 24643u + ((_12091 / 273529u) % 523u);
	                uint _27710 = _27709 / 2u;
	                uint _27720;
	                if ((_27709 & 1u) != 0u)
	                {
	                    _27720 = g_ScrambledHaltonPermutations.Load<uint>(_27710 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _27720 = g_ScrambledHaltonPermutations.Load<uint>(_27710 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_27690 * 273529u) + (_27705 * 523u)) + _27720) * 6.9902852395387071737786754965782e-09f;
	                _33360 = true;
	                break;
	            }
	            case 99u:
	            {
	                uint _27631 = _12091 % 541u;
	                uint _27633 = (25166u + _27631) / 2u;
	                uint _27643;
	                if ((_27631 & 1u) != 0u)
	                {
	                    _27643 = g_ScrambledHaltonPermutations.Load<uint>(_27633 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _27643 = g_ScrambledHaltonPermutations.Load<uint>(_27633 * 4 + 0) & 65535u;
	                }
	                uint _27646 = (_12091 / 541u) % 541u;
	                uint _27648 = (25166u + _27646) / 2u;
	                uint _27658;
	                if ((_27646 & 1u) != 0u)
	                {
	                    _27658 = g_ScrambledHaltonPermutations.Load<uint>(_27648 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _27658 = g_ScrambledHaltonPermutations.Load<uint>(_27648 * 4 + 0) & 65535u;
	                }
	                uint _27661 = (_12091 / 292681u) % 541u;
	                uint _27663 = (25166u + _27661) / 2u;
	                uint _27673;
	                if ((_27661 & 1u) != 0u)
	                {
	                    _27673 = g_ScrambledHaltonPermutations.Load<uint>(_27663 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _27673 = g_ScrambledHaltonPermutations.Load<uint>(_27663 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_27643 * 292681u) + (_27658 * 541u)) + _27673) * 6.3155063401154620805755257606506e-09f;
	                _33360 = true;
	                break;
	            }
	            case 100u:
	            {
	                uint _27585 = 25707u + (_12091 % 547u);
	                uint _27586 = _27585 / 2u;
	                uint _27596;
	                if ((_27585 & 1u) != 0u)
	                {
	                    _27596 = g_ScrambledHaltonPermutations.Load<uint>(_27586 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _27596 = g_ScrambledHaltonPermutations.Load<uint>(_27586 * 4 + 0) & 65535u;
	                }
	                uint _27600 = 25707u + ((_12091 / 547u) % 547u);
	                uint _27601 = _27600 / 2u;
	                uint _27611;
	                if ((_27600 & 1u) != 0u)
	                {
	                    _27611 = g_ScrambledHaltonPermutations.Load<uint>(_27601 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _27611 = g_ScrambledHaltonPermutations.Load<uint>(_27601 * 4 + 0) & 65535u;
	                }
	                uint _27615 = 25707u + ((_12091 / 299209u) % 547u);
	                uint _27616 = _27615 / 2u;
	                uint _27626;
	                if ((_27615 & 1u) != 0u)
	                {
	                    _27626 = g_ScrambledHaltonPermutations.Load<uint>(_27616 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _27626 = g_ScrambledHaltonPermutations.Load<uint>(_27616 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_27596 * 299209u) + (_27611 * 547u)) + _27626) * 6.1099543202658423979301005601883e-09f;
	                _33360 = true;
	                break;
	            }
	            case 101u:
	            {
	                uint _27537 = _12091 % 557u;
	                uint _27539 = (26254u + _27537) / 2u;
	                uint _27549;
	                if ((_27537 & 1u) != 0u)
	                {
	                    _27549 = g_ScrambledHaltonPermutations.Load<uint>(_27539 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _27549 = g_ScrambledHaltonPermutations.Load<uint>(_27539 * 4 + 0) & 65535u;
	                }
	                uint _27552 = (_12091 / 557u) % 557u;
	                uint _27554 = (26254u + _27552) / 2u;
	                uint _27564;
	                if ((_27552 & 1u) != 0u)
	                {
	                    _27564 = g_ScrambledHaltonPermutations.Load<uint>(_27554 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _27564 = g_ScrambledHaltonPermutations.Load<uint>(_27554 * 4 + 0) & 65535u;
	                }
	                uint _27567 = (_12091 / 310249u) % 557u;
	                uint _27569 = (26254u + _27567) / 2u;
	                uint _27579;
	                if ((_27567 & 1u) != 0u)
	                {
	                    _27579 = g_ScrambledHaltonPermutations.Load<uint>(_27569 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _27579 = g_ScrambledHaltonPermutations.Load<uint>(_27569 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_27549 * 310249u) + (_27564 * 557u)) + _27579) * 5.7867453051585471257567405700684e-09f;
	                _33360 = true;
	                break;
	            }
	            case 102u:
	            {
	                uint _27491 = 26811u + (_12091 % 563u);
	                uint _27492 = _27491 / 2u;
	                uint _27502;
	                if ((_27491 & 1u) != 0u)
	                {
	                    _27502 = g_ScrambledHaltonPermutations.Load<uint>(_27492 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _27502 = g_ScrambledHaltonPermutations.Load<uint>(_27492 * 4 + 0) & 65535u;
	                }
	                uint _27506 = 26811u + ((_12091 / 563u) % 563u);
	                uint _27507 = _27506 / 2u;
	                uint _27517;
	                if ((_27506 & 1u) != 0u)
	                {
	                    _27517 = g_ScrambledHaltonPermutations.Load<uint>(_27507 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _27517 = g_ScrambledHaltonPermutations.Load<uint>(_27507 * 4 + 0) & 65535u;
	                }
	                uint _27521 = 26811u + ((_12091 / 316969u) % 563u);
	                uint _27522 = _27521 / 2u;
	                uint _27532;
	                if ((_27521 & 1u) != 0u)
	                {
	                    _27532 = g_ScrambledHaltonPermutations.Load<uint>(_27522 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _27532 = g_ScrambledHaltonPermutations.Load<uint>(_27522 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_27502 * 316969u) + (_27517 * 563u)) + _27532) * 5.6036983941964990663109347224236e-09f;
	                _33360 = true;
	                break;
	            }
	            case 103u:
	            {
	                uint _27443 = _12091 % 569u;
	                uint _27445 = (27374u + _27443) / 2u;
	                uint _27455;
	                if ((_27443 & 1u) != 0u)
	                {
	                    _27455 = g_ScrambledHaltonPermutations.Load<uint>(_27445 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _27455 = g_ScrambledHaltonPermutations.Load<uint>(_27445 * 4 + 0) & 65535u;
	                }
	                uint _27458 = (_12091 / 569u) % 569u;
	                uint _27460 = (27374u + _27458) / 2u;
	                uint _27470;
	                if ((_27458 & 1u) != 0u)
	                {
	                    _27470 = g_ScrambledHaltonPermutations.Load<uint>(_27460 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _27470 = g_ScrambledHaltonPermutations.Load<uint>(_27460 * 4 + 0) & 65535u;
	                }
	                uint _27473 = (_12091 / 323761u) % 569u;
	                uint _27475 = (27374u + _27473) / 2u;
	                uint _27485;
	                if ((_27473 & 1u) != 0u)
	                {
	                    _27485 = g_ScrambledHaltonPermutations.Load<uint>(_27475 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _27485 = g_ScrambledHaltonPermutations.Load<uint>(_27475 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_27455 * 323761u) + (_27470 * 569u)) + _27485) * 5.4282911499115016340510919690132e-09f;
	                _33360 = true;
	                break;
	            }
	            case 104u:
	            {
	                uint _27397 = 27943u + (_12091 % 571u);
	                uint _27398 = _27397 / 2u;
	                uint _27408;
	                if ((_27397 & 1u) != 0u)
	                {
	                    _27408 = g_ScrambledHaltonPermutations.Load<uint>(_27398 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _27408 = g_ScrambledHaltonPermutations.Load<uint>(_27398 * 4 + 0) & 65535u;
	                }
	                uint _27412 = 27943u + ((_12091 / 571u) % 571u);
	                uint _27413 = _27412 / 2u;
	                uint _27423;
	                if ((_27412 & 1u) != 0u)
	                {
	                    _27423 = g_ScrambledHaltonPermutations.Load<uint>(_27413 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _27423 = g_ScrambledHaltonPermutations.Load<uint>(_27413 * 4 + 0) & 65535u;
	                }
	                uint _27427 = 27943u + ((_12091 / 326041u) % 571u);
	                uint _27428 = _27427 / 2u;
	                uint _27438;
	                if ((_27427 & 1u) != 0u)
	                {
	                    _27438 = g_ScrambledHaltonPermutations.Load<uint>(_27428 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _27438 = g_ScrambledHaltonPermutations.Load<uint>(_27428 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_27408 * 326041u) + (_27423 * 571u)) + _27438) * 5.3714512837643724196823313832283e-09f;
	                _33360 = true;
	                break;
	            }
	            case 105u:
	            {
	                uint _27349 = _12091 % 577u;
	                uint _27351 = (28514u + _27349) / 2u;
	                uint _27361;
	                if ((_27349 & 1u) != 0u)
	                {
	                    _27361 = g_ScrambledHaltonPermutations.Load<uint>(_27351 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _27361 = g_ScrambledHaltonPermutations.Load<uint>(_27351 * 4 + 0) & 65535u;
	                }
	                uint _27364 = (_12091 / 577u) % 577u;
	                uint _27366 = (28514u + _27364) / 2u;
	                uint _27376;
	                if ((_27364 & 1u) != 0u)
	                {
	                    _27376 = g_ScrambledHaltonPermutations.Load<uint>(_27366 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _27376 = g_ScrambledHaltonPermutations.Load<uint>(_27366 * 4 + 0) & 65535u;
	                }
	                uint _27379 = (_12091 / 332929u) % 577u;
	                uint _27381 = (28514u + _27379) / 2u;
	                uint _27391;
	                if ((_27379 & 1u) != 0u)
	                {
	                    _27391 = g_ScrambledHaltonPermutations.Load<uint>(_27381 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _27391 = g_ScrambledHaltonPermutations.Load<uint>(_27381 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_27361 * 332929u) + (_27376 * 577u)) + _27391) * 5.2056203792005817376775667071342e-09f;
	                _33360 = true;
	                break;
	            }
	            case 106u:
	            {
	                uint _27303 = 29091u + (_12091 % 587u);
	                uint _27304 = _27303 / 2u;
	                uint _27314;
	                if ((_27303 & 1u) != 0u)
	                {
	                    _27314 = g_ScrambledHaltonPermutations.Load<uint>(_27304 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _27314 = g_ScrambledHaltonPermutations.Load<uint>(_27304 * 4 + 0) & 65535u;
	                }
	                uint _27318 = 29091u + ((_12091 / 587u) % 587u);
	                uint _27319 = _27318 / 2u;
	                uint _27329;
	                if ((_27318 & 1u) != 0u)
	                {
	                    _27329 = g_ScrambledHaltonPermutations.Load<uint>(_27319 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _27329 = g_ScrambledHaltonPermutations.Load<uint>(_27319 * 4 + 0) & 65535u;
	                }
	                uint _27333 = 29091u + ((_12091 / 344569u) % 587u);
	                uint _27334 = _27333 / 2u;
	                uint _27344;
	                if ((_27333 & 1u) != 0u)
	                {
	                    _27344 = g_ScrambledHaltonPermutations.Load<uint>(_27334 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _27344 = g_ScrambledHaltonPermutations.Load<uint>(_27334 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_27314 * 344569u) + (_27329 * 587u)) + _27344) * 4.9440820326651646610116586089134e-09f;
	                _33360 = true;
	                break;
	            }
	            case 107u:
	            {
	                uint _27255 = _12091 % 593u;
	                uint _27257 = (29678u + _27255) / 2u;
	                uint _27267;
	                if ((_27255 & 1u) != 0u)
	                {
	                    _27267 = g_ScrambledHaltonPermutations.Load<uint>(_27257 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _27267 = g_ScrambledHaltonPermutations.Load<uint>(_27257 * 4 + 0) & 65535u;
	                }
	                uint _27270 = (_12091 / 593u) % 593u;
	                uint _27272 = (29678u + _27270) / 2u;
	                uint _27282;
	                if ((_27270 & 1u) != 0u)
	                {
	                    _27282 = g_ScrambledHaltonPermutations.Load<uint>(_27272 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _27282 = g_ScrambledHaltonPermutations.Load<uint>(_27272 * 4 + 0) & 65535u;
	                }
	                uint _27285 = (_12091 / 351649u) % 593u;
	                uint _27287 = (29678u + _27285) / 2u;
	                uint _27297;
	                if ((_27285 & 1u) != 0u)
	                {
	                    _27297 = g_ScrambledHaltonPermutations.Load<uint>(_27287 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _27297 = g_ScrambledHaltonPermutations.Load<uint>(_27287 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_27267 * 351649u) + (_27282 * 593u)) + _27297) * 4.7955217574724429141497239470482e-09f;
	                _33360 = true;
	                break;
	            }
	            case 108u:
	            {
	                uint _27209 = 30271u + (_12091 % 599u);
	                uint _27210 = _27209 / 2u;
	                uint _27220;
	                if ((_27209 & 1u) != 0u)
	                {
	                    _27220 = g_ScrambledHaltonPermutations.Load<uint>(_27210 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _27220 = g_ScrambledHaltonPermutations.Load<uint>(_27210 * 4 + 0) & 65535u;
	                }
	                uint _27224 = 30271u + ((_12091 / 599u) % 599u);
	                uint _27225 = _27224 / 2u;
	                uint _27235;
	                if ((_27224 & 1u) != 0u)
	                {
	                    _27235 = g_ScrambledHaltonPermutations.Load<uint>(_27225 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _27235 = g_ScrambledHaltonPermutations.Load<uint>(_27225 * 4 + 0) & 65535u;
	                }
	                uint _27239 = 30271u + ((_12091 / 358801u) % 599u);
	                uint _27240 = _27239 / 2u;
	                uint _27250;
	                if ((_27239 & 1u) != 0u)
	                {
	                    _27250 = g_ScrambledHaltonPermutations.Load<uint>(_27240 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _27250 = g_ScrambledHaltonPermutations.Load<uint>(_27240 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_27220 * 358801u) + (_27235 * 599u)) + _27250) * 4.6528545460944314982043579220772e-09f;
	                _33360 = true;
	                break;
	            }
	            case 109u:
	            {
	                uint _27161 = _12091 % 601u;
	                uint _27163 = (30870u + _27161) / 2u;
	                uint _27173;
	                if ((_27161 & 1u) != 0u)
	                {
	                    _27173 = g_ScrambledHaltonPermutations.Load<uint>(_27163 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _27173 = g_ScrambledHaltonPermutations.Load<uint>(_27163 * 4 + 0) & 65535u;
	                }
	                uint _27176 = (_12091 / 601u) % 601u;
	                uint _27178 = (30870u + _27176) / 2u;
	                uint _27188;
	                if ((_27176 & 1u) != 0u)
	                {
	                    _27188 = g_ScrambledHaltonPermutations.Load<uint>(_27178 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _27188 = g_ScrambledHaltonPermutations.Load<uint>(_27178 * 4 + 0) & 65535u;
	                }
	                uint _27191 = (_12091 / 361201u) % 601u;
	                uint _27193 = (30870u + _27191) / 2u;
	                uint _27203;
	                if ((_27191 & 1u) != 0u)
	                {
	                    _27203 = g_ScrambledHaltonPermutations.Load<uint>(_27193 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _27203 = g_ScrambledHaltonPermutations.Load<uint>(_27193 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_27173 * 361201u) + (_27188 * 601u)) + _27203) * 4.6065578018783526204060763120651e-09f;
	                _33360 = true;
	                break;
	            }
	            case 110u:
	            {
	                uint _27115 = 31471u + (_12091 % 607u);
	                uint _27116 = _27115 / 2u;
	                uint _27126;
	                if ((_27115 & 1u) != 0u)
	                {
	                    _27126 = g_ScrambledHaltonPermutations.Load<uint>(_27116 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _27126 = g_ScrambledHaltonPermutations.Load<uint>(_27116 * 4 + 0) & 65535u;
	                }
	                uint _27130 = 31471u + ((_12091 / 607u) % 607u);
	                uint _27131 = _27130 / 2u;
	                uint _27141;
	                if ((_27130 & 1u) != 0u)
	                {
	                    _27141 = g_ScrambledHaltonPermutations.Load<uint>(_27131 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _27141 = g_ScrambledHaltonPermutations.Load<uint>(_27131 * 4 + 0) & 65535u;
	                }
	                uint _27145 = 31471u + ((_12091 / 368449u) % 607u);
	                uint _27146 = _27145 / 2u;
	                uint _27156;
	                if ((_27145 & 1u) != 0u)
	                {
	                    _27156 = g_ScrambledHaltonPermutations.Load<uint>(_27146 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _27156 = g_ScrambledHaltonPermutations.Load<uint>(_27146 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_27126 * 368449u) + (_27141 * 607u)) + _27156) * 4.4713006630558993492741137742996e-09f;
	                _33360 = true;
	                break;
	            }
	            case 111u:
	            {
	                uint _27067 = _12091 % 613u;
	                uint _27069 = (32078u + _27067) / 2u;
	                uint _27079;
	                if ((_27067 & 1u) != 0u)
	                {
	                    _27079 = g_ScrambledHaltonPermutations.Load<uint>(_27069 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _27079 = g_ScrambledHaltonPermutations.Load<uint>(_27069 * 4 + 0) & 65535u;
	                }
	                uint _27082 = (_12091 / 613u) % 613u;
	                uint _27084 = (32078u + _27082) / 2u;
	                uint _27094;
	                if ((_27082 & 1u) != 0u)
	                {
	                    _27094 = g_ScrambledHaltonPermutations.Load<uint>(_27084 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _27094 = g_ScrambledHaltonPermutations.Load<uint>(_27084 * 4 + 0) & 65535u;
	                }
	                uint _27097 = (_12091 / 375769u) % 613u;
	                uint _27099 = (32078u + _27097) / 2u;
	                uint _27109;
	                if ((_27097 & 1u) != 0u)
	                {
	                    _27109 = g_ScrambledHaltonPermutations.Load<uint>(_27099 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _27109 = g_ScrambledHaltonPermutations.Load<uint>(_27099 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_27079 * 375769u) + (_27094 * 613u)) + _27109) * 4.3412873296233556175138801336288e-09f;
	                _33360 = true;
	                break;
	            }
	            case 112u:
	            {
	                uint _27021 = 32691u + (_12091 % 617u);
	                uint _27022 = _27021 / 2u;
	                uint _27032;
	                if ((_27021 & 1u) != 0u)
	                {
	                    _27032 = g_ScrambledHaltonPermutations.Load<uint>(_27022 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _27032 = g_ScrambledHaltonPermutations.Load<uint>(_27022 * 4 + 0) & 65535u;
	                }
	                uint _27036 = 32691u + ((_12091 / 617u) % 617u);
	                uint _27037 = _27036 / 2u;
	                uint _27047;
	                if ((_27036 & 1u) != 0u)
	                {
	                    _27047 = g_ScrambledHaltonPermutations.Load<uint>(_27037 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _27047 = g_ScrambledHaltonPermutations.Load<uint>(_27037 * 4 + 0) & 65535u;
	                }
	                uint _27051 = 32691u + ((_12091 / 380689u) % 617u);
	                uint _27052 = _27051 / 2u;
	                uint _27062;
	                if ((_27051 & 1u) != 0u)
	                {
	                    _27062 = g_ScrambledHaltonPermutations.Load<uint>(_27052 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _27062 = g_ScrambledHaltonPermutations.Load<uint>(_27052 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_27032 * 380689u) + (_27047 * 617u)) + _27062) * 4.2573997660610984894447028636932e-09f;
	                _33360 = true;
	                break;
	            }
	            case 113u:
	            {
	                uint _26973 = _12091 % 619u;
	                uint _26975 = (33308u + _26973) / 2u;
	                uint _26985;
	                if ((_26973 & 1u) != 0u)
	                {
	                    _26985 = g_ScrambledHaltonPermutations.Load<uint>(_26975 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _26985 = g_ScrambledHaltonPermutations.Load<uint>(_26975 * 4 + 0) & 65535u;
	                }
	                uint _26988 = (_12091 / 619u) % 619u;
	                uint _26990 = (33308u + _26988) / 2u;
	                uint _27000;
	                if ((_26988 & 1u) != 0u)
	                {
	                    _27000 = g_ScrambledHaltonPermutations.Load<uint>(_26990 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _27000 = g_ScrambledHaltonPermutations.Load<uint>(_26990 * 4 + 0) & 65535u;
	                }
	                uint _27003 = (_12091 / 383161u) % 619u;
	                uint _27005 = (33308u + _27003) / 2u;
	                uint _27015;
	                if ((_27003 & 1u) != 0u)
	                {
	                    _27015 = g_ScrambledHaltonPermutations.Load<uint>(_27005 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _27015 = g_ScrambledHaltonPermutations.Load<uint>(_27005 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_26985 * 383161u) + (_27000 * 619u)) + _27015) * 4.2162660029987364396220073103905e-09f;
	                _33360 = true;
	                break;
	            }
	            case 114u:
	            {
	                uint _26927 = 33927u + (_12091 % 631u);
	                uint _26928 = _26927 / 2u;
	                uint _26938;
	                if ((_26927 & 1u) != 0u)
	                {
	                    _26938 = g_ScrambledHaltonPermutations.Load<uint>(_26928 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _26938 = g_ScrambledHaltonPermutations.Load<uint>(_26928 * 4 + 0) & 65535u;
	                }
	                uint _26942 = 33927u + ((_12091 / 631u) % 631u);
	                uint _26943 = _26942 / 2u;
	                uint _26953;
	                if ((_26942 & 1u) != 0u)
	                {
	                    _26953 = g_ScrambledHaltonPermutations.Load<uint>(_26943 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _26953 = g_ScrambledHaltonPermutations.Load<uint>(_26943 * 4 + 0) & 65535u;
	                }
	                uint _26957 = 33927u + ((_12091 / 398161u) % 631u);
	                uint _26958 = _26957 / 2u;
	                uint _26968;
	                if ((_26957 & 1u) != 0u)
	                {
	                    _26968 = g_ScrambledHaltonPermutations.Load<uint>(_26958 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _26968 = g_ScrambledHaltonPermutations.Load<uint>(_26958 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_26938 * 398161u) + (_26953 * 631u)) + _26968) * 3.9802641182973275135736912488937e-09f;
	                _33360 = true;
	                break;
	            }
	            case 115u:
	            {
	                uint _26879 = _12091 % 641u;
	                uint _26881 = (34558u + _26879) / 2u;
	                uint _26891;
	                if ((_26879 & 1u) != 0u)
	                {
	                    _26891 = g_ScrambledHaltonPermutations.Load<uint>(_26881 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _26891 = g_ScrambledHaltonPermutations.Load<uint>(_26881 * 4 + 0) & 65535u;
	                }
	                uint _26894 = (_12091 / 641u) % 641u;
	                uint _26896 = (34558u + _26894) / 2u;
	                uint _26906;
	                if ((_26894 & 1u) != 0u)
	                {
	                    _26906 = g_ScrambledHaltonPermutations.Load<uint>(_26896 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _26906 = g_ScrambledHaltonPermutations.Load<uint>(_26896 * 4 + 0) & 65535u;
	                }
	                uint _26909 = (_12091 / 410881u) % 641u;
	                uint _26911 = (34558u + _26909) / 2u;
	                uint _26921;
	                if ((_26909 & 1u) != 0u)
	                {
	                    _26921 = g_ScrambledHaltonPermutations.Load<uint>(_26911 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _26921 = g_ScrambledHaltonPermutations.Load<uint>(_26911 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_26891 * 410881u) + (_26906 * 641u)) + _26921) * 3.7968712618408062553498893976212e-09f;
	                _33360 = true;
	                break;
	            }
	            case 116u:
	            {
	                uint _26833 = 35199u + (_12091 % 643u);
	                uint _26834 = _26833 / 2u;
	                uint _26844;
	                if ((_26833 & 1u) != 0u)
	                {
	                    _26844 = g_ScrambledHaltonPermutations.Load<uint>(_26834 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _26844 = g_ScrambledHaltonPermutations.Load<uint>(_26834 * 4 + 0) & 65535u;
	                }
	                uint _26848 = 35199u + ((_12091 / 643u) % 643u);
	                uint _26849 = _26848 / 2u;
	                uint _26859;
	                if ((_26848 & 1u) != 0u)
	                {
	                    _26859 = g_ScrambledHaltonPermutations.Load<uint>(_26849 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _26859 = g_ScrambledHaltonPermutations.Load<uint>(_26849 * 4 + 0) & 65535u;
	                }
	                uint _26863 = 35199u + ((_12091 / 413449u) % 643u);
	                uint _26864 = _26863 / 2u;
	                uint _26874;
	                if ((_26863 & 1u) != 0u)
	                {
	                    _26874 = g_ScrambledHaltonPermutations.Load<uint>(_26864 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _26874 = g_ScrambledHaltonPermutations.Load<uint>(_26864 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_26844 * 413449u) + (_26859 * 643u)) + _26874) * 3.7615515147138012252980843186378e-09f;
	                _33360 = true;
	                break;
	            }
	            case 117u:
	            {
	                uint _26785 = _12091 % 647u;
	                uint _26787 = (35842u + _26785) / 2u;
	                uint _26797;
	                if ((_26785 & 1u) != 0u)
	                {
	                    _26797 = g_ScrambledHaltonPermutations.Load<uint>(_26787 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _26797 = g_ScrambledHaltonPermutations.Load<uint>(_26787 * 4 + 0) & 65535u;
	                }
	                uint _26800 = (_12091 / 647u) % 647u;
	                uint _26802 = (35842u + _26800) / 2u;
	                uint _26812;
	                if ((_26800 & 1u) != 0u)
	                {
	                    _26812 = g_ScrambledHaltonPermutations.Load<uint>(_26802 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _26812 = g_ScrambledHaltonPermutations.Load<uint>(_26802 * 4 + 0) & 65535u;
	                }
	                uint _26815 = (_12091 / 418609u) % 647u;
	                uint _26817 = (35842u + _26815) / 2u;
	                uint _26827;
	                if ((_26815 & 1u) != 0u)
	                {
	                    _26827 = g_ScrambledHaltonPermutations.Load<uint>(_26817 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _26827 = g_ScrambledHaltonPermutations.Load<uint>(_26817 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_26797 * 418609u) + (_26812 * 647u)) + _26827) * 3.6922158663799109490355476737022e-09f;
	                _33360 = true;
	                break;
	            }
	            case 118u:
	            {
	                uint _26739 = 36489u + (_12091 % 653u);
	                uint _26740 = _26739 / 2u;
	                uint _26750;
	                if ((_26739 & 1u) != 0u)
	                {
	                    _26750 = g_ScrambledHaltonPermutations.Load<uint>(_26740 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _26750 = g_ScrambledHaltonPermutations.Load<uint>(_26740 * 4 + 0) & 65535u;
	                }
	                uint _26754 = 36489u + ((_12091 / 653u) % 653u);
	                uint _26755 = _26754 / 2u;
	                uint _26765;
	                if ((_26754 & 1u) != 0u)
	                {
	                    _26765 = g_ScrambledHaltonPermutations.Load<uint>(_26755 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _26765 = g_ScrambledHaltonPermutations.Load<uint>(_26755 * 4 + 0) & 65535u;
	                }
	                uint _26769 = 36489u + ((_12091 / 426409u) % 653u);
	                uint _26770 = _26769 / 2u;
	                uint _26780;
	                if ((_26769 & 1u) != 0u)
	                {
	                    _26780 = g_ScrambledHaltonPermutations.Load<uint>(_26770 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _26780 = g_ScrambledHaltonPermutations.Load<uint>(_26770 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_26750 * 426409u) + (_26765 * 653u)) + _26780) * 3.5913718665625538051244802772999e-09f;
	                _33360 = true;
	                break;
	            }
	            case 119u:
	            {
	                uint _26691 = _12091 % 659u;
	                uint _26693 = (37142u + _26691) / 2u;
	                uint _26703;
	                if ((_26691 & 1u) != 0u)
	                {
	                    _26703 = g_ScrambledHaltonPermutations.Load<uint>(_26693 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _26703 = g_ScrambledHaltonPermutations.Load<uint>(_26693 * 4 + 0) & 65535u;
	                }
	                uint _26706 = (_12091 / 659u) % 659u;
	                uint _26708 = (37142u + _26706) / 2u;
	                uint _26718;
	                if ((_26706 & 1u) != 0u)
	                {
	                    _26718 = g_ScrambledHaltonPermutations.Load<uint>(_26708 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _26718 = g_ScrambledHaltonPermutations.Load<uint>(_26708 * 4 + 0) & 65535u;
	                }
	                uint _26721 = (_12091 / 434281u) % 659u;
	                uint _26723 = (37142u + _26721) / 2u;
	                uint _26733;
	                if ((_26721 & 1u) != 0u)
	                {
	                    _26733 = g_ScrambledHaltonPermutations.Load<uint>(_26723 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _26733 = g_ScrambledHaltonPermutations.Load<uint>(_26723 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_26703 * 434281u) + (_26718 * 659u)) + _26733) * 3.4941673998645228493842296302319e-09f;
	                _33360 = true;
	                break;
	            }
	            case 120u:
	            {
	                uint _26645 = 37801u + (_12091 % 661u);
	                uint _26646 = _26645 / 2u;
	                uint _26656;
	                if ((_26645 & 1u) != 0u)
	                {
	                    _26656 = g_ScrambledHaltonPermutations.Load<uint>(_26646 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _26656 = g_ScrambledHaltonPermutations.Load<uint>(_26646 * 4 + 0) & 65535u;
	                }
	                uint _26660 = 37801u + ((_12091 / 661u) % 661u);
	                uint _26661 = _26660 / 2u;
	                uint _26671;
	                if ((_26660 & 1u) != 0u)
	                {
	                    _26671 = g_ScrambledHaltonPermutations.Load<uint>(_26661 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _26671 = g_ScrambledHaltonPermutations.Load<uint>(_26661 * 4 + 0) & 65535u;
	                }
	                uint _26675 = 37801u + ((_12091 / 436921u) % 661u);
	                uint _26676 = _26675 / 2u;
	                uint _26686;
	                if ((_26675 & 1u) != 0u)
	                {
	                    _26686 = g_ScrambledHaltonPermutations.Load<uint>(_26676 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _26686 = g_ScrambledHaltonPermutations.Load<uint>(_26676 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_26656 * 436921u) + (_26671 * 661u)) + _26686) * 3.4625462497217540658311918377876e-09f;
	                _33360 = true;
	                break;
	            }
	            case 121u:
	            {
	                uint _26597 = _12091 % 673u;
	                uint _26599 = (38462u + _26597) / 2u;
	                uint _26609;
	                if ((_26597 & 1u) != 0u)
	                {
	                    _26609 = g_ScrambledHaltonPermutations.Load<uint>(_26599 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _26609 = g_ScrambledHaltonPermutations.Load<uint>(_26599 * 4 + 0) & 65535u;
	                }
	                uint _26612 = (_12091 / 673u) % 673u;
	                uint _26614 = (38462u + _26612) / 2u;
	                uint _26624;
	                if ((_26612 & 1u) != 0u)
	                {
	                    _26624 = g_ScrambledHaltonPermutations.Load<uint>(_26614 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _26624 = g_ScrambledHaltonPermutations.Load<uint>(_26614 * 4 + 0) & 65535u;
	                }
	                uint _26627 = (_12091 / 452929u) % 673u;
	                uint _26629 = (38462u + _26627) / 2u;
	                uint _26639;
	                if ((_26627 & 1u) != 0u)
	                {
	                    _26639 = g_ScrambledHaltonPermutations.Load<uint>(_26629 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _26639 = g_ScrambledHaltonPermutations.Load<uint>(_26629 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_26609 * 452929u) + (_26624 * 673u)) + _26639) * 3.2806111160965656381449662148952e-09f;
	                _33360 = true;
	                break;
	            }
	            case 122u:
	            {
	                uint _26551 = 39135u + (_12091 % 677u);
	                uint _26552 = _26551 / 2u;
	                uint _26562;
	                if ((_26551 & 1u) != 0u)
	                {
	                    _26562 = g_ScrambledHaltonPermutations.Load<uint>(_26552 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _26562 = g_ScrambledHaltonPermutations.Load<uint>(_26552 * 4 + 0) & 65535u;
	                }
	                uint _26566 = 39135u + ((_12091 / 677u) % 677u);
	                uint _26567 = _26566 / 2u;
	                uint _26577;
	                if ((_26566 & 1u) != 0u)
	                {
	                    _26577 = g_ScrambledHaltonPermutations.Load<uint>(_26567 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _26577 = g_ScrambledHaltonPermutations.Load<uint>(_26567 * 4 + 0) & 65535u;
	                }
	                uint _26581 = 39135u + ((_12091 / 458329u) % 677u);
	                uint _26582 = _26581 / 2u;
	                uint _26592;
	                if ((_26581 & 1u) != 0u)
	                {
	                    _26592 = g_ScrambledHaltonPermutations.Load<uint>(_26582 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _26592 = g_ScrambledHaltonPermutations.Load<uint>(_26582 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_26562 * 458329u) + (_26577 * 677u)) + _26592) * 3.2228042456949879124294966459274e-09f;
	                _33360 = true;
	                break;
	            }
	            case 123u:
	            {
	                uint _26503 = _12091 % 683u;
	                uint _26505 = (39812u + _26503) / 2u;
	                uint _26515;
	                if ((_26503 & 1u) != 0u)
	                {
	                    _26515 = g_ScrambledHaltonPermutations.Load<uint>(_26505 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _26515 = g_ScrambledHaltonPermutations.Load<uint>(_26505 * 4 + 0) & 65535u;
	                }
	                uint _26518 = (_12091 / 683u) % 683u;
	                uint _26520 = (39812u + _26518) / 2u;
	                uint _26530;
	                if ((_26518 & 1u) != 0u)
	                {
	                    _26530 = g_ScrambledHaltonPermutations.Load<uint>(_26520 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _26530 = g_ScrambledHaltonPermutations.Load<uint>(_26520 * 4 + 0) & 65535u;
	                }
	                uint _26533 = (_12091 / 466489u) % 683u;
	                uint _26535 = (39812u + _26533) / 2u;
	                uint _26545;
	                if ((_26533 & 1u) != 0u)
	                {
	                    _26545 = g_ScrambledHaltonPermutations.Load<uint>(_26535 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _26545 = g_ScrambledHaltonPermutations.Load<uint>(_26535 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_26515 * 466489u) + (_26530 * 683u)) + _26545) * 3.1386133692024031915934756398201e-09f;
	                _33360 = true;
	                break;
	            }
	            case 124u:
	            {
	                uint _26457 = 40495u + (_12091 % 691u);
	                uint _26458 = _26457 / 2u;
	                uint _26468;
	                if ((_26457 & 1u) != 0u)
	                {
	                    _26468 = g_ScrambledHaltonPermutations.Load<uint>(_26458 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _26468 = g_ScrambledHaltonPermutations.Load<uint>(_26458 * 4 + 0) & 65535u;
	                }
	                uint _26472 = 40495u + ((_12091 / 691u) % 691u);
	                uint _26473 = _26472 / 2u;
	                uint _26483;
	                if ((_26472 & 1u) != 0u)
	                {
	                    _26483 = g_ScrambledHaltonPermutations.Load<uint>(_26473 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _26483 = g_ScrambledHaltonPermutations.Load<uint>(_26473 * 4 + 0) & 65535u;
	                }
	                uint _26487 = 40495u + ((_12091 / 477481u) % 691u);
	                uint _26488 = _26487 / 2u;
	                uint _26498;
	                if ((_26487 & 1u) != 0u)
	                {
	                    _26498 = g_ScrambledHaltonPermutations.Load<uint>(_26488 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _26498 = g_ScrambledHaltonPermutations.Load<uint>(_26488 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_26468 * 477481u) + (_26483 * 691u)) + _26498) * 3.0308595633243839984061196446419e-09f;
	                _33360 = true;
	                break;
	            }
	            case 125u:
	            {
	                uint _26409 = _12091 % 701u;
	                uint _26411 = (41186u + _26409) / 2u;
	                uint _26421;
	                if ((_26409 & 1u) != 0u)
	                {
	                    _26421 = g_ScrambledHaltonPermutations.Load<uint>(_26411 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _26421 = g_ScrambledHaltonPermutations.Load<uint>(_26411 * 4 + 0) & 65535u;
	                }
	                uint _26424 = (_12091 / 701u) % 701u;
	                uint _26426 = (41186u + _26424) / 2u;
	                uint _26436;
	                if ((_26424 & 1u) != 0u)
	                {
	                    _26436 = g_ScrambledHaltonPermutations.Load<uint>(_26426 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _26436 = g_ScrambledHaltonPermutations.Load<uint>(_26426 * 4 + 0) & 65535u;
	                }
	                uint _26439 = (_12091 / 491401u) % 701u;
	                uint _26441 = (41186u + _26439) / 2u;
	                uint _26451;
	                if ((_26439 & 1u) != 0u)
	                {
	                    _26451 = g_ScrambledHaltonPermutations.Load<uint>(_26441 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _26451 = g_ScrambledHaltonPermutations.Load<uint>(_26441 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_26421 * 491401u) + (_26436 * 701u)) + _26451) * 2.9029925130430456192698329687119e-09f;
	                _33360 = true;
	                break;
	            }
	            case 126u:
	            {
	                uint _26363 = 41887u + (_12091 % 709u);
	                uint _26364 = _26363 / 2u;
	                uint _26374;
	                if ((_26363 & 1u) != 0u)
	                {
	                    _26374 = g_ScrambledHaltonPermutations.Load<uint>(_26364 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _26374 = g_ScrambledHaltonPermutations.Load<uint>(_26364 * 4 + 0) & 65535u;
	                }
	                uint _26378 = 41887u + ((_12091 / 709u) % 709u);
	                uint _26379 = _26378 / 2u;
	                uint _26389;
	                if ((_26378 & 1u) != 0u)
	                {
	                    _26389 = g_ScrambledHaltonPermutations.Load<uint>(_26379 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _26389 = g_ScrambledHaltonPermutations.Load<uint>(_26379 * 4 + 0) & 65535u;
	                }
	                uint _26393 = 41887u + ((_12091 / 502681u) % 709u);
	                uint _26394 = _26393 / 2u;
	                uint _26404;
	                if ((_26393 & 1u) != 0u)
	                {
	                    _26404 = g_ScrambledHaltonPermutations.Load<uint>(_26394 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _26404 = g_ScrambledHaltonPermutations.Load<uint>(_26394 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_26374 * 502681u) + (_26389 * 709u)) + _26404) * 2.8058293466415307193528860807419e-09f;
	                _33360 = true;
	                break;
	            }
	            case 127u:
	            {
	                uint _26315 = _12091 % 719u;
	                uint _26317 = (42596u + _26315) / 2u;
	                uint _26327;
	                if ((_26315 & 1u) != 0u)
	                {
	                    _26327 = g_ScrambledHaltonPermutations.Load<uint>(_26317 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _26327 = g_ScrambledHaltonPermutations.Load<uint>(_26317 * 4 + 0) & 65535u;
	                }
	                uint _26330 = (_12091 / 719u) % 719u;
	                uint _26332 = (42596u + _26330) / 2u;
	                uint _26342;
	                if ((_26330 & 1u) != 0u)
	                {
	                    _26342 = g_ScrambledHaltonPermutations.Load<uint>(_26332 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _26342 = g_ScrambledHaltonPermutations.Load<uint>(_26332 * 4 + 0) & 65535u;
	                }
	                uint _26345 = (_12091 / 516961u) % 719u;
	                uint _26347 = (42596u + _26345) / 2u;
	                uint _26357;
	                if ((_26345 & 1u) != 0u)
	                {
	                    _26357 = g_ScrambledHaltonPermutations.Load<uint>(_26347 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _26357 = g_ScrambledHaltonPermutations.Load<uint>(_26347 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_26327 * 516961u) + (_26342 * 719u)) + _26357) * 2.6903779204445754658081568777561e-09f;
	                _33360 = true;
	                break;
	            }
	            case 128u:
	            {
	                uint _26269 = 43315u + (_12091 % 727u);
	                uint _26270 = _26269 / 2u;
	                uint _26280;
	                if ((_26269 & 1u) != 0u)
	                {
	                    _26280 = g_ScrambledHaltonPermutations.Load<uint>(_26270 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _26280 = g_ScrambledHaltonPermutations.Load<uint>(_26270 * 4 + 0) & 65535u;
	                }
	                uint _26284 = 43315u + ((_12091 / 727u) % 727u);
	                uint _26285 = _26284 / 2u;
	                uint _26295;
	                if ((_26284 & 1u) != 0u)
	                {
	                    _26295 = g_ScrambledHaltonPermutations.Load<uint>(_26285 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _26295 = g_ScrambledHaltonPermutations.Load<uint>(_26285 * 4 + 0) & 65535u;
	                }
	                uint _26299 = 43315u + ((_12091 / 528529u) % 727u);
	                uint _26300 = _26299 / 2u;
	                uint _26310;
	                if ((_26299 & 1u) != 0u)
	                {
	                    _26310 = g_ScrambledHaltonPermutations.Load<uint>(_26300 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _26310 = g_ScrambledHaltonPermutations.Load<uint>(_26300 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_26280 * 528529u) + (_26295 * 727u)) + _26310) * 2.6025359645132084551732987165451e-09f;
	                _33360 = true;
	                break;
	            }
	            case 129u:
	            {
	                uint _26221 = _12091 % 733u;
	                uint _26223 = (44042u + _26221) / 2u;
	                uint _26233;
	                if ((_26221 & 1u) != 0u)
	                {
	                    _26233 = g_ScrambledHaltonPermutations.Load<uint>(_26223 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _26233 = g_ScrambledHaltonPermutations.Load<uint>(_26223 * 4 + 0) & 65535u;
	                }
	                uint _26236 = (_12091 / 733u) % 733u;
	                uint _26238 = (44042u + _26236) / 2u;
	                uint _26248;
	                if ((_26236 & 1u) != 0u)
	                {
	                    _26248 = g_ScrambledHaltonPermutations.Load<uint>(_26238 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _26248 = g_ScrambledHaltonPermutations.Load<uint>(_26238 * 4 + 0) & 65535u;
	                }
	                uint _26251 = (_12091 / 537289u) % 733u;
	                uint _26253 = (44042u + _26251) / 2u;
	                uint _26263;
	                if ((_26251 & 1u) != 0u)
	                {
	                    _26263 = g_ScrambledHaltonPermutations.Load<uint>(_26253 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _26263 = g_ScrambledHaltonPermutations.Load<uint>(_26253 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_26233 * 537289u) + (_26248 * 733u)) + _26263) * 2.5391480029668400675291195511818e-09f;
	                _33360 = true;
	                break;
	            }
	            case 130u:
	            {
	                uint _26175 = 44775u + (_12091 % 739u);
	                uint _26176 = _26175 / 2u;
	                uint _26186;
	                if ((_26175 & 1u) != 0u)
	                {
	                    _26186 = g_ScrambledHaltonPermutations.Load<uint>(_26176 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _26186 = g_ScrambledHaltonPermutations.Load<uint>(_26176 * 4 + 0) & 65535u;
	                }
	                uint _26190 = 44775u + ((_12091 / 739u) % 739u);
	                uint _26191 = _26190 / 2u;
	                uint _26201;
	                if ((_26190 & 1u) != 0u)
	                {
	                    _26201 = g_ScrambledHaltonPermutations.Load<uint>(_26191 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _26201 = g_ScrambledHaltonPermutations.Load<uint>(_26191 * 4 + 0) & 65535u;
	                }
	                uint _26205 = 44775u + ((_12091 / 546121u) % 739u);
	                uint _26206 = _26205 / 2u;
	                uint _26216;
	                if ((_26205 & 1u) != 0u)
	                {
	                    _26216 = g_ScrambledHaltonPermutations.Load<uint>(_26206 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _26216 = g_ScrambledHaltonPermutations.Load<uint>(_26206 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_26186 * 546121u) + (_26201 * 739u)) + _26216) * 2.4778021856519671928253956139088e-09f;
	                _33360 = true;
	                break;
	            }
	            case 131u:
	            {
	                uint _26127 = _12091 % 743u;
	                uint _26129 = (45514u + _26127) / 2u;
	                uint _26139;
	                if ((_26127 & 1u) != 0u)
	                {
	                    _26139 = g_ScrambledHaltonPermutations.Load<uint>(_26129 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _26139 = g_ScrambledHaltonPermutations.Load<uint>(_26129 * 4 + 0) & 65535u;
	                }
	                uint _26142 = (_12091 / 743u) % 743u;
	                uint _26144 = (45514u + _26142) / 2u;
	                uint _26154;
	                if ((_26142 & 1u) != 0u)
	                {
	                    _26154 = g_ScrambledHaltonPermutations.Load<uint>(_26144 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _26154 = g_ScrambledHaltonPermutations.Load<uint>(_26144 * 4 + 0) & 65535u;
	                }
	                uint _26157 = (_12091 / 552049u) % 743u;
	                uint _26159 = (45514u + _26157) / 2u;
	                uint _26169;
	                if ((_26157 & 1u) != 0u)
	                {
	                    _26169 = g_ScrambledHaltonPermutations.Load<uint>(_26159 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _26169 = g_ScrambledHaltonPermutations.Load<uint>(_26159 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_26139 * 552049u) + (_26154 * 743u)) + _26169) * 2.437998913862315930600743740797e-09f;
	                _33360 = true;
	                break;
	            }
	            case 132u:
	            {
	                uint _26081 = 46257u + (_12091 % 751u);
	                uint _26082 = _26081 / 2u;
	                uint _26092;
	                if ((_26081 & 1u) != 0u)
	                {
	                    _26092 = g_ScrambledHaltonPermutations.Load<uint>(_26082 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _26092 = g_ScrambledHaltonPermutations.Load<uint>(_26082 * 4 + 0) & 65535u;
	                }
	                uint _26096 = 46257u + ((_12091 / 751u) % 751u);
	                uint _26097 = _26096 / 2u;
	                uint _26107;
	                if ((_26096 & 1u) != 0u)
	                {
	                    _26107 = g_ScrambledHaltonPermutations.Load<uint>(_26097 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _26107 = g_ScrambledHaltonPermutations.Load<uint>(_26097 * 4 + 0) & 65535u;
	                }
	                uint _26111 = 46257u + ((_12091 / 564001u) % 751u);
	                uint _26112 = _26111 / 2u;
	                uint _26122;
	                if ((_26111 & 1u) != 0u)
	                {
	                    _26122 = g_ScrambledHaltonPermutations.Load<uint>(_26112 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _26122 = g_ScrambledHaltonPermutations.Load<uint>(_26112 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_26092 * 564001u) + (_26107 * 751u)) + _26122) * 2.3609139088165420616860501468182e-09f;
	                _33360 = true;
	                break;
	            }
	            case 133u:
	            {
	                uint _26033 = _12091 % 757u;
	                uint _26035 = (47008u + _26033) / 2u;
	                uint _26045;
	                if ((_26033 & 1u) != 0u)
	                {
	                    _26045 = g_ScrambledHaltonPermutations.Load<uint>(_26035 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _26045 = g_ScrambledHaltonPermutations.Load<uint>(_26035 * 4 + 0) & 65535u;
	                }
	                uint _26048 = (_12091 / 757u) % 757u;
	                uint _26050 = (47008u + _26048) / 2u;
	                uint _26060;
	                if ((_26048 & 1u) != 0u)
	                {
	                    _26060 = g_ScrambledHaltonPermutations.Load<uint>(_26050 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _26060 = g_ScrambledHaltonPermutations.Load<uint>(_26050 * 4 + 0) & 65535u;
	                }
	                uint _26063 = (_12091 / 573049u) % 757u;
	                uint _26065 = (47008u + _26063) / 2u;
	                uint _26075;
	                if ((_26063 & 1u) != 0u)
	                {
	                    _26075 = g_ScrambledHaltonPermutations.Load<uint>(_26065 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _26075 = g_ScrambledHaltonPermutations.Load<uint>(_26065 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_26045 * 573049u) + (_26060 * 757u)) + _26075) * 2.3052197928308260088670067489147e-09f;
	                _33360 = true;
	                break;
	            }
	            case 134u:
	            {
	                uint _25987 = 47765u + (_12091 % 761u);
	                uint _25988 = _25987 / 2u;
	                uint _25998;
	                if ((_25987 & 1u) != 0u)
	                {
	                    _25998 = g_ScrambledHaltonPermutations.Load<uint>(_25988 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _25998 = g_ScrambledHaltonPermutations.Load<uint>(_25988 * 4 + 0) & 65535u;
	                }
	                uint _26002 = 47765u + ((_12091 / 761u) % 761u);
	                uint _26003 = _26002 / 2u;
	                uint _26013;
	                if ((_26002 & 1u) != 0u)
	                {
	                    _26013 = g_ScrambledHaltonPermutations.Load<uint>(_26003 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _26013 = g_ScrambledHaltonPermutations.Load<uint>(_26003 * 4 + 0) & 65535u;
	                }
	                uint _26017 = 47765u + ((_12091 / 579121u) % 761u);
	                uint _26018 = _26017 / 2u;
	                uint _26028;
	                if ((_26017 & 1u) != 0u)
	                {
	                    _26028 = g_ScrambledHaltonPermutations.Load<uint>(_26018 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _26028 = g_ScrambledHaltonPermutations.Load<uint>(_26018 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_25998 * 579121u) + (_26013 * 761u)) + _26028) * 2.2690600509633895853767171502113e-09f;
	                _33360 = true;
	                break;
	            }
	            case 135u:
	            {
	                uint _25939 = _12091 % 769u;
	                uint _25941 = (48526u + _25939) / 2u;
	                uint _25951;
	                if ((_25939 & 1u) != 0u)
	                {
	                    _25951 = g_ScrambledHaltonPermutations.Load<uint>(_25941 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _25951 = g_ScrambledHaltonPermutations.Load<uint>(_25941 * 4 + 0) & 65535u;
	                }
	                uint _25954 = (_12091 / 769u) % 769u;
	                uint _25956 = (48526u + _25954) / 2u;
	                uint _25966;
	                if ((_25954 & 1u) != 0u)
	                {
	                    _25966 = g_ScrambledHaltonPermutations.Load<uint>(_25956 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _25966 = g_ScrambledHaltonPermutations.Load<uint>(_25956 * 4 + 0) & 65535u;
	                }
	                uint _25969 = (_12091 / 591361u) % 769u;
	                uint _25971 = (48526u + _25969) / 2u;
	                uint _25981;
	                if ((_25969 & 1u) != 0u)
	                {
	                    _25981 = g_ScrambledHaltonPermutations.Load<uint>(_25971 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _25981 = g_ScrambledHaltonPermutations.Load<uint>(_25971 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_25951 * 591361u) + (_25966 * 769u)) + _25981) * 2.1989783327569512039190158247948e-09f;
	                _33360 = true;
	                break;
	            }
	            case 136u:
	            {
	                uint _25893 = 49295u + (_12091 % 773u);
	                uint _25894 = _25893 / 2u;
	                uint _25904;
	                if ((_25893 & 1u) != 0u)
	                {
	                    _25904 = g_ScrambledHaltonPermutations.Load<uint>(_25894 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _25904 = g_ScrambledHaltonPermutations.Load<uint>(_25894 * 4 + 0) & 65535u;
	                }
	                uint _25908 = 49295u + ((_12091 / 773u) % 773u);
	                uint _25909 = _25908 / 2u;
	                uint _25919;
	                if ((_25908 & 1u) != 0u)
	                {
	                    _25919 = g_ScrambledHaltonPermutations.Load<uint>(_25909 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _25919 = g_ScrambledHaltonPermutations.Load<uint>(_25909 * 4 + 0) & 65535u;
	                }
	                uint _25923 = 49295u + ((_12091 / 597529u) % 773u);
	                uint _25924 = _25923 / 2u;
	                uint _25934;
	                if ((_25923 & 1u) != 0u)
	                {
	                    _25934 = g_ScrambledHaltonPermutations.Load<uint>(_25924 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _25934 = g_ScrambledHaltonPermutations.Load<uint>(_25924 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_25904 * 597529u) + (_25919 * 773u)) + _25934) * 2.1650177206566922905039973556995e-09f;
	                _33360 = true;
	                break;
	            }
	            case 137u:
	            {
	                uint _25845 = _12091 % 787u;
	                uint _25847 = (50068u + _25845) / 2u;
	                uint _25857;
	                if ((_25845 & 1u) != 0u)
	                {
	                    _25857 = g_ScrambledHaltonPermutations.Load<uint>(_25847 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _25857 = g_ScrambledHaltonPermutations.Load<uint>(_25847 * 4 + 0) & 65535u;
	                }
	                uint _25860 = (_12091 / 787u) % 787u;
	                uint _25862 = (50068u + _25860) / 2u;
	                uint _25872;
	                if ((_25860 & 1u) != 0u)
	                {
	                    _25872 = g_ScrambledHaltonPermutations.Load<uint>(_25862 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _25872 = g_ScrambledHaltonPermutations.Load<uint>(_25862 * 4 + 0) & 65535u;
	                }
	                uint _25875 = (_12091 / 619369u) % 787u;
	                uint _25877 = (50068u + _25875) / 2u;
	                uint _25887;
	                if ((_25875 & 1u) != 0u)
	                {
	                    _25887 = g_ScrambledHaltonPermutations.Load<uint>(_25877 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _25887 = g_ScrambledHaltonPermutations.Load<uint>(_25877 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_25857 * 619369u) + (_25872 * 787u)) + _25887) * 2.0515200649384723874391056597233e-09f;
	                _33360 = true;
	                break;
	            }
	            case 138u:
	            {
	                uint _25799 = 50855u + (_12091 % 797u);
	                uint _25800 = _25799 / 2u;
	                uint _25810;
	                if ((_25799 & 1u) != 0u)
	                {
	                    _25810 = g_ScrambledHaltonPermutations.Load<uint>(_25800 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _25810 = g_ScrambledHaltonPermutations.Load<uint>(_25800 * 4 + 0) & 65535u;
	                }
	                uint _25814 = 50855u + ((_12091 / 797u) % 797u);
	                uint _25815 = _25814 / 2u;
	                uint _25825;
	                if ((_25814 & 1u) != 0u)
	                {
	                    _25825 = g_ScrambledHaltonPermutations.Load<uint>(_25815 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _25825 = g_ScrambledHaltonPermutations.Load<uint>(_25815 * 4 + 0) & 65535u;
	                }
	                uint _25829 = 50855u + ((_12091 / 635209u) % 797u);
	                uint _25830 = _25829 / 2u;
	                uint _25840;
	                if ((_25829 & 1u) != 0u)
	                {
	                    _25840 = g_ScrambledHaltonPermutations.Load<uint>(_25830 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _25840 = g_ScrambledHaltonPermutations.Load<uint>(_25830 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_25810 * 635209u) + (_25825 * 797u)) + _25840) * 1.9752632862690688853035680949688e-09f;
	                _33360 = true;
	                break;
	            }
	            case 139u:
	            {
	                uint _25751 = _12091 % 809u;
	                uint _25753 = (51652u + _25751) / 2u;
	                uint _25763;
	                if ((_25751 & 1u) != 0u)
	                {
	                    _25763 = g_ScrambledHaltonPermutations.Load<uint>(_25753 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _25763 = g_ScrambledHaltonPermutations.Load<uint>(_25753 * 4 + 0) & 65535u;
	                }
	                uint _25766 = (_12091 / 809u) % 809u;
	                uint _25768 = (51652u + _25766) / 2u;
	                uint _25778;
	                if ((_25766 & 1u) != 0u)
	                {
	                    _25778 = g_ScrambledHaltonPermutations.Load<uint>(_25768 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _25778 = g_ScrambledHaltonPermutations.Load<uint>(_25768 * 4 + 0) & 65535u;
	                }
	                uint _25781 = (_12091 / 654481u) % 809u;
	                uint _25783 = (51652u + _25781) / 2u;
	                uint _25793;
	                if ((_25781 & 1u) != 0u)
	                {
	                    _25793 = g_ScrambledHaltonPermutations.Load<uint>(_25783 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _25793 = g_ScrambledHaltonPermutations.Load<uint>(_25783 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_25763 * 654481u) + (_25778 * 809u)) + _25793) * 1.8886625596792327996809035539627e-09f;
	                _33360 = true;
	                break;
	            }
	            case 140u:
	            {
	                uint _25705 = 52461u + (_12091 % 811u);
	                uint _25706 = _25705 / 2u;
	                uint _25716;
	                if ((_25705 & 1u) != 0u)
	                {
	                    _25716 = g_ScrambledHaltonPermutations.Load<uint>(_25706 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _25716 = g_ScrambledHaltonPermutations.Load<uint>(_25706 * 4 + 0) & 65535u;
	                }
	                uint _25720 = 52461u + ((_12091 / 811u) % 811u);
	                uint _25721 = _25720 / 2u;
	                uint _25731;
	                if ((_25720 & 1u) != 0u)
	                {
	                    _25731 = g_ScrambledHaltonPermutations.Load<uint>(_25721 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _25731 = g_ScrambledHaltonPermutations.Load<uint>(_25721 * 4 + 0) & 65535u;
	                }
	                uint _25735 = 52461u + ((_12091 / 657721u) % 811u);
	                uint _25736 = _25735 / 2u;
	                uint _25746;
	                if ((_25735 & 1u) != 0u)
	                {
	                    _25746 = g_ScrambledHaltonPermutations.Load<uint>(_25736 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _25746 = g_ScrambledHaltonPermutations.Load<uint>(_25736 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_25716 * 657721u) + (_25731 * 811u)) + _25746) * 1.8747241536942738093785010278225e-09f;
	                _33360 = true;
	                break;
	            }
	            case 141u:
	            {
	                uint _25657 = _12091 % 821u;
	                uint _25659 = (53272u + _25657) / 2u;
	                uint _25669;
	                if ((_25657 & 1u) != 0u)
	                {
	                    _25669 = g_ScrambledHaltonPermutations.Load<uint>(_25659 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _25669 = g_ScrambledHaltonPermutations.Load<uint>(_25659 * 4 + 0) & 65535u;
	                }
	                uint _25672 = (_12091 / 821u) % 821u;
	                uint _25674 = (53272u + _25672) / 2u;
	                uint _25684;
	                if ((_25672 & 1u) != 0u)
	                {
	                    _25684 = g_ScrambledHaltonPermutations.Load<uint>(_25674 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _25684 = g_ScrambledHaltonPermutations.Load<uint>(_25674 * 4 + 0) & 65535u;
	                }
	                uint _25687 = (_12091 / 674041u) % 821u;
	                uint _25689 = (53272u + _25687) / 2u;
	                uint _25699;
	                if ((_25687 & 1u) != 0u)
	                {
	                    _25699 = g_ScrambledHaltonPermutations.Load<uint>(_25689 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _25699 = g_ScrambledHaltonPermutations.Load<uint>(_25689 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_25669 * 674041u) + (_25684 * 821u)) + _25699) * 1.8070512863843646300665568560362e-09f;
	                _33360 = true;
	                break;
	            }
	            case 142u:
	            {
	                uint _25611 = 54093u + (_12091 % 823u);
	                uint _25612 = _25611 / 2u;
	                uint _25622;
	                if ((_25611 & 1u) != 0u)
	                {
	                    _25622 = g_ScrambledHaltonPermutations.Load<uint>(_25612 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _25622 = g_ScrambledHaltonPermutations.Load<uint>(_25612 * 4 + 0) & 65535u;
	                }
	                uint _25626 = 54093u + ((_12091 / 823u) % 823u);
	                uint _25627 = _25626 / 2u;
	                uint _25637;
	                if ((_25626 & 1u) != 0u)
	                {
	                    _25637 = g_ScrambledHaltonPermutations.Load<uint>(_25627 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _25637 = g_ScrambledHaltonPermutations.Load<uint>(_25627 * 4 + 0) & 65535u;
	                }
	                uint _25641 = 54093u + ((_12091 / 677329u) % 823u);
	                uint _25642 = _25641 / 2u;
	                uint _25652;
	                if ((_25641 & 1u) != 0u)
	                {
	                    _25652 = g_ScrambledHaltonPermutations.Load<uint>(_25642 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _25652 = g_ScrambledHaltonPermutations.Load<uint>(_25642 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_25622 * 677329u) + (_25637 * 823u)) + _25652) * 1.7939090213303643395192921161652e-09f;
	                _33360 = true;
	                break;
	            }
	            case 143u:
	            {
	                uint _25563 = _12091 % 827u;
	                uint _25565 = (54916u + _25563) / 2u;
	                uint _25575;
	                if ((_25563 & 1u) != 0u)
	                {
	                    _25575 = g_ScrambledHaltonPermutations.Load<uint>(_25565 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _25575 = g_ScrambledHaltonPermutations.Load<uint>(_25565 * 4 + 0) & 65535u;
	                }
	                uint _25578 = (_12091 / 827u) % 827u;
	                uint _25580 = (54916u + _25578) / 2u;
	                uint _25590;
	                if ((_25578 & 1u) != 0u)
	                {
	                    _25590 = g_ScrambledHaltonPermutations.Load<uint>(_25580 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _25590 = g_ScrambledHaltonPermutations.Load<uint>(_25580 * 4 + 0) & 65535u;
	                }
	                uint _25593 = (_12091 / 683929u) % 827u;
	                uint _25595 = (54916u + _25593) / 2u;
	                uint _25605;
	                if ((_25593 & 1u) != 0u)
	                {
	                    _25605 = g_ScrambledHaltonPermutations.Load<uint>(_25595 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _25605 = g_ScrambledHaltonPermutations.Load<uint>(_25595 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_25575 * 683929u) + (_25590 * 827u)) + _25605) * 1.7680047426082978745398577302694e-09f;
	                _33360 = true;
	                break;
	            }
	            case 144u:
	            {
	                uint _25517 = 55743u + (_12091 % 829u);
	                uint _25518 = _25517 / 2u;
	                uint _25528;
	                if ((_25517 & 1u) != 0u)
	                {
	                    _25528 = g_ScrambledHaltonPermutations.Load<uint>(_25518 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _25528 = g_ScrambledHaltonPermutations.Load<uint>(_25518 * 4 + 0) & 65535u;
	                }
	                uint _25532 = 55743u + ((_12091 / 829u) % 829u);
	                uint _25533 = _25532 / 2u;
	                uint _25543;
	                if ((_25532 & 1u) != 0u)
	                {
	                    _25543 = g_ScrambledHaltonPermutations.Load<uint>(_25533 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _25543 = g_ScrambledHaltonPermutations.Load<uint>(_25533 * 4 + 0) & 65535u;
	                }
	                uint _25547 = 55743u + ((_12091 / 687241u) % 829u);
	                uint _25548 = _25547 / 2u;
	                uint _25558;
	                if ((_25547 & 1u) != 0u)
	                {
	                    _25558 = g_ScrambledHaltonPermutations.Load<uint>(_25548 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _25558 = g_ScrambledHaltonPermutations.Load<uint>(_25548 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_25528 * 687241u) + (_25543 * 829u)) + _25558) * 1.7552392872488553621224127709866e-09f;
	                _33360 = true;
	                break;
	            }
	            case 145u:
	            {
	                uint _25469 = _12091 % 839u;
	                uint _25471 = (56572u + _25469) / 2u;
	                uint _25481;
	                if ((_25469 & 1u) != 0u)
	                {
	                    _25481 = g_ScrambledHaltonPermutations.Load<uint>(_25471 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _25481 = g_ScrambledHaltonPermutations.Load<uint>(_25471 * 4 + 0) & 65535u;
	                }
	                uint _25484 = (_12091 / 839u) % 839u;
	                uint _25486 = (56572u + _25484) / 2u;
	                uint _25496;
	                if ((_25484 & 1u) != 0u)
	                {
	                    _25496 = g_ScrambledHaltonPermutations.Load<uint>(_25486 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _25496 = g_ScrambledHaltonPermutations.Load<uint>(_25486 * 4 + 0) & 65535u;
	                }
	                uint _25499 = (_12091 / 703921u) % 839u;
	                uint _25501 = (56572u + _25499) / 2u;
	                uint _25511;
	                if ((_25499 & 1u) != 0u)
	                {
	                    _25511 = g_ScrambledHaltonPermutations.Load<uint>(_25501 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _25511 = g_ScrambledHaltonPermutations.Load<uint>(_25501 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_25481 * 703921u) + (_25496 * 839u)) + _25511) * 1.6932226731825039678369648754597e-09f;
	                _33360 = true;
	                break;
	            }
	            case 146u:
	            {
	                uint _25423 = 57411u + (_12091 % 853u);
	                uint _25424 = _25423 / 2u;
	                uint _25434;
	                if ((_25423 & 1u) != 0u)
	                {
	                    _25434 = g_ScrambledHaltonPermutations.Load<uint>(_25424 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _25434 = g_ScrambledHaltonPermutations.Load<uint>(_25424 * 4 + 0) & 65535u;
	                }
	                uint _25438 = 57411u + ((_12091 / 853u) % 853u);
	                uint _25439 = _25438 / 2u;
	                uint _25449;
	                if ((_25438 & 1u) != 0u)
	                {
	                    _25449 = g_ScrambledHaltonPermutations.Load<uint>(_25439 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _25449 = g_ScrambledHaltonPermutations.Load<uint>(_25439 * 4 + 0) & 65535u;
	                }
	                uint _25453 = 57411u + ((_12091 / 727609u) % 853u);
	                uint _25454 = _25453 / 2u;
	                uint _25464;
	                if ((_25453 & 1u) != 0u)
	                {
	                    _25464 = g_ScrambledHaltonPermutations.Load<uint>(_25454 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _25464 = g_ScrambledHaltonPermutations.Load<uint>(_25454 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_25434 * 727609u) + (_25449 * 853u)) + _25464) * 1.611212607777190441993298009038e-09f;
	                _33360 = true;
	                break;
	            }
	            case 147u:
	            {
	                uint _25375 = _12091 % 857u;
	                uint _25377 = (58264u + _25375) / 2u;
	                uint _25387;
	                if ((_25375 & 1u) != 0u)
	                {
	                    _25387 = g_ScrambledHaltonPermutations.Load<uint>(_25377 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _25387 = g_ScrambledHaltonPermutations.Load<uint>(_25377 * 4 + 0) & 65535u;
	                }
	                uint _25390 = (_12091 / 857u) % 857u;
	                uint _25392 = (58264u + _25390) / 2u;
	                uint _25402;
	                if ((_25390 & 1u) != 0u)
	                {
	                    _25402 = g_ScrambledHaltonPermutations.Load<uint>(_25392 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _25402 = g_ScrambledHaltonPermutations.Load<uint>(_25392 * 4 + 0) & 65535u;
	                }
	                uint _25405 = (_12091 / 734449u) % 857u;
	                uint _25407 = (58264u + _25405) / 2u;
	                uint _25417;
	                if ((_25405 & 1u) != 0u)
	                {
	                    _25417 = g_ScrambledHaltonPermutations.Load<uint>(_25407 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _25417 = g_ScrambledHaltonPermutations.Load<uint>(_25407 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_25387 * 734449u) + (_25402 * 857u)) + _25417) * 1.5887570148365171007753815501928e-09f;
	                _33360 = true;
	                break;
	            }
	            case 148u:
	            {
	                uint _25329 = 59121u + (_12091 % 859u);
	                uint _25330 = _25329 / 2u;
	                uint _25340;
	                if ((_25329 & 1u) != 0u)
	                {
	                    _25340 = g_ScrambledHaltonPermutations.Load<uint>(_25330 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _25340 = g_ScrambledHaltonPermutations.Load<uint>(_25330 * 4 + 0) & 65535u;
	                }
	                uint _25344 = 59121u + ((_12091 / 859u) % 859u);
	                uint _25345 = _25344 / 2u;
	                uint _25355;
	                if ((_25344 & 1u) != 0u)
	                {
	                    _25355 = g_ScrambledHaltonPermutations.Load<uint>(_25345 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _25355 = g_ScrambledHaltonPermutations.Load<uint>(_25345 * 4 + 0) & 65535u;
	                }
	                uint _25359 = 59121u + ((_12091 / 737881u) % 859u);
	                uint _25360 = _25359 / 2u;
	                uint _25370;
	                if ((_25359 & 1u) != 0u)
	                {
	                    _25370 = g_ScrambledHaltonPermutations.Load<uint>(_25360 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _25370 = g_ScrambledHaltonPermutations.Load<uint>(_25360 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_25340 * 737881u) + (_25355 * 859u)) + _25370) * 1.5776855377680476522073149681091e-09f;
	                _33360 = true;
	                break;
	            }
	            case 149u:
	            {
	                uint _25281 = _12091 % 863u;
	                uint _25283 = (59980u + _25281) / 2u;
	                uint _25293;
	                if ((_25281 & 1u) != 0u)
	                {
	                    _25293 = g_ScrambledHaltonPermutations.Load<uint>(_25283 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _25293 = g_ScrambledHaltonPermutations.Load<uint>(_25283 * 4 + 0) & 65535u;
	                }
	                uint _25296 = (_12091 / 863u) % 863u;
	                uint _25298 = (59980u + _25296) / 2u;
	                uint _25308;
	                if ((_25296 & 1u) != 0u)
	                {
	                    _25308 = g_ScrambledHaltonPermutations.Load<uint>(_25298 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _25308 = g_ScrambledHaltonPermutations.Load<uint>(_25298 * 4 + 0) & 65535u;
	                }
	                uint _25311 = (_12091 / 744769u) % 863u;
	                uint _25313 = (59980u + _25311) / 2u;
	                uint _25323;
	                if ((_25311 & 1u) != 0u)
	                {
	                    _25323 = g_ScrambledHaltonPermutations.Load<uint>(_25313 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _25323 = g_ScrambledHaltonPermutations.Load<uint>(_25313 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_25293 * 744769u) + (_25308 * 863u)) + _25323) * 1.5558494492751151483389548957348e-09f;
	                _33360 = true;
	                break;
	            }
	            case 150u:
	            {
	                uint _25235 = 60843u + (_12091 % 877u);
	                uint _25236 = _25235 / 2u;
	                uint _25246;
	                if ((_25235 & 1u) != 0u)
	                {
	                    _25246 = g_ScrambledHaltonPermutations.Load<uint>(_25236 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _25246 = g_ScrambledHaltonPermutations.Load<uint>(_25236 * 4 + 0) & 65535u;
	                }
	                uint _25250 = 60843u + ((_12091 / 877u) % 877u);
	                uint _25251 = _25250 / 2u;
	                uint _25261;
	                if ((_25250 & 1u) != 0u)
	                {
	                    _25261 = g_ScrambledHaltonPermutations.Load<uint>(_25251 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _25261 = g_ScrambledHaltonPermutations.Load<uint>(_25251 * 4 + 0) & 65535u;
	                }
	                uint _25265 = 60843u + ((_12091 / 769129u) % 877u);
	                uint _25266 = _25265 / 2u;
	                uint _25276;
	                if ((_25265 & 1u) != 0u)
	                {
	                    _25276 = g_ScrambledHaltonPermutations.Load<uint>(_25266 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _25276 = g_ScrambledHaltonPermutations.Load<uint>(_25266 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_25246 * 769129u) + (_25261 * 877u)) + _25276) * 1.4825219940561851217353250831366e-09f;
	                _33360 = true;
	                break;
	            }
	            case 151u:
	            {
	                uint _25187 = _12091 % 881u;
	                uint _25189 = (61720u + _25187) / 2u;
	                uint _25199;
	                if ((_25187 & 1u) != 0u)
	                {
	                    _25199 = g_ScrambledHaltonPermutations.Load<uint>(_25189 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _25199 = g_ScrambledHaltonPermutations.Load<uint>(_25189 * 4 + 0) & 65535u;
	                }
	                uint _25202 = (_12091 / 881u) % 881u;
	                uint _25204 = (61720u + _25202) / 2u;
	                uint _25214;
	                if ((_25202 & 1u) != 0u)
	                {
	                    _25214 = g_ScrambledHaltonPermutations.Load<uint>(_25204 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _25214 = g_ScrambledHaltonPermutations.Load<uint>(_25204 * 4 + 0) & 65535u;
	                }
	                uint _25217 = (_12091 / 776161u) % 881u;
	                uint _25219 = (61720u + _25217) / 2u;
	                uint _25229;
	                if ((_25217 & 1u) != 0u)
	                {
	                    _25229 = g_ScrambledHaltonPermutations.Load<uint>(_25219 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _25229 = g_ScrambledHaltonPermutations.Load<uint>(_25219 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_25199 * 776161u) + (_25214 * 881u)) + _25229) * 1.4624204069946244999300688505173e-09f;
	                _33360 = true;
	                break;
	            }
	            case 152u:
	            {
	                uint _25139 = 62601u + (_12091 % 883u);
	                uint _25140 = _25139 / 2u;
	                uint _25150;
	                if ((_25139 & 1u) != 0u)
	                {
	                    _25150 = g_ScrambledHaltonPermutations.Load<uint>(_25140 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _25150 = g_ScrambledHaltonPermutations.Load<uint>(_25140 * 4 + 0) & 65535u;
	                }
	                uint _25154 = 62601u + ((_12091 / 883u) % 883u);
	                uint _25155 = _25154 / 2u;
	                uint _25165;
	                if ((_25154 & 1u) != 0u)
	                {
	                    _25165 = g_ScrambledHaltonPermutations.Load<uint>(_25155 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _25165 = g_ScrambledHaltonPermutations.Load<uint>(_25155 * 4 + 0) & 65535u;
	                }
	                uint _25169 = 62601u + ((_12091 / 779689u) % 883u);
	                uint _25170 = _25169 / 2u;
	                uint _25180;
	                if ((_25169 & 1u) != 0u)
	                {
	                    _25180 = g_ScrambledHaltonPermutations.Load<uint>(_25170 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _25180 = g_ScrambledHaltonPermutations.Load<uint>(_25170 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_25150 * 779689u) + (_25165 * 883u)) + _25180) * 1.4525056712955120019614696502686e-09f;
	                _33360 = true;
	                break;
	            }
	            case 153u:
	            {
	                uint _25091 = _12091 % 887u;
	                uint _25093 = (63484u + _25091) / 2u;
	                uint _25103;
	                if ((_25091 & 1u) != 0u)
	                {
	                    _25103 = g_ScrambledHaltonPermutations.Load<uint>(_25093 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _25103 = g_ScrambledHaltonPermutations.Load<uint>(_25093 * 4 + 0) & 65535u;
	                }
	                uint _25106 = (_12091 / 887u) % 887u;
	                uint _25108 = (63484u + _25106) / 2u;
	                uint _25118;
	                if ((_25106 & 1u) != 0u)
	                {
	                    _25118 = g_ScrambledHaltonPermutations.Load<uint>(_25108 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _25118 = g_ScrambledHaltonPermutations.Load<uint>(_25108 * 4 + 0) & 65535u;
	                }
	                uint _25121 = (_12091 / 786769u) % 887u;
	                uint _25123 = (63484u + _25121) / 2u;
	                uint _25133;
	                if ((_25121 & 1u) != 0u)
	                {
	                    _25133 = g_ScrambledHaltonPermutations.Load<uint>(_25123 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _25133 = g_ScrambledHaltonPermutations.Load<uint>(_25123 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_25103 * 786769u) + (_25118 * 887u)) + _25133) * 1.4329435416016167437192052602768e-09f;
	                _33360 = true;
	                break;
	            }
	            case 154u:
	            {
	                uint _25045 = 64371u + (_12091 % 907u);
	                uint _25046 = _25045 / 2u;
	                uint _25056;
	                if ((_25045 & 1u) != 0u)
	                {
	                    _25056 = g_ScrambledHaltonPermutations.Load<uint>(_25046 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _25056 = g_ScrambledHaltonPermutations.Load<uint>(_25046 * 4 + 0) & 65535u;
	                }
	                uint _25060 = 64371u + ((_12091 / 907u) % 907u);
	                uint _25061 = _25060 / 2u;
	                uint _25071;
	                if ((_25060 & 1u) != 0u)
	                {
	                    _25071 = g_ScrambledHaltonPermutations.Load<uint>(_25061 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _25071 = g_ScrambledHaltonPermutations.Load<uint>(_25061 * 4 + 0) & 65535u;
	                }
	                uint _25075 = 64371u + ((_12091 / 822649u) % 907u);
	                uint _25076 = _25075 / 2u;
	                uint _25086;
	                if ((_25075 & 1u) != 0u)
	                {
	                    _25086 = g_ScrambledHaltonPermutations.Load<uint>(_25076 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _25086 = g_ScrambledHaltonPermutations.Load<uint>(_25076 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_25056 * 822649u) + (_25071 * 907u)) + _25086) * 1.3402261522799108206527307629585e-09f;
	                _33360 = true;
	                break;
	            }
	            case 155u:
	            {
	                uint _24997 = _12091 % 911u;
	                uint _24999 = (65278u + _24997) / 2u;
	                uint _25009;
	                if ((_24997 & 1u) != 0u)
	                {
	                    _25009 = g_ScrambledHaltonPermutations.Load<uint>(_24999 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _25009 = g_ScrambledHaltonPermutations.Load<uint>(_24999 * 4 + 0) & 65535u;
	                }
	                uint _25012 = (_12091 / 911u) % 911u;
	                uint _25014 = (65278u + _25012) / 2u;
	                uint _25024;
	                if ((_25012 & 1u) != 0u)
	                {
	                    _25024 = g_ScrambledHaltonPermutations.Load<uint>(_25014 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _25024 = g_ScrambledHaltonPermutations.Load<uint>(_25014 * 4 + 0) & 65535u;
	                }
	                uint _25027 = (_12091 / 829921u) % 911u;
	                uint _25029 = (65278u + _25027) / 2u;
	                uint _25039;
	                if ((_25027 & 1u) != 0u)
	                {
	                    _25039 = g_ScrambledHaltonPermutations.Load<uint>(_25029 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _25039 = g_ScrambledHaltonPermutations.Load<uint>(_25029 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_25009 * 829921u) + (_25024 * 911u)) + _25039) * 1.3226496564655576548830140382051e-09f;
	                _33360 = true;
	                break;
	            }
	            case 156u:
	            {
	                uint _24950 = 66189u + (_12091 % 919u);
	                uint _24951 = _24950 / 2u;
	                uint _24962;
	                if ((_24950 & 1u) != 0u)
	                {
	                    _24962 = g_ScrambledHaltonPermutations.Load<uint>(_24951 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _24962 = g_ScrambledHaltonPermutations.Load<uint>(_24951 * 4 + 0) & 65535u;
	                }
	                uint _24966 = 66189u + ((_12091 / 919u) % 919u);
	                uint _24967 = _24966 / 2u;
	                uint _24977;
	                if ((_24966 & 1u) != 0u)
	                {
	                    _24977 = g_ScrambledHaltonPermutations.Load<uint>(_24967 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _24977 = g_ScrambledHaltonPermutations.Load<uint>(_24967 * 4 + 0) & 65535u;
	                }
	                uint _24981 = 66189u + ((_12091 / 844561u) % 919u);
	                uint _24982 = _24981 / 2u;
	                uint _24992;
	                if ((_24981 & 1u) != 0u)
	                {
	                    _24992 = g_ScrambledHaltonPermutations.Load<uint>(_24982 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _24992 = g_ScrambledHaltonPermutations.Load<uint>(_24982 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_24962 * 844561u) + (_24977 * 919u)) + _24992) * 1.2884080469177661143476143479347e-09f;
	                _33360 = true;
	                break;
	            }
	            case 157u:
	            {
	                uint _24902 = _12091 % 929u;
	                uint _24904 = (67108u + _24902) / 2u;
	                uint _24914;
	                if ((_24902 & 1u) != 0u)
	                {
	                    _24914 = g_ScrambledHaltonPermutations.Load<uint>(_24904 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _24914 = g_ScrambledHaltonPermutations.Load<uint>(_24904 * 4 + 0) & 65535u;
	                }
	                uint _24917 = (_12091 / 929u) % 929u;
	                uint _24919 = (67108u + _24917) / 2u;
	                uint _24929;
	                if ((_24917 & 1u) != 0u)
	                {
	                    _24929 = g_ScrambledHaltonPermutations.Load<uint>(_24919 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _24929 = g_ScrambledHaltonPermutations.Load<uint>(_24919 * 4 + 0) & 65535u;
	                }
	                uint _24932 = (_12091 / 863041u) % 929u;
	                uint _24934 = (67108u + _24932) / 2u;
	                uint _24944;
	                if ((_24932 & 1u) != 0u)
	                {
	                    _24944 = g_ScrambledHaltonPermutations.Load<uint>(_24934 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _24944 = g_ScrambledHaltonPermutations.Load<uint>(_24934 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_24914 * 863041u) + (_24929 * 929u)) + _24944) * 1.2472479715697204483149107545614e-09f;
	                _33360 = true;
	                break;
	            }
	            case 158u:
	            {
	                uint _24856 = 68037u + (_12091 % 937u);
	                uint _24857 = _24856 / 2u;
	                uint _24867;
	                if ((_24856 & 1u) != 0u)
	                {
	                    _24867 = g_ScrambledHaltonPermutations.Load<uint>(_24857 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _24867 = g_ScrambledHaltonPermutations.Load<uint>(_24857 * 4 + 0) & 65535u;
	                }
	                uint _24871 = 68037u + ((_12091 / 937u) % 937u);
	                uint _24872 = _24871 / 2u;
	                uint _24882;
	                if ((_24871 & 1u) != 0u)
	                {
	                    _24882 = g_ScrambledHaltonPermutations.Load<uint>(_24872 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _24882 = g_ScrambledHaltonPermutations.Load<uint>(_24872 * 4 + 0) & 65535u;
	                }
	                uint _24886 = 68037u + ((_12091 / 877969u) % 937u);
	                uint _24887 = _24886 / 2u;
	                uint _24897;
	                if ((_24886 & 1u) != 0u)
	                {
	                    _24897 = g_ScrambledHaltonPermutations.Load<uint>(_24887 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _24897 = g_ScrambledHaltonPermutations.Load<uint>(_24887 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_24867 * 877969u) + (_24882 * 937u)) + _24897) * 1.2155733086771647322166245430708e-09f;
	                _33360 = true;
	                break;
	            }
	            case 159u:
	            {
	                uint _24800 = _12091 % 941u;
	                uint _24802 = (68974u + _24800) / 2u;
	                uint _24812;
	                if ((_24800 & 1u) != 0u)
	                {
	                    _24812 = g_ScrambledHaltonPermutations.Load<uint>(_24802 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _24812 = g_ScrambledHaltonPermutations.Load<uint>(_24802 * 4 + 0) & 65535u;
	                }
	                uint _24815 = (_12091 / 941u) % 941u;
	                uint _24817 = (68974u + _24815) / 2u;
	                uint _24827;
	                if ((_24815 & 1u) != 0u)
	                {
	                    _24827 = g_ScrambledHaltonPermutations.Load<uint>(_24817 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _24827 = g_ScrambledHaltonPermutations.Load<uint>(_24817 * 4 + 0) & 65535u;
	                }
	                uint _24830 = (_12091 / 885481u) % 941u;
	                uint _24832 = (68974u + _24830) / 2u;
	                uint _24850;
	                if ((_24830 & 1u) != 0u)
	                {
	                    _24850 = g_ScrambledHaltonPermutations.Load<uint>(_24832 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _24850 = g_ScrambledHaltonPermutations.Load<uint>(_24832 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_24812 * 885481u) + (_24827 * 941u)) + _24850) * 1.200137655921196255803806707263e-09f;
	                _33360 = true;
	                break;
	            }
	            case 160u:
	            {
	                uint _24758 = 69915u + (_12091 % 947u);
	                uint _24759 = _24758 / 2u;
	                uint _24767;
	                if ((_24758 & 1u) != 0u)
	                {
	                    _24767 = g_ScrambledHaltonPermutations.Load<uint>(_24759 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _24767 = g_ScrambledHaltonPermutations.Load<uint>(_24759 * 4 + 0) & 65535u;
	                }
	                uint _24771 = 69915u + ((_12091 / 947u) % 947u);
	                uint _24772 = _24771 / 2u;
	                uint _24780;
	                if ((_24771 & 1u) != 0u)
	                {
	                    _24780 = g_ScrambledHaltonPermutations.Load<uint>(_24772 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _24780 = g_ScrambledHaltonPermutations.Load<uint>(_24772 * 4 + 0) & 65535u;
	                }
	                uint _24784 = 69915u + ((_12091 / 896809u) % 947u);
	                uint _24785 = _24784 / 2u;
	                uint _24795;
	                if ((_24784 & 1u) != 0u)
	                {
	                    _24795 = g_ScrambledHaltonPermutations.Load<uint>(_24785 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _24795 = g_ScrambledHaltonPermutations.Load<uint>(_24785 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_24767 * 896809u) + (_24780 * 947u)) + _24795) * 1.1774704544720293597492855042219e-09f;
	                _33360 = true;
	                break;
	            }
	            case 161u:
	            {
	                uint _10518 = _12091 % 953u;
	                uint _24721 = (70862u + _10518) / 2u;
	                uint _24729;
	                if ((_10518 & 1u) != 0u)
	                {
	                    _24729 = g_ScrambledHaltonPermutations.Load<uint>(_24721 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _24729 = g_ScrambledHaltonPermutations.Load<uint>(_24721 * 4 + 0) & 65535u;
	                }
	                uint _24732 = (_12091 / 953u) % 953u;
	                uint _24734 = (70862u + _24732) / 2u;
	                uint _24742;
	                if ((_24732 & 1u) != 0u)
	                {
	                    _24742 = g_ScrambledHaltonPermutations.Load<uint>(_24734 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _24742 = g_ScrambledHaltonPermutations.Load<uint>(_24734 * 4 + 0) & 65535u;
	                }
	                uint _10523 = (_12091 / 908209u) % 953u;
	                uint _24746 = (70862u + _10523) / 2u;
	                uint _24754;
	                if ((_10523 & 1u) != 0u)
	                {
	                    _24754 = g_ScrambledHaltonPermutations.Load<uint>(_24746 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _24754 = g_ScrambledHaltonPermutations.Load<uint>(_24746 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_24729 * 908209u) + (_24742 * 953u)) + _24754) * 1.1553703549438409936556126922369e-09f;
	                _33360 = true;
	                break;
	            }
	            case 162u:
	            {
	                uint _24682 = 71815u + (_12091 % 967u);
	                uint _24683 = _24682 / 2u;
	                uint _24691;
	                if ((_24682 & 1u) != 0u)
	                {
	                    _24691 = g_ScrambledHaltonPermutations.Load<uint>(_24683 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _24691 = g_ScrambledHaltonPermutations.Load<uint>(_24683 * 4 + 0) & 65535u;
	                }
	                uint _24695 = 71815u + ((_12091 / 967u) % 967u);
	                uint _24696 = _24695 / 2u;
	                uint _24704;
	                if ((_24695 & 1u) != 0u)
	                {
	                    _24704 = g_ScrambledHaltonPermutations.Load<uint>(_24696 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _24704 = g_ScrambledHaltonPermutations.Load<uint>(_24696 * 4 + 0) & 65535u;
	                }
	                uint _24707 = 71815u + ((_12091 / 935089u) % 967u);
	                uint _24708 = _24707 / 2u;
	                uint _24716;
	                if ((_24707 & 1u) != 0u)
	                {
	                    _24716 = g_ScrambledHaltonPermutations.Load<uint>(_24708 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _24716 = g_ScrambledHaltonPermutations.Load<uint>(_24708 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_24691 * 935089u) + (_24704 * 967u)) + _24716) * 1.1059119175982345950615126639605e-09f;
	                _33360 = true;
	                break;
	            }
	            case 163u:
	            {
	                uint _10500 = _12091 % 971u;
	                uint _24645 = (72782u + _10500) / 2u;
	                uint _24653;
	                if ((_10500 & 1u) != 0u)
	                {
	                    _24653 = g_ScrambledHaltonPermutations.Load<uint>(_24645 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _24653 = g_ScrambledHaltonPermutations.Load<uint>(_24645 * 4 + 0) & 65535u;
	                }
	                uint _24656 = (_12091 / 971u) % 971u;
	                uint _24658 = (72782u + _24656) / 2u;
	                uint _24666;
	                if ((_24656 & 1u) != 0u)
	                {
	                    _24666 = g_ScrambledHaltonPermutations.Load<uint>(_24658 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _24666 = g_ScrambledHaltonPermutations.Load<uint>(_24658 * 4 + 0) & 65535u;
	                }
	                uint _10505 = (_12091 / 942841u) % 971u;
	                uint _24670 = (72782u + _10505) / 2u;
	                uint _24678;
	                if ((_10505 & 1u) != 0u)
	                {
	                    _24678 = g_ScrambledHaltonPermutations.Load<uint>(_24670 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _24678 = g_ScrambledHaltonPermutations.Load<uint>(_24670 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_24653 * 942841u) + (_24666 * 971u)) + _24678) * 1.092300805360935100907227024436e-09f;
	                _33360 = true;
	                break;
	            }
	            case 164u:
	            {
	                uint _24606 = 73753u + (_12091 % 977u);
	                uint _24607 = _24606 / 2u;
	                uint _24615;
	                if ((_24606 & 1u) != 0u)
	                {
	                    _24615 = g_ScrambledHaltonPermutations.Load<uint>(_24607 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _24615 = g_ScrambledHaltonPermutations.Load<uint>(_24607 * 4 + 0) & 65535u;
	                }
	                uint _24619 = 73753u + ((_12091 / 977u) % 977u);
	                uint _24620 = _24619 / 2u;
	                uint _24628;
	                if ((_24619 & 1u) != 0u)
	                {
	                    _24628 = g_ScrambledHaltonPermutations.Load<uint>(_24620 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _24628 = g_ScrambledHaltonPermutations.Load<uint>(_24620 * 4 + 0) & 65535u;
	                }
	                uint _24631 = 73753u + ((_12091 / 954529u) % 977u);
	                uint _24632 = _24631 / 2u;
	                uint _24640;
	                if ((_24631 & 1u) != 0u)
	                {
	                    _24640 = g_ScrambledHaltonPermutations.Load<uint>(_24632 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _24640 = g_ScrambledHaltonPermutations.Load<uint>(_24632 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_24615 * 954529u) + (_24628 * 977u)) + _24640) * 1.072299915527707980800187215209e-09f;
	                _33360 = true;
	                break;
	            }
	            case 165u:
	            {
	                uint _10482 = _12091 % 983u;
	                uint _24569 = (74730u + _10482) / 2u;
	                uint _24577;
	                if ((_10482 & 1u) != 0u)
	                {
	                    _24577 = g_ScrambledHaltonPermutations.Load<uint>(_24569 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _24577 = g_ScrambledHaltonPermutations.Load<uint>(_24569 * 4 + 0) & 65535u;
	                }
	                uint _24580 = (_12091 / 983u) % 983u;
	                uint _24582 = (74730u + _24580) / 2u;
	                uint _24590;
	                if ((_24580 & 1u) != 0u)
	                {
	                    _24590 = g_ScrambledHaltonPermutations.Load<uint>(_24582 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _24590 = g_ScrambledHaltonPermutations.Load<uint>(_24582 * 4 + 0) & 65535u;
	                }
	                uint _10487 = (_12091 / 966289u) % 983u;
	                uint _24594 = (74730u + _10487) / 2u;
	                uint _24602;
	                if ((_10487 & 1u) != 0u)
	                {
	                    _24602 = g_ScrambledHaltonPermutations.Load<uint>(_24594 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _24602 = g_ScrambledHaltonPermutations.Load<uint>(_24594 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_24577 * 966289u) + (_24590 * 983u)) + _24602) * 1.0527843041785445166169665753841e-09f;
	                _33360 = true;
	                break;
	            }
	            case 166u:
	            {
	                uint _24530 = 75713u + (_12091 % 991u);
	                uint _24531 = _24530 / 2u;
	                uint _24539;
	                if ((_24530 & 1u) != 0u)
	                {
	                    _24539 = g_ScrambledHaltonPermutations.Load<uint>(_24531 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _24539 = g_ScrambledHaltonPermutations.Load<uint>(_24531 * 4 + 0) & 65535u;
	                }
	                uint _24543 = 75713u + ((_12091 / 991u) % 991u);
	                uint _24544 = _24543 / 2u;
	                uint _24552;
	                if ((_24543 & 1u) != 0u)
	                {
	                    _24552 = g_ScrambledHaltonPermutations.Load<uint>(_24544 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _24552 = g_ScrambledHaltonPermutations.Load<uint>(_24544 * 4 + 0) & 65535u;
	                }
	                uint _24555 = 75713u + ((_12091 / 982081u) % 991u);
	                uint _24556 = _24555 / 2u;
	                uint _24564;
	                if ((_24555 & 1u) != 0u)
	                {
	                    _24564 = g_ScrambledHaltonPermutations.Load<uint>(_24556 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _24564 = g_ScrambledHaltonPermutations.Load<uint>(_24556 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_24539 * 982081u) + (_24552 * 991u)) + _24564) * 1.0274933126552809881104622036219e-09f;
	                _33360 = true;
	                break;
	            }
	            case 167u:
	            {
	                uint _10464 = _12091 % 997u;
	                uint _24493 = (76704u + _10464) / 2u;
	                uint _24501;
	                if ((_10464 & 1u) != 0u)
	                {
	                    _24501 = g_ScrambledHaltonPermutations.Load<uint>(_24493 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _24501 = g_ScrambledHaltonPermutations.Load<uint>(_24493 * 4 + 0) & 65535u;
	                }
	                uint _24504 = (_12091 / 997u) % 997u;
	                uint _24506 = (76704u + _24504) / 2u;
	                uint _24514;
	                if ((_24504 & 1u) != 0u)
	                {
	                    _24514 = g_ScrambledHaltonPermutations.Load<uint>(_24506 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _24514 = g_ScrambledHaltonPermutations.Load<uint>(_24506 * 4 + 0) & 65535u;
	                }
	                uint _10469 = (_12091 / 994009u) % 997u;
	                uint _24518 = (76704u + _10469) / 2u;
	                uint _24526;
	                if ((_10469 & 1u) != 0u)
	                {
	                    _24526 = g_ScrambledHaltonPermutations.Load<uint>(_24518 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _24526 = g_ScrambledHaltonPermutations.Load<uint>(_24518 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_24501 * 994009u) + (_24514 * 997u)) + _24526) * 1.0090541735507940757088363170624e-09f;
	                _33360 = true;
	                break;
	            }
	            case 168u:
	            {
	                uint _24453 = 77701u + (_12091 % 1009u);
	                uint _24454 = _24453 / 2u;
	                uint _24462;
	                if ((_24453 & 1u) != 0u)
	                {
	                    _24462 = g_ScrambledHaltonPermutations.Load<uint>(_24454 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _24462 = g_ScrambledHaltonPermutations.Load<uint>(_24454 * 4 + 0) & 65535u;
	                }
	                uint _24466 = 77701u + ((_12091 / 1009u) % 1009u);
	                uint _24467 = _24466 / 2u;
	                uint _24475;
	                if ((_24466 & 1u) != 0u)
	                {
	                    _24475 = g_ScrambledHaltonPermutations.Load<uint>(_24467 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _24475 = g_ScrambledHaltonPermutations.Load<uint>(_24467 * 4 + 0) & 65535u;
	                }
	                uint _24479 = 77701u + ((_12091 / 1018081u) % 1009u);
	                uint _24480 = _24479 / 2u;
	                uint _24488;
	                if ((_24479 & 1u) != 0u)
	                {
	                    _24488 = g_ScrambledHaltonPermutations.Load<uint>(_24480 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _24488 = g_ScrambledHaltonPermutations.Load<uint>(_24480 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_24462 * 1018081u) + (_24475 * 1009u)) + _24488) * 9.7347874206121787210577167570591e-10f;
	                _33360 = true;
	                break;
	            }
	            case 169u:
	            {
	                uint _10446 = _12091 % 1013u;
	                uint _24415 = (78710u + _10446) / 2u;
	                uint _24423;
	                if ((_10446 & 1u) != 0u)
	                {
	                    _24423 = g_ScrambledHaltonPermutations.Load<uint>(_24415 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _24423 = g_ScrambledHaltonPermutations.Load<uint>(_24415 * 4 + 0) & 65535u;
	                }
	                uint _24426 = (_12091 / 1013u) % 1013u;
	                uint _24428 = (78710u + _24426) / 2u;
	                uint _24436;
	                if ((_24426 & 1u) != 0u)
	                {
	                    _24436 = g_ScrambledHaltonPermutations.Load<uint>(_24428 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _24436 = g_ScrambledHaltonPermutations.Load<uint>(_24428 * 4 + 0) & 65535u;
	                }
	                uint _10451 = (_12091 / 1026169u) % 1013u;
	                uint _24440 = (78710u + _10451) / 2u;
	                uint _24449;
	                if ((_10451 & 1u) != 0u)
	                {
	                    _24449 = g_ScrambledHaltonPermutations.Load<uint>(_24440 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _24449 = g_ScrambledHaltonPermutations.Load<uint>(_24440 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_24423 * 1026169u) + (_24436 * 1013u)) + _24449) * 9.6199237464844600253854878246784e-10f;
	                _33360 = true;
	                break;
	            }
	            case 170u:
	            {
	                uint _24376 = 79723u + (_12091 % 1019u);
	                uint _24377 = _24376 / 2u;
	                uint _24385;
	                if ((_24376 & 1u) != 0u)
	                {
	                    _24385 = g_ScrambledHaltonPermutations.Load<uint>(_24377 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _24385 = g_ScrambledHaltonPermutations.Load<uint>(_24377 * 4 + 0) & 65535u;
	                }
	                uint _24389 = 79723u + ((_12091 / 1019u) % 1019u);
	                uint _24390 = _24389 / 2u;
	                uint _24398;
	                if ((_24389 & 1u) != 0u)
	                {
	                    _24398 = g_ScrambledHaltonPermutations.Load<uint>(_24390 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _24398 = g_ScrambledHaltonPermutations.Load<uint>(_24390 * 4 + 0) & 65535u;
	                }
	                uint _24401 = 79723u + ((_12091 / 1038361u) % 1019u);
	                uint _24402 = _24401 / 2u;
	                uint _24410;
	                if ((_24401 & 1u) != 0u)
	                {
	                    _24410 = g_ScrambledHaltonPermutations.Load<uint>(_24402 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _24410 = g_ScrambledHaltonPermutations.Load<uint>(_24402 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_24385 * 1038361u) + (_24398 * 1019u)) + _24410) * 9.4509922110574962061946280300617e-10f;
	                _33360 = true;
	                break;
	            }
	            case 171u:
	            {
	                uint _10428 = _12091 % 1021u;
	                uint _24339 = (80742u + _10428) / 2u;
	                uint _24347;
	                if ((_10428 & 1u) != 0u)
	                {
	                    _24347 = g_ScrambledHaltonPermutations.Load<uint>(_24339 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _24347 = g_ScrambledHaltonPermutations.Load<uint>(_24339 * 4 + 0) & 65535u;
	                }
	                uint _24350 = (_12091 / 1021u) % 1021u;
	                uint _24352 = (80742u + _24350) / 2u;
	                uint _24360;
	                if ((_24350 & 1u) != 0u)
	                {
	                    _24360 = g_ScrambledHaltonPermutations.Load<uint>(_24352 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _24360 = g_ScrambledHaltonPermutations.Load<uint>(_24352 * 4 + 0) & 65535u;
	                }
	                uint _10433 = (_12091 / 1042441u) % 1021u;
	                uint _24364 = (80742u + _10433) / 2u;
	                uint _24372;
	                if ((_10433 & 1u) != 0u)
	                {
	                    _24372 = g_ScrambledHaltonPermutations.Load<uint>(_24364 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _24372 = g_ScrambledHaltonPermutations.Load<uint>(_24364 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_24347 * 1042441u) + (_24360 * 1021u)) + _24372) * 9.3955609958840113904443569481373e-10f;
	                _33360 = true;
	                break;
	            }
	            case 172u:
	            {
	                uint _24300 = 81763u + (_12091 % 1031u);
	                uint _24301 = _24300 / 2u;
	                uint _24309;
	                if ((_24300 & 1u) != 0u)
	                {
	                    _24309 = g_ScrambledHaltonPermutations.Load<uint>(_24301 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _24309 = g_ScrambledHaltonPermutations.Load<uint>(_24301 * 4 + 0) & 65535u;
	                }
	                uint _24313 = 81763u + ((_12091 / 1031u) % 1031u);
	                uint _24314 = _24313 / 2u;
	                uint _24322;
	                if ((_24313 & 1u) != 0u)
	                {
	                    _24322 = g_ScrambledHaltonPermutations.Load<uint>(_24314 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _24322 = g_ScrambledHaltonPermutations.Load<uint>(_24314 * 4 + 0) & 65535u;
	                }
	                uint _24325 = 81763u + ((_12091 / 1062961u) % 1031u);
	                uint _24326 = _24325 / 2u;
	                uint _24334;
	                if ((_24325 & 1u) != 0u)
	                {
	                    _24334 = g_ScrambledHaltonPermutations.Load<uint>(_24326 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _24334 = g_ScrambledHaltonPermutations.Load<uint>(_24326 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_24309 * 1062961u) + (_24322 * 1031u)) + _24334) * 9.1248120170916990900877863168716e-10f;
	                _33360 = true;
	                break;
	            }
	            case 173u:
	            {
	                uint _10409 = _12091 % 1033u;
	                uint _24263 = (82794u + _10409) / 2u;
	                uint _24271;
	                if ((_10409 & 1u) != 0u)
	                {
	                    _24271 = g_ScrambledHaltonPermutations.Load<uint>(_24263 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _24271 = g_ScrambledHaltonPermutations.Load<uint>(_24263 * 4 + 0) & 65535u;
	                }
	                uint _24274 = (_12091 / 1033u) % 1033u;
	                uint _24276 = (82794u + _24274) / 2u;
	                uint _24284;
	                if ((_24274 & 1u) != 0u)
	                {
	                    _24284 = g_ScrambledHaltonPermutations.Load<uint>(_24276 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _24284 = g_ScrambledHaltonPermutations.Load<uint>(_24276 * 4 + 0) & 65535u;
	                }
	                uint _10414 = (_12091 / 1067089u) % 1033u;
	                uint _24288 = (82794u + _10414) / 2u;
	                uint _24296;
	                if ((_10414 & 1u) != 0u)
	                {
	                    _24296 = g_ScrambledHaltonPermutations.Load<uint>(_24288 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _24296 = g_ScrambledHaltonPermutations.Load<uint>(_24288 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_24271 * 1067089u) + (_24284 * 1033u)) + _24296) * 9.0719148859719211941410321742296e-10f;
	                _33360 = true;
	                break;
	            }
	            case 174u:
	            {
	                uint _24224 = 83827u + (_12091 % 1039u);
	                uint _24225 = _24224 / 2u;
	                uint _24233;
	                if ((_24224 & 1u) != 0u)
	                {
	                    _24233 = g_ScrambledHaltonPermutations.Load<uint>(_24225 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _24233 = g_ScrambledHaltonPermutations.Load<uint>(_24225 * 4 + 0) & 65535u;
	                }
	                uint _24237 = 83827u + ((_12091 / 1039u) % 1039u);
	                uint _24238 = _24237 / 2u;
	                uint _24246;
	                if ((_24237 & 1u) != 0u)
	                {
	                    _24246 = g_ScrambledHaltonPermutations.Load<uint>(_24238 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _24246 = g_ScrambledHaltonPermutations.Load<uint>(_24238 * 4 + 0) & 65535u;
	                }
	                uint _24249 = 83827u + ((_12091 / 1079521u) % 1039u);
	                uint _24250 = _24249 / 2u;
	                uint _24258;
	                if ((_24249 & 1u) != 0u)
	                {
	                    _24258 = g_ScrambledHaltonPermutations.Load<uint>(_24250 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _24258 = g_ScrambledHaltonPermutations.Load<uint>(_24250 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_24233 * 1079521u) + (_24246 * 1039u)) + _24258) * 8.9156565463710535368591081351042e-10f;
	                _33360 = true;
	                break;
	            }
	            case 175u:
	            {
	                uint _10391 = _12091 % 1049u;
	                uint _24187 = (84866u + _10391) / 2u;
	                uint _24195;
	                if ((_10391 & 1u) != 0u)
	                {
	                    _24195 = g_ScrambledHaltonPermutations.Load<uint>(_24187 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _24195 = g_ScrambledHaltonPermutations.Load<uint>(_24187 * 4 + 0) & 65535u;
	                }
	                uint _24198 = (_12091 / 1049u) % 1049u;
	                uint _24200 = (84866u + _24198) / 2u;
	                uint _24208;
	                if ((_24198 & 1u) != 0u)
	                {
	                    _24208 = g_ScrambledHaltonPermutations.Load<uint>(_24200 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _24208 = g_ScrambledHaltonPermutations.Load<uint>(_24200 * 4 + 0) & 65535u;
	                }
	                uint _10396 = (_12091 / 1100401u) % 1049u;
	                uint _24212 = (84866u + _10396) / 2u;
	                uint _24220;
	                if ((_10396 & 1u) != 0u)
	                {
	                    _24220 = g_ScrambledHaltonPermutations.Load<uint>(_24212 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _24220 = g_ScrambledHaltonPermutations.Load<uint>(_24212 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_24195 * 1100401u) + (_24208 * 1049u)) + _24220) * 8.6631030127293229270435404032469e-10f;
	                _33360 = true;
	                break;
	            }
	            case 176u:
	            {
	                uint _24148 = 85915u + (_12091 % 1051u);
	                uint _24149 = _24148 / 2u;
	                uint _24157;
	                if ((_24148 & 1u) != 0u)
	                {
	                    _24157 = g_ScrambledHaltonPermutations.Load<uint>(_24149 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _24157 = g_ScrambledHaltonPermutations.Load<uint>(_24149 * 4 + 0) & 65535u;
	                }
	                uint _24161 = 85915u + ((_12091 / 1051u) % 1051u);
	                uint _24162 = _24161 / 2u;
	                uint _24170;
	                if ((_24161 & 1u) != 0u)
	                {
	                    _24170 = g_ScrambledHaltonPermutations.Load<uint>(_24162 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _24170 = g_ScrambledHaltonPermutations.Load<uint>(_24162 * 4 + 0) & 65535u;
	                }
	                uint _24173 = 85915u + ((_12091 / 1104601u) % 1051u);
	                uint _24174 = _24173 / 2u;
	                uint _24182;
	                if ((_24173 & 1u) != 0u)
	                {
	                    _24182 = g_ScrambledHaltonPermutations.Load<uint>(_24174 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _24182 = g_ScrambledHaltonPermutations.Load<uint>(_24174 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_24157 * 1104601u) + (_24170 * 1051u)) + _24182) * 8.6137408317199515295214951038361e-10f;
	                _33360 = true;
	                break;
	            }
	            case 177u:
	            {
	                uint _10372 = _12091 % 1061u;
	                uint _24111 = (86966u + _10372) / 2u;
	                uint _24119;
	                if ((_10372 & 1u) != 0u)
	                {
	                    _24119 = g_ScrambledHaltonPermutations.Load<uint>(_24111 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _24119 = g_ScrambledHaltonPermutations.Load<uint>(_24111 * 4 + 0) & 65535u;
	                }
	                uint _24122 = (_12091 / 1061u) % 1061u;
	                uint _24124 = (86966u + _24122) / 2u;
	                uint _24132;
	                if ((_24122 & 1u) != 0u)
	                {
	                    _24132 = g_ScrambledHaltonPermutations.Load<uint>(_24124 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _24132 = g_ScrambledHaltonPermutations.Load<uint>(_24124 * 4 + 0) & 65535u;
	                }
	                uint _10377 = (_12091 / 1125721u) % 1061u;
	                uint _24136 = (86966u + _10377) / 2u;
	                uint _24144;
	                if ((_10377 & 1u) != 0u)
	                {
	                    _24144 = g_ScrambledHaltonPermutations.Load<uint>(_24136 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _24144 = g_ScrambledHaltonPermutations.Load<uint>(_24136 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_24119 * 1125721u) + (_24132 * 1061u)) + _24144) * 8.3724732702350479485176037997007e-10f;
	                _33360 = true;
	                break;
	            }
	            case 178u:
	            {
	                uint _24072 = 88027u + (_12091 % 1063u);
	                uint _24073 = _24072 / 2u;
	                uint _24081;
	                if ((_24072 & 1u) != 0u)
	                {
	                    _24081 = g_ScrambledHaltonPermutations.Load<uint>(_24073 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _24081 = g_ScrambledHaltonPermutations.Load<uint>(_24073 * 4 + 0) & 65535u;
	                }
	                uint _24085 = 88027u + ((_12091 / 1063u) % 1063u);
	                uint _24086 = _24085 / 2u;
	                uint _24094;
	                if ((_24085 & 1u) != 0u)
	                {
	                    _24094 = g_ScrambledHaltonPermutations.Load<uint>(_24086 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _24094 = g_ScrambledHaltonPermutations.Load<uint>(_24086 * 4 + 0) & 65535u;
	                }
	                uint _24097 = 88027u + ((_12091 / 1129969u) % 1063u);
	                uint _24098 = _24097 / 2u;
	                uint _24106;
	                if ((_24097 & 1u) != 0u)
	                {
	                    _24106 = g_ScrambledHaltonPermutations.Load<uint>(_24098 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _24106 = g_ScrambledHaltonPermutations.Load<uint>(_24098 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_24081 * 1129969u) + (_24094 * 1063u)) + _24106) * 8.3253054450338481728977058082819e-10f;
	                _33360 = true;
	                break;
	            }
	            case 179u:
	            {
	                uint _10354 = _12091 % 1069u;
	                uint _24035 = (89090u + _10354) / 2u;
	                uint _24043;
	                if ((_10354 & 1u) != 0u)
	                {
	                    _24043 = g_ScrambledHaltonPermutations.Load<uint>(_24035 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _24043 = g_ScrambledHaltonPermutations.Load<uint>(_24035 * 4 + 0) & 65535u;
	                }
	                uint _24046 = (_12091 / 1069u) % 1069u;
	                uint _24048 = (89090u + _24046) / 2u;
	                uint _24056;
	                if ((_24046 & 1u) != 0u)
	                {
	                    _24056 = g_ScrambledHaltonPermutations.Load<uint>(_24048 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _24056 = g_ScrambledHaltonPermutations.Load<uint>(_24048 * 4 + 0) & 65535u;
	                }
	                uint _10359 = (_12091 / 1142761u) % 1069u;
	                uint _24060 = (89090u + _10359) / 2u;
	                uint _24068;
	                if ((_10359 & 1u) != 0u)
	                {
	                    _24068 = g_ScrambledHaltonPermutations.Load<uint>(_24060 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _24068 = g_ScrambledHaltonPermutations.Load<uint>(_24060 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_24043 * 1142761u) + (_24056 * 1069u)) + _24068) * 8.1859075073964504554169252514839e-10f;
	                _33360 = true;
	                break;
	            }
	            case 180u:
	            {
	                uint _23992 = 90159u + (_12091 % 1087u);
	                uint _23993 = _23992 / 2u;
	                uint _24001;
	                if ((_23992 & 1u) != 0u)
	                {
	                    _24001 = g_ScrambledHaltonPermutations.Load<uint>(_23993 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _24001 = g_ScrambledHaltonPermutations.Load<uint>(_23993 * 4 + 0) & 65535u;
	                }
	                uint _24005 = 90159u + ((_12091 / 1087u) % 1087u);
	                uint _24006 = _24005 / 2u;
	                uint _24018;
	                if ((_24005 & 1u) != 0u)
	                {
	                    _24018 = g_ScrambledHaltonPermutations.Load<uint>(_24006 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _24018 = g_ScrambledHaltonPermutations.Load<uint>(_24006 * 4 + 0) & 65535u;
	                }
	                uint _24021 = 90159u + ((_12091 / 1181569u) % 1087u);
	                uint _24022 = _24021 / 2u;
	                uint _24030;
	                if ((_24021 & 1u) != 0u)
	                {
	                    _24030 = g_ScrambledHaltonPermutations.Load<uint>(_24022 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _24030 = g_ScrambledHaltonPermutations.Load<uint>(_24022 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_24001 * 1181569u) + (_24018 * 1087u)) + _24030) * 7.7859452218831393111031502485275e-10f;
	                _33360 = true;
	                break;
	            }
	            case 181u:
	            {
	                uint _10336 = _12091 % 1091u;
	                uint _23955 = (91246u + _10336) / 2u;
	                uint _23963;
	                if ((_10336 & 1u) != 0u)
	                {
	                    _23963 = g_ScrambledHaltonPermutations.Load<uint>(_23955 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _23963 = g_ScrambledHaltonPermutations.Load<uint>(_23955 * 4 + 0) & 65535u;
	                }
	                uint _23966 = (_12091 / 1091u) % 1091u;
	                uint _23968 = (91246u + _23966) / 2u;
	                uint _23976;
	                if ((_23966 & 1u) != 0u)
	                {
	                    _23976 = g_ScrambledHaltonPermutations.Load<uint>(_23968 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _23976 = g_ScrambledHaltonPermutations.Load<uint>(_23968 * 4 + 0) & 65535u;
	                }
	                uint _10341 = (_12091 / 1190281u) % 1091u;
	                uint _23980 = (91246u + _10341) / 2u;
	                uint _23988;
	                if ((_10341 & 1u) != 0u)
	                {
	                    _23988 = g_ScrambledHaltonPermutations.Load<uint>(_23980 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _23988 = g_ScrambledHaltonPermutations.Load<uint>(_23980 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_23963 * 1190281u) + (_23976 * 1091u)) + _23988) * 7.7006195864370852177671622484922e-10f;
	                _33360 = true;
	                break;
	            }
	            case 182u:
	            {
	                uint _23915 = 92337u + (_12091 % 1093u);
	                uint _23916 = _23915 / 2u;
	                uint _23924;
	                if ((_23915 & 1u) != 0u)
	                {
	                    _23924 = g_ScrambledHaltonPermutations.Load<uint>(_23916 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _23924 = g_ScrambledHaltonPermutations.Load<uint>(_23916 * 4 + 0) & 65535u;
	                }
	                uint _23928 = 92337u + ((_12091 / 1093u) % 1093u);
	                uint _23929 = _23928 / 2u;
	                uint _23937;
	                if ((_23928 & 1u) != 0u)
	                {
	                    _23937 = g_ScrambledHaltonPermutations.Load<uint>(_23929 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _23937 = g_ScrambledHaltonPermutations.Load<uint>(_23929 * 4 + 0) & 65535u;
	                }
	                uint _23940 = 92337u + ((_12091 / 1194649u) % 1093u);
	                uint _23941 = _23940 / 2u;
	                uint _23949;
	                if ((_23940 & 1u) != 0u)
	                {
	                    _23949 = g_ScrambledHaltonPermutations.Load<uint>(_23941 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _23949 = g_ScrambledHaltonPermutations.Load<uint>(_23941 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_23924 * 1194649u) + (_23937 * 1093u)) + _23949) * 7.6584255603862061434483621269464e-10f;
	                _33360 = true;
	                break;
	            }
	            case 183u:
	            {
	                uint _10318 = _12091 % 1097u;
	                uint _23877 = (93430u + _10318) / 2u;
	                uint _23886;
	                if ((_10318 & 1u) != 0u)
	                {
	                    _23886 = g_ScrambledHaltonPermutations.Load<uint>(_23877 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _23886 = g_ScrambledHaltonPermutations.Load<uint>(_23877 * 4 + 0) & 65535u;
	                }
	                uint _23889 = (_12091 / 1097u) % 1097u;
	                uint _23891 = (93430u + _23889) / 2u;
	                uint _23899;
	                if ((_23889 & 1u) != 0u)
	                {
	                    _23899 = g_ScrambledHaltonPermutations.Load<uint>(_23891 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _23899 = g_ScrambledHaltonPermutations.Load<uint>(_23891 * 4 + 0) & 65535u;
	                }
	                uint _10323 = (_12091 / 1203409u) % 1097u;
	                uint _23903 = (93430u + _10323) / 2u;
	                uint _23911;
	                if ((_10323 & 1u) != 0u)
	                {
	                    _23911 = g_ScrambledHaltonPermutations.Load<uint>(_23903 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _23911 = g_ScrambledHaltonPermutations.Load<uint>(_23903 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_23886 * 1203409u) + (_23899 * 1097u)) + _23911) * 7.5749551076143006866914220154285e-10f;
	                _33360 = true;
	                break;
	            }
	            case 184u:
	            {
	                uint _23440 = 94527u + (_12091 % 1103u);
	                uint _23441 = _23440 / 2u;
	                uint _23449;
	                if ((_23440 & 1u) != 0u)
	                {
	                    _23449 = g_ScrambledHaltonPermutations.Load<uint>(_23441 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _23449 = g_ScrambledHaltonPermutations.Load<uint>(_23441 * 4 + 0) & 65535u;
	                }
	                uint _23453 = 94527u + ((_12091 / 1103u) % 1103u);
	                uint _23454 = _23453 / 2u;
	                uint _23462;
	                if ((_23453 & 1u) != 0u)
	                {
	                    _23462 = g_ScrambledHaltonPermutations.Load<uint>(_23454 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _23462 = g_ScrambledHaltonPermutations.Load<uint>(_23454 * 4 + 0) & 65535u;
	                }
	                uint _23464 = 94527u + ((_12091 / 1216609u) % 1103u);
	                uint _23465 = _23464 / 2u;
	                uint _23872;
	                if ((_23464 & 1u) != 0u)
	                {
	                    _23872 = g_ScrambledHaltonPermutations.Load<uint>(_23465 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _23872 = g_ScrambledHaltonPermutations.Load<uint>(_23465 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_23449 * 1216609u) + (_23462 * 1103u)) + _23872) * 7.45200956497882316398317925632e-10f;
	                _33360 = true;
	                break;
	            }
	            case 185u:
	            {
	                uint _10300 = _12091 % 1109u;
	                uint _23404 = (95630u + _10300) / 2u;
	                uint _23412;
	                if ((_10300 & 1u) != 0u)
	                {
	                    _23412 = g_ScrambledHaltonPermutations.Load<uint>(_23404 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _23412 = g_ScrambledHaltonPermutations.Load<uint>(_23404 * 4 + 0) & 65535u;
	                }
	                uint _23415 = (_12091 / 1109u) % 1109u;
	                uint _23417 = (95630u + _23415) / 2u;
	                uint _23425;
	                if ((_23415 & 1u) != 0u)
	                {
	                    _23425 = g_ScrambledHaltonPermutations.Load<uint>(_23417 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _23425 = g_ScrambledHaltonPermutations.Load<uint>(_23417 * 4 + 0) & 65535u;
	                }
	                uint _10305 = (_12091 / 1229881u) % 1109u;
	                uint _23428 = (95630u + _10305) / 2u;
	                uint _23436;
	                if ((_10305 & 1u) != 0u)
	                {
	                    _23436 = g_ScrambledHaltonPermutations.Load<uint>(_23428 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _23436 = g_ScrambledHaltonPermutations.Load<uint>(_23428 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_23412 * 1229881u) + (_23425 * 1109u)) + _23436) * 7.3317102389225397018890362232924e-10f;
	                _33360 = true;
	                break;
	            }
	            case 186u:
	            {
	                uint _23366 = 96739u + (_12091 % 1117u);
	                uint _23367 = _23366 / 2u;
	                uint _23375;
	                if ((_23366 & 1u) != 0u)
	                {
	                    _23375 = g_ScrambledHaltonPermutations.Load<uint>(_23367 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _23375 = g_ScrambledHaltonPermutations.Load<uint>(_23367 * 4 + 0) & 65535u;
	                }
	                uint _23379 = 96739u + ((_12091 / 1117u) % 1117u);
	                uint _23380 = _23379 / 2u;
	                uint _23388;
	                if ((_23379 & 1u) != 0u)
	                {
	                    _23388 = g_ScrambledHaltonPermutations.Load<uint>(_23380 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _23388 = g_ScrambledHaltonPermutations.Load<uint>(_23380 * 4 + 0) & 65535u;
	                }
	                uint _23390 = 96739u + ((_12091 / 1247689u) % 1117u);
	                uint _23391 = _23390 / 2u;
	                uint _23399;
	                if ((_23390 & 1u) != 0u)
	                {
	                    _23399 = g_ScrambledHaltonPermutations.Load<uint>(_23391 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _23399 = g_ScrambledHaltonPermutations.Load<uint>(_23391 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_23375 * 1247689u) + (_23388 * 1117u)) + _23399) * 7.1753059049939338365220464766026e-10f;
	                _33360 = true;
	                break;
	            }
	            case 187u:
	            {
	                uint _10282 = _12091 % 1123u;
	                uint _23330 = (97856u + _10282) / 2u;
	                uint _23338;
	                if ((_10282 & 1u) != 0u)
	                {
	                    _23338 = g_ScrambledHaltonPermutations.Load<uint>(_23330 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _23338 = g_ScrambledHaltonPermutations.Load<uint>(_23330 * 4 + 0) & 65535u;
	                }
	                uint _23341 = (_12091 / 1123u) % 1123u;
	                uint _23343 = (97856u + _23341) / 2u;
	                uint _23351;
	                if ((_23341 & 1u) != 0u)
	                {
	                    _23351 = g_ScrambledHaltonPermutations.Load<uint>(_23343 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _23351 = g_ScrambledHaltonPermutations.Load<uint>(_23343 * 4 + 0) & 65535u;
	                }
	                uint _10287 = (_12091 / 1261129u) % 1123u;
	                uint _23354 = (97856u + _10287) / 2u;
	                uint _23362;
	                if ((_10287 & 1u) != 0u)
	                {
	                    _23362 = g_ScrambledHaltonPermutations.Load<uint>(_23354 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _23362 = g_ScrambledHaltonPermutations.Load<uint>(_23354 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_23338 * 1261129u) + (_23351 * 1123u)) + _23362) * 7.06091018987109464433160610497e-10f;
	                _33360 = true;
	                break;
	            }
	            case 188u:
	            {
	                uint _23292 = 98979u + (_12091 % 1129u);
	                uint _23293 = _23292 / 2u;
	                uint _23301;
	                if ((_23292 & 1u) != 0u)
	                {
	                    _23301 = g_ScrambledHaltonPermutations.Load<uint>(_23293 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _23301 = g_ScrambledHaltonPermutations.Load<uint>(_23293 * 4 + 0) & 65535u;
	                }
	                uint _23305 = 98979u + ((_12091 / 1129u) % 1129u);
	                uint _23306 = _23305 / 2u;
	                uint _23314;
	                if ((_23305 & 1u) != 0u)
	                {
	                    _23314 = g_ScrambledHaltonPermutations.Load<uint>(_23306 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _23314 = g_ScrambledHaltonPermutations.Load<uint>(_23306 * 4 + 0) & 65535u;
	                }
	                uint _23316 = 98979u + ((_12091 / 1274641u) % 1129u);
	                uint _23317 = _23316 / 2u;
	                uint _23325;
	                if ((_23316 & 1u) != 0u)
	                {
	                    _23325 = g_ScrambledHaltonPermutations.Load<uint>(_23317 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _23325 = g_ScrambledHaltonPermutations.Load<uint>(_23317 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_23301 * 1274641u) + (_23314 * 1129u)) + _23325) * 6.9489330956074013556644786149263e-10f;
	                _33360 = true;
	                break;
	            }
	            case 189u:
	            {
	                uint _10264 = _12091 % 1151u;
	                uint _23256 = (100108u + _10264) / 2u;
	                uint _23264;
	                if ((_10264 & 1u) != 0u)
	                {
	                    _23264 = g_ScrambledHaltonPermutations.Load<uint>(_23256 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _23264 = g_ScrambledHaltonPermutations.Load<uint>(_23256 * 4 + 0) & 65535u;
	                }
	                uint _23267 = (_12091 / 1151u) % 1151u;
	                uint _23269 = (100108u + _23267) / 2u;
	                uint _23277;
	                if ((_23267 & 1u) != 0u)
	                {
	                    _23277 = g_ScrambledHaltonPermutations.Load<uint>(_23269 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _23277 = g_ScrambledHaltonPermutations.Load<uint>(_23269 * 4 + 0) & 65535u;
	                }
	                uint _10269 = (_12091 / 1324801u) % 1151u;
	                uint _23280 = (100108u + _10269) / 2u;
	                uint _23288;
	                if ((_10269 & 1u) != 0u)
	                {
	                    _23288 = g_ScrambledHaltonPermutations.Load<uint>(_23280 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _23288 = g_ScrambledHaltonPermutations.Load<uint>(_23280 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_23264 * 1324801u) + (_23277 * 1151u)) + _23288) * 6.5580385566477161773946136236191e-10f;
	                _33360 = true;
	                break;
	            }
	            case 190u:
	            {
	                uint _23218 = 101259u + (_12091 % 1153u);
	                uint _23219 = _23218 / 2u;
	                uint _23227;
	                if ((_23218 & 1u) != 0u)
	                {
	                    _23227 = g_ScrambledHaltonPermutations.Load<uint>(_23219 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _23227 = g_ScrambledHaltonPermutations.Load<uint>(_23219 * 4 + 0) & 65535u;
	                }
	                uint _23231 = 101259u + ((_12091 / 1153u) % 1153u);
	                uint _23232 = _23231 / 2u;
	                uint _23240;
	                if ((_23231 & 1u) != 0u)
	                {
	                    _23240 = g_ScrambledHaltonPermutations.Load<uint>(_23232 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _23240 = g_ScrambledHaltonPermutations.Load<uint>(_23232 * 4 + 0) & 65535u;
	                }
	                uint _23242 = 101259u + ((_12091 / 1329409u) % 1153u);
	                uint _23243 = _23242 / 2u;
	                uint _23251;
	                if ((_23242 & 1u) != 0u)
	                {
	                    _23251 = g_ScrambledHaltonPermutations.Load<uint>(_23243 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _23251 = g_ScrambledHaltonPermutations.Load<uint>(_23243 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_23227 * 1329409u) + (_23240 * 1153u)) + _23251) * 6.5239708080255809363734442740679e-10f;
	                _33360 = true;
	                break;
	            }
	            case 191u:
	            {
	                uint _10246 = _12091 % 1163u;
	                uint _23182 = (102412u + _10246) / 2u;
	                uint _23190;
	                if ((_10246 & 1u) != 0u)
	                {
	                    _23190 = g_ScrambledHaltonPermutations.Load<uint>(_23182 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _23190 = g_ScrambledHaltonPermutations.Load<uint>(_23182 * 4 + 0) & 65535u;
	                }
	                uint _23193 = (_12091 / 1163u) % 1163u;
	                uint _23195 = (102412u + _23193) / 2u;
	                uint _23203;
	                if ((_23193 & 1u) != 0u)
	                {
	                    _23203 = g_ScrambledHaltonPermutations.Load<uint>(_23195 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _23203 = g_ScrambledHaltonPermutations.Load<uint>(_23195 * 4 + 0) & 65535u;
	                }
	                uint _10251 = (_12091 / 1352569u) % 1163u;
	                uint _23206 = (102412u + _10251) / 2u;
	                uint _23214;
	                if ((_10251 & 1u) != 0u)
	                {
	                    _23214 = g_ScrambledHaltonPermutations.Load<uint>(_23206 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _23214 = g_ScrambledHaltonPermutations.Load<uint>(_23206 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_23190 * 1352569u) + (_23203 * 1163u)) + _23214) * 6.3571259367734000989003106951714e-10f;
	                _33360 = true;
	                break;
	            }
	            case 192u:
	            {
	                uint _23144 = 103575u + (_12091 % 1171u);
	                uint _23145 = _23144 / 2u;
	                uint _23153;
	                if ((_23144 & 1u) != 0u)
	                {
	                    _23153 = g_ScrambledHaltonPermutations.Load<uint>(_23145 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _23153 = g_ScrambledHaltonPermutations.Load<uint>(_23145 * 4 + 0) & 65535u;
	                }
	                uint _23157 = 103575u + ((_12091 / 1171u) % 1171u);
	                uint _23158 = _23157 / 2u;
	                uint _23166;
	                if ((_23157 & 1u) != 0u)
	                {
	                    _23166 = g_ScrambledHaltonPermutations.Load<uint>(_23158 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _23166 = g_ScrambledHaltonPermutations.Load<uint>(_23158 * 4 + 0) & 65535u;
	                }
	                uint _23168 = 103575u + ((_12091 / 1371241u) % 1171u);
	                uint _23169 = _23168 / 2u;
	                uint _23177;
	                if ((_23168 & 1u) != 0u)
	                {
	                    _23177 = g_ScrambledHaltonPermutations.Load<uint>(_23169 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _23177 = g_ScrambledHaltonPermutations.Load<uint>(_23169 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_23153 * 1371241u) + (_23166 * 1171u)) + _23177) * 6.2277222268036780405964236706495e-10f;
	                _33360 = true;
	                break;
	            }
	            case 193u:
	            {
	                uint _10228 = _12091 % 1181u;
	                uint _23107 = (104746u + _10228) / 2u;
	                uint _23115;
	                if ((_10228 & 1u) != 0u)
	                {
	                    _23115 = g_ScrambledHaltonPermutations.Load<uint>(_23107 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _23115 = g_ScrambledHaltonPermutations.Load<uint>(_23107 * 4 + 0) & 65535u;
	                }
	                uint _23118 = (_12091 / 1181u) % 1181u;
	                uint _23120 = (104746u + _23118) / 2u;
	                uint _23128;
	                if ((_23118 & 1u) != 0u)
	                {
	                    _23128 = g_ScrambledHaltonPermutations.Load<uint>(_23120 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _23128 = g_ScrambledHaltonPermutations.Load<uint>(_23120 * 4 + 0) & 65535u;
	                }
	                uint _10233 = (_12091 / 1394761u) % 1181u;
	                uint _23131 = (104746u + _10233) / 2u;
	                uint _23140;
	                if ((_10233 & 1u) != 0u)
	                {
	                    _23140 = g_ScrambledHaltonPermutations.Load<uint>(_23131 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _23140 = g_ScrambledHaltonPermutations.Load<uint>(_23131 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_23115 * 1394761u) + (_23128 * 1181u)) + _23140) * 6.0708604809889266107347793877125e-10f;
	                _33360 = true;
	                break;
	            }
	            case 194u:
	            {
	                uint _23069 = 105927u + (_12091 % 1187u);
	                uint _23070 = _23069 / 2u;
	                uint _23078;
	                if ((_23069 & 1u) != 0u)
	                {
	                    _23078 = g_ScrambledHaltonPermutations.Load<uint>(_23070 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _23078 = g_ScrambledHaltonPermutations.Load<uint>(_23070 * 4 + 0) & 65535u;
	                }
	                uint _23082 = 105927u + ((_12091 / 1187u) % 1187u);
	                uint _23083 = _23082 / 2u;
	                uint _23091;
	                if ((_23082 & 1u) != 0u)
	                {
	                    _23091 = g_ScrambledHaltonPermutations.Load<uint>(_23083 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _23091 = g_ScrambledHaltonPermutations.Load<uint>(_23083 * 4 + 0) & 65535u;
	                }
	                uint _23093 = 105927u + ((_12091 / 1408969u) % 1187u);
	                uint _23094 = _23093 / 2u;
	                uint _23102;
	                if ((_23093 & 1u) != 0u)
	                {
	                    _23102 = g_ScrambledHaltonPermutations.Load<uint>(_23094 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _23102 = g_ScrambledHaltonPermutations.Load<uint>(_23094 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_23078 * 1408969u) + (_23091 * 1187u)) + _23102) * 5.9792648610113019458367489278316e-10f;
	                _33360 = true;
	                break;
	            }
	            case 195u:
	            {
	                uint _10210 = _12091 % 1193u;
	                uint _23033 = (107114u + _10210) / 2u;
	                uint _23041;
	                if ((_10210 & 1u) != 0u)
	                {
	                    _23041 = g_ScrambledHaltonPermutations.Load<uint>(_23033 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _23041 = g_ScrambledHaltonPermutations.Load<uint>(_23033 * 4 + 0) & 65535u;
	                }
	                uint _23044 = (_12091 / 1193u) % 1193u;
	                uint _23046 = (107114u + _23044) / 2u;
	                uint _23054;
	                if ((_23044 & 1u) != 0u)
	                {
	                    _23054 = g_ScrambledHaltonPermutations.Load<uint>(_23046 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _23054 = g_ScrambledHaltonPermutations.Load<uint>(_23046 * 4 + 0) & 65535u;
	                }
	                uint _10215 = (_12091 / 1423249u) % 1193u;
	                uint _23057 = (107114u + _10215) / 2u;
	                uint _23065;
	                if ((_10215 & 1u) != 0u)
	                {
	                    _23065 = g_ScrambledHaltonPermutations.Load<uint>(_23057 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _23065 = g_ScrambledHaltonPermutations.Load<uint>(_23057 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_23041 * 1423249u) + (_23054 * 1193u)) + _23065) * 5.8895027743588457269652280956507e-10f;
	                _33360 = true;
	                break;
	            }
	            case 196u:
	            {
	                uint _22995 = 108307u + (_12091 % 1201u);
	                uint _22996 = _22995 / 2u;
	                uint _23004;
	                if ((_22995 & 1u) != 0u)
	                {
	                    _23004 = g_ScrambledHaltonPermutations.Load<uint>(_22996 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _23004 = g_ScrambledHaltonPermutations.Load<uint>(_22996 * 4 + 0) & 65535u;
	                }
	                uint _23008 = 108307u + ((_12091 / 1201u) % 1201u);
	                uint _23009 = _23008 / 2u;
	                uint _23017;
	                if ((_23008 & 1u) != 0u)
	                {
	                    _23017 = g_ScrambledHaltonPermutations.Load<uint>(_23009 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _23017 = g_ScrambledHaltonPermutations.Load<uint>(_23009 * 4 + 0) & 65535u;
	                }
	                uint _23019 = 108307u + ((_12091 / 1442401u) % 1201u);
	                uint _23020 = _23019 / 2u;
	                uint _23028;
	                if ((_23019 & 1u) != 0u)
	                {
	                    _23028 = g_ScrambledHaltonPermutations.Load<uint>(_23020 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _23028 = g_ScrambledHaltonPermutations.Load<uint>(_23020 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_23004 * 1442401u) + (_23017 * 1201u)) + _23028) * 5.7725929591967428677889984101057e-10f;
	                _33360 = true;
	                break;
	            }
	            case 197u:
	            {
	                uint _10192 = _12091 % 1213u;
	                uint _22959 = (109508u + _10192) / 2u;
	                uint _22967;
	                if ((_10192 & 1u) != 0u)
	                {
	                    _22967 = g_ScrambledHaltonPermutations.Load<uint>(_22959 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _22967 = g_ScrambledHaltonPermutations.Load<uint>(_22959 * 4 + 0) & 65535u;
	                }
	                uint _22970 = (_12091 / 1213u) % 1213u;
	                uint _22972 = (109508u + _22970) / 2u;
	                uint _22980;
	                if ((_22970 & 1u) != 0u)
	                {
	                    _22980 = g_ScrambledHaltonPermutations.Load<uint>(_22972 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _22980 = g_ScrambledHaltonPermutations.Load<uint>(_22972 * 4 + 0) & 65535u;
	                }
	                uint _10197 = (_12091 / 1471369u) % 1213u;
	                uint _22983 = (109508u + _10197) / 2u;
	                uint _22991;
	                if ((_10197 & 1u) != 0u)
	                {
	                    _22991 = g_ScrambledHaltonPermutations.Load<uint>(_22983 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _22991 = g_ScrambledHaltonPermutations.Load<uint>(_22983 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_22967 * 1471369u) + (_22980 * 1213u)) + _22991) * 5.6029603179297282622428610920906e-10f;
	                _33360 = true;
	                break;
	            }
	            case 198u:
	            {
	                uint _22921 = 110721u + (_12091 % 1217u);
	                uint _22922 = _22921 / 2u;
	                uint _22930;
	                if ((_22921 & 1u) != 0u)
	                {
	                    _22930 = g_ScrambledHaltonPermutations.Load<uint>(_22922 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _22930 = g_ScrambledHaltonPermutations.Load<uint>(_22922 * 4 + 0) & 65535u;
	                }
	                uint _22934 = 110721u + ((_12091 / 1217u) % 1217u);
	                uint _22935 = _22934 / 2u;
	                uint _22943;
	                if ((_22934 & 1u) != 0u)
	                {
	                    _22943 = g_ScrambledHaltonPermutations.Load<uint>(_22935 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _22943 = g_ScrambledHaltonPermutations.Load<uint>(_22935 * 4 + 0) & 65535u;
	                }
	                uint _22945 = 110721u + ((_12091 / 1481089u) % 1217u);
	                uint _22946 = _22945 / 2u;
	                uint _22954;
	                if ((_22945 & 1u) != 0u)
	                {
	                    _22954 = g_ScrambledHaltonPermutations.Load<uint>(_22946 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _22954 = g_ScrambledHaltonPermutations.Load<uint>(_22946 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_22930 * 1481089u) + (_22943 * 1217u)) + _22954) * 5.547894366131345122994389384985e-10f;
	                _33360 = true;
	                break;
	            }
	            case 199u:
	            {
	                uint _10174 = _12091 % 1223u;
	                uint _22885 = (111938u + _10174) / 2u;
	                uint _22893;
	                if ((_10174 & 1u) != 0u)
	                {
	                    _22893 = g_ScrambledHaltonPermutations.Load<uint>(_22885 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _22893 = g_ScrambledHaltonPermutations.Load<uint>(_22885 * 4 + 0) & 65535u;
	                }
	                uint _22896 = (_12091 / 1223u) % 1223u;
	                uint _22898 = (111938u + _22896) / 2u;
	                uint _22906;
	                if ((_22896 & 1u) != 0u)
	                {
	                    _22906 = g_ScrambledHaltonPermutations.Load<uint>(_22898 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _22906 = g_ScrambledHaltonPermutations.Load<uint>(_22898 * 4 + 0) & 65535u;
	                }
	                uint _10179 = (_12091 / 1495729u) % 1223u;
	                uint _22909 = (111938u + _10179) / 2u;
	                uint _22917;
	                if ((_10179 & 1u) != 0u)
	                {
	                    _22917 = g_ScrambledHaltonPermutations.Load<uint>(_22909 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _22917 = g_ScrambledHaltonPermutations.Load<uint>(_22909 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_22893 * 1495729u) + (_22906 * 1223u)) + _22917) * 5.4666415838511284164269454777241e-10f;
	                _33360 = true;
	                break;
	            }
	            case 200u:
	            {
	                uint _22847 = 113161u + (_12091 % 1229u);
	                uint _22848 = _22847 / 2u;
	                uint _22856;
	                if ((_22847 & 1u) != 0u)
	                {
	                    _22856 = g_ScrambledHaltonPermutations.Load<uint>(_22848 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _22856 = g_ScrambledHaltonPermutations.Load<uint>(_22848 * 4 + 0) & 65535u;
	                }
	                uint _22860 = 113161u + ((_12091 / 1229u) % 1229u);
	                uint _22861 = _22860 / 2u;
	                uint _22869;
	                if ((_22860 & 1u) != 0u)
	                {
	                    _22869 = g_ScrambledHaltonPermutations.Load<uint>(_22861 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _22869 = g_ScrambledHaltonPermutations.Load<uint>(_22861 * 4 + 0) & 65535u;
	                }
	                uint _22871 = 113161u + ((_12091 / 1510441u) % 1229u);
	                uint _22872 = _22871 / 2u;
	                uint _22880;
	                if ((_22871 & 1u) != 0u)
	                {
	                    _22880 = g_ScrambledHaltonPermutations.Load<uint>(_22872 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _22880 = g_ScrambledHaltonPermutations.Load<uint>(_22872 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_22856 * 1510441u) + (_22869 * 1229u)) + _22880) * 5.3869664284889040573034435510635e-10f;
	                _33360 = true;
	                break;
	            }
	            case 201u:
	            {
	                uint _10156 = _12091 % 1231u;
	                uint _22811 = (114390u + _10156) / 2u;
	                uint _22819;
	                if ((_10156 & 1u) != 0u)
	                {
	                    _22819 = g_ScrambledHaltonPermutations.Load<uint>(_22811 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _22819 = g_ScrambledHaltonPermutations.Load<uint>(_22811 * 4 + 0) & 65535u;
	                }
	                uint _22822 = (_12091 / 1231u) % 1231u;
	                uint _22824 = (114390u + _22822) / 2u;
	                uint _22832;
	                if ((_22822 & 1u) != 0u)
	                {
	                    _22832 = g_ScrambledHaltonPermutations.Load<uint>(_22824 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _22832 = g_ScrambledHaltonPermutations.Load<uint>(_22824 * 4 + 0) & 65535u;
	                }
	                uint _10161 = (_12091 / 1515361u) % 1231u;
	                uint _22835 = (114390u + _10161) / 2u;
	                uint _22843;
	                if ((_10161 & 1u) != 0u)
	                {
	                    _22843 = g_ScrambledHaltonPermutations.Load<uint>(_22835 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _22843 = g_ScrambledHaltonPermutations.Load<uint>(_22835 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_22819 * 1515361u) + (_22832 * 1231u)) + _22843) * 5.3607529526544794862275011837482e-10f;
	                _33360 = true;
	                break;
	            }
	            case 202u:
	            {
	                uint _22773 = 115621u + (_12091 % 1237u);
	                uint _22774 = _22773 / 2u;
	                uint _22782;
	                if ((_22773 & 1u) != 0u)
	                {
	                    _22782 = g_ScrambledHaltonPermutations.Load<uint>(_22774 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _22782 = g_ScrambledHaltonPermutations.Load<uint>(_22774 * 4 + 0) & 65535u;
	                }
	                uint _22786 = 115621u + ((_12091 / 1237u) % 1237u);
	                uint _22787 = _22786 / 2u;
	                uint _22795;
	                if ((_22786 & 1u) != 0u)
	                {
	                    _22795 = g_ScrambledHaltonPermutations.Load<uint>(_22787 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _22795 = g_ScrambledHaltonPermutations.Load<uint>(_22787 * 4 + 0) & 65535u;
	                }
	                uint _22797 = 115621u + ((_12091 / 1530169u) % 1237u);
	                uint _22798 = _22797 / 2u;
	                uint _22806;
	                if ((_22797 & 1u) != 0u)
	                {
	                    _22806 = g_ScrambledHaltonPermutations.Load<uint>(_22798 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _22806 = g_ScrambledHaltonPermutations.Load<uint>(_22798 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_22782 * 1530169u) + (_22795 * 1237u)) + _22806) * 5.2831244934381516031862702220678e-10f;
	                _33360 = true;
	                break;
	            }
	            case 203u:
	            {
	                uint _10138 = _12091 % 1249u;
	                uint _22737 = (116858u + _10138) / 2u;
	                uint _22745;
	                if ((_10138 & 1u) != 0u)
	                {
	                    _22745 = g_ScrambledHaltonPermutations.Load<uint>(_22737 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _22745 = g_ScrambledHaltonPermutations.Load<uint>(_22737 * 4 + 0) & 65535u;
	                }
	                uint _22748 = (_12091 / 1249u) % 1249u;
	                uint _22750 = (116858u + _22748) / 2u;
	                uint _22758;
	                if ((_22748 & 1u) != 0u)
	                {
	                    _22758 = g_ScrambledHaltonPermutations.Load<uint>(_22750 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _22758 = g_ScrambledHaltonPermutations.Load<uint>(_22750 * 4 + 0) & 65535u;
	                }
	                uint _10143 = (_12091 / 1560001u) % 1249u;
	                uint _22761 = (116858u + _10143) / 2u;
	                uint _22769;
	                if ((_10143 & 1u) != 0u)
	                {
	                    _22769 = g_ScrambledHaltonPermutations.Load<uint>(_22761 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _22769 = g_ScrambledHaltonPermutations.Load<uint>(_22761 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_22745 * 1560001u) + (_22758 * 1249u)) + _22769) * 5.1323073568809718381089624017477e-10f;
	                _33360 = true;
	                break;
	            }
	            case 204u:
	            {
	                uint _22699 = 118107u + (_12091 % 1259u);
	                uint _22700 = _22699 / 2u;
	                uint _22708;
	                if ((_22699 & 1u) != 0u)
	                {
	                    _22708 = g_ScrambledHaltonPermutations.Load<uint>(_22700 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _22708 = g_ScrambledHaltonPermutations.Load<uint>(_22700 * 4 + 0) & 65535u;
	                }
	                uint _22712 = 118107u + ((_12091 / 1259u) % 1259u);
	                uint _22713 = _22712 / 2u;
	                uint _22721;
	                if ((_22712 & 1u) != 0u)
	                {
	                    _22721 = g_ScrambledHaltonPermutations.Load<uint>(_22713 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _22721 = g_ScrambledHaltonPermutations.Load<uint>(_22713 * 4 + 0) & 65535u;
	                }
	                uint _22723 = 118107u + ((_12091 / 1585081u) % 1259u);
	                uint _22724 = _22723 / 2u;
	                uint _22732;
	                if ((_22723 & 1u) != 0u)
	                {
	                    _22732 = g_ScrambledHaltonPermutations.Load<uint>(_22724 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _22732 = g_ScrambledHaltonPermutations.Load<uint>(_22724 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_22708 * 1585081u) + (_22721 * 1259u)) + _22732) * 5.0109810745269101062149275094271e-10f;
	                _33360 = true;
	                break;
	            }
	            case 205u:
	            {
	                uint _10120 = _12091 % 1277u;
	                uint _22663 = (119366u + _10120) / 2u;
	                uint _22671;
	                if ((_10120 & 1u) != 0u)
	                {
	                    _22671 = g_ScrambledHaltonPermutations.Load<uint>(_22663 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _22671 = g_ScrambledHaltonPermutations.Load<uint>(_22663 * 4 + 0) & 65535u;
	                }
	                uint _22674 = (_12091 / 1277u) % 1277u;
	                uint _22676 = (119366u + _22674) / 2u;
	                uint _22684;
	                if ((_22674 & 1u) != 0u)
	                {
	                    _22684 = g_ScrambledHaltonPermutations.Load<uint>(_22676 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _22684 = g_ScrambledHaltonPermutations.Load<uint>(_22676 * 4 + 0) & 65535u;
	                }
	                uint _10125 = (_12091 / 1630729u) % 1277u;
	                uint _22687 = (119366u + _10125) / 2u;
	                uint _22695;
	                if ((_10125 & 1u) != 0u)
	                {
	                    _22695 = g_ScrambledHaltonPermutations.Load<uint>(_22687 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _22695 = g_ScrambledHaltonPermutations.Load<uint>(_22687 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_22671 * 1630729u) + (_22684 * 1277u)) + _22695) * 4.8020565301953865855466574430466e-10f;
	                _33360 = true;
	                break;
	            }
	            case 206u:
	            {
	                uint _22625 = 120643u + (_12091 % 1279u);
	                uint _22626 = _22625 / 2u;
	                uint _22634;
	                if ((_22625 & 1u) != 0u)
	                {
	                    _22634 = g_ScrambledHaltonPermutations.Load<uint>(_22626 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _22634 = g_ScrambledHaltonPermutations.Load<uint>(_22626 * 4 + 0) & 65535u;
	                }
	                uint _22638 = 120643u + ((_12091 / 1279u) % 1279u);
	                uint _22639 = _22638 / 2u;
	                uint _22647;
	                if ((_22638 & 1u) != 0u)
	                {
	                    _22647 = g_ScrambledHaltonPermutations.Load<uint>(_22639 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _22647 = g_ScrambledHaltonPermutations.Load<uint>(_22639 * 4 + 0) & 65535u;
	                }
	                uint _22649 = 120643u + ((_12091 / 1635841u) % 1279u);
	                uint _22650 = _22649 / 2u;
	                uint _22658;
	                if ((_22649 & 1u) != 0u)
	                {
	                    _22658 = g_ScrambledHaltonPermutations.Load<uint>(_22650 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _22658 = g_ScrambledHaltonPermutations.Load<uint>(_22650 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_22634 * 1635841u) + (_22647 * 1279u)) + _22658) * 4.7795645219395055391942150890827e-10f;
	                _33360 = true;
	                break;
	            }
	            case 207u:
	            {
	                uint _10102 = _12091 % 1283u;
	                uint _22581 = (121922u + _10102) / 2u;
	                uint _22589;
	                if ((_10102 & 1u) != 0u)
	                {
	                    _22589 = g_ScrambledHaltonPermutations.Load<uint>(_22581 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _22589 = g_ScrambledHaltonPermutations.Load<uint>(_22581 * 4 + 0) & 65535u;
	                }
	                uint _22592 = (_12091 / 1283u) % 1283u;
	                uint _22594 = (121922u + _22592) / 2u;
	                uint _22602;
	                if ((_22592 & 1u) != 0u)
	                {
	                    _22602 = g_ScrambledHaltonPermutations.Load<uint>(_22594 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _22602 = g_ScrambledHaltonPermutations.Load<uint>(_22594 * 4 + 0) & 65535u;
	                }
	                uint _10107 = (_12091 / 1646089u) % 1283u;
	                uint _22605 = (121922u + _10107) / 2u;
	                uint _22621;
	                if ((_10107 & 1u) != 0u)
	                {
	                    _22621 = g_ScrambledHaltonPermutations.Load<uint>(_22605 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _22621 = g_ScrambledHaltonPermutations.Load<uint>(_22605 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_22589 * 1646089u) + (_22602 * 1283u)) + _22621) * 4.7350001697310517556616105139256e-10f;
	                _33360 = true;
	                break;
	            }
	            case 208u:
	            {
	                uint _22543 = 123205u + (_12091 % 1289u);
	                uint _22544 = _22543 / 2u;
	                uint _22552;
	                if ((_22543 & 1u) != 0u)
	                {
	                    _22552 = g_ScrambledHaltonPermutations.Load<uint>(_22544 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _22552 = g_ScrambledHaltonPermutations.Load<uint>(_22544 * 4 + 0) & 65535u;
	                }
	                uint _22556 = 123205u + ((_12091 / 1289u) % 1289u);
	                uint _22557 = _22556 / 2u;
	                uint _22565;
	                if ((_22556 & 1u) != 0u)
	                {
	                    _22565 = g_ScrambledHaltonPermutations.Load<uint>(_22557 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _22565 = g_ScrambledHaltonPermutations.Load<uint>(_22557 * 4 + 0) & 65535u;
	                }
	                uint _22567 = 123205u + ((_12091 / 1661521u) % 1289u);
	                uint _22568 = _22567 / 2u;
	                uint _22576;
	                if ((_22567 & 1u) != 0u)
	                {
	                    _22576 = g_ScrambledHaltonPermutations.Load<uint>(_22568 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _22576 = g_ScrambledHaltonPermutations.Load<uint>(_22568 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_22552 * 1661521u) + (_22565 * 1289u)) + _22576) * 4.6691861488312724759452976286411e-10f;
	                _33360 = true;
	                break;
	            }
	            case 209u:
	            {
	                uint _10084 = _12091 % 1291u;
	                uint _22507 = (124494u + _10084) / 2u;
	                uint _22515;
	                if ((_10084 & 1u) != 0u)
	                {
	                    _22515 = g_ScrambledHaltonPermutations.Load<uint>(_22507 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _22515 = g_ScrambledHaltonPermutations.Load<uint>(_22507 * 4 + 0) & 65535u;
	                }
	                uint _22518 = (_12091 / 1291u) % 1291u;
	                uint _22520 = (124494u + _22518) / 2u;
	                uint _22528;
	                if ((_22518 & 1u) != 0u)
	                {
	                    _22528 = g_ScrambledHaltonPermutations.Load<uint>(_22520 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _22528 = g_ScrambledHaltonPermutations.Load<uint>(_22520 * 4 + 0) & 65535u;
	                }
	                uint _10089 = (_12091 / 1666681u) % 1291u;
	                uint _22531 = (124494u + _10089) / 2u;
	                uint _22539;
	                if ((_10089 & 1u) != 0u)
	                {
	                    _22539 = g_ScrambledHaltonPermutations.Load<uint>(_22531 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _22539 = g_ScrambledHaltonPermutations.Load<uint>(_22531 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_22515 * 1666681u) + (_22528 * 1291u)) + _22539) * 4.6475195913942002334806602448225e-10f;
	                _33360 = true;
	                break;
	            }
	            case 210u:
	            {
	                uint _22468 = 125785u + (_12091 % 1297u);
	                uint _22469 = _22468 / 2u;
	                uint _22478;
	                if ((_22468 & 1u) != 0u)
	                {
	                    _22478 = g_ScrambledHaltonPermutations.Load<uint>(_22469 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _22478 = g_ScrambledHaltonPermutations.Load<uint>(_22469 * 4 + 0) & 65535u;
	                }
	                uint _22482 = 125785u + ((_12091 / 1297u) % 1297u);
	                uint _22483 = _22482 / 2u;
	                uint _22491;
	                if ((_22482 & 1u) != 0u)
	                {
	                    _22491 = g_ScrambledHaltonPermutations.Load<uint>(_22483 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _22491 = g_ScrambledHaltonPermutations.Load<uint>(_22483 * 4 + 0) & 65535u;
	                }
	                uint _22493 = 125785u + ((_12091 / 1682209u) % 1297u);
	                uint _22494 = _22493 / 2u;
	                uint _22502;
	                if ((_22493 & 1u) != 0u)
	                {
	                    _22502 = g_ScrambledHaltonPermutations.Load<uint>(_22494 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _22502 = g_ScrambledHaltonPermutations.Load<uint>(_22494 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_22478 * 1682209u) + (_22491 * 1297u)) + _22502) * 4.5833184469934451499284477904439e-10f;
	                _33360 = true;
	                break;
	            }
	            case 211u:
	            {
	                uint _10066 = _12091 % 1301u;
	                uint _22431 = (127082u + _10066) / 2u;
	                uint _22439;
	                if ((_10066 & 1u) != 0u)
	                {
	                    _22439 = g_ScrambledHaltonPermutations.Load<uint>(_22431 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _22439 = g_ScrambledHaltonPermutations.Load<uint>(_22431 * 4 + 0) & 65535u;
	                }
	                uint _22442 = (_12091 / 1301u) % 1301u;
	                uint _22444 = (127082u + _22442) / 2u;
	                uint _22452;
	                if ((_22442 & 1u) != 0u)
	                {
	                    _22452 = g_ScrambledHaltonPermutations.Load<uint>(_22444 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _22452 = g_ScrambledHaltonPermutations.Load<uint>(_22444 * 4 + 0) & 65535u;
	                }
	                uint _10071 = (_12091 / 1692601u) % 1301u;
	                uint _22455 = (127082u + _10071) / 2u;
	                uint _22463;
	                if ((_10071 & 1u) != 0u)
	                {
	                    _22463 = g_ScrambledHaltonPermutations.Load<uint>(_22455 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _22463 = g_ScrambledHaltonPermutations.Load<uint>(_22455 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_22439 * 1692601u) + (_22452 * 1301u)) + _22463) * 4.5411732707556495824974263086915e-10f;
	                _33360 = true;
	                break;
	            }
	            case 212u:
	            {
	                uint _22392 = 128383u + (_12091 % 1303u);
	                uint _22393 = _22392 / 2u;
	                uint _22401;
	                if ((_22392 & 1u) != 0u)
	                {
	                    _22401 = g_ScrambledHaltonPermutations.Load<uint>(_22393 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _22401 = g_ScrambledHaltonPermutations.Load<uint>(_22393 * 4 + 0) & 65535u;
	                }
	                uint _22405 = 128383u + ((_12091 / 1303u) % 1303u);
	                uint _22406 = _22405 / 2u;
	                uint _22414;
	                if ((_22405 & 1u) != 0u)
	                {
	                    _22414 = g_ScrambledHaltonPermutations.Load<uint>(_22406 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _22414 = g_ScrambledHaltonPermutations.Load<uint>(_22406 * 4 + 0) & 65535u;
	                }
	                uint _22417 = 128383u + ((_12091 / 1697809u) % 1303u);
	                uint _22418 = _22417 / 2u;
	                uint _22426;
	                if ((_22417 & 1u) != 0u)
	                {
	                    _22426 = g_ScrambledHaltonPermutations.Load<uint>(_22418 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _22426 = g_ScrambledHaltonPermutations.Load<uint>(_22418 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_22401 * 1697809u) + (_22414 * 1303u)) + _22426) * 4.5202938614430365760199492797256e-10f;
	                _33360 = true;
	                break;
	            }
	            case 213u:
	            {
	                uint _10048 = _12091 % 1307u;
	                uint _22052 = (129686u + _10048) / 2u;
	                uint _22060;
	                if ((_10048 & 1u) != 0u)
	                {
	                    _22060 = g_ScrambledHaltonPermutations.Load<uint>(_22052 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _22060 = g_ScrambledHaltonPermutations.Load<uint>(_22052 * 4 + 0) & 65535u;
	                }
	                uint _22063 = (_12091 / 1307u) % 1307u;
	                uint _22065 = (129686u + _22063) / 2u;
	                uint _22073;
	                if ((_22063 & 1u) != 0u)
	                {
	                    _22073 = g_ScrambledHaltonPermutations.Load<uint>(_22065 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _22073 = g_ScrambledHaltonPermutations.Load<uint>(_22065 * 4 + 0) & 65535u;
	                }
	                uint _10053 = (_12091 / 1708249u) % 1307u;
	                uint _22076 = (129686u + _10053) / 2u;
	                uint _22084;
	                if ((_10053 & 1u) != 0u)
	                {
	                    _22084 = g_ScrambledHaltonPermutations.Load<uint>(_22076 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _22084 = g_ScrambledHaltonPermutations.Load<uint>(_22076 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_22060 * 1708249u) + (_22073 * 1307u)) + _22084) * 4.478918624872818554649711586535e-10f;
	                _33360 = true;
	                break;
	            }
	            case 214u:
	            {
	                uint _22015 = 130993u + (_12091 % 1319u);
	                uint _22016 = _22015 / 2u;
	                uint _22024;
	                if ((_22015 & 1u) != 0u)
	                {
	                    _22024 = g_ScrambledHaltonPermutations.Load<uint>(_22016 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _22024 = g_ScrambledHaltonPermutations.Load<uint>(_22016 * 4 + 0) & 65535u;
	                }
	                uint _22028 = 130993u + ((_12091 / 1319u) % 1319u);
	                uint _22029 = _22028 / 2u;
	                uint _22037;
	                if ((_22028 & 1u) != 0u)
	                {
	                    _22037 = g_ScrambledHaltonPermutations.Load<uint>(_22029 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _22037 = g_ScrambledHaltonPermutations.Load<uint>(_22029 * 4 + 0) & 65535u;
	                }
	                uint _22039 = 130993u + ((_12091 / 1739761u) % 1319u);
	                uint _22040 = _22039 / 2u;
	                uint _22048;
	                if ((_22039 & 1u) != 0u)
	                {
	                    _22048 = g_ScrambledHaltonPermutations.Load<uint>(_22040 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _22048 = g_ScrambledHaltonPermutations.Load<uint>(_22040 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_22024 * 1739761u) + (_22037 * 1319u)) + _22048) * 4.3577824682117238808132242411375e-10f;
	                _33360 = true;
	                break;
	            }
	            case 215u:
	            {
	                uint _10030 = _12091 % 1321u;
	                uint _21979 = (132312u + _10030) / 2u;
	                uint _21987;
	                if ((_10030 & 1u) != 0u)
	                {
	                    _21987 = g_ScrambledHaltonPermutations.Load<uint>(_21979 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _21987 = g_ScrambledHaltonPermutations.Load<uint>(_21979 * 4 + 0) & 65535u;
	                }
	                uint _21990 = (_12091 / 1321u) % 1321u;
	                uint _21992 = (132312u + _21990) / 2u;
	                uint _22000;
	                if ((_21990 & 1u) != 0u)
	                {
	                    _22000 = g_ScrambledHaltonPermutations.Load<uint>(_21992 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _22000 = g_ScrambledHaltonPermutations.Load<uint>(_21992 * 4 + 0) & 65535u;
	                }
	                uint _10035 = (_12091 / 1745041u) % 1321u;
	                uint _22003 = (132312u + _10035) / 2u;
	                uint _22011;
	                if ((_10035 & 1u) != 0u)
	                {
	                    _22011 = g_ScrambledHaltonPermutations.Load<uint>(_22003 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _22011 = g_ScrambledHaltonPermutations.Load<uint>(_22003 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_21987 * 1745041u) + (_22000 * 1321u)) + _22011) * 4.3380196657061276255262782797217e-10f;
	                _33360 = true;
	                break;
	            }
	            case 216u:
	            {
	                uint _21942 = 133633u + (_12091 % 1327u);
	                uint _21943 = _21942 / 2u;
	                uint _21951;
	                if ((_21942 & 1u) != 0u)
	                {
	                    _21951 = g_ScrambledHaltonPermutations.Load<uint>(_21943 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _21951 = g_ScrambledHaltonPermutations.Load<uint>(_21943 * 4 + 0) & 65535u;
	                }
	                uint _21955 = 133633u + ((_12091 / 1327u) % 1327u);
	                uint _21956 = _21955 / 2u;
	                uint _21964;
	                if ((_21955 & 1u) != 0u)
	                {
	                    _21964 = g_ScrambledHaltonPermutations.Load<uint>(_21956 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _21964 = g_ScrambledHaltonPermutations.Load<uint>(_21956 * 4 + 0) & 65535u;
	                }
	                uint _21966 = 133633u + ((_12091 / 1760929u) % 1327u);
	                uint _21967 = _21966 / 2u;
	                uint _21975;
	                if ((_21966 & 1u) != 0u)
	                {
	                    _21975 = g_ScrambledHaltonPermutations.Load<uint>(_21967 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _21975 = g_ScrambledHaltonPermutations.Load<uint>(_21967 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_21951 * 1760929u) + (_21964 * 1327u)) + _21975) * 4.2794420784808551161404466256499e-10f;
	                _33360 = true;
	                break;
	            }
	            case 217u:
	            {
	                uint _10012 = _12091 % 1361u;
	                uint _20946 = (134960u + _10012) / 2u;
	                uint _20953;
	                if ((_10012 & 1u) != 0u)
	                {
	                    _20953 = g_ScrambledHaltonPermutations.Load<uint>(_20946 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _20953 = g_ScrambledHaltonPermutations.Load<uint>(_20946 * 4 + 0) & 65535u;
	                }
	                uint _21918 = (_12091 / 1361u) % 1361u;
	                uint _21920 = (134960u + _21918) / 2u;
	                uint _21928;
	                if ((_21918 & 1u) != 0u)
	                {
	                    _21928 = g_ScrambledHaltonPermutations.Load<uint>(_21920 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _21928 = g_ScrambledHaltonPermutations.Load<uint>(_21920 * 4 + 0) & 65535u;
	                }
	                uint _10017 = (_12091 / 1852321u) % 1361u;
	                uint _21931 = (134960u + _10017) / 2u;
	                uint _21939;
	                if ((_10017 & 1u) != 0u)
	                {
	                    _21939 = g_ScrambledHaltonPermutations.Load<uint>(_21931 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _21939 = g_ScrambledHaltonPermutations.Load<uint>(_21931 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_20953 * 1852321u) + (_21928 * 1361u)) + _21939) * 3.9666653295356013586570043116808e-10f;
	                _33360 = true;
	                break;
	            }
	            case 218u:
	            {
	                uint _20257 = 136321u + (_12091 % 1367u);
	                uint _20258 = _20257 / 2u;
	                uint _20265;
	                if ((_20257 & 1u) != 0u)
	                {
	                    _20265 = g_ScrambledHaltonPermutations.Load<uint>(_20258 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _20265 = g_ScrambledHaltonPermutations.Load<uint>(_20258 * 4 + 0) & 65535u;
	                }
	                uint _20924 = 136321u + ((_12091 / 1367u) % 1367u);
	                uint _20925 = _20924 / 2u;
	                uint _20932;
	                if ((_20924 & 1u) != 0u)
	                {
	                    _20932 = g_ScrambledHaltonPermutations.Load<uint>(_20925 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _20932 = g_ScrambledHaltonPermutations.Load<uint>(_20925 * 4 + 0) & 65535u;
	                }
	                uint _20934 = 136321u + ((_12091 / 1868689u) % 1367u);
	                uint _20935 = _20934 / 2u;
	                uint _20942;
	                if ((_20934 & 1u) != 0u)
	                {
	                    _20942 = g_ScrambledHaltonPermutations.Load<uint>(_20935 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _20942 = g_ScrambledHaltonPermutations.Load<uint>(_20935 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_20265 * 1868689u) + (_20932 * 1367u)) + _20942) * 3.9146633157294274951709667220712e-10f;
	                _33360 = true;
	                break;
	            }
	            case 219u:
	            {
	                uint _9994 = _12091 % 1373u;
	                uint _20227 = (137688u + _9994) / 2u;
	                uint _20234;
	                if ((_9994 & 1u) != 0u)
	                {
	                    _20234 = g_ScrambledHaltonPermutations.Load<uint>(_20227 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _20234 = g_ScrambledHaltonPermutations.Load<uint>(_20227 * 4 + 0) & 65535u;
	                }
	                uint _20237 = (_12091 / 1373u) % 1373u;
	                uint _20238 = (137688u + _20237) / 2u;
	                uint _20245;
	                if ((_20237 & 1u) != 0u)
	                {
	                    _20245 = g_ScrambledHaltonPermutations.Load<uint>(_20238 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _20245 = g_ScrambledHaltonPermutations.Load<uint>(_20238 * 4 + 0) & 65535u;
	                }
	                uint _9999 = (_12091 / 1885129u) % 1373u;
	                uint _20247 = (137688u + _9999) / 2u;
	                uint _20254;
	                if ((_9999 & 1u) != 0u)
	                {
	                    _20254 = g_ScrambledHaltonPermutations.Load<uint>(_20247 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _20254 = g_ScrambledHaltonPermutations.Load<uint>(_20247 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_20234 * 1885129u) + (_20245 * 1373u)) + _20254) * 3.863566133688323134265374392271e-10f;
	                _33360 = true;
	                break;
	            }
	            case 220u:
	            {
	                uint _20195 = 139061u + (_12091 % 1381u);
	                uint _20196 = _20195 / 2u;
	                uint _20203;
	                if ((_20195 & 1u) != 0u)
	                {
	                    _20203 = g_ScrambledHaltonPermutations.Load<uint>(_20196 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _20203 = g_ScrambledHaltonPermutations.Load<uint>(_20196 * 4 + 0) & 65535u;
	                }
	                uint _20920 = 139061u + ((_12091 / 1381u) % 1381u);
	                uint _20207 = _20920 / 2u;
	                uint _20214;
	                if ((_20920 & 1u) != 0u)
	                {
	                    _20214 = g_ScrambledHaltonPermutations.Load<uint>(_20207 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _20214 = g_ScrambledHaltonPermutations.Load<uint>(_20207 * 4 + 0) & 65535u;
	                }
	                uint _20921 = 139061u + ((_12091 / 1907161u) % 1381u);
	                uint _20216 = _20921 / 2u;
	                uint _20223;
	                if ((_20921 & 1u) != 0u)
	                {
	                    _20223 = g_ScrambledHaltonPermutations.Load<uint>(_20216 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _20223 = g_ScrambledHaltonPermutations.Load<uint>(_20216 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_20203 * 1907161u) + (_20214 * 1381u)) + _20223) * 3.7968103661079055655136471614242e-10f;
	                _33360 = true;
	                break;
	            }
	            case 221u:
	            {
	                uint _9976 = _12091 % 1399u;
	                uint _20164 = (140442u + _9976) / 2u;
	                uint _20171;
	                if ((_9976 & 1u) != 0u)
	                {
	                    _20171 = g_ScrambledHaltonPermutations.Load<uint>(_20164 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _20171 = g_ScrambledHaltonPermutations.Load<uint>(_20164 * 4 + 0) & 65535u;
	                }
	                uint _20174 = (_12091 / 1399u) % 1399u;
	                uint _20175 = (140442u + _20174) / 2u;
	                uint _20182;
	                if ((_20174 & 1u) != 0u)
	                {
	                    _20182 = g_ScrambledHaltonPermutations.Load<uint>(_20175 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _20182 = g_ScrambledHaltonPermutations.Load<uint>(_20175 * 4 + 0) & 65535u;
	                }
	                uint _9981 = (_12091 / 1957201u) % 1399u;
	                uint _20184 = (140442u + _9981) / 2u;
	                uint _20191;
	                if ((_9981 & 1u) != 0u)
	                {
	                    _20191 = g_ScrambledHaltonPermutations.Load<uint>(_20184 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _20191 = g_ScrambledHaltonPermutations.Load<uint>(_20184 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_20171 * 1957201u) + (_20182 * 1399u)) + _20191) * 3.652134705767196010128827765584e-10f;
	                _33360 = true;
	                break;
	            }
	            case 222u:
	            {
	                uint _20131 = 141841u + (_12091 % 1409u);
	                uint _20132 = _20131 / 2u;
	                uint _20139;
	                if ((_20131 & 1u) != 0u)
	                {
	                    _20139 = g_ScrambledHaltonPermutations.Load<uint>(_20132 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _20139 = g_ScrambledHaltonPermutations.Load<uint>(_20132 * 4 + 0) & 65535u;
	                }
	                uint _20915 = 141841u + ((_12091 / 1409u) % 1409u);
	                uint _20143 = _20915 / 2u;
	                uint _20150;
	                if ((_20915 & 1u) != 0u)
	                {
	                    _20150 = g_ScrambledHaltonPermutations.Load<uint>(_20143 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _20150 = g_ScrambledHaltonPermutations.Load<uint>(_20143 * 4 + 0) & 65535u;
	                }
	                uint _20916 = 141841u + ((_12091 / 1985281u) % 1409u);
	                uint _20152 = _20916 / 2u;
	                uint _20159;
	                if ((_20916 & 1u) != 0u)
	                {
	                    _20159 = g_ScrambledHaltonPermutations.Load<uint>(_20152 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _20159 = g_ScrambledHaltonPermutations.Load<uint>(_20152 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_20139 * 1985281u) + (_20150 * 1409u)) + _20159) * 3.5749250781869079673924716189504e-10f;
	                _33360 = true;
	                break;
	            }
	            case 223u:
	            {
	                uint _9958 = _12091 % 1423u;
	                uint _20101 = (143250u + _9958) / 2u;
	                uint _20108;
	                if ((_9958 & 1u) != 0u)
	                {
	                    _20108 = g_ScrambledHaltonPermutations.Load<uint>(_20101 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _20108 = g_ScrambledHaltonPermutations.Load<uint>(_20101 * 4 + 0) & 65535u;
	                }
	                uint _20111 = (_12091 / 1423u) % 1423u;
	                uint _20112 = (143250u + _20111) / 2u;
	                uint _20119;
	                if ((_20111 & 1u) != 0u)
	                {
	                    _20119 = g_ScrambledHaltonPermutations.Load<uint>(_20112 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _20119 = g_ScrambledHaltonPermutations.Load<uint>(_20112 * 4 + 0) & 65535u;
	                }
	                uint _9963 = (_12091 / 2024929u) % 1423u;
	                uint _20121 = (143250u + _9963) / 2u;
	                uint _20128;
	                if ((_9963 & 1u) != 0u)
	                {
	                    _20128 = g_ScrambledHaltonPermutations.Load<uint>(_20121 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _20128 = g_ScrambledHaltonPermutations.Load<uint>(_20121 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_20108 * 2024929u) + (_20119 * 1423u)) + _20128) * 3.4704455975642645171319600194693e-10f;
	                _33360 = true;
	                break;
	            }
	            case 224u:
	            {
	                uint _20069 = 144673u + (_12091 % 1427u);
	                uint _20070 = _20069 / 2u;
	                uint _20077;
	                if ((_20069 & 1u) != 0u)
	                {
	                    _20077 = g_ScrambledHaltonPermutations.Load<uint>(_20070 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _20077 = g_ScrambledHaltonPermutations.Load<uint>(_20070 * 4 + 0) & 65535u;
	                }
	                uint _20911 = 144673u + ((_12091 / 1427u) % 1427u);
	                uint _20081 = _20911 / 2u;
	                uint _20088;
	                if ((_20911 & 1u) != 0u)
	                {
	                    _20088 = g_ScrambledHaltonPermutations.Load<uint>(_20081 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _20088 = g_ScrambledHaltonPermutations.Load<uint>(_20081 * 4 + 0) & 65535u;
	                }
	                uint _20912 = 144673u + ((_12091 / 2036329u) % 1427u);
	                uint _20090 = _20912 / 2u;
	                uint _20097;
	                if ((_20912 & 1u) != 0u)
	                {
	                    _20097 = g_ScrambledHaltonPermutations.Load<uint>(_20090 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _20097 = g_ScrambledHaltonPermutations.Load<uint>(_20090 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_20077 * 2036329u) + (_20088 * 1427u)) + _20097) * 3.4413435989755214450269704684615e-10f;
	                _33360 = true;
	                break;
	            }
	            case 225u:
	            {
	                uint _9940 = _12091 % 1429u;
	                uint _20039 = (146100u + _9940) / 2u;
	                uint _20046;
	                if ((_9940 & 1u) != 0u)
	                {
	                    _20046 = g_ScrambledHaltonPermutations.Load<uint>(_20039 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _20046 = g_ScrambledHaltonPermutations.Load<uint>(_20039 * 4 + 0) & 65535u;
	                }
	                uint _20049 = (_12091 / 1429u) % 1429u;
	                uint _20050 = (146100u + _20049) / 2u;
	                uint _20057;
	                if ((_20049 & 1u) != 0u)
	                {
	                    _20057 = g_ScrambledHaltonPermutations.Load<uint>(_20050 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _20057 = g_ScrambledHaltonPermutations.Load<uint>(_20050 * 4 + 0) & 65535u;
	                }
	                uint _9945 = (_12091 / 2042041u) % 1429u;
	                uint _20059 = (146100u + _9945) / 2u;
	                uint _20066;
	                if ((_9945 & 1u) != 0u)
	                {
	                    _20066 = g_ScrambledHaltonPermutations.Load<uint>(_20059 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _20066 = g_ScrambledHaltonPermutations.Load<uint>(_20059 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_20046 * 2042041u) + (_20057 * 1429u)) + _20066) * 3.4269143078802244417602196335793e-10f;
	                _33360 = true;
	                break;
	            }
	            case 226u:
	            {
	                uint _20007 = 147529u + (_12091 % 1433u);
	                uint _20008 = _20007 / 2u;
	                uint _20015;
	                if ((_20007 & 1u) != 0u)
	                {
	                    _20015 = g_ScrambledHaltonPermutations.Load<uint>(_20008 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _20015 = g_ScrambledHaltonPermutations.Load<uint>(_20008 * 4 + 0) & 65535u;
	                }
	                uint _20907 = 147529u + ((_12091 / 1433u) % 1433u);
	                uint _20019 = _20907 / 2u;
	                uint _20026;
	                if ((_20907 & 1u) != 0u)
	                {
	                    _20026 = g_ScrambledHaltonPermutations.Load<uint>(_20019 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _20026 = g_ScrambledHaltonPermutations.Load<uint>(_20019 * 4 + 0) & 65535u;
	                }
	                uint _20908 = 147529u + ((_12091 / 2053489u) % 1433u);
	                uint _20028 = _20908 / 2u;
	                uint _20035;
	                if ((_20908 & 1u) != 0u)
	                {
	                    _20035 = g_ScrambledHaltonPermutations.Load<uint>(_20028 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _20035 = g_ScrambledHaltonPermutations.Load<uint>(_20028 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_20015 * 2053489u) + (_20026 * 1433u)) + _20035) * 3.3982971991974864067742601037025e-10f;
	                _33360 = true;
	                break;
	            }
	            case 227u:
	            {
	                uint _9921 = _12091 % 1439u;
	                uint _19977 = (148962u + _9921) / 2u;
	                uint _19984;
	                if ((_9921 & 1u) != 0u)
	                {
	                    _19984 = g_ScrambledHaltonPermutations.Load<uint>(_19977 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19984 = g_ScrambledHaltonPermutations.Load<uint>(_19977 * 4 + 0) & 65535u;
	                }
	                uint _19987 = (_12091 / 1439u) % 1439u;
	                uint _19988 = (148962u + _19987) / 2u;
	                uint _19995;
	                if ((_19987 & 1u) != 0u)
	                {
	                    _19995 = g_ScrambledHaltonPermutations.Load<uint>(_19988 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19995 = g_ScrambledHaltonPermutations.Load<uint>(_19988 * 4 + 0) & 65535u;
	                }
	                uint _9927 = (_12091 / 2070721u) % 1439u;
	                uint _19997 = (148962u + _9927) / 2u;
	                uint _20004;
	                if ((_9927 & 1u) != 0u)
	                {
	                    _20004 = g_ScrambledHaltonPermutations.Load<uint>(_19997 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _20004 = g_ScrambledHaltonPermutations.Load<uint>(_19997 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_19984 * 2070721u) + (_19995 * 1439u)) + _20004) * 3.3559660606030661256227176636457e-10f;
	                _33360 = true;
	                break;
	            }
	            case 228u:
	            {
	                uint _19945 = 150401u + (_12091 % 1447u);
	                uint _19946 = _19945 / 2u;
	                uint _19953;
	                if ((_19945 & 1u) != 0u)
	                {
	                    _19953 = g_ScrambledHaltonPermutations.Load<uint>(_19946 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19953 = g_ScrambledHaltonPermutations.Load<uint>(_19946 * 4 + 0) & 65535u;
	                }
	                uint _20903 = 150401u + ((_12091 / 1447u) % 1447u);
	                uint _19957 = _20903 / 2u;
	                uint _19964;
	                if ((_20903 & 1u) != 0u)
	                {
	                    _19964 = g_ScrambledHaltonPermutations.Load<uint>(_19957 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19964 = g_ScrambledHaltonPermutations.Load<uint>(_19957 * 4 + 0) & 65535u;
	                }
	                uint _20904 = 150401u + ((_12091 / 2093809u) % 1447u);
	                uint _19966 = _20904 / 2u;
	                uint _19973;
	                if ((_20904 & 1u) != 0u)
	                {
	                    _19973 = g_ScrambledHaltonPermutations.Load<uint>(_19966 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19973 = g_ScrambledHaltonPermutations.Load<uint>(_19966 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_19953 * 2093809u) + (_19964 * 1447u)) + _19973) * 3.3006111732625242893846007063985e-10f;
	                _33360 = true;
	                break;
	            }
	            case 229u:
	            {
	                uint _9903 = _12091 % 1451u;
	                uint _19915 = (151848u + _9903) / 2u;
	                uint _19922;
	                if ((_9903 & 1u) != 0u)
	                {
	                    _19922 = g_ScrambledHaltonPermutations.Load<uint>(_19915 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19922 = g_ScrambledHaltonPermutations.Load<uint>(_19915 * 4 + 0) & 65535u;
	                }
	                uint _19925 = (_12091 / 1451u) % 1451u;
	                uint _19926 = (151848u + _19925) / 2u;
	                uint _19933;
	                if ((_19925 & 1u) != 0u)
	                {
	                    _19933 = g_ScrambledHaltonPermutations.Load<uint>(_19926 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19933 = g_ScrambledHaltonPermutations.Load<uint>(_19926 * 4 + 0) & 65535u;
	                }
	                uint _9908 = (_12091 / 2105401u) % 1451u;
	                uint _19935 = (151848u + _9908) / 2u;
	                uint _19942;
	                if ((_9908 & 1u) != 0u)
	                {
	                    _19942 = g_ScrambledHaltonPermutations.Load<uint>(_19935 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19942 = g_ScrambledHaltonPermutations.Load<uint>(_19935 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_19922 * 2105401u) + (_19933 * 1451u)) + _19942) * 3.2733896149217400761699536815286e-10f;
	                _33360 = true;
	                break;
	            }
	            case 230u:
	            {
	                uint _19883 = 153299u + (_12091 % 1453u);
	                uint _19884 = _19883 / 2u;
	                uint _19891;
	                if ((_19883 & 1u) != 0u)
	                {
	                    _19891 = g_ScrambledHaltonPermutations.Load<uint>(_19884 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19891 = g_ScrambledHaltonPermutations.Load<uint>(_19884 * 4 + 0) & 65535u;
	                }
	                uint _20899 = 153299u + ((_12091 / 1453u) % 1453u);
	                uint _19895 = _20899 / 2u;
	                uint _19902;
	                if ((_20899 & 1u) != 0u)
	                {
	                    _19902 = g_ScrambledHaltonPermutations.Load<uint>(_19895 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19902 = g_ScrambledHaltonPermutations.Load<uint>(_19895 * 4 + 0) & 65535u;
	                }
	                uint _20900 = 153299u + ((_12091 / 2111209u) % 1453u);
	                uint _19904 = _20900 / 2u;
	                uint _19911;
	                if ((_20900 & 1u) != 0u)
	                {
	                    _19911 = g_ScrambledHaltonPermutations.Load<uint>(_19904 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19911 = g_ScrambledHaltonPermutations.Load<uint>(_19904 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_19891 * 2111209u) + (_19902 * 1453u)) + _19911) * 3.2598912458325912666623480618e-10f;
	                _33360 = true;
	                break;
	            }
	            case 231u:
	            {
	                uint _9884 = _12091 % 1459u;
	                uint _19852 = (154752u + _9884) / 2u;
	                uint _19860;
	                if ((_9884 & 1u) != 0u)
	                {
	                    _19860 = g_ScrambledHaltonPermutations.Load<uint>(_19852 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19860 = g_ScrambledHaltonPermutations.Load<uint>(_19852 * 4 + 0) & 65535u;
	                }
	                uint _19863 = (_12091 / 1459u) % 1459u;
	                uint _19864 = (154752u + _19863) / 2u;
	                uint _19871;
	                if ((_19863 & 1u) != 0u)
	                {
	                    _19871 = g_ScrambledHaltonPermutations.Load<uint>(_19864 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19871 = g_ScrambledHaltonPermutations.Load<uint>(_19864 * 4 + 0) & 65535u;
	                }
	                uint _9890 = (_12091 / 2128681u) % 1459u;
	                uint _19873 = (154752u + _9890) / 2u;
	                uint _19880;
	                if ((_9890 & 1u) != 0u)
	                {
	                    _19880 = g_ScrambledHaltonPermutations.Load<uint>(_19873 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19880 = g_ScrambledHaltonPermutations.Load<uint>(_19873 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_19860 * 2128681u) + (_19871 * 1459u)) + _19880) * 3.2198382848847018067317549139261e-10f;
	                _33360 = true;
	                break;
	            }
	            case 232u:
	            {
	                uint _19820 = 156211u + (_12091 % 1471u);
	                uint _19821 = _19820 / 2u;
	                uint _19828;
	                if ((_19820 & 1u) != 0u)
	                {
	                    _19828 = g_ScrambledHaltonPermutations.Load<uint>(_19821 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19828 = g_ScrambledHaltonPermutations.Load<uint>(_19821 * 4 + 0) & 65535u;
	                }
	                uint _20895 = 156211u + ((_12091 / 1471u) % 1471u);
	                uint _19832 = _20895 / 2u;
	                uint _19839;
	                if ((_20895 & 1u) != 0u)
	                {
	                    _19839 = g_ScrambledHaltonPermutations.Load<uint>(_19832 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19839 = g_ScrambledHaltonPermutations.Load<uint>(_19832 * 4 + 0) & 65535u;
	                }
	                uint _20896 = 156211u + ((_12091 / 2163841u) % 1471u);
	                uint _19841 = _20896 / 2u;
	                uint _19848;
	                if ((_20896 & 1u) != 0u)
	                {
	                    _19848 = g_ScrambledHaltonPermutations.Load<uint>(_19841 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19848 = g_ScrambledHaltonPermutations.Load<uint>(_19841 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_19828 * 2163841u) + (_19839 * 1471u)) + _19848) * 3.1416799717298715677316067740321e-10f;
	                _33360 = true;
	                break;
	            }
	            case 233u:
	            {
	                uint _9866 = _12091 % 1481u;
	                uint _19790 = (157682u + _9866) / 2u;
	                uint _19797;
	                if ((_9866 & 1u) != 0u)
	                {
	                    _19797 = g_ScrambledHaltonPermutations.Load<uint>(_19790 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19797 = g_ScrambledHaltonPermutations.Load<uint>(_19790 * 4 + 0) & 65535u;
	                }
	                uint _19800 = (_12091 / 1481u) % 1481u;
	                uint _19801 = (157682u + _19800) / 2u;
	                uint _19808;
	                if ((_19800 & 1u) != 0u)
	                {
	                    _19808 = g_ScrambledHaltonPermutations.Load<uint>(_19801 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19808 = g_ScrambledHaltonPermutations.Load<uint>(_19801 * 4 + 0) & 65535u;
	                }
	                uint _9871 = (_12091 / 2193361u) % 1481u;
	                uint _19810 = (157682u + _9871) / 2u;
	                uint _19817;
	                if ((_9871 & 1u) != 0u)
	                {
	                    _19817 = g_ScrambledHaltonPermutations.Load<uint>(_19810 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19817 = g_ScrambledHaltonPermutations.Load<uint>(_19810 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_19797 * 2193361u) + (_19808 * 1481u)) + _19817) * 3.0784688687113259675243170931935e-10f;
	                _33360 = true;
	                break;
	            }
	            case 234u:
	            {
	                uint _19758 = 159163u + (_12091 % 1483u);
	                uint _19759 = _19758 / 2u;
	                uint _19766;
	                if ((_19758 & 1u) != 0u)
	                {
	                    _19766 = g_ScrambledHaltonPermutations.Load<uint>(_19759 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19766 = g_ScrambledHaltonPermutations.Load<uint>(_19759 * 4 + 0) & 65535u;
	                }
	                uint _20891 = 159163u + ((_12091 / 1483u) % 1483u);
	                uint _19770 = _20891 / 2u;
	                uint _19777;
	                if ((_20891 & 1u) != 0u)
	                {
	                    _19777 = g_ScrambledHaltonPermutations.Load<uint>(_19770 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19777 = g_ScrambledHaltonPermutations.Load<uint>(_19770 * 4 + 0) & 65535u;
	                }
	                uint _20892 = 159163u + ((_12091 / 2199289u) % 1483u);
	                uint _19779 = _20892 / 2u;
	                uint _19786;
	                if ((_20892 & 1u) != 0u)
	                {
	                    _19786 = g_ScrambledHaltonPermutations.Load<uint>(_19779 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19786 = g_ScrambledHaltonPermutations.Load<uint>(_19779 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_19766 * 2199289u) + (_19777 * 1483u)) + _19786) * 3.066030762610694182512816041708e-10f;
	                _33360 = true;
	                break;
	            }
	            case 235u:
	            {
	                uint _9848 = _12091 % 1487u;
	                uint _19728 = (160646u + _9848) / 2u;
	                uint _19735;
	                if ((_9848 & 1u) != 0u)
	                {
	                    _19735 = g_ScrambledHaltonPermutations.Load<uint>(_19728 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19735 = g_ScrambledHaltonPermutations.Load<uint>(_19728 * 4 + 0) & 65535u;
	                }
	                uint _19738 = (_12091 / 1487u) % 1487u;
	                uint _19739 = (160646u + _19738) / 2u;
	                uint _19746;
	                if ((_19738 & 1u) != 0u)
	                {
	                    _19746 = g_ScrambledHaltonPermutations.Load<uint>(_19739 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19746 = g_ScrambledHaltonPermutations.Load<uint>(_19739 * 4 + 0) & 65535u;
	                }
	                uint _9853 = (_12091 / 2211169u) % 1487u;
	                uint _19748 = (160646u + _9853) / 2u;
	                uint _19755;
	                if ((_9853 & 1u) != 0u)
	                {
	                    _19755 = g_ScrambledHaltonPermutations.Load<uint>(_19748 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19755 = g_ScrambledHaltonPermutations.Load<uint>(_19748 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_19735 * 2211169u) + (_19746 * 1487u)) + _19755) * 3.0413546681096192969562252983451e-10f;
	                _33360 = true;
	                break;
	            }
	            case 236u:
	            {
	                uint _19696 = 162133u + (_12091 % 1489u);
	                uint _19697 = _19696 / 2u;
	                uint _19704;
	                if ((_19696 & 1u) != 0u)
	                {
	                    _19704 = g_ScrambledHaltonPermutations.Load<uint>(_19697 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19704 = g_ScrambledHaltonPermutations.Load<uint>(_19697 * 4 + 0) & 65535u;
	                }
	                uint _20887 = 162133u + ((_12091 / 1489u) % 1489u);
	                uint _19708 = _20887 / 2u;
	                uint _19715;
	                if ((_20887 & 1u) != 0u)
	                {
	                    _19715 = g_ScrambledHaltonPermutations.Load<uint>(_19708 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19715 = g_ScrambledHaltonPermutations.Load<uint>(_19708 * 4 + 0) & 65535u;
	                }
	                uint _20888 = 162133u + ((_12091 / 2217121u) % 1489u);
	                uint _19717 = _20888 / 2u;
	                uint _19724;
	                if ((_20888 & 1u) != 0u)
	                {
	                    _19724 = g_ScrambledHaltonPermutations.Load<uint>(_19717 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19724 = g_ScrambledHaltonPermutations.Load<uint>(_19717 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_19704 * 2217121u) + (_19715 * 1489u)) + _19724) * 3.029115847041907727543730288744e-10f;
	                _33360 = true;
	                break;
	            }
	            case 237u:
	            {
	                uint _9830 = _12091 % 1493u;
	                uint _19665 = (163622u + _9830) / 2u;
	                uint _19672;
	                if ((_9830 & 1u) != 0u)
	                {
	                    _19672 = g_ScrambledHaltonPermutations.Load<uint>(_19665 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19672 = g_ScrambledHaltonPermutations.Load<uint>(_19665 * 4 + 0) & 65535u;
	                }
	                uint _19676 = (_12091 / 1493u) % 1493u;
	                uint _19677 = (163622u + _19676) / 2u;
	                uint _19684;
	                if ((_19676 & 1u) != 0u)
	                {
	                    _19684 = g_ScrambledHaltonPermutations.Load<uint>(_19677 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19684 = g_ScrambledHaltonPermutations.Load<uint>(_19677 * 4 + 0) & 65535u;
	                }
	                uint _9835 = (_12091 / 2229049u) % 1493u;
	                uint _19686 = (163622u + _9835) / 2u;
	                uint _19693;
	                if ((_9835 & 1u) != 0u)
	                {
	                    _19693 = g_ScrambledHaltonPermutations.Load<uint>(_19686 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19693 = g_ScrambledHaltonPermutations.Load<uint>(_19686 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_19672 * 2229049u) + (_19684 * 1493u)) + _19693) * 3.0048344368260870851372601464391e-10f;
	                _33360 = true;
	                break;
	            }
	            case 238u:
	            {
	                uint _19633 = 165115u + (_12091 % 1499u);
	                uint _19634 = _19633 / 2u;
	                uint _19641;
	                if ((_19633 & 1u) != 0u)
	                {
	                    _19641 = g_ScrambledHaltonPermutations.Load<uint>(_19634 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19641 = g_ScrambledHaltonPermutations.Load<uint>(_19634 * 4 + 0) & 65535u;
	                }
	                uint _20883 = 165115u + ((_12091 / 1499u) % 1499u);
	                uint _19645 = _20883 / 2u;
	                uint _19652;
	                if ((_20883 & 1u) != 0u)
	                {
	                    _19652 = g_ScrambledHaltonPermutations.Load<uint>(_19645 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19652 = g_ScrambledHaltonPermutations.Load<uint>(_19645 * 4 + 0) & 65535u;
	                }
	                uint _20884 = 165115u + ((_12091 / 2247001u) % 1499u);
	                uint _19654 = _20884 / 2u;
	                uint _19661;
	                if ((_20884 & 1u) != 0u)
	                {
	                    _19661 = g_ScrambledHaltonPermutations.Load<uint>(_19654 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19661 = g_ScrambledHaltonPermutations.Load<uint>(_19654 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_19641 * 2247001u) + (_19652 * 1499u)) + _19661) * 2.968896517518970767923747189343e-10f;
	                _33360 = true;
	                break;
	            }
	            case 239u:
	            {
	                uint _9812 = _12091 % 1511u;
	                uint _19603 = (166614u + _9812) / 2u;
	                uint _19610;
	                if ((_9812 & 1u) != 0u)
	                {
	                    _19610 = g_ScrambledHaltonPermutations.Load<uint>(_19603 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19610 = g_ScrambledHaltonPermutations.Load<uint>(_19603 * 4 + 0) & 65535u;
	                }
	                uint _19613 = (_12091 / 1511u) % 1511u;
	                uint _19614 = (166614u + _19613) / 2u;
	                uint _19621;
	                if ((_19613 & 1u) != 0u)
	                {
	                    _19621 = g_ScrambledHaltonPermutations.Load<uint>(_19614 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19621 = g_ScrambledHaltonPermutations.Load<uint>(_19614 * 4 + 0) & 65535u;
	                }
	                uint _9817 = (_12091 / 2283121u) % 1511u;
	                uint _19623 = (166614u + _9817) / 2u;
	                uint _19630;
	                if ((_9817 & 1u) != 0u)
	                {
	                    _19630 = g_ScrambledHaltonPermutations.Load<uint>(_19623 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19630 = g_ScrambledHaltonPermutations.Load<uint>(_19623 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_19610 * 2283121u) + (_19621 * 1511u)) + _19630) * 2.8987218181342200296057853847742e-10f;
	                _33360 = true;
	                break;
	            }
	            case 240u:
	            {
	                uint _19571 = 168125u + (_12091 % 1523u);
	                uint _19572 = _19571 / 2u;
	                uint _19579;
	                if ((_19571 & 1u) != 0u)
	                {
	                    _19579 = g_ScrambledHaltonPermutations.Load<uint>(_19572 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19579 = g_ScrambledHaltonPermutations.Load<uint>(_19572 * 4 + 0) & 65535u;
	                }
	                uint _20879 = 168125u + ((_12091 / 1523u) % 1523u);
	                uint _19583 = _20879 / 2u;
	                uint _19590;
	                if ((_20879 & 1u) != 0u)
	                {
	                    _19590 = g_ScrambledHaltonPermutations.Load<uint>(_19583 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19590 = g_ScrambledHaltonPermutations.Load<uint>(_19583 * 4 + 0) & 65535u;
	                }
	                uint _20880 = 168125u + ((_12091 / 2319529u) % 1523u);
	                uint _19592 = _20880 / 2u;
	                uint _19599;
	                if ((_20880 & 1u) != 0u)
	                {
	                    _19599 = g_ScrambledHaltonPermutations.Load<uint>(_19592 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19599 = g_ScrambledHaltonPermutations.Load<uint>(_19592 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_19579 * 2319529u) + (_19590 * 1523u)) + _19599) * 2.8307417521133970694791059941053e-10f;
	                _33360 = true;
	                break;
	            }
	            case 241u:
	            {
	                uint _9794 = _12091 % 1531u;
	                uint _19535 = (169648u + _9794) / 2u;
	                uint _19548;
	                if ((_9794 & 1u) != 0u)
	                {
	                    _19548 = g_ScrambledHaltonPermutations.Load<uint>(_19535 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19548 = g_ScrambledHaltonPermutations.Load<uint>(_19535 * 4 + 0) & 65535u;
	                }
	                uint _19551 = (_12091 / 1531u) % 1531u;
	                uint _19552 = (169648u + _19551) / 2u;
	                uint _19559;
	                if ((_19551 & 1u) != 0u)
	                {
	                    _19559 = g_ScrambledHaltonPermutations.Load<uint>(_19552 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19559 = g_ScrambledHaltonPermutations.Load<uint>(_19552 * 4 + 0) & 65535u;
	                }
	                uint _9799 = (_12091 / 2343961u) % 1531u;
	                uint _19561 = (169648u + _9799) / 2u;
	                uint _19568;
	                if ((_9799 & 1u) != 0u)
	                {
	                    _19568 = g_ScrambledHaltonPermutations.Load<uint>(_19561 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19568 = g_ScrambledHaltonPermutations.Load<uint>(_19561 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_19548 * 2343961u) + (_19559 * 1531u)) + _19568) * 2.7865981744312762202753219753504e-10f;
	                _33360 = true;
	                break;
	            }
	            case 242u:
	            {
	                uint _19503 = 171179u + (_12091 % 1543u);
	                uint _19504 = _19503 / 2u;
	                uint _19511;
	                if ((_19503 & 1u) != 0u)
	                {
	                    _19511 = g_ScrambledHaltonPermutations.Load<uint>(_19504 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19511 = g_ScrambledHaltonPermutations.Load<uint>(_19504 * 4 + 0) & 65535u;
	                }
	                uint _20875 = 171179u + ((_12091 / 1543u) % 1543u);
	                uint _19515 = _20875 / 2u;
	                uint _19522;
	                if ((_20875 & 1u) != 0u)
	                {
	                    _19522 = g_ScrambledHaltonPermutations.Load<uint>(_19515 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19522 = g_ScrambledHaltonPermutations.Load<uint>(_19515 * 4 + 0) & 65535u;
	                }
	                uint _20876 = 171179u + ((_12091 / 2380849u) % 1543u);
	                uint _19524 = _20876 / 2u;
	                uint _19531;
	                if ((_20876 & 1u) != 0u)
	                {
	                    _19531 = g_ScrambledHaltonPermutations.Load<uint>(_19524 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19531 = g_ScrambledHaltonPermutations.Load<uint>(_19524 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_19511 * 2380849u) + (_19522 * 1543u)) + _19531) * 2.7220881104739191869157366454601e-10f;
	                _33360 = true;
	                break;
	            }
	            case 243u:
	            {
	                uint _9776 = _12091 % 1549u;
	                uint _19473 = (172722u + _9776) / 2u;
	                uint _19480;
	                if ((_9776 & 1u) != 0u)
	                {
	                    _19480 = g_ScrambledHaltonPermutations.Load<uint>(_19473 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19480 = g_ScrambledHaltonPermutations.Load<uint>(_19473 * 4 + 0) & 65535u;
	                }
	                uint _19483 = (_12091 / 1549u) % 1549u;
	                uint _19484 = (172722u + _19483) / 2u;
	                uint _19491;
	                if ((_19483 & 1u) != 0u)
	                {
	                    _19491 = g_ScrambledHaltonPermutations.Load<uint>(_19484 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19491 = g_ScrambledHaltonPermutations.Load<uint>(_19484 * 4 + 0) & 65535u;
	                }
	                uint _9781 = (_12091 / 2399401u) % 1549u;
	                uint _19493 = (172722u + _9781) / 2u;
	                uint _19500;
	                if ((_9781 & 1u) != 0u)
	                {
	                    _19500 = g_ScrambledHaltonPermutations.Load<uint>(_19493 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19500 = g_ScrambledHaltonPermutations.Load<uint>(_19493 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_19480 * 2399401u) + (_19491 * 1549u)) + _19500) * 2.6905785932562764628528384491801e-10f;
	                _33360 = true;
	                break;
	            }
	            case 244u:
	            {
	                uint _19441 = 174271u + (_12091 % 1553u);
	                uint _19442 = _19441 / 2u;
	                uint _19449;
	                if ((_19441 & 1u) != 0u)
	                {
	                    _19449 = g_ScrambledHaltonPermutations.Load<uint>(_19442 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19449 = g_ScrambledHaltonPermutations.Load<uint>(_19442 * 4 + 0) & 65535u;
	                }
	                uint _20871 = 174271u + ((_12091 / 1553u) % 1553u);
	                uint _19453 = _20871 / 2u;
	                uint _19460;
	                if ((_20871 & 1u) != 0u)
	                {
	                    _19460 = g_ScrambledHaltonPermutations.Load<uint>(_19453 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19460 = g_ScrambledHaltonPermutations.Load<uint>(_19453 * 4 + 0) & 65535u;
	                }
	                uint _20872 = 174271u + ((_12091 / 2411809u) % 1553u);
	                uint _19462 = _20872 / 2u;
	                uint _19469;
	                if ((_20872 & 1u) != 0u)
	                {
	                    _19469 = g_ScrambledHaltonPermutations.Load<uint>(_19462 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19469 = g_ScrambledHaltonPermutations.Load<uint>(_19462 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_19449 * 2411809u) + (_19460 * 1553u)) + _19469) * 2.6698421251580839452799409627914e-10f;
	                _33360 = true;
	                break;
	            }
	            case 245u:
	            {
	                uint _9758 = _12091 % 1559u;
	                uint _19411 = (175824u + _9758) / 2u;
	                uint _19418;
	                if ((_9758 & 1u) != 0u)
	                {
	                    _19418 = g_ScrambledHaltonPermutations.Load<uint>(_19411 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19418 = g_ScrambledHaltonPermutations.Load<uint>(_19411 * 4 + 0) & 65535u;
	                }
	                uint _19421 = (_12091 / 1559u) % 1559u;
	                uint _19422 = (175824u + _19421) / 2u;
	                uint _19429;
	                if ((_19421 & 1u) != 0u)
	                {
	                    _19429 = g_ScrambledHaltonPermutations.Load<uint>(_19422 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19429 = g_ScrambledHaltonPermutations.Load<uint>(_19422 * 4 + 0) & 65535u;
	                }
	                uint _9763 = (_12091 / 2430481u) % 1559u;
	                uint _19431 = (175824u + _9763) / 2u;
	                uint _19438;
	                if ((_9763 & 1u) != 0u)
	                {
	                    _19438 = g_ScrambledHaltonPermutations.Load<uint>(_19431 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19438 = g_ScrambledHaltonPermutations.Load<uint>(_19431 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_19418 * 2430481u) + (_19429 * 1559u)) + _19438) * 2.6391350216314890531066339462996e-10f;
	                _33360 = true;
	                break;
	            }
	            case 246u:
	            {
	                uint _19379 = 177383u + (_12091 % 1567u);
	                uint _19380 = _19379 / 2u;
	                uint _19387;
	                if ((_19379 & 1u) != 0u)
	                {
	                    _19387 = g_ScrambledHaltonPermutations.Load<uint>(_19380 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19387 = g_ScrambledHaltonPermutations.Load<uint>(_19380 * 4 + 0) & 65535u;
	                }
	                uint _20867 = 177383u + ((_12091 / 1567u) % 1567u);
	                uint _19391 = _20867 / 2u;
	                uint _19398;
	                if ((_20867 & 1u) != 0u)
	                {
	                    _19398 = g_ScrambledHaltonPermutations.Load<uint>(_19391 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19398 = g_ScrambledHaltonPermutations.Load<uint>(_19391 * 4 + 0) & 65535u;
	                }
	                uint _20868 = 177383u + ((_12091 / 2455489u) % 1567u);
	                uint _19400 = _20868 / 2u;
	                uint _19407;
	                if ((_20868 & 1u) != 0u)
	                {
	                    _19407 = g_ScrambledHaltonPermutations.Load<uint>(_19400 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19407 = g_ScrambledHaltonPermutations.Load<uint>(_19400 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_19387 * 2455489u) + (_19398 * 1567u)) + _19407) * 2.5989202456777604766102740541101e-10f;
	                _33360 = true;
	                break;
	            }
	            case 247u:
	            {
	                uint _9740 = _12091 % 1571u;
	                uint _19349 = (178950u + _9740) / 2u;
	                uint _19356;
	                if ((_9740 & 1u) != 0u)
	                {
	                    _19356 = g_ScrambledHaltonPermutations.Load<uint>(_19349 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19356 = g_ScrambledHaltonPermutations.Load<uint>(_19349 * 4 + 0) & 65535u;
	                }
	                uint _19359 = (_12091 / 1571u) % 1571u;
	                uint _19360 = (178950u + _19359) / 2u;
	                uint _19367;
	                if ((_19359 & 1u) != 0u)
	                {
	                    _19367 = g_ScrambledHaltonPermutations.Load<uint>(_19360 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19367 = g_ScrambledHaltonPermutations.Load<uint>(_19360 * 4 + 0) & 65535u;
	                }
	                uint _9745 = (_12091 / 2468041u) % 1571u;
	                uint _19369 = (178950u + _9745) / 2u;
	                uint _19376;
	                if ((_9745 & 1u) != 0u)
	                {
	                    _19376 = g_ScrambledHaltonPermutations.Load<uint>(_19369 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19376 = g_ScrambledHaltonPermutations.Load<uint>(_19369 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_19356 * 2468041u) + (_19367 * 1571u)) + _19376) * 2.5791191404778146534226834774017e-10f;
	                _33360 = true;
	                break;
	            }
	            case 248u:
	            {
	                uint _19317 = 180521u + (_12091 % 1579u);
	                uint _19318 = _19317 / 2u;
	                uint _19325;
	                if ((_19317 & 1u) != 0u)
	                {
	                    _19325 = g_ScrambledHaltonPermutations.Load<uint>(_19318 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19325 = g_ScrambledHaltonPermutations.Load<uint>(_19318 * 4 + 0) & 65535u;
	                }
	                uint _20863 = 180521u + ((_12091 / 1579u) % 1579u);
	                uint _19329 = _20863 / 2u;
	                uint _19336;
	                if ((_20863 & 1u) != 0u)
	                {
	                    _19336 = g_ScrambledHaltonPermutations.Load<uint>(_19329 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19336 = g_ScrambledHaltonPermutations.Load<uint>(_19329 * 4 + 0) & 65535u;
	                }
	                uint _20864 = 180521u + ((_12091 / 2493241u) % 1579u);
	                uint _19338 = _20864 / 2u;
	                uint _19345;
	                if ((_20864 & 1u) != 0u)
	                {
	                    _19345 = g_ScrambledHaltonPermutations.Load<uint>(_19338 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19345 = g_ScrambledHaltonPermutations.Load<uint>(_19338 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_19325 * 2493241u) + (_19336 * 1579u)) + _19345) * 2.54011589539970827900106087327e-10f;
	                _33360 = true;
	                break;
	            }
	            case 249u:
	            {
	                uint _9722 = _12091 % 1583u;
	                uint _19287 = (182100u + _9722) / 2u;
	                uint _19294;
	                if ((_9722 & 1u) != 0u)
	                {
	                    _19294 = g_ScrambledHaltonPermutations.Load<uint>(_19287 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19294 = g_ScrambledHaltonPermutations.Load<uint>(_19287 * 4 + 0) & 65535u;
	                }
	                uint _19297 = (_12091 / 1583u) % 1583u;
	                uint _19298 = (182100u + _19297) / 2u;
	                uint _19305;
	                if ((_19297 & 1u) != 0u)
	                {
	                    _19305 = g_ScrambledHaltonPermutations.Load<uint>(_19298 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19305 = g_ScrambledHaltonPermutations.Load<uint>(_19298 * 4 + 0) & 65535u;
	                }
	                uint _9727 = (_12091 / 2505889u) % 1583u;
	                uint _19307 = (182100u + _9727) / 2u;
	                uint _19314;
	                if ((_9727 & 1u) != 0u)
	                {
	                    _19314 = g_ScrambledHaltonPermutations.Load<uint>(_19307 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19314 = g_ScrambledHaltonPermutations.Load<uint>(_19307 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_19294 * 2505889u) + (_19305 * 1583u)) + _19314) * 2.5209090370736930708517320454121e-10f;
	                _33360 = true;
	                break;
	            }
	            case 250u:
	            {
	                uint _19255 = 183683u + (_12091 % 1597u);
	                uint _19256 = _19255 / 2u;
	                uint _19263;
	                if ((_19255 & 1u) != 0u)
	                {
	                    _19263 = g_ScrambledHaltonPermutations.Load<uint>(_19256 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19263 = g_ScrambledHaltonPermutations.Load<uint>(_19256 * 4 + 0) & 65535u;
	                }
	                uint _20859 = 183683u + ((_12091 / 1597u) % 1597u);
	                uint _19267 = _20859 / 2u;
	                uint _19274;
	                if ((_20859 & 1u) != 0u)
	                {
	                    _19274 = g_ScrambledHaltonPermutations.Load<uint>(_19267 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19274 = g_ScrambledHaltonPermutations.Load<uint>(_19267 * 4 + 0) & 65535u;
	                }
	                uint _20860 = 183683u + ((_12091 / 2550409u) % 1597u);
	                uint _19276 = _20860 / 2u;
	                uint _19283;
	                if ((_20860 & 1u) != 0u)
	                {
	                    _19283 = g_ScrambledHaltonPermutations.Load<uint>(_19276 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19283 = g_ScrambledHaltonPermutations.Load<uint>(_19276 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_19263 * 2550409u) + (_19274 * 1597u)) + _19283) * 2.4551904953540315545978955924511e-10f;
	                _33360 = true;
	                break;
	            }
	            case 251u:
	            {
	                uint _9704 = _12091 % 1601u;
	                uint _19225 = (185280u + _9704) / 2u;
	                uint _19232;
	                if ((_9704 & 1u) != 0u)
	                {
	                    _19232 = g_ScrambledHaltonPermutations.Load<uint>(_19225 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19232 = g_ScrambledHaltonPermutations.Load<uint>(_19225 * 4 + 0) & 65535u;
	                }
	                uint _19235 = (_12091 / 1601u) % 1601u;
	                uint _19236 = (185280u + _19235) / 2u;
	                uint _19243;
	                if ((_19235 & 1u) != 0u)
	                {
	                    _19243 = g_ScrambledHaltonPermutations.Load<uint>(_19236 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19243 = g_ScrambledHaltonPermutations.Load<uint>(_19236 * 4 + 0) & 65535u;
	                }
	                uint _9709 = (_12091 / 2563201u) % 1601u;
	                uint _19245 = (185280u + _9709) / 2u;
	                uint _19252;
	                if ((_9709 & 1u) != 0u)
	                {
	                    _19252 = g_ScrambledHaltonPermutations.Load<uint>(_19245 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19252 = g_ScrambledHaltonPermutations.Load<uint>(_19245 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_19232 * 2563201u) + (_19243 * 1601u)) + _19252) * 2.4368340678648792163585312664509e-10f;
	                _33360 = true;
	                break;
	            }
	            case 252u:
	            {
	                uint _19193 = 186881u + (_12091 % 1607u);
	                uint _19194 = _19193 / 2u;
	                uint _19201;
	                if ((_19193 & 1u) != 0u)
	                {
	                    _19201 = g_ScrambledHaltonPermutations.Load<uint>(_19194 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19201 = g_ScrambledHaltonPermutations.Load<uint>(_19194 * 4 + 0) & 65535u;
	                }
	                uint _20855 = 186881u + ((_12091 / 1607u) % 1607u);
	                uint _19205 = _20855 / 2u;
	                uint _19212;
	                if ((_20855 & 1u) != 0u)
	                {
	                    _19212 = g_ScrambledHaltonPermutations.Load<uint>(_19205 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19212 = g_ScrambledHaltonPermutations.Load<uint>(_19205 * 4 + 0) & 65535u;
	                }
	                uint _20856 = 186881u + ((_12091 / 2582449u) % 1607u);
	                uint _19214 = _20856 / 2u;
	                uint _19221;
	                if ((_20856 & 1u) != 0u)
	                {
	                    _19221 = g_ScrambledHaltonPermutations.Load<uint>(_19214 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19221 = g_ScrambledHaltonPermutations.Load<uint>(_19214 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_19201 * 2582449u) + (_19212 * 1607u)) + _19221) * 2.4096408202112229446356650441885e-10f;
	                _33360 = true;
	                break;
	            }
	            case 253u:
	            {
	                uint _9686 = _12091 % 1609u;
	                uint _19163 = (188488u + _9686) / 2u;
	                uint _19170;
	                if ((_9686 & 1u) != 0u)
	                {
	                    _19170 = g_ScrambledHaltonPermutations.Load<uint>(_19163 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19170 = g_ScrambledHaltonPermutations.Load<uint>(_19163 * 4 + 0) & 65535u;
	                }
	                uint _19173 = (_12091 / 1609u) % 1609u;
	                uint _19174 = (188488u + _19173) / 2u;
	                uint _19181;
	                if ((_19173 & 1u) != 0u)
	                {
	                    _19181 = g_ScrambledHaltonPermutations.Load<uint>(_19174 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19181 = g_ScrambledHaltonPermutations.Load<uint>(_19174 * 4 + 0) & 65535u;
	                }
	                uint _9691 = (_12091 / 2588881u) % 1609u;
	                uint _19183 = (188488u + _9691) / 2u;
	                uint _19190;
	                if ((_9691 & 1u) != 0u)
	                {
	                    _19190 = g_ScrambledHaltonPermutations.Load<uint>(_19183 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19190 = g_ScrambledHaltonPermutations.Load<uint>(_19183 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_19170 * 2588881u) + (_19181 * 1609u)) + _19190) * 2.4006663323916654917411506175995e-10f;
	                _33360 = true;
	                break;
	            }
	            case 254u:
	            {
	                uint _19131 = 190097u + (_12091 % 1613u);
	                uint _19132 = _19131 / 2u;
	                uint _19139;
	                if ((_19131 & 1u) != 0u)
	                {
	                    _19139 = g_ScrambledHaltonPermutations.Load<uint>(_19132 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19139 = g_ScrambledHaltonPermutations.Load<uint>(_19132 * 4 + 0) & 65535u;
	                }
	                uint _20851 = 190097u + ((_12091 / 1613u) % 1613u);
	                uint _19143 = _20851 / 2u;
	                uint _19150;
	                if ((_20851 & 1u) != 0u)
	                {
	                    _19150 = g_ScrambledHaltonPermutations.Load<uint>(_19143 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19150 = g_ScrambledHaltonPermutations.Load<uint>(_19143 * 4 + 0) & 65535u;
	                }
	                uint _20852 = 190097u + ((_12091 / 2601769u) % 1613u);
	                uint _19152 = _20852 / 2u;
	                uint _19159;
	                if ((_20852 & 1u) != 0u)
	                {
	                    _19159 = g_ScrambledHaltonPermutations.Load<uint>(_19152 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19159 = g_ScrambledHaltonPermutations.Load<uint>(_19152 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_19139 * 2601769u) + (_19150 * 1613u)) + _19159) * 2.3828508610712617610261077061296e-10f;
	                _33360 = true;
	                break;
	            }
	            case 255u:
	            {
	                uint _9668 = _12091 % 1619u;
	                uint _19101 = (191710u + _9668) / 2u;
	                uint _19108;
	                if ((_9668 & 1u) != 0u)
	                {
	                    _19108 = g_ScrambledHaltonPermutations.Load<uint>(_19101 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19108 = g_ScrambledHaltonPermutations.Load<uint>(_19101 * 4 + 0) & 65535u;
	                }
	                uint _19111 = (_12091 / 1619u) % 1619u;
	                uint _19112 = (191710u + _19111) / 2u;
	                uint _19119;
	                if ((_19111 & 1u) != 0u)
	                {
	                    _19119 = g_ScrambledHaltonPermutations.Load<uint>(_19112 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19119 = g_ScrambledHaltonPermutations.Load<uint>(_19112 * 4 + 0) & 65535u;
	                }
	                uint _9673 = (_12091 / 2621161u) % 1619u;
	                uint _19121 = (191710u + _9673) / 2u;
	                uint _19128;
	                if ((_9673 & 1u) != 0u)
	                {
	                    _19128 = g_ScrambledHaltonPermutations.Load<uint>(_19121 * 4 + 0) >> uint(16);
	                }
	                else
	                {
	                    _19128 = g_ScrambledHaltonPermutations.Load<uint>(_19121 * 4 + 0) & 65535u;
	                }
	                _33359 = float(((_19108 * 2621161u) + (_19119 * 1619u)) + _19128) * 2.3564564188838232894340762868524e-10f;
	                _33360 = true;
	                break;
	            }
	            default:
	            {
	                _33359 = _2;
	                _33360 = false;
	                break;
	            }
	        }
	        if (_33360)
	        {
	            _33363 = _33359;
	            break;
	        }
	        _33363 = 0.0f;
	        break;
	    } while(false);
	    g_RandomSamples[gl_GlobalInvocationID.xyz] = float4(_19097, _33363, 0.0f, 0.0f);
	}
	
	[numthreads(8, 8, 1)]
	void MainCs(SPIRV_Cross_Input stage_input)
	{
	    gl_GlobalInvocationID = stage_input.gl_GlobalInvocationID;
	    MainCs_inner();
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
}
