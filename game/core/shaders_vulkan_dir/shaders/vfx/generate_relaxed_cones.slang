//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Computes relaxed cone step maps from a heightmap.";
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
	
	float g_fWidthScale < Attribute("WidthScale"); UiType(Slider); >;
	int g_nMipCount < Attribute("MipCount"); UiType(Slider); >;
	RWTexture2D<float4> g_tDstCones < Attribute("OutputCones"); >;
	Texture2D g_tHeightmap < Attribute("HeightMap"); SrgbRead(false); >;
	float4 g_vImageDimensions < Attribute("ImageDimensions"); UiType(VectorText); >;
	
	
	// Variant parameters
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	cbuffer _Globals_ : register(b0, space0)
	{
	    float4 _Globals_1_g_vImageDimensions : packoffset(c0);
	    float _Globals_1_g_fWidthScale : packoffset(c1);
	    uint _Globals_1_g_nMipCount : packoffset(c1.y);
	};
	
	Texture2D<float4> g_tHeightmap : register(t30, space0);
	SamplerState AddressU_Wrap_AddressV_Wrap_Filter_MinMagMipPoint : register(s14, space0);
	SamplerState AddressU_Wrap_AddressV_Wrap_Filter_MinMagLinearMipPoint : register(s15, space0);
	RWTexture2D<uint> g_tDstCones : register(u158, space0);
	
	static uint3 gl_WorkGroupID;
	static uint3 gl_LocalInvocationID;
	static uint gl_LocalInvocationIndex;
	struct SPIRV_Cross_Input
	{
	    uint3 gl_WorkGroupID : SV_GroupID;
	    uint3 gl_LocalInvocationID : SV_GroupThreadID;
	    uint gl_LocalInvocationIndex : SV_GroupIndex;
	};
	
	groupshared uint _4495;
	
	void MainCs_inner()
	{
	    bool _17840 = all(bool3(gl_LocalInvocationID.x == uint3(0u, 0u, 0u).x, gl_LocalInvocationID.y == uint3(0u, 0u, 0u).y, gl_LocalInvocationID.z == uint3(0u, 0u, 0u).z));
	    if (_17840)
	    {
	        _4495 = 255u;
	    }
	    GroupMemoryBarrierWithGroupSync();
	    int2 _10133 = int2(gl_WorkGroupID.xy);
	    uint _6475;
	    float _11901;
	    float _13155 = 1.0f;
	    uint _16208 = 0u;
	    for (;;)
	    {
	        if (!(_16208 < max(1u, _Globals_1_g_nMipCount)))
	        {
	            break;
	        }
	        float2 _16123 = (float2(_10133) + 0.5f.xx) * _Globals_1_g_vImageDimensions.zw;
	        float4 _11160 = g_tHeightmap.SampleLevel(AddressU_Wrap_AddressV_Wrap_Filter_MinMagMipPoint, _16123, 0.0f);
	        float _17197 = _11160.x;
	        uint2 _13520 = _16208.xx;
	        float _24380 = length(float2(int2(2, 2) << int2(_13520)) * _Globals_1_g_vImageDimensions.zw);
	        int _12501;
	        if (_16208 != 0u)
	        {
	            _12501 = int(64u << (_16208 - 1u));
	        }
	        else
	        {
	            _12501 = 0;
	        }
	        uint _13156;
	        _13156 = 0u;
	        uint _8087;
	        uint _14382;
	        uint _16209 = 0u;
	        for (;;)
	        {
	            bool _7956_ladder_break = false;
	            do
	            {
	                if (!(_16209 < 16u))
	                {
	                    _7956_ladder_break = true;
	                    break;
	                }
	                uint _24149 = (_16209 * 64u) + gl_LocalInvocationIndex;
	                int2 _9763 = int2(uint2(int2(int(_24149 % 32u), int(_24149 / 32u)) * int2(4, 4)) - uint2(64u, 64u));
	                int2 _12273 = abs(_9763 << int2(_13520));
	                int2 _24292 = _12501.xx;
	                if (all(bool2(_12273.x < _24292.x, _12273.y < _24292.y)))
	                {
	                    _14382 = _13156;
	                    break;
	                }
	                float2 _6348 = (float2((_10133 & int2(-4, -4)) + ((_9763 + int2(2, 2)) << int2(_13520))) + 0.5f.xx) * _Globals_1_g_vImageDimensions.zw;
	                float _10682 = _17197 - g_tHeightmap.SampleLevel(AddressU_Wrap_AddressV_Wrap_Filter_MinMagMipPoint, _6348, float(_16208 + 2u)).x;
	                float _23727;
	                if (_10682 <= 0.0f)
	                {
	                    _23727 = 1.0f;
	                }
	                else
	                {
	                    _23727 = (_Globals_1_g_fWidthScale * (length(_16123.xy - _6348.xy) - _24380)) / _10682;
	                }
	                uint _12502;
	                if (_23727 < _13155)
	                {
	                    _12502 = _13156 | (1u << _16209);
	                }
	                else
	                {
	                    _12502 = _13156;
	                }
	                _14382 = _12502;
	                break;
	            } while(false);
	            if (_7956_ladder_break)
	            {
	                break;
	            }
	            _8087 = _16209 + 1u;
	            _13156 = _14382;
	            _16209 = _8087;
	            continue;
	        }
	        float _13157;
	        _13157 = _13155;
	        uint _5298;
	        float _13158;
	        uint _16210 = _13156;
	        for (;;)
	        {
	            if (!(_16210 != 0u))
	            {
	                break;
	            }
	            _5298 = _16210 & (_16210 - 1u);
	            uint _20144 = (firstbitlow(_16210) * 64u) + gl_LocalInvocationIndex;
	            int2 _24144 = int2(uint2(int2(int(_20144 % 32u), int(_20144 / 32u)) * int2(4, 4)) - uint2(64u, 64u));
	            _13158 = _13157;
	            int _21567;
	            float _13159;
	            int _16211 = 0;
	            for (;;)
	            {
	                if (!(_16211 < 4))
	                {
	                    break;
	                }
	                _13159 = _13158;
	                float _22046;
	                int _24969;
	                int _16212 = 0;
	                for (;;)
	                {
	                    if (!(_16212 < 4))
	                    {
	                        break;
	                    }
	                    int2 _15209 = (_10133 & int2(-4, -4)) + ((_24144 + int2(_16212, _16211)) << int2(_13520));
	                    float _20773;
	                    do
	                    {
	                        if (all(bool2(_10133.x == _15209.x, _10133.y == _15209.y)))
	                        {
	                            _20773 = 1.0f;
	                            break;
	                        }
	                        float2 _23069 = (float2(_15209) + 0.5f.xx) * _Globals_1_g_vImageDimensions.zw;
	                        float _19207 = g_tHeightmap.SampleLevel(AddressU_Wrap_AddressV_Wrap_Filter_MinMagMipPoint, _16123, 0.0f).x - g_tHeightmap.SampleLevel(AddressU_Wrap_AddressV_Wrap_Filter_MinMagMipPoint, _23069, float(_16208)).x;
	                        float _23728;
	                        if (_19207 <= 0.0f)
	                        {
	                            _23728 = 1.0f;
	                        }
	                        else
	                        {
	                            _23728 = (length(_16123.xy - _23069.xy) * _Globals_1_g_fWidthScale) / _19207;
	                        }
	                        if (_23728 < _13159)
	                        {
	                            float4 _12167 = g_tHeightmap.SampleLevel(AddressU_Wrap_AddressV_Wrap_Filter_MinMagMipPoint, _23069, 0.0f);
	                            float _7002 = _12167.x;
	                            float2 _14547 = (normalize(_23069 - _16123) * _Globals_1_g_vImageDimensions.zw) * 0.25f;
	                            bool _12885;
	                            if ((g_tHeightmap.SampleLevel(AddressU_Wrap_AddressV_Wrap_Filter_MinMagLinearMipPoint, _23069 + _14547, 0.0f).x - _7002) > 0.0f)
	                            {
	                                _12885 = (g_tHeightmap.SampleLevel(AddressU_Wrap_AddressV_Wrap_Filter_MinMagLinearMipPoint, _23069 - _14547, 0.0f).x - _7002) <= 0.0f;
	                            }
	                            else
	                            {
	                                _12885 = false;
	                            }
	                            if (_12885)
	                            {
	                                _20773 = _23728;
	                                break;
	                            }
	                        }
	                        _20773 = 1.0f;
	                        break;
	                    } while(false);
	                    _22046 = min(_13159, _20773);
	                    _24969 = _16212 + 1;
	                    _13159 = _22046;
	                    _16212 = _24969;
	                    continue;
	                }
	                _21567 = _16211 + 1;
	                _13158 = _13159;
	                _16211 = _21567;
	                continue;
	            }
	            _13157 = _13158;
	            _16210 = _5298;
	            continue;
	        }
	        uint _16589;
	        InterlockedMin(_4495, uint(floor(saturate(_13157) * 255.0f)), _16589);
	        GroupMemoryBarrierWithGroupSync();
	        _11901 = float(_4495) * 0.0039215688593685626983642578125f;
	        _6475 = _16208 + 1u;
	        _13155 = _11901;
	        _16208 = _6475;
	        continue;
	    }
	    if (_17840)
	    {
	        g_tDstCones[gl_WorkGroupID.xy] = _4495.x;
	    }
	}
	
	[numthreads(64, 1, 1)]
	void MainCs(SPIRV_Cross_Input stage_input)
	{
	    gl_WorkGroupID = stage_input.gl_WorkGroupID;
	    gl_LocalInvocationID = stage_input.gl_LocalInvocationID;
	    gl_LocalInvocationIndex = stage_input.gl_LocalInvocationIndex;
	    MainCs_inner();
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
}
