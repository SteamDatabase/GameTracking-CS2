//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "GPU Implicit Surface Gen";
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
	DynamicCombo( D_PARTICLE_LDS_CACHE, 0..1 );
	DynamicCombo( D_DEBUG_STATS, 0..1 );
	DynamicCombo( D_FIELD_MODE, 0..1 );
	DynamicCombo( D_PER_PARTICLE_RADIUS, 0..1 );
	
	StructuredBuffer g_DispatchBuffer < Attribute("DispatchBuffer"); >;
	RWByteAddressBuffer g_IndexBuffer < Attribute("IndexBuffer"); >;
	RWBuffer<float4> g_IndirectDrawArgs < Attribute("IndirectDrawArgs"); >;
	Buffer g_LookupTables < Attribute("LookupTables"); SrgbRead(false); >;
	StructuredBuffer g_Particles < Attribute("ParticleBuffer"); >;
	RWByteAddressBuffer g_VertexBuffer < Attribute("VertexBuffer"); >;
	float g_fIsosurfaceThreshold < Attribute("IsosurfaceThreshold"); UiType(Slider); >;
	int g_nBrickHeight < Attribute("BrickHeight"); UiType(Slider); >;
	int g_nClassDataOffset < Attribute("ClassDataOffset"); UiType(Slider); >;
	int g_nIndexBufferSize < Attribute("IndexBufferSize"); UiType(Slider); >;
	int g_nTriangleDataOffset < Attribute("TriangleTableOffset"); UiType(Slider); >;
	int g_nVertexBufferSize < Attribute("VertexBufferSize"); UiType(Slider); >;
	int g_nVertexDataOffset < Attribute("VertexDataOffset"); UiType(Slider); >;
	float4 g_vBlobulatorConstants < Attribute("BlobulatorConstants"); UiType(VectorText); >;
	float4 g_vSoftObjectCoefficients < Attribute("SoftObjectCoefficients"); UiType(VectorText); >;
	float3 g_vSystemOrigin < Attribute("SystemOrigin"); UiType(VectorText); >;
	float3 g_vSystemStepSize < Attribute("SystemStepSize"); UiType(VectorText); >;
	
	// SPIR-V reflection failed for backend HLSL:
	// cbuffer ID 5618 (name: _Globals_), member index 5 (name: g_vBlobulatorConstants) cannot be expressed with either HLSL packing layout or packoffset.
	//
	// Re-attempting reflection with the GLSL backend.
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, GLSL reflection with SPIRV-Cross by KhronosGroup
	
	#version 460
	#extension GL_EXT_samplerless_texture_functions : require
	layout(local_size_x = 8, local_size_y = 8, local_size_z = 1) in;
	
	struct _990
	{
	    uint _m0;
	    uint _m1;
	};
	
	struct _1022
	{
	    vec3 _m0;
	    float _m1;
	};
	
	struct _991
	{
	    uint _m0;
	    uint _m1;
	};
	
	uint _4;
	
	layout(set = 0, binding = 31, std430) readonly buffer g_DispatchBuffer
	{
	    _990 _m0[];
	} g_DispatchBuffer_1;
	
	struct _1529
	{
	    uint g_nTriangleDataOffset;
	    uint g_nClassDataOffset;
	    uint g_nVertexDataOffset;
	    uint g_nBrickHeight;
	    float g_fIsosurfaceThreshold;
	    vec4 g_vBlobulatorConstants;
	    vec3 g_vSystemOrigin;
	    vec3 g_vSystemStepSize;
	    uint g_nVertexBufferSize;
	    uint g_nIndexBufferSize;
	};
	
	layout(set = 0) uniform _1529 _Globals_;
	
	layout(set = 0, binding = 32, std430) readonly buffer g_Particles
	{
	    _1022 _m0[];
	} g_Particles_1;
	
	layout(set = 0, binding = 159, std430) buffer g_VertexBuffer
	{
	    uint _m0[];
	} g_VertexBuffer_1;
	
	layout(set = 0, binding = 160, std430) buffer g_IndexBuffer
	{
	    uint _m0[];
	} g_IndexBuffer_1;
	
	layout(set = 0, binding = 30) uniform usamplerBuffer g_LookupTables;
	layout(set = 0, binding = 158, r32ui) uniform uimageBuffer g_IndirectDrawArgs;
	
	shared uint _5696;
	shared uint _5501;
	shared float _3739[64][2];
	shared _991 _3560[49];
	shared uint _4676[49];
	
	void main()
	{
	    uint _21607 = g_DispatchBuffer_1._m0[gl_WorkGroupID.x]._m1;
	    uint _15978 = _21607 >> uint(16);
	    uint _9584 = _21607 & 65535u;
	    uint _5563 = (gl_LocalInvocationID.y * 8u) + gl_LocalInvocationID.x;
	    vec3 _22446 = _Globals_.g_vSystemOrigin + (_Globals_.g_vSystemStepSize * vec3(uvec3((g_DispatchBuffer_1._m0[gl_WorkGroupID.x]._m0 & 1023u) * 7u, ((g_DispatchBuffer_1._m0[gl_WorkGroupID.x]._m0 >> uint(10)) & 1023u) * 7u, ((g_DispatchBuffer_1._m0[gl_WorkGroupID.x]._m0 >> uint(20)) & 4095u) * 4u)));
	    vec3 _6302 = _22446 + vec3(_Globals_.g_vSystemStepSize.xy * vec2(gl_LocalInvocationID.xy), 0.0);
	    bool _8412 = all(equal(gl_LocalInvocationID.xy, uvec2(0u)));
	    if (_8412)
	    {
	        _5696 = 0u;
	        _5501 = 0u;
	    }
	    float _13155;
	    _13155 = 0.0;
	    uint _14722;
	    float _20258;
	    uint _16208 = _15978;
	    for (;;)
	    {
	        if (!(_16208 < _9584))
	        {
	            break;
	        }
	        vec3 _12928 = _6302 - g_Particles_1._m0[_16208]._m0;
	        float _18342 = dot(_12928, _12928);
	        float _11237;
	        if (_18342 <= _Globals_.g_vBlobulatorConstants.x)
	        {
	            float _19902 = _18342 * _Globals_.g_vBlobulatorConstants.y;
	            _11237 = (0.25 + (_19902 * _19902)) - _19902;
	        }
	        else
	        {
	            _11237 = 0.0;
	        }
	        _20258 = _13155 + (_11237 * g_Particles_1._m0[_16208]._m1);
	        _14722 = _16208 + 1u;
	        _13155 = _20258;
	        _16208 = _14722;
	        continue;
	    }
	    _3739[_5563][0] = (_13155 - _Globals_.g_fIsosurfaceThreshold) * (-1.0);
	    vec3 _13137;
	    vec3 _16305;
	    _13137 = _22446;
	    _16305 = _6302;
	    uint _4300;
	    vec3 _14716;
	    vec3 _19764;
	    uint _13039;
	    uint _17017 = 1u;
	    uint _17133 = _15978;
	    for (;;)
	    {
	        if (!(_17017 <= _Globals_.g_nBrickHeight))
	        {
	            break;
	        }
	        _13039 = _17133;
	        uint _23989;
	        for (;;)
	        {
	            bool _12885;
	            if (_13039 < _9584)
	            {
	                _12885 = (g_Particles_1._m0[_13039]._m0.z + _Globals_.g_vBlobulatorConstants.w) < _16305.z;
	            }
	            else
	            {
	                _12885 = false;
	            }
	            if (!_12885)
	            {
	                break;
	            }
	            _23989 = _13039 + 1u;
	            _13039 = _23989;
	            continue;
	        }
	        _14716 = _13137;
	        _14716.z = _13137.z + _Globals_.g_vSystemStepSize.z;
	        _19764 = _16305;
	        _19764.z = _16305.z + _Globals_.g_vSystemStepSize.z;
	        float _13156;
	        _13156 = 0.0;
	        uint _14723;
	        float _20259;
	        uint _16209 = _13039;
	        for (;;)
	        {
	            if (!(_16209 < _9584))
	            {
	                break;
	            }
	            vec3 _12929 = _19764 - g_Particles_1._m0[_16209]._m0;
	            float _18343 = dot(_12929, _12929);
	            float _11238;
	            if (_18343 <= _Globals_.g_vBlobulatorConstants.x)
	            {
	                float _19903 = _18343 * _Globals_.g_vBlobulatorConstants.y;
	                _11238 = (0.25 + (_19903 * _19903)) - _19903;
	            }
	            else
	            {
	                _11238 = 0.0;
	            }
	            _20259 = _13156 + (_11238 * g_Particles_1._m0[_16209]._m1);
	            _14723 = _16209 + 1u;
	            _13156 = _20259;
	            _16209 = _14723;
	            continue;
	        }
	        _3739[_5563][1] = (_13156 - _Globals_.g_fIsosurfaceThreshold) * (-1.0);
	        barrier();
	        if (all(lessThan(gl_LocalInvocationID.xy, uvec2(7u))))
	        {
	            uvec2 _19313 = gl_LocalInvocationID.xy + uvec2(1u, 0u);
	            uint _7595 = (_19313.y * 8u) + _19313.x;
	            uvec2 _11305 = gl_LocalInvocationID.xy + uvec2(0u, 1u);
	            uint _7596 = (_11305.y * 8u) + _11305.x;
	            uvec2 _11306 = gl_LocalInvocationID.xy + uvec2(1u);
	            uint _7597 = (_11306.y * 8u) + _11306.x;
	            uvec4 _9781 = texelFetch(g_LookupTables, int(_Globals_.g_nClassDataOffset + (((((((((floatBitsToUint(_3739[_5563][0u]) & 2147483648u) >> uint(31)) | ((floatBitsToUint(_3739[_7595][0u]) & 2147483648u) >> uint(30))) | ((floatBitsToUint(_3739[_7596][0u]) & 2147483648u) >> uint(29))) | ((floatBitsToUint(_3739[_7597][0u]) & 2147483648u) >> uint(28))) | ((floatBitsToUint(_3739[_5563][1u]) & 2147483648u) >> uint(27))) | ((floatBitsToUint(_3739[_7595][1u]) & 2147483648u) >> uint(26))) | ((floatBitsToUint(_3739[_7596][1u]) & 2147483648u) >> uint(25))) | ((floatBitsToUint(_3739[_7597][1u]) & 2147483648u) >> uint(24)))));
	            uint _16997 = _9781.x;
	            uint _24537 = (_16997 >> uint(4)) & 15u;
	            uint _23149 = (_16997 >> uint(8)) & 15u;
	            if (_24537 != 0u)
	            {
	                bool _16059 = all(greaterThan(gl_LocalInvocationID.xy, uvec2(0u)));
	                uint _23718 = _16059 ? ((_16997 >> uint(24)) & 15u) : _24537;
	                uint _13990 = atomicMax(_5501, max(_23718, _23149));
	                uint _23496 = imageAtomicAdd(g_IndirectDrawArgs, int(8u), _16059 ? ((_16997 >> uint(28)) & 15u) : ((_16997 >> uint(12)) & 15u));
	                uint _5156 = imageAtomicAdd(g_IndirectDrawArgs, int(0u), _23149 * 3u);
	                bool _12886;
	                if (_23496 < _Globals_.g_nVertexBufferSize)
	                {
	                    _12886 = _5156 < _Globals_.g_nIndexBufferSize;
	                }
	                else
	                {
	                    _12886 = false;
	                }
	                if (_12886)
	                {
	                    uint _3801 = atomicAdd(_5696, 1u);
	                    _3560[_3801]._m0 = ((_16997 & 16776975u) | (_23718 << uint(4))) | ((gl_LocalInvocationID.x << uint(24)) | (gl_LocalInvocationID.y << uint(28)));
	                    _3560[_3801]._m1 = _5156;
	                    _4676[(gl_LocalInvocationID.y * 7u) + gl_LocalInvocationID.x] = _23496;
	                }
	            }
	        }
	        barrier();
	        uint _18293 = _5501 - 1u;
	        uint _13205 = _18293 | (_18293 >> uint(1));
	        uint _25270 = _13205 | (_13205 >> uint(2));
	        uint _25271 = _25270 | (_25270 >> uint(4));
	        uint _25272 = _25271 | (_25271 >> uint(8));
	        uint _14175 = _25272 | (_25272 >> uint(16));
	        uint _7125 = uint(findLSB(_14175 + 1u));
	        uint _4097 = 64u >> _7125;
	        uint _3750;
	        uint _13040 = 0u;
	        for (;;)
	        {
	            if (!(_13040 < _5696))
	            {
	                break;
	            }
	            uint _4009 = _13040 + (_5563 >> _7125);
	            uint _3354 = _5563 & _14175;
	            if (_4009 >= _5696)
	            {
	                break;
	            }
	            uint _4688 = (_3560[_4009]._m0 >> uint(16)) & 255u;
	            uint _23151 = (_3560[_4009]._m0 >> uint(24)) & 15u;
	            uint _22527 = (_3560[_4009]._m0 >> uint(28)) & 15u;
	            uvec2 _5072 = uvec2(_23151, _22527);
	            if (_3354 < ((_3560[_4009]._m0 >> uint(4)) & 15u))
	            {
	                vec3 _4278 = _14716 + vec3(vec2(_5072) * _Globals_.g_vSystemStepSize.xy, 0.0);
	                uvec4 _9876 = texelFetch(g_LookupTables, int((_Globals_.g_nVertexDataOffset + (_4688 * 12u)) + _3354));
	                uint _16037 = _9876.x;
	                uint _4758 = _16037 & 15u;
	                uint _18698 = _16037 >> uint(4);
	                uint _4759 = _18698 & 15u;
	                uint _14643 = _16037 & 1u;
	                uvec2 _7087 = _5072 + uvec3(_14643, (_4758 >> uint(1)) & 1u, _4).xy;
	                uint _16065 = _18698 & 1u;
	                uvec2 _7088 = _5072 + uvec3(_16065, (_4759 >> uint(1)) & 1u, _4).xy;
	                uint _16749 = uint(int(_4759 >= 4u));
	                uint _7599 = (_7088.y * 8u) + _7088.x;
	                vec3 _19688;
	                if (_14643 != 0u)
	                {
	                    vec3 _6984 = _4278;
	                    _6984.x = _4278.x + _Globals_.g_vSystemStepSize.x;
	                    _19688 = _6984;
	                }
	                else
	                {
	                    _19688 = _4278;
	                }
	                vec3 _19689;
	                if ((_16037 & 2u) != 0u)
	                {
	                    vec3 _6985 = _19688;
	                    _6985.y = _19688.y + _Globals_.g_vSystemStepSize.y;
	                    _19689 = _6985;
	                }
	                else
	                {
	                    _19689 = _19688;
	                }
	                vec3 _6905;
	                if ((_16037 & 4u) != 0u)
	                {
	                    vec3 _6986 = _19689;
	                    _6986.z = _19689.z + _Globals_.g_vSystemStepSize.z;
	                    _6905 = _6986;
	                }
	                else
	                {
	                    _6905 = _19689;
	                }
	                vec3 _19690;
	                if (_16065 != 0u)
	                {
	                    vec3 _6987 = _4278;
	                    _6987.x = _4278.x + _Globals_.g_vSystemStepSize.x;
	                    _19690 = _6987;
	                }
	                else
	                {
	                    _19690 = _4278;
	                }
	                vec3 _19691;
	                if ((_18698 & 2u) != 0u)
	                {
	                    vec3 _6988 = _19690;
	                    _6988.y = _19690.y + _Globals_.g_vSystemStepSize.y;
	                    _19691 = _6988;
	                }
	                else
	                {
	                    _19691 = _19690;
	                }
	                vec3 _18229;
	                if ((_18698 & 4u) != 0u)
	                {
	                    vec3 _6989 = _19691;
	                    _6989.z = _19691.z + _Globals_.g_vSystemStepSize.z;
	                    _18229 = _6989;
	                }
	                else
	                {
	                    _18229 = _19691;
	                }
	                vec3 _12090 = mix(_18229, _6905, vec3(_3739[_7599][_16749] / (_3739[_7599][_16749] - _3739[(_7087.y * 8u) + _7087.x][uint(int(_4758 >= 4u))])));
	                _12090.z = _12090.z - _Globals_.g_vSystemStepSize.z;
	                vec3 _13157;
	                _13157 = vec3(0.0);
	                uint _18752;
	                vec3 _23944;
	                uint _16210 = _13039;
	                for (;;)
	                {
	                    if (!(_16210 < _9584))
	                    {
	                        break;
	                    }
	                    vec3 _12930 = _12090 - g_Particles_1._m0[_16210]._m0;
	                    float _18344 = dot(_12930, _12930);
	                    float _11484;
	                    if (_18344 <= _Globals_.g_vBlobulatorConstants.x)
	                    {
	                        float _19904 = _18344 * _Globals_.g_vBlobulatorConstants.y;
	                        _11484 = (0.25 + (_19904 * _19904)) - _19904;
	                    }
	                    else
	                    {
	                        _11484 = 0.0;
	                    }
	                    _23944 = _13157 + (_12930 * (_11484 * g_Particles_1._m0[_16210]._m1));
	                    _18752 = _16210 + 1u;
	                    _13157 = _23944;
	                    _16210 = _18752;
	                    continue;
	                }
	                vec3 _15061 = normalize(_13157);
	                vec3 _19000 = _15061 / vec3((abs(_15061.x) + abs(_15061.y)) + abs(_15061.z));
	                vec2 _19321;
	                if (_19000.z >= 0.0)
	                {
	                    _19321 = _19000.xy;
	                }
	                else
	                {
	                    _19321 = (vec2(1.0) - abs(_19000.yx)) * mix(vec2(-1.0), vec2(1.0), greaterThanEqual(_19000.xy, vec2(0.0)));
	                }
	                uint _13526 = (_4676[(_22527 * 7u) + _23151] + ((_16037 >> uint(12)) & 15u)) * 16u;
	                uvec3 _9171 = floatBitsToUint(_12090);
	                g_VertexBuffer_1._m0[_13526 / 4u] = _9171.x;
	                g_VertexBuffer_1._m0[(_13526 + 4u) / 4u] = _9171.y;
	                g_VertexBuffer_1._m0[(_13526 + 8u) / 4u] = _9171.z;
	                g_VertexBuffer_1._m0[(_13526 + 12u) / 4u] = (1u | (uint(round(((_19321.x * 0.5) + 0.5) * 1023.0)) << 12u)) | (uint(round(((_19321.y * 0.5) + 0.5) * 1023.0)) << 22u);
	            }
	            if (_3354 < ((_3560[_4009]._m0 >> uint(8)) & 15u))
	            {
	                uvec4 _3300 = texelFetch(g_LookupTables, int((_Globals_.g_nTriangleDataOffset + (_4688 * 5u)) + _3354));
	                uint _16038 = _3300.x;
	                uint _16517 = _16038 >> uint(24);
	                uint _5913 = _16517 & 3u;
	                uint _16518 = _16038 >> uint(26);
	                uint _5914 = _16518 & 3u;
	                uint _16088 = _16038 >> uint(28);
	                uint _5915 = _16088 & 3u;
	                uint _7601 = uint(int(_23151 > 0u) | ((_22527 > 0u) ? 2 : 0));
	                bool _12887;
	                if (_5913 != 0u)
	                {
	                    _12887 = (_7601 & _5913) == _5913;
	                }
	                else
	                {
	                    _12887 = false;
	                }
	                uvec2 _23168;
	                if (_12887)
	                {
	                    _23168 = uvec2(_23151 - (_16517 & 1u), _22527 - ((_5913 >> uint(1)) & 1u));
	                }
	                else
	                {
	                    _23168 = _5072;
	                }
	                bool _12888;
	                if (_5914 != 0u)
	                {
	                    _12888 = (_7601 & _5914) == _5914;
	                }
	                else
	                {
	                    _12888 = false;
	                }
	                uvec2 _23169;
	                if (_12888)
	                {
	                    _23169 = uvec2(_23151 - (_16518 & 1u), _22527 - ((_5914 >> uint(1)) & 1u));
	                }
	                else
	                {
	                    _23169 = _5072;
	                }
	                bool _12889;
	                if (_5915 != 0u)
	                {
	                    _12889 = (_7601 & _5915) == _5915;
	                }
	                else
	                {
	                    _12889 = false;
	                }
	                uvec2 _23170;
	                if (_12889)
	                {
	                    _23170 = uvec2(_23151 - (_16088 & 1u), _22527 - ((_5915 >> uint(1)) & 1u));
	                }
	                else
	                {
	                    _23170 = _5072;
	                }
	                uint _20110 = (_3560[_4009]._m1 + (_3354 * 3u)) * 4u;
	                g_IndexBuffer_1._m0[_20110 / 4u] = (_12887 ? ((_16038 >> uint(12)) & 15u) : (_16038 & 15u)) + _4676[(_23168.y * 7u) + _23168.x];
	                g_IndexBuffer_1._m0[(_20110 + 4u) / 4u] = (_12888 ? ((_16038 >> uint(16)) & 15u) : ((_16038 >> uint(4)) & 15u)) + _4676[(_23169.y * 7u) + _23169.x];
	                g_IndexBuffer_1._m0[(_20110 + 8u) / 4u] = (_12889 ? ((_16038 >> uint(20)) & 15u) : ((_16038 >> uint(8)) & 15u)) + _4676[(_23170.y * 7u) + _23170.x];
	            }
	            _3750 = _13040 + _4097;
	            _13040 = _3750;
	            continue;
	        }
	        barrier();
	        _3739[_5563][0] = _3739[_5563][1];
	        if (_8412)
	        {
	            _5696 = 0u;
	            _5501 = 0u;
	        }
	        _4300 = _17017 + 1u;
	        _13137 = _14716;
	        _16305 = _19764;
	        _17133 = _13039;
	        _17017 = _4300;
	        continue;
	    }
	}
	
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
}
