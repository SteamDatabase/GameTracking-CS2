//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Player Visibility Postprocess";
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
	DynamicCombo( D_DATA_COLOR_MSAA, 0..1 );
	
	RenderState(StencilRef, 1);
	float g_flPlayerVisStrength < Default(0.8); Attribute("PlayerVisStrength"); UiType(Slider); >;
	Texture2D g_tDataColor < Attribute("DataColor"); SrgbRead(true); >;
	Texture2D g_tWithPlayers < Attribute("WithPlayers"); SrgbRead(false); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	static const float _2029[16] = { 0.0228166244924068450927734375f, 0.0483712442219257354736328125f, 0.0483712442219257354736328125f, 0.0228166244924068450927734375f, 0.0483712442219257354736328125f, 0.0994804799556732177734375f, 0.130440890789031982421875f, 0.07933165132999420166015625f, 0.0483712442219257354736328125f, 0.0994804799556732177734375f, 0.130440890789031982421875f, 0.07933165132999420166015625f, 0.0228166244924068450927734375f, 0.0483712442219257354736328125f, 0.0483712442219257354736328125f, 0.0228166244924068450927734375f };
	
	cbuffer PerViewConstantBuffer_t : register(b1, space1)
	{
	    float4 PerViewConstantBuffer_t_1_m0 : packoffset(c22);
	};
	
	cbuffer _Globals_ : register(b0, space1)
	{
	    float _Globals_1_g_flPlayerVisStrength : packoffset(c0);
	};
	
	Texture2D<float4> g_tWithPlayers : register(t30, space1);
	SamplerState Filter_MinMagLinearMipPoint : register(s14, space1);
	Texture2D<float4> g_tDataColor : register(t31, space1);
	SamplerState Filter_MinMagLinearMipPoint_1 : register(s15, space1);
	
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
	    float2 _21103 = gl_FragCoord.xy * PerViewConstantBuffer_t_1_m0.xy;
	    float _16123 = _21103.x;
	    float _25068 = _21103.y;
	    float _13136;
	    float _16305;
	    float _17114;
	    float _17115;
	    float _17116;
	    float3 _17117;
	    float _17118;
	    float3 _17133;
	    _13136 = 0.0f;
	    _16305 = 0.0f;
	    _17114 = 1.0f;
	    _17115 = 0.0f;
	    _17116 = 0.0f;
	    _17117 = 0.0f.xxx;
	    _17118 = 0.0f;
	    _17133 = 0.0f.xxx;
	    int _21567;
	    float _13137;
	    float _16306;
	    float _17119;
	    float _17120;
	    float3 _17121;
	    float3 _17122;
	    float _17123;
	    float _17134;
	    int _17017 = 0;
	    for (;;)
	    {
	        if (!(_17017 < 4))
	        {
	            break;
	        }
	        _13137 = _13136;
	        _16306 = _17114;
	        _17119 = _17116;
	        _17120 = _16305;
	        _17121 = _17133;
	        _17122 = _17117;
	        _17123 = _17115;
	        _17134 = _17118;
	        float _3716;
	        float _5207;
	        float3 _6508;
	        float _14736;
	        float _17524;
	        float _18833;
	        int _19265;
	        float _22212;
	        float3 _22803;
	        int _17018 = 0;
	        for (;;)
	        {
	            if (!(_17018 < 4))
	            {
	                break;
	            }
	            float4 _20506 = float4(-3.5f, -1.5f, 1.5f, 2.5f);
	            float4 _23892 = float4(-3.5f, -1.5f, 1.5f, 2.5f);
	            float2 _12974 = (_21103.xy + (float2(_20506[_17017], _23892[_17018]) * PerViewConstantBuffer_t_1_m0.xy)).xy;
	            float4 _18109 = g_tDataColor.Sample(Filter_MinMagLinearMipPoint_1, _12974);
	            float _23523 = _18109.x;
	            float _17655 = step(9.9999997473787516355514526367188e-06f, _23523);
	            _3716 = _17123 + (_17655 * _2029[(_17017 * 4) + _17018]);
	            float3 _23291 = g_tWithPlayers.Sample(Filter_MinMagLinearMipPoint, _12974).xyz;
	            _6508 = _17122.xyz + (_23291 * (1.0f - _17655));
	            _22803 = _17121.xyz + (_23291 * _17655);
	            _17524 = max(_17120, _18109.y);
	            _18833 = max(_17119, _18109.z);
	            _22212 = min(_16306, _18109.w);
	            _14736 = max(_13137, _23523);
	            _5207 = _17134 + _17655;
	            _19265 = _17018 + 1;
	            _13137 = _14736;
	            _16306 = _22212;
	            _17119 = _18833;
	            _17120 = _17524;
	            _17121 = _22803;
	            _17122 = _6508;
	            _17123 = _3716;
	            _17134 = _5207;
	            _17018 = _19265;
	            continue;
	        }
	        _21567 = _17017 + 1;
	        _13136 = _13137;
	        _16305 = _17120;
	        _17114 = _16306;
	        _17115 = _17123;
	        _17116 = _17119;
	        _17117 = _17122;
	        _17118 = _17134;
	        _17133 = _17121;
	        _17017 = _21567;
	        continue;
	    }
	    float3 _6923 = _17133.xyz / max(1.0f, _17118).xxx;
	    float3 _7136 = _17117.xyz / max(1.0f, 16.0f - _17118).xxx;
	    float _14232 = min(min(1.0f, _17118), 1.0f - _17116);
	    float2 _8764 = _21103.xy;
	    float4 _19372 = g_tDataColor.Sample(Filter_MinMagLinearMipPoint_1, _8764);
	    float _16000 = _19372.x;
	    float4 _3300 = g_tWithPlayers.Sample(Filter_MinMagLinearMipPoint, _8764);
	    float _7796 = dot(_7136.xyz, float3(0.2125000059604644775390625f, 0.7153999805450439453125f, 0.07209999859333038330078125f));
	    float _12193 = dot(_6923.xyz, float3(0.2125000059604644775390625f, 0.7153999805450439453125f, 0.07209999859333038330078125f));
	    float _4884 = _7796 - _12193;
	    float3 _22537 = _7136.xyz;
	    float _14451 = step(9.9999997473787516355514526367188e-06f, _16000);
	    float _5998 = (float(min(min(min(min(_16000, g_tDataColor.Sample(Filter_MinMagLinearMipPoint_1, float2(_16123 + PerViewConstantBuffer_t_1_m0.x, _25068).xy).x), g_tDataColor.Sample(Filter_MinMagLinearMipPoint_1, float2(_16123 - PerViewConstantBuffer_t_1_m0.x, _25068).xy).x), g_tDataColor.Sample(Filter_MinMagLinearMipPoint_1, float2(_16123, _25068 + PerViewConstantBuffer_t_1_m0.y).xy).x), g_tDataColor.Sample(Filter_MinMagLinearMipPoint_1, float2(_16123, _25068 - PerViewConstantBuffer_t_1_m0.y).xy).x) == 0.0f) * _14451) * _14232;
	    float3 _14188 = lerp(lerp(lerp(_22537, max(0.0f.xxx, (normalize(max(_22537, 0.001000000047497451305389404296875f.xxx)) * ((_7796 + max(0.0f, _4884 * 4.0f)) + min(0.0f, _4884 * 2.0f))).xyz).xyz, (((lerp(_17115 * _17115, 1.0f, _17114 * _14232) * pow(1.0f - saturate(abs(_4884) * smoothstep(0.699999988079071044921875f, 0.25f, _7796 * _12193)), 8.0f)) * _Globals_1_g_flPlayerVisStrength) * _14232).xxx), _3300.xyz, max(_14451, _5998).xxx), _3300.xyz + (((_6923.xyz - _22537) * 0.25f) * _Globals_1_g_flPlayerVisStrength), _5998.xxx);
	    float _24197 = _14188.x;
	    float4 _10432 = float4(_24197, _14188.yz, (((1.0f / max(1.0f, 8.0f - _17118)) * (_16305 * smoothstep(0.0599999986588954925537109375f, 0.4000000059604644775390625f, _14232))) * _17114) * _13136);
	    float3 _21152 = clamp(_10432.xyz, 0.0f.xxx, max(max(_24197, _14188.y), _14188.z).xxx);
	    float4 _13514 = _10432;
	    _13514.x = _21152.x;
	    _13514.y = _21152.y;
	    _13514.z = _21152.z;
	    output_0 = _13514;
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
