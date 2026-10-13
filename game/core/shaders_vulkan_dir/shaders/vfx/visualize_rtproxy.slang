//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Debug drawing for rt proxies";
	DevShader = true;
	Version = 0;
	
	// Platform: VULKAN_SM_50
	// Programs: ps, vs
}

MODES
{
	Default();
	ToolsUtil();
}

FEATURES
{
	Feature( F_WIREFRAME, 0..1, "" );
}

COMMON
{
	#include "system.fxc"
}

struct VS_INPUT
{
	float3 vPositionOs  : POSITION0  < Semantic( PosXyz ); >;                                     
	float2 nInstanceIdx : TEXCOORD13 < Semantic( InstanceTransformUv ); >;                        
};

VS
{
	DynamicCombo( D_BLEND_WEIGHT_COUNT, 0..4 );
	DynamicCombo( D_COMPRESSED_NORMALS_AND_TANGENTS, 0..1 );
	DynamicComboRule( Allow0( D_BLEND_WEIGHT_COUNT ) );
	
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
	static float3 output_0;
	
	struct VS_INPUT
	{
	    float3 vPositionOs : POSITION0;
	    uint nInstanceIdx : TEXCOORD13;
	};
	
	struct PS_INPUT
	{
	    float3 output_0 : TEXCOORD0;
	    float4 gl_Position : SV_Position;
	};
	
	void MainVs_inner()
	{
	    float3x4 _9558 = float3x4(g_transformBuffer.Load<float4>(g_instanceBuffer.Load<uint>(nInstanceIdx * 32 + 4) * 48 + 0), g_transformBuffer.Load<float4>(g_instanceBuffer.Load<uint>(nInstanceIdx * 32 + 4) * 48 + 16), g_transformBuffer.Load<float4>(g_instanceBuffer.Load<uint>(nInstanceIdx * 32 + 4) * 48 + 32));
	    float4 _19149 = mul(PerViewConstantBuffer_t_1_m0, (float4(mul(_9558, float4(vPositionOs.xyz, 1.0f)).xyz, 1.0f) + (PerViewConstantBuffer_t_1_m1 * 1.0f)).xyzw);
	    _19149.y = -_19149.y;
	    gl_Position = _19149;
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
	
	RenderState(CullMode, None);
	RenderState(DepthBias, 256);
	RenderState(DepthBiasClamp, 0);
	RenderState(FillMode, F_WIREFRAME ? Wireframe : Solid);
	RenderState(SlopeScaleDepthBias, F_WIREFRAME ? .5 : 0);
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	static uint gl_PrimitiveID;
	static float4 output_0;
	
	struct PS_INPUT
	{
	    uint gl_PrimitiveID : SV_PrimitiveID;
	};
	
	struct PS_OUTPUT
	{
	    float4 output_0 : SV_Target0;
	};
	
	void MainPs_inner()
	{
	    uint3 _7107 = (uint(gl_PrimitiveID).xxx * uint3(1664525u, 1664525u, 1664525u)) + uint3(1013904223u, 1013904223u, 1013904223u);
	    uint _9762 = _7107.y;
	    uint _22261 = _7107.z;
	    uint _16272 = _7107.x + (_9762 * _22261);
	    uint _24675 = _9762 + (_22261 * _16272);
	    uint3 _18731 = uint3(_16272, _24675, _22261 + (_16272 * _24675));
	    uint3 _14317 = _18731 ^ (_18731 >> uint3(16u, 16u, 16u));
	    uint _21164 = _14317.y;
	    uint _14446 = _14317.z;
	    uint _16273 = _14317.x + (_21164 * _14446);
	    uint _24676 = _21164 + (_14446 * _16273);
	    output_0 = float4(float3(uint3(_16273, _24676, _14446 + (_16273 * _24676))) * 2.3283064365386962890625e-10f.xxx, 1.0f);
	}
	
	PS_OUTPUT MainPs(PS_INPUT stage_input)
	{
	    gl_PrimitiveID = stage_input.gl_PrimitiveID;
	    MainPs_inner();
	    PS_OUTPUT stage_output;
	    stage_output.output_0 = output_0;
	    return stage_output;
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
}
