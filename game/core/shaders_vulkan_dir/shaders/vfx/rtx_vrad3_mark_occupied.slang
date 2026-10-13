//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Marks occupied voxels to prepare for inside/outside testing";
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
	DynamicCombo( D_MODE, 0..1 );
	
	StructuredBuffer g_Grids < Attribute("Grids"); >;
	StructuredBuffer g_InstanceTriangleOffsets < Attribute("InstanceTriangleOffsets"); >;
	StructuredBuffer g_MeshIndices < Attribute("MeshIndices"); >;
	StructuredBuffer g_MeshInstances < Attribute("MeshInstances"); >;
	StructuredBuffer g_MeshPositions < Attribute("MeshPositions"); >;
	RWStructuredBuffer g_OccupiedMask < Attribute("OccupiedMask"); >;
	StructuredBuffer g_OccupiedMaskIn < Attribute("OccupiedMaskIn"); >;
	RWStructuredBuffer g_OccupiedMaskOut < Attribute("OccupiedMask"); >;
	int g_nMeshInstances < Attribute("MeshInstanceCount"); UiType(Slider); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	struct _1626
	{
	    column_major float4x3 _m0;
	    column_major float4x3 _m1;
	    float4 _m2;
	    float4 _m3;
	    uint3 _m4;
	};
	
	struct _1017
	{
	    uint _m0;
	    uint _m1;
	    uint _m2;
	    uint _m3;
	};
	
	struct _216
	{
	    _1017 _m0;
	    column_major float4x3 _m1;
	};
	
	ByteAddressBuffer g_Grids : register(t30, space0);
	cbuffer _Globals_ : register(b0, space0)
	{
	    uint _Globals_1_g_nMeshInstances : packoffset(c0);
	};
	
	ByteAddressBuffer g_InstanceTriangleOffsets : register(t34, space0);
	ByteAddressBuffer g_MeshInstances : register(t33, space0);
	ByteAddressBuffer g_MeshIndices : register(t32, space0);
	ByteAddressBuffer g_MeshPositions : register(t31, space0);
	RWByteAddressBuffer g_OccupiedMask : register(u158, space0);
	
	static uint3 gl_GlobalInvocationID;
	struct SPIRV_Cross_Input
	{
	    uint3 gl_GlobalInvocationID : SV_DispatchThreadID;
	};
	
	void MainCs_inner()
	{
	    do
	    {
	        uint _4129 = gl_GlobalInvocationID.x + (gl_GlobalInvocationID.y * 512u);
	        if (_4129 >= g_InstanceTriangleOffsets.Load<uint>(_Globals_1_g_nMeshInstances * 4 + 0))
	        {
	            break;
	        }
	        uint _16208;
	        _16208 = 0u;
	        uint _16133;
	        uint _18463;
	        uint _13155 = _Globals_1_g_nMeshInstances;
	        for (;;)
	        {
	            if (!((_16208 + 1u) < _13155))
	            {
	                break;
	            }
	            uint _10393 = (_16208 + _13155) >> uint(1);
	            bool _7620 = g_InstanceTriangleOffsets.Load<uint>(_10393 * 4 + 0) <= _4129;
	            _16133 = _7620 ? _13155 : _10393;
	            _18463 = _7620 ? _10393 : _16208;
	            _13155 = _16133;
	            _16208 = _18463;
	            continue;
	        }
	        float4x3 _24370 = float4x3(g_MeshInstances.Load<float>(_16208 * 64 + 16), g_MeshInstances.Load<float>(_16208 * 64 + 32), g_MeshInstances.Load<float>(_16208 * 64 + 48), g_MeshInstances.Load<float>(_16208 * 64 + 20), g_MeshInstances.Load<float>(_16208 * 64 + 36), g_MeshInstances.Load<float>(_16208 * 64 + 52), g_MeshInstances.Load<float>(_16208 * 64 + 24), g_MeshInstances.Load<float>(_16208 * 64 + 40), g_MeshInstances.Load<float>(_16208 * 64 + 56), g_MeshInstances.Load<float>(_16208 * 64 + 28), g_MeshInstances.Load<float>(_16208 * 64 + 44), g_MeshInstances.Load<float>(_16208 * 64 + 60));
	        uint _17535 = g_MeshInstances.Load<uint>(_16208 * 64 + 8) + ((_4129 - g_InstanceTriangleOffsets.Load<uint>(_16208 * 4 + 0)) * 3u);
	        float3 _11222 = mul(float4(g_MeshPositions.Load<float3>((g_MeshInstances.Load<uint>(_16208 * 64 + 0) + g_MeshIndices.Load<uint>(_17535 * 4 + 0)) * 12 + 0), 1.0f), _24370);
	        float3 _20855 = mul(float4(g_MeshPositions.Load<float3>((g_MeshInstances.Load<uint>(_16208 * 64 + 0) + g_MeshIndices.Load<uint>((_17535 + 1u) * 4 + 0)) * 12 + 0), 1.0f), _24370);
	        float3 _25208 = mul(float4(g_MeshPositions.Load<float3>((g_MeshInstances.Load<uint>(_16208 * 64 + 0) + g_MeshIndices.Load<uint>((_17535 + 2u) * 4 + 0)) * 12 + 0), 1.0f), _24370);
	        float3 _9415 = min(_11222, min(_20855, _25208));
	        float3 _8559 = max(_11222, max(_20855, _25208));
	        bool _12885;
	        if (any(bool3(_9415.x > g_Grids.Load<float4>(112).xyz.x, _9415.y > g_Grids.Load<float4>(112).xyz.y, _9415.z > g_Grids.Load<float4>(112).xyz.z)))
	        {
	            _12885 = true;
	        }
	        else
	        {
	            _12885 = any(bool3(_8559.x < g_Grids.Load<float4>(96).xyz.x, _8559.y < g_Grids.Load<float4>(96).xyz.y, _8559.z < g_Grids.Load<float4>(96).xyz.z));
	        }
	        if (_12885)
	        {
	            break;
	        }
	        float4x3 _16528 = float4x3(g_Grids.Load<float>(0), g_Grids.Load<float>(16), g_Grids.Load<float>(32), g_Grids.Load<float>(4), g_Grids.Load<float>(20), g_Grids.Load<float>(36), g_Grids.Load<float>(8), g_Grids.Load<float>(24), g_Grids.Load<float>(40), g_Grids.Load<float>(12), g_Grids.Load<float>(28), g_Grids.Load<float>(44));
	        float3 _6865 = mul(float4(_11222, 1.0f), _16528);
	        float3 _20856 = mul(float4(_20855, 1.0f), _16528);
	        float3 _9240 = mul(float4(_25208, 1.0f), _16528);
	        int3 _4744 = int3(g_Grids.Load<uint3>(128)) - int3(1, 1, 1);
	        int3 _14766 = clamp(int3(floor(min(_6865, min(_20856, _9240)))), int3(0, 0, 0), _4744);
	        int3 _12824 = clamp(int3(floor(max(_6865, max(_20856, _9240)))), int3(0, 0, 0), _4744);
	        float3 _3765 = _20856 - _6865;
	        float3 _3766 = _9240 - _20856;
	        float3 _13196 = _6865 - _9240;
	        float3 _16702 = cross(_3765, _3766);
	        int _18807 = _14766.z;
	        int _21567;
	        int _13039 = _18807;
	        for (;;)
	        {
	            if (!(_13039 <= _12824.z))
	            {
	                break;
	            }
	            int _8569 = _14766.y;
	            int _21568;
	            int _13040 = _8569;
	            for (;;)
	            {
	                if (!(_13040 <= _12824.y))
	                {
	                    break;
	                }
	                int _8570 = _14766.x;
	                int _23989;
	                int _13041 = _8570;
	                for (;;)
	                {
	                    if (!(_13041 <= _12824.x))
	                    {
	                        break;
	                    }
	                    float3 _4277 = float3(float(_13041), float(_13040), float(_13039)) + 0.5f.xxx;
	                    float3 _3749 = _6865 - _4277;
	                    float3 _3750 = _20856 - _4277;
	                    float3 _3751 = _9240 - _4277;
	                    bool _12899;
	                    do
	                    {
	                        float _17002 = _3749.x;
	                        float _10931 = _3750.x;
	                        float _22360 = _3751.x;
	                        float _7818 = dot(0.50010001659393310546875f.xxx, abs(float3(1.0f, 0.0f, 0.0f)));
	                        bool _12886;
	                        if (min(_17002, min(_10931, _22360)) > _7818)
	                        {
	                            _12886 = true;
	                        }
	                        else
	                        {
	                            _12886 = max(_17002, max(_10931, _22360)) < (-_7818);
	                        }
	                        if (_12886)
	                        {
	                            _12899 = false;
	                            break;
	                        }
	                        float _15389 = _3749.y;
	                        float _10932 = _3750.y;
	                        float _22361 = _3751.y;
	                        float _7819 = dot(0.50010001659393310546875f.xxx, abs(float3(0.0f, 1.0f, 0.0f)));
	                        bool _12887;
	                        if (min(_15389, min(_10932, _22361)) > _7819)
	                        {
	                            _12887 = true;
	                        }
	                        else
	                        {
	                            _12887 = max(_15389, max(_10932, _22361)) < (-_7819);
	                        }
	                        if (_12887)
	                        {
	                            _12899 = false;
	                            break;
	                        }
	                        float _15390 = _3749.z;
	                        float _10933 = _3750.z;
	                        float _22362 = _3751.z;
	                        float _7820 = dot(0.50010001659393310546875f.xxx, abs(float3(0.0f, 0.0f, 1.0f)));
	                        bool _12888;
	                        if (min(_15390, min(_10933, _22362)) > _7820)
	                        {
	                            _12888 = true;
	                        }
	                        else
	                        {
	                            _12888 = max(_15390, max(_10933, _22362)) < (-_7820);
	                        }
	                        if (_12888)
	                        {
	                            _12899 = false;
	                            break;
	                        }
	                        float _9199 = dot(_16702, _3749);
	                        float _16970 = dot(_16702, _3750);
	                        float _20370 = dot(_16702, _3751);
	                        float _13426 = dot(0.50010001659393310546875f.xxx, abs(_16702));
	                        bool _12889;
	                        if (min(_9199, min(_16970, _20370)) > _13426)
	                        {
	                            _12889 = true;
	                        }
	                        else
	                        {
	                            _12889 = max(_9199, max(_16970, _20370)) < (-_13426);
	                        }
	                        if (_12889)
	                        {
	                            _12899 = false;
	                            break;
	                        }
	                        float _7431 = _3765.z;
	                        float _23941 = _3765.y;
	                        float3 _12310 = float3(0.0f, -_7431, _23941);
	                        float _16294 = dot(_12310, _3749);
	                        float _16775 = dot(_12310, _3750);
	                        float _20371 = dot(_12310, _3751);
	                        float _13427 = dot(0.50010001659393310546875f.xxx, abs(_12310));
	                        bool _12890;
	                        if (min(_16294, min(_16775, _20371)) > _13427)
	                        {
	                            _12890 = true;
	                        }
	                        else
	                        {
	                            _12890 = max(_16294, max(_16775, _20371)) < (-_13427);
	                        }
	                        if (_12890)
	                        {
	                            _12899 = false;
	                            break;
	                        }
	                        float _7412 = _3765.x;
	                        float3 _20372 = float3(_7431, 0.0f, -_7412);
	                        float _21108 = dot(_20372, _3749);
	                        float _16776 = dot(_20372, _3750);
	                        float _20373 = dot(_20372, _3751);
	                        float _13428 = dot(0.50010001659393310546875f.xxx, abs(_20372));
	                        bool _12891;
	                        if (min(_21108, min(_16776, _20373)) > _13428)
	                        {
	                            _12891 = true;
	                        }
	                        else
	                        {
	                            _12891 = max(_21108, max(_16776, _20373)) < (-_13428);
	                        }
	                        if (_12891)
	                        {
	                            _12899 = false;
	                            break;
	                        }
	                        float3 _10373 = float3(-_23941, _7412, 0.0f);
	                        float _21109 = dot(_10373, _3749);
	                        float _16777 = dot(_10373, _3750);
	                        float _20374 = dot(_10373, _3751);
	                        float _13429 = dot(0.50010001659393310546875f.xxx, abs(_10373));
	                        bool _12892;
	                        if (min(_21109, min(_16777, _20374)) > _13429)
	                        {
	                            _12892 = true;
	                        }
	                        else
	                        {
	                            _12892 = max(_21109, max(_16777, _20374)) < (-_13429);
	                        }
	                        if (_12892)
	                        {
	                            _12899 = false;
	                            break;
	                        }
	                        float _7432 = _3766.z;
	                        float _23942 = _3766.y;
	                        float3 _12311 = float3(0.0f, -_7432, _23942);
	                        float _16295 = dot(_12311, _3749);
	                        float _16778 = dot(_12311, _3750);
	                        float _20375 = dot(_12311, _3751);
	                        float _13430 = dot(0.50010001659393310546875f.xxx, abs(_12311));
	                        bool _12893;
	                        if (min(_16295, min(_16778, _20375)) > _13430)
	                        {
	                            _12893 = true;
	                        }
	                        else
	                        {
	                            _12893 = max(_16295, max(_16778, _20375)) < (-_13430);
	                        }
	                        if (_12893)
	                        {
	                            _12899 = false;
	                            break;
	                        }
	                        float _7413 = _3766.x;
	                        float3 _20376 = float3(_7432, 0.0f, -_7413);
	                        float _21110 = dot(_20376, _3749);
	                        float _16779 = dot(_20376, _3750);
	                        float _20377 = dot(_20376, _3751);
	                        float _13431 = dot(0.50010001659393310546875f.xxx, abs(_20376));
	                        bool _12894;
	                        if (min(_21110, min(_16779, _20377)) > _13431)
	                        {
	                            _12894 = true;
	                        }
	                        else
	                        {
	                            _12894 = max(_21110, max(_16779, _20377)) < (-_13431);
	                        }
	                        if (_12894)
	                        {
	                            _12899 = false;
	                            break;
	                        }
	                        float3 _10374 = float3(-_23942, _7413, 0.0f);
	                        float _21111 = dot(_10374, _3749);
	                        float _16780 = dot(_10374, _3750);
	                        float _20378 = dot(_10374, _3751);
	                        float _13432 = dot(0.50010001659393310546875f.xxx, abs(_10374));
	                        bool _12895;
	                        if (min(_21111, min(_16780, _20378)) > _13432)
	                        {
	                            _12895 = true;
	                        }
	                        else
	                        {
	                            _12895 = max(_21111, max(_16780, _20378)) < (-_13432);
	                        }
	                        if (_12895)
	                        {
	                            _12899 = false;
	                            break;
	                        }
	                        float _7433 = _13196.z;
	                        float _23943 = _13196.y;
	                        float3 _12312 = float3(0.0f, -_7433, _23943);
	                        float _16296 = dot(_12312, _3749);
	                        float _16781 = dot(_12312, _3750);
	                        float _20379 = dot(_12312, _3751);
	                        float _13433 = dot(0.50010001659393310546875f.xxx, abs(_12312));
	                        bool _12896;
	                        if (min(_16296, min(_16781, _20379)) > _13433)
	                        {
	                            _12896 = true;
	                        }
	                        else
	                        {
	                            _12896 = max(_16296, max(_16781, _20379)) < (-_13433);
	                        }
	                        if (_12896)
	                        {
	                            _12899 = false;
	                            break;
	                        }
	                        float _7414 = _13196.x;
	                        float3 _20380 = float3(_7433, 0.0f, -_7414);
	                        float _21112 = dot(_20380, _3749);
	                        float _16782 = dot(_20380, _3750);
	                        float _20381 = dot(_20380, _3751);
	                        float _13434 = dot(0.50010001659393310546875f.xxx, abs(_20380));
	                        bool _12897;
	                        if (min(_21112, min(_16782, _20381)) > _13434)
	                        {
	                            _12897 = true;
	                        }
	                        else
	                        {
	                            _12897 = max(_21112, max(_16782, _20381)) < (-_13434);
	                        }
	                        if (_12897)
	                        {
	                            _12899 = false;
	                            break;
	                        }
	                        float3 _10375 = float3(-_23943, _7414, 0.0f);
	                        float _21113 = dot(_10375, _3749);
	                        float _16783 = dot(_10375, _3750);
	                        float _20382 = dot(_10375, _3751);
	                        float _13435 = dot(0.50010001659393310546875f.xxx, abs(_10375));
	                        bool _12898;
	                        if (min(_21113, min(_16783, _20382)) > _13435)
	                        {
	                            _12898 = true;
	                        }
	                        else
	                        {
	                            _12898 = max(_21113, max(_16783, _20382)) < (-_13435);
	                        }
	                        if (_12898)
	                        {
	                            _12899 = false;
	                            break;
	                        }
	                        _12899 = true;
	                        break;
	                    } while(false);
	                    if (_12899)
	                    {
	                        uint _12752 = uint(_13041) + (g_Grids.Load<uint3>(128).x * (uint(_13040) + (g_Grids.Load<uint3>(128).y * uint(_13039))));
	                        uint _13239;
	                        g_OccupiedMask.InterlockedOr((_12752 >> uint(5)) * 4 + 0, 1u << (_12752 & 31u), _13239);
	                    }
	                    _23989 = _13041 + 1;
	                    _13041 = _23989;
	                    continue;
	                }
	                _21568 = _13040 + 1;
	                _13040 = _21568;
	                continue;
	            }
	            _21567 = _13039 + 1;
	            _13039 = _21567;
	            continue;
	        }
	        break;
	    } while(false);
	}
	
	[numthreads(64, 1, 1)]
	void MainCs(SPIRV_Cross_Input stage_input)
	{
	    gl_GlobalInvocationID = stage_input.gl_GlobalInvocationID;
	    MainCs_inner();
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
}
