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
	DynamicCombo( D_PASS, 0..5 );
	
	RWStructuredBuffer CBufferUAV < Attribute("CBufferUAV"); >;
	int CShiftBit < Attribute("CShiftBit"); UiType(Slider); >;
	RWStructuredBuffer DstBuffer < Attribute("DstBuffer"); >;
	RWStructuredBuffer DstPayload < Attribute("DstPayload"); >;
	RWStructuredBuffer IndirectDispatchArgs < Attribute("IndirectDispatchArgs"); >;
	int MaxThreadGroups < Attribute("MaxThreadGroups"); UiType(Slider); >;
	RWStructuredBuffer NumKeysBuffer < Attribute("NumKeysBuffer"); >;
	int NumKeysIndex < Attribute("NumKeysIndex"); UiType(Slider); >;
	RWStructuredBuffer ReduceScratchBuffer < Attribute("ReduceScratchBuffer"); >;
	RWStructuredBuffer ScratchBuffer < Attribute("ScratchBuffer"); >;
	RWStructuredBuffer SrcBuffer < Attribute("SrcBuffer"); >;
	RWStructuredBuffer SrcPayload < Attribute("SrcPayload"); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	struct _1059
	{
	    uint _m0;
	    int _m1;
	    uint _m2;
	    uint _m3;
	    uint _m4;
	    uint _m5;
	};
	
	RWByteAddressBuffer CBufferUAV : register(u158, space0);
	cbuffer _Globals_ : register(b0, space0)
	{
	    uint _Globals_1_CShiftBit : packoffset(c0.z);
	};
	
	RWByteAddressBuffer SrcBuffer : register(u159, space0);
	RWByteAddressBuffer ScratchBuffer : register(u163, space0);
	
	static uint3 gl_WorkGroupID;
	static uint3 gl_LocalInvocationID;
	struct SPIRV_Cross_Input
	{
	    uint3 gl_WorkGroupID : SV_GroupID;
	    uint3 gl_LocalInvocationID : SV_GroupThreadID;
	};
	
	groupshared uint _5770[2048];
	
	void MainCs_inner()
	{
	    uint _8524 = CBufferUAV.Load<uint>(0);
	    int _24369 = CBufferUAV.Load<int>(4);
	    uint _24370 = CBufferUAV.Load<uint>(8);
	    uint _6370 = CBufferUAV.Load<uint>(12);
	    int _23262;
	    int _13039 = 0;
	    for (;;)
	    {
	        if (!(_13039 < 16))
	        {
	            break;
	        }
	        _5770[uint(_13039 * 128) + gl_LocalInvocationID.x] = 0u;
	        _23262 = _13039 + 1;
	        _13039 = _23262;
	        continue;
	    }
	    GroupMemoryBarrierWithGroupSync();
	    uint _11457 = uint(512 * _24369) * gl_WorkGroupID.x;
	    uint _23756 = uint(_24369);
	    uint _21416 = _24370 - _6370;
	    uint _10913;
	    uint _17551;
	    if (gl_WorkGroupID.x >= _21416)
	    {
	        _10913 = _23756 + 1u;
	        _17551 = _11457 + ((gl_WorkGroupID.x - _21416) * 512u);
	    }
	    else
	    {
	        _10913 = _23756;
	        _17551 = _11457;
	    }
	    uint _8896 = _17551 + gl_LocalInvocationID.x;
	    uint _14392;
	    uint _23448;
	    uint _19582[4];
	    uint _13155 = _8896;
	    uint _16208 = 0u;
	    for (;;)
	    {
	        if (!(_16208 < _10913))
	        {
	            break;
	        }
	        _19582[0] = SrcBuffer.Load<uint>(_13155 * 4 + 0);
	        _19582[1] = SrcBuffer.Load<uint>((_13155 + 128u) * 4 + 0);
	        _19582[2] = SrcBuffer.Load<uint>((_13155 + 256u) * 4 + 0);
	        _19582[3] = SrcBuffer.Load<uint>((_13155 + 384u) * 4 + 0);
	        uint _8087;
	        uint _14382;
	        uint _13156 = _13155;
	        uint _16209 = 0u;
	        for (;;)
	        {
	            if (!(_16209 < 4u))
	            {
	                break;
	            }
	            if (_13156 < _8524)
	            {
	                uint _10058;
	                InterlockedAdd(_5770[(((_19582[_16209] >> _Globals_1_CShiftBit) & 15u) * 128u) + gl_LocalInvocationID.x], 1u, _10058);
	                _14382 = _13156 + 128u;
	            }
	            else
	            {
	                _14382 = _13156;
	            }
	            _8087 = _16209 + 1u;
	            _13156 = _14382;
	            _16209 = _8087;
	            continue;
	        }
	        _23448 = _16208 + 1u;
	        _14392 = _13155 + 512u;
	        _13155 = _14392;
	        _16208 = _23448;
	        continue;
	    }
	    GroupMemoryBarrierWithGroupSync();
	    if (gl_LocalInvocationID.x < 16u)
	    {
	        uint _13157;
	        _13157 = 0u;
	        uint _6321;
	        int _8559;
	        int _16210 = 0;
	        for (;;)
	        {
	            if (!(_16210 < 128))
	            {
	                break;
	            }
	            _6321 = _13157 + _5770[(gl_LocalInvocationID.x * 128u) + uint(_16210)];
	            _8559 = _16210 + 1;
	            _13157 = _6321;
	            _16210 = _8559;
	            continue;
	        }
	        ScratchBuffer.Store<uint>(((gl_LocalInvocationID.x * _24370) + gl_WorkGroupID.x) * 4 + 0, _13157);
	    }
	}
	
	[numthreads(128, 1, 1)]
	void MainCs(SPIRV_Cross_Input stage_input)
	{
	    gl_WorkGroupID = stage_input.gl_WorkGroupID;
	    gl_LocalInvocationID = stage_input.gl_LocalInvocationID;
	    MainCs_inner();
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
}
