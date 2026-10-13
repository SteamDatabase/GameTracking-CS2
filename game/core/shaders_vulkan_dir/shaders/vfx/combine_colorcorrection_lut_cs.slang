//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Blend multiple color correction LUTs into a single LUT";
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
}

COMMON
{
	#include "system.fxc"
}

CS
{
	DynamicCombo( D_COLOR_CORRECTION_TEXTURE_COUNT, 0..4 );
	
	RWTexture3D<float4> OutputTexture < Attribute("OutputTexture"); >;
	Texture3D g_tColorCorrection0 < Attribute("ColorCorrectionTex0"); SrgbRead(false); >;
	Texture3D g_tColorCorrection1 < Attribute("ColorCorrectionTex1"); SrgbRead(false); >;
	Texture3D g_tColorCorrection2 < Attribute("ColorCorrectionTex2"); SrgbRead(false); >;
	Texture3D g_tColorCorrection3 < Attribute("ColorCorrectionTex3"); SrgbRead(false); >;
	Texture3D g_tColorCorrection4 < Attribute("ColorCorrectionTex4"); SrgbRead(false); >;
	Texture3D g_tColorCorrection5 < Attribute("ColorCorrectionTex5"); SrgbRead(false); >;
	Texture3D g_tColorCorrection6 < Attribute("ColorCorrectionTex6"); SrgbRead(false); >;
	Texture3D g_tColorCorrection7 < Attribute("ColorCorrectionTex7"); SrgbRead(false); >;
	float4 g_vColorCorrectionWeights0 < Attribute("ColorCorrectionWeights0"); UiType(VectorText); >;
	float4 g_vColorCorrectionWeights1 < Attribute("ColorCorrectionWeights1"); UiType(VectorText); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	cbuffer _Globals_ : register(b0, space0)
	{
	    float4 _Globals_1_g_vColorCorrectionWeights0 : packoffset(c0);
	};
	
	Texture3D<float4> g_tColorCorrection0 : register(t30, space0);
	RWTexture3D<float4> OutputTexture : register(u158, space0);
	
	static uint3 gl_GlobalInvocationID;
	struct SPIRV_Cross_Input
	{
	    uint3 gl_GlobalInvocationID : SV_DispatchThreadID;
	};
	
	void MainCs_inner()
	{
	    int4 _10344 = int4(uint4(gl_GlobalInvocationID.xyz, 0u));
	    OutputTexture[gl_GlobalInvocationID.xyz] = float4((g_tColorCorrection0.Load(int4(_10344.xyz, _10344.w)).xyz * _Globals_1_g_vColorCorrectionWeights0.x).xyz, 1.0f);
	}
	
	[numthreads(4, 4, 4)]
	void MainCs(SPIRV_Cross_Input stage_input)
	{
	    gl_GlobalInvocationID = stage_input.gl_GlobalInvocationID;
	    MainCs_inner();
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
}
