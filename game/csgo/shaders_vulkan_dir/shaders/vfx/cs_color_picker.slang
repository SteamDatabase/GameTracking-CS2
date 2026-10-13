//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Used to draw UI color picker elements";
	DevShader = false;
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
	
	float4 g_vViewport < Source(Viewport); UiType(VectorText); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	static float _3;
	
	cbuffer _Globals_ : register(b0, space0)
	{
	    float4 _Globals_1_g_vViewport : packoffset(c0);
	};
	
	
	static float4 gl_Position;
	static float2 vPositionSs;
	static float4 vColor;
	static float2 vTexCoord;
	static float4 output_0;
	static float2 output_1;
	
	struct VS_INPUT
	{
	    float2 vPositionSs : POSITION0;
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
	    float2 _15639 = (((vPositionSs.xy - _Globals_1_g_vViewport.xy) * 2.0f) / _Globals_1_g_vViewport.zw) - 1.0f.xx;
	    float4 _14779 = float4(_15639.x, _3, 1.0f, 1.0f);
	    float3 _24030 = vColor.xyz * 0.077399380505084991455078125f.xxx;
	    float3 _7676 = pow((vColor.xyz * 0.947867333889007568359375f.xxx) + 0.052132703363895416259765625f.xxx, 2.400000095367431640625f.xxx);
	    float _21354;
	    if (vColor.x <= 0.040449999272823333740234375f)
	    {
	        _21354 = _24030.x;
	    }
	    else
	    {
	        _21354 = _7676.x;
	    }
	    float _21355;
	    if (vColor.y <= 0.040449999272823333740234375f)
	    {
	        _21355 = _24030.y;
	    }
	    else
	    {
	        _21355 = _7676.y;
	    }
	    float _19302;
	    if (vColor.z <= 0.040449999272823333740234375f)
	    {
	        _19302 = _24030.z;
	    }
	    else
	    {
	        _19302 = _7676.z;
	    }
	    output_0 = float4(_21354, _21355, _19302, vColor.w);
	    output_1 = vTexCoord;
	    _14779.y = _15639.y;
	    gl_Position = _14779;
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
	
	
	
	BoolAttribute(ui, true);
	BoolAttribute(ScreenSpaceVertices, true);
	
}

PS
{
	
	float g_flHue < Default(1); Range(0, 360); UiType(Slider); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	static float _2;
	
	cbuffer _Globals_ : register(b0, space1)
	{
	    float _Globals_1_g_flHue : packoffset(c0);
	};
	
	
	static float2 input_1;
	static float4 input_0;
	static float4 output_0;
	
	struct PS_INPUT
	{
	    float4 input_0 : TEXCOORD0;
	    float2 input_1 : TEXCOORD1;
	};
	
	struct PS_OUTPUT
	{
	    float4 output_0 : SV_Target0;
	};
	
	void MainPs_inner()
	{
	    float _13211 = 1.0f - input_1.y;
	    float3 _22743;
	    if (input_1.x != 0.0f)
	    {
	        float _12281 = _Globals_1_g_flHue * 0.01666666753590106964111328125f;
	        float _23729 = floor(_12281);
	        float _15688 = _13211 * (1.0f - input_1.x);
	        float _17993 = _12281 - _23729;
	        float _10560 = _13211 * (1.0f - (input_1.x * _17993));
	        float _23319 = _13211 * (1.0f - (input_1.x * (1.0f - _17993)));
	        float3 _12505;
	        if (_23729 == 0.0f)
	        {
	            _12505 = float3(_13211, _23319, _15688);
	        }
	        else
	        {
	            float3 _12504;
	            if (_23729 == 1.0f)
	            {
	                _12504 = float3(_10560, _13211, _15688);
	            }
	            else
	            {
	                float3 _12503;
	                if (_23729 == 2.0f)
	                {
	                    _12503 = float3(_15688, _13211, _23319);
	                }
	                else
	                {
	                    float3 _12502;
	                    if (_23729 == 3.0f)
	                    {
	                        _12502 = float3(_15688, _10560, _13211);
	                    }
	                    else
	                    {
	                        float3 _12501;
	                        if (_23729 == 4.0f)
	                        {
	                            _12501 = float3(_23319, _15688, _13211);
	                        }
	                        else
	                        {
	                            _12501 = float3(_13211, _15688, _10560);
	                        }
	                        _12502 = _12501;
	                    }
	                    _12503 = _12502;
	                }
	                _12504 = _12503;
	            }
	            _12505 = _12504;
	        }
	        _22743 = _12505;
	    }
	    else
	    {
	        _22743 = float3(_2, input_1.x, _13211).zzz;
	    }
	    float4 _15731 = input_0.xyzw * float4(_22743, 1.0f);
	    float3 _6273 = _15731.xyz;
	    float3 _17828 = _6273 * 0.077399380505084991455078125f.xxx;
	    float3 _7676 = pow((_6273 * 0.947867333889007568359375f.xxx) + 0.052132703363895416259765625f.xxx, 2.400000095367431640625f.xxx);
	    float _21354;
	    if (_15731.x <= 0.040449999272823333740234375f)
	    {
	        _21354 = _17828.x;
	    }
	    else
	    {
	        _21354 = _7676.x;
	    }
	    float _21355;
	    if (_15731.y <= 0.040449999272823333740234375f)
	    {
	        _21355 = _17828.y;
	    }
	    else
	    {
	        _21355 = _7676.y;
	    }
	    float _19167;
	    if (_15731.z <= 0.040449999272823333740234375f)
	    {
	        _19167 = _17828.z;
	    }
	    else
	    {
	        _19167 = _7676.z;
	    }
	    _15731.x = _21354;
	    _15731.y = _21355;
	    _15731.z = _19167;
	    output_0 = _15731;
	}
	
	PS_OUTPUT MainPs(PS_INPUT stage_input)
	{
	    input_1 = stage_input.input_1;
	    input_0 = stage_input.input_0;
	    MainPs_inner();
	    PS_OUTPUT stage_output;
	    stage_output.output_0 = output_0;
	    return stage_output;
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
}
