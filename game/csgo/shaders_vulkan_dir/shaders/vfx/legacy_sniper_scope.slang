//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Legacy Sniper Scope";
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
	float3 vPositionSs : POSITION0  < Semantic( PosXyz ); >;                                      
};

VS
{
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	static float4 gl_Position;
	static float3 vPositionSs;
	
	struct VS_INPUT
	{
	    float3 vPositionSs : POSITION0;
	};
	
	struct PS_INPUT
	{
	    float4 gl_Position : SV_Position;
	};
	
	void MainVs_inner()
	{
	    float4 _22489 = float4(vPositionSs, 1.0f);
	    _22489.y = -vPositionSs.y;
	    gl_Position = _22489;
	}
	
	PS_INPUT MainVs(VS_INPUT stage_input)
	{
	    vPositionSs = stage_input.vPositionSs;
	    MainVs_inner();
	    PS_INPUT stage_output;
	    stage_output.gl_Position = gl_Position;
	    return stage_output;
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
}

PS
{
	
	float g_flSniperScopeInaccuracy < Attribute("LegacySniperScopeInaccuracy"); UiType(Slider); >;
	int g_nSniperScopeLineWidth < Default(1); Attribute("LegacySniperScopeLineWidth"); UiType(Slider); >;
	int g_nSpreadGap < Attribute("LegacySniperScopeSpreadGap"); UiType(Slider); >;
	Texture2D g_tFramebuffer < Attribute("FramebufferInput"); SrgbRead(true); >;
	float2 g_vSniperScopeBob < Attribute("LegacySniperScopeBob"); UiType(VectorText); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	static float4 _3;
	
	cbuffer PerViewConstantBuffer_t : register(b1, space1)
	{
	    float2 PerViewConstantBuffer_t_1_m0 : packoffset(c19);
	    float2 PerViewConstantBuffer_t_1_m1 : packoffset(c20);
	    float2 PerViewConstantBuffer_t_1_m2 : packoffset(c20.z);
	    float2 PerViewConstantBuffer_t_1_m3 : packoffset(c21);
	};
	
	cbuffer _Globals_ : register(b0, space1)
	{
	    float2 _Globals_1_g_vSniperScopeBob : packoffset(c0);
	    float _Globals_1_g_flSniperScopeInaccuracy : packoffset(c0.z);
	    uint _Globals_1_g_nSniperScopeLineWidth : packoffset(c0.w);
	    int _Globals_1_g_nSpreadGap : packoffset(c1);
	};
	
	Texture2D<float4> g_tFramebuffer : register(t30, space1);
	SamplerState DefaultSamplerState_0 : register(s14, space1);
	
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
	    float2 _20667 = ((gl_FragCoord.xy - PerViewConstantBuffer_t_1_m1.xy).xy * PerViewConstantBuffer_t_1_m3.xy).xy;
	    float2 _23227 = _20667 - 0.5f.xx;
	    _23227.x = _23227.x * (PerViewConstantBuffer_t_1_m3.y / PerViewConstantBuffer_t_1_m3.x);
	    float2 _6516 = _23227 - ((_Globals_1_g_vSniperScopeBob * PerViewConstantBuffer_t_1_m3.y) * (-1.2000000476837158203125f));
	    float2 _21645 = normalize(_6516);
	    float _13515 = length(_6516);
	    float _20294 = saturate(_Globals_1_g_flSniperScopeInaccuracy * 2.0f);
	    float _22510 = lerp(0.425000011920928955078125f, 0.37999999523162841796875f, _20294);
	    float _24850 = smoothstep(_22510, _22510 - 0.02999999932944774627685546875f, _13515);
	    float2 _11926 = _20667 + (_21645 * pow(_13515, 6.0f));
	    float _10696 = smoothstep(_22510 - 0.039999999105930328369140625f, _22510, _13515);
	    float2 _12302 = lerp(_11926, _11926 + (((_21645 * _10696) * _10696) * 0.0500000007450580596923828125f), _10696.xx);
	    float2 _13072 = (_21645 * pow(smoothstep(0.0500000007450580596923828125f, 1.0f, _13515), 0.5f)) * 0.5f;
	    float4 _20531 = g_tFramebuffer.Sample(DefaultSamplerState_0, (PerViewConstantBuffer_t_1_m0 * (_12302 - (_13072 * 0.014999999664723873138427734375f))).xy);
	    float4 _20532 = g_tFramebuffer.Sample(DefaultSamplerState_0, (PerViewConstantBuffer_t_1_m0 * (_12302 - (_13072 * 0.0199999995529651641845703125f))).xy);
	    float4 _19353 = g_tFramebuffer.Sample(DefaultSamplerState_0, (PerViewConstantBuffer_t_1_m0 * (_12302 - (_13072 * 0.02500000037252902984619140625f))).xy);
	    float2 _3944 = ((PerViewConstantBuffer_t_1_m2.xy * 0.5f.xx) + 0.25f.xx) + ((_Globals_1_g_vSniperScopeBob * _20294) * (-4.0f));
	    float2 _12478 = float2(PerViewConstantBuffer_t_1_m2.x, 0.0f);
	    float2 _8175 = _3944 - _12478;
	    float2 _18274 = _3944 + _12478;
	    float _9054;
	    do
	    {
	        float2 _19537 = _18274 - _8175;
	        float2 _18013 = gl_FragCoord.xy - _8175;
	        float _11853 = dot(_18013, _19537);
	        if (_11853 <= 0.0f)
	        {
	            _9054 = length(_18013);
	            break;
	        }
	        float _23231 = dot(_19537, _19537);
	        if (_23231 <= _11853)
	        {
	            _9054 = length(gl_FragCoord.xy - _18274);
	            break;
	        }
	        _9054 = length(gl_FragCoord.xy - (_8175 + (_19537 * (_11853 / _23231))));
	        break;
	    } while(false);
	    float _17142 = max(0.5f, float(_Globals_1_g_nSniperScopeLineWidth) * 0.5f);
	    float _17319 = (_17142 + max(0.0f, (PerViewConstantBuffer_t_1_m2.y * 0.100000001490116119384765625f) * _20294)) + 0.25f;
	    float2 _24718 = float2(0.0f, PerViewConstantBuffer_t_1_m2.y);
	    float2 _9827 = _3944 - _24718;
	    float2 _18275 = _3944 + _24718;
	    float _19755;
	    do
	    {
	        float2 _19538 = _18275 - _9827;
	        float2 _18014 = gl_FragCoord.xy - _9827;
	        float _11854 = dot(_18014, _19538);
	        if (_11854 <= 0.0f)
	        {
	            _19755 = length(_18014);
	            break;
	        }
	        float _23232 = dot(_19538, _19538);
	        if (_23232 <= _11854)
	        {
	            _19755 = length(gl_FragCoord.xy - _18275);
	            break;
	        }
	        _19755 = length(gl_FragCoord.xy - (_9827 + (_19538 * (_11854 / _23232))));
	        break;
	    } while(false);
	    float _15651 = saturate(smoothstep(_17142, _17319, _9054) * smoothstep(_17142, _17319, _19755));
	    float _11689;
	    if (_Globals_1_g_nSpreadGap > 0)
	    {
	        float2 _12197 = _3944 + 0.25f.xx;
	        float2 _15043;
	        if ((_Globals_1_g_nSniperScopeLineWidth % 2u) == 0u)
	        {
	            _15043 = _12197.xy - 0.5f.xx;
	        }
	        else
	        {
	            _15043 = _12197;
	        }
	        float _4637 = float(_Globals_1_g_nSpreadGap);
	        float _25218 = smoothstep(_4637 + 0.5f, _4637, distance(gl_FragCoord.xy, _15043));
	        _11689 = lerp(saturate(_15651 + (_25218 * 0.5f)) + (_25218 * 0.02999999932944774627685546875f), _15651, smoothstep(0.0f, 0.0199999995529651641845703125f, _20294));
	    }
	    else
	    {
	        _11689 = _15651;
	    }
	    float3 _15449 = float4(float3(_20531.x, _20532.y, _19353.z) * smoothstep(0.550000011920928955078125f, 0.20000000298023223876953125f, _13515), _24850).xyz;
	    float3 _14959 = lerp(_15449, _15449 * _11689, saturate(lerp(1.0f, 0.300000011920928955078125f, pow(_20294, 0.300000011920928955078125f))).xxx);
	    float4 _17842;
	    _17842.x = _14959.x;
	    _17842.y = _14959.y;
	    _17842.z = _14959.z;
	    output_0 = float4(_17842.xyz * _24850, 1.0f);
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
