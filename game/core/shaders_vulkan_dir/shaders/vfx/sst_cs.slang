//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Sparse Shadow Tree Compute Shader";
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
	DynamicCombo( D_UNPACK_METHOD, 0..2 );
	DynamicCombo( D_OUTPUT_DEBUG_COLOR, 0..1 );
	
	StructuredBuffer g_SST < Attribute("SparseShadowTree"); >;
	int g_nSSTForest < Attribute("SSTForest"); UiType(Slider); >;
	int g_nSSTOutputPixelExcludeEndX < Attribute("SSTOutputPixelExcludeEndX"); UiType(Slider); >;
	int g_nSSTOutputPixelExcludeEndY < Attribute("SSTOutputPixelExcludeEndY"); UiType(Slider); >;
	int g_nSSTOutputPixelExcludeStartX < Attribute("SSTOutputPixelExcludeStartX"); UiType(Slider); >;
	int g_nSSTOutputPixelExcludeStartY < Attribute("SSTOutputPixelExcludeStartY"); UiType(Slider); >;
	int g_nSSTOutputPixelHeight < Attribute("SSTOutputPixelHeight"); UiType(Slider); >;
	int g_nSSTOutputPixelStartOffsetX < Attribute("SSTOutputPixelStartOffsetX"); UiType(Slider); >;
	int g_nSSTOutputPixelStartOffsetY < Attribute("SSTOutputPixelStartOffsetY"); UiType(Slider); >;
	int g_nSSTOutputPixelStartX < Attribute("SSTOutputPixelStartX"); UiType(Slider); >;
	int g_nSSTOutputPixelStartY < Attribute("SSTOutputPixelStartY"); UiType(Slider); >;
	int g_nSSTOutputPixelWidth < Attribute("SSTOutputPixelWidth"); UiType(Slider); >;
	int g_nSSTTileStartX < Attribute("SSTTileStartX"); UiType(Slider); >;
	int g_nSSTTileStartY < Attribute("SSTTileStartY"); UiType(Slider); >;
	int g_nSSTWidth < Attribute("SSTWidth"); UiType(Slider); >;
	RWTexture2D<float4> g_tOutColor < Attribute("SSTDebugColor"); >;
	RWTexture2D<float4> g_tOutDepth < Attribute("ShadowAtlas"); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	cbuffer _Globals_ : register(b0, space0)
	{
	    uint _Globals_1_g_nSSTWidth : packoffset(c0);
	    uint _Globals_1_g_nSSTTileStartX : packoffset(c1);
	    uint _Globals_1_g_nSSTTileStartY : packoffset(c1.y);
	    uint _Globals_1_g_nSSTOutputPixelStartOffsetX : packoffset(c1.z);
	    uint _Globals_1_g_nSSTOutputPixelStartOffsetY : packoffset(c1.w);
	    uint _Globals_1_g_nSSTOutputPixelStartX : packoffset(c2);
	    uint _Globals_1_g_nSSTOutputPixelStartY : packoffset(c2.y);
	    uint _Globals_1_g_nSSTOutputPixelWidth : packoffset(c2.z);
	    uint _Globals_1_g_nSSTOutputPixelHeight : packoffset(c2.w);
	    uint _Globals_1_g_nSSTOutputPixelExcludeStartX : packoffset(c3);
	    uint _Globals_1_g_nSSTOutputPixelExcludeStartY : packoffset(c3.y);
	    uint _Globals_1_g_nSSTOutputPixelExcludeEndX : packoffset(c3.z);
	    uint _Globals_1_g_nSSTOutputPixelExcludeEndY : packoffset(c3.w);
	    uint _Globals_1_g_nSSTForest : packoffset(c4);
	};
	
	ByteAddressBuffer g_SST : register(t30, space0);
	RWTexture2D<float4> g_tOutDepth : register(u158, space0);
	
	static uint3 gl_GlobalInvocationID;
	struct SPIRV_Cross_Input
	{
	    uint3 gl_GlobalInvocationID : SV_DispatchThreadID;
	};
	
	void MainCs_inner()
	{
	    do
	    {
	        uint2 _23624 = gl_GlobalInvocationID.xy * uint2(4u, 4u);
	        uint2 _3797 = uint2(_Globals_1_g_nSSTTileStartX, _Globals_1_g_nSSTTileStartY) + (gl_GlobalInvocationID.xy / uint2(32u, 32u));
	        uint2 _15313 = _23624 + uint2(_Globals_1_g_nSSTOutputPixelStartOffsetX, _Globals_1_g_nSSTOutputPixelStartOffsetY);
	        uint _7985 = _15313.x;
	        bool _12885;
	        if (_7985 >= _Globals_1_g_nSSTOutputPixelWidth)
	        {
	            _12885 = true;
	        }
	        else
	        {
	            _12885 = _15313.y >= _Globals_1_g_nSSTOutputPixelHeight;
	        }
	        if (_12885)
	        {
	            break;
	        }
	        bool _12886;
	        if (_7985 > _Globals_1_g_nSSTOutputPixelExcludeStartX)
	        {
	            _12886 = _7985 < _Globals_1_g_nSSTOutputPixelExcludeEndX;
	        }
	        else
	        {
	            _12886 = false;
	        }
	        bool _12887;
	        if (_12886)
	        {
	            _12887 = _15313.y > _Globals_1_g_nSSTOutputPixelExcludeStartY;
	        }
	        else
	        {
	            _12887 = false;
	        }
	        bool _12888;
	        if (_12887)
	        {
	            _12888 = _15313.y < _Globals_1_g_nSSTOutputPixelExcludeEndY;
	        }
	        else
	        {
	            _12888 = false;
	        }
	        if (_12888)
	        {
	            break;
	        }
	        uint2 _15314 = _15313 + uint2(_Globals_1_g_nSSTOutputPixelStartX, _Globals_1_g_nSSTOutputPixelStartY);
	        uint _17785 = (_3797.y * _Globals_1_g_nSSTWidth) + _3797.x;
	        bool _11402;
	        uint _11518;
	        float _12889;
	        uint _14842;
	        do
	        {
	            bool _18261;
	            uint _21397 = g_SST.Load<uint>(_17785 * 4 + 0);
	            do
	            {
	                _18261 = (_21397 & 1073741824u) != 0u;
	                if (_18261)
	                {
	                    _12889 = asfloat((_21397 & 3221225471u) << uint(2));
	                    break;
	                }
	                _12889 = 1.0f;
	                break;
	            } while(false);
	            if (_18261)
	            {
	                float4 _10876 = _12889.xxxx;
	                g_tOutDepth[_15314] = _10876;
	                g_tOutDepth[_15314 + uint2(1u, 0u)] = _10876;
	                g_tOutDepth[_15314 + uint2(0u, 1u)] = _10876;
	                g_tOutDepth[_15314 + uint2(1u, 1u)] = _10876;
	                g_tOutDepth[_15314 + uint2(2u, 0u)] = _10876;
	                g_tOutDepth[_15314 + uint2(3u, 0u)] = _10876;
	                g_tOutDepth[_15314 + uint2(2u, 1u)] = _10876;
	                g_tOutDepth[_15314 + uint2(3u, 1u)] = _10876;
	                g_tOutDepth[_15314 + uint2(0u, 2u)] = _10876;
	                g_tOutDepth[_15314 + uint2(1u, 2u)] = _10876;
	                g_tOutDepth[_15314 + uint2(0u, 3u)] = _10876;
	                g_tOutDepth[_15314 + uint2(1u, 3u)] = _10876;
	                g_tOutDepth[_15314 + uint2(2u, 2u)] = _10876;
	                g_tOutDepth[_15314 + uint2(3u, 2u)] = _10876;
	                g_tOutDepth[_15314 + uint2(2u, 3u)] = _10876;
	                g_tOutDepth[_15314 + uint2(3u, 3u)] = _10876;
	                _11518 = _Globals_1_g_nSSTForest;
	                _14842 = _17785;
	                _11402 = true;
	                break;
	            }
	            else
	            {
	                _11518 = _21397;
	                _14842 = _21397;
	                _11402 = false;
	                break;
	            }
	            break; // unreachable workaround
	        } while(false);
	        if (!_11402)
	        {
	            bool _11403;
	            float3 _11519;
	            float _12890;
	            uint _14843;
	            do
	            {
	                bool _18262;
	                uint _21398 = g_SST.Load<uint>(_14842 * 4 + 0);
	                do
	                {
	                    _18262 = (_21398 & 1073741824u) != 0u;
	                    if (_18262)
	                    {
	                        _12890 = asfloat((_21398 & 3221225471u) << uint(2));
	                        break;
	                    }
	                    _12890 = _12889;
	                    break;
	                } while(false);
	                if (_18262)
	                {
	                    float4 _10877 = _12890.xxxx;
	                    g_tOutDepth[_15314] = _10877;
	                    g_tOutDepth[_15314 + uint2(1u, 0u)] = _10877;
	                    g_tOutDepth[_15314 + uint2(0u, 1u)] = _10877;
	                    g_tOutDepth[_15314 + uint2(1u, 1u)] = _10877;
	                    g_tOutDepth[_15314 + uint2(2u, 0u)] = _10877;
	                    g_tOutDepth[_15314 + uint2(3u, 0u)] = _10877;
	                    g_tOutDepth[_15314 + uint2(2u, 1u)] = _10877;
	                    g_tOutDepth[_15314 + uint2(3u, 1u)] = _10877;
	                    g_tOutDepth[_15314 + uint2(0u, 2u)] = _10877;
	                    g_tOutDepth[_15314 + uint2(1u, 2u)] = _10877;
	                    g_tOutDepth[_15314 + uint2(0u, 3u)] = _10877;
	                    g_tOutDepth[_15314 + uint2(1u, 3u)] = _10877;
	                    g_tOutDepth[_15314 + uint2(2u, 2u)] = _10877;
	                    g_tOutDepth[_15314 + uint2(3u, 2u)] = _10877;
	                    g_tOutDepth[_15314 + uint2(2u, 3u)] = _10877;
	                    g_tOutDepth[_15314 + uint2(3u, 3u)] = _10877;
	                    _11519 = float3(1.0f, 0.0f, 0.0f);
	                    _14843 = _14842;
	                    _11403 = true;
	                    break;
	                }
	                else
	                {
	                    bool _18263;
	                    uint _21970 = _14842 + 1u;
	                    float3 _12891;
	                    do
	                    {
	                        _18263 = (_21398 & 2147483648u) != 0u;
	                        if (_18263)
	                        {
	                            _12891 = float3(float((half)f16tof32(uint16_t(g_SST.Load<uint>(_21970 * 4 + 0) >> uint(16)))), float((half)f16tof32(uint16_t(g_SST.Load<uint>(_21970 * 4 + 0) & 65535u))), asfloat((_21398 & 2147483647u) << uint(1)));
	                            break;
	                        }
	                        _12891 = float3(1.0f, 0.0f, 0.0f);
	                        break;
	                    } while(false);
	                    if (_18263)
	                    {
	                        uint2 _24337 = _23624 % uint2(128u, 128u);
	                        float4 _22821 = _12891.xxxx * float4(0.0f, 1.0f, 2.0f, 3.0f);
	                        float4 _22382 = ((_12891.z + (float(_24337.x) * _12891.x)) + (float(_24337.y) * _12891.y)).xxxx;
	                        float4 _9987 = _22382 + _22821;
	                        float4 _21802 = (_22382 + _12891.yyyy) + _22821;
	                        float4 _20890 = (_22382 + (_12891.yyyy * 2.0f)) + _22821;
	                        float4 _16200 = (_22382 + (_12891.yyyy * 3.0f)) + _22821;
	                        g_tOutDepth[_15314] = _9987.x.xxxx;
	                        g_tOutDepth[_15314 + uint2(1u, 0u)] = _9987.y.xxxx;
	                        g_tOutDepth[_15314 + uint2(2u, 0u)] = _9987.z.xxxx;
	                        g_tOutDepth[_15314 + uint2(3u, 0u)] = _9987.w.xxxx;
	                        g_tOutDepth[_15314 + uint2(0u, 1u)] = _21802.x.xxxx;
	                        g_tOutDepth[_15314 + uint2(1u, 1u)] = _21802.y.xxxx;
	                        g_tOutDepth[_15314 + uint2(2u, 1u)] = _21802.z.xxxx;
	                        g_tOutDepth[_15314 + uint2(3u, 1u)] = _21802.w.xxxx;
	                        g_tOutDepth[_15314 + uint2(0u, 2u)] = _20890.x.xxxx;
	                        g_tOutDepth[_15314 + uint2(1u, 2u)] = _20890.y.xxxx;
	                        g_tOutDepth[_15314 + uint2(2u, 2u)] = _20890.z.xxxx;
	                        g_tOutDepth[_15314 + uint2(3u, 2u)] = _20890.w.xxxx;
	                        g_tOutDepth[_15314 + uint2(0u, 3u)] = _16200.x.xxxx;
	                        g_tOutDepth[_15314 + uint2(1u, 3u)] = _16200.y.xxxx;
	                        g_tOutDepth[_15314 + uint2(2u, 3u)] = _16200.z.xxxx;
	                        g_tOutDepth[_15314 + uint2(3u, 3u)] = _16200.w.xxxx;
	                        _11519 = _12891;
	                        _14843 = _14842;
	                        _11403 = true;
	                        break;
	                    }
	                    else
	                    {
	                        uint2 _13668 = _23624 % uint2(128u, 128u);
	                        uint _21709;
	                        if (_13668.x < 64u)
	                        {
	                            _21709 = (_13668.y < 64u) ? 0u : 2u;
	                        }
	                        else
	                        {
	                            _21709 = (_13668.y < 64u) ? 1u : 3u;
	                        }
	                        uint _14382;
	                        if (_21709 == 0u)
	                        {
	                            _14382 = (_21398 >> uint(15)) & 32767u;
	                        }
	                        else
	                        {
	                            uint _12502;
	                            if (_21709 == 1u)
	                            {
	                                _12502 = _21398 & 32767u;
	                            }
	                            else
	                            {
	                                uint _12501;
	                                if (_21709 == 2u)
	                                {
	                                    _12501 = (g_SST.Load<uint>(_21970 * 4 + 0) >> uint(15)) & 32767u;
	                                }
	                                else
	                                {
	                                    _12501 = g_SST.Load<uint>(_21970 * 4 + 0) & 32767u;
	                                }
	                                _12502 = _12501;
	                            }
	                            _14382 = _12502;
	                        }
	                        _11519 = _12891;
	                        _14843 = _14382 + _11518;
	                        _11403 = false;
	                        break;
	                    }
	                    break; // unreachable workaround
	                }
	                break; // unreachable workaround
	            } while(false);
	            if (!_11403)
	            {
	                bool _11404;
	                float3 _11520;
	                float _12892;
	                uint _14844;
	                do
	                {
	                    bool _18264;
	                    uint _21399 = g_SST.Load<uint>(_14843 * 4 + 0);
	                    do
	                    {
	                        _18264 = (_21399 & 1073741824u) != 0u;
	                        if (_18264)
	                        {
	                            _12892 = asfloat((_21399 & 3221225471u) << uint(2));
	                            break;
	                        }
	                        _12892 = _12890;
	                        break;
	                    } while(false);
	                    if (_18264)
	                    {
	                        float4 _10878 = _12892.xxxx;
	                        g_tOutDepth[_15314] = _10878;
	                        g_tOutDepth[_15314 + uint2(1u, 0u)] = _10878;
	                        g_tOutDepth[_15314 + uint2(0u, 1u)] = _10878;
	                        g_tOutDepth[_15314 + uint2(1u, 1u)] = _10878;
	                        g_tOutDepth[_15314 + uint2(2u, 0u)] = _10878;
	                        g_tOutDepth[_15314 + uint2(3u, 0u)] = _10878;
	                        g_tOutDepth[_15314 + uint2(2u, 1u)] = _10878;
	                        g_tOutDepth[_15314 + uint2(3u, 1u)] = _10878;
	                        g_tOutDepth[_15314 + uint2(0u, 2u)] = _10878;
	                        g_tOutDepth[_15314 + uint2(1u, 2u)] = _10878;
	                        g_tOutDepth[_15314 + uint2(0u, 3u)] = _10878;
	                        g_tOutDepth[_15314 + uint2(1u, 3u)] = _10878;
	                        g_tOutDepth[_15314 + uint2(2u, 2u)] = _10878;
	                        g_tOutDepth[_15314 + uint2(3u, 2u)] = _10878;
	                        g_tOutDepth[_15314 + uint2(2u, 3u)] = _10878;
	                        g_tOutDepth[_15314 + uint2(3u, 3u)] = _10878;
	                        _11520 = _11519;
	                        _14844 = _14843;
	                        _11404 = true;
	                        break;
	                    }
	                    else
	                    {
	                        bool _18265;
	                        uint _21971 = _14843 + 1u;
	                        float3 _12893;
	                        do
	                        {
	                            _18265 = (_21399 & 2147483648u) != 0u;
	                            if (_18265)
	                            {
	                                _12893 = float3(float((half)f16tof32(uint16_t(g_SST.Load<uint>(_21971 * 4 + 0) >> uint(16)))), float((half)f16tof32(uint16_t(g_SST.Load<uint>(_21971 * 4 + 0) & 65535u))), asfloat((_21399 & 2147483647u) << uint(1)));
	                                break;
	                            }
	                            _12893 = _11519;
	                            break;
	                        } while(false);
	                        if (_18265)
	                        {
	                            uint2 _24338 = _23624 % uint2(64u, 64u);
	                            float4 _22822 = _12893.xxxx * float4(0.0f, 1.0f, 2.0f, 3.0f);
	                            float4 _22383 = ((_12893.z + (float(_24338.x) * _12893.x)) + (float(_24338.y) * _12893.y)).xxxx;
	                            float4 _9988 = _22383 + _22822;
	                            float4 _21803 = (_22383 + _12893.yyyy) + _22822;
	                            float4 _20891 = (_22383 + (_12893.yyyy * 2.0f)) + _22822;
	                            float4 _16201 = (_22383 + (_12893.yyyy * 3.0f)) + _22822;
	                            g_tOutDepth[_15314] = _9988.x.xxxx;
	                            g_tOutDepth[_15314 + uint2(1u, 0u)] = _9988.y.xxxx;
	                            g_tOutDepth[_15314 + uint2(2u, 0u)] = _9988.z.xxxx;
	                            g_tOutDepth[_15314 + uint2(3u, 0u)] = _9988.w.xxxx;
	                            g_tOutDepth[_15314 + uint2(0u, 1u)] = _21803.x.xxxx;
	                            g_tOutDepth[_15314 + uint2(1u, 1u)] = _21803.y.xxxx;
	                            g_tOutDepth[_15314 + uint2(2u, 1u)] = _21803.z.xxxx;
	                            g_tOutDepth[_15314 + uint2(3u, 1u)] = _21803.w.xxxx;
	                            g_tOutDepth[_15314 + uint2(0u, 2u)] = _20891.x.xxxx;
	                            g_tOutDepth[_15314 + uint2(1u, 2u)] = _20891.y.xxxx;
	                            g_tOutDepth[_15314 + uint2(2u, 2u)] = _20891.z.xxxx;
	                            g_tOutDepth[_15314 + uint2(3u, 2u)] = _20891.w.xxxx;
	                            g_tOutDepth[_15314 + uint2(0u, 3u)] = _16201.x.xxxx;
	                            g_tOutDepth[_15314 + uint2(1u, 3u)] = _16201.y.xxxx;
	                            g_tOutDepth[_15314 + uint2(2u, 3u)] = _16201.z.xxxx;
	                            g_tOutDepth[_15314 + uint2(3u, 3u)] = _16201.w.xxxx;
	                            _11520 = _12893;
	                            _14844 = _14843;
	                            _11404 = true;
	                            break;
	                        }
	                        else
	                        {
	                            uint2 _13669 = _23624 % uint2(64u, 64u);
	                            uint _21710;
	                            if (_13669.x < 32u)
	                            {
	                                _21710 = (_13669.y < 32u) ? 0u : 2u;
	                            }
	                            else
	                            {
	                                _21710 = (_13669.y < 32u) ? 1u : 3u;
	                            }
	                            uint _14383;
	                            if (_21710 == 0u)
	                            {
	                                _14383 = (_21399 >> uint(15)) & 32767u;
	                            }
	                            else
	                            {
	                                uint _12504;
	                                if (_21710 == 1u)
	                                {
	                                    _12504 = _21399 & 32767u;
	                                }
	                                else
	                                {
	                                    uint _12503;
	                                    if (_21710 == 2u)
	                                    {
	                                        _12503 = (g_SST.Load<uint>(_21971 * 4 + 0) >> uint(15)) & 32767u;
	                                    }
	                                    else
	                                    {
	                                        _12503 = g_SST.Load<uint>(_21971 * 4 + 0) & 32767u;
	                                    }
	                                    _12504 = _12503;
	                                }
	                                _14383 = _12504;
	                            }
	                            _11520 = _12893;
	                            _14844 = _14383 + _11518;
	                            _11404 = false;
	                            break;
	                        }
	                        break; // unreachable workaround
	                    }
	                    break; // unreachable workaround
	                } while(false);
	                if (!_11404)
	                {
	                    bool _11405;
	                    float3 _11521;
	                    float _12894;
	                    uint _14845;
	                    do
	                    {
	                        bool _18266;
	                        uint _21400 = g_SST.Load<uint>(_14844 * 4 + 0);
	                        do
	                        {
	                            _18266 = (_21400 & 1073741824u) != 0u;
	                            if (_18266)
	                            {
	                                _12894 = asfloat((_21400 & 3221225471u) << uint(2));
	                                break;
	                            }
	                            _12894 = _12892;
	                            break;
	                        } while(false);
	                        if (_18266)
	                        {
	                            float4 _10879 = _12894.xxxx;
	                            g_tOutDepth[_15314] = _10879;
	                            g_tOutDepth[_15314 + uint2(1u, 0u)] = _10879;
	                            g_tOutDepth[_15314 + uint2(0u, 1u)] = _10879;
	                            g_tOutDepth[_15314 + uint2(1u, 1u)] = _10879;
	                            g_tOutDepth[_15314 + uint2(2u, 0u)] = _10879;
	                            g_tOutDepth[_15314 + uint2(3u, 0u)] = _10879;
	                            g_tOutDepth[_15314 + uint2(2u, 1u)] = _10879;
	                            g_tOutDepth[_15314 + uint2(3u, 1u)] = _10879;
	                            g_tOutDepth[_15314 + uint2(0u, 2u)] = _10879;
	                            g_tOutDepth[_15314 + uint2(1u, 2u)] = _10879;
	                            g_tOutDepth[_15314 + uint2(0u, 3u)] = _10879;
	                            g_tOutDepth[_15314 + uint2(1u, 3u)] = _10879;
	                            g_tOutDepth[_15314 + uint2(2u, 2u)] = _10879;
	                            g_tOutDepth[_15314 + uint2(3u, 2u)] = _10879;
	                            g_tOutDepth[_15314 + uint2(2u, 3u)] = _10879;
	                            g_tOutDepth[_15314 + uint2(3u, 3u)] = _10879;
	                            _11521 = _11520;
	                            _14845 = _14844;
	                            _11405 = true;
	                            break;
	                        }
	                        else
	                        {
	                            bool _18267;
	                            uint _21972 = _14844 + 1u;
	                            float3 _12895;
	                            do
	                            {
	                                _18267 = (_21400 & 2147483648u) != 0u;
	                                if (_18267)
	                                {
	                                    _12895 = float3(float((half)f16tof32(uint16_t(g_SST.Load<uint>(_21972 * 4 + 0) >> uint(16)))), float((half)f16tof32(uint16_t(g_SST.Load<uint>(_21972 * 4 + 0) & 65535u))), asfloat((_21400 & 2147483647u) << uint(1)));
	                                    break;
	                                }
	                                _12895 = _11520;
	                                break;
	                            } while(false);
	                            if (_18267)
	                            {
	                                uint2 _24339 = _23624 % uint2(32u, 32u);
	                                float4 _22823 = _12895.xxxx * float4(0.0f, 1.0f, 2.0f, 3.0f);
	                                float4 _22384 = ((_12895.z + (float(_24339.x) * _12895.x)) + (float(_24339.y) * _12895.y)).xxxx;
	                                float4 _9989 = _22384 + _22823;
	                                float4 _21804 = (_22384 + _12895.yyyy) + _22823;
	                                float4 _20892 = (_22384 + (_12895.yyyy * 2.0f)) + _22823;
	                                float4 _16202 = (_22384 + (_12895.yyyy * 3.0f)) + _22823;
	                                g_tOutDepth[_15314] = _9989.x.xxxx;
	                                g_tOutDepth[_15314 + uint2(1u, 0u)] = _9989.y.xxxx;
	                                g_tOutDepth[_15314 + uint2(2u, 0u)] = _9989.z.xxxx;
	                                g_tOutDepth[_15314 + uint2(3u, 0u)] = _9989.w.xxxx;
	                                g_tOutDepth[_15314 + uint2(0u, 1u)] = _21804.x.xxxx;
	                                g_tOutDepth[_15314 + uint2(1u, 1u)] = _21804.y.xxxx;
	                                g_tOutDepth[_15314 + uint2(2u, 1u)] = _21804.z.xxxx;
	                                g_tOutDepth[_15314 + uint2(3u, 1u)] = _21804.w.xxxx;
	                                g_tOutDepth[_15314 + uint2(0u, 2u)] = _20892.x.xxxx;
	                                g_tOutDepth[_15314 + uint2(1u, 2u)] = _20892.y.xxxx;
	                                g_tOutDepth[_15314 + uint2(2u, 2u)] = _20892.z.xxxx;
	                                g_tOutDepth[_15314 + uint2(3u, 2u)] = _20892.w.xxxx;
	                                g_tOutDepth[_15314 + uint2(0u, 3u)] = _16202.x.xxxx;
	                                g_tOutDepth[_15314 + uint2(1u, 3u)] = _16202.y.xxxx;
	                                g_tOutDepth[_15314 + uint2(2u, 3u)] = _16202.z.xxxx;
	                                g_tOutDepth[_15314 + uint2(3u, 3u)] = _16202.w.xxxx;
	                                _11521 = _12895;
	                                _14845 = _14844;
	                                _11405 = true;
	                                break;
	                            }
	                            else
	                            {
	                                uint2 _13670 = _23624 % uint2(32u, 32u);
	                                uint _21711;
	                                if (_13670.x < 16u)
	                                {
	                                    _21711 = (_13670.y < 16u) ? 0u : 2u;
	                                }
	                                else
	                                {
	                                    _21711 = (_13670.y < 16u) ? 1u : 3u;
	                                }
	                                uint _14384;
	                                if (_21711 == 0u)
	                                {
	                                    _14384 = (_21400 >> uint(15)) & 32767u;
	                                }
	                                else
	                                {
	                                    uint _12506;
	                                    if (_21711 == 1u)
	                                    {
	                                        _12506 = _21400 & 32767u;
	                                    }
	                                    else
	                                    {
	                                        uint _12505;
	                                        if (_21711 == 2u)
	                                        {
	                                            _12505 = (g_SST.Load<uint>(_21972 * 4 + 0) >> uint(15)) & 32767u;
	                                        }
	                                        else
	                                        {
	                                            _12505 = g_SST.Load<uint>(_21972 * 4 + 0) & 32767u;
	                                        }
	                                        _12506 = _12505;
	                                    }
	                                    _14384 = _12506;
	                                }
	                                _11521 = _12895;
	                                _14845 = _14384 + _11518;
	                                _11405 = false;
	                                break;
	                            }
	                            break; // unreachable workaround
	                        }
	                        break; // unreachable workaround
	                    } while(false);
	                    if (!_11405)
	                    {
	                        bool _11406;
	                        float3 _11522;
	                        float _12896;
	                        uint _14846;
	                        do
	                        {
	                            bool _18268;
	                            uint _21401 = g_SST.Load<uint>(_14845 * 4 + 0);
	                            do
	                            {
	                                _18268 = (_21401 & 1073741824u) != 0u;
	                                if (_18268)
	                                {
	                                    _12896 = asfloat((_21401 & 3221225471u) << uint(2));
	                                    break;
	                                }
	                                _12896 = _12894;
	                                break;
	                            } while(false);
	                            if (_18268)
	                            {
	                                float4 _10880 = _12896.xxxx;
	                                g_tOutDepth[_15314] = _10880;
	                                g_tOutDepth[_15314 + uint2(1u, 0u)] = _10880;
	                                g_tOutDepth[_15314 + uint2(0u, 1u)] = _10880;
	                                g_tOutDepth[_15314 + uint2(1u, 1u)] = _10880;
	                                g_tOutDepth[_15314 + uint2(2u, 0u)] = _10880;
	                                g_tOutDepth[_15314 + uint2(3u, 0u)] = _10880;
	                                g_tOutDepth[_15314 + uint2(2u, 1u)] = _10880;
	                                g_tOutDepth[_15314 + uint2(3u, 1u)] = _10880;
	                                g_tOutDepth[_15314 + uint2(0u, 2u)] = _10880;
	                                g_tOutDepth[_15314 + uint2(1u, 2u)] = _10880;
	                                g_tOutDepth[_15314 + uint2(0u, 3u)] = _10880;
	                                g_tOutDepth[_15314 + uint2(1u, 3u)] = _10880;
	                                g_tOutDepth[_15314 + uint2(2u, 2u)] = _10880;
	                                g_tOutDepth[_15314 + uint2(3u, 2u)] = _10880;
	                                g_tOutDepth[_15314 + uint2(2u, 3u)] = _10880;
	                                g_tOutDepth[_15314 + uint2(3u, 3u)] = _10880;
	                                _11522 = _11521;
	                                _14846 = _14845;
	                                _11406 = true;
	                                break;
	                            }
	                            else
	                            {
	                                bool _18269;
	                                uint _21973 = _14845 + 1u;
	                                float3 _12897;
	                                do
	                                {
	                                    _18269 = (_21401 & 2147483648u) != 0u;
	                                    if (_18269)
	                                    {
	                                        _12897 = float3(float((half)f16tof32(uint16_t(g_SST.Load<uint>(_21973 * 4 + 0) >> uint(16)))), float((half)f16tof32(uint16_t(g_SST.Load<uint>(_21973 * 4 + 0) & 65535u))), asfloat((_21401 & 2147483647u) << uint(1)));
	                                        break;
	                                    }
	                                    _12897 = _11521;
	                                    break;
	                                } while(false);
	                                if (_18269)
	                                {
	                                    uint2 _24340 = _23624 % uint2(16u, 16u);
	                                    float4 _22824 = _12897.xxxx * float4(0.0f, 1.0f, 2.0f, 3.0f);
	                                    float4 _22385 = ((_12897.z + (float(_24340.x) * _12897.x)) + (float(_24340.y) * _12897.y)).xxxx;
	                                    float4 _9990 = _22385 + _22824;
	                                    float4 _21805 = (_22385 + _12897.yyyy) + _22824;
	                                    float4 _20893 = (_22385 + (_12897.yyyy * 2.0f)) + _22824;
	                                    float4 _16203 = (_22385 + (_12897.yyyy * 3.0f)) + _22824;
	                                    g_tOutDepth[_15314] = _9990.x.xxxx;
	                                    g_tOutDepth[_15314 + uint2(1u, 0u)] = _9990.y.xxxx;
	                                    g_tOutDepth[_15314 + uint2(2u, 0u)] = _9990.z.xxxx;
	                                    g_tOutDepth[_15314 + uint2(3u, 0u)] = _9990.w.xxxx;
	                                    g_tOutDepth[_15314 + uint2(0u, 1u)] = _21805.x.xxxx;
	                                    g_tOutDepth[_15314 + uint2(1u, 1u)] = _21805.y.xxxx;
	                                    g_tOutDepth[_15314 + uint2(2u, 1u)] = _21805.z.xxxx;
	                                    g_tOutDepth[_15314 + uint2(3u, 1u)] = _21805.w.xxxx;
	                                    g_tOutDepth[_15314 + uint2(0u, 2u)] = _20893.x.xxxx;
	                                    g_tOutDepth[_15314 + uint2(1u, 2u)] = _20893.y.xxxx;
	                                    g_tOutDepth[_15314 + uint2(2u, 2u)] = _20893.z.xxxx;
	                                    g_tOutDepth[_15314 + uint2(3u, 2u)] = _20893.w.xxxx;
	                                    g_tOutDepth[_15314 + uint2(0u, 3u)] = _16203.x.xxxx;
	                                    g_tOutDepth[_15314 + uint2(1u, 3u)] = _16203.y.xxxx;
	                                    g_tOutDepth[_15314 + uint2(2u, 3u)] = _16203.z.xxxx;
	                                    g_tOutDepth[_15314 + uint2(3u, 3u)] = _16203.w.xxxx;
	                                    _11522 = _12897;
	                                    _14846 = _14845;
	                                    _11406 = true;
	                                    break;
	                                }
	                                else
	                                {
	                                    uint2 _13671 = _23624 % uint2(16u, 16u);
	                                    uint _21712;
	                                    if (_13671.x < 8u)
	                                    {
	                                        _21712 = (_13671.y < 8u) ? 0u : 2u;
	                                    }
	                                    else
	                                    {
	                                        _21712 = (_13671.y < 8u) ? 1u : 3u;
	                                    }
	                                    uint _14385;
	                                    if (_21712 == 0u)
	                                    {
	                                        _14385 = (_21401 >> uint(15)) & 32767u;
	                                    }
	                                    else
	                                    {
	                                        uint _12508;
	                                        if (_21712 == 1u)
	                                        {
	                                            _12508 = _21401 & 32767u;
	                                        }
	                                        else
	                                        {
	                                            uint _12507;
	                                            if (_21712 == 2u)
	                                            {
	                                                _12507 = (g_SST.Load<uint>(_21973 * 4 + 0) >> uint(15)) & 32767u;
	                                            }
	                                            else
	                                            {
	                                                _12507 = g_SST.Load<uint>(_21973 * 4 + 0) & 32767u;
	                                            }
	                                            _12508 = _12507;
	                                        }
	                                        _14385 = _12508;
	                                    }
	                                    _11522 = _12897;
	                                    _14846 = _14385 + _11518;
	                                    _11406 = false;
	                                    break;
	                                }
	                                break; // unreachable workaround
	                            }
	                            break; // unreachable workaround
	                        } while(false);
	                        if (!_11406)
	                        {
	                            bool _11407;
	                            uint _11523;
	                            float _12898;
	                            float3 _14847;
	                            do
	                            {
	                                bool _18270;
	                                uint _21402 = g_SST.Load<uint>(_14846 * 4 + 0);
	                                do
	                                {
	                                    _18270 = (_21402 & 1073741824u) != 0u;
	                                    if (_18270)
	                                    {
	                                        _12898 = asfloat((_21402 & 3221225471u) << uint(2));
	                                        break;
	                                    }
	                                    _12898 = _12896;
	                                    break;
	                                } while(false);
	                                if (_18270)
	                                {
	                                    float4 _10881 = _12898.xxxx;
	                                    g_tOutDepth[_15314] = _10881;
	                                    g_tOutDepth[_15314 + uint2(1u, 0u)] = _10881;
	                                    g_tOutDepth[_15314 + uint2(0u, 1u)] = _10881;
	                                    g_tOutDepth[_15314 + uint2(1u, 1u)] = _10881;
	                                    g_tOutDepth[_15314 + uint2(2u, 0u)] = _10881;
	                                    g_tOutDepth[_15314 + uint2(3u, 0u)] = _10881;
	                                    g_tOutDepth[_15314 + uint2(2u, 1u)] = _10881;
	                                    g_tOutDepth[_15314 + uint2(3u, 1u)] = _10881;
	                                    g_tOutDepth[_15314 + uint2(0u, 2u)] = _10881;
	                                    g_tOutDepth[_15314 + uint2(1u, 2u)] = _10881;
	                                    g_tOutDepth[_15314 + uint2(0u, 3u)] = _10881;
	                                    g_tOutDepth[_15314 + uint2(1u, 3u)] = _10881;
	                                    g_tOutDepth[_15314 + uint2(2u, 2u)] = _10881;
	                                    g_tOutDepth[_15314 + uint2(3u, 2u)] = _10881;
	                                    g_tOutDepth[_15314 + uint2(2u, 3u)] = _10881;
	                                    g_tOutDepth[_15314 + uint2(3u, 3u)] = _10881;
	                                    _11523 = _14846;
	                                    _14847 = _11522;
	                                    _11407 = true;
	                                    break;
	                                }
	                                else
	                                {
	                                    bool _18271;
	                                    uint _21974 = _14846 + 1u;
	                                    float3 _12899;
	                                    do
	                                    {
	                                        _18271 = (_21402 & 2147483648u) != 0u;
	                                        if (_18271)
	                                        {
	                                            _12899 = float3(float((half)f16tof32(uint16_t(g_SST.Load<uint>(_21974 * 4 + 0) >> uint(16)))), float((half)f16tof32(uint16_t(g_SST.Load<uint>(_21974 * 4 + 0) & 65535u))), asfloat((_21402 & 2147483647u) << uint(1)));
	                                            break;
	                                        }
	                                        _12899 = _11522;
	                                        break;
	                                    } while(false);
	                                    if (_18271)
	                                    {
	                                        uint2 _24341 = _23624 % uint2(8u, 8u);
	                                        float4 _22825 = _12899.xxxx * float4(0.0f, 1.0f, 2.0f, 3.0f);
	                                        float4 _22386 = ((_12899.z + (float(_24341.x) * _12899.x)) + (float(_24341.y) * _12899.y)).xxxx;
	                                        float4 _9991 = _22386 + _22825;
	                                        float4 _21806 = (_22386 + _12899.yyyy) + _22825;
	                                        float4 _20894 = (_22386 + (_12899.yyyy * 2.0f)) + _22825;
	                                        float4 _16204 = (_22386 + (_12899.yyyy * 3.0f)) + _22825;
	                                        g_tOutDepth[_15314] = _9991.x.xxxx;
	                                        g_tOutDepth[_15314 + uint2(1u, 0u)] = _9991.y.xxxx;
	                                        g_tOutDepth[_15314 + uint2(2u, 0u)] = _9991.z.xxxx;
	                                        g_tOutDepth[_15314 + uint2(3u, 0u)] = _9991.w.xxxx;
	                                        g_tOutDepth[_15314 + uint2(0u, 1u)] = _21806.x.xxxx;
	                                        g_tOutDepth[_15314 + uint2(1u, 1u)] = _21806.y.xxxx;
	                                        g_tOutDepth[_15314 + uint2(2u, 1u)] = _21806.z.xxxx;
	                                        g_tOutDepth[_15314 + uint2(3u, 1u)] = _21806.w.xxxx;
	                                        g_tOutDepth[_15314 + uint2(0u, 2u)] = _20894.x.xxxx;
	                                        g_tOutDepth[_15314 + uint2(1u, 2u)] = _20894.y.xxxx;
	                                        g_tOutDepth[_15314 + uint2(2u, 2u)] = _20894.z.xxxx;
	                                        g_tOutDepth[_15314 + uint2(3u, 2u)] = _20894.w.xxxx;
	                                        g_tOutDepth[_15314 + uint2(0u, 3u)] = _16204.x.xxxx;
	                                        g_tOutDepth[_15314 + uint2(1u, 3u)] = _16204.y.xxxx;
	                                        g_tOutDepth[_15314 + uint2(2u, 3u)] = _16204.z.xxxx;
	                                        g_tOutDepth[_15314 + uint2(3u, 3u)] = _16204.w.xxxx;
	                                        _11523 = _14846;
	                                        _14847 = _12899;
	                                        _11407 = true;
	                                        break;
	                                    }
	                                    else
	                                    {
	                                        uint2 _13672 = _23624 % uint2(8u, 8u);
	                                        uint _21713;
	                                        if (_13672.x < 4u)
	                                        {
	                                            _21713 = (_13672.y < 4u) ? 0u : 2u;
	                                        }
	                                        else
	                                        {
	                                            _21713 = (_13672.y < 4u) ? 1u : 3u;
	                                        }
	                                        uint _14386;
	                                        if (_21713 == 0u)
	                                        {
	                                            _14386 = (_21402 >> uint(15)) & 32767u;
	                                        }
	                                        else
	                                        {
	                                            uint _12510;
	                                            if (_21713 == 1u)
	                                            {
	                                                _12510 = _21402 & 32767u;
	                                            }
	                                            else
	                                            {
	                                                uint _12509;
	                                                if (_21713 == 2u)
	                                                {
	                                                    _12509 = (g_SST.Load<uint>(_21974 * 4 + 0) >> uint(15)) & 32767u;
	                                                }
	                                                else
	                                                {
	                                                    _12509 = g_SST.Load<uint>(_21974 * 4 + 0) & 32767u;
	                                                }
	                                                _12510 = _12509;
	                                            }
	                                            _14386 = _12510;
	                                        }
	                                        _11523 = _14386 + _11518;
	                                        _14847 = _12899;
	                                        _11407 = false;
	                                        break;
	                                    }
	                                    break; // unreachable workaround
	                                }
	                                break; // unreachable workaround
	                            } while(false);
	                            if (!_11407)
	                            {
	                                uint _21403 = g_SST.Load<uint>(_11523 * 4 + 0);
	                                float _13174;
	                                bool _16054;
	                                do
	                                {
	                                    if ((_21403 & 1073741824u) != 0u)
	                                    {
	                                        _13174 = asfloat((_21403 & 3221225471u) << uint(2));
	                                        _16054 = true;
	                                        break;
	                                    }
	                                    _13174 = _12898;
	                                    _16054 = false;
	                                    break;
	                                } while(false);
	                                if (_16054)
	                                {
	                                    float4 _10882 = _13174.xxxx;
	                                    g_tOutDepth[_15314] = _10882;
	                                    g_tOutDepth[_15314 + uint2(1u, 0u)] = _10882;
	                                    g_tOutDepth[_15314 + uint2(0u, 1u)] = _10882;
	                                    g_tOutDepth[_15314 + uint2(1u, 1u)] = _10882;
	                                    g_tOutDepth[_15314 + uint2(2u, 0u)] = _10882;
	                                    g_tOutDepth[_15314 + uint2(3u, 0u)] = _10882;
	                                    g_tOutDepth[_15314 + uint2(2u, 1u)] = _10882;
	                                    g_tOutDepth[_15314 + uint2(3u, 1u)] = _10882;
	                                    g_tOutDepth[_15314 + uint2(0u, 2u)] = _10882;
	                                    g_tOutDepth[_15314 + uint2(1u, 2u)] = _10882;
	                                    g_tOutDepth[_15314 + uint2(0u, 3u)] = _10882;
	                                    g_tOutDepth[_15314 + uint2(1u, 3u)] = _10882;
	                                    g_tOutDepth[_15314 + uint2(2u, 2u)] = _10882;
	                                    g_tOutDepth[_15314 + uint2(3u, 2u)] = _10882;
	                                    g_tOutDepth[_15314 + uint2(2u, 3u)] = _10882;
	                                    g_tOutDepth[_15314 + uint2(3u, 3u)] = _10882;
	                                }
	                                else
	                                {
	                                    uint _21975 = _11523 + 1u;
	                                    float3 _13175;
	                                    bool _16055;
	                                    do
	                                    {
	                                        if ((_21403 & 2147483648u) != 0u)
	                                        {
	                                            _13175 = float3(float((half)f16tof32(uint16_t(g_SST.Load<uint>(_21975 * 4 + 0) >> uint(16)))), float((half)f16tof32(uint16_t(g_SST.Load<uint>(_21975 * 4 + 0) & 65535u))), asfloat((_21403 & 2147483647u) << uint(1)));
	                                            _16055 = true;
	                                            break;
	                                        }
	                                        _13175 = _14847;
	                                        _16055 = false;
	                                        break;
	                                    } while(false);
	                                    if (_16055)
	                                    {
	                                        uint2 _24342 = _23624 % uint2(4u, 4u);
	                                        float4 _22826 = _13175.xxxx * float4(0.0f, 1.0f, 2.0f, 3.0f);
	                                        float4 _22387 = ((_13175.z + (float(_24342.x) * _13175.x)) + (float(_24342.y) * _13175.y)).xxxx;
	                                        float4 _9992 = _22387 + _22826;
	                                        float4 _21807 = (_22387 + _13175.yyyy) + _22826;
	                                        float4 _20895 = (_22387 + (_13175.yyyy * 2.0f)) + _22826;
	                                        float4 _16205 = (_22387 + (_13175.yyyy * 3.0f)) + _22826;
	                                        g_tOutDepth[_15314] = _9992.x.xxxx;
	                                        g_tOutDepth[_15314 + uint2(1u, 0u)] = _9992.y.xxxx;
	                                        g_tOutDepth[_15314 + uint2(2u, 0u)] = _9992.z.xxxx;
	                                        g_tOutDepth[_15314 + uint2(3u, 0u)] = _9992.w.xxxx;
	                                        g_tOutDepth[_15314 + uint2(0u, 1u)] = _21807.x.xxxx;
	                                        g_tOutDepth[_15314 + uint2(1u, 1u)] = _21807.y.xxxx;
	                                        g_tOutDepth[_15314 + uint2(2u, 1u)] = _21807.z.xxxx;
	                                        g_tOutDepth[_15314 + uint2(3u, 1u)] = _21807.w.xxxx;
	                                        g_tOutDepth[_15314 + uint2(0u, 2u)] = _20895.x.xxxx;
	                                        g_tOutDepth[_15314 + uint2(1u, 2u)] = _20895.y.xxxx;
	                                        g_tOutDepth[_15314 + uint2(2u, 2u)] = _20895.z.xxxx;
	                                        g_tOutDepth[_15314 + uint2(3u, 2u)] = _20895.w.xxxx;
	                                        g_tOutDepth[_15314 + uint2(0u, 3u)] = _16205.x.xxxx;
	                                        g_tOutDepth[_15314 + uint2(1u, 3u)] = _16205.y.xxxx;
	                                        g_tOutDepth[_15314 + uint2(2u, 3u)] = _16205.z.xxxx;
	                                        g_tOutDepth[_15314 + uint2(3u, 3u)] = _16205.w.xxxx;
	                                    }
	                                    else
	                                    {
	                                        if ((_21403 & 536870912u) != 0u)
	                                        {
	                                            uint _24813 = g_SST.Load<uint>(_21975 * 4 + 0);
	                                            uint _13655 = _11523 + 2u;
	                                            uint _6546 = g_SST.Load<uint>(_13655 * 4 + 0);
	                                            uint _13656 = _11523 + 3u;
	                                            uint _6547 = g_SST.Load<uint>(_13656 * 4 + 0);
	                                            uint _13657 = _11523 + 4u;
	                                            uint _16740 = g_SST.Load<uint>(_13657 * 4 + 0);
	                                            float4 _11451 = float((half)f16tof32(uint16_t(_21403 & 32767u))).xxxx;
	                                            float4 _17844 = float((half)f16tof32(uint16_t((_21403 >> uint(14)) & 32766u))).xxxx;
	                                            float4 _12210 = (_11451 * float4(float((_24813 >> uint(24)) & 255u), float((_24813 >> uint(16)) & 255u), float((_24813 >> uint(8)) & 255u), float(_24813 & 255u))) + _17844;
	                                            float4 _20116 = (_11451 * float4(float((_6546 >> uint(24)) & 255u), float((_6546 >> uint(16)) & 255u), float((_6546 >> uint(8)) & 255u), float(_6546 & 255u))) + _17844;
	                                            float4 _20117 = (_11451 * float4(float((_6547 >> uint(24)) & 255u), float((_6547 >> uint(16)) & 255u), float((_6547 >> uint(8)) & 255u), float(_6547 & 255u))) + _17844;
	                                            float4 _8748 = (_11451 * float4(float((_16740 >> uint(24)) & 255u), float((_16740 >> uint(16)) & 255u), float((_16740 >> uint(8)) & 255u), float(_16740 & 255u))) + _17844;
	                                            g_tOutDepth[_15314] = _12210.x.xxxx;
	                                            g_tOutDepth[_15314 + uint2(1u, 0u)] = _12210.y.xxxx;
	                                            g_tOutDepth[_15314 + uint2(2u, 0u)] = _12210.z.xxxx;
	                                            g_tOutDepth[_15314 + uint2(3u, 0u)] = _12210.w.xxxx;
	                                            g_tOutDepth[_15314 + uint2(0u, 1u)] = _20116.x.xxxx;
	                                            g_tOutDepth[_15314 + uint2(1u, 1u)] = _20116.y.xxxx;
	                                            g_tOutDepth[_15314 + uint2(2u, 1u)] = _20116.z.xxxx;
	                                            g_tOutDepth[_15314 + uint2(3u, 1u)] = _20116.w.xxxx;
	                                            g_tOutDepth[_15314 + uint2(0u, 2u)] = _20117.x.xxxx;
	                                            g_tOutDepth[_15314 + uint2(1u, 2u)] = _20117.y.xxxx;
	                                            g_tOutDepth[_15314 + uint2(2u, 2u)] = _20117.z.xxxx;
	                                            g_tOutDepth[_15314 + uint2(3u, 2u)] = _20117.w.xxxx;
	                                            g_tOutDepth[_15314 + uint2(0u, 3u)] = _8748.x.xxxx;
	                                            g_tOutDepth[_15314 + uint2(1u, 3u)] = _8748.y.xxxx;
	                                            g_tOutDepth[_15314 + uint2(2u, 3u)] = _8748.z.xxxx;
	                                            g_tOutDepth[_15314 + uint2(3u, 3u)] = _8748.w.xxxx;
	                                        }
	                                        else
	                                        {
	                                            uint _24812 = g_SST.Load<uint>(_21975 * 4 + 0);
	                                            uint _13648 = _11523 + 2u;
	                                            uint _6540 = g_SST.Load<uint>(_13648 * 4 + 0);
	                                            uint _13649 = _11523 + 3u;
	                                            uint _6541 = g_SST.Load<uint>(_13649 * 4 + 0);
	                                            uint _13650 = _11523 + 4u;
	                                            uint _6542 = g_SST.Load<uint>(_13650 * 4 + 0);
	                                            uint _13651 = _11523 + 5u;
	                                            uint _6543 = g_SST.Load<uint>(_13651 * 4 + 0);
	                                            uint _13652 = _11523 + 6u;
	                                            uint _6544 = g_SST.Load<uint>(_13652 * 4 + 0);
	                                            uint _13653 = _11523 + 7u;
	                                            uint _6545 = g_SST.Load<uint>(_13653 * 4 + 0);
	                                            uint _13654 = _11523 + 8u;
	                                            uint _16739 = g_SST.Load<uint>(_13654 * 4 + 0);
	                                            float4 _11450 = float((half)f16tof32(uint16_t(_21403 & 32767u))).xxxx;
	                                            float4 _17843 = float((half)f16tof32(uint16_t((_21403 >> uint(14)) & 32766u))).xxxx;
	                                            float4 _12209 = (_11450 * float4(float((_24812 >> uint(16)) & 65535u), float(_24812 & 65535u), float((_6540 >> uint(16)) & 65535u), float(_6540 & 65535u))) + _17843;
	                                            float4 _20114 = (_11450 * float4(float((_6541 >> uint(16)) & 65535u), float(_6541 & 65535u), float((_6542 >> uint(16)) & 65535u), float(_6542 & 65535u))) + _17843;
	                                            float4 _20115 = (_11450 * float4(float((_6543 >> uint(16)) & 65535u), float(_6543 & 65535u), float((_6544 >> uint(16)) & 65535u), float(_6544 & 65535u))) + _17843;
	                                            float4 _8747 = (_11450 * float4(float((_6545 >> uint(16)) & 65535u), float(_6545 & 65535u), float((_16739 >> uint(16)) & 65535u), float(_16739 & 65535u))) + _17843;
	                                            g_tOutDepth[_15314] = _12209.x.xxxx;
	                                            g_tOutDepth[_15314 + uint2(1u, 0u)] = _12209.y.xxxx;
	                                            g_tOutDepth[_15314 + uint2(2u, 0u)] = _12209.z.xxxx;
	                                            g_tOutDepth[_15314 + uint2(3u, 0u)] = _12209.w.xxxx;
	                                            g_tOutDepth[_15314 + uint2(0u, 1u)] = _20114.x.xxxx;
	                                            g_tOutDepth[_15314 + uint2(1u, 1u)] = _20114.y.xxxx;
	                                            g_tOutDepth[_15314 + uint2(2u, 1u)] = _20114.z.xxxx;
	                                            g_tOutDepth[_15314 + uint2(3u, 1u)] = _20114.w.xxxx;
	                                            g_tOutDepth[_15314 + uint2(0u, 2u)] = _20115.x.xxxx;
	                                            g_tOutDepth[_15314 + uint2(1u, 2u)] = _20115.y.xxxx;
	                                            g_tOutDepth[_15314 + uint2(2u, 2u)] = _20115.z.xxxx;
	                                            g_tOutDepth[_15314 + uint2(3u, 2u)] = _20115.w.xxxx;
	                                            g_tOutDepth[_15314 + uint2(0u, 3u)] = _8747.x.xxxx;
	                                            g_tOutDepth[_15314 + uint2(1u, 3u)] = _8747.y.xxxx;
	                                            g_tOutDepth[_15314 + uint2(2u, 3u)] = _8747.z.xxxx;
	                                            g_tOutDepth[_15314 + uint2(3u, 3u)] = _8747.w.xxxx;
	                                        }
	                                    }
	                                }
	                            }
	                        }
	                    }
	                }
	            }
	        }
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
