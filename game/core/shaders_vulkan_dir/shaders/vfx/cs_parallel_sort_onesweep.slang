//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Sort something on the GPU.";
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
	DynamicCombo( D_PASS, 0..4 );
	DynamicCombo( D_16_BIT_KEYS, 0..1 );
	DynamicComboRule( Requires( D_16_BIT_KEYS, D_PASS==1 ) );
	
	RWStructuredBuffer b_alt < Attribute("AltSortBuffer"); >;
	RWStructuredBuffer b_altPayload < Attribute("AltPayloadBuffer"); >;
	RWStructuredBuffer b_globalHist < Attribute("GlobalHistBuffer"); >;
	RWStructuredBuffer b_index < Attribute("PassIndexBuffer"); >;
	RWStructuredBuffer b_passHist < Attribute("PassHistBuffer"); >;
	RWStructuredBuffer b_sort < Attribute("SortBuffer"); >;
	RWStructuredBuffer b_sortPayload < Attribute("PayloadBuffer"); >;
	StructuredBuffer g_constantBuffer < Attribute("DispatchArgBuffer"); >;
	RWStructuredBuffer g_dispatchBuffer < Attribute("DispatchArgBuffer"); >;
	int g_nFixedKeyCount < Attribute("FixedKeyCount"); UiType(Slider); >;
	int g_nKeyCountBufferOffset < Attribute("NumKeysIndex"); UiType(Slider); >;
	int g_nPartitionSize < Attribute("PartitionSize"); UiType(Slider); >;
	int g_nRadixPasses < Attribute("RadixPasses"); UiType(Slider); >;
	RWStructuredBuffer g_numKeysBuffer < Attribute("NumKeysBuffer"); >;
	
	
	// Variant parameters
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	struct _990
	{
	    uint _m0;
	    uint _m1;
	};
	
	struct _2511
	{
	    _990 _m0[4];
	};
	
	struct _1002
	{
	    uint _m0;
	    uint _m1;
	    uint _m2;
	};
	
	struct _316
	{
	    _1002 _m0[4];
	};
	
	struct _883
	{
	    _2511 _m0;
	    _316 _m1;
	};
	
	ByteAddressBuffer g_constantBuffer : register(t30, space0);
	globallycoherent RWByteAddressBuffer b_passHist : register(u163, space0);
	RWByteAddressBuffer b_globalHist : register(u162, space0);
	globallycoherent RWByteAddressBuffer b_index : register(u164, space0);
	cbuffer g_consts
	{
	    uint g_consts_1_m0 : packoffset(c0);
	};
	
	
	static uint3 gl_GlobalInvocationID;
	struct SPIRV_Cross_Input
	{
	    uint3 gl_GlobalInvocationID : SV_DispatchThreadID;
	};
	
	void MainCs_inner()
	{
	    uint _20090 = g_constantBuffer.Load<uint>(g_consts_1_m0 * 8 + 4) * 1024u;
	    uint _4283;
	    uint _13039 = gl_GlobalInvocationID.x;
	    for (;;)
	    {
	        if (!(_13039 < _20090))
	        {
	            break;
	        }
	        b_passHist.Store<uint>(_13039 * 4 + 0, 0u);
	        _4283 = _13039 + 65536u;
	        _13039 = _4283;
	        continue;
	    }
	    if (gl_GlobalInvocationID.x < 1024u)
	    {
	        b_globalHist.Store<uint>(gl_GlobalInvocationID.x * 4 + 0, 0u);
	    }
	    if (gl_GlobalInvocationID.x < 4u)
	    {
	        b_index.Store<uint>(gl_GlobalInvocationID.x * 4 + 0, 0u);
	    }
	}
	
	[numthreads(256, 1, 1)]
	void MainCs(SPIRV_Cross_Input stage_input)
	{
	    gl_GlobalInvocationID = stage_input.gl_GlobalInvocationID;
	    MainCs_inner();
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
}
