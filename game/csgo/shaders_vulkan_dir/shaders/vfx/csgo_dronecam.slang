//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "(S2) Drone camera screen space effect.";
	DevShader = false;
	Version = 1;
	
	// Platform: VULKAN_SM_50
	// Programs: ps, vs
}

MODES
{
	Default();
	CsgoForward();
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
	float3 vPositionSs : POSITION0  < Semantic( PosXyz ); >;                                      
	float2 vTexCoord   : TEXCOORD0  < Semantic( LowPrecisionUv ); >;                              
};

VS
{
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	static float4 gl_Position;
	static float2 vPositionSs;
	static float2 vTexCoord;
	static float2 output_0;
	
	struct VS_INPUT
	{
	    float2 vPositionSs : POSITION0;
	    float2 vTexCoord : TEXCOORD0;
	};
	
	struct PS_INPUT
	{
	    float2 output_0 : TEXCOORD0;
	    float4 gl_Position : SV_Position;
	};
	
	void MainVs_inner()
	{
	    float4 _14456 = float4(vPositionSs, 1.0f, 1.0f);
	    output_0 = vTexCoord;
	    _14456.y = -vPositionSs.y;
	    gl_Position = _14456;
	}
	
	PS_INPUT MainVs(VS_INPUT stage_input)
	{
	    vPositionSs = stage_input.vPositionSs;
	    vTexCoord = stage_input.vTexCoord;
	    MainVs_inner();
	    PS_INPUT stage_output;
	    stage_output.gl_Position = gl_Position;
	    stage_output.output_0 = output_0;
	    return stage_output;
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
}

PS
{
	DynamicCombo( D_MSAA_DEPTH_BUFFER, 0..1 );
	
	float4 g_Const0 < UiType(VectorText); Expression(const0); >;
	Texture2D g_tFrameBuffer < Attribute("FrameBuffer"); SrgbRead(false); >;
	Texture2D g_tNoise < Channel(RGBA, None(TextureNoise), Linear); OutputFormat(BC7); SrgbRead(true); >;
	
	// Color
	CreateInputTexture2D(TextureNoise, Srgb, 8, "", "", "Color", Default4(1, 1, 1, 0));
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	cbuffer _Globals_ : register(b0, space1)
	{
	    float4 _Globals_1_g_Const0 : packoffset(c0);
	};
	
	Texture2D<float4> g_tNoise : register(t30, space1);
	SamplerState AddressU_Clamp_AddressV_Clamp_Filter_MinMagMipPoint : register(s15, space1);
	Texture2D<float4> g_tFrameBuffer : register(t31, space1);
	
	static float2 input_0;
	static float4 output_0;
	
	struct PS_INPUT
	{
	    float2 input_0 : TEXCOORD0;
	};
	
	struct PS_OUTPUT
	{
	    float4 output_0 : SV_Target0;
	};
	
	void MainPs_inner()
	{
	    float2 _3363 = input_0 - 0.5f.xx;
	    float _24990 = length(_3363);
	    float2 _4328 = (((input_0 + (normalize(_3363) * pow(_24990, 5.0f))) - 0.5f.xx) * float2(1.0499999523162841796875f, 1.10000002384185791015625f)) + 0.5f.xx;
	    float _14384 = clamp(smoothstep(0.20000000298023223876953125f, 0.60000002384185791015625f, _24990) * 0.004999999888241291046142578125f, 9.9999999747524270787835121154785e-07f, 0.004999999888241291046142578125f);
	    float _6250 = _4328.x;
	    float _10920 = _6250 - fmod(_6250, _14384);
	    float _17855 = _4328.y;
	    float _9668 = _17855 - fmod(_17855, _14384);
	    float4 _19372 = g_tNoise.Sample(AddressU_Clamp_AddressV_Clamp_Filter_MinMagMipPoint, float2(_10920 + _Globals_1_g_Const0.y, _9668 + _Globals_1_g_Const0.z).xy);
	    float _5582 = _19372.x * _Globals_1_g_Const0.x;
	    float4 _3300 = g_tFrameBuffer.Sample(AddressU_Clamp_AddressV_Clamp_Filter_MinMagMipPoint, (float2(_10920, _9668) + (_5582 * 0.00999999977648258209228515625f).xx).xy);
	    float3 _8371 = _5582.xxx;
	    float3 _21602 = lerp(_3300.xyz + _8371, _8371, _Globals_1_g_Const0.x.xxx);
	    float3 _6979 = lerp(_21602, dot(_21602, float3(0.300000011920928955078125f, 0.589999973773956298828125f, 0.10999999940395355224609375f)).xxx, 0.60000002384185791015625f.xxx) * (abs(sin(_17855 * 900.0f) * 0.300000011920928955078125f) + 0.800000011920928955078125f);
	    float _15630 = _6979.x;
	    float _10921 = _15630 - fmod(_15630, 0.02999999932944774627685546875f);
	    float _17856 = _6979.y;
	    float _10922 = _17856 - fmod(_17856, 0.02999999932944774627685546875f);
	    float _17857 = _6979.z;
	    float3 _9233 = float3(_10921, _10922, _17857 - fmod(_17857, 0.02999999932944774627685546875f));
	    float3 _17505;
	    if (_10921 > (_10922 * 2.0f))
	    {
	        float3 _21219 = _9233;
	        _21219.x = _10921 * 3.0f;
	        _17505 = _21219;
	    }
	    else
	    {
	        _17505 = _9233;
	    }
	    output_0 = float4(_17505 * (((smoothstep(0.0f, 0.004999999888241291046142578125f, _6250) * smoothstep(1.0f, 0.99500000476837158203125f, _6250)) * smoothstep(0.0f, 0.004999999888241291046142578125f, _17855)) * smoothstep(1.0f, 0.99500000476837158203125f, _17855)), 1.0f);
	}
	
	PS_OUTPUT MainPs(PS_INPUT stage_input)
	{
	    input_0 = stage_input.input_0;
	    MainPs_inner();
	    PS_OUTPUT stage_output;
	    stage_output.output_0 = output_0;
	    return stage_output;
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
}
