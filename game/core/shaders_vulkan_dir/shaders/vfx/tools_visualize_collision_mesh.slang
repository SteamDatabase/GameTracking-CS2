//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Debug shader to visualize collision meshes";
	DevShader = true;
	Version = 0;
	
	// Platform: VULKAN_SM_50
	// Programs: ps, vs
}

MODES
{
	Default();
	VrForward();
	Depth();
	ToolsUtil();
}

FEATURES
{
	Feature( F_DEPTH_TEST, 0..1, "" );
	Feature( F_WIREFRAME, 0..1, "" );
}

COMMON
{
	#include "system.fxc"
}

struct VS_INPUT
{
	float4 vBlendIndices : BLENDINDICES0  < Semantic( BlendIndices ); >;                           // D_BLEND_WEIGHT_COUNT=1, D_BLEND_WEIGHT_COUNT=2, D_BLEND_WEIGHT_COUNT=3, D_BLEND_WEIGHT_COUNT=4
	float4 vBlendWeight  : BLENDWEIGHT0   < Semantic( BlendWeight ); >;                            // D_BLEND_WEIGHT_COUNT=2, D_BLEND_WEIGHT_COUNT=3, D_BLEND_WEIGHT_COUNT=4
	float4 vColor        : COLOR0         < Semantic( Color ); >;                                 
	float4 vNormalOs     : NORMAL0        < Semantic( Normal ); >;                                
	float3 vPositionOs   : POSITION0      < Semantic( PosXyz ); >;                                
	float2 nInstanceIdx  : TEXCOORD13     < Semantic( InstanceTransformUv ); >;                   
};

VS
{
	StaticCombo( S_WIREFRAME, F_WIREFRAME );
	DynamicCombo( D_BLEND_WEIGHT_COUNT, 0..4 );
	DynamicCombo( D_COMPRESSED_NORMALS_AND_TANGENTS, 0..1 );
	
	[[layer_constant]] StructuredBuffer g_instanceBuffer < Attribute("InstanceBuffer"); >;
	[[layer_constant]] StructuredBuffer g_transformBuffer < Attribute("TransformBuffer"); >;
	float4 g_vColor < Default4(1, 1, 1, 1); Attribute("Color"); UiType(VectorText); >;
	
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
	cbuffer PerViewConstantBuffer_t : register(b1, space0)
	{
	    column_major float4x4 PerViewConstantBuffer_t_1_m0 : packoffset(c0);
	    float4 PerViewConstantBuffer_t_1_m1 : packoffset(c24);
	    float3 PerViewConstantBuffer_t_1_m2 : packoffset(c26);
	};
	
	cbuffer _Globals_ : register(b0, space0)
	{
	    float4 _Globals_1_g_vColor : packoffset(c0);
	};
	
	
	static float4 gl_Position;
	static float3 vPositionOs;
	static float3 vNormalOs;
	static float4 vColor;
	static uint nInstanceIdx;
	static float4 output_0;
	static float3 output_1;
	
	struct VS_INPUT
	{
	    float3 vPositionOs : POSITION0;
	    float3 vNormalOs : NORMAL0;
	    float4 vColor : COLOR0;
	    uint nInstanceIdx : TEXCOORD13;
	};
	
	struct PS_INPUT
	{
	    float4 output_0 : TEXCOORD0;
	    float3 output_1 : TEXCOORD1;
	    float4 gl_Position : SV_Position;
	};
	
	void MainVs_inner()
	{
	    float3x4 _9558 = float3x4(g_transformBuffer.Load<float4>(g_instanceBuffer.Load<uint>(nInstanceIdx * 32 + 4) * 48 + 0), g_transformBuffer.Load<float4>(g_instanceBuffer.Load<uint>(nInstanceIdx * 32 + 4) * 48 + 16), g_transformBuffer.Load<float4>(g_instanceBuffer.Load<uint>(nInstanceIdx * 32 + 4) * 48 + 32));
	    float3 _11111 = mul(_9558, float4(vPositionOs.xyz, 1.0f)).xyz;
	    float4 _17895 = mul(PerViewConstantBuffer_t_1_m0, (float4(_11111, 1.0f) + (PerViewConstantBuffer_t_1_m1 * 1.0f)).xyzw);
	    float3 _10837 = normalize(mul(_9558, float4(vNormalOs.xyz, 0.0f)));
	    float _19069 = saturate(dot(_10837, float3(-1.0f, 1.0f, -1.0f)));
	    float _13301 = dot(-normalize(_11111 - PerViewConstantBuffer_t_1_m2.xyz), _10837.xyz);
	    bool _6651 = _13301 < 0.0f;
	    output_0 = float4((vColor.xyz * _Globals_1_g_vColor.xyz) * (clamp(float3(saturate(dot(_10837, 1.0f.xxx)) + _19069, saturate(dot(_10837, float3(-1.0f, -1.0f, 1.0f))) + _19069, saturate(dot(_10837, float3(1.0f, -1.0f, -1.0f)))) * 0.014999999664723873138427734375f, 0.0f.xxx, 1.0f.xxx) + 0.89999997615814208984375f.xxx), (vColor.w * saturate(((_6651 ? 0.25f : 1.0f) * pow(1.0f - abs(_13301), _6651 ? 4.0f : 2.0f)) + pow(saturate(_13301), 8.0f))) * _Globals_1_g_vColor.w);
	    output_1 = _10837;
	    _17895.y = -_17895.y;
	    gl_Position = _17895;
	}
	
	PS_INPUT MainVs(VS_INPUT stage_input)
	{
	    vPositionOs = stage_input.vPositionOs;
	    vNormalOs = stage_input.vNormalOs;
	    vColor = stage_input.vColor;
	    nInstanceIdx = stage_input.nInstanceIdx;
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
	StaticCombo( S_DEPTH_TEST, F_DEPTH_TEST );
	StaticCombo( S_WIREFRAME, F_WIREFRAME );
	
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
	    output_0 = input_0.xyzw;
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
	
	
	
	BoolAttribute(translucent, true);
	
}
