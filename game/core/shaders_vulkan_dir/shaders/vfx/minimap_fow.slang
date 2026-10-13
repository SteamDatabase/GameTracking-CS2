//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Used to draw fog of war on the minimap";
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
	
	Texture2D g_tFowTexture < Attribute("FOWTexture"); SrgbRead(false); >;
	Texture2D g_tMapTexture < Attribute("MapTexture"); SrgbRead(false); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	Texture2D<float4> g_tMapTexture : register(t30, space1);
	SamplerState AddressU_Clamp_AddressV_Clamp_Filter_MinMagMipLinear : register(s14, space1);
	Texture2D<float4> g_tFowTexture : register(t31, space1);
	SamplerState AddressU_Clamp_AddressV_Clamp_Filter_MinMagMipLinear_1 : register(s15, space1);
	
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
	    float4 _22452 = g_tMapTexture.Sample(AddressU_Clamp_AddressV_Clamp_Filter_MinMagMipLinear, input_1.xy);
	    float4 _3300 = g_tFowTexture.Sample(AddressU_Clamp_AddressV_Clamp_Filter_MinMagMipLinear_1, input_1.xy);
	    float _23223 = _22452.w;
	    float _13220 = _3300.w;
	    bool _12885;
	    if (_13220 < 0.60000002384185791015625f)
	    {
	        _12885 = _3300.x < 0.100000001490116119384765625f;
	    }
	    else
	    {
	        _12885 = false;
	    }
	    float4 _6805;
	    if (_12885)
	    {
	        _6805 = float4(0.699999988079071044921875f, 0.699999988079071044921875f, 0.0f, _23223 * 0.5f);
	    }
	    else
	    {
	        _6805 = float4(input_0.xyz, _23223 * _13220);
	    }
	    output_0 = _6805;
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
