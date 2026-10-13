//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Rendergraph test";
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
	DynamicCombo( D_PASS, 0..1 );
	
	StructuredBuffer g_ForkBuffer_0 < Attribute("ForkBuffer_0"); >;
	StructuredBuffer g_ForkBuffer_1 < Attribute("ForkBuffer_1"); >;
	StructuredBuffer g_ForkBuffer_2 < Attribute("ForkBuffer_2"); >;
	StructuredBuffer g_ForkBuffer_3 < Attribute("ForkBuffer_3"); >;
	StructuredBuffer g_InputBuffer < Attribute("InputBuffer"); >;
	RWStructuredBuffer g_OutputBuffer < Attribute("OutputBuffer"); >;
	int g_nBranchCount < Attribute("BranchCount"); UiType(Slider); >;
	int g_nBranchOffset < Attribute("BranchOffset"); UiType(Slider); >;
	int g_nElementCount < Attribute("ElementCount"); UiType(Slider); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	cbuffer _Globals_ : register(b0, space0)
	{
	    int _Globals_1_g_nElementCount : packoffset(c0);
	    int _Globals_1_g_nBranchOffset : packoffset(c0.y);
	};
	
	RWByteAddressBuffer g_OutputBuffer : register(u158, space0);
	ByteAddressBuffer g_InputBuffer : register(t30, space0);
	
	static uint3 gl_GlobalInvocationID;
	struct SPIRV_Cross_Input
	{
	    uint3 gl_GlobalInvocationID : SV_DispatchThreadID;
	};
	
	void MainCs_inner()
	{
	    do
	    {
	        if (gl_GlobalInvocationID.x >= uint(_Globals_1_g_nElementCount))
	        {
	            break;
	        }
	        g_OutputBuffer.Store<uint>(gl_GlobalInvocationID.x * 4 + 0, g_InputBuffer.Load<uint>(gl_GlobalInvocationID.x * 4 + 0) + uint(_Globals_1_g_nBranchOffset));
	        break;
	    } while(false);
	}
	
	[numthreads(64, 1, 1)]
	void MainCs(SPIRV_Cross_Input stage_input)
	{
	    gl_GlobalInvocationID = stage_input.gl_GlobalInvocationID;
	    MainCs_inner();
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
}
