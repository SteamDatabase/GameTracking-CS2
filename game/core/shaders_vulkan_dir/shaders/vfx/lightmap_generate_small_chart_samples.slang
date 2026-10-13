//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Generates samples for degenerate charts that can't be rasterized";
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
	
	StructuredBuffer g_ChartInfo < Attribute("g_ChartInfo"); >;
	RWStructuredBuffer g_LightmapSamples < Attribute("g_LightmapSamples"); >;
	Texture2D g_LuxelChartIDs < Attribute("g_LuxelChartIDs"); SrgbRead(false); >;
	StructuredBuffer g_TriangleArea < Attribute("g_TriangleArea"); >;
	StructuredBuffer g_TriangleListForThreadGroup < Attribute("g_TriangleListForThreadGroup"); >;
	ByteAddressBuffer g_Vertices < Attribute("g_Vertices"); >;
	int g_nLightmapBlockRectWidth < Attribute("g_nLightmapBlockRectWidth"); UiType(Slider); >;
	int g_nLightmapBlockRectX < Attribute("g_nLightmapBlockRectX"); UiType(Slider); >;
	int g_nLightmapBlockRectY < Attribute("g_nLightmapBlockRectY"); UiType(Slider); >;
	int g_nLightmapHeight < Attribute("g_nLightmapHeight"); UiType(Slider); >;
	int g_nLightmapUVOffsetInBytes < Attribute("g_nLightmapUVOffsetInBytes"); UiType(Slider); >;
	int g_nLightmapWidth < Attribute("g_nLightmapWidth"); UiType(Slider); >;
	int g_nPackedNormalTangentOffsetInBytes < Attribute("g_nPackedNormalTangentOffsetInBytes"); UiType(Slider); >;
	int g_nRNGOffsetX < Attribute("g_nRNGOffsetX"); UiType(Slider); >;
	int g_nRNGOffsetY < Attribute("g_nRNGOffsetY"); UiType(Slider); >;
	int g_nVertexStride < Attribute("g_nVertexStride"); UiType(Slider); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	struct _1531
	{
	    float4 _m0;
	    float4 _m1;
	    float4 _m2;
	    float4 _m3;
	    float4 _m4;
	    float2 _m5;
	    int _m6;
	    uint _m7;
	};
	
	struct _1532
	{
	    float4 _m0;
	    float4 _m1;
	    float4 _m2;
	    float4 _m3;
	    float4 _m4;
	    float2 _m5;
	    int _m6;
	    uint _m7;
	};
	
	struct _990
	{
	    uint _m0;
	    uint _m1;
	};
	
	static float _6;
	static float2 _7;
	
	cbuffer _Globals_ : register(b0, space0)
	{
	    int _Globals_1_g_nVertexStride : packoffset(c0);
	    int _Globals_1_g_nLightmapUVOffsetInBytes : packoffset(c0.y);
	    int _Globals_1_g_nPackedNormalTangentOffsetInBytes : packoffset(c0.z);
	    int _Globals_1_g_nLightmapBlockRectX : packoffset(c0.w);
	    int _Globals_1_g_nLightmapBlockRectY : packoffset(c1);
	    int _Globals_1_g_nLightmapBlockRectWidth : packoffset(c1.y);
	    int _Globals_1_g_nRNGOffsetX : packoffset(c1.w);
	    int _Globals_1_g_nRNGOffsetY : packoffset(c2);
	    int _Globals_1_g_nLightmapWidth : packoffset(c2.y);
	    int _Globals_1_g_nLightmapHeight : packoffset(c2.z);
	};
	
	ByteAddressBuffer g_TriangleListForThreadGroup : register(t31, space0);
	RWByteAddressBuffer g_LightmapSamples : register(u158, space0);
	ByteAddressBuffer g_TriangleArea : register(t32, space0);
	ByteAddressBuffer g_Vertices : register(t30, space0);
	ByteAddressBuffer g_Vertices_1 : register(t30, space0);
	ByteAddressBuffer g_ChartInfo : register(t33, space0);
	Texture2D<uint4> g_LuxelChartIDs : register(t34, space0);
	
	static uint3 gl_WorkGroupID;
	static uint3 gl_GlobalInvocationID;
	static uint gl_LocalInvocationIndex;
	struct SPIRV_Cross_Input
	{
	    uint3 gl_WorkGroupID : SV_GroupID;
	    uint3 gl_GlobalInvocationID : SV_DispatchThreadID;
	    uint gl_LocalInvocationIndex : SV_GroupIndex;
	};
	
	groupshared _1531 _5633[64];
	groupshared int2 _5704[64];
	
	void MainCs_inner()
	{
	    do
	    {
	        uint _5156 = gl_WorkGroupID.x + (gl_WorkGroupID.y * uint(_Globals_1_g_nLightmapBlockRectWidth / 8));
	        int _6540 = g_TriangleListForThreadGroup.Load<int>(_5156 * 4 + 0);
	        uint _13648 = _5156 + 1u;
	        int _18397 = g_TriangleListForThreadGroup.Load<int>(_13648 * 4 + 0);
	        uint _5963 = (gl_GlobalInvocationID.y * uint(_Globals_1_g_nLightmapBlockRectWidth)) + gl_GlobalInvocationID.x;
	        g_LightmapSamples.Store<float4>(_5963 * 96 + 0, 0.0f.xxxx);
	        g_LightmapSamples.Store<float4>(_5963 * 96 + 16, 0.0f.xxxx);
	        g_LightmapSamples.Store<float4>(_5963 * 96 + 32, 0.0f.xxxx);
	        g_LightmapSamples.Store<float4>(_5963 * 96 + 48, 0.0f.xxxx);
	        g_LightmapSamples.Store<float4>(_5963 * 96 + 64, 0.0f.xxxx);
	        g_LightmapSamples.Store<float2>(_5963 * 96 + 80, (-1.0f).xx);
	        g_LightmapSamples.Store<int>(_5963 * 96 + 88, 0);
	        g_LightmapSamples.Store<uint>(_5963 * 96 + 92, 0u);
	        [branch]
	        if (_6540 >= _18397)
	        {
	            break;
	        }
	        uint2 _13136;
	        float4 _16305;
	        float2 _17114;
	        int _17115;
	        float4 _17116;
	        float4 _17117;
	        float4 _17118;
	        float4 _17119;
	        _13136 = gl_GlobalInvocationID.xy + uint2(int2(_Globals_1_g_nRNGOffsetX, _Globals_1_g_nRNGOffsetY));
	        _16305 = 0.0f.xxxx;
	        _17114 = (-1.0f).xx;
	        _17115 = 0;
	        _17116 = 0.0f.xxxx;
	        _17117 = 0.0f.xxxx;
	        _17118 = 0.0f.xxxx;
	        _17119 = 0.0f.xxxx;
	        int _21567;
	        float _13142;
	        uint2 _16327;
	        float4 _17023;
	        float4 _17121;
	        float2 _17122;
	        int _17123;
	        float4 _17124;
	        float4 _17125;
	        float4 _17135;
	        float _17017 = 0.0f;
	        int _17133 = 0;
	        [loop]
	        for (;;)
	        {
	            if (!(_17133 < 16))
	            {
	                break;
	            }
	            uint2 _16324;
	            _16324 = _13136;
	            int _6352;
	            uint _12046;
	            uint2 _16189;
	            uint _13137 = 0u;
	            int _17018 = 0;
	            for (;;)
	            {
	                if (!(_17018 < 6))
	                {
	                    break;
	                }
	                _12046 = _13137 + 2654435769u;
	                _16189 = _16324.xy + ((((_16324.yx << uint2(int2(4, 4))) + uint2(2738958700u, 2911926141u)) ^ (_16324.yx + _12046.xx)) ^ ((_16324.yx >> uint2(int2(5, 5))) + uint2(3355524772u, 2123724318u)));
	                _6352 = _17018 + 1;
	                _13137 = _12046;
	                _16324 = _16189;
	                _17018 = _6352;
	                continue;
	            }
	            uint2 _16325;
	            _16325 = _16324;
	            int _6353;
	            uint _12047;
	            uint2 _16190;
	            uint _13138 = 0u;
	            int _17019 = 0;
	            for (;;)
	            {
	                if (!(_17019 < 6))
	                {
	                    break;
	                }
	                _12047 = _13138 + 2654435769u;
	                _16190 = _16325.xy + ((((_16325.yx << uint2(int2(4, 4))) + uint2(2738958700u, 2911926141u)) ^ (_16325.yx + _12047.xx)) ^ ((_16325.yx >> uint2(int2(5, 5))) + uint2(3355524772u, 2123724318u)));
	                _6353 = _17019 + 1;
	                _13138 = _12047;
	                _16325 = _16190;
	                _17019 = _6353;
	                continue;
	            }
	            float2 _16306;
	            int _17134;
	            _16306 = float2(float(_16324.x & 1048575u) * 9.5367431640625e-07f, float(_16325.x & 1048575u) * 9.5367431640625e-07f);
	            _17134 = -1;
	            float _10256;
	            float2 _15914;
	            int _17315;
	            int _24187;
	            float _13139 = 0.0f;
	            int _17020 = _6540;
	            for (;;)
	            {
	                if (!(_17020 < _18397))
	                {
	                    break;
	                }
	                float _10039;
	                bool _23989;
	                do
	                {
	                    _10256 = _13139 + g_TriangleArea.Load<float>(_17020 * 4 + 0);
	                    if (_10256 == 0.0f)
	                    {
	                        _10039 = _16306.y;
	                        _23989 = false;
	                        break;
	                    }
	                    float _16061 = g_TriangleArea.Load<float>(_17020 * 4 + 0) / _10256;
	                    float _13212;
	                    bool _15670;
	                    do
	                    {
	                        if (_16061 <= 0.0f)
	                        {
	                            _13212 = _16306.y;
	                            _15670 = false;
	                            break;
	                        }
	                        if (_16061 >= 1.0f)
	                        {
	                            _13212 = _16306.y;
	                            _15670 = true;
	                            break;
	                        }
	                        if (_16306.y < _16061)
	                        {
	                            _13212 = min(_16306.y / _16061, 0.99999988079071044921875f);
	                            _15670 = true;
	                            break;
	                        }
	                        _13212 = min((_16306.y - _16061) / (1.0f - _16061), 0.99999988079071044921875f);
	                        _15670 = false;
	                        break;
	                    } while(false);
	                    _10039 = _13212;
	                    _23989 = _15670;
	                    break;
	                } while(false);
	                _15914 = _16306;
	                _15914.y = _10039;
	                _24187 = _23989 ? _17020 : _17134;
	                _17315 = _17020 + 1;
	                _13139 = _10256;
	                _16306 = _15914;
	                _17134 = _24187;
	                _17020 = _17315;
	                continue;
	            }
	            GroupMemoryBarrierWithGroupSync();
	            if (_17134 >= 0)
	            {
	                int _19496 = _17134 * 3;
	                int _10198 = _19496 * _Globals_1_g_nVertexStride;
	                uint _12154 = uint(_10198);
	                float3 _6421 = float3(g_Vertices.Load<float>((_12154 / 4u) * 4 + 0), g_Vertices.Load<float>(((_12154 + 4u) / 4u) * 4 + 0), g_Vertices.Load<float>(((_12154 + 8u) / 4u) * 4 + 0));
	                uint _19607 = uint(_10198 + _Globals_1_g_nLightmapUVOffsetInBytes);
	                uint _19813 = uint(_10198 + _Globals_1_g_nPackedNormalTangentOffsetInBytes) / 4u;
	                float _22483 = (float((g_Vertices_1.Load<uint>(_19813 * 4 + 0) >> 12u) & 1023u) * 0.00195503421127796173095703125f) - 1.0f;
	                float _7589 = (float((g_Vertices_1.Load<uint>(_19813 * 4 + 0) >> 22u) & 1023u) * 0.00195503421127796173095703125f) - 1.0f;
	                float _23404 = (1.0f - abs(_22483)) - abs(_7589);
	                float3 _8254 = float3(_22483, _7589, _23404);
	                float _24228 = saturate(-_23404);
	                float2 _7335 = float2(_22483, _7589);
	                bool2 _10803 = bool2(_7335.x >= 0.0f.xx.x, _7335.y >= 0.0f.xx.y);
	                float2 _14501 = (-_24228).xx;
	                float2 _8565 = _24228.xx;
	                float2 _14348 = _7335 + float2(_10803.x ? _14501.x : _8565.x, _10803.y ? _14501.y : _8565.y);
	                _8254.x = _14348.x;
	                _8254.y = _14348.y;
	                float3 _21001 = normalize(_8254);
	                float _6384 = _21001.z;
	                float _8220 = (_6384 >= 0.0f) ? 1.0f : (-1.0f);
	                float _16417 = (-1.0f) / (_8220 + _6384);
	                float _14755 = _21001.x;
	                float3 _23176 = float3(1.0f + (((_8220 * _14755) * _14755) * _16417), _8220 * ((_14755 * _21001.y) * _16417), (-_8220) * _14755);
	                float _23966 = float((g_Vertices_1.Load<uint>(_19813 * 4 + 0) >> uint(1)) & 2047u) * 0.003069460391998291015625f;
	                int _13498 = (_19496 + 1) * _Globals_1_g_nVertexStride;
	                uint _17762 = uint(_13498);
	                float3 _15790 = float3(g_Vertices.Load<float>((_17762 / 4u) * 4 + 0), g_Vertices.Load<float>(((_17762 + 4u) / 4u) * 4 + 0), g_Vertices.Load<float>(((_17762 + 8u) / 4u) * 4 + 0));
	                uint _18788 = uint(_13498 + _Globals_1_g_nLightmapUVOffsetInBytes);
	                uint _19815 = uint(_13498 + _Globals_1_g_nPackedNormalTangentOffsetInBytes) / 4u;
	                float _22484 = (float((g_Vertices_1.Load<uint>(_19815 * 4 + 0) >> 12u) & 1023u) * 0.00195503421127796173095703125f) - 1.0f;
	                float _7590 = (float((g_Vertices_1.Load<uint>(_19815 * 4 + 0) >> 22u) & 1023u) * 0.00195503421127796173095703125f) - 1.0f;
	                float _23405 = (1.0f - abs(_22484)) - abs(_7590);
	                float3 _8255 = float3(_22484, _7590, _23405);
	                float _24229 = saturate(-_23405);
	                float2 _7336 = float2(_22484, _7590);
	                bool2 _10804 = bool2(_7336.x >= 0.0f.xx.x, _7336.y >= 0.0f.xx.y);
	                float2 _14502 = (-_24229).xx;
	                float2 _8566 = _24229.xx;
	                float2 _14349 = _7336 + float2(_10804.x ? _14502.x : _8566.x, _10804.y ? _14502.y : _8566.y);
	                _8255.x = _14349.x;
	                _8255.y = _14349.y;
	                float3 _21002 = normalize(_8255);
	                float _6385 = _21002.z;
	                float _8221 = (_6385 >= 0.0f) ? 1.0f : (-1.0f);
	                float _16418 = (-1.0f) / (_8221 + _6385);
	                float _14756 = _21002.x;
	                float3 _23177 = float3(1.0f + (((_8221 * _14756) * _14756) * _16418), _8221 * ((_14756 * _21002.y) * _16418), (-_8221) * _14756);
	                float _23967 = float((g_Vertices_1.Load<uint>(_19815 * 4 + 0) >> uint(1)) & 2047u) * 0.003069460391998291015625f;
	                int _13499 = (_19496 + 2) * _Globals_1_g_nVertexStride;
	                uint _17763 = uint(_13499);
	                float3 _15792 = float3(g_Vertices.Load<float>((_17763 / 4u) * 4 + 0), g_Vertices.Load<float>(((_17763 + 4u) / 4u) * 4 + 0), g_Vertices.Load<float>(((_17763 + 8u) / 4u) * 4 + 0));
	                uint _18790 = uint(_13499 + _Globals_1_g_nLightmapUVOffsetInBytes);
	                uint _19817 = uint(_13499 + _Globals_1_g_nPackedNormalTangentOffsetInBytes) / 4u;
	                float _22485 = (float((g_Vertices_1.Load<uint>(_19817 * 4 + 0) >> 12u) & 1023u) * 0.00195503421127796173095703125f) - 1.0f;
	                float _7593 = (float((g_Vertices_1.Load<uint>(_19817 * 4 + 0) >> 22u) & 1023u) * 0.00195503421127796173095703125f) - 1.0f;
	                float _23406 = (1.0f - abs(_22485)) - abs(_7593);
	                float3 _8256 = float3(_22485, _7593, _23406);
	                float _24230 = saturate(-_23406);
	                float2 _7337 = float2(_22485, _7593);
	                bool2 _10805 = bool2(_7337.x >= 0.0f.xx.x, _7337.y >= 0.0f.xx.y);
	                float2 _14503 = (-_24230).xx;
	                float2 _8567 = _24230.xx;
	                float2 _14350 = _7337 + float2(_10805.x ? _14503.x : _8567.x, _10805.y ? _14503.y : _8567.y);
	                _8256.x = _14350.x;
	                _8256.y = _14350.y;
	                float3 _21003 = normalize(_8256);
	                float _6386 = _21003.z;
	                float _8222 = (_6386 >= 0.0f) ? 1.0f : (-1.0f);
	                float _16419 = (-1.0f) / (_8222 + _6386);
	                float _14757 = _21003.x;
	                float3 _23178 = float3(1.0f + (((_8222 * _14757) * _14757) * _16419), _8222 * ((_14757 * _21003.y) * _16419), (-_8222) * _14757);
	                float _23968 = float((g_Vertices_1.Load<uint>(_19817 * 4 + 0) >> uint(1)) & 2047u) * 0.003069460391998291015625f;
	                float _10266 = sqrt(_16306.x);
	                float _11861 = 1.0f - _10266;
	                float _16310 = _16306.y * _10266;
	                float _15062 = _10266 - _16310;
	                float3 _13062 = ((_6421 * _15062) + (_15790 * _11861)) + (_15792 * _16310);
	                float4 _20493 = float4(0.0f, 0.0f, 0.0f, 1.0f);
	                _20493.x = _13062.x;
	                _20493.y = _13062.y;
	                _20493.z = _13062.z;
	                float3 _13063 = ((_21001 * _15062) + (_21002 * _11861)) + (_21003 * _16310);
	                float4 _20494 = 0.0f.xxxx;
	                _20494.x = _13063.x;
	                _20494.y = _13063.y;
	                _20494.z = _13063.z;
	                float3 _22590 = normalize(cross(_15790 - _6421, _15792 - _6421));
	                float4 _16886 = 0.0f.xxxx;
	                _16886.x = _22590.x;
	                _16886.y = _22590.y;
	                _16886.z = _22590.z;
	                float2 _16199 = ((float2(g_Vertices.Load<float>((_19607 / 4u) * 4 + 0), g_Vertices.Load<float>(((_19607 + 4u) / 4u) * 4 + 0)) * _15062) + (float2(g_Vertices.Load<float>((_18788 / 4u) * 4 + 0), g_Vertices.Load<float>(((_18788 + 4u) / 4u) * 4 + 0)) * _11861)) + (float2(g_Vertices.Load<float>((_18790 / 4u) * 4 + 0), g_Vertices.Load<float>(((_18790 + 4u) / 4u) * 4 + 0)) * _16310);
	                _1531 _21868 = { _20493, 0.0f.xxxx, _20494, _16886, ((float4((_23176 * cos(_23966)) + (cross(_21001, _23176) * sin(_23966)), ((g_Vertices_1.Load<uint>(_19813 * 4 + 0) & 1u) == 0u) ? (-1.0f) : 1.0f) * _15062) + (float4((_23177 * cos(_23967)) + (cross(_21002, _23177) * sin(_23967)), ((g_Vertices_1.Load<uint>(_19815 * 4 + 0) & 1u) == 0u) ? (-1.0f) : 1.0f) * _11861)) + (float4((_23178 * cos(_23968)) + (cross(_21003, _23178) * sin(_23968)), ((g_Vertices_1.Load<uint>(_19817 * 4 + 0) & 1u) == 0u) ? (-1.0f) : 1.0f) * _16310), _16199, 0, 0u };
	                _5633[gl_LocalInvocationIndex] = _21868;
	                _5704[gl_LocalInvocationIndex] = int2(_16199.xy * float2(int2(_Globals_1_g_nLightmapWidth, _Globals_1_g_nLightmapHeight)));
	            }
	            GroupMemoryBarrierWithGroupSync();
	            uint2 _16326;
	            _16326 = _16325;
	            int _6354;
	            uint _12048;
	            uint2 _16191;
	            uint _13140 = 0u;
	            int _17021 = 0;
	            for (;;)
	            {
	                if (!(_17021 < 6))
	                {
	                    break;
	                }
	                _12048 = _13140 + 2654435769u;
	                _16191 = _16326.xy + ((((_16326.yx << uint2(int2(4, 4))) + uint2(2738958700u, 2911926141u)) ^ (_16326.yx + _12048.xx)) ^ ((_16326.yx >> uint2(int2(5, 5))) + uint2(3355524772u, 2123724318u)));
	                _6354 = _17021 + 1;
	                _13140 = _12048;
	                _16326 = _16191;
	                _17021 = _6354;
	                continue;
	            }
	            _16327 = _16326;
	            int _6355;
	            uint _12049;
	            uint2 _16192;
	            uint _13141 = 0u;
	            int _17022 = 0;
	            for (;;)
	            {
	                if (!(_17022 < 6))
	                {
	                    break;
	                }
	                _12049 = _13141 + 2654435769u;
	                _16192 = _16327.xy + ((((_16327.yx << uint2(int2(4, 4))) + uint2(2738958700u, 2911926141u)) ^ (_16327.yx + _12049.xx)) ^ ((_16327.yx >> uint2(int2(5, 5))) + uint2(3355524772u, 2123724318u)));
	                _6355 = _17022 + 1;
	                _13141 = _12049;
	                _16327 = _16192;
	                _17022 = _6355;
	                continue;
	            }
	            float2 _16307;
	            _13142 = _17017;
	            _16307 = float2(float(_16326.x & 1048575u) * 9.5367431640625e-07f, _6);
	            _17121 = _16305;
	            _17122 = _17114;
	            _17123 = _17115;
	            _17124 = _17116;
	            _17125 = _17117;
	            _17135 = _17118;
	            _17023 = _17119;
	            uint _8896;
	            float _13144;
	            float4 _14891;
	            float2 _16309;
	            float4 _17129;
	            float2 _17130;
	            int _17131;
	            float4 _17132;
	            float4 _17136;
	            float4 _18360;
	            uint _17120 = 0u;
	            for (;;)
	            {
	                bool _7956_ladder_break = false;
	                do
	                {
	                    if (!(_17120 < 64u))
	                    {
	                        _7956_ladder_break = true;
	                        break;
	                    }
	                    uint2 _8278 = uint2(_5704[_17120]);
	                    uint2 _10273 = gl_GlobalInvocationID.xy + uint2(uint(_Globals_1_g_nLightmapBlockRectX), uint(_Globals_1_g_nLightmapBlockRectY));
	                    if (any(bool2(_8278.x != _10273.x, _8278.y != _10273.y)))
	                    {
	                        _13144 = _13142;
	                        _16309 = _16307;
	                        _17129 = _17121;
	                        _17130 = _17122;
	                        _17131 = _17123;
	                        _17132 = _17124;
	                        _17136 = _17125;
	                        _14891 = _17135;
	                        _18360 = _17023;
	                        break;
	                    }
	                    if (_5633[_17120]._m0.w == 0.0f)
	                    {
	                        _13144 = _13142;
	                        _16309 = _16307;
	                        _17129 = _17121;
	                        _17130 = _17122;
	                        _17131 = _17123;
	                        _17132 = _17124;
	                        _17136 = _17125;
	                        _14891 = _17135;
	                        _18360 = _17023;
	                        break;
	                    }
	                    float _10257;
	                    bool _6400;
	                    float _10040;
	                    do
	                    {
	                        _10257 = _13142 + 1.0f;
	                        if (_10257 == 0.0f)
	                        {
	                            _10040 = _16307.x;
	                            _6400 = false;
	                            break;
	                        }
	                        float _16062 = 1.0f / _10257;
	                        float _13213;
	                        bool _15671;
	                        do
	                        {
	                            if (_16062 <= 0.0f)
	                            {
	                                _13213 = _16307.x;
	                                _15671 = false;
	                                break;
	                            }
	                            if (_16062 >= 1.0f)
	                            {
	                                _13213 = _16307.x;
	                                _15671 = true;
	                                break;
	                            }
	                            if (_16307.x < _16062)
	                            {
	                                _13213 = min(_16307.x / _16062, 0.99999988079071044921875f);
	                                _15671 = true;
	                                break;
	                            }
	                            _13213 = min((_16307.x - _16062) / (1.0f - _16062), 0.99999988079071044921875f);
	                            _15671 = false;
	                            break;
	                        } while(false);
	                        _10040 = _13213;
	                        _6400 = _15671;
	                        break;
	                    } while(false);
	                    float2 _23809;
	                    _23809.x = _10040;
	                    float4 _13143;
	                    float2 _16308;
	                    float4 _16479;
	                    int _17126;
	                    float4 _17127;
	                    float4 _17128;
	                    float4 _17190;
	                    if (_6400)
	                    {
	                        _13143 = _5633[_17120]._m3;
	                        _16308 = _5633[_17120]._m5;
	                        _17126 = _5633[_17120]._m6;
	                        _17127 = _5633[_17120]._m4;
	                        _17128 = _5633[_17120]._m1;
	                        _17190 = _5633[_17120]._m2;
	                        _16479 = _5633[_17120]._m0;
	                    }
	                    else
	                    {
	                        _13143 = _17121;
	                        _16308 = _17122;
	                        _17126 = _17123;
	                        _17127 = _17124;
	                        _17128 = _17125;
	                        _17190 = _17135;
	                        _16479 = _17023;
	                    }
	                    _13144 = _10257;
	                    _16309 = _23809;
	                    _17129 = _13143;
	                    _17130 = _16308;
	                    _17131 = _17126;
	                    _17132 = _17127;
	                    _17136 = _17128;
	                    _14891 = _17190;
	                    _18360 = _16479;
	                    break;
	                } while(false);
	                if (_7956_ladder_break)
	                {
	                    break;
	                }
	                _8896 = _17120 + 1u;
	                _13142 = _13144;
	                _16307 = _16309;
	                _17120 = _8896;
	                _17121 = _17129;
	                _17122 = _17130;
	                _17123 = _17131;
	                _17124 = _17132;
	                _17125 = _17136;
	                _17135 = _14891;
	                _17023 = _18360;
	                continue;
	            }
	            _21567 = _17133 + 1;
	            _13136 = _16327;
	            _16305 = _17121;
	            _17114 = _17122;
	            _17115 = _17123;
	            _17116 = _17124;
	            _17117 = _17125;
	            _17118 = _17135;
	            _17119 = _17023;
	            _17133 = _21567;
	            _17017 = _13142;
	            continue;
	        }
	        uint4 _3300 = g_LuxelChartIDs.Load(int3(gl_GlobalInvocationID.xy, 0));
	        uint _17171 = _3300.x;
	        bool _12885;
	        if (_17119.w != 0.0f)
	        {
	            _12885 = _17171 != 4294967295u;
	        }
	        else
	        {
	            _12885 = false;
	        }
	        if (_12885)
	        {
	            float3 _9699 = normalize(_17118.xyz);
	            float _24205 = _9699.x;
	            float4 _16887 = _17118;
	            _16887.x = _24205;
	            float _21816 = _9699.y;
	            _16887.y = _21816;
	            float _21832 = _9699.z;
	            _16887.z = _21832;
	            float4 _13639 = _17117;
	            _13639.x = _24205;
	            _13639.y = _21816;
	            _13639.z = _21832;
	            uint _9062 = g_ChartInfo.Load<uint>(_17171 * 8 + 4);
	            g_LightmapSamples.Store<float4>(_5963 * 96 + 0, _17119);
	            g_LightmapSamples.Store<float4>(_5963 * 96 + 16, _13639);
	            g_LightmapSamples.Store<float4>(_5963 * 96 + 32, _16887);
	            g_LightmapSamples.Store<float4>(_5963 * 96 + 48, _16305);
	            g_LightmapSamples.Store<float4>(_5963 * 96 + 64, float4(normalize(_17116.xyz), float(int(sign(_17116.w)))));
	            g_LightmapSamples.Store<float2>(_5963 * 96 + 80, _17114);
	            g_LightmapSamples.Store<int>(_5963 * 96 + 88, _17115);
	            g_LightmapSamples.Store<uint>(_5963 * 96 + 92, _9062);
	        }
	        break;
	    } while(false);
	}
	
	[numthreads(8, 8, 1)]
	void MainCs(SPIRV_Cross_Input stage_input)
	{
	    gl_WorkGroupID = stage_input.gl_WorkGroupID;
	    gl_GlobalInvocationID = stage_input.gl_GlobalInvocationID;
	    gl_LocalInvocationIndex = stage_input.gl_LocalInvocationIndex;
	    MainCs_inner();
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
}
