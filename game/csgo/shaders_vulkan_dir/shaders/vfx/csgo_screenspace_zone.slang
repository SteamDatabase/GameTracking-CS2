//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "(S2) Danger zone distance field shader for CSGO.";
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
	float4 g_Const1 < UiType(VectorText); Expression(const1); >;
	float4 g_Const3 < UiType(VectorText); Expression(const3); >;
	float4 g_Const5 < UiType(VectorText); Expression(const5); >;
	float4x4 g_invViewProjMatrix < Attribute("InvViewProjMatrix"); >;
	Texture2D g_tColor1 < Channel(RGBA, None(TextureColor1), Linear); OutputFormat(BC7); SrgbRead(true); >;
	Texture2D g_tCsgoDZPRT < Attribute("DangerZoneProjectionRT"); SrgbRead(false); >;
	Texture2D g_tFrameBuffer < Attribute("FrameBuffer"); SrgbRead(false); >;
	Texture2D g_tSceneDepth < Attribute("SceneDepth"); SrgbRead(false); >;
	
	// Color
	CreateInputTexture2D(TextureColor1, Srgb, 8, "", "", "Color", Default4(1, 1, 1, 0));
	
	
	// Variant parameters
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	cbuffer PerViewConstantBuffer_t : register(b1, space1)
	{
	    float PerViewConstantBuffer_t_1_m0 : packoffset(c23);
	    float PerViewConstantBuffer_t_1_m1 : packoffset(c23.y);
	};
	
	cbuffer _Globals_ : register(b0, space1)
	{
	    float4 _Globals_1_g_Const0 : packoffset(c0);
	    float4 _Globals_1_g_Const1 : packoffset(c1);
	    float4 _Globals_1_g_Const3 : packoffset(c3);
	    float4 _Globals_1_g_Const5 : packoffset(c4);
	    column_major float4x4 _Globals_1_g_invViewProjMatrix : packoffset(c5);
	};
	
	Texture2D<float4> g_tSceneDepth : register(t33, space1);
	SamplerState AddressU_Clamp_AddressV_Clamp_Filter_MinMagMipPoint : register(s17, space1);
	Texture2D<float4> g_tCsgoDZPRT : register(t31, space1);
	SamplerState AddressU_Wrap_AddressV_Wrap_Filter_MinMagLinearMipPoint : register(s14, space1);
	Texture2D<float4> g_tColor1 : register(t30, space1);
	Texture2D<float4> g_tFrameBuffer : register(t32, space1);
	
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
	    float4 _19068 = g_tSceneDepth.Sample(AddressU_Clamp_AddressV_Clamp_Filter_MinMagMipPoint, input_0.xy);
	    float _12211 = saturate((_19068.x - PerViewConstantBuffer_t_1_m0) / (PerViewConstantBuffer_t_1_m1 - PerViewConstantBuffer_t_1_m0));
	    if ((0.99989998340606689453125f - _12211) < 0.0f)
	    {
	        discard;
	    }
	    float4 _24893 = mul(float4((input_0.x * 2.0f) - 1.0f, ((1.0f - input_0.y) * 2.0f) - 1.0f, _12211, 1.0f), _Globals_1_g_invViewProjMatrix);
	    float3 _12890 = _24893.xyz / _24893.w.xxx;
	    float _16095 = length(_Globals_1_g_Const1.xyz - _12890);
	    float2 _14979 = _12890.xy;
	    float2 _22686 = (_14979 + _Globals_1_g_Const5.xy) * _Globals_1_g_Const5.zw;
	    float4 _19069 = g_tCsgoDZPRT.Sample(AddressU_Wrap_AddressV_Wrap_Filter_MinMagLinearMipPoint, float2(_22686.x + 0.0009765625f, 1.0009765625f - _22686.y).xy);
	    float _17477 = _19069.x;
	    bool _10513 = _Globals_1_g_Const3.w > 0.0f;
	    float _10970;
	    float _15797;
	    if (_10513)
	    {
	        float _8315 = length(_Globals_1_g_Const3.xyz - _12890);
	        _10970 = _8315;
	        _15797 = min(_17477, smoothstep(_Globals_1_g_Const3.w - 250.0f, _Globals_1_g_Const3.w + 300.0f, _8315));
	    }
	    else
	    {
	        _10970 = 0.0f;
	        _15797 = _17477;
	    }
	    if ((_15797 - 0.01568627543747425079345703125f) < 0.0f)
	    {
	        discard;
	    }
	    float _11737 = _12890.z;
	    float _15977 = smoothstep(0.01568627543747425079345703125f, 0.19607843458652496337890625f, _15797 + (sin(((_11737 * 0.001000000047497451305389404296875f) + _Globals_1_g_Const0.w) * 5.0f) * 0.008000000379979610443115234375f));
	    float4 _19334 = g_tColor1.Sample(AddressU_Wrap_AddressV_Wrap_Filter_MinMagLinearMipPoint, ((_14979 * _Globals_1_g_Const5.zw) * 12.0f).xy);
	    float4 _19335 = g_tColor1.Sample(AddressU_Wrap_AddressV_Wrap_Filter_MinMagLinearMipPoint, ((_12890.xz * _Globals_1_g_Const5.zw) * 8.0f).xy);
	    float4 _20284 = g_tColor1.Sample(AddressU_Wrap_AddressV_Wrap_Filter_MinMagLinearMipPoint, ((_12890.yz * _Globals_1_g_Const5.zw) * 10.0f).xy);
	    float _12473 = (_19334.y + _19335.y) + _20284.y;
	    float _5579 = _12473 * 3.1415927410125732421875f;
	    float _22760 = lerp(saturate((sin(_12473 * 12.56637096405029296875f) * 0.5f) + 0.5f), saturate((sin(_5579) * 0.5f) + 0.5f), _15977);
	    bool _12885;
	    if (_10513)
	    {
	        _12885 = _10970 < (_Globals_1_g_Const3.w * 1.5499999523162841796875f);
	    }
	    else
	    {
	        _12885 = false;
	    }
	    float _13866;
	    if (_12885)
	    {
	        _13866 = lerp(_22760, _22760 + (sin((_22760 + _Globals_1_g_Const0.w) * 100.0f) * 0.100000001490116119384765625f), smoothstep(_Globals_1_g_Const3.w * 1.5499999523162841796875f, _Globals_1_g_Const3.w, _10970));
	    }
	    else
	    {
	        _13866 = _22760;
	    }
	    float _10763 = pow(_15977, 1.60000002384185791015625f);
	    float _17802 = saturate((_13866 + _10763) * _10763);
	    if ((_17802 - 0.00200000009499490261077880859375f) < 0.0f)
	    {
	        discard;
	    }
	    float _17460 = step(0.07999999821186065673828125f, _17802);
	    float _22112 = smoothstep(0.0f, 0.07999999821186065673828125f, _17802);
	    float4 _3300 = g_tFrameBuffer.Sample(AddressU_Wrap_AddressV_Wrap_Filter_MinMagLinearMipPoint, input_0.xy);
	    float3 _20871 = _3300.xyz;
	    float _23825 = dot(float3(0.300000011920928955078125f, 0.589999973773956298828125f, 0.10999999940395355224609375f), _20871);
	    float _3187 = (0.449999988079071044921875f * _23825) - (fmod(_23825, 0.20000000298023223876953125f) * 0.20000000298023223876953125f);
	    float3 _9366 = lerp(lerp(_3187 * 0.100000001490116119384765625f, _3187 * smoothstep(0.100000001490116119384765625f, 0.699999988079071044921875f, _17802), _17460).xxx, _3187.xxx, smoothstep(1500.0f, 5000.0f, _16095).xxx);
	    float4 _23112 = float4(_9366, _22112);
	    _23112.x = _9366.x + (((((smoothstep(1.0f, 0.0f, pow(_17802, 0.20000000298023223876953125f)) + smoothstep(0.1500000059604644775390625f, 0.0f, _17802)) * (1.0f - saturate((sin((_5579 + _Globals_1_g_Const0.w) * 20.0f) * 0.1500000059604644775390625f) + 0.1500000059604644775390625f))) * _17460) * smoothstep(4000.0f, 0.0f, _16095)) * smoothstep(1200.0f, 0.0f, abs(_Globals_1_g_Const1.z - _11737)));
	    float3 _9385 = lerp(_20871, _23112.xyz, smoothstep(6000.0f, 4000.0f, _16095).xxx);
	    float _20401 = _9385.x;
	    float4 _17842 = _23112;
	    _17842.x = _20401;
	    _17842.y = _9385.y;
	    _17842.z = _9385.z;
	    float4 _6805;
	    if (_10513)
	    {
	        _6805 = lerp(float4(_20401 * 0.100000001490116119384765625f, _20401, _20401 * 0.800000011920928955078125f, _22112 * 0.699999988079071044921875f), _17842.xyzw, smoothstep(_Globals_1_g_Const3.w - 50.0f, _Globals_1_g_Const3.w + 50.0f, _10970).xxxx);
	    }
	    else
	    {
	        _6805 = _17842;
	    }
	    output_0 = _6805;
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
