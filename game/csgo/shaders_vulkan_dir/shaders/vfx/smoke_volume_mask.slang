//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Smoke Volume Mask";
	DevShader = true;
	Version = 1;
	
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
	float4 vPositionPs : POSITION0  < Semantic( position ); >;                                    
	float4 vTexCoord   : TEXCOORD0  < Semantic( texcoord ); >;                                    
	float3 vPositionOs : POSITION0  < Semantic( PosXyz ); >;                                      
};

VS
{
	DynamicCombo( D_DDA_MASK, 0..1 );
	
	[[layer_constant]] ExternalDescriptorSet g_globalLateBoundBindlessSet < Source(ExternalDescSet); Attribute("g_globalLateBoundBindlessSet"); >;
	[[layer_constant]] ExternalDescriptorSet g_lightBinnerGpuSet < Source(ExternalDescSet); Attribute("g_lightBinnerGpuSet"); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	struct _2607
	{
	    float4 _m0[16];
	};
	
	cbuffer SmokeConstantBaseBuffer_t : register(b2, space0)
	{
	    _2607 SmokeConstantBaseBuffer_t_1_m0 : packoffset(c0);
	    _2607 SmokeConstantBaseBuffer_t_1_m1 : packoffset(c16);
	};
	
	cbuffer PerViewConstantBuffer_t : register(b0, space0)
	{
	    column_major float4x4 PerViewConstantBuffer_t_1_m0 : packoffset(c0);
	    float4 PerViewConstantBuffer_t_1_m1 : packoffset(c24);
	};
	
	
	static float4 gl_Position;
	static int gl_InstanceIndex;
	static int gl_BaseInstanceARB;
	cbuffer SPIRV_Cross_VertexInfo
	{
	    int SPIRV_Cross_BaseVertex;
	    int SPIRV_Cross_BaseInstance;
	};
	
	static float3 vPositionOs;
	static float3 output_0;
	static uint output_1;
	
	struct VS_INPUT
	{
	    float3 vPositionOs : POSITION0;
	    uint gl_InstanceIndex : SV_InstanceID;
	};
	
	struct PS_INPUT
	{
	    float3 output_0 : TEXCOORD0;
	    nointerpolation uint output_1 : TEXCOORD1;
	    float4 gl_Position : SV_Position;
	};
	
	void MainVs_inner()
	{
	    uint _24589 = uint(gl_InstanceIndex - gl_BaseInstanceARB);
	    float3 _18555 = lerp(SmokeConstantBaseBuffer_t_1_m0._m0[_24589].xyz, SmokeConstantBaseBuffer_t_1_m1._m0[_24589].xyz, vPositionOs.xyz + 0.5f.xxx);
	    float4 _19149 = mul(PerViewConstantBuffer_t_1_m0, (float4(_18555.xyz, 1.0f) + (PerViewConstantBuffer_t_1_m1 * 1.0f)).xyzw);
	    _19149.y = -_19149.y;
	    gl_Position = _19149;
	    output_0 = _18555;
	    output_1 = _24589;
	}
	
	PS_INPUT MainVs(VS_INPUT stage_input)
	{
	    gl_InstanceIndex = int(stage_input.gl_InstanceIndex);
	    gl_BaseInstanceARB = SPIRV_Cross_BaseInstance;
	    vPositionOs = stage_input.vPositionOs;
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
	DynamicCombo( D_MBOIT_PASS2, 0..1 );
	DynamicCombo( D_MBOIT_4_MOMENTS, 0..1 );
	DynamicCombo( D_DDA_MASK, 0..1 );
	DynamicCombo( D_SMOKE_FULLRES_PASS, 0..2 );
	DynamicCombo( D_SCOPE_CLIP, 0..1 );
	DynamicComboRule( Requires( D_MBOIT_4_MOMENTS, D_MBOIT_PASS2 ) );
	
	RenderState(StencilRef, 128);
	[[layer_constant]] ExternalDescriptorSet g_globalLateBoundBindlessSet < Source(ExternalDescSet); Attribute("g_globalLateBoundBindlessSet"); >;
	[[layer_constant]] ExternalDescriptorSet g_lightBinnerGpuSet < Source(ExternalDescSet); Attribute("g_lightBinnerGpuSet"); >;
	Texture2D g_tDepthTexture < Attribute("DepthCopy"); SrgbRead(false); >;
	Texture2D g_tExtra_Moment < Attribute("moments_extra"); SrgbRead(true); >;
	Texture2D g_tMoments < Attribute("moments"); SrgbRead(true); >;
	Texture2D g_tSceneDepthHalf < Attribute("SceneDepthHalf"); SrgbRead(false); >;
	Texture2D g_tSceneDepthQuarter < Attribute("SceneDepthQuarter"); SrgbRead(false); >;
	Texture2D g_tSmokeOppacityHalf < Attribute("SmokeOppacityHalf"); SrgbRead(false); >;
	Texture2D g_tSmokeOppacityQuarter < Attribute("SmokeOppacityQuarter"); SrgbRead(false); >;
	Texture3D g_tSmokeVolumeTexA_Atlas < Attribute("SmokeVolumeTexA_Atlas"); SrgbRead(false); >;
	Texture2D g_tZeroth_Moment < Attribute("zeroth_moment"); SrgbRead(true); >;
	float2 g_vScopeClip < Attribute("ScopeClip"); UiType(VectorText); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	static uint input_1;
	static float output_0;
	
	struct PS_INPUT
	{
	    nointerpolation uint input_1 : TEXCOORD1;
	};
	
	struct PS_OUTPUT
	{
	    float output_0 : SV_Target0;
	};
	
	void MainPs_inner()
	{
	    output_0 = float(1 << int(input_1));
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
