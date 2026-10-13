//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Terrain composite shader which computes the slope of the input displacement or heightmap";
	DevShader = true;
	Version = 0;
	
	// Platform: VULKAN_SM_50
	// Programs: ps, vs
}

MODES
{
	Default();
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
	float3 vPosition : POSITION0  < Semantic( PosXyz ); >;                                        
	float2 vTexCoord : TEXCOORD0  < Semantic( LowPrecisionUv ); >;                                
};

VS
{
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	static float _2;
	
	static float4 gl_Position;
	static float3 vPosition;
	static float2 vTexCoord;
	static float2 output_0;
	
	struct VS_INPUT
	{
	    float3 vPosition : POSITION0;
	    float2 vTexCoord : TEXCOORD0;
	};
	
	struct PS_INPUT
	{
	    float2 output_0 : TEXCOORD0;
	    float4 gl_Position : SV_Position;
	};
	
	void MainVs_inner()
	{
	    float4 _14456 = float4(vPosition.x, _2, 1.0f, 1.0f);
	    output_0 = vTexCoord;
	    _14456.y = vPosition.y;
	    gl_Position = _14456;
	}
	
	PS_INPUT MainVs(VS_INPUT stage_input)
	{
	    vPosition = stage_input.vPosition;
	    vTexCoord = stage_input.vTexCoord;
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
	
	float3 g_vDisplacementScale < Attribute("DisplacementScale"); UiType(VectorText); >;
	float2 g_vLayerSize < Attribute("LayerSize"); UiType(VectorText); >;
	
	// Inputs
	Texture2D g_tDisplacement < Attribute("Displacement Map"); SrgbRead(false); >;
	
	// SPIR-V reflection failed for backend HLSL:
	// cbuffer ID 5618 (name: _Globals_), member index 1 (name: g_vLayerSize) cannot be expressed with either HLSL packing layout or packoffset.
	//
	// Re-attempting reflection with the GLSL backend.
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, GLSL reflection with SPIRV-Cross by KhronosGroup
	
	#version 460
	#extension GL_EXT_samplerless_texture_functions : require
	
	const vec2 _852[8] = vec2[](vec2(-1.0), vec2(0.0, -1.0), vec2(1.0, -1.0), vec2(1.0, 0.0), vec2(1.0), vec2(0.0, 1.0), vec2(-1.0, 1.0), vec2(-1.0, 0.0));
	
	struct _1040
	{
	    vec3 g_vDisplacementScale;
	    vec2 g_vLayerSize;
	};
	
	layout(set = 1) uniform _1040 _Globals_;
	
	layout(set = 1, binding = 30) uniform texture2D g_tDisplacement;
	layout(set = 1, binding = 14) uniform sampler AddressU_Clamp_AddressV_Clamp_Filter_MinMagMipPoint;
	
	layout(location = 0) in vec2 input_0;
	layout(location = 0) out vec4 output_0;
	
	void main()
	{
	    vec4 _19414 = texture(sampler2D(g_tDisplacement, AddressU_Clamp_AddressV_Clamp_Filter_MinMagMipPoint), input_0.xy);
	    vec3 _20688 = _19414.zyx * _Globals_.g_vDisplacementScale;
	    float _13155;
	    _13155 = 0.0;
	    int _4505;
	    float _17213;
	    int _16208 = 0;
	    for (;;)
	    {
	        if (!(_16208 < 8))
	        {
	            break;
	        }
	        uvec2 _10352 = uvec2(textureSize(g_tDisplacement, int(0u)));
	        vec2 _19607 = vec2(1.0) / vec2(ivec2(int(_10352.x), int(_10352.y)));
	        vec3 _10323 = abs(_20688 - (vec3((_19607 * _Globals_.g_vLayerSize) * _852[_16208], 0.0) + (texture(sampler2D(g_tDisplacement, AddressU_Clamp_AddressV_Clamp_Filter_MinMagMipPoint), (input_0 + (_19607 * _852[_16208])).xy).zyx * _Globals_.g_vDisplacementScale)));
	        float _23793 = _10323.z;
	        _17213 = max(_13155, (_23793 * _23793) / dot(_10323, _10323));
	        _4505 = _16208 + 1;
	        _13155 = _17213;
	        _16208 = _4505;
	        continue;
	    }
	    output_0 = vec4(_13155, _13155, _13155, 1.0);
	}
	
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
	
	BoolAttribute(terrain_composite, true);
	
}
