//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "";
	DevShader = true;
	Version = 0;
	
	// Platform: VULKAN_SM_50
	// Programs: ps, vs
}

MODES
{
	ToolsVis();
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
	float3 vPositionOs  : POSITION0  < Semantic( PosXyz ); >;                                     
	float2 nInstanceIdx : TEXCOORD13 < Semantic( InstanceTransformUv ); >;                        
};

VS
{
	
	[[layer_constant]] ExternalDescriptorSet g_globalLateBoundBindlessSet < Source(ExternalDescSet); Attribute("g_globalLateBoundBindlessSet"); >;
	[[layer_constant]] StructuredBuffer g_instanceBuffer < Attribute("InstanceBuffer"); >;
	[[layer_constant]] ExternalDescriptorSet g_lightBinnerGpuSet < Source(ExternalDescSet); Attribute("g_lightBinnerGpuSet"); >;
	int g_nInstanceBufferIndex < Attribute("InstanceID"); UiType(Slider); >;
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
	
	cbuffer _Globals_ : register(b0, space0)
	{
	    int _Globals_1_g_nInstanceBufferIndex : packoffset(c0);
	};
	
	ByteAddressBuffer g_instanceBuffer : register(t32, space4);
	ByteAddressBuffer g_transformBuffer : register(t30, space4);
	cbuffer PerViewConstantBuffer_t : register(b1, space0)
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
	    uint _21116 = (nInstanceIdx + 1u) * 2654435769u;
	    uint _3320 = _21116 & 4294901759u;
	    float3x4 _6463 = float3x4(g_transformBuffer.Load<float4>(g_instanceBuffer.Load<uint>(uint(_Globals_1_g_nInstanceBufferIndex) * 32 + 4) * 48 + 0), g_transformBuffer.Load<float4>(g_instanceBuffer.Load<uint>(uint(_Globals_1_g_nInstanceBufferIndex) * 32 + 4) * 48 + 16), g_transformBuffer.Load<float4>(g_instanceBuffer.Load<uint>(uint(_Globals_1_g_nInstanceBufferIndex) * 32 + 4) * 48 + 32));
	    float4 _20422 = mul(PerViewConstantBuffer_t_1_m0, (float4(mul(_6463, float4(vPositionOs.xyz, 1.0f)).xyz, 1.0f) + (PerViewConstantBuffer_t_1_m1 * 1.0f)).xyzw);
	    float3 _23610 = float3(float((_3320 >> uint(16)) & 255u) * 0.0039215688593685626983642578125f, float((_3320 >> uint(8)) & 255u) * 0.0039215688593685626983642578125f, float(_21116 & 255u) * 0.0039215688593685626983642578125f).xyz;
	    float3 _12245 = _23610 * _23610;
	    float3 _23482;
	    if ((_21116 & 65536u) != 0u)
	    {
	        _23482 = _12245.xyz * float3(0.25f, 0.5f, 0.75f);
	    }
	    else
	    {
	        _23482 = _12245;
	    }
	    output_0 = _23482;
	    _20422.y = -_20422.y;
	    gl_Position = _20422;
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
	DynamicCombo( D_WIREFRAME, 0..1 );
	DynamicCombo( D_OVERWRITE_DEPTH, 0..1 );
	
	float g_fDepth < Attribute("DepthValue"); UiType(Slider); >;
	[[layer_constant]] ExternalDescriptorSet g_globalLateBoundBindlessSet < Source(ExternalDescSet); Attribute("g_globalLateBoundBindlessSet"); >;
	[[layer_constant]] ExternalDescriptorSet g_lightBinnerGpuSet < Source(ExternalDescSet); Attribute("g_lightBinnerGpuSet"); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	static bool gl_FrontFacing;
	static float3 input_0;
	static float4 output_0;
	
	struct PS_INPUT
	{
	    float3 input_0 : TEXCOORD0;
	    bool gl_FrontFacing : SV_IsFrontFace;
	};
	
	struct PS_OUTPUT
	{
	    float4 output_0 : SV_Target0;
	};
	
	void MainPs_inner()
	{
	    bool3 _16564 = gl_FrontFacing.xxx;
	    output_0 = float4(float3(_16564.x ? 1.0f.xxx.x : float3(0.20000000298023223876953125f, 0.20000000298023223876953125f, 0.449999988079071044921875f).x, _16564.y ? 1.0f.xxx.y : float3(0.20000000298023223876953125f, 0.20000000298023223876953125f, 0.449999988079071044921875f).y, _16564.z ? 1.0f.xxx.z : float3(0.20000000298023223876953125f, 0.20000000298023223876953125f, 0.449999988079071044921875f).z) * input_0.xyz, 0.0f);
	}
	
	PS_OUTPUT MainPs(PS_INPUT stage_input)
	{
	    gl_FrontFacing = stage_input.gl_FrontFacing;
	    input_0 = stage_input.input_0;
	    MainPs_inner();
	    PS_OUTPUT stage_output;
	    stage_output.output_0 = output_0;
	    return stage_output;
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
}
