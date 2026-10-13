//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Compute shader BC7 texture compression";
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
	DynamicCombo( D_4x4, 0..1 );
	
	RWTexture2D<float4> OutputBC7Texture < Attribute("OutputBC7Texture"); >;
	RWTexture2D<float4> OutputBC7Texture_1x1 < Attribute("OutputBC7Texture_1x1"); >;
	RWTexture2D<float4> OutputBC7Texture_2x2 < Attribute("OutputBC7Texture_2x2"); >;
	int g_nMipLevel < Attribute("MipLevel"); UiType(Slider); >;
	Texture2D g_tSrc < Attribute("SrcTex"); SrgbRead(false); >;
	float2 g_vImageSize < Attribute("ImageSize"); UiType(VectorText); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	cbuffer _Globals_ : register(b0, space0)
	{
	    float2 _Globals_1_g_vImageSize : packoffset(c0);
	    uint _Globals_1_g_nMipLevel : packoffset(c0.z);
	};
	
	Texture2D<float4> g_tSrc : register(t30, space0);
	SamplerState AddressU_Clamp_AddressV_Clamp_Filter_MinMagLinearMipPoint : register(s14, space0);
	RWTexture2D<uint4> OutputBC7Texture : register(u158, space0);
	
	static uint3 gl_GlobalInvocationID;
	struct SPIRV_Cross_Input
	{
	    uint3 gl_GlobalInvocationID : SV_DispatchThreadID;
	};
	
	uint spvBitfieldInsert(uint Base, uint Insert, uint Offset, uint Count)
	{
	    uint Mask = Count == 32 ? 0xffffffff : (((1u << Count) - 1) << (Offset & 31));
	    return (Base & ~Mask) | ((Insert << Offset) & Mask);
	}
	
	uint2 spvBitfieldInsert(uint2 Base, uint2 Insert, uint Offset, uint Count)
	{
	    uint Mask = Count == 32 ? 0xffffffff : (((1u << Count) - 1) << (Offset & 31));
	    return (Base & ~Mask) | ((Insert << Offset) & Mask);
	}
	
	uint3 spvBitfieldInsert(uint3 Base, uint3 Insert, uint Offset, uint Count)
	{
	    uint Mask = Count == 32 ? 0xffffffff : (((1u << Count) - 1) << (Offset & 31));
	    return (Base & ~Mask) | ((Insert << Offset) & Mask);
	}
	
	uint4 spvBitfieldInsert(uint4 Base, uint4 Insert, uint Offset, uint Count)
	{
	    uint Mask = Count == 32 ? 0xffffffff : (((1u << Count) - 1) << (Offset & 31));
	    return (Base & ~Mask) | ((Insert << Offset) & Mask);
	}
	
	void MainCs_inner()
	{
	    do
	    {
	        uint2 _16748 = uint2(_Globals_1_g_vImageSize.xy * 0.25f.xx);
	        if (any(bool2(gl_GlobalInvocationID.xy.x >= _16748.x, gl_GlobalInvocationID.xy.y >= _16748.y)))
	        {
	            break;
	        }
	        int _4299;
	        float4 _3448[16];
	        int _13039 = 0;
	        for (;;)
	        {
	            if (!(_13039 < 4))
	            {
	                break;
	            }
	            int _4298;
	            int _13040 = 0;
	            for (;;)
	            {
	                if (!(_13040 < 4))
	                {
	                    break;
	                }
	                _3448[(_13039 * 4) + _13040] = g_tSrc.SampleLevel(AddressU_Clamp_AddressV_Clamp_Filter_MinMagLinearMipPoint, (float2(gl_GlobalInvocationID.xy * uint2(4u, 4u)) + float2(float(_13040) + 0.5f, float(_13039) + 0.5f)) * (1.0f.xx / _Globals_1_g_vImageSize), float(_Globals_1_g_nMipLevel));
	                _4298 = _13040 + 1;
	                _13040 = _4298;
	                continue;
	            }
	            _4299 = _13039 + 1;
	            _13039 = _4299;
	            continue;
	        }
	        float4 _6603[16] = _3448;
	        uint4 _23123;
	        do
	        {
	            int _23989;
	            bool _12885;
	            int _13041 = 0;
	            for (;;)
	            {
	                if (!(_13041 < 16))
	                {
	                    _12885 = false;
	                    break;
	                }
	                if (_6603[_13041].w < 0.99800002574920654296875f)
	                {
	                    _12885 = true;
	                    break;
	                }
	                _23989 = _13041 + 1;
	                _13041 = _23989;
	                continue;
	            }
	            if (_12885)
	            {
	                float4 _13155;
	                _13155 = 0.0f.xxxx;
	                float4 _17199;
	                int _20924;
	                int _16208 = 0;
	                [unroll]
	                for (;;)
	                {
	                    if (!(_16208 < 16))
	                    {
	                        break;
	                    }
	                    _17199 = _13155 + _6603[_16208];
	                    _20924 = _16208 + 1;
	                    _13155 = _17199;
	                    _16208 = _20924;
	                    continue;
	                }
	                float4 _21291 = _13155 * 0.0625f;
	                float4 _13136;
	                float4 _16305;
	                float4 _17114;
	                float4 _17133;
	                _13136 = 0.0f.xxxx;
	                _16305 = 0.0f.xxxx;
	                _17114 = 0.0f.xxxx;
	                _17133 = 0.0f.xxxx;
	                float4 _7775;
	                float4 _7776;
	                float4 _7777;
	                int _18752;
	                float4 _20748;
	                int _17017 = 0;
	                [unroll]
	                for (;;)
	                {
	                    if (!(_17017 < 16))
	                    {
	                        break;
	                    }
	                    float4 _6911 = _6603[_17017] - _21291;
	                    _7775 = _13136 + (_6911 * _6911.x);
	                    _7776 = _16305 + (_6911 * _6911.y);
	                    _7777 = _17114 + (_6911 * _6911.z);
	                    _20748 = _17133 + (_6911 * _6911.w);
	                    _18752 = _17017 + 1;
	                    _13136 = _7775;
	                    _16305 = _7776;
	                    _17114 = _7777;
	                    _17133 = _20748;
	                    _17017 = _18752;
	                    continue;
	                }
	                float4 _13156;
	                _13156 = 1.0f.xxxx;
	                int _6339;
	                float4 _8238;
	                int _16209 = 0;
	                [unroll]
	                for (;;)
	                {
	                    if (!(_16209 < 8))
	                    {
	                        break;
	                    }
	                    float4 _12825 = (((_13136 * _13156.x) + (_16305 * _13156.y)) + (_17114 * _13156.z)) + (_17133 * _13156.w);
	                    _8238 = _12825 * rsqrt(max(dot(_12825, _12825), 9.9999999747524270787835121154785e-07f));
	                    _6339 = _16209 + 1;
	                    _13156 = _8238;
	                    _16209 = _6339;
	                    continue;
	                }
	                float4 _12501;
	                if (dot(_13156, _13156) < 0.5f)
	                {
	                    _12501 = normalize(1.0f.xxxx);
	                }
	                else
	                {
	                    _12501 = _13156;
	                }
	                float _13137;
	                float _16324;
	                _13137 = -1000000000.0f;
	                _16324 = 1000000000.0f;
	                float _16925;
	                float _22816;
	                uint _24638;
	                uint _17018 = 0u;
	                for (;;)
	                {
	                    if (!(_17018 < 16u))
	                    {
	                        break;
	                    }
	                    float _15242 = dot(_6603[_17018] - _21291, _12501);
	                    _16925 = min(_16324, _15242);
	                    _22816 = max(_13137, _15242);
	                    _24638 = _17018 + 1u;
	                    _13137 = _22816;
	                    _16324 = _16925;
	                    _17018 = _24638;
	                    continue;
	                }
	                float4 _17231 = clamp(_21291 + (_12501 * _16324), 0.0f.xxxx, 1.0f.xxxx);
	                float4 _24558 = clamp(_21291 + (_12501 * _13137), 0.0f.xxxx, 1.0f.xxxx);
	                bool4 _6853 = (dot(_17231, float4(1.0f, 1.0f, 1.0f, 0.0f)) > dot(_24558, float4(1.0f, 1.0f, 1.0f, 0.0f))).xxxx;
	                float4 _13138;
	                float4 _16325;
	                _13138 = float4(_6853.x ? _24558.x : _17231.x, _6853.y ? _24558.y : _17231.y, _6853.z ? _24558.z : _17231.z, _6853.w ? _24558.w : _17231.w);
	                _16325 = float4(_6853.x ? _17231.x : _24558.x, _6853.y ? _17231.y : _24558.y, _6853.z ? _17231.z : _24558.z, _6853.w ? _17231.w : _24558.w);
	                int _8087;
	                float4 _6559;
	                float4 _14382;
	                int _17019 = 0;
	                for (;;)
	                {
	                    if (!(_17019 < 2))
	                    {
	                        break;
	                    }
	                    float4 _15667 = _16325 - _13138;
	                    float _7122 = dot(_15667, _15667);
	                    if (_7122 < 9.9999997473787516355514526367188e-05f)
	                    {
	                        break;
	                    }
	                    float4 _13139;
	                    int _16306;
	                    float4 _17115;
	                    int _17134;
	                    _13139 = 0.0f.xxxx;
	                    _16306 = 0;
	                    _17115 = 0.0f.xxxx;
	                    _17134 = 0;
	                    int _8896;
	                    float4 _13140;
	                    float4 _14891;
	                    int _16307;
	                    int _18360;
	                    int _17020 = 0;
	                    for (;;)
	                    {
	                        if (!(_17020 < 16))
	                        {
	                            break;
	                        }
	                        int _23276 = int((saturate(dot(_6603[_17020] - _13138, _15667) / _7122) * 15.0f) + 0.5f);
	                        if (_23276 == 0)
	                        {
	                            _13140 = _13139;
	                            _16307 = _16306;
	                            _14891 = _17115 + _6603[_17020];
	                            _18360 = _17134 + 1;
	                        }
	                        else
	                        {
	                            int _13212;
	                            float4 _15670;
	                            if (_23276 == 15)
	                            {
	                                _13212 = _16306 + 1;
	                                _15670 = _13139 + _6603[_17020];
	                            }
	                            else
	                            {
	                                _13212 = _16306;
	                                _15670 = _13139;
	                            }
	                            _13140 = _15670;
	                            _16307 = _13212;
	                            _14891 = _17115;
	                            _18360 = _17134;
	                        }
	                        _8896 = _17020 + 1;
	                        _13139 = _13140;
	                        _16306 = _16307;
	                        _17115 = _14891;
	                        _17134 = _18360;
	                        _17020 = _8896;
	                        continue;
	                    }
	                    if (_17134 > 0)
	                    {
	                        _6559 = round((_17115 / float(_17134).xxxx) * 255.0f) * 0.0039215688593685626983642578125f.xxxx;
	                    }
	                    else
	                    {
	                        _6559 = _13138;
	                    }
	                    if (_16306 > 0)
	                    {
	                        _14382 = round((_13139 / float(_16306).xxxx) * 255.0f) * 0.0039215688593685626983642578125f.xxxx;
	                    }
	                    else
	                    {
	                        _14382 = _16325;
	                    }
	                    _8087 = _17019 + 1;
	                    _13138 = _6559;
	                    _16325 = _14382;
	                    _17019 = _8087;
	                    continue;
	                }
	                float4 _6656 = float4(uint4((clamp(_13138, 0.0f.xxxx, 1.0f.xxxx) * 255.0f) + 0.5f.xxxx));
	                float4 _7539 = float4(uint4((clamp(_16325, 0.0f.xxxx, 1.0f.xxxx) * 255.0f) + 0.5f.xxxx));
	                float4 _21909 = (_7539 - _6656) * 0.0039215688593685626983642578125f;
	                float4 _18308 = _21909 * (1.0f / (dot(_21909, _21909) + 9.9999997473787516355514526367188e-05f));
	                float _17055 = dot(_6656, _18308) * 0.0039215688593685626983642578125f;
	                uint2 _13157;
	                _13157 = uint2(0u, 0u);
	                int _8515;
	                uint2 _9504;
	                int _16210 = 0;
	                for (;;)
	                {
	                    if (!(_16210 < 8))
	                    {
	                        break;
	                    }
	                    _9504 = _13157;
	                    _9504.x = _13157.x | (uint((15.0f * saturate(dot(_6603[_16210], _18308) - _17055)) + 0.5f) << uint(_16210 * 4));
	                    _8515 = _16210 + 1;
	                    _13157 = _9504;
	                    _16210 = _8515;
	                    continue;
	                }
	                uint2 _13158;
	                _13158 = _13157;
	                int _8516;
	                uint2 _9505;
	                int _16211 = 0;
	                for (;;)
	                {
	                    if (!(_16211 < 8))
	                    {
	                        break;
	                    }
	                    _9505 = _13158;
	                    _9505.y = _13158.y | (uint((15.0f * saturate(dot(_6603[8 + _16211], _18308) - _17055)) + 0.5f) << uint(_16211 * 4));
	                    _8516 = _16211 + 1;
	                    _13158 = _9505;
	                    _16211 = _8516;
	                    continue;
	                }
	                bool _15644 = (_13158.x & 8u) != 0u;
	                uint2 _21166;
	                if (_15644)
	                {
	                    _21166 = uint2(~_13158.x, ~_13158.y);
	                }
	                else
	                {
	                    _21166 = _13158;
	                }
	                bool4 _19656 = _15644.xxxx;
	                float4 _17592 = float4(_19656.x ? _6656.x : _7539.x, _19656.y ? _6656.y : _7539.y, _19656.z ? _6656.z : _7539.z, _19656.w ? _6656.w : _7539.w);
	                float4 _23068 = float4(_19656.x ? _7539.x : _6656.x, _19656.y ? _7539.y : _6656.y, _19656.z ? _7539.z : _6656.z, _19656.w ? _7539.w : _6656.w);
	                uint4 _16326;
	                _16326 = uint4(0u, 0u, 0u, 0u);
	                int _10579;
	                uint _20682;
	                uint4 _19660;
	                uint _13141 = 64u;
	                int _17021 = 0;
	                [unroll]
	                for (;;)
	                {
	                    if (!(_17021 < 7))
	                    {
	                        break;
	                    }
	                    uint _23694 = uint(_17021 & 31);
	                    uint _16826 = min(uint(7 - _17021), (32u - _23694));
	                    switch (uint(_17021 >> 5))
	                    {
	                        case 0u:
	                        {
	                            uint4 _19242 = _16326;
	                            _19242.x = spvBitfieldInsert(_16326.x, _13141, _23694, _16826);
	                            _19660 = _19242;
	                            break;
	                        }
	                        case 1u:
	                        {
	                            uint4 _19241 = _16326;
	                            _19241.y = spvBitfieldInsert(_16326.y, _13141, _23694, _16826);
	                            _19660 = _19241;
	                            break;
	                        }
	                        case 2u:
	                        {
	                            _19660 = _16326;
	                            break;
	                        }
	                        default:
	                        {
	                            _19660 = _16326;
	                            break;
	                        }
	                    }
	                    _20682 = _13141 >> _16826;
	                    _10579 = _17021 + int(_16826);
	                    _13141 = _20682;
	                    _16326 = _19660;
	                    _17021 = _10579;
	                    continue;
	                }
	                uint _10056 = uint(_23068.x) >> uint(1);
	                uint4 _16327;
	                _16327 = _16326;
	                int _10580;
	                uint _20683;
	                uint4 _19661;
	                uint _13142 = _10056;
	                int _17022 = 7;
	                [unroll]
	                for (;;)
	                {
	                    if (!(_17022 < 14))
	                    {
	                        break;
	                    }
	                    uint _23695 = uint(_17022 & 31);
	                    uint _16827 = min(uint(14 - _17022), (32u - _23695));
	                    switch (uint(_17022 >> 5))
	                    {
	                        case 0u:
	                        {
	                            uint4 _19244 = _16327;
	                            _19244.x = spvBitfieldInsert(_16327.x, _13142, _23695, _16827);
	                            _19661 = _19244;
	                            break;
	                        }
	                        case 1u:
	                        {
	                            uint4 _19243 = _16327;
	                            _19243.y = spvBitfieldInsert(_16327.y, _13142, _23695, _16827);
	                            _19661 = _19243;
	                            break;
	                        }
	                        case 2u:
	                        {
	                            _19661 = _16327;
	                            break;
	                        }
	                        default:
	                        {
	                            _19661 = _16327;
	                            break;
	                        }
	                    }
	                    _20683 = _13142 >> _16827;
	                    _10580 = _17022 + int(_16827);
	                    _13142 = _20683;
	                    _16327 = _19661;
	                    _17022 = _10580;
	                    continue;
	                }
	                uint _10057 = uint(_17592.x) >> uint(1);
	                uint4 _16328;
	                _16328 = _16327;
	                int _10581;
	                uint _20684;
	                uint4 _19662;
	                uint _13143 = _10057;
	                int _17023 = 14;
	                [unroll]
	                for (;;)
	                {
	                    if (!(_17023 < 21))
	                    {
	                        break;
	                    }
	                    uint _23696 = uint(_17023 & 31);
	                    uint _16828 = min(uint(21 - _17023), (32u - _23696));
	                    switch (uint(_17023 >> 5))
	                    {
	                        case 0u:
	                        {
	                            uint4 _19246 = _16328;
	                            _19246.x = spvBitfieldInsert(_16328.x, _13143, _23696, _16828);
	                            _19662 = _19246;
	                            break;
	                        }
	                        case 1u:
	                        {
	                            uint4 _19245 = _16328;
	                            _19245.y = spvBitfieldInsert(_16328.y, _13143, _23696, _16828);
	                            _19662 = _19245;
	                            break;
	                        }
	                        case 2u:
	                        {
	                            _19662 = _16328;
	                            break;
	                        }
	                        default:
	                        {
	                            _19662 = _16328;
	                            break;
	                        }
	                    }
	                    _20684 = _13143 >> _16828;
	                    _10581 = _17023 + int(_16828);
	                    _13143 = _20684;
	                    _16328 = _19662;
	                    _17023 = _10581;
	                    continue;
	                }
	                uint _10058 = uint(_23068.y) >> uint(1);
	                uint4 _16329;
	                _16329 = _16328;
	                int _10582;
	                uint _20685;
	                uint4 _19663;
	                uint _13144 = _10058;
	                int _17025 = 21;
	                [unroll]
	                for (;;)
	                {
	                    if (!(_17025 < 28))
	                    {
	                        break;
	                    }
	                    uint _23697 = uint(_17025 & 31);
	                    uint _16829 = min(uint(28 - _17025), (32u - _23697));
	                    switch (uint(_17025 >> 5))
	                    {
	                        case 0u:
	                        {
	                            uint4 _19248 = _16329;
	                            _19248.x = spvBitfieldInsert(_16329.x, _13144, _23697, _16829);
	                            _19663 = _19248;
	                            break;
	                        }
	                        case 1u:
	                        {
	                            uint4 _19247 = _16329;
	                            _19247.y = spvBitfieldInsert(_16329.y, _13144, _23697, _16829);
	                            _19663 = _19247;
	                            break;
	                        }
	                        case 2u:
	                        {
	                            _19663 = _16329;
	                            break;
	                        }
	                        default:
	                        {
	                            _19663 = _16329;
	                            break;
	                        }
	                    }
	                    _20685 = _13144 >> _16829;
	                    _10582 = _17025 + int(_16829);
	                    _13144 = _20685;
	                    _16329 = _19663;
	                    _17025 = _10582;
	                    continue;
	                }
	                uint _10059 = uint(_17592.y) >> uint(1);
	                uint4 _16330;
	                _16330 = _16329;
	                int _10583;
	                uint _20686;
	                uint4 _19664;
	                uint _13145 = _10059;
	                int _17026 = 28;
	                [unroll]
	                for (;;)
	                {
	                    if (!(_17026 < 35))
	                    {
	                        break;
	                    }
	                    uint _23698 = uint(_17026 & 31);
	                    uint _16830 = min(uint(35 - _17026), (32u - _23698));
	                    switch (uint(_17026 >> 5))
	                    {
	                        case 0u:
	                        {
	                            uint4 _19250 = _16330;
	                            _19250.x = spvBitfieldInsert(_16330.x, _13145, _23698, _16830);
	                            _19664 = _19250;
	                            break;
	                        }
	                        case 1u:
	                        {
	                            uint4 _19249 = _16330;
	                            _19249.y = spvBitfieldInsert(_16330.y, _13145, _23698, _16830);
	                            _19664 = _19249;
	                            break;
	                        }
	                        case 2u:
	                        {
	                            _19664 = _16330;
	                            break;
	                        }
	                        default:
	                        {
	                            _19664 = _16330;
	                            break;
	                        }
	                    }
	                    _20686 = _13145 >> _16830;
	                    _10583 = _17026 + int(_16830);
	                    _13145 = _20686;
	                    _16330 = _19664;
	                    _17026 = _10583;
	                    continue;
	                }
	                uint _10060 = uint(_23068.z) >> uint(1);
	                uint4 _16331;
	                _16331 = _16330;
	                int _10584;
	                uint _20687;
	                uint4 _19665;
	                uint _13146 = _10060;
	                int _17027 = 35;
	                [unroll]
	                for (;;)
	                {
	                    if (!(_17027 < 42))
	                    {
	                        break;
	                    }
	                    uint _23699 = uint(_17027 & 31);
	                    uint _16831 = min(uint(42 - _17027), (32u - _23699));
	                    switch (uint(_17027 >> 5))
	                    {
	                        case 0u:
	                        {
	                            uint4 _19252 = _16331;
	                            _19252.x = spvBitfieldInsert(_16331.x, _13146, _23699, _16831);
	                            _19665 = _19252;
	                            break;
	                        }
	                        case 1u:
	                        {
	                            uint4 _19251 = _16331;
	                            _19251.y = spvBitfieldInsert(_16331.y, _13146, _23699, _16831);
	                            _19665 = _19251;
	                            break;
	                        }
	                        case 2u:
	                        {
	                            _19665 = _16331;
	                            break;
	                        }
	                        default:
	                        {
	                            _19665 = _16331;
	                            break;
	                        }
	                    }
	                    _20687 = _13146 >> _16831;
	                    _10584 = _17027 + int(_16831);
	                    _13146 = _20687;
	                    _16331 = _19665;
	                    _17027 = _10584;
	                    continue;
	                }
	                uint _10061 = uint(_17592.z) >> uint(1);
	                uint4 _16332;
	                _16332 = _16331;
	                int _10585;
	                uint _20688;
	                uint4 _19666;
	                uint _13147 = _10061;
	                int _17028 = 42;
	                [unroll]
	                for (;;)
	                {
	                    if (!(_17028 < 49))
	                    {
	                        break;
	                    }
	                    uint _23700 = uint(_17028 & 31);
	                    uint _16832 = min(uint(49 - _17028), (32u - _23700));
	                    switch (uint(_17028 >> 5))
	                    {
	                        case 0u:
	                        {
	                            uint4 _19254 = _16332;
	                            _19254.x = spvBitfieldInsert(_16332.x, _13147, _23700, _16832);
	                            _19666 = _19254;
	                            break;
	                        }
	                        case 1u:
	                        {
	                            uint4 _19253 = _16332;
	                            _19253.y = spvBitfieldInsert(_16332.y, _13147, _23700, _16832);
	                            _19666 = _19253;
	                            break;
	                        }
	                        case 2u:
	                        {
	                            _19666 = _16332;
	                            break;
	                        }
	                        default:
	                        {
	                            _19666 = _16332;
	                            break;
	                        }
	                    }
	                    _20688 = _13147 >> _16832;
	                    _10585 = _17028 + int(_16832);
	                    _13147 = _20688;
	                    _16332 = _19666;
	                    _17028 = _10585;
	                    continue;
	                }
	                uint _10062 = uint(_23068.w) >> uint(1);
	                uint4 _16333;
	                _16333 = _16332;
	                int _10586;
	                uint _20689;
	                uint4 _19667;
	                uint _13148 = _10062;
	                int _17029 = 49;
	                [unroll]
	                for (;;)
	                {
	                    if (!(_17029 < 56))
	                    {
	                        break;
	                    }
	                    uint _23701 = uint(_17029 & 31);
	                    uint _16833 = min(uint(56 - _17029), (32u - _23701));
	                    switch (uint(_17029 >> 5))
	                    {
	                        case 0u:
	                        {
	                            uint4 _19256 = _16333;
	                            _19256.x = spvBitfieldInsert(_16333.x, _13148, _23701, _16833);
	                            _19667 = _19256;
	                            break;
	                        }
	                        case 1u:
	                        {
	                            uint4 _19255 = _16333;
	                            _19255.y = spvBitfieldInsert(_16333.y, _13148, _23701, _16833);
	                            _19667 = _19255;
	                            break;
	                        }
	                        case 2u:
	                        {
	                            _19667 = _16333;
	                            break;
	                        }
	                        default:
	                        {
	                            _19667 = _16333;
	                            break;
	                        }
	                    }
	                    _20689 = _13148 >> _16833;
	                    _10586 = _17029 + int(_16833);
	                    _13148 = _20689;
	                    _16333 = _19667;
	                    _17029 = _10586;
	                    continue;
	                }
	                uint _10063 = uint(_17592.w) >> uint(1);
	                uint4 _16334;
	                _16334 = _16333;
	                int _10587;
	                uint _20690;
	                uint4 _19668;
	                uint _13149 = _10063;
	                int _17030 = 56;
	                [unroll]
	                for (;;)
	                {
	                    if (!(_17030 < 63))
	                    {
	                        break;
	                    }
	                    uint _23702 = uint(_17030 & 31);
	                    uint _16834 = min(uint(63 - _17030), (32u - _23702));
	                    switch (uint(_17030 >> 5))
	                    {
	                        case 0u:
	                        {
	                            uint4 _19258 = _16334;
	                            _19258.x = spvBitfieldInsert(_16334.x, _13149, _23702, _16834);
	                            _19668 = _19258;
	                            break;
	                        }
	                        case 1u:
	                        {
	                            uint4 _19257 = _16334;
	                            _19257.y = spvBitfieldInsert(_16334.y, _13149, _23702, _16834);
	                            _19668 = _19257;
	                            break;
	                        }
	                        case 2u:
	                        {
	                            _19668 = _16334;
	                            break;
	                        }
	                        default:
	                        {
	                            _19668 = _16334;
	                            break;
	                        }
	                    }
	                    _20690 = _13149 >> _16834;
	                    _10587 = _17030 + int(_16834);
	                    _13149 = _20690;
	                    _16334 = _19668;
	                    _17030 = _10587;
	                    continue;
	                }
	                uint4 _16335;
	                _16335 = _16334;
	                int _10588;
	                uint _20691;
	                uint4 _19669;
	                uint _13150 = 1u;
	                int _17031 = 63;
	                [unroll]
	                for (;;)
	                {
	                    if (!(_17031 < 64))
	                    {
	                        break;
	                    }
	                    uint _23703 = uint(_17031 & 31);
	                    uint _16835 = min(uint(64 - _17031), (32u - _23703));
	                    switch (uint(_17031 >> 5))
	                    {
	                        case 0u:
	                        {
	                            uint4 _19261 = _16335;
	                            _19261.x = spvBitfieldInsert(_16335.x, _13150, _23703, _16835);
	                            _19669 = _19261;
	                            break;
	                        }
	                        case 1u:
	                        {
	                            uint4 _19260 = _16335;
	                            _19260.y = spvBitfieldInsert(_16335.y, _13150, _23703, _16835);
	                            _19669 = _19260;
	                            break;
	                        }
	                        case 2u:
	                        {
	                            _19669 = _16335;
	                            break;
	                        }
	                        default:
	                        {
	                            _19669 = _16335;
	                            break;
	                        }
	                    }
	                    _20691 = _13150 >> _16835;
	                    _10588 = _17031 + int(_16835);
	                    _13150 = _20691;
	                    _16335 = _19669;
	                    _17031 = _10588;
	                    continue;
	                }
	                uint4 _23135 = _16335;
	                _23135.z = _21166.x;
	                _23135.w = _21166.y;
	                _23123 = _23135;
	                break;
	            }
	            float3 _13159;
	            _13159 = 0.0f.xxx;
	            int _9913;
	            float3 _21805;
	            int _16218 = 0;
	            for (;;)
	            {
	                if (!(_16218 < 16))
	                {
	                    break;
	                }
	                _21805 = _13159 + _6603[_16218].xyz;
	                _9913 = _16218 + 1;
	                _13159 = _21805;
	                _16218 = _9913;
	                continue;
	            }
	            float3 _12972 = _13159 * 0.0625f.xxx;
	            float3x3 _20506 = float3x3(0.0f.xxx, 0.0f.xxx, 0.0f.xxx);
	            int _10608;
	            int _13042 = 0;
	            for (;;)
	            {
	                if (!(_13042 < 16))
	                {
	                    break;
	                }
	                float3 _12822 = _6603[_13042].xyz - _12972;
	                float _6827 = _12822.x;
	                _20506[0].x += (_6827 * _6827);
	                float _6828 = _12822.y;
	                float _22952 = _6827 * _6828;
	                _20506[0].y += _22952;
	                _20506[1].x += _22952;
	                float _6829 = _12822.z;
	                float _22953 = _6827 * _6829;
	                _20506[0].z += _22953;
	                _20506[2].x += _22953;
	                _20506[1].y += (_6828 * _6828);
	                float _18844 = _6828 * _6829;
	                _20506[1].z += _18844;
	                _20506[2].y += _18844;
	                _20506[2].z += (_6829 * _6829);
	                _10608 = _13042 + 1;
	                _13042 = _10608;
	                continue;
	            }
	            float3x3 _23854 = float3x3(float3(1.0f, 0.0f, 0.0f), float3(0.0f, 1.0f, 0.0f), float3(0.0f, 0.0f, 1.0f));
	            int _21567;
	            int _13043 = 0;
	            for (;;)
	            {
	                if (!(_13043 < 10))
	                {
	                    break;
	                }
	                float _23755 = _20506[0].y;
	                float _24236 = abs(_23755);
	                float _20289 = _20506[0].z;
	                bool _11754 = abs(_20289) > _24236;
	                float _22864;
	                if (_11754)
	                {
	                    _22864 = abs(_20506[0].z);
	                }
	                else
	                {
	                    _22864 = _24236;
	                }
	                float _6983 = _20506[1].z;
	                bool _11755 = abs(_6983) > _22864;
	                float _24840;
	                if (_11755)
	                {
	                    _24840 = abs(_20506[1].z);
	                }
	                else
	                {
	                    _24840 = _22864;
	                }
	                int _9005 = _11755 ? 2 : (_11754 ? 2 : 1);
	                int _16226 = int(_11755);
	                if (_24840 < 9.9999997473787516355514526367188e-06f)
	                {
	                    break;
	                }
	                float _8600 = _20506[_16226][_16226];
	                float _8524 = _20506[_9005][_9005];
	                float _12024 = _20506[_16226][_9005];
	                float _6561 = _8524 - _8600;
	                float _9028;
	                if (abs(_6561) < 9.9999997473787516355514526367188e-06f)
	                {
	                    _9028 = 1.57000005245208740234375f;
	                }
	                else
	                {
	                    _9028 = atan2(2.0f * _12024, _6561);
	                }
	                float _24603 = 0.5f * _9028;
	                float _14203 = cos(_24603);
	                float _17205 = sin(_24603);
	                int _23990;
	                int _13044 = 0;
	                for (;;)
	                {
	                    if (!(_13044 < 3))
	                    {
	                        break;
	                    }
	                    bool _12886;
	                    if (_13044 != _16226)
	                    {
	                        _12886 = _13044 != _9005;
	                    }
	                    else
	                    {
	                        _12886 = false;
	                    }
	                    if (_12886)
	                    {
	                        float _8525 = _20506[_13044][_16226];
	                        float _13973 = _20506[_13044][_9005];
	                        float _19722 = (_8525 * _14203) - (_13973 * _17205);
	                        int _21437 = _13044 * 3;
	                        switch (_21437 + _16226)
	                        {
	                            case 0:
	                            {
	                                _20506[0].x = _19722;
	                                break;
	                            }
	                            case 1:
	                            {
	                                _20506[0].y = _19722;
	                                break;
	                            }
	                            case 2:
	                            {
	                                _20506[0].z = _19722;
	                                break;
	                            }
	                            case 3:
	                            {
	                                _20506[1].x = _19722;
	                                break;
	                            }
	                            case 4:
	                            {
	                                _20506[1].y = _19722;
	                                break;
	                            }
	                            case 5:
	                            {
	                                _20506[1].z = _19722;
	                                break;
	                            }
	                            case 6:
	                            {
	                                _20506[2].x = _19722;
	                                break;
	                            }
	                            case 7:
	                            {
	                                _20506[2].y = _19722;
	                                break;
	                            }
	                            case 8:
	                            {
	                                _20506[2].z = _19722;
	                                break;
	                            }
	                            default:
	                            {
	                                break;
	                            }
	                        }
	                        float _18807 = _20506[_13044][_16226];
	                        switch ((_11755 ? 3 : 0) + _13044)
	                        {
	                            case 0:
	                            {
	                                _20506[0].x = _18807;
	                                break;
	                            }
	                            case 1:
	                            {
	                                _20506[0].y = _18807;
	                                break;
	                            }
	                            case 2:
	                            {
	                                _20506[0].z = _18807;
	                                break;
	                            }
	                            case 3:
	                            {
	                                _20506[1].x = _18807;
	                                break;
	                            }
	                            case 4:
	                            {
	                                _20506[1].y = _18807;
	                                break;
	                            }
	                            case 5:
	                            {
	                                _20506[1].z = _18807;
	                                break;
	                            }
	                            case 6:
	                            {
	                                _20506[2].x = _18807;
	                                break;
	                            }
	                            case 7:
	                            {
	                                _20506[2].y = _18807;
	                                break;
	                            }
	                            case 8:
	                            {
	                                _20506[2].z = _18807;
	                                break;
	                            }
	                            default:
	                            {
	                                break;
	                            }
	                        }
	                        float _20014 = (_13973 * _14203) + (_8525 * _17205);
	                        switch (_21437 + _9005)
	                        {
	                            case 0:
	                            {
	                                _20506[0].x = _20014;
	                                break;
	                            }
	                            case 1:
	                            {
	                                _20506[0].y = _20014;
	                                break;
	                            }
	                            case 2:
	                            {
	                                _20506[0].z = _20014;
	                                break;
	                            }
	                            case 3:
	                            {
	                                _20506[1].x = _20014;
	                                break;
	                            }
	                            case 4:
	                            {
	                                _20506[1].y = _20014;
	                                break;
	                            }
	                            case 5:
	                            {
	                                _20506[1].z = _20014;
	                                break;
	                            }
	                            case 6:
	                            {
	                                _20506[2].x = _20014;
	                                break;
	                            }
	                            case 7:
	                            {
	                                _20506[2].y = _20014;
	                                break;
	                            }
	                            case 8:
	                            {
	                                _20506[2].z = _20014;
	                                break;
	                            }
	                            default:
	                            {
	                                break;
	                            }
	                        }
	                        float _25208 = _20506[_13044][_9005];
	                        switch ((_9005 * 3) + _13044)
	                        {
	                            case 0:
	                            {
	                                _20506[0].x = _25208;
	                                break;
	                            }
	                            case 1:
	                            {
	                                _20506[0].y = _25208;
	                                break;
	                            }
	                            case 2:
	                            {
	                                _20506[0].z = _25208;
	                                break;
	                            }
	                            case 3:
	                            {
	                                _20506[1].x = _25208;
	                                break;
	                            }
	                            case 4:
	                            {
	                                _20506[1].y = _25208;
	                                break;
	                            }
	                            case 5:
	                            {
	                                _20506[1].z = _25208;
	                                break;
	                            }
	                            case 6:
	                            {
	                                _20506[2].x = _25208;
	                                break;
	                            }
	                            case 7:
	                            {
	                                _20506[2].y = _25208;
	                                break;
	                            }
	                            case 8:
	                            {
	                                _20506[2].z = _25208;
	                                break;
	                            }
	                            default:
	                            {
	                                break;
	                            }
	                        }
	                    }
	                    _23990 = _13044 + 1;
	                    _13044 = _23990;
	                    continue;
	                }
	                float _17556 = _14203 * _14203;
	                float _22675 = ((2.0f * _17205) * _14203) * _12024;
	                float _10137 = _17205 * _17205;
	                float _10637 = ((_17556 * _8600) - _22675) + (_10137 * _8524);
	                int _23930 = _11755 ? 3 : 0;
	                switch (_23930 + _16226)
	                {
	                    case 0:
	                    {
	                        _20506[0].x = _10637;
	                        break;
	                    }
	                    case 1:
	                    {
	                        _20506[0].y = _10637;
	                        break;
	                    }
	                    case 2:
	                    {
	                        _20506[0].z = _10637;
	                        break;
	                    }
	                    case 3:
	                    {
	                        _20506[1].x = _10637;
	                        break;
	                    }
	                    case 4:
	                    {
	                        _20506[1].y = _10637;
	                        break;
	                    }
	                    case 5:
	                    {
	                        _20506[1].z = _10637;
	                        break;
	                    }
	                    case 6:
	                    {
	                        _20506[2].x = _10637;
	                        break;
	                    }
	                    case 7:
	                    {
	                        _20506[2].y = _10637;
	                        break;
	                    }
	                    case 8:
	                    {
	                        _20506[2].z = _10637;
	                        break;
	                    }
	                    default:
	                    {
	                        break;
	                    }
	                }
	                float _20268 = ((_10137 * _8600) + _22675) + (_17556 * _8524);
	                int _21935 = _9005 * 3;
	                switch (_21935 + _9005)
	                {
	                    case 0:
	                    {
	                        _20506[0].x = _20268;
	                        break;
	                    }
	                    case 1:
	                    {
	                        _20506[0].y = _20268;
	                        break;
	                    }
	                    case 2:
	                    {
	                        _20506[0].z = _20268;
	                        break;
	                    }
	                    case 3:
	                    {
	                        _20506[1].x = _20268;
	                        break;
	                    }
	                    case 4:
	                    {
	                        _20506[1].y = _20268;
	                        break;
	                    }
	                    case 5:
	                    {
	                        _20506[1].z = _20268;
	                        break;
	                    }
	                    case 6:
	                    {
	                        _20506[2].x = _20268;
	                        break;
	                    }
	                    case 7:
	                    {
	                        _20506[2].y = _20268;
	                        break;
	                    }
	                    case 8:
	                    {
	                        _20506[2].z = _20268;
	                        break;
	                    }
	                    default:
	                    {
	                        break;
	                    }
	                }
	                switch (_23930 + _9005)
	                {
	                    case 0:
	                    {
	                        _20506[0].x = 0.0f;
	                        break;
	                    }
	                    case 1:
	                    {
	                        _20506[0].y = 0.0f;
	                        break;
	                    }
	                    case 2:
	                    {
	                        _20506[0].z = 0.0f;
	                        break;
	                    }
	                    case 3:
	                    {
	                        _20506[1].x = 0.0f;
	                        break;
	                    }
	                    case 4:
	                    {
	                        _20506[1].y = 0.0f;
	                        break;
	                    }
	                    case 5:
	                    {
	                        _20506[1].z = 0.0f;
	                        break;
	                    }
	                    case 6:
	                    {
	                        _20506[2].x = 0.0f;
	                        break;
	                    }
	                    case 7:
	                    {
	                        _20506[2].y = 0.0f;
	                        break;
	                    }
	                    case 8:
	                    {
	                        _20506[2].z = 0.0f;
	                        break;
	                    }
	                    default:
	                    {
	                        break;
	                    }
	                }
	                switch (_21935 + _16226)
	                {
	                    case 0:
	                    {
	                        _20506[0].x = 0.0f;
	                        break;
	                    }
	                    case 1:
	                    {
	                        _20506[0].y = 0.0f;
	                        break;
	                    }
	                    case 2:
	                    {
	                        _20506[0].z = 0.0f;
	                        break;
	                    }
	                    case 3:
	                    {
	                        _20506[1].x = 0.0f;
	                        break;
	                    }
	                    case 4:
	                    {
	                        _20506[1].y = 0.0f;
	                        break;
	                    }
	                    case 5:
	                    {
	                        _20506[1].z = 0.0f;
	                        break;
	                    }
	                    case 6:
	                    {
	                        _20506[2].x = 0.0f;
	                        break;
	                    }
	                    case 7:
	                    {
	                        _20506[2].y = 0.0f;
	                        break;
	                    }
	                    case 8:
	                    {
	                        _20506[2].z = 0.0f;
	                        break;
	                    }
	                    default:
	                    {
	                        break;
	                    }
	                }
	                int _23991;
	                int _13045 = 0;
	                for (;;)
	                {
	                    if (!(_13045 < 3))
	                    {
	                        break;
	                    }
	                    float _8526 = _23854[_13045][_16226];
	                    float _13974 = _23854[_13045][_9005];
	                    float _19723 = (_8526 * _14203) - (_13974 * _17205);
	                    int _21438 = _13045 * 3;
	                    switch (_21438 + _16226)
	                    {
	                        case 0:
	                        {
	                            _23854[0].x = _19723;
	                            break;
	                        }
	                        case 1:
	                        {
	                            _23854[0].y = _19723;
	                            break;
	                        }
	                        case 2:
	                        {
	                            _23854[0].z = _19723;
	                            break;
	                        }
	                        case 3:
	                        {
	                            _23854[1].x = _19723;
	                            break;
	                        }
	                        case 4:
	                        {
	                            _23854[1].y = _19723;
	                            break;
	                        }
	                        case 5:
	                        {
	                            _23854[1].z = _19723;
	                            break;
	                        }
	                        case 6:
	                        {
	                            _23854[2].x = _19723;
	                            break;
	                        }
	                        case 7:
	                        {
	                            _23854[2].y = _19723;
	                            break;
	                        }
	                        case 8:
	                        {
	                            _23854[2].z = _19723;
	                            break;
	                        }
	                        default:
	                        {
	                            break;
	                        }
	                    }
	                    float _20016 = (_13974 * _14203) + (_8526 * _17205);
	                    switch (_21438 + _9005)
	                    {
	                        case 0:
	                        {
	                            _23854[0].x = _20016;
	                            break;
	                        }
	                        case 1:
	                        {
	                            _23854[0].y = _20016;
	                            break;
	                        }
	                        case 2:
	                        {
	                            _23854[0].z = _20016;
	                            break;
	                        }
	                        case 3:
	                        {
	                            _23854[1].x = _20016;
	                            break;
	                        }
	                        case 4:
	                        {
	                            _23854[1].y = _20016;
	                            break;
	                        }
	                        case 5:
	                        {
	                            _23854[1].z = _20016;
	                            break;
	                        }
	                        case 6:
	                        {
	                            _23854[2].x = _20016;
	                            break;
	                        }
	                        case 7:
	                        {
	                            _23854[2].y = _20016;
	                            break;
	                        }
	                        case 8:
	                        {
	                            _23854[2].z = _20016;
	                            break;
	                        }
	                        default:
	                        {
	                            break;
	                        }
	                    }
	                    _23991 = _13045 + 1;
	                    _13045 = _23991;
	                    continue;
	                }
	                _21567 = _13043 + 1;
	                _13043 = _21567;
	                continue;
	            }
	            bool _6405 = _20506[1].y > _20506[0].x;
	            float _22865;
	            if (_6405)
	            {
	                _22865 = _20506[1].y;
	            }
	            else
	            {
	                _22865 = _20506[0].x;
	            }
	            int _22180 = (_20506[2].z > _22865) ? 2 : int(_6405);
	            float3 _11081 = normalize(float3(_23854[0][_22180], _23854[1][_22180], _23854[2][_22180]));
	            bool _21167;
	            if (any(isnan(_11081)))
	            {
	                _21167 = true;
	            }
	            else
	            {
	                float3 _9948 = abs(_11081);
	                _21167 = all(bool3(_9948.x < 9.9999997473787516355514526367188e-05f.xxx.x, _9948.y < 9.9999997473787516355514526367188e-05f.xxx.y, _9948.z < 9.9999997473787516355514526367188e-05f.xxx.z));
	            }
	            bool3 _17965 = _21167.xxx;
	            float4 _25117 = float4(_12972, 0.0f);
	            float4 _24102 = float4(float3(_17965.x ? float3(0.0f, 1.0f, 0.0f).x : _11081.x, _17965.y ? float3(0.0f, 1.0f, 0.0f).y : _11081.y, _17965.z ? float3(0.0f, 1.0f, 0.0f).z : _11081.z), 0.0f);
	            float _13151;
	            float _16336;
	            _13151 = -1000000000.0f;
	            _16336 = 1000000000.0f;
	            float _16926;
	            float _22843;
	            int _24639;
	            int _17032 = 0;
	            for (;;)
	            {
	                if (!(_17032 < 16))
	                {
	                    break;
	                }
	                float _15243 = dot(_6603[_17032] - _25117, _24102);
	                _16926 = min(_16336, _15243);
	                _22843 = max(_13151, _15243);
	                _24639 = _17032 + 1;
	                _13151 = _22843;
	                _16336 = _16926;
	                _17032 = _24639;
	                continue;
	            }
	            float4 _13152;
	            float4 _16337;
	            _13152 = clamp(_25117 + (_24102 * _16336), 0.0f.xxxx, 1.0f.xxxx);
	            _16337 = clamp(_25117 + (_24102 * _13151), 0.0f.xxxx, 1.0f.xxxx);
	            int _8088;
	            float4 _6560;
	            float4 _14391;
	            int _17033 = 0;
	            for (;;)
	            {
	                if (!(_17033 < 2))
	                {
	                    break;
	                }
	                float4 _15668 = _16337 - _13152;
	                float _7123 = dot(_15668, _15668);
	                if (_7123 < 9.9999997473787516355514526367188e-05f)
	                {
	                    break;
	                }
	                float4 _13153;
	                int _16308;
	                float4 _17116;
	                int _17135;
	                _13153 = 0.0f.xxxx;
	                _16308 = 0;
	                _17116 = 0.0f.xxxx;
	                _17135 = 0;
	                int _8897;
	                float4 _13154;
	                float4 _14892;
	                int _16309;
	                int _18361;
	                int _17034 = 0;
	                for (;;)
	                {
	                    if (!(_17034 < 16))
	                    {
	                        break;
	                    }
	                    int _23277 = int((saturate(dot(_6603[_17034] - _13152, _15668) / _7123) * 15.0f) + 0.5f);
	                    if (_23277 == 0)
	                    {
	                        _13154 = _13153;
	                        _16309 = _16308;
	                        _14892 = _17116 + _6603[_17034];
	                        _18361 = _17135 + 1;
	                    }
	                    else
	                    {
	                        int _13213;
	                        float4 _15671;
	                        if (_23277 == 15)
	                        {
	                            _13213 = _16308 + 1;
	                            _15671 = _13153 + _6603[_17034];
	                        }
	                        else
	                        {
	                            _13213 = _16308;
	                            _15671 = _13153;
	                        }
	                        _13154 = _15671;
	                        _16309 = _13213;
	                        _14892 = _17116;
	                        _18361 = _17135;
	                    }
	                    _8897 = _17034 + 1;
	                    _13153 = _13154;
	                    _16308 = _16309;
	                    _17116 = _14892;
	                    _17135 = _18361;
	                    _17034 = _8897;
	                    continue;
	                }
	                if (_17135 > 0)
	                {
	                    _6560 = round((_17116 / float(_17135).xxxx) * 255.0f) * 0.0039215688593685626983642578125f.xxxx;
	                }
	                else
	                {
	                    _6560 = _13152;
	                }
	                if (_16308 > 0)
	                {
	                    _14391 = round((_13153 / float(_16308).xxxx) * 255.0f) * 0.0039215688593685626983642578125f.xxxx;
	                }
	                else
	                {
	                    _14391 = _16337;
	                }
	                _8088 = _17033 + 1;
	                _13152 = _6560;
	                _16337 = _14391;
	                _17033 = _8088;
	                continue;
	            }
	            float4 _6657 = float4(uint4((clamp(_13152, 0.0f.xxxx, 1.0f.xxxx) * 255.0f) + 0.5f.xxxx));
	            float4 _7540 = float4(uint4((clamp(_16337, 0.0f.xxxx, 1.0f.xxxx) * 255.0f) + 0.5f.xxxx));
	            float4 _21910 = (_7540 - _6657) * 0.0039215688593685626983642578125f;
	            float4 _18309 = _21910 * (1.0f / (dot(_21910, _21910) + 9.9999997473787516355514526367188e-05f));
	            float _17056 = dot(_6657, _18309) * 0.0039215688593685626983642578125f;
	            uint2 _13160;
	            _13160 = uint2(0u, 0u);
	            int _8517;
	            uint2 _9506;
	            int _16219 = 0;
	            for (;;)
	            {
	                if (!(_16219 < 8))
	                {
	                    break;
	                }
	                _9506 = _13160;
	                _9506.x = _13160.x | (uint((15.0f * saturate(dot(_6603[_16219], _18309) - _17056)) + 0.5f) << uint(_16219 * 4));
	                _8517 = _16219 + 1;
	                _13160 = _9506;
	                _16219 = _8517;
	                continue;
	            }
	            uint2 _13161;
	            _13161 = _13160;
	            int _8518;
	            uint2 _9507;
	            int _16220 = 0;
	            for (;;)
	            {
	                if (!(_16220 < 8))
	                {
	                    break;
	                }
	                _9507 = _13161;
	                _9507.y = _13161.y | (uint((15.0f * saturate(dot(_6603[8 + _16220], _18309) - _17056)) + 0.5f) << uint(_16220 * 4));
	                _8518 = _16220 + 1;
	                _13161 = _9507;
	                _16220 = _8518;
	                continue;
	            }
	            bool _15645 = (_13161.x & 8u) != 0u;
	            uint2 _21168;
	            if (_15645)
	            {
	                _21168 = uint2(~_13161.x, ~_13161.y);
	            }
	            else
	            {
	                _21168 = _13161;
	            }
	            bool4 _19657 = _15645.xxxx;
	            float4 _17593 = float4(_19657.x ? _6657.x : _7540.x, _19657.y ? _6657.y : _7540.y, _19657.z ? _6657.z : _7540.z, _19657.w ? _6657.w : _7540.w);
	            float4 _23069 = float4(_19657.x ? _7540.x : _6657.x, _19657.y ? _7540.y : _6657.y, _19657.z ? _7540.z : _6657.z, _19657.w ? _7540.w : _6657.w);
	            uint4 _16338;
	            _16338 = uint4(0u, 0u, 0u, 0u);
	            int _10589;
	            uint _20692;
	            uint4 _19670;
	            uint _13162 = 64u;
	            int _17035 = 0;
	            [unroll]
	            for (;;)
	            {
	                if (!(_17035 < 7))
	                {
	                    break;
	                }
	                uint _23704 = uint(_17035 & 31);
	                uint _16836 = min(uint(7 - _17035), (32u - _23704));
	                switch (uint(_17035 >> 5))
	                {
	                    case 0u:
	                    {
	                        uint4 _19263 = _16338;
	                        _19263.x = spvBitfieldInsert(_16338.x, _13162, _23704, _16836);
	                        _19670 = _19263;
	                        break;
	                    }
	                    case 1u:
	                    {
	                        uint4 _19262 = _16338;
	                        _19262.y = spvBitfieldInsert(_16338.y, _13162, _23704, _16836);
	                        _19670 = _19262;
	                        break;
	                    }
	                    case 2u:
	                    {
	                        _19670 = _16338;
	                        break;
	                    }
	                    default:
	                    {
	                        _19670 = _16338;
	                        break;
	                    }
	                }
	                _20692 = _13162 >> _16836;
	                _10589 = _17035 + int(_16836);
	                _13162 = _20692;
	                _16338 = _19670;
	                _17035 = _10589;
	                continue;
	            }
	            uint _10064 = uint(_23069.x) >> uint(1);
	            uint4 _16339;
	            _16339 = _16338;
	            int _10590;
	            uint _20693;
	            uint4 _19671;
	            uint _13163 = _10064;
	            int _17036 = 7;
	            [unroll]
	            for (;;)
	            {
	                if (!(_17036 < 14))
	                {
	                    break;
	                }
	                uint _23705 = uint(_17036 & 31);
	                uint _16837 = min(uint(14 - _17036), (32u - _23705));
	                switch (uint(_17036 >> 5))
	                {
	                    case 0u:
	                    {
	                        uint4 _19265 = _16339;
	                        _19265.x = spvBitfieldInsert(_16339.x, _13163, _23705, _16837);
	                        _19671 = _19265;
	                        break;
	                    }
	                    case 1u:
	                    {
	                        uint4 _19264 = _16339;
	                        _19264.y = spvBitfieldInsert(_16339.y, _13163, _23705, _16837);
	                        _19671 = _19264;
	                        break;
	                    }
	                    case 2u:
	                    {
	                        _19671 = _16339;
	                        break;
	                    }
	                    default:
	                    {
	                        _19671 = _16339;
	                        break;
	                    }
	                }
	                _20693 = _13163 >> _16837;
	                _10590 = _17036 + int(_16837);
	                _13163 = _20693;
	                _16339 = _19671;
	                _17036 = _10590;
	                continue;
	            }
	            uint _10065 = uint(_17593.x) >> uint(1);
	            uint4 _16340;
	            _16340 = _16339;
	            int _10591;
	            uint _20694;
	            uint4 _19672;
	            uint _13164 = _10065;
	            int _17037 = 14;
	            [unroll]
	            for (;;)
	            {
	                if (!(_17037 < 21))
	                {
	                    break;
	                }
	                uint _23706 = uint(_17037 & 31);
	                uint _16838 = min(uint(21 - _17037), (32u - _23706));
	                switch (uint(_17037 >> 5))
	                {
	                    case 0u:
	                    {
	                        uint4 _19267 = _16340;
	                        _19267.x = spvBitfieldInsert(_16340.x, _13164, _23706, _16838);
	                        _19672 = _19267;
	                        break;
	                    }
	                    case 1u:
	                    {
	                        uint4 _19266 = _16340;
	                        _19266.y = spvBitfieldInsert(_16340.y, _13164, _23706, _16838);
	                        _19672 = _19266;
	                        break;
	                    }
	                    case 2u:
	                    {
	                        _19672 = _16340;
	                        break;
	                    }
	                    default:
	                    {
	                        _19672 = _16340;
	                        break;
	                    }
	                }
	                _20694 = _13164 >> _16838;
	                _10591 = _17037 + int(_16838);
	                _13164 = _20694;
	                _16340 = _19672;
	                _17037 = _10591;
	                continue;
	            }
	            uint _10066 = uint(_23069.y) >> uint(1);
	            uint4 _16341;
	            _16341 = _16340;
	            int _10592;
	            uint _20695;
	            uint4 _19673;
	            uint _13165 = _10066;
	            int _17038 = 21;
	            [unroll]
	            for (;;)
	            {
	                if (!(_17038 < 28))
	                {
	                    break;
	                }
	                uint _23707 = uint(_17038 & 31);
	                uint _16839 = min(uint(28 - _17038), (32u - _23707));
	                switch (uint(_17038 >> 5))
	                {
	                    case 0u:
	                    {
	                        uint4 _19269 = _16341;
	                        _19269.x = spvBitfieldInsert(_16341.x, _13165, _23707, _16839);
	                        _19673 = _19269;
	                        break;
	                    }
	                    case 1u:
	                    {
	                        uint4 _19268 = _16341;
	                        _19268.y = spvBitfieldInsert(_16341.y, _13165, _23707, _16839);
	                        _19673 = _19268;
	                        break;
	                    }
	                    case 2u:
	                    {
	                        _19673 = _16341;
	                        break;
	                    }
	                    default:
	                    {
	                        _19673 = _16341;
	                        break;
	                    }
	                }
	                _20695 = _13165 >> _16839;
	                _10592 = _17038 + int(_16839);
	                _13165 = _20695;
	                _16341 = _19673;
	                _17038 = _10592;
	                continue;
	            }
	            uint _10067 = uint(_17593.y) >> uint(1);
	            uint4 _16342;
	            _16342 = _16341;
	            int _10593;
	            uint _20696;
	            uint4 _19674;
	            uint _13166 = _10067;
	            int _17039 = 28;
	            [unroll]
	            for (;;)
	            {
	                if (!(_17039 < 35))
	                {
	                    break;
	                }
	                uint _23708 = uint(_17039 & 31);
	                uint _16840 = min(uint(35 - _17039), (32u - _23708));
	                switch (uint(_17039 >> 5))
	                {
	                    case 0u:
	                    {
	                        uint4 _19271 = _16342;
	                        _19271.x = spvBitfieldInsert(_16342.x, _13166, _23708, _16840);
	                        _19674 = _19271;
	                        break;
	                    }
	                    case 1u:
	                    {
	                        uint4 _19270 = _16342;
	                        _19270.y = spvBitfieldInsert(_16342.y, _13166, _23708, _16840);
	                        _19674 = _19270;
	                        break;
	                    }
	                    case 2u:
	                    {
	                        _19674 = _16342;
	                        break;
	                    }
	                    default:
	                    {
	                        _19674 = _16342;
	                        break;
	                    }
	                }
	                _20696 = _13166 >> _16840;
	                _10593 = _17039 + int(_16840);
	                _13166 = _20696;
	                _16342 = _19674;
	                _17039 = _10593;
	                continue;
	            }
	            uint _10068 = uint(_23069.z) >> uint(1);
	            uint4 _16343;
	            _16343 = _16342;
	            int _10594;
	            uint _20697;
	            uint4 _19675;
	            uint _13167 = _10068;
	            int _17040 = 35;
	            [unroll]
	            for (;;)
	            {
	                if (!(_17040 < 42))
	                {
	                    break;
	                }
	                uint _23709 = uint(_17040 & 31);
	                uint _16841 = min(uint(42 - _17040), (32u - _23709));
	                switch (uint(_17040 >> 5))
	                {
	                    case 0u:
	                    {
	                        uint4 _19273 = _16343;
	                        _19273.x = spvBitfieldInsert(_16343.x, _13167, _23709, _16841);
	                        _19675 = _19273;
	                        break;
	                    }
	                    case 1u:
	                    {
	                        uint4 _19272 = _16343;
	                        _19272.y = spvBitfieldInsert(_16343.y, _13167, _23709, _16841);
	                        _19675 = _19272;
	                        break;
	                    }
	                    case 2u:
	                    {
	                        _19675 = _16343;
	                        break;
	                    }
	                    default:
	                    {
	                        _19675 = _16343;
	                        break;
	                    }
	                }
	                _20697 = _13167 >> _16841;
	                _10594 = _17040 + int(_16841);
	                _13167 = _20697;
	                _16343 = _19675;
	                _17040 = _10594;
	                continue;
	            }
	            uint _10069 = uint(_17593.z) >> uint(1);
	            uint4 _16344;
	            _16344 = _16343;
	            int _10595;
	            uint _20698;
	            uint4 _19676;
	            uint _13168 = _10069;
	            int _17041 = 42;
	            [unroll]
	            for (;;)
	            {
	                if (!(_17041 < 49))
	                {
	                    break;
	                }
	                uint _23710 = uint(_17041 & 31);
	                uint _16842 = min(uint(49 - _17041), (32u - _23710));
	                switch (uint(_17041 >> 5))
	                {
	                    case 0u:
	                    {
	                        uint4 _19275 = _16344;
	                        _19275.x = spvBitfieldInsert(_16344.x, _13168, _23710, _16842);
	                        _19676 = _19275;
	                        break;
	                    }
	                    case 1u:
	                    {
	                        uint4 _19274 = _16344;
	                        _19274.y = spvBitfieldInsert(_16344.y, _13168, _23710, _16842);
	                        _19676 = _19274;
	                        break;
	                    }
	                    case 2u:
	                    {
	                        _19676 = _16344;
	                        break;
	                    }
	                    default:
	                    {
	                        _19676 = _16344;
	                        break;
	                    }
	                }
	                _20698 = _13168 >> _16842;
	                _10595 = _17041 + int(_16842);
	                _13168 = _20698;
	                _16344 = _19676;
	                _17041 = _10595;
	                continue;
	            }
	            uint4 _16345;
	            _16345 = _16344;
	            int _10596;
	            uint _20699;
	            uint4 _19677;
	            uint _13169 = 127u;
	            int _17042 = 49;
	            [unroll]
	            for (;;)
	            {
	                if (!(_17042 < 56))
	                {
	                    break;
	                }
	                uint _23711 = uint(_17042 & 31);
	                uint _16843 = min(uint(56 - _17042), (32u - _23711));
	                switch (uint(_17042 >> 5))
	                {
	                    case 0u:
	                    {
	                        uint4 _19277 = _16345;
	                        _19277.x = spvBitfieldInsert(_16345.x, _13169, _23711, _16843);
	                        _19677 = _19277;
	                        break;
	                    }
	                    case 1u:
	                    {
	                        uint4 _19276 = _16345;
	                        _19276.y = spvBitfieldInsert(_16345.y, _13169, _23711, _16843);
	                        _19677 = _19276;
	                        break;
	                    }
	                    case 2u:
	                    {
	                        _19677 = _16345;
	                        break;
	                    }
	                    default:
	                    {
	                        _19677 = _16345;
	                        break;
	                    }
	                }
	                _20699 = _13169 >> _16843;
	                _10596 = _17042 + int(_16843);
	                _13169 = _20699;
	                _16345 = _19677;
	                _17042 = _10596;
	                continue;
	            }
	            uint4 _16346;
	            _16346 = _16345;
	            int _10597;
	            uint _20700;
	            uint4 _19678;
	            uint _13170 = 127u;
	            int _17043 = 56;
	            [unroll]
	            for (;;)
	            {
	                if (!(_17043 < 63))
	                {
	                    break;
	                }
	                uint _23712 = uint(_17043 & 31);
	                uint _16844 = min(uint(63 - _17043), (32u - _23712));
	                switch (uint(_17043 >> 5))
	                {
	                    case 0u:
	                    {
	                        uint4 _19279 = _16346;
	                        _19279.x = spvBitfieldInsert(_16346.x, _13170, _23712, _16844);
	                        _19678 = _19279;
	                        break;
	                    }
	                    case 1u:
	                    {
	                        uint4 _19278 = _16346;
	                        _19278.y = spvBitfieldInsert(_16346.y, _13170, _23712, _16844);
	                        _19678 = _19278;
	                        break;
	                    }
	                    case 2u:
	                    {
	                        _19678 = _16346;
	                        break;
	                    }
	                    default:
	                    {
	                        _19678 = _16346;
	                        break;
	                    }
	                }
	                _20700 = _13170 >> _16844;
	                _10597 = _17043 + int(_16844);
	                _13170 = _20700;
	                _16346 = _19678;
	                _17043 = _10597;
	                continue;
	            }
	            uint4 _16347;
	            _16347 = _16346;
	            int _10598;
	            uint _20701;
	            uint4 _19679;
	            uint _13171 = 1u;
	            int _17044 = 63;
	            [unroll]
	            for (;;)
	            {
	                if (!(_17044 < 64))
	                {
	                    break;
	                }
	                uint _23713 = uint(_17044 & 31);
	                uint _16845 = min(uint(64 - _17044), (32u - _23713));
	                switch (uint(_17044 >> 5))
	                {
	                    case 0u:
	                    {
	                        uint4 _19283 = _16347;
	                        _19283.x = spvBitfieldInsert(_16347.x, _13171, _23713, _16845);
	                        _19679 = _19283;
	                        break;
	                    }
	                    case 1u:
	                    {
	                        uint4 _19282 = _16347;
	                        _19282.y = spvBitfieldInsert(_16347.y, _13171, _23713, _16845);
	                        _19679 = _19282;
	                        break;
	                    }
	                    case 2u:
	                    {
	                        _19679 = _16347;
	                        break;
	                    }
	                    default:
	                    {
	                        _19679 = _16347;
	                        break;
	                    }
	                }
	                _20701 = _13171 >> _16845;
	                _10598 = _17044 + int(_16845);
	                _13171 = _20701;
	                _16347 = _19679;
	                _17044 = _10598;
	                continue;
	            }
	            uint4 _23136 = _16347;
	            _23136.z = _21168.x;
	            _23136.w = _21168.y;
	            _23123 = _23136;
	            break;
	        } while(false);
	        OutputBC7Texture[gl_GlobalInvocationID.xy] = _23123;
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
