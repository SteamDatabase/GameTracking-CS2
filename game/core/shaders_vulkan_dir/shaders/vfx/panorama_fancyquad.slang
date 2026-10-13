//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Used for panorama fancy quad";
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
	float3 vPositionSs            : POSITION0  < Semantic( PosXyz ); >;                           
	float2 vTexcoordgradientcoord : TEXCOORD0  < Semantic( LowPrecisionUv ); >;                   
	float2 vOutercornercoord0     : TEXCOORD1  < Semantic( LowPrecisionUv ); >;                   
	float2 vOutercornercoord1     : TEXCOORD2  < Semantic( LowPrecisionUv ); >;                   
	float2 vColor0                : TEXCOORD3  < Semantic( LowPrecisionUv ); >;                   
	float2 vColor1                : TEXCOORD4  < Semantic( LowPrecisionUv ); >;                   
	float2 vInnercornercoord0     : TEXCOORD5  < Semantic( LowPrecisionUv ); >;                   
	float2 vInnercornercoord1     : TEXCOORD6  < Semantic( LowPrecisionUv ); >;                   
	float2 vOpacitytexcoord       : TEXCOORD7  < Semantic( LowPrecisionUv ); >;                   
};

VS
{
	DynamicCombo( D_DSTCOLOR_BLENDMODE, 0..8 );
	
	float2 g_vTexture4Scale < Default2(1, 1); Attribute("Texture4Scale"); UiType(VectorText); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	static float4 gl_Position;
	static float4 vPositionSs;
	static float4 vTexcoordgradientcoord;
	static float4 vOutercornercoord0;
	static float4 vOutercornercoord1;
	static float4 vColor0;
	static float4 vColor1;
	static float4 vInnercornercoord0;
	static float4 vInnercornercoord1;
	static float4 vOpacitytexcoord;
	static float4 output_0;
	static float4 output_1;
	static float4 output_2;
	static float4 output_3;
	static float4 output_4;
	static float4 output_5;
	static float4 output_6;
	static float4 output_7;
	
	struct VS_INPUT
	{
	    float4 vPositionSs : POSITION0;
	    float4 vTexcoordgradientcoord : TEXCOORD0;
	    float4 vOutercornercoord0 : TEXCOORD1;
	    float4 vOutercornercoord1 : TEXCOORD2;
	    float4 vColor0 : TEXCOORD3;
	    float4 vColor1 : TEXCOORD4;
	    float4 vInnercornercoord0 : TEXCOORD5;
	    float4 vInnercornercoord1 : TEXCOORD6;
	    float4 vOpacitytexcoord : TEXCOORD7;
	};
	
	struct PS_INPUT
	{
	    float4 output_0 : TEXCOORD0;
	    float4 output_1 : TEXCOORD1;
	    float4 output_2 : TEXCOORD2;
	    float4 output_3 : TEXCOORD3;
	    float4 output_4 : TEXCOORD4;
	    float4 output_5 : TEXCOORD5;
	    float4 output_6 : TEXCOORD6;
	    float4 output_7 : TEXCOORD7;
	    float4 gl_Position : SV_Position;
	};
	
	void MainVs_inner()
	{
	    float4 _19250 = vPositionSs;
	    float4 _18862 = _19250;
	    _18862.z = 0.0f;
	    output_0 = vTexcoordgradientcoord;
	    output_1 = vOutercornercoord0;
	    output_2 = vOutercornercoord1;
	    output_3 = vColor0;
	    output_4 = vColor1;
	    output_5 = vInnercornercoord0;
	    output_6 = vInnercornercoord1;
	    output_7 = vOpacitytexcoord;
	    _18862.y = -_19250.y;
	    gl_Position = _18862;
	}
	
	PS_INPUT MainVs(VS_INPUT stage_input)
	{
	    vPositionSs = stage_input.vPositionSs;
	    vTexcoordgradientcoord = stage_input.vTexcoordgradientcoord;
	    vOutercornercoord0 = stage_input.vOutercornercoord0;
	    vOutercornercoord1 = stage_input.vOutercornercoord1;
	    vColor0 = stage_input.vColor0;
	    vColor1 = stage_input.vColor1;
	    vInnercornercoord0 = stage_input.vInnercornercoord0;
	    vInnercornercoord1 = stage_input.vInnercornercoord1;
	    vOpacitytexcoord = stage_input.vOpacitytexcoord;
	    MainVs_inner();
	    PS_INPUT stage_output;
	    stage_output.gl_Position = gl_Position;
	    stage_output.output_0 = output_0;
	    stage_output.output_1 = output_1;
	    stage_output.output_2 = output_2;
	    stage_output.output_3 = output_3;
	    stage_output.output_4 = output_4;
	    stage_output.output_5 = output_5;
	    stage_output.output_6 = output_6;
	    stage_output.output_7 = output_7;
	    return stage_output;
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
}

PS
{
	DynamicCombo( D_DSTCOLOR_BLENDMODE, 0..8 );
	DynamicCombo( D_USERADIALGRADIENT, 0..1 );
	DynamicCombo( D_USEOUTERCORNER, 0..1 );
	DynamicCombo( D_USEINNERCORNER, 0..1 );
	DynamicCombo( D_COLORCORRECTION, 0..1 );
	DynamicCombo( D_USERADIALCLIP, 0..1 );
	DynamicCombo( D_USEBORDERCLIP, 0..1 );
	DynamicCombo( D_BORDER_DASH, 0..1 );
	
	Texture2D g_tLinearTexture0 < Attribute("Texture0"); SrgbRead(false); >;
	Texture2D g_tTexture0 < Attribute("Texture0"); SrgbRead(true); >;
	Texture2D g_tTexture1 < Attribute("Texture1"); SrgbRead(true); >;
	Texture2D g_tTexture3 < Attribute("Texture3"); SrgbRead(true); >;
	Texture2D g_tTexture4 < Attribute("Texture4"); SrgbRead(false); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	cbuffer FancyQuadCoreConstants_t : register(b0, space1)
	{
	    float FancyQuadCoreConstants_t_1_m0 : packoffset(c6.z);
	    int FancyQuadCoreConstants_t_1_m1 : packoffset(c7.y);
	    int FancyQuadCoreConstants_t_1_m2 : packoffset(c7.z);
	    int FancyQuadCoreConstants_t_1_m3 : packoffset(c7.w);
	    float FancyQuadCoreConstants_t_1_m4 : packoffset(c9.y);
	    float FancyQuadCoreConstants_t_1_m5 : packoffset(c9.z);
	    int FancyQuadCoreConstants_t_1_m6 : packoffset(c9.w);
	};
	
	SamplerState DefaultSamplerState_0 : register(s14, space1);
	Texture2D<float4> g_tTexture0 : register(t30, space1);
	Texture2D<float4> g_tLinearTexture0 : register(t34, space1);
	Texture2D<float4> g_tTexture3 : register(t33, space1);
	Texture2D<float4> g_tTexture1 : register(t31, space1);
	
	static float4 input_0;
	static float4 input_3;
	static float4 input_4;
	static float4 input_7;
	static float4 output_0;
	
	struct PS_INPUT
	{
	    float4 input_0 : TEXCOORD0;
	    float4 input_3 : TEXCOORD3;
	    float4 input_4 : TEXCOORD4;
	    float4 input_7 : TEXCOORD7;
	};
	
	struct PS_OUTPUT
	{
	    float4 output_0 : SV_Target0;
	};
	
	void MainPs_inner()
	{
	    float2 _13829 = ddx(input_0.xy);
	    float2 _9944 = ddy(input_0.xy);
	    bool _12885;
	    if (FancyQuadCoreConstants_t_1_m3 == 1)
	    {
	        _12885 = true;
	    }
	    else
	    {
	        _12885 = FancyQuadCoreConstants_t_1_m3 == 2;
	    }
	    float4 _7078;
	    if (_12885)
	    {
	        _7078 = g_tTexture0.SampleGrad(DefaultSamplerState_0, input_0.xy, _13829, _9944);
	    }
	    else
	    {
	        float4 _12502;
	        if (FancyQuadCoreConstants_t_1_m3 == 3)
	        {
	            float4 _11198 = g_tTexture0.SampleGrad(DefaultSamplerState_0, input_0.xy, _13829, _9944);
	            float _14685 = _11198.w;
	            float4 _16305 = _11198;
	            _16305.x = _14685;
	            _16305.y = _14685;
	            _16305.z = _14685;
	            _12502 = _16305;
	        }
	        else
	        {
	            bool _23546 = FancyQuadCoreConstants_t_1_m3 == 4;
	            bool _12886;
	            if (_23546)
	            {
	                _12886 = true;
	            }
	            else
	            {
	                _12886 = _23546;
	            }
	            float4 _12501;
	            if (_12886)
	            {
	                float4 _12167 = g_tLinearTexture0.SampleGrad(DefaultSamplerState_0, input_0.xy, _13829, _9944);
	                float _22721 = (_12167.z * 31.875f) + 1.0f;
	                float _23081 = (_12167.x - 0.501960813999176025390625f) / _22721;
	                float _23043 = (_12167.y - 0.501960813999176025390625f) / _22721;
	                float _8026 = _12167.w;
	                float _18098 = (_8026 + _23081) - _23043;
	                float _20996 = _8026 + _23043;
	                float _12464 = (_8026 - _23081) - _23043;
	                float4 _12339 = float4(_18098, _20996, _12464, 1.0f);
	                float3 _14213 = float3(_18098, _20996, _12464).xyz;
	                float3 _10597 = _14213 * 0.077399380505084991455078125f.xxx;
	                float3 _9357 = pow((_14213 * 0.947867333889007568359375f.xxx) + 0.052132703363895416259765625f.xxx, 2.400000095367431640625f.xxx);
	                float _23035;
	                if (_18098 <= 0.040449999272823333740234375f)
	                {
	                    _23035 = _10597.x;
	                }
	                else
	                {
	                    _23035 = _9357.x;
	                }
	                float _23036;
	                if (_20996 <= 0.040449999272823333740234375f)
	                {
	                    _23036 = _10597.y;
	                }
	                else
	                {
	                    _23036 = _9357.y;
	                }
	                float _19167;
	                if (_12464 <= 0.040449999272823333740234375f)
	                {
	                    _19167 = _10597.z;
	                }
	                else
	                {
	                    _19167 = _9357.z;
	                }
	                _12339.x = _23035;
	                _12339.y = _23036;
	                _12339.z = _19167;
	                _12501 = _12339;
	            }
	            else
	            {
	                _12501 = 1.0f.xxxx;
	            }
	            _12502 = _12501;
	        }
	        _7078 = _12502;
	    }
	    float4 _19017;
	    if (FancyQuadCoreConstants_t_1_m3 == 2)
	    {
	        float3 _16714 = _7078.xyz * _7078.w;
	        float4 _8673 = _7078;
	        _8673.x = _16714.x;
	        _8673.y = _16714.y;
	        _8673.z = _16714.z;
	        _19017 = _8673;
	    }
	    else
	    {
	        _19017 = _7078;
	    }
	    float4 _21709;
	    if (FancyQuadCoreConstants_t_1_m1 == 2)
	    {
	        _21709 = _19017 * g_tTexture3.SampleLevel(DefaultSamplerState_0, float2((saturate(input_0.z) * 0.9990234375f) + 0.00048828125f, 0.0f), 0.0f);
	    }
	    else
	    {
	        float4 _12503;
	        if (FancyQuadCoreConstants_t_1_m1 == 1)
	        {
	            _12503 = _19017 * lerp(input_3, input_4, saturate(input_0.z).xxxx);
	        }
	        else
	        {
	            _12503 = _19017 * input_3;
	        }
	        _21709 = _12503;
	    }
	    float4 _19306;
	    if (FancyQuadCoreConstants_t_1_m2 != 0)
	    {
	        float4 _19068 = g_tTexture1.Sample(DefaultSamplerState_0, input_7.xy);
	        float _17476 = _19068.w;
	        float _21710;
	        if (FancyQuadCoreConstants_t_1_m6 != 0)
	        {
	            _21710 = _17476 * dot(g_tTexture1.Sample(DefaultSamplerState_0, input_7.xy).xyz, float3(0.2125000059604644775390625f, 0.7153999805450439453125f, 0.07209999859333038330078125f));
	        }
	        else
	        {
	            _21710 = _17476;
	        }
	        float _21711;
	        if (_21710 < FancyQuadCoreConstants_t_1_m4)
	        {
	            _21711 = 0.0f;
	        }
	        else
	        {
	            float _12504;
	            if (_21710 < FancyQuadCoreConstants_t_1_m5)
	            {
	                _12504 = (_21710 - FancyQuadCoreConstants_t_1_m4) / (FancyQuadCoreConstants_t_1_m5 - FancyQuadCoreConstants_t_1_m4);
	            }
	            else
	            {
	                _12504 = 1.0f;
	            }
	            _21711 = _12504;
	        }
	        float _6837 = abs(FancyQuadCoreConstants_t_1_m0);
	        float _11659;
	        if (FancyQuadCoreConstants_t_1_m0 > 0.0f)
	        {
	            _11659 = _21711;
	        }
	        else
	        {
	            _11659 = 1.0f - _21711;
	        }
	        _19306 = _21709 * ((1.0f - _6837) + (_11659 * _6837));
	    }
	    else
	    {
	        _19306 = _21709;
	    }
	    output_0 = _19306.xyzw;
	}
	
	PS_OUTPUT MainPs(PS_INPUT stage_input)
	{
	    input_0 = stage_input.input_0;
	    input_3 = stage_input.input_3;
	    input_4 = stage_input.input_4;
	    input_7 = stage_input.input_7;
	    MainPs_inner();
	    PS_OUTPUT stage_output;
	    stage_output.output_0 = output_0;
	    return stage_output;
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
}
