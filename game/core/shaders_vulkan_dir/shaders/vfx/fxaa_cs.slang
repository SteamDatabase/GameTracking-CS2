//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "FXAA Compute Shader";
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
	DynamicCombo( D_PASS, 0..3 );
	DynamicCombo( D_QUALITY, 0..1 );
	
	RWTexture2D<float4> DstColor < Attribute("OutputTexture"); >;
	RWBuffer<float4> g_ColorQueue < Attribute("ColorQueueBuffer"); >;
	RWBuffer<float4> g_IndirectDispatchParams < Attribute("DispatchParamBuffer"); >;
	RWBuffer<float4> g_WorkCount < Attribute("WorkCountBuffer"); >;
	RWBuffer<float4> g_WorkQueue < Attribute("WorkQueueBuffer"); >;
	Texture2D g_tColor < Attribute("InputTexture"); SrgbRead(false); >;
	RWTexture2D<float4> g_tLuma < Attribute("LumaOutputTexture"); >;
	Texture2D g_tLuma < Attribute("LumaTexture"); SrgbRead(false); >;
	
	
	// Variant parameters
	RWTexture2D<float4> g_tLuma < Attribute("LumaOutputTexture"); >;
	Texture2D g_tLuma < Attribute("LumaTexture"); SrgbRead(false); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	static float4 _6;
	
	cbuffer FxaaConstants_t : register(b1, space0)
	{
	    float FxaaConstants_t_1_m0 : packoffset(c0.z);
	    float FxaaConstants_t_1_m1 : packoffset(c0.w);
	    uint2 FxaaConstants_t_1_m2 : packoffset(c1);
	    uint FxaaConstants_t_1_m3 : packoffset(c1.z);
	};
	
	Texture2D<float4> g_tColor : register(t30, space0);
	RWTexture2D<unorm float> g_tLuma : register(u162, space0);
	RWBuffer<uint> g_WorkCount : register(u158, space0);
	RWBuffer<uint> g_WorkQueue : register(u159, space0);
	RWBuffer<float> g_ColorQueue : register(u160, space0);
	
	static uint3 gl_WorkGroupID;
	static uint3 gl_LocalInvocationID;
	static uint3 gl_GlobalInvocationID;
	static uint gl_LocalInvocationIndex;
	struct SPIRV_Cross_Input
	{
	    uint3 gl_WorkGroupID : SV_GroupID;
	    uint3 gl_LocalInvocationID : SV_GroupThreadID;
	    uint3 gl_GlobalInvocationID : SV_DispatchThreadID;
	    uint gl_LocalInvocationIndex : SV_GroupIndex;
	};
	
	groupshared float _5396[100];
	
	void MainCs_inner()
	{
	    do
	    {
	        uint2 _3873 = gl_GlobalInvocationID.xy + FxaaConstants_t_1_m2;
	        if (gl_LocalInvocationIndex < 50u)
	        {
	            uint2 _19079 = ((FxaaConstants_t_1_m2 + uint2(gl_LocalInvocationIndex % 10u, gl_LocalInvocationIndex / 10u)) + (gl_WorkGroupID.xy * uint2(8u, 8u))) - uint2(1u, 1u);
	            float _21479 = log2(1.0f + (dot(g_tColor.Load(int3(_19079, 0)).xyz, float3(0.21267099678516387939453125f, 0.71516001224517822265625f, 0.072168998420238494873046875f)) * 15.0f)) * 0.25f;
	            g_tLuma[_19079] = _21479.x;
	            _5396[gl_LocalInvocationIndex] = _21479;
	            uint2 _19343 = uint2(int2(_19079) + int2(0, 5));
	            float _21480 = log2(1.0f + (dot(g_tColor.Load(int3(_19343, 0)).xyz, float3(0.21267099678516387939453125f, 0.71516001224517822265625f, 0.072168998420238494873046875f)) * 15.0f)) * 0.25f;
	            g_tLuma[_19343] = _21480.x;
	            _5396[gl_LocalInvocationIndex + 50u] = _21480;
	        }
	        GroupMemoryBarrierWithGroupSync();
	        uint _4614 = (gl_LocalInvocationID.x + 1u) + ((gl_LocalInvocationID.y + 1u) * 10u);
	        uint _10215 = _4614 - 10u;
	        uint _16333 = _4614 - 1u;
	        float _4459 = _5396[_4614];
	        uint _13648 = _4614 + 1u;
	        uint _13649 = _4614 + 10u;
	        float _4466 = max(max(_5396[_10215], _5396[_16333]), max(_5396[_13648], max(_5396[_13649], _4459))) - min(min(_5396[_10215], _5396[_16333]), min(_5396[_13648], min(_5396[_13649], _4459)));
	        if (_4466 < FxaaConstants_t_1_m0)
	        {
	            break;
	        }
	        uint _16811 = _4614 - 11u;
	        uint _13650 = _4614 + 4294967287u;
	        uint _13651 = _4614 + 9u;
	        uint _13652 = _4614 + 11u;
	        float _4332 = _5396[_10215] + _5396[_13649];
	        float _4366 = _5396[_16333] + _5396[_13648];
	        float _4079 = _5396[_16811] + _5396[_13651];
	        float _3549 = _5396[_13650] + _5396[_13652];
	        float _15085 = 2.0f * _4459;
	        bool _17147 = ((abs(_4079 - (2.0f * _5396[_16333])) + (abs(_4332 - _15085) * 2.0f)) + abs(_3549 - (2.0f * _5396[_13648]))) >= ((abs((_5396[_13651] + _5396[_13652]) - (2.0f * _5396[_13649])) + (abs(_4366 - _15085) * 2.0f)) + abs((_5396[_16811] + _5396[_13650]) - (2.0f * _5396[_10215])));
	        uint _5884 = uint(int(abs((_17147 ? _5396[_13649] : _5396[_13648]) - _4459) >= abs((_17147 ? _5396[_10215] : _5396[_16333]) - _4459)));
	        uint _4421 = (((_3873.y << uint(20)) | (_3873.x << uint(8))) | (uint(saturate((pow(smoothstep(0.0f, 1.0f, abs((((((_4332 + _4366) * 2.0f) + _4079) + _3549) * 0.083333335816860198974609375f) - _4459) / _4466), 2.0f) * FxaaConstants_t_1_m1) * 2.0f) * 254.0f) & 254u)) | _5884;
	        if (_17147)
	        {
	            uint _7294;
	            InterlockedAdd(g_WorkCount[0u], 1u, _7294);
	            g_WorkQueue[_7294] = _4421.x;
	            float4 _14651 = g_tColor.Load(int3(_3873 + uint2(0u, (2u * _5884) - 1u), 0));
	            uint _16572 = 3u * _7294;
	            g_ColorQueue[_16572] = _14651.x.x;
	            g_ColorQueue[_16572 + 1u] = _14651.y.x;
	            g_ColorQueue[_16572 + 2u] = _14651.z.x;
	        }
	        else
	        {
	            uint _6241;
	            InterlockedAdd(g_WorkCount[1u], 1u, _6241);
	            uint _4591 = FxaaConstants_t_1_m3 - _6241;
	            g_WorkQueue[_4591] = _4421.x;
	            float4 _14652 = g_tColor.Load(int3(_3873 + uint2((2u * _5884) - 1u, 0u), 0));
	            uint _16573 = 3u * _4591;
	            g_ColorQueue[_16573] = _14652.x.x;
	            g_ColorQueue[_16573 + 1u] = _14652.y.x;
	            g_ColorQueue[_16573 + 2u] = _14652.z.x;
	        }
	        break;
	    } while(false);
	}
	
	[numthreads(8, 8, 1)]
	void MainCs(SPIRV_Cross_Input stage_input)
	{
	    gl_WorkGroupID = stage_input.gl_WorkGroupID;
	    gl_LocalInvocationID = stage_input.gl_LocalInvocationID;
	    gl_GlobalInvocationID = stage_input.gl_GlobalInvocationID;
	    gl_LocalInvocationIndex = stage_input.gl_LocalInvocationIndex;
	    MainCs_inner();
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
}
