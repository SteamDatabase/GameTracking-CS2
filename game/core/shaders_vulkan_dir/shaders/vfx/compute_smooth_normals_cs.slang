//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Compute Smooth Normals CS";
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
	DynamicCombo( D_COMPRESSED_NORMALS_AND_TANGENTS, 0..1 );
	DynamicCombo( D_PASS, 0..1 );
	DynamicCombo( D_SMOOTH_ACROSS_UV_SEAMS, 0..2 );
	DynamicCombo( D_COMPUTE_TENSION, 0..2 );
	
	int g_bIs16BitIB < Attribute("16BitIB"); UiType(Slider); >;
	float g_flCompressMultiplier < Attribute("CompressMultiplier"); UiType(Slider); >;
	float g_flStretchMultiplier < Attribute("StretchMultiplier"); UiType(Slider); >;
	ByteAddressBuffer g_inputIB < Attribute("InputIB"); >;
	ByteAddressBuffer g_inputVB < Attribute("InputVB"); >;
	ByteAddressBuffer g_inputVertAliasInfo < Attribute("InputVertAliasInfo"); >;
	int g_nAccumVBStartIndex < Attribute("TempBufferStartIndex"); UiType(Slider); >;
	int g_nInputIndexOffset < Attribute("InputIBOffset"); UiType(Slider); >;
	int g_nInputVertexSizeInBytes < Attribute("VertexSize"); UiType(Slider); >;
	int g_nSrcBufferOffset < Attribute("SourceBufferOffset"); UiType(Slider); >;
	int g_nTriCount < Attribute("TriCount"); UiType(Slider); >;
	int g_nVertAliasBufferOffset < Attribute("VertAliasBufferOffset"); UiType(Slider); >;
	int g_nVertexCacheStartIndex < Attribute("StartIndex"); UiType(Slider); >;
	int g_nVertexCount < Attribute("VertexCount"); UiType(Slider); >;
	RWBuffer<float4> g_normalAccumVB < Attribute("NormalAccumVB"); >;
	RWByteAddressBuffer g_vertexCacheVB < Attribute("VertexCacheVB"); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	cbuffer _Globals_ : register(b0, space0)
	{
	    uint _Globals_1_g_nInputIndexOffset : packoffset(c0);
	    uint _Globals_1_g_nTriCount : packoffset(c0.z);
	    uint _Globals_1_g_bIs16BitIB : packoffset(c0.w);
	    uint _Globals_1_g_nVertexCacheStartIndex : packoffset(c1);
	    uint _Globals_1_g_nAccumVBStartIndex : packoffset(c1.y);
	};
	
	ByteAddressBuffer g_inputIB : register(t35, space0);
	RWByteAddressBuffer g_vertexCacheVB : register(u158, space0);
	RWBuffer<int> g_normalAccumVB : register(u159, space0);
	
	static uint3 gl_GlobalInvocationID;
	struct SPIRV_Cross_Input
	{
	    uint3 gl_GlobalInvocationID : SV_DispatchThreadID;
	};
	
	void MainCs_inner()
	{
	    do
	    {
	        if (gl_GlobalInvocationID.x >= _Globals_1_g_nTriCount)
	        {
	            break;
	        }
	        uint _3851 = (_Globals_1_g_nInputIndexOffset + (gl_GlobalInvocationID.x * 3u)) * 4u;
	        bool _14874 = _Globals_1_g_bIs16BitIB != 0u;
	        uint _9848;
	        if (_14874)
	        {
	            _9848 = (_3851 >> uint(1)) & 4294967292u;
	        }
	        else
	        {
	            _9848 = _3851;
	        }
	        uint _6279 = _9848 / 4u;
	        uint _6751 = (_9848 + 4u) / 4u;
	        uint3 _19017;
	        if (_14874)
	        {
	            uint3 _12501;
	            if ((gl_GlobalInvocationID.x & 1u) != 0u)
	            {
	                uint3 _8989 = uint3(g_inputIB.Load<uint>(_6279 * 4 + 0) >> uint(16), g_inputIB.Load<uint>(_6751 * 4 + 0), g_inputIB.Load<uint>(_6751 * 4 + 0) >> uint(16));
	                _8989.y = g_inputIB.Load<uint>(_6751 * 4 + 0) & 65535u;
	                _12501 = _8989;
	            }
	            else
	            {
	                uint3 _13418 = uint3(g_inputIB.Load<uint>(_6279 * 4 + 0), g_inputIB.Load<uint>(_6751 * 4 + 0), g_inputIB.Load<uint>(_6751 * 4 + 0) & 65535u);
	                _13418.y = g_inputIB.Load<uint>(_6279 * 4 + 0) >> uint(16);
	                _13418.x = g_inputIB.Load<uint>(_6279 * 4 + 0) & 65535u;
	                _12501 = _13418;
	            }
	            _19017 = _12501;
	        }
	        else
	        {
	            _19017 = uint3(g_inputIB.Load<uint>(_6279 * 4 + 0), g_inputIB.Load<uint>(_6751 * 4 + 0), g_inputIB.Load<uint>(((_9848 + 8u) / 4u) * 4 + 0));
	        }
	        uint _11276 = (_19017.x + _Globals_1_g_nVertexCacheStartIndex) * 24u;
	        uint _6234 = g_vertexCacheVB.Load<uint>((_11276 / 4u) * 4 + 0);
	        uint _6235 = g_vertexCacheVB.Load<uint>(((_11276 + 4u) / 4u) * 4 + 0);
	        uint _14347 = g_vertexCacheVB.Load<uint>(((_11276 + 8u) / 4u) * 4 + 0);
	        float3 _11140 = asfloat(uint3(_6234, _6235, _14347));
	        uint _14492 = (_19017.y + _Globals_1_g_nVertexCacheStartIndex) * 24u;
	        uint _6236 = g_vertexCacheVB.Load<uint>((_14492 / 4u) * 4 + 0);
	        uint _6237 = g_vertexCacheVB.Load<uint>(((_14492 + 4u) / 4u) * 4 + 0);
	        uint _14348 = g_vertexCacheVB.Load<uint>(((_14492 + 8u) / 4u) * 4 + 0);
	        uint _14493 = (_19017.z + _Globals_1_g_nVertexCacheStartIndex) * 24u;
	        uint _6238 = g_vertexCacheVB.Load<uint>((_14493 / 4u) * 4 + 0);
	        uint _6239 = g_vertexCacheVB.Load<uint>(((_14493 + 4u) / 4u) * 4 + 0);
	        uint _14349 = g_vertexCacheVB.Load<uint>(((_14493 + 8u) / 4u) * 4 + 0);
	        uint3 _3334 = _19017.xyz + _Globals_1_g_nAccumVBStartIndex.xxx;
	        float3 _9771 = cross(asfloat(uint3(_6236, _6237, _14348)) - _11140, asfloat(uint3(_6238, _6239, _14349)) - _11140);
	        int3 _9071 = int3((_9771 / length(_9771).xxx).xyz * 32767.0f);
	        uint _9305 = 5u * _3334.x;
	        int _20720 = _9071.x;
	        int _11611;
	        InterlockedAdd(g_normalAccumVB[_9305], _20720, _11611);
	        int _23951 = _9071.y;
	        int _11612;
	        InterlockedAdd(g_normalAccumVB[_9305 + 1u], _23951, _11612);
	        int _23058 = _9071.z;
	        int _21110;
	        InterlockedAdd(g_normalAccumVB[_9305 + 2u], _23058, _21110);
	        uint _15663 = 5u * _3334.y;
	        int _17395;
	        InterlockedAdd(g_normalAccumVB[_15663], _20720, _17395);
	        int _14169;
	        InterlockedAdd(g_normalAccumVB[_15663 + 1u], _23951, _14169);
	        int _23668;
	        InterlockedAdd(g_normalAccumVB[_15663 + 2u], _23058, _23668);
	        uint _15664 = 5u * _3334.z;
	        int _17396;
	        InterlockedAdd(g_normalAccumVB[_15664], _20720, _17396);
	        int _14170;
	        InterlockedAdd(g_normalAccumVB[_15664 + 1u], _23951, _14170);
	        int _15879;
	        InterlockedAdd(g_normalAccumVB[_15664 + 2u], _23058, _15879);
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
