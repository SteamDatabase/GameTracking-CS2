//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "denoise blur for effects (compute)";
	DevShader = true;
	Version = 0;
	
	// Platform: VULKAN_SM_50
	// Programs: cs
}

MODES
{
	Default();
}

FEATURES
{
	Feature( F_BOX_KERNEL, 0..2 (0="No Blur", 1="9 pixels wide", 2="13 pixels wide"), "Box Kernel" );
}

COMMON
{
	#include "system.fxc"
}

CS
{
	StaticCombo( S_BOX_KERNEL, F_BOX_KERNEL );
	DynamicCombo( D_BLUR_Y, 0..1 );
	DynamicCombo( D_MSAA_DEPTH_BUFFER, 0..1 );
	
	RWTexture2D<float4> OutputTexture < Attribute("OutputTexture"); >;
	float g_flBlurZThresh < Default(0.002); UiType(Slider); >;
	Texture2D g_tGBufferDepth < Attribute("GBufferDepth"); SrgbRead(false); >;
	Texture2D g_tRawInput0 < Attribute("RawInput0"); SrgbRead(false); >;
	float4 g_vDepthBufferSize < Attribute("GBufferDepthSize"); UiType(VectorText); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	Texture2D<float4> g_tRawInput0 : register(t30, space0);
	RWTexture2D<unorm float4> OutputTexture : register(u158, space0);
	
	static uint3 gl_GlobalInvocationID;
	struct SPIRV_Cross_Input
	{
	    uint3 gl_GlobalInvocationID : SV_DispatchThreadID;
	};
	
	void MainCs_inner()
	{
	    OutputTexture[gl_GlobalInvocationID.xy] = g_tRawInput0.Load(int3(int3(int2(gl_GlobalInvocationID.xy), 0).xy, 0)).xyzw;
	}
	
	[numthreads(8, 8, 1)]
	void MainCs(SPIRV_Cross_Input stage_input)
	{
	    gl_GlobalInvocationID = stage_input.gl_GlobalInvocationID;
	    MainCs_inner();
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
}
