//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Shader for compositing terrain layers";
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
	
	
	// Parameters
	float g_BlendAmount < Default(0.5); Attribute("BlendAmount"); UiType(Slider); UiGroup("Parameters"); >;
	float3 g_ColorTest < Default3(1, 1, 1); Attribute("ColorTest"); UiType(Color); UiGroup("Parameters"); >;
	float2 g_TestA < Attribute("Test Float2"); UiType(VectorText); UiGroup("Parameters"); >;
	float3 g_TestB < Attribute("Test Float3"); UiType(VectorText); UiGroup("Parameters"); >;
	bool g_TestBool < Default(1); Attribute("Test Bool"); UiType(CheckBox); UiGroup("Parameters"); >;
	float4 g_TestC < Attribute("Test Float4"); UiType(VectorText); UiGroup("Parameters"); >;
	int g_TestD < Attribute("Test Int"); UiType(Slider); UiGroup("Parameters"); >;
	float g_TestFloat < Attribute("Test Float"); UiType(Slider); UiGroup("Parameters"); >;
	
	// Inputs
	Texture2D g_tColorA < Attribute("InputA"); SrgbRead(false); >;
	Texture2D g_tColorB < Attribute("InputB"); SrgbRead(false); >;
	
	// SPIR-V reflection failed for backend HLSL:
	// cbuffer ID 5618 (name: _Globals_), member index 4 (name: g_TestB) cannot be expressed with either HLSL packing layout or packoffset.
	//
	// Re-attempting reflection with the GLSL backend.
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, GLSL reflection with SPIRV-Cross by KhronosGroup
	
	#version 460
	
	vec4 _2;
	
	struct _1419
	{
	    float g_BlendAmount;
	    vec3 g_ColorTest;
	    float g_TestFloat;
	    vec2 g_TestA;
	    vec3 g_TestB;
	    vec4 g_TestC;
	    int g_TestD;
	    int g_TestBool;
	};
	
	layout(set = 1) uniform _1419 _Globals_;
	
	layout(set = 1, binding = 30) uniform texture2D g_tColorA;
	layout(set = 1, binding = 14) uniform sampler Filter_MinMagMipLinear;
	layout(set = 1, binding = 31) uniform texture2D g_tColorB;
	layout(set = 1, binding = 15) uniform sampler Filter_MinMagMipLinear_1;
	
	layout(location = 0) in vec2 input_0;
	layout(location = 0) out vec4 output_0;
	
	void main()
	{
	    vec3 _7443 = ((((mix(texture(sampler2D(g_tColorA, Filter_MinMagMipLinear), input_0.xy).xyz, texture(sampler2D(g_tColorB, Filter_MinMagMipLinear_1), input_0.xy).xyz, vec3(_Globals_.g_BlendAmount)) + vec3(_Globals_.g_TestA.x)) + vec3(_Globals_.g_TestB.x)) + vec3(_Globals_.g_TestC.x)) + vec3(float(_Globals_.g_TestD))) + vec3(_Globals_.g_TestFloat);
	    vec4 _20488;
	    _20488.x = _7443.x;
	    _20488.y = _7443.y;
	    _20488.z = _7443.z;
	    vec4 _18787;
	    if (_Globals_.g_TestBool != 0)
	    {
	        vec3 _22157 = _20488.xyz + _Globals_.g_ColorTest;
	        vec4 _20489 = _20488;
	        _20489.x = _22157.x;
	        _20489.y = _22157.y;
	        _20489.z = _22157.z;
	        _18787 = _20489;
	    }
	    else
	    {
	        _18787 = _20488;
	    }
	    vec4 _23377 = _18787;
	    _23377.w = 1.0;
	    output_0 = _23377;
	}
	
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
	
	BoolAttribute(terrain_composite, true);
	
}
