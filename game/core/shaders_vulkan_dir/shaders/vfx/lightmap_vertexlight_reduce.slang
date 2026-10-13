//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Test convergence";
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
	Feature( F_LIGHTMAP_TYPE, 0..2 (0="Lightmap", 1="LPV", 2="Vertex Lighting"), "" );
}

COMMON
{
	#include "system.fxc"
}

CS
{
	DynamicCombo( D_COMPRESSED_NORMALS_AND_TANGENTS, 0..1 );
	
	RWStructuredBuffer g_Result < Attribute("g_Result"); >;
	StructuredBuffer g_VertexLightSamples < Attribute("g_VertexLightSamples"); >;
	int g_nBlockWidth < Attribute("g_nBlockWidth"); UiType(Slider); >;
	int g_nVertexCount < Attribute("g_nVertexCount"); UiType(Slider); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	struct _1017
	{
	    float4 _m0;
	};
	
	cbuffer _Globals_ : register(b0, space0)
	{
	    uint _Globals_1_g_nVertexCount : packoffset(c0);
	    int _Globals_1_g_nBlockWidth : packoffset(c0.y);
	};
	
	ByteAddressBuffer g_VertexLightSamples : register(t30, space0);
	RWByteAddressBuffer g_Result : register(u158, space0);
	
	static uint3 gl_GlobalInvocationID;
	struct SPIRV_Cross_Input
	{
	    uint3 gl_GlobalInvocationID : SV_DispatchThreadID;
	};
	
	void MainCs_inner()
	{
	    do
	    {
	        if (gl_GlobalInvocationID.x >= _Globals_1_g_nVertexCount)
	        {
	            break;
	        }
	        uint _4129 = gl_GlobalInvocationID.x / 3u;
	        uint _23446 = gl_GlobalInvocationID.x - (3u * _4129);
	        uint _16799 = uint(_Globals_1_g_nBlockWidth);
	        uint _5499 = _16799 / 4u;
	        uint _9973 = _4129 / _5499;
	        uint2 _9668 = uint2(_4129 - (_9973 * _5499), _9973);
	        float3 _13155;
	        _13155 = 0.0f.xxx;
	        uint _21567;
	        float3 _13156;
	        uint _16208 = 0u;
	        for (;;)
	        {
	            if (!(_16208 < 4u))
	            {
	                break;
	            }
	            _13156 = _13155;
	            float3 _3273;
	            uint _9913;
	            uint _16209 = 0u;
	            for (;;)
	            {
	                if (!(_16209 < 4u))
	                {
	                    break;
	                }
	                uint2 _6349 = (_9668.xy * uint2(4u, 4u)) + uint2(_16209, _16208);
	                _3273 = _13156 + g_VertexLightSamples.Load<float4>(((_6349.y * _16799) + _6349.x) * 16 + 0).xyz;
	                _9913 = _16209 + 1u;
	                _13156 = _3273;
	                _16209 = _9913;
	                continue;
	            }
	            _21567 = _16208 + 1u;
	            _13155 = _13156;
	            _16208 = _21567;
	            continue;
	        }
	        float3 _13088 = max(0.0f.xxx, _13155 * 0.0625f.xxx);
	        float4 _13157;
	        _13157 = 0.0f.xxxx;
	        uint _21568;
	        float4 _13158;
	        uint _16210 = 0u;
	        for (;;)
	        {
	            if (!(_16210 < 4u))
	            {
	                break;
	            }
	            _13158 = _13157;
	            uint _8087;
	            float4 _14382;
	            uint _16211 = 0u;
	            for (;;)
	            {
	                bool _7956_ladder_break = false;
	                do
	                {
	                    if (!(_16211 < 4u))
	                    {
	                        _7956_ladder_break = true;
	                        break;
	                    }
	                    uint2 _5745 = (_9668.xy * uint2(4u, 4u)) + uint2(_16211, _16210);
	                    float3 _20166 = max(0.0f.xxx, g_VertexLightSamples.Load<float4>(((_5745.y * _16799) + _5745.x) * 16 + 0).xyz);
	                    float3 _9380 = _13088 * 8.0f;
	                    if (any(bool3(_20166.x > _9380.x, _20166.y > _9380.y, _20166.z > _9380.z)))
	                    {
	                        _14382 = _13158;
	                        break;
	                    }
	                    float2 _21157 = float2(float(_16211) + 0.5f, float(_16210) + 0.5f) * 0.25f.xx;
	                    float _17497 = sqrt(_21157.x);
	                    float _15049 = _21157.y;
	                    float3 _10701 = float3(1.0f - _17497, _17497 * (1.0f - _15049), _17497 * _15049);
	                    _14382 = _13158 + (float4(_20166, 1.0f) * _10701[_23446]);
	                    break;
	                } while(false);
	                if (_7956_ladder_break)
	                {
	                    break;
	                }
	                _8087 = _16211 + 1u;
	                _13158 = _14382;
	                _16211 = _8087;
	                continue;
	            }
	            _21568 = _16210 + 1u;
	            _13157 = _13158;
	            _16210 = _21568;
	            continue;
	        }
	        float3 _24698 = _13157.xyz / max(_13157.w, 1.0f).xxx;
	        uint _7290 = 3u * gl_GlobalInvocationID.x;
	        g_Result.Store<float>(_7290 * 4 + 0, _24698.x);
	        g_Result.Store<float>((_7290 + 1u) * 4 + 0, _24698.y);
	        g_Result.Store<float>((_7290 + 2u) * 4 + 0, _24698.z);
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
