//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Error shader";
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
	float4 vBlendIndices : BLENDINDICES0  < Semantic( BlendIndices ); >;                          
	float4 vBlendWeight  : BLENDWEIGHT0   < Semantic( BlendWeight ); >;                           
	float3 vPositionOs   : POSITION0      < Semantic( PosXyz ); >;                                
	float2 nInstanceIdx  : TEXCOORD13     < Semantic( InstanceTransformUv ); >;                   
};

VS
{
	DynamicCombo( D_BLEND_WEIGHT_COUNT, 0..4 );
	
	[[layer_constant]] StructuredBuffer g_instanceBuffer < Attribute("InstanceBuffer"); >;
	[[layer_constant]] StructuredBuffer g_transformBuffer < Attribute("TransformBuffer"); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	struct _1125
	{
	    uint _m0;
	    uint _m1;
	    uint _m2;
	    uint _m3;
	    uint _m4;
	    uint _m5;
	    uint _m6;
	    float _m7;
	};
	
	struct _1119
	{
	    row_major float3x4 _m0;
	};
	
	ByteAddressBuffer g_instanceBuffer : register(t32, space0);
	ByteAddressBuffer g_transformBuffer : register(t30, space0);
	cbuffer PerViewConstantBuffer_t : register(b0, space0)
	{
	    column_major float4x4 PerViewConstantBuffer_t_1_m0 : packoffset(c0);
	    float4 PerViewConstantBuffer_t_1_m1 : packoffset(c24);
	};
	
	
	static float4 gl_Position;
	static float3 vPositionOs;
	static uint nInstanceIdx;
	static float output_0;
	
	struct VS_INPUT
	{
	    float3 vPositionOs : POSITION0;
	    uint nInstanceIdx : TEXCOORD13;
	};
	
	struct PS_INPUT
	{
	    float output_0 : TEXCOORD0;
	    float4 gl_Position : SV_Position;
	};
	
	void MainVs_inner()
	{
	    float3x4 _9558 = float3x4(g_transformBuffer.Load<float4>(g_instanceBuffer.Load<uint>(nInstanceIdx * 32 + 4) * 48 + 0), g_transformBuffer.Load<float4>(g_instanceBuffer.Load<uint>(nInstanceIdx * 32 + 4) * 48 + 16), g_transformBuffer.Load<float4>(g_instanceBuffer.Load<uint>(nInstanceIdx * 32 + 4) * 48 + 32));
	    float4 _18275 = mul(PerViewConstantBuffer_t_1_m0, (float4(mul(_9558, float4(vPositionOs.xyz, 1.0f)).xyz, 1.0f) + (PerViewConstantBuffer_t_1_m1 * 1.0f)).xyzw);
	    output_0 = frac(((vPositionOs.x + vPositionOs.y) + vPositionOs.z) * 100.09999847412109375f);
	    _18275.y = -_18275.y;
	    gl_Position = _18275;
	}
	
	PS_INPUT MainVs(VS_INPUT stage_input)
	{
	    vPositionOs = stage_input.vPositionOs;
	    nInstanceIdx = stage_input.nInstanceIdx;
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
	
	float g_flTime < Attribute("Time"); UiType(Slider); >;
	
	// Color
	float3 g_vErrorColorTint < Default(1); UiType(Color); UiGroup("Color"); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	cbuffer _Globals_ : register(b0, space1)
	{
	    float _Globals_1_g_flTime : packoffset(c0);
	    float3 _Globals_1_g_vErrorColorTint : packoffset(c0.y);
	};
	
	
	static float gl_FragDepth;
	static float input_0;
	static float4 output_0;
	static float4 output_1;
	static float4 output_2;
	static float4 output_3;
	
	struct PS_INPUT
	{
	    float input_0 : TEXCOORD0;
	};
	
	struct PS_OUTPUT
	{
	    float4 output_0 : SV_Target0;
	    float4 output_1 : SV_Target1;
	    float4 output_2 : SV_Target2;
	    float4 output_3 : SV_Target3;
	    float gl_FragDepth : SV_Depth;
	};
	
	void MainPs_inner()
	{
	    output_0 = float4(_Globals_1_g_vErrorColorTint.xyz * (saturate((sin(_Globals_1_g_flTime * 6.0f) * 0.300000011920928955078125f) + 0.699999988079071044921875f) * ((input_0 * 0.20000000298023223876953125f) + 0.800000011920928955078125f)), 1.0f);
	    output_1 = 0.0f.xxxx;
	    output_2 = 0.0f.xxxx;
	    output_3 = 0.0f.xxxx;
	    gl_FragDepth = 0.0f;
	}
	
	PS_OUTPUT MainPs(PS_INPUT stage_input)
	{
	    input_0 = stage_input.input_0;
	    MainPs_inner();
	    PS_OUTPUT stage_output;
	    stage_output.gl_FragDepth = gl_FragDepth;
	    stage_output.output_0 = output_0;
	    stage_output.output_1 = output_1;
	    stage_output.output_2 = output_2;
	    stage_output.output_3 = output_3;
	    return stage_output;
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
}
