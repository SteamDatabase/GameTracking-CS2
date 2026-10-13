//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Simple, no frills screenspace wireframe with per-vertex colors";
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
	float4 vColor              : COLOR0     < Semantic( Color ); >;                               
	float3 vPositionPs         : POSITION0  < Semantic( PosXyz ); >;                              
	float2 vFirstLineVertPosPs : TEXCOORD1  < Semantic( uvw ); >;                                 
};

VS
{
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	static float4 gl_Position;
	static float4 vPositionPs;
	static float4 vColor;
	static float4 vFirstLineVertPosPs;
	static float4 output_0;
	static float4 output_1;
	static float4 output_2;
	
	struct VS_INPUT
	{
	    float4 vPositionPs : POSITION0;
	    float4 vColor : COLOR0;
	    float4 vFirstLineVertPosPs : TEXCOORD1;
	};
	
	struct PS_INPUT
	{
	    float4 output_0 : TEXCOORD0;
	    float4 output_1 : TEXCOORD1;
	    float4 output_2 : TEXCOORD2;
	    float4 gl_Position : SV_Position;
	};
	
	void MainVs_inner()
	{
	    float4 _22883 = vPositionPs;
	    output_0 = vColor;
	    output_1 = vFirstLineVertPosPs;
	    output_2 = _22883;
	    _22883.y = -_22883.y;
	    gl_Position = _22883;
	}
	
	PS_INPUT MainVs(VS_INPUT stage_input)
	{
	    vPositionPs = stage_input.vPositionPs;
	    vColor = stage_input.vColor;
	    vFirstLineVertPosPs = stage_input.vFirstLineVertPosPs;
	    MainVs_inner();
	    PS_INPUT stage_output;
	    stage_output.gl_Position = gl_Position;
	    stage_output.output_0 = output_0;
	    stage_output.output_1 = output_1;
	    stage_output.output_2 = output_2;
	    return stage_output;
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
}

PS
{
	
	float g_flPatternType < Attribute("PatternType"); UiType(Slider); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	cbuffer _Globals_ : register(b0, space1)
	{
	    float _Globals_1_g_flPatternType : packoffset(c0);
	};
	
	cbuffer PerViewConstantBuffer_t : register(b1, space1)
	{
	    float2 PerViewConstantBuffer_t_1_m0 : packoffset(c21);
	};
	
	
	static float4 input_0;
	static float4 input_1;
	static float4 input_2;
	static float4 output_0;
	
	struct PS_INPUT
	{
	    float4 input_0 : TEXCOORD0;
	    float4 input_1 : TEXCOORD1;
	    float4 input_2 : TEXCOORD2;
	};
	
	struct PS_OUTPUT
	{
	    float4 output_0 : SV_Target0;
	};
	
	void MainPs_inner()
	{
	    bool _12885;
	    do
	    {
	        float _19667;
	        if (_Globals_1_g_flPatternType == 1.0f)
	        {
	            _19667 = 16.0f;
	        }
	        else
	        {
	            _19667 = (_Globals_1_g_flPatternType == 2.0f) ? 3.0f : 0.0f;
	        }
	        float2 _6382 = input_1.w.xx;
	        if (_19667 != 0.0f)
	        {
	            _12885 = fmod(length(((input_2.xy / _6382) / PerViewConstantBuffer_t_1_m0.xy) - ((input_1.xy / _6382) / PerViewConstantBuffer_t_1_m0.xy)), _19667 * 2.0f) > _19667;
	            break;
	        }
	        _12885 = false;
	        break;
	    } while(false);
	    if (_12885)
	    {
	        discard;
	    }
	    output_0 = input_0;
	}
	
	PS_OUTPUT MainPs(PS_INPUT stage_input)
	{
	    input_0 = stage_input.input_0;
	    input_1 = stage_input.input_1;
	    input_2 = stage_input.input_2;
	    MainPs_inner();
	    PS_OUTPUT stage_output;
	    stage_output.output_0 = output_0;
	    return stage_output;
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
}
