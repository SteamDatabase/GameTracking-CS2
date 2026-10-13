//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Update wind noise textures";
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
	
	RWTexture3D<float4> g_WindNoise < Attribute("WindNoiseOut"); >;
	[[layer_constant]] ExternalDescriptorSet g_globalLateBoundBindlessSet < Source(ExternalDescSet); Attribute("g_globalLateBoundBindlessSet"); >;
	
	// SPIR-V reflection failed for backend HLSL:
	// cbuffer ID 3246 (name: WindControllerConstantBuffer_t), member index 0 (name: _m0) cannot be expressed with either HLSL packing layout or packoffset.
	//
	// Re-attempting reflection with the GLSL backend.
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, GLSL reflection with SPIRV-Cross by KhronosGroup
	
	#version 460
	layout(local_size_x = 8, local_size_y = 8, local_size_z = 1) in;
	
	struct _981
	{
	    uint _m0;
	};
	
	struct _117
	{
	    _981 _m0;
	    vec2 _m1;
	    vec2 _m2;
	    float _m3;
	    float _m4;
	    float _m5;
	    float _m6;
	};
	
	layout(set = 0) uniform _117 WindControllerConstantBuffer_t;
	
	layout(set = 0, binding = 158) uniform writeonly image3D g_WindNoise;
	
	void main()
	{
	    uint _4300;
	    uint _13039 = 0u;
	    for (;;)
	    {
	        if (!(_13039 < WindControllerConstantBuffer_t._m0._m0))
	        {
	            break;
	        }
	        float _17644 = float(_13039);
	        vec2 _4678 = WindControllerConstantBuffer_t._m1 + ((vec2(gl_GlobalInvocationID.xy) * WindControllerConstantBuffer_t._m2) * exp2(WindControllerConstantBuffer_t._m4 * _17644));
	        float _3269 = (WindControllerConstantBuffer_t._m3 * exp2(WindControllerConstantBuffer_t._m5 * _17644)) + (WindControllerConstantBuffer_t._m6 * _17644);
	        vec3 _8570 = vec3(_4678, _3269);
	        vec3 _12135 = _8570 * mat3(vec3(0.0, 1.0, 1.0), vec3(1.0, 0.0, 1.0), vec3(1.0, 1.0, 0.0));
	        vec3 _16879 = floor(_12135);
	        vec3 _17217 = fract(_12135);
	        vec3 _23646 = step(_17217.xyx, _17217.yzz);
	        vec3 _24150 = vec3(1.0) - _23646;
	        vec3 _18658 = vec3(_24150.z, _23646.xy);
	        vec3 _15489 = vec3(_24150.xy, _23646.z);
	        vec3 _15873 = _16879 + min(_18658, _15489);
	        vec3 _10785 = _16879 + max(_18658, _15489);
	        vec3 _19492 = _16879 + vec3(1.0);
	        vec3 _11023 = _16879 * mat3(vec3(-0.5, 0.5, 0.5), vec3(0.5, -0.5, 0.5), vec3(0.5, 0.5, -0.5));
	        vec3 _6988 = _15873 * mat3(vec3(-0.5, 0.5, 0.5), vec3(0.5, -0.5, 0.5), vec3(0.5, 0.5, -0.5));
	        vec3 _9153 = _10785 * mat3(vec3(-0.5, 0.5, 0.5), vec3(0.5, -0.5, 0.5), vec3(0.5, 0.5, -0.5));
	        vec3 _11402 = _19492 * mat3(vec3(-0.5, 0.5, 0.5), vec3(0.5, -0.5, 0.5), vec3(0.5, 0.5, -0.5));
	        vec3 _22556 = _8570 - _11023;
	        vec3 _7022 = _8570 - _6988;
	        vec3 _6660 = _8570 - _9153;
	        vec3 _23519 = _8570 - _11402;
	        bool _9758 = any(bvec3(true));
	        vec3 _13136;
	        vec3 _13998;
	        vec3 _16305;
	        vec3 _23299;
	        if (_9758)
	        {
	            vec4 _11357 = vec4(_11023.x, _6988.x, _9153.x, _11402.x);
	            vec4 _11358 = vec4(_11023.y, _6988.y, _9153.y, _11402.y);
	            vec4 _21342 = vec4(_11023.z, _6988.z, _9153.z, _11402.z);
	            vec4 _6786 = _11357 - vec4(237.0) * trunc(_11357 / vec4(237.0));
	            vec4 _23632 = _11358 - vec4(193.0) * trunc(_11358 / vec4(193.0));
	            vec4 _17959 = _21342 - vec4(213.0) * trunc(_21342 / vec4(213.0));
	            _13136 = floor((vec3(_6786.w, _23632.w, _17959.w) * mat3(vec3(0.0, 1.0, 1.0), vec3(1.0, 0.0, 1.0), vec3(1.0, 1.0, 0.0))) + vec3(0.5));
	            _16305 = floor((vec3(_6786.z, _23632.z, _17959.z) * mat3(vec3(0.0, 1.0, 1.0), vec3(1.0, 0.0, 1.0), vec3(1.0, 1.0, 0.0))) + vec3(0.5));
	            _13998 = floor((vec3(_6786.y, _23632.y, _17959.y) * mat3(vec3(0.0, 1.0, 1.0), vec3(1.0, 0.0, 1.0), vec3(1.0, 1.0, 0.0))) + vec3(0.5));
	            _23299 = floor((vec3(_6786.x, _23632.x, _17959.x) * mat3(vec3(0.0, 1.0, 1.0), vec3(1.0, 0.0, 1.0), vec3(1.0, 1.0, 0.0))) + vec3(0.5));
	        }
	        else
	        {
	            _13136 = _19492;
	            _16305 = _10785;
	            _13998 = _15873;
	            _23299 = _16879;
	        }
	        vec4 _21380 = vec4(_23299.z, _13998.z, _16305.z, _13136.z);
	        vec4 _6231 = _21380 - vec4(289.0) * trunc(_21380 / vec4(289.0));
	        vec4 _12542 = ((_6231 * 34.0) + vec4(10.0)) * _6231;
	        vec4 _20663 = (_12542 - vec4(289.0) * trunc(_12542 / vec4(289.0))) + vec4(_23299.y, _13998.y, _16305.y, _13136.y);
	        vec4 _20780 = _20663 - vec4(289.0) * trunc(_20663 / vec4(289.0));
	        vec4 _12543 = ((_20780 * 34.0) + vec4(10.0)) * _20780;
	        vec4 _20664 = (_12543 - vec4(289.0) * trunc(_12543 / vec4(289.0))) + vec4(_23299.x, _13998.x, _16305.x, _13136.x);
	        vec4 _20781 = _20664 - vec4(289.0) * trunc(_20664 / vec4(289.0));
	        vec4 _13701 = ((_20781 * 34.0) + vec4(10.0)) * _20781;
	        vec4 _24036 = _13701 - vec4(289.0) * trunc(_13701 / vec4(289.0));
	        vec4 _15043 = _24036 * 3.883222103118896484375;
	        vec4 _13001 = _24036 * (-0.006920414976775646209716796875);
	        vec4 _21063 = _13001 + vec4(0.996539771556854248046875);
	        vec4 _18744 = _24036 * 0.10870562493801116943359375;
	        vec4 _13552 = sin(_15043);
	        vec4 _24568 = -cos(_15043);
	        vec4 _14672 = sin(_18744);
	        vec4 _20586 = cos(_18744);
	        vec4 _16959 = (_20586 * (_21063 * _24568)) + (_14672 * _13552);
	        vec4 _15971 = (_20586 * ((vec4(-0.996539771556854248046875) - _13001) * _13552)) + (_14672 * _24568);
	        vec4 _18719 = _20586 * sqrt(vec4(1.0) - (_21063 * _21063));
	        vec4 _12203 = max(vec4(0.5) - vec4(dot(_22556, _22556), dot(_7022, _7022), dot(_6660, _6660), dot(_23519, _23519)), vec4(0.0));
	        vec3 _8571 = vec3(_4678 + vec2(3.7000000476837158203125), _3269);
	        vec3 _12136 = _8571 * mat3(vec3(0.0, 1.0, 1.0), vec3(1.0, 0.0, 1.0), vec3(1.0, 1.0, 0.0));
	        vec3 _16880 = floor(_12136);
	        vec3 _17218 = fract(_12136);
	        vec3 _23647 = step(_17218.xyx, _17218.yzz);
	        vec3 _24151 = vec3(1.0) - _23647;
	        vec3 _18659 = vec3(_24151.z, _23647.xy);
	        vec3 _15490 = vec3(_24151.xy, _23647.z);
	        vec3 _15874 = _16880 + min(_18659, _15490);
	        vec3 _10786 = _16880 + max(_18659, _15490);
	        vec3 _19493 = _16880 + vec3(1.0);
	        vec3 _11024 = _16880 * mat3(vec3(-0.5, 0.5, 0.5), vec3(0.5, -0.5, 0.5), vec3(0.5, 0.5, -0.5));
	        vec3 _6989 = _15874 * mat3(vec3(-0.5, 0.5, 0.5), vec3(0.5, -0.5, 0.5), vec3(0.5, 0.5, -0.5));
	        vec3 _9154 = _10786 * mat3(vec3(-0.5, 0.5, 0.5), vec3(0.5, -0.5, 0.5), vec3(0.5, 0.5, -0.5));
	        vec3 _11403 = _19493 * mat3(vec3(-0.5, 0.5, 0.5), vec3(0.5, -0.5, 0.5), vec3(0.5, 0.5, -0.5));
	        vec3 _22557 = _8571 - _11024;
	        vec3 _7023 = _8571 - _6989;
	        vec3 _8427 = _8571 - _9154;
	        vec3 _7487 = _8571 - _11403;
	        vec3 _13137;
	        vec3 _13999;
	        vec3 _16306;
	        vec3 _23300;
	        if (_9758)
	        {
	            vec4 _11362 = vec4(_11024.x, _6989.x, _9154.x, _11403.x);
	            vec4 _11363 = vec4(_11024.y, _6989.y, _9154.y, _11403.y);
	            vec4 _21343 = vec4(_11024.z, _6989.z, _9154.z, _11403.z);
	            vec4 _6787 = _11362 - vec4(237.0) * trunc(_11362 / vec4(237.0));
	            vec4 _23633 = _11363 - vec4(193.0) * trunc(_11363 / vec4(193.0));
	            vec4 _17960 = _21343 - vec4(213.0) * trunc(_21343 / vec4(213.0));
	            _13137 = floor((vec3(_6787.w, _23633.w, _17960.w) * mat3(vec3(0.0, 1.0, 1.0), vec3(1.0, 0.0, 1.0), vec3(1.0, 1.0, 0.0))) + vec3(0.5));
	            _16306 = floor((vec3(_6787.z, _23633.z, _17960.z) * mat3(vec3(0.0, 1.0, 1.0), vec3(1.0, 0.0, 1.0), vec3(1.0, 1.0, 0.0))) + vec3(0.5));
	            _13999 = floor((vec3(_6787.y, _23633.y, _17960.y) * mat3(vec3(0.0, 1.0, 1.0), vec3(1.0, 0.0, 1.0), vec3(1.0, 1.0, 0.0))) + vec3(0.5));
	            _23300 = floor((vec3(_6787.x, _23633.x, _17960.x) * mat3(vec3(0.0, 1.0, 1.0), vec3(1.0, 0.0, 1.0), vec3(1.0, 1.0, 0.0))) + vec3(0.5));
	        }
	        else
	        {
	            _13137 = _19493;
	            _16306 = _10786;
	            _13999 = _15874;
	            _23300 = _16880;
	        }
	        vec4 _21381 = vec4(_23300.z, _13999.z, _16306.z, _13137.z);
	        vec4 _6232 = _21381 - vec4(289.0) * trunc(_21381 / vec4(289.0));
	        vec4 _12544 = ((_6232 * 34.0) + vec4(10.0)) * _6232;
	        vec4 _20665 = (_12544 - vec4(289.0) * trunc(_12544 / vec4(289.0))) + vec4(_23300.y, _13999.y, _16306.y, _13137.y);
	        vec4 _20782 = _20665 - vec4(289.0) * trunc(_20665 / vec4(289.0));
	        vec4 _12545 = ((_20782 * 34.0) + vec4(10.0)) * _20782;
	        vec4 _20666 = (_12545 - vec4(289.0) * trunc(_12545 / vec4(289.0))) + vec4(_23300.x, _13999.x, _16306.x, _13137.x);
	        vec4 _20783 = _20666 - vec4(289.0) * trunc(_20666 / vec4(289.0));
	        vec4 _13702 = ((_20783 * 34.0) + vec4(10.0)) * _20783;
	        vec4 _24037 = _13702 - vec4(289.0) * trunc(_13702 / vec4(289.0));
	        vec4 _15044 = _24037 * 3.883222103118896484375;
	        vec4 _13002 = _24037 * (-0.006920414976775646209716796875);
	        vec4 _21064 = _13002 + vec4(0.996539771556854248046875);
	        vec4 _18745 = _24037 * 0.10870562493801116943359375;
	        vec4 _13553 = sin(_15044);
	        vec4 _24569 = -cos(_15044);
	        vec4 _14673 = sin(_18745);
	        vec4 _20587 = cos(_18745);
	        vec4 _16960 = (_20587 * (_21064 * _24569)) + (_14673 * _13553);
	        vec4 _15972 = (_20587 * ((vec4(-0.996539771556854248046875) - _13002) * _13553)) + (_14673 * _24569);
	        vec4 _18720 = _20587 * sqrt(vec4(1.0) - (_21064 * _21064));
	        vec4 _12204 = max(vec4(0.5) - vec4(dot(_22557, _22557), dot(_7023, _7023), dot(_8427, _8427), dot(_7487, _7487)), vec4(0.0));
	        vec2 _12295 = vec2(39.5 * dot((_12203 * _12203) * _12203, vec4(dot(vec3(_16959.x, _15971.x, _18719.x), _22556), dot(vec3(_16959.y, _15971.y, _18719.y), _7022), dot(vec3(_16959.z, _15971.z, _18719.z), _6660), dot(vec3(_16959.w, _15971.w, _18719.w), _23519))), 39.5 * dot((_12204 * _12204) * _12204, vec4(dot(vec3(_16960.x, _15972.x, _18720.x), _22557), dot(vec3(_16960.y, _15972.y, _18720.y), _7023), dot(vec3(_16960.z, _15972.z, _18720.z), _8427), dot(vec3(_16960.w, _15972.w, _18720.w), _7487)))) * 0.5;
	        imageStore(g_WindNoise, ivec3(uvec3(gl_GlobalInvocationID.xy, _13039)), vec4(_12295 + vec2(0.5), 0.0, 0.0));
	        _4300 = _13039 + 1u;
	        _13039 = _4300;
	        continue;
	    }
	}
	
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
	
	BoolAttribute(BindlessResources, true);
	
}
