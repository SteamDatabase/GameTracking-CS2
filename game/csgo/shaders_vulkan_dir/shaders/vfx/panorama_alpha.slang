//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Used to make background color pixels transparent for panorama compositing.";
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
	float4 vColor      : COLOR0     < Semantic( Color ); >;                                       
	float3 vPositionSs : POSITION0  < Semantic( PosXyz ); >;                                      
	float2 vTexCoord   : TEXCOORD0  < Semantic( LowPrecisionUv ); >;                              
};

VS
{
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	static float _2;
	
	static float4 gl_Position;
	static float3 vPositionSs;
	static float4 vColor;
	static float2 vTexCoord;
	static float4 output_0;
	static float2 output_1;
	
	struct VS_INPUT
	{
	    float3 vPositionSs : POSITION0;
	    float4 vColor : COLOR0;
	    float2 vTexCoord : TEXCOORD0;
	};
	
	struct PS_INPUT
	{
	    float4 output_0 : TEXCOORD0;
	    float2 output_1 : TEXCOORD1;
	    float4 gl_Position : SV_Position;
	};
	
	void MainVs_inner()
	{
	    float4 _14437 = float4(vPositionSs.x, _2, 1.0f, 1.0f);
	    output_0 = vColor;
	    output_1 = vTexCoord;
	    _14437.y = vPositionSs.y;
	    gl_Position = _14437;
	}
	
	PS_INPUT MainVs(VS_INPUT stage_input)
	{
	    vPositionSs = stage_input.vPositionSs;
	    vColor = stage_input.vColor;
	    vTexCoord = stage_input.vTexCoord;
	    MainVs_inner();
	    PS_INPUT stage_output;
	    stage_output.gl_Position = gl_Position;
	    stage_output.output_0 = output_0;
	    stage_output.output_1 = output_1;
	    return stage_output;
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
}

PS
{
	
	float g_flMaxDepth < Attribute("MaxDepth"); UiType(Slider); >;
	Texture2D g_tSceneColor < Attribute("SceneColor"); SrgbRead(true); >;
	Texture2D g_tSceneDepth < Attribute("SceneDepth"); SrgbRead(false); >;
	float3 g_vTexelSize < Attribute("TexelSize"); UiType(VectorText); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	static const float2 _1363[8] = { (-1.0f).xx, float2(-1.0f, 0.0f), float2(-1.0f, 1.0f), float2(0.0f, 1.0f), 1.0f.xx, float2(1.0f, 0.0f), float2(1.0f, -1.0f), float2(0.0f, -1.0f) };
	
	cbuffer _Globals_ : register(b0, space1)
	{
	    float3 _Globals_1_g_vTexelSize : packoffset(c0);
	    float _Globals_1_g_flMaxDepth : packoffset(c0.w);
	};
	
	Texture2D<float4> g_tSceneColor : register(t30, space1);
	SamplerState AddressU_Clamp_AddressV_Clamp_Filter_MinMagMipPoint : register(s14, space1);
	Texture2D<float4> g_tSceneDepth : register(t31, space1);
	SamplerState AddressU_Clamp_AddressV_Clamp_Filter_MinMagMipPoint_1 : register(s15, space1);
	
	static float2 input_1;
	static float4 output_0;
	
	struct PS_INPUT
	{
	    float2 input_1 : TEXCOORD1;
	};
	
	struct PS_OUTPUT
	{
	    float4 output_0 : SV_Target0;
	};
	
	void MainPs_inner()
	{
	    float4 _22452 = g_tSceneColor.Sample(AddressU_Clamp_AddressV_Clamp_Filter_MinMagMipPoint, input_1.xy);
	    float4 _19372 = g_tSceneDepth.Sample(AddressU_Clamp_AddressV_Clamp_Filter_MinMagMipPoint_1, input_1.xy);
	    bool _12885;
	    if (_22452.x < 0.004999999888241291046142578125f)
	    {
	        _12885 = _22452.y < 0.004999999888241291046142578125f;
	    }
	    else
	    {
	        _12885 = false;
	    }
	    bool _12886;
	    if (_12885)
	    {
	        _12886 = _22452.z < 0.004999999888241291046142578125f;
	    }
	    else
	    {
	        _12886 = false;
	    }
	    bool _12887;
	    if (_12886)
	    {
	        _12887 = _19372.x >= (_Globals_1_g_flMaxDepth - 0.00999999977648258209228515625f);
	    }
	    else
	    {
	        _12887 = false;
	    }
	    float4 _6805;
	    if (_12887)
	    {
	        _6805 = 0.0f.xxxx;
	    }
	    else
	    {
	        float _13155;
	        _13155 = 0.0f;
	        int _8087;
	        float _14382;
	        int _16208 = 0;
	        for (;;)
	        {
	            if (!(_16208 < 8))
	            {
	                break;
	            }
	            float2 _12974 = (input_1.xy + (_1363[_16208] * _Globals_1_g_vTexelSize.xy)).xy;
	            float4 _22453 = g_tSceneColor.Sample(AddressU_Clamp_AddressV_Clamp_Filter_MinMagMipPoint, _12974);
	            float4 _3300 = g_tSceneDepth.Sample(AddressU_Clamp_AddressV_Clamp_Filter_MinMagMipPoint_1, _12974);
	            bool _12888;
	            if (_22453.x >= 0.004999999888241291046142578125f)
	            {
	                _12888 = true;
	            }
	            else
	            {
	                _12888 = _22453.y >= 0.004999999888241291046142578125f;
	            }
	            bool _12889;
	            if (_12888)
	            {
	                _12889 = true;
	            }
	            else
	            {
	                _12889 = _22453.z >= 0.004999999888241291046142578125f;
	            }
	            bool _12890;
	            if (_12889)
	            {
	                _12890 = true;
	            }
	            else
	            {
	                _12890 = _3300.x < (_Globals_1_g_flMaxDepth - 0.00999999977648258209228515625f);
	            }
	            if (_12890)
	            {
	                _14382 = _13155 + 1.0f;
	            }
	            else
	            {
	                _14382 = _13155;
	            }
	            _8087 = _16208 + 1;
	            _13155 = _14382;
	            _16208 = _8087;
	            continue;
	        }
	        float _13093 = smoothstep(4.0f, 8.0f, _13155);
	        _6805 = float4(_22452.xyz * _13093, _13093);
	    }
	    output_0 = _6805;
	}
	
	PS_OUTPUT MainPs(PS_INPUT stage_input)
	{
	    input_1 = stage_input.input_1;
	    MainPs_inner();
	    PS_OUTPUT stage_output;
	    stage_output.output_0 = output_0;
	    return stage_output;
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
}
