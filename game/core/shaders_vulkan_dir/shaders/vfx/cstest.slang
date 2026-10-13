//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Compute shader test";
	DevShader = true;
	Version = 0;
	
	// Platform: VULKAN_SM_60
	// Programs: cs
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

CS
{
	DynamicCombo( D_INLINE_RTX_TEST, 0..1 );
	DynamicCombo( D_INLINE_RTX_TEST_VARIANT, 0..1 );
	DynamicCombo( D_CUBEMAP_TEST, 0..1 );
	DynamicCombo( D_TEST_VARIANT, 0..1 );
	DynamicComboRule( Requires( D_CUBEMAP_TEST, D_TEST_VARIANT==0 ) );
	DynamicComboRule( Requires( D_CUBEMAP_TEST, D_INLINE_RTX_TEST==0 ) );
	DynamicComboRule( Requires( D_INLINE_RTX_TEST, D_TEST_VARIANT==0 ) );
	DynamicComboRule( Requires( D_INLINE_RTX_TEST_VARIANT, D_INLINE_RTX_TEST==1 ) );
	
	StructuredBuffer Buffer0 < Attribute("Buffer0"); >;
	StructuredBuffer Buffer1 < Attribute("Buffer1"); >;
	Buffer Buffer2 < Attribute("Buffer2"); SrgbRead(false); >;
	RWTexture2D<float4> OutputTexture < Attribute("OutputUAV"); >;
	RWTexture2D<float4>[] g_CubemapUAV < Attribute("CubemapUAV"); >;
	ExternalDescriptorSet g_rtxTestDescriptorSet < Source(ExternalDescSet); Attribute("g_rtxTestDescriptorSet"); >;
	float2 vOutputSize < Attribute("OutputSize"); UiType(VectorText); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	struct _1080
	{
	    float4 _m0;
	    float4 _m1;
	};
	
	cbuffer Dimensions_t : register(b0, space0)
	{
	    uint Dimensions_t_1_m0 : packoffset(c0);
	};
	
	ByteAddressBuffer Buffer0 : register(t30, space0);
	ByteAddressBuffer Buffer1 : register(t31, space0);
	Buffer<float4> Buffer2 : register(t32, space0);
	RWTexture2D<float4> OutputTexture : register(u158, space0);
	
	static uint3 gl_GlobalInvocationID;
	struct SPIRV_Cross_Input
	{
	    uint3 gl_GlobalInvocationID : SV_DispatchThreadID;
	};
	
	void MainCs_inner()
	{
	    uint _7595 = (gl_GlobalInvocationID.y * Dimensions_t_1_m0) + gl_GlobalInvocationID.x;
	    OutputTexture[gl_GlobalInvocationID.xy] = ((Buffer0.Load<float4>(_7595 * 32 + 0) + Buffer0.Load<float4>(_7595 * 32 + 16)) + (Buffer1.Load<float4>(_7595 * 32 + 0) + Buffer1.Load<float4>(_7595 * 32 + 16))) + Buffer2.Load(int(_7595));
	}
	
	[numthreads(32, 32, 1)]
	void MainCs(SPIRV_Cross_Input stage_input)
	{
	    gl_GlobalInvocationID = stage_input.gl_GlobalInvocationID;
	    MainCs_inner();
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
}
