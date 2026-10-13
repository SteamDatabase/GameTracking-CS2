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
	StaticCombo( S_LIGHTMAP_TYPE, F_LIGHTMAP_TYPE );
	DynamicCombo( D_COMPRESSED_NORMALS_AND_TANGENTS, 0..1 );
	
	RWTexture3D<float4> g_BlockConverged < Attribute("g_BlockConverged"); >;
	StructuredBuffer g_LpvLuxels < Attribute("g_LpvLuxels"); >;
	StructuredBuffer g_Luxels < Attribute("g_Luxels"); >;
	StructuredBuffer g_VertexLightSamples < Attribute("g_VertexLightSamples"); >;
	float g_flErrorTolerance < Attribute("g_flErrorTolerance"); UiType(Slider); >;
	int g_nBlockHeight < Attribute("g_nBlockHeight"); UiType(Slider); >;
	int g_nBlockWidth < Attribute("g_nBlockWidth"); UiType(Slider); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	struct _427
	{
	    float4 _m0;
	    float4 _m1;
	    float4 _m2;
	    float4 _m3;
	    float4 _m4;
	    float4 _m5;
	    float4 _m6;
	    float4 _m7;
	    float4 _m8;
	    float4 _m9;
	    int4 _m10;
	    float4 _m11;
	    float4 _m12;
	    float4 _m13;
	};
	
	cbuffer _Globals_ : register(b0, space0)
	{
	    int _Globals_1_g_nBlockWidth : packoffset(c0);
	    int _Globals_1_g_nBlockHeight : packoffset(c0.y);
	    float _Globals_1_g_flErrorTolerance : packoffset(c0.z);
	};
	
	ByteAddressBuffer g_Luxels : register(t30, space0);
	RWTexture3D<uint> g_BlockConverged : register(u158, space0);
	
	static uint3 gl_GlobalInvocationID;
	static uint gl_LocalInvocationIndex;
	struct SPIRV_Cross_Input
	{
	    uint3 gl_GlobalInvocationID : SV_DispatchThreadID;
	    uint gl_LocalInvocationIndex : SV_GroupIndex;
	};
	
	void MainCs_inner()
	{
	    bool _24472;
	    do
	    {
	        if (_Globals_1_g_flErrorTolerance <= 0.0f)
	        {
	            _24472 = false;
	            break;
	        }
	        uint _15834 = uint(_Globals_1_g_nBlockWidth);
	        uint _10826 = (((gl_GlobalInvocationID.z * _15834) * uint(_Globals_1_g_nBlockHeight)) + (gl_GlobalInvocationID.y * _15834)) + gl_GlobalInvocationID.x;
	        bool _6817 = g_Luxels.Load<float4>(_10826 * 224 + 0).w > 0.0f;
	        int _12919 = WaveActiveSum(int(_6817));
	        if (_12919 == 0)
	        {
	            _24472 = true;
	            break;
	        }
	        else
	        {
	            if (_12919 <= 2)
	            {
	                _24472 = false;
	                break;
	            }
	        }
	        float3 _20940;
	        if (_6817)
	        {
	            _20940 = g_Luxels.Load<float4>(_10826 * 224 + 0).xyz;
	        }
	        else
	        {
	            _20940 = 0.0f.xxx;
	        }
	        float _22462 = dot(_20940.xyz, float3(0.2125000059604644775390625f, 0.7153999805450439453125f, 0.07209999859333038330078125f));
	        float _18595 = float(_12919);
	        float _12151 = WaveActiveSum(_22462) / _18595;
	        _24472 = !(sqrt(abs((WaveActiveSum(_22462 * _22462) / _18595) - (_12151 * _12151))) > (_12151 * _Globals_1_g_flErrorTolerance));
	        break;
	    } while(false);
	    if (gl_LocalInvocationIndex == 0u)
	    {
	        g_BlockConverged[gl_GlobalInvocationID / uint3(4u, 4u, 1u)] = uint(int(_24472)).x;
	    }
	}
	
	[numthreads(4, 4, 1)]
	void MainCs(SPIRV_Cross_Input stage_input)
	{
	    gl_GlobalInvocationID = stage_input.gl_GlobalInvocationID;
	    gl_LocalInvocationIndex = stage_input.gl_LocalInvocationIndex;
	    MainCs_inner();
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
}
