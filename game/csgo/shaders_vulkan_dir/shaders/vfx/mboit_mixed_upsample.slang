//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "MBOIT Mixed Resolution Upsample";
	DevShader = true;
	Version = 0;
	
	// Platform: VULKAN_SM_50
	// Programs: cs
}

MODES
{
	Default();
	CsgoForward();
	ToolsVis();
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
	DynamicCombo( D_MODE, 0..2 );
	DynamicCombo( D_FORCE_MR, 0..1 );
	
	float g_flDepthThreshold < Attribute("DepthThreshold"); UiType(Slider); >;
	float g_flJoinedSigma < Attribute("JoinedSigma"); UiType(Slider); >;
	RWTexture2D<float4> g_tColorFull < Attribute("ColorFull"); >;
	Texture2D g_tColorHalf < Attribute("ColorHalf"); SrgbRead(false); >;
	Texture2D g_tColorQuarter < Attribute("ColorQuarter"); SrgbRead(false); >;
	RWTexture2D<float4> g_tExtraFull < Attribute("ExtraFull"); >;
	Texture2D g_tExtraFull < Attribute("ExtraFull"); SrgbRead(false); >;
	RWTexture2D<float4> g_tExtraHalf < Attribute("ExtraHalf"); >;
	Texture2D g_tExtraHalf < Attribute("ExtraHalf"); SrgbRead(false); >;
	RWTexture2D<float4> g_tExtraQuarter < Attribute("ExtraQuarter"); >;
	Texture2D g_tExtraQuarter < Attribute("ExtraQuarter"); SrgbRead(false); >;
	Texture2D g_tLinearDepthFull < Attribute("LinearDepthFull"); SrgbRead(false); >;
	Texture2D g_tLinearDepthHalf < Attribute("LinearDepthHalf"); SrgbRead(false); >;
	Texture2D g_tLinearDepthQuarter < Attribute("LinearDepthQuarter"); SrgbRead(false); >;
	Texture2D g_tMomentFull < Attribute("MomentFull"); SrgbRead(false); >;
	RWTexture2D<float4> g_tMomentHalf < Attribute("MomentHalf"); >;
	RWTexture2D<float4> g_tMomentQuarter < Attribute("MomentQuarter"); >;
	RWTexture2D<float4> g_tMomentsFull < Attribute("MomentsFull"); >;
	Texture2D g_tMomentsHalf < Attribute("MomentsHalf"); SrgbRead(false); >;
	Texture2D g_tMomentsQuarter < Attribute("MomentsQuarter"); SrgbRead(false); >;
	RWTexture2D<float4> g_tSmokeDepthCombined < Attribute("SmokeDepthCombined"); >;
	Texture2D g_tSmokeDepthHalf < Attribute("SmokeDepthHalf"); SrgbRead(false); >;
	Texture2D g_tSmokeDepthQuarter < Attribute("SmokeDepthQuarter"); SrgbRead(false); >;
	RWTexture2D<float4> g_tZerothFull < Attribute("ZerothFull"); >;
	Texture2D g_tZerothFull < Attribute("ZerothFull"); SrgbRead(false); >;
	RWTexture2D<float4> g_tZerothHalf < Attribute("ZerothHalf"); >;
	Texture2D g_tZerothHalf < Attribute("ZerothHalf"); SrgbRead(false); >;
	RWTexture2D<float4> g_tZerothQuarter < Attribute("ZerothQuarter"); >;
	Texture2D g_tZerothQuarter < Attribute("ZerothQuarter"); SrgbRead(false); >;
	float4 g_vOutputDim < Attribute("OutputDim"); UiType(VectorText); >;
	
	
	// Variant parameters
	RWTexture2D<float4> g_tExtraFull < Attribute("ExtraFull"); >;
	Texture2D g_tExtraFull < Attribute("ExtraFull"); SrgbRead(false); >;
	RWTexture2D<float4> g_tExtraHalf < Attribute("ExtraHalf"); >;
	Texture2D g_tExtraHalf < Attribute("ExtraHalf"); SrgbRead(false); >;
	RWTexture2D<float4> g_tExtraQuarter < Attribute("ExtraQuarter"); >;
	Texture2D g_tExtraQuarter < Attribute("ExtraQuarter"); SrgbRead(false); >;
	RWTexture2D<float4> g_tZerothFull < Attribute("ZerothFull"); >;
	Texture2D g_tZerothFull < Attribute("ZerothFull"); SrgbRead(false); >;
	RWTexture2D<float4> g_tZerothHalf < Attribute("ZerothHalf"); >;
	Texture2D g_tZerothHalf < Attribute("ZerothHalf"); SrgbRead(false); >;
	RWTexture2D<float4> g_tZerothQuarter < Attribute("ZerothQuarter"); >;
	Texture2D g_tZerothQuarter < Attribute("ZerothQuarter"); SrgbRead(false); >;
	
	// SPIR-V reflection failed for backend HLSL:
	// cbuffer ID 5618 (name: _Globals_), member index 0 (name: g_vOutputDim) cannot be expressed with either HLSL packing layout or packoffset.
	//
	// Re-attempting reflection with the GLSL backend.
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, GLSL reflection with SPIRV-Cross by KhronosGroup
	
	#version 460
	#extension GL_EXT_samplerless_texture_functions : require
	#extension GL_EXT_shader_image_load_formatted : require
	layout(local_size_x = 8, local_size_y = 8, local_size_z = 1) in;
	
	vec4 _4;
	
	struct _1052
	{
	    vec4 g_vOutputDim;
	    float g_flDepthThreshold;
	    float g_flJoinedSigma;
	};
	
	layout(set = 0) uniform _1052 _Globals_;
	
	struct _1000
	{
	    float _m0;
	    float _m1;
	};
	
	layout(set = 0) uniform _1000 PerViewConstantBuffer_t;
	
	layout(set = 0, binding = 35) uniform texture2D g_tZerothQuarter;
	layout(set = 0, binding = 33) uniform texture2D g_tSmokeDepthQuarter;
	layout(set = 0, binding = 30) uniform texture2D g_tLinearDepthQuarter;
	layout(set = 0, binding = 37) uniform texture2D g_tMomentsQuarter;
	layout(set = 0, binding = 38) uniform texture2D g_tExtraQuarter;
	layout(set = 0, binding = 36) uniform texture2D g_tZerothHalf;
	layout(set = 0, binding = 31) uniform texture2D g_tLinearDepthHalf;
	layout(set = 0, binding = 34) uniform texture2D g_tSmokeDepthHalf;
	layout(set = 0, binding = 39) uniform texture2D g_tMomentsHalf;
	layout(set = 0, binding = 40) uniform texture2D g_tExtraHalf;
	layout(set = 0, binding = 158) uniform writeonly image2D g_tSmokeDepthCombined;
	layout(set = 0, binding = 32) uniform texture2D g_tLinearDepthFull;
	layout(set = 0, binding = 159) uniform image2D g_tZerothFull;
	layout(set = 0, binding = 160) uniform image2D g_tMomentsFull;
	layout(set = 0, binding = 161) uniform image2D g_tExtraFull;
	
	shared float _3449[25];
	shared vec2 _5300[25];
	shared float _5084[25];
	shared vec2 _5745[25];
	shared vec4 _4516[25];
	shared float _5504[36];
	shared float _5750[36];
	shared vec2 _4675[36];
	shared vec2 _3430[36];
	shared vec4 _4077[36];
	
	void main()
	{
	    do
	    {
	        uvec2 _3849 = (gl_WorkGroupID.xy * uvec2(8u)) + gl_LocalInvocationID.xy;
	        uint _3100 = (gl_LocalInvocationID.y * 8u) + gl_LocalInvocationID.x;
	        if (_3100 < 25u)
	        {
	            ivec3 _9620 = min(max(ivec3(0), ivec3(ivec2(((gl_WorkGroupID.xy * uvec2(2u)) - uvec2(1u)) + uvec2(_3100 % 5u, _3100 / 5u)), 0)), ivec3(ivec2(_Globals_.g_vOutputDim.xy * vec2(0.25)), 0));
	            ivec2 _21441 = _9620.xy;
	            int _13855 = _9620.z;
	            _3449[_3100] = texelFetch(g_tZerothQuarter, _21441, _13855).x;
	            _5300[_3100] = texelFetch(g_tSmokeDepthQuarter, _21441, _13855).xy;
	            _5084[_3100] = texelFetch(g_tLinearDepthQuarter, _21441, _13855).x;
	            if (_3449[_3100] == 0.0)
	            {
	                _5745[_3100] = vec2(0.0);
	                _4516[_3100] = vec4(0.0);
	            }
	            else
	            {
	                _5745[_3100] = texelFetch(g_tMomentsQuarter, _21441, _13855).xy;
	                _4516[_3100] = texelFetch(g_tExtraQuarter, _21441, _13855);
	            }
	            if (_5300[_3100].y > 1.5)
	            {
	                _5300[_3100].y = -_5300[_3100].y;
	            }
	        }
	        else
	        {
	            if (_3100 < 61u)
	            {
	                uint _22201 = _3100 - 25u;
	                ivec3 _9621 = min(max(ivec3(0), ivec3(ivec2(((gl_WorkGroupID.xy * uvec2(4u)) - uvec2(1u)) + uvec2(ivec2(int(_22201 % 6u), int(_22201 / 6u)))), 0)), ivec3(ivec2(_Globals_.g_vOutputDim.xy * vec2(0.5)), 0));
	                ivec2 _21442 = _9621.xy;
	                int _13856 = _9621.z;
	                _5504[_22201] = texelFetch(g_tZerothHalf, _21442, _13856).x;
	                _5750[_22201] = texelFetch(g_tLinearDepthHalf, _21442, _13856).x;
	                if (_5504[_22201] == 0.0)
	                {
	                    _4675[_22201] = vec2(2.0, -2.0);
	                    _3430[_22201] = vec2(0.0);
	                    _4077[_22201] = vec4(0.0);
	                }
	                else
	                {
	                    _4675[_22201] = texelFetch(g_tSmokeDepthHalf, _21442, _13856).xy;
	                    _3430[_22201] = texelFetch(g_tMomentsHalf, _21442, _13856).xy;
	                    _4077[_22201] = texelFetch(g_tExtraHalf, _21442, _13856);
	                }
	                if (_4675[_22201].y > 1.5)
	                {
	                    _4675[_22201].y = -_4675[_22201].y;
	                }
	            }
	        }
	        barrier();
	        uint _20318 = _3849.x;
	        uint _24257 = uint(_Globals_.g_vOutputDim.x);
	        bool _12885;
	        if (_20318 < _24257)
	        {
	            _12885 = _3849.y < uint(_Globals_.g_vOutputDim.y);
	        }
	        else
	        {
	            _12885 = false;
	        }
	        if (_12885)
	        {
	            bool _12886;
	            if (gl_LocalInvocationID.x < 6u)
	            {
	                _12886 = gl_LocalInvocationID.y < 6u;
	            }
	            else
	            {
	                _12886 = false;
	            }
	            if (_12886)
	            {
	                vec2 _15857 = vec2(uvec2(gl_LocalInvocationID.xy));
	                vec2 _23245 = (_15857 * 0.5) + vec2(0.25);
	                uvec2 _10569 = uvec2(_23245);
	                uint _3925 = (_10569.y * 5u) + _10569.x;
	                uint _13648 = _3925 + 1u;
	                uint _13649 = _3925 + 5u;
	                uint _13650 = _3925 + 6u;
	                vec2 _17895 = fract(_23245);
	                float _23592 = _17895.x;
	                float _16927 = 1.0 - _23592;
	                float _7380 = _17895.y;
	                float _13108 = 1.0 - _7380;
	                float _19631 = _16927 * _13108;
	                float _20716 = _23592 * _13108;
	                float _22329 = _16927 * _7380;
	                float _22330 = _23592 * _7380;
	                if (((((_3449[_3925] * _19631) + (_3449[_13648] * _20716)) + (_3449[_13649] * _22329)) + (_3449[_13650] * _22330)) != 0.0)
	                {
	                    uvec2 _15661 = uvec2(max(vec2(0.0), _15857));
	                    uint _7519 = (_15661.y * 6u) + _15661.x;
	                    float _12167 = min(_5300[_3925].x, min(_5300[_13648].x, min(_5300[_13649].x, _5300[_13650].x)));
	                    float _12887 = max(_5300[_3925].y, max(_5300[_13648].y, max(_5300[_13649].y, _5300[_13650].y)));
	                    vec4 _22401;
	                    do
	                    {
	                        float _17238 = log(PerViewConstantBuffer_t._m0);
	                        float _12178 = (((log(_5750[_7519]) - _17238) / (log(PerViewConstantBuffer_t._m1) - _17238)) * 2.0) - 1.0;
	                        bool _12888;
	                        if (_12887 < (-1.0))
	                        {
	                            _12888 = true;
	                        }
	                        else
	                        {
	                            _12888 = _12178 > _12887;
	                        }
	                        if (_12888)
	                        {
	                            _22401 = vec4(_19631, _20716, _22329, _22330);
	                            break;
	                        }
	                        if (_12178 < _12167)
	                        {
	                            _22401 = vec4(0.0);
	                            break;
	                        }
	                        vec4 _13625 = vec4(_5750[_7519]);
	                        vec4 _21922 = abs(_13625 - vec4(_5084[_3925], _5084[_13648], _5084[_13649], _5084[_13650])) / _13625;
	                        if (all(lessThan(_21922, vec4(_Globals_.g_flDepthThreshold))))
	                        {
	                            _22401 = vec4(_19631, _20716, _22329, _22330);
	                            break;
	                        }
	                        float _14875 = _21922.x;
	                        float _21156 = (2.0 * _Globals_.g_flJoinedSigma) * _Globals_.g_flJoinedSigma;
	                        float _6509 = _21922.y;
	                        float _6510 = _21922.z;
	                        float _6511 = _21922.w;
	                        _22401 = vec4(_19631, _20716, _22329, _22330) * vec4(exp((-(_14875 * _14875)) / _21156), exp((-(_6509 * _6509)) / _21156), exp((-(_6510 * _6510)) / _21156), exp((-(_6511 * _6511)) / _21156));
	                        break;
	                    } while(false);
	                    _5504[_7519] += ((((_3449[_3925] * _22401.x) + (_3449[_13648] * _22401.y)) + (_3449[_13649] * _22401.z)) + (_3449[_13650] * _22401.w));
	                    _3430[_7519] = ((((_5745[_3925] * _22401.x) + (_5745[_13648] * _22401.y)) + (_5745[_13649] * _22401.z)) + (_5745[_13650] * _22401.w)) + _3430[_7519];
	                    _4077[_7519] = ((((_4516[_3925] * _22401.x) + (_4516[_13648] * _22401.y)) + (_4516[_13649] * _22401.z)) + (_4516[_13650] * _22401.w)) + _4077[_7519];
	                    _4675[_7519] = vec2(min(_12167, _4675[_7519].x), max(_12887, _4675[_7519].y));
	                }
	                bool _12889;
	                if (gl_LocalInvocationID.x > 0u)
	                {
	                    _12889 = gl_LocalInvocationID.x < 5u;
	                }
	                else
	                {
	                    _12889 = false;
	                }
	                bool _12890;
	                if (_12889)
	                {
	                    _12890 = gl_LocalInvocationID.y > 0u;
	                }
	                else
	                {
	                    _12890 = false;
	                }
	                bool _12891;
	                if (_12890)
	                {
	                    _12891 = gl_LocalInvocationID.y < 5u;
	                }
	                else
	                {
	                    _12891 = false;
	                }
	                if (_12891)
	                {
	                    uvec2 _15662 = uvec2(max(vec2(0.0), _15857));
	                    uint _16310 = (_15662.y * 6u) + _15662.x;
	                    vec2 _16932 = _4675[_16310];
	                    vec2 _22781;
	                    if (_16932.y < (-1.0))
	                    {
	                        vec2 _23482 = _16932;
	                        _23482.y = 2.0;
	                        _22781 = _23482;
	                    }
	                    else
	                    {
	                        _22781 = _16932;
	                    }
	                    imageStore(g_tSmokeDepthCombined, ivec2((gl_WorkGroupID.xy * uvec2(4u)) + (gl_LocalInvocationID.xy - uvec2(1u))), vec4(_22781, 0.0, 0.0));
	                }
	            }
	        }
	        barrier();
	        bool _12892;
	        if (_20318 >= _24257)
	        {
	            _12892 = _3849.y >= uint(_Globals_.g_vOutputDim.y);
	        }
	        else
	        {
	            _12892 = false;
	        }
	        if (_12892)
	        {
	            break;
	        }
	        vec2 _5247 = ((vec2(gl_LocalInvocationID.xy) + vec2(0.5)) * 0.5) + vec2(0.5);
	        uvec2 _19471 = uvec2(max(vec2(0.0), _5247));
	        int _4275 = int((_19471.y * 6u) + _19471.x);
	        int _13651 = _4275 + 1;
	        int _13652 = _4275 + 6;
	        int _13653 = _4275 + 7;
	        vec2 _17896 = fract(_5247);
	        float _23593 = _17896.x;
	        float _16928 = 1.0 - _23593;
	        float _7381 = _17896.y;
	        float _13109 = 1.0 - _7381;
	        float _19632 = _16928 * _13109;
	        float _20717 = _23593 * _13109;
	        float _22331 = _16928 * _7381;
	        float _22332 = _23593 * _7381;
	        if (((((_5504[_4275] * _19632) + (_5504[_13651] * _20717)) + (_5504[_13652] * _22331)) + (_5504[_13653] * _22332)) != 0.0)
	        {
	            float _22112 = max(_4675[_4275].y, max(_4675[_13651].y, max(_4675[_13652].y, _4675[_13653].y)));
	            ivec2 _11480 = ivec2(_3849);
	            vec4 _19165 = texelFetch(g_tLinearDepthFull, ivec3(_11480, 0).xy, 0);
	            float _17621 = _19165.x;
	            vec4 _23104;
	            do
	            {
	                float _17239 = log(PerViewConstantBuffer_t._m0);
	                float _12179 = (((log(_17621) - _17239) / (log(PerViewConstantBuffer_t._m1) - _17239)) * 2.0) - 1.0;
	                bool _12893;
	                if (_22112 < (-1.0))
	                {
	                    _12893 = true;
	                }
	                else
	                {
	                    _12893 = _12179 > _22112;
	                }
	                if (_12893)
	                {
	                    _23104 = vec4(_19632, _20717, _22331, _22332);
	                    break;
	                }
	                if (_12179 < min(_4675[_4275].x, min(_4675[_13651].x, min(_4675[_13652].x, _4675[_13653].x))))
	                {
	                    _23104 = vec4(0.0);
	                    break;
	                }
	                vec4 _13626 = vec4(_17621);
	                vec4 _21923 = abs(_13626 - vec4(_5750[_4275], _5750[_13651], _5750[_13652], _5750[_13653])) / _13626;
	                if (all(lessThan(_21923, vec4(_Globals_.g_flDepthThreshold))))
	                {
	                    _23104 = vec4(_19632, _20717, _22331, _22332);
	                    break;
	                }
	                float _14876 = _21923.x;
	                float _21157 = (2.0 * _Globals_.g_flJoinedSigma) * _Globals_.g_flJoinedSigma;
	                float _6512 = _21923.y;
	                float _6513 = _21923.z;
	                float _6514 = _21923.w;
	                _23104 = vec4(_19632, _20717, _22331, _22332) * vec4(exp((-(_14876 * _14876)) / _21157), exp((-(_6512 * _6512)) / _21157), exp((-(_6513 * _6513)) / _21157), exp((-(_6514 * _6514)) / _21157));
	                break;
	            } while(false);
	            vec4 _15540 = imageLoad(g_tMomentsFull, _11480);
	            vec4 _3300 = imageLoad(g_tExtraFull, _11480);
	            imageStore(g_tZerothFull, ivec2(_3849), vec4(imageLoad(g_tZerothFull, _11480).x + ((((_5504[_4275] * _23104.x) + (_5504[_13651] * _23104.y)) + (_5504[_13652] * _23104.z)) + (_5504[_13653] * _23104.w))));
	            imageStore(g_tMomentsFull, ivec2(_3849), vec4(_15540.xy + ((((_3430[_4275] * _23104.x) + (_3430[_13651] * _23104.y)) + (_3430[_13652] * _23104.z)) + (_3430[_13653] * _23104.w)), 0.0, 0.0));
	            imageStore(g_tExtraFull, ivec2(_3849), _3300 + ((((_4077[_4275] * _23104.x) + (_4077[_13651] * _23104.y)) + (_4077[_13652] * _23104.z)) + (_4077[_13653] * _23104.w)));
	        }
	        break;
	    } while(false);
	}
	
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
}
