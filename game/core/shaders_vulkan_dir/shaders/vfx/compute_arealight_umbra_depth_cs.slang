//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Computed depth mask corresponding to the umbra of an arealight";
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
	DynamicCombo( D_MODE, 0..2 );
	
	Texture2D g_BlockerDepth < Attribute("BlockerDepth"); SrgbRead(false); >;
	Texture2D g_ErodeX < Attribute("ErodeX"); SrgbRead(false); >;
	RWTexture2D<float4> g_RWBlockerDepth < Attribute("OutBlockerDepth"); >;
	RWTexture2D<float4> g_RWDepthMap < Attribute("OutDepth"); >;
	RWTexture2D<float4> g_RWErodeX < Attribute("ErodeX"); >;
	StructuredBuffer g_ShadowViewFrusta < Attribute("ShadowViewFrusta"); >;
	Texture2DArray g_ShadowViewSamples < Attribute("ShadowViewSamples"); SrgbRead(false); >;
	Texture2D g_UmbraDepth < Attribute("UmbraDepth"); SrgbRead(false); >;
	float g_fErodeRadiusPerDepth < Attribute("ErodeRadiusPerDepth"); UiType(Slider); >;
	float g_fFarZ < Attribute("FarZ"); UiType(Slider); >;
	float g_fFloorZ < Attribute("FloorZ"); UiType(Slider); >;
	float g_fNearZ < Attribute("NearZ"); UiType(Slider); >;
	float g_fStepZ < Attribute("StepZ"); UiType(Slider); >;
	float4x4 g_mShadowWorldFromProj < Attribute("ShadowWorldFromProj"); >;
	int g_nDownsample < Attribute("DownsampleRatio"); UiType(Slider); >;
	int g_nErodeRadius < Attribute("ErodeRadius"); UiType(Slider); >;
	int g_nRefineSteps < Attribute("RefineSteps"); UiType(Slider); >;
	int g_nShadowViewCount < Attribute("NumShadowViewSamples"); UiType(Slider); >;
	int g_nUmbraDepthSize < Attribute("UmbraDepthSize"); UiType(Slider); >;
	float2 g_vInvShadowSize < Attribute("InvShadowSize"); UiType(VectorText); >;
	float4 g_vProjToDepth < Attribute("ProjToDepth"); UiType(VectorText); >;
	
	// SPIR-V reflection failed for backend HLSL:
	// cbuffer ID 5618 (name: _Globals_), member index 2 (name: g_mShadowWorldFromProj) cannot be expressed with either HLSL packing layout or packoffset.
	//
	// Re-attempting reflection with the GLSL backend.
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, GLSL reflection with SPIRV-Cross by KhronosGroup
	
	#version 460
	#extension GL_EXT_samplerless_texture_functions : require
	layout(local_size_x = 4, local_size_y = 4, local_size_z = 1) in;
	
	struct _1161
	{
	    mat4 _m0;
	};
	
	bool _3;
	vec4 _4;
	
	struct _1703
	{
	    uint g_nShadowViewCount;
	    vec2 g_vInvShadowSize;
	    mat4 g_mShadowWorldFromProj;
	    float g_fFarZ;
	    float g_fNearZ;
	    vec4 g_vProjToDepth;
	    float g_fStepZ;
	    float g_fFloorZ;
	    uint g_nRefineSteps;
	};
	
	layout(set = 0) uniform _1703 _Globals_;
	
	layout(set = 0, binding = 31, std430) readonly buffer g_ShadowViewFrusta
	{
	    layout(row_major) _1161 _m0[];
	} g_ShadowViewFrusta_1;
	
	layout(set = 0, binding = 30) uniform texture2DArray g_ShadowViewSamples;
	layout(set = 0, binding = 14) uniform sampler AddressU_Clamp_AddressV_Clamp_AddressW_Clamp_Filter_MinMagLinearMipPoint;
	layout(set = 0, binding = 158) uniform writeonly image2D g_RWDepthMap;
	layout(set = 0, binding = 159) uniform writeonly image2D g_RWBlockerDepth;
	
	void main()
	{
	    vec2 _13485 = (((vec2(gl_GlobalInvocationID.xy) + vec2(0.5)) * _Globals_.g_vInvShadowSize) * 2.0) - vec2(1.0);
	    _13485.y = _13485.y * (-1.0);
	    vec4 _15039 = vec4(_13485, 1.0, 1.0) * _Globals_.g_mShadowWorldFromProj;
	    vec4 _11356 = vec4(_13485, 0.0, 1.0) * _Globals_.g_mShadowWorldFromProj;
	    vec3 _5130 = _15039.xyz / vec3(_15039.w);
	    vec3 _5939 = ((_11356.xyz / vec3(_11356.w)) - _5130) / vec3(_Globals_.g_fFarZ - _Globals_.g_fNearZ);
	    vec3 _14076 = _5130 - (_5939 * _Globals_.g_fNearZ);
	    float _12111 = max(0.0, min(_Globals_.g_fFloorZ, texelFetch(g_ShadowViewSamples, ivec4(ivec2(gl_GlobalInvocationID.xy), 0, 0).xyz, 0).x - (_Globals_.g_fStepZ / float(1u << _Globals_.g_nRefineSteps))));
	    float _16305;
	    float _17133;
	    _16305 = 0.0;
	    _17133 = _12111;
	    float _4816;
	    float _16814;
	    bool _12885;
	    float _24118;
	    bool _13136;
	    float _17017 = _12111;
	    for (;;)
	    {
	        if (!(_17017 > 0.0))
	        {
	            break;
	        }
	        vec3 _21657 = _14076 + (_5939 * ((_Globals_.g_vProjToDepth.x + (_Globals_.g_vProjToDepth.y * _17017)) / (_Globals_.g_vProjToDepth.z + (_Globals_.g_vProjToDepth.w * _17017))));
	        float _13155;
	        do
	        {
	            _13155 = 0.0;
	            uint _9895;
	            float _24631;
	            bool _13174;
	            bool _16054;
	            uint _16208 = 1u;
	            for (;;)
	            {
	                if (!(_16208 < _Globals_.g_nShadowViewCount))
	                {
	                    _13174 = _13136;
	                    _16054 = false;
	                    break;
	                }
	                vec4 _18372 = vec4(_21657, 1.0) * g_ShadowViewFrusta_1._m0[_16208]._m0;
	                vec3 _10521 = _18372.xyz / vec3(_18372.w);
	                vec4 _22905;
	                _22905.x = _10521.x;
	                _22905.y = _10521.y;
	                vec2 _25024 = (_22905.xy * 0.5) + vec2(0.5);
	                _25024.y = 1.0 - _25024.y;
	                if (any(notEqual(_25024, saturate(_25024))))
	                {
	                    _13174 = true;
	                    _16054 = true;
	                    break;
	                }
	                vec4 _24163 = textureGather(sampler2DArray(g_ShadowViewSamples, AddressU_Clamp_AddressV_Clamp_AddressW_Clamp_Filter_MinMagLinearMipPoint), vec3(_25024, float(_16208)));
	                if (any(greaterThanEqual(vec4(_10521.z), _24163)))
	                {
	                    _13174 = true;
	                    _16054 = true;
	                    break;
	                }
	                _24631 = max(_13155, max(max(_24163.x, _24163.y), max(_24163.z, _24163.w)));
	                _9895 = _16208 + 1u;
	                _13155 = _24631;
	                _16208 = _9895;
	                continue;
	            }
	            if (_16054)
	            {
	                _12885 = _13174;
	                break;
	            }
	            _12885 = false;
	            break;
	        } while(false);
	        if (_12885)
	        {
	            _24118 = _16305;
	        }
	        else
	        {
	            _24118 = max(_16305, _13155);
	        }
	        _16814 = _12885 ? _17017 : _17133;
	        _4816 = _17017 - _Globals_.g_fStepZ;
	        _13136 = _12885;
	        _16305 = _24118;
	        _17133 = _16814;
	        _17017 = _4816;
	        continue;
	    }
	    float _17134;
	    _17134 = max(0.0, _17133 - _Globals_.g_fStepZ);
	    uint _4878;
	    float _6881;
	    float _7941;
	    bool _24840;
	    bool _13137;
	    float _16306 = _17133;
	    uint _17018 = 0u;
	    for (;;)
	    {
	        if (!(_17018 < _Globals_.g_nRefineSteps))
	        {
	            break;
	        }
	        float _3498 = (_16306 + _17134) * 0.5;
	        vec3 _21658 = _14076 + (_5939 * ((_Globals_.g_vProjToDepth.x + (_Globals_.g_vProjToDepth.y * _3498)) / (_Globals_.g_vProjToDepth.z + (_Globals_.g_vProjToDepth.w * _3498))));
	        do
	        {
	            uint _23989;
	            bool _13175;
	            bool _16055;
	            uint _13039 = 1u;
	            for (;;)
	            {
	                if (!(_13039 < _Globals_.g_nShadowViewCount))
	                {
	                    _13175 = _13137;
	                    _16055 = false;
	                    break;
	                }
	                vec4 _18373 = vec4(_21658, 1.0) * g_ShadowViewFrusta_1._m0[_13039]._m0;
	                vec3 _10522 = _18373.xyz / vec3(_18373.w);
	                vec4 _22906;
	                _22906.x = _10522.x;
	                _22906.y = _10522.y;
	                vec2 _25025 = (_22906.xy * 0.5) + vec2(0.5);
	                _25025.y = 1.0 - _25025.y;
	                if (any(notEqual(_25025, saturate(_25025))))
	                {
	                    _13175 = true;
	                    _16055 = true;
	                    break;
	                }
	                if (any(greaterThanEqual(vec4(_10522.z), textureGather(sampler2DArray(g_ShadowViewSamples, AddressU_Clamp_AddressV_Clamp_AddressW_Clamp_Filter_MinMagLinearMipPoint), vec3(_25025, float(_13039))))))
	                {
	                    _13175 = true;
	                    _16055 = true;
	                    break;
	                }
	                _23989 = _13039 + 1u;
	                _13039 = _23989;
	                continue;
	            }
	            if (_16055)
	            {
	                _24840 = _13175;
	                break;
	            }
	            _24840 = false;
	            break;
	        } while(false);
	        _7941 = _24840 ? _3498 : _16306;
	        _6881 = _24840 ? _17134 : _3498;
	        _4878 = _17018 + 1u;
	        _13137 = _24840;
	        _16306 = _7941;
	        _17134 = _6881;
	        _17018 = _4878;
	        continue;
	    }
	    imageStore(g_RWDepthMap, ivec2(gl_GlobalInvocationID.xy), vec4(_17134));
	    imageStore(g_RWBlockerDepth, ivec2(gl_GlobalInvocationID.xy), vec4(_16305));
	}
	
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
}
