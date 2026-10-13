//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "CMAA2 Compute Shader";
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
	DynamicCombo( D_PASS, 0..5 );
	DynamicCombo( D_EXTRA_SHARPNESS, 0..1 );
	DynamicCombo( D_QUALITY, 0..3 );
	DynamicComboRule( Requires( D_QUALITY, D_PASS==2 ) );
	DynamicComboRule( Requires( D_EXTRA_SHARPNESS, D_PASS==2 ) );
	
	Texture2D g_inoutColorReadonly < Attribute("InColor"); SrgbRead(false); >;
	RWTexture2D<float4> g_inoutColorWriteonly < Attribute("OutColor"); >;
	RWBuffer<float4> g_workingControlBuffer < Attribute("ControlBuffer"); >;
	RWStructuredBuffer g_workingDeferredBlendItemList < Attribute("DeferredBlendItemList"); >;
	RWTexture2D<float4> g_workingDeferredBlendItemListHeads < Attribute("DeferredBlendItemListHead"); >;
	RWStructuredBuffer g_workingDeferredBlendLocationList < Attribute("DeferredBlendLocationList"); >;
	RWTexture2D<float4> g_workingEdges < Attribute("WorkingEdges"); >;
	Texture2D g_workingEdges < Attribute("WorkingEdges"); SrgbRead(false); >;
	RWBuffer<float4> g_workingExecuteIndirectBuffer < Attribute("DispatchParamBuffer"); >;
	RWStructuredBuffer g_workingShapeCandidates < Attribute("ShapeCandidates"); >;
	
	
	// Variant parameters
	RWTexture2D<float4> g_workingEdges < Attribute("WorkingEdges"); >;
	Texture2D g_workingEdges < Attribute("WorkingEdges"); SrgbRead(false); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	RWByteAddressBuffer g_workingShapeCandidates : register(u159, space0);
	RWBuffer<uint> g_workingControlBuffer : register(u163, space0);
	RWBuffer<uint> g_workingExecuteIndirectBuffer : register(u164, space0);
	
	void MainCs_inner()
	{
	    uint4 _3300 = g_workingControlBuffer[4].xxxx;
	    uint _11756;
	    g_workingShapeCandidates.GetDimensions(_11756);
	    _11756 = (_11756 - 0) / 4;
	    uint _20977 = min(_3300.x, _11756);
	    g_workingExecuteIndirectBuffer[0u] = ((_20977 + 127u) / 128u).x;
	    g_workingExecuteIndirectBuffer[1u] = uint4(1u, 1u, 1u, 1u).x;
	    g_workingExecuteIndirectBuffer[2u] = uint4(1u, 1u, 1u, 1u).x;
	    g_workingControlBuffer[3u] = _20977.x;
	}
	
	[numthreads(1, 1, 1)]
	void MainCs()
	{
	    MainCs_inner();
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
}
