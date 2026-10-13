//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Edge-Avoiding A-Trous wavelet filter";
	DevShader = true;
	Version = 0;
	
	// Platform: VULKAN_SM_50
	// Programs: ps, vs
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

struct VS_INPUT
{
	float3 vPositionPs : POSITION0  < Semantic( PosXyz ); >;                                      
};

VS
{
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	static float4 gl_Position;
	static float2 vPositionPs;
	
	struct VS_INPUT
	{
	    float2 vPositionPs : POSITION0;
	};
	
	struct PS_INPUT
	{
	    float4 gl_Position : SV_Position;
	};
	
	void MainVs_inner()
	{
	    float4 _22489 = float4(vPositionPs, 0.0f, 1.0f);
	    _22489.y = -vPositionPs.y;
	    gl_Position = _22489;
	}
	
	PS_INPUT MainVs(VS_INPUT stage_input)
	{
	    vPositionPs = stage_input.vPositionPs;
	    MainVs_inner();
	    PS_INPUT stage_output;
	    stage_output.gl_Position = gl_Position;
	    return stage_output;
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
}

PS
{
	
	Texture2D g_tInputDepth < Attribute("InputDepth"); SrgbRead(false); >;
	Texture2D g_tInputNormal < Attribute("InputNormal"); SrgbRead(false); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	static float3 _3;
	
	cbuffer PerViewConstantBuffer_t : register(b1, space1)
	{
	    float3 PerViewConstantBuffer_t_1_m0 : packoffset(c29);
	};
	
	Texture2D<float4> g_tInputDepth : register(t30, space1);
	Texture2D<float4> g_tInputNormal : register(t31, space1);
	
	static float4 gl_FragCoord;
	static float4 output_0;
	
	struct PS_INPUT
	{
	    float4 gl_FragCoord : SV_Position;
	};
	
	struct PS_OUTPUT
	{
	    float4 output_0 : SV_Target0;
	};
	
	void MainPs_inner()
	{
	    int2 _11700 = int3(int2(gl_FragCoord.xy), 0).xy;
	    float3 _5393 = (g_tInputNormal.Load(int3(_11700, 0)).xyz * 2.0f) - 1.0f.xxx;
	    float _16670 = abs(PerViewConstantBuffer_t_1_m0.x / ((PerViewConstantBuffer_t_1_m0.y * g_tInputDepth.Load(int3(_11700, 0)).x) + PerViewConstantBuffer_t_1_m0.z));
	    float _24644 = ddx(_16670);
	    float _21601 = ddy(_16670);
	    float3 _19000 = _5393 / ((abs(_5393.x) + abs(_5393.y)) + abs(_5393.z)).xxx;
	    float2 _19340;
	    if (_19000.z >= 0.0f)
	    {
	        _19340 = _19000.xy;
	    }
	    else
	    {
	        float2 _8488 = _19000.xy;
	        bool2 _19837 = bool2(_8488.x >= 0.0f.xx.x, _8488.y >= 0.0f.xx.y);
	        _19340 = (1.0f.xx - abs(_19000.yx)) * float2(_19837.x ? 1.0f.xx.x : (-1.0f).xx.x, _19837.y ? 1.0f.xx.y : (-1.0f).xx.y);
	    }
	    float3 _23944;
	    _23944.x = _19340.x;
	    _23944.y = _19340.y;
	    output_0 = float4(_16670, max(abs(_24644), abs(_21601)), (_23944.xy * 0.5f) + 0.5f.xx);
	}
	
	PS_OUTPUT MainPs(PS_INPUT stage_input)
	{
	    gl_FragCoord = stage_input.gl_FragCoord;
	    gl_FragCoord.w = 1.0 / gl_FragCoord.w;
	    MainPs_inner();
	    PS_OUTPUT stage_output;
	    stage_output.output_0 = output_0;
	    return stage_output;
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
}
