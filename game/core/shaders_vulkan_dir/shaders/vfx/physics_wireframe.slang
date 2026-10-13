//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Wireframe for physics model visualization";
	DevShader = true;
	Version = 0;
	
	// Platform: VULKAN_SM_50
	// Programs: ps, vs
}

MODES
{
	Default();
	Forward(S_MODE_FORWARD);
}

FEATURES
{
	Feature( F_ALPHA_TEST, 0..1, "" );
	Feature( F_DOTTED_LINE, 0..1, "" );
	Feature( F_FILL, 0..1, "" );
	Feature( F_HIDDEN_WIREFRAME, 0..1, "" );
}

COMMON
{
	#include "system.fxc"
}

struct VS_INPUT
{
	float4 vBlendIndices       : BLENDINDICES0  < Semantic( BlendIndices ); >;                     // D_BLEND_WEIGHT_COUNT=1, D_BLEND_WEIGHT_COUNT=2, D_BLEND_WEIGHT_COUNT=3, D_BLEND_WEIGHT_COUNT=4
	float4 vBlendWeight        : BLENDWEIGHT0   < Semantic( BlendWeight ); >;                      // D_BLEND_WEIGHT_COUNT=2, D_BLEND_WEIGHT_COUNT=3, D_BLEND_WEIGHT_COUNT=4
	float4 vColor              : COLOR0         < Semantic( Color ); >;                           
	float4 vFirstLineVertPosWs : TEXCOORD0      < Semantic( None ); >;                             // S_DOTTED_LINE=1
	float4 vNormalOs           : NORMAL0        < Semantic( Normal ); >;                          
	float3 vPositionOs         : POSITION0      < Semantic( PosXyz ); >;                          
	float2 nInstanceIdx        : TEXCOORD13     < Semantic( InstanceTransformUv ); >;             
};

VS
{
	StaticCombo( S_DOTTED_LINE, F_DOTTED_LINE );
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
	static float4 vColor;
	static float3 vNormalOs;
	static uint nInstanceIdx;
	static float4 output_0;
	static float3 output_1;
	static float3 output_2;
	
	struct VS_INPUT
	{
	    float3 vPositionOs : POSITION0;
	    float4 vColor : COLOR0;
	    float3 vNormalOs : NORMAL0;
	    uint nInstanceIdx : TEXCOORD13;
	};
	
	struct PS_INPUT
	{
	    float4 output_0 : TEXCOORD0;
	    float3 output_1 : TEXCOORD1;
	    float3 output_2 : TEXCOORD2;
	    float4 gl_Position : SV_Position;
	};
	
	void MainVs_inner()
	{
	    float3x4 _9558 = float3x4(g_transformBuffer.Load<float4>(g_instanceBuffer.Load<uint>(nInstanceIdx * 32 + 4) * 48 + 0), g_transformBuffer.Load<float4>(g_instanceBuffer.Load<uint>(nInstanceIdx * 32 + 4) * 48 + 16), g_transformBuffer.Load<float4>(g_instanceBuffer.Load<uint>(nInstanceIdx * 32 + 4) * 48 + 32));
	    float3 _19956 = mul(_9558, float4(vPositionOs.xyz, 1.0f));
	    float4 _17895 = mul(PerViewConstantBuffer_t_1_m0, (float4(_19956.xyz, 1.0f) + (PerViewConstantBuffer_t_1_m1 * 1.0f)).xyzw);
	    output_0 = vColor;
	    output_1 = vNormalOs;
	    output_2 = _19956;
	    _17895.y = -_17895.y;
	    gl_Position = _17895;
	}
	
	PS_INPUT MainVs(VS_INPUT stage_input)
	{
	    vPositionOs = stage_input.vPositionOs;
	    vColor = stage_input.vColor;
	    vNormalOs = stage_input.vNormalOs;
	    nInstanceIdx = stage_input.nInstanceIdx;
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
	StaticCombo( S_MODE_FORWARD, 0..1 );
	StaticCombo( S_DOTTED_LINE, F_DOTTED_LINE );
	StaticCombo( S_ALPHA_TEST, F_ALPHA_TEST );
	StaticCombo( S_HIDDEN_WIREFRAME, F_HIDDEN_WIREFRAME );
	StaticCombo( S_FILL, F_FILL );
	
	RenderState(StencilRef, 1);
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	static float4 input_0;
	static float4 output_0;
	
	struct PS_INPUT
	{
	    float4 input_0 : TEXCOORD0;
	};
	
	struct PS_OUTPUT
	{
	    float4 output_0 : SV_Target0;
	};
	
	void MainPs_inner()
	{
	    output_0 = input_0;
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
