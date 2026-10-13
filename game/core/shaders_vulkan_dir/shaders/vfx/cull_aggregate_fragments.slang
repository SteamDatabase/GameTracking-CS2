//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Culls aggregate fragments and generates indirect draw args";
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
	StaticCombo( S_REVERSE_DEPTH_BUFFER, 0..1 );
	StaticCombo( S_SUPPORTS_DX_11_1, 0, Sys( 13 ) );
	DynamicCombo( D_PASS, 0..2 );
	DynamicCombo( D_OCCLUSION_CULLING, 0..1 );
	DynamicCombo( D_VOLUME_CULLER, 0..1 );
	DynamicCombo( D_CUBEMAP_FOG_CULLING, 0..1 );
	DynamicCombo( D_SUPPORTS_MESH_SHADER, 0..1 );
	DynamicCombo( D_NEEDS_OVERFLOW_HANDLING, 0..1 );
	DynamicCombo( D_DEBUG_OUTPUT_STATS, 0..1 );
	DynamicCombo( D_DEBUG_DRAW_MESHLETS, 0..1 );
	DynamicComboRule( Requires( D_SUPPORTS_MESH_SHADER, S_SUBGROUP_WAVE_OPS ) );
	DynamicComboRule( Requires( D_NEEDS_OVERFLOW_HANDLING, D_SUPPORTS_MESH_SHADER ) );
	
	RWStructuredBuffer g_CullStats < Attribute("FragmentStats"); >;
	RWBuffer<float4> g_DebugMeshletDrawArgs < Attribute("DebugMeshletDrawArgs"); >;
	RWBuffer<float4> g_DrawArgs < Attribute("FragmentDrawArgs"); >;
	StructuredBuffer g_FragmentCullRequests < Attribute("FragmentCullRequests"); >;
	StructuredBuffer g_FragmentData < Attribute("FragmentBounds"); >;
	RWStructuredBuffer g_GroupDecreasingCounter < Attribute("GroupDecreasingCounter"); >;
	ByteAddressBuffer g_InputIndices < Attribute("InputIndices"); >;
	RWStructuredBuffer g_MSIndirectDispatchArgs < Attribute("MSIndirectDispatchArgs"); >;
	RWStructuredBuffer g_MSIndirectDispatchArgsRecull < Attribute("MSIndirectDispatchArgsRecull"); >;
	ByteAddressBuffer g_MeshletData < Attribute("MeshletData"); >;
	RWByteAddressBuffer g_OutputIndices < Attribute("OutputIndices"); >;
	RWStructuredBuffer g_RWMeshletBuffer < Source(ExternalDescSet); >;
	RWStructuredBuffer g_RecullDispatchArgs < Attribute("RecullDispatchArgs"); >;
	RWBuffer<float4> g_RecullDrawArgs < Attribute("FragmentRecullDrawArgs"); >;
	StructuredBuffer g_RecullRequests < Attribute("RecullRequests"); >;
	RWStructuredBuffer g_RecullRequests < Attribute("RecullRequests"); >;
	bool g_bBackfaceCulling < Attribute("BackfaceCulling"); UiType(CheckBox); >;
	int g_bCubemapFogHeightBlendModeAdd < Attribute("GpuCubemapFogHeightBlendModeAdd"); UiType(Slider); >;
	int g_bCubemapFogHeightCoordinateWS < Attribute("GpuCubemapFogHeightCoordinateWs"); UiType(Slider); >;
	bool g_bDrawAllMeshlets < Attribute("DebugDrawAllMeshlets"); UiType(CheckBox); >;
	bool g_bOrthographicView < Attribute("OrthographicView"); UiType(CheckBox); >;
	float g_fCubemapFogFullDistSqr < Attribute("GpuCubemapFogFullDistSqr"); UiType(Slider); >;
	float g_fCubemapFogFullHeightZDirTimesZ < Attribute("GpuCubemapFogFullHeightZDirTimesZ"); UiType(Slider); >;
	[[layer_constant]] ExternalDescriptorSet g_globalLateBoundBindlessSet < Source(ExternalDescSet); Attribute("g_globalLateBoundBindlessSet"); >;
	float4x4 g_mDepthPyramidProjFromWorld < Attribute("DepthPyramidProjFromWorld"); >;
	int g_nDepthPyramidHeight < Attribute("DepthPyramidHeight"); UiType(Slider); >;
	int g_nDepthPyramidMaxMip < Attribute("DepthPyramidMaxMip"); UiType(Slider); >;
	int g_nDepthPyramidWidth < Attribute("DepthPyramidWidth"); UiType(Slider); >;
	int g_nFragmentCullRequests < Attribute("NumFragmentRequests"); UiType(Slider); >;
	int g_nMaxDispatchIndex < Attribute("MaxDispatchIndex"); UiType(Slider); >;
	int g_nMeshletCullRequests < Attribute("NumMeshletCullRequests"); UiType(Slider); >;
	Texture2D g_tDepthPyramid < Attribute("DepthPyramid"); SrgbRead(false); >;
	float3 g_vCullCameraForwardWs < Attribute("CullCameraForwardWs"); UiType(VectorText); >;
	float3 g_vCullCameraPositionWs < Attribute("CullCameraPositionWs"); UiType(VectorText); >;
	float3 g_vDepthPyramidCameraOffset < Attribute("DepthPyramidCameraOffset"); UiType(VectorText); >;
	float2 g_vDepthPyramidSize < Attribute("DepthPyramidSize"); UiType(VectorText); >;
	float4 g_vFrustumPlane0 < Attribute("FrustumPlane0"); UiType(VectorText); >;
	float4 g_vFrustumPlane1 < Attribute("FrustumPlane1"); UiType(VectorText); >;
	float4 g_vFrustumPlane2 < Attribute("FrustumPlane2"); UiType(VectorText); >;
	float4 g_vFrustumPlane3 < Attribute("FrustumPlane3"); UiType(VectorText); >;
	float4 g_vFrustumPlane4 < Attribute("FrustumPlane4"); UiType(VectorText); >;
	float4 g_vFrustumPlane5 < Attribute("FrustumPlane5"); UiType(VectorText); >;
	
	#if (S_SUPPORTS_DX_11_1 == 0)
		StructuredBuffer g_RecullRequests < Attribute("RecullRequests"); >;
		RWStructuredBuffer g_RecullRequests < Attribute("RecullRequests"); >;
	#endif
	
	// SPIR-V reflection failed for backend HLSL:
	// cbuffer ID 5618 (name: _Globals_), member index 1 (name: g_vCullCameraPositionWs) cannot be expressed with either HLSL packing layout or packoffset.
	//
	// Re-attempting reflection with the GLSL backend.
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, GLSL reflection with SPIRV-Cross by KhronosGroup
	
	#version 460
	#if defined(GL_EXT_control_flow_attributes)
	#extension GL_EXT_control_flow_attributes : require
	#define SPIRV_CROSS_FLATTEN [[flatten]]
	#define SPIRV_CROSS_BRANCH [[dont_flatten]]
	#define SPIRV_CROSS_UNROLL [[unroll]]
	#define SPIRV_CROSS_LOOP [[dont_unroll]]
	#else
	#define SPIRV_CROSS_FLATTEN
	#define SPIRV_CROSS_BRANCH
	#define SPIRV_CROSS_UNROLL
	#define SPIRV_CROSS_LOOP
	#endif
	layout(local_size_x = 32, local_size_y = 1, local_size_z = 1) in;
	
	struct _1107
	{
	    uint _m0;
	    uint _m1;
	    uint _m2;
	    uint _m3;
	    uint _m4;
	    uint _m5;
	    uint _m6;
	    uint _m7;
	};
	
	struct _1098
	{
	    vec3 _m0;
	    int _m1;
	    vec3 _m2;
	    uint _m3;
	};
	
	struct _2037
	{
	    vec3 g_vCullCameraForwardWs;
	    vec3 g_vCullCameraPositionWs;
	    vec4 g_vFrustumPlane0;
	    vec4 g_vFrustumPlane1;
	    vec4 g_vFrustumPlane2;
	    vec4 g_vFrustumPlane3;
	    vec4 g_vFrustumPlane4;
	    vec4 g_vFrustumPlane5;
	    uint g_nFragmentCullRequests;
	    uint g_nMeshletCullRequests;
	    int g_bBackfaceCulling;
	    int g_bOrthographicView;
	};
	
	layout(set = 0) uniform _2037 _Globals_;
	
	layout(set = 0, binding = 33, std430) readonly buffer g_FragmentCullRequests
	{
	    _1107 _m0[];
	} g_FragmentCullRequests_1;
	
	layout(set = 0, binding = 32, std430) readonly buffer g_MeshletData
	{
	    uint _m0[];
	} g_MeshletData_1;
	
	layout(set = 0, binding = 31, std430) readonly buffer g_FragmentData
	{
	    _1098 _m0[];
	} g_FragmentData_1;
	
	layout(set = 0, binding = 34, std430) readonly buffer g_InputIndices
	{
	    uint _m0[];
	} g_InputIndices_1;
	
	layout(set = 0, binding = 166, std430) buffer g_OutputIndices
	{
	    uint _m0[];
	} g_OutputIndices_1;
	
	layout(set = 0, binding = 161, r32ui) uniform uimageBuffer g_DrawArgs;
	
	void main()
	{
	    if (gl_GlobalInvocationID.x < _Globals_.g_nMeshletCullRequests)
	    {
	        uint _16208;
	        _16208 = 0u;
	        uint _16133;
	        uint _18463;
	        uint _13155 = _Globals_.g_nFragmentCullRequests;
	        for (;;)
	        {
	            if (!((_16208 + 1u) < _13155))
	            {
	                break;
	            }
	            uint _3189 = (_16208 + _13155) >> uint(1);
	            bool _7620 = g_FragmentCullRequests_1._m0[_3189]._m3 <= gl_GlobalInvocationID.x;
	            _16133 = _7620 ? _13155 : _3189;
	            _18463 = _7620 ? _3189 : _16208;
	            _13155 = _16133;
	            _16208 = _18463;
	            continue;
	        }
	        uint _8524 = g_FragmentCullRequests_1._m0[_16208]._m0;
	        uint _24369 = g_FragmentCullRequests_1._m0[_16208]._m2;
	        uint _24370 = g_FragmentCullRequests_1._m0[_16208]._m3;
	        uint _24371 = g_FragmentCullRequests_1._m0[_16208]._m4;
	        uint _24372 = g_FragmentCullRequests_1._m0[_16208]._m5;
	        uint _24373 = g_FragmentCullRequests_1._m0[_16208]._m6;
	        uint _15195 = g_FragmentCullRequests_1._m0[_16208]._m7;
	        uint _5517 = gl_GlobalInvocationID.x - _24370;
	        if (_5517 == 0u)
	        {
	            uint _8597 = _24369 * 5u;
	            imageStore(g_DrawArgs, int(_8597 + 1u), uvec4(1u));
	            imageStore(g_DrawArgs, int(_8597 + 2u), uvec4(_24371));
	            imageStore(g_DrawArgs, int(_8597 + 3u), uvec4(_24372));
	            imageStore(g_DrawArgs, int(_8597 + 4u), uvec4(_24373));
	        }
	        uint _17109 = (_8524 + _5517) * 32u;
	        uint _6233 = g_MeshletData_1._m0[_17109 / 4u];
	        uint _6234 = g_MeshletData_1._m0[(_17109 + 4u) / 4u];
	        uint _6752 = (_17109 + 12u) / 4u;
	        uint _6753 = (_17109 + 16u) / 4u;
	        uint _6754 = (_17109 + 20u) / 4u;
	        uint _18023 = _6233 >> uint(7);
	        uint _5882 = (_18023 & 127u) + (_18023 & 1u);
	        int _24374 = g_FragmentData_1._m0[_15195]._m1;
	        vec3 _11811 = mix(g_FragmentData_1._m0[_15195]._m0.xyz, g_FragmentData_1._m0[_15195]._m2.xyz, vec3(float(g_MeshletData_1._m0[_6753] & 1023u) * 0.000977517105638980865478515625, float((g_MeshletData_1._m0[_6753] >> uint(10)) & 1023u) * 0.000977517105638980865478515625, float((g_MeshletData_1._m0[_6753] >> uint(20)) & 1023u) * 0.000977517105638980865478515625));
	        vec3 _12834 = mix(g_FragmentData_1._m0[_15195]._m0.xyz, g_FragmentData_1._m0[_15195]._m2.xyz, vec3(float(g_MeshletData_1._m0[_6754] & 1023u) * 0.000977517105638980865478515625, float((g_MeshletData_1._m0[_6754] >> uint(10)) & 1023u) * 0.000977517105638980865478515625, float((g_MeshletData_1._m0[_6754] >> uint(20)) & 1023u) * 0.000977517105638980865478515625));
	        vec4 _20578[6] = vec4[](_Globals_.g_vFrustumPlane0, _Globals_.g_vFrustumPlane1, _Globals_.g_vFrustumPlane2, _Globals_.g_vFrustumPlane3, _Globals_.g_vFrustumPlane4, _Globals_.g_vFrustumPlane5);
	        float _13156;
	        _13156 = 100000000.0;
	        float _6414;
	        int _8899;
	        int _16209 = 0;
	        for (;;)
	        {
	            if (!(_16209 < 6))
	            {
	                break;
	            }
	            _6414 = min(_13156, dot(mix(_11811, _12834, greaterThan(_20578[_16209].xyz, vec3(0.0))), _20578[_16209].xyz) + _20578[_16209].w);
	            _8899 = _16209 + 1;
	            _13156 = _6414;
	            _16209 = _8899;
	            continue;
	        }
	        bool _10462 = !(_13156 < 0.0);
	        bool _12885;
	        if (_Globals_.g_bBackfaceCulling != 0)
	        {
	            bool _24742;
	            do
	            {
	                vec3 _10254 = vec3(float(int((g_MeshletData_1._m0[_6752] & 255u) << uint(24)) >> 24) * 0.0078740157186985015869140625, float(int(((g_MeshletData_1._m0[_6752] >> uint(8)) & 255u) << uint(24)) >> 24) * 0.0078740157186985015869140625, float(int(((g_MeshletData_1._m0[_6752] >> uint(16)) & 255u) << uint(24)) >> 24) * 0.0078740157186985015869140625);
	                float _15712 = float(int(((g_MeshletData_1._m0[_6752] >> uint(24)) & 255u) << uint(24)) >> 24) * 0.0078740157186985015869140625;
	                if (_Globals_.g_bOrthographicView != 0)
	                {
	                    _24742 = dot(_Globals_.g_vCullCameraForwardWs.xyz, _10254) > _15712;
	                    break;
	                }
	                else
	                {
	                    vec3 _16593 = ((_11811 + _12834) * 0.5) - _Globals_.g_vCullCameraPositionWs.xyz;
	                    _24742 = dot(_16593, _10254) > ((_15712 * length(_16593)) + (length(_12834 - _11811) * 0.5));
	                    break;
	                }
	                break; // unreachable workaround
	            } while(false);
	            _12885 = _24742 ? false : _10462;
	        }
	        else
	        {
	            _12885 = _10462;
	        }
	        if (_12885)
	        {
	            uint _18763 = imageAtomicAdd(g_DrawArgs, int(_24369 * 5u), _5882 * 3u);
	            uint _14025 = _5882 * 6u;
	            uint _16134 = _14025 / 128u;
	            uint _10045 = (_14025 % 128u) / 16u;
	            uint _11906 = (_14025 % 16u) / 4u;
	            uint _13136;
	            uint _16324;
	            _13136 = (_18763 + _24371) * 2u;
	            _16324 = ((_6234 * 3u) + uint(_24374)) * 2u;
	            uint _14167;
	            uint _16273;
	            uint _21149;
	            uint _17017 = 0u;
	            SPIRV_CROSS_LOOP
	            for (;;)
	            {
	                if (!(_17017 < _16134))
	                {
	                    break;
	                }
	                uint _23262;
	                uint _13039 = 0u;
	                SPIRV_CROSS_UNROLL
	                for (;;)
	                {
	                    if (!(_13039 < 8u))
	                    {
	                        break;
	                    }
	                    uint _9984 = _13039 * 16u;
	                    uint _23357 = _16324 + _9984;
	                    uint _6238 = g_InputIndices_1._m0[(_23357 + 4u) / 4u];
	                    uint _6239 = g_InputIndices_1._m0[(_23357 + 8u) / 4u];
	                    uint _6240 = g_InputIndices_1._m0[(_23357 + 12u) / 4u];
	                    uint _20865 = _13136 + _9984;
	                    g_OutputIndices_1._m0[_20865 / 4u] = g_InputIndices_1._m0[_23357 / 4u];
	                    g_OutputIndices_1._m0[(_20865 + 4u) / 4u] = _6238;
	                    g_OutputIndices_1._m0[(_20865 + 8u) / 4u] = _6239;
	                    g_OutputIndices_1._m0[(_20865 + 12u) / 4u] = _6240;
	                    _23262 = _13039 + 1u;
	                    _13039 = _23262;
	                    continue;
	                }
	                _21149 = _16324 + 128u;
	                _16273 = _13136 + 128u;
	                _14167 = _17017 + 1u;
	                _13136 = _16273;
	                _16324 = _21149;
	                _17017 = _14167;
	                continue;
	            }
	            uint _13137;
	            uint _16325;
	            _13137 = _16324;
	            _16325 = _13136;
	            uint _8018;
	            uint _14168;
	            uint _22844;
	            uint _17018 = 0u;
	            SPIRV_CROSS_LOOP
	            for (;;)
	            {
	                if (!(_17018 < _10045))
	                {
	                    break;
	                }
	                uint _6242 = g_InputIndices_1._m0[(_13137 + 4u) / 4u];
	                uint _6243 = g_InputIndices_1._m0[(_13137 + 8u) / 4u];
	                uint _22955 = g_InputIndices_1._m0[(_13137 + 12u) / 4u];
	                g_OutputIndices_1._m0[_16325 / 4u] = g_InputIndices_1._m0[_13137 / 4u];
	                g_OutputIndices_1._m0[(_16325 + 4u) / 4u] = _6242;
	                g_OutputIndices_1._m0[(_16325 + 8u) / 4u] = _6243;
	                g_OutputIndices_1._m0[(_16325 + 12u) / 4u] = _22955;
	                _22844 = _13137 + 16u;
	                _8018 = _16325 + 16u;
	                _14168 = _17018 + 1u;
	                _13137 = _22844;
	                _16325 = _8018;
	                _17018 = _14168;
	                continue;
	            }
	            uint _8019;
	            uint _14169;
	            uint _22845;
	            uint _13138 = _16325;
	            uint _16326 = _13137;
	            uint _17019 = 0u;
	            SPIRV_CROSS_LOOP
	            for (;;)
	            {
	                if (!(_17019 < _11906))
	                {
	                    break;
	                }
	                g_OutputIndices_1._m0[_13138 / 4u] = g_InputIndices_1._m0[_16326 / 4u];
	                _22845 = _16326 + 4u;
	                _8019 = _13138 + 4u;
	                _14169 = _17019 + 1u;
	                _13138 = _8019;
	                _16326 = _22845;
	                _17019 = _14169;
	                continue;
	            }
	        }
	    }
	}
	
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
	
	BoolAttribute(BindlessResources, true);
	
}
