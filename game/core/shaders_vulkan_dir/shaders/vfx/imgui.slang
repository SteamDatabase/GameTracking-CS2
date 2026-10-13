//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Shader to draw Dear ImGui";
	DevShader = true;
	Version = 0;
	
	// Platform: VULKAN_SM_50
	// Programs: ps, vs
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

struct VS_INPUT
{
	float4 vColor      : COLOR0     < Semantic( Color ); >;                                       
	float3 vPositionPs : POSITION0  < Semantic( PosXyz ); >;                                      
	float4 vUV         : TEXCOORD0  < Semantic( texcoord ); >;                                    
};

VS
{
	
	float4 g_OrthoParams < Attribute("ImGuiOrthoParams"); UiType(VectorText); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	cbuffer _Globals_ : register(b0, space0)
	{
	    float4 _Globals_1_g_OrthoParams : packoffset(c0);
	};
	
	
	static float4 gl_Position;
	static float2 vPositionPs;
	static float4 vColor;
	static float2 vUV;
	static float2 output_0;
	static float4 output_1;
	
	struct VS_INPUT
	{
	    float2 vPositionPs : POSITION0;
	    float2 vUV : TEXCOORD0;
	    float4 vColor : COLOR0;
	};
	
	struct PS_INPUT
	{
	    float2 output_0 : TEXCOORD0;
	    float4 output_1 : TEXCOORD1;
	    float4 gl_Position : SV_Position;
	};
	
	void MainVs_inner()
	{
	    float4 _23513 = mul(transpose(float4x4(float4(2.0f / (_Globals_1_g_OrthoParams.y - _Globals_1_g_OrthoParams.x), 0.0f, 0.0f, 0.0f), float4(0.0f, 2.0f / (_Globals_1_g_OrthoParams.z - _Globals_1_g_OrthoParams.w), 0.0f, 0.0f), float4(0.0f, 0.0f, 0.5f, 0.0f), float4((_Globals_1_g_OrthoParams.y + _Globals_1_g_OrthoParams.x) / (_Globals_1_g_OrthoParams.x - _Globals_1_g_OrthoParams.y), (_Globals_1_g_OrthoParams.z + _Globals_1_g_OrthoParams.w) / (_Globals_1_g_OrthoParams.w - _Globals_1_g_OrthoParams.z), 0.5f, 1.0f))), float4(vPositionPs.xy, 0.0f, 1.0f));
	    output_0 = vUV;
	    output_1 = vColor;
	    _23513.y = -_23513.y;
	    gl_Position = _23513;
	}
	
	PS_INPUT MainVs(VS_INPUT stage_input)
	{
	    vPositionPs = stage_input.vPositionPs;
	    vColor = stage_input.vColor;
	    vUV = stage_input.vUV;
	    MainVs_inner();
	    PS_INPUT stage_output;
	    stage_output.gl_Position = gl_Position;
	    stage_output.output_0 = output_0;
	    stage_output.output_1 = output_1;
	    return stage_output;
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
}

PS
{
	
	int g_ArrayArrayIndex < Attribute("ImGuiTextureArrayIndex"); UiType(Slider); >;
	float4 g_ChannelMask < Attribute("ImGuiChannelMask"); UiType(VectorText); >;
	float g_fTex3DZCoord < Attribute("ImGuiTex3DZ"); UiType(Slider); >;
	int g_nTexType < Attribute("ImGuiTexType"); UiType(Slider); >;
	Texture2D g_tex2D < Attribute("ImGuiTexture2D"); SrgbRead(false); >;
	Texture3D g_tex3D < Attribute("ImGuiTexture3D"); SrgbRead(false); >;
	Texture2DArray g_texArray < Attribute("ImGuiTextureArray"); SrgbRead(false); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	cbuffer _Globals_ : register(b0, space1)
	{
	    float4 _Globals_1_g_ChannelMask : packoffset(c0);
	    int _Globals_1_g_nTexType : packoffset(c1);
	    float _Globals_1_g_fTex3DZCoord : packoffset(c1.y);
	    int _Globals_1_g_ArrayArrayIndex : packoffset(c1.z);
	};
	
	Texture2D<float4> g_tex2D : register(t30, space1);
	SamplerState Filter_MinMagMipLinear : register(s14, space1);
	Texture3D<float4> g_tex3D : register(t31, space1);
	SamplerState Filter_MinMagMipLinear_1 : register(s15, space1);
	Texture2DArray<float4> g_texArray : register(t32, space1);
	SamplerState Filter_MinMagMipLinear_2 : register(s16, space1);
	
	static float2 input_0;
	static float4 input_1;
	static float4 output_0;
	
	struct PS_INPUT
	{
	    float2 input_0 : TEXCOORD0;
	    float4 input_1 : TEXCOORD1;
	};
	
	struct PS_OUTPUT
	{
	    float4 output_0 : SV_Target0;
	};
	
	void MainPs_inner()
	{
	    float4 _21709;
	    if (_Globals_1_g_nTexType == 0)
	    {
	        _21709 = g_tex2D.Sample(Filter_MinMagMipLinear, input_0.xy);
	    }
	    else
	    {
	        float4 _12502;
	        if (_Globals_1_g_nTexType == 1)
	        {
	            _12502 = g_tex3D.Sample(Filter_MinMagMipLinear_1, float3(input_0.xy, _Globals_1_g_fTex3DZCoord).xyz);
	        }
	        else
	        {
	            float4 _12501;
	            if (_Globals_1_g_nTexType == 2)
	            {
	                _12501 = g_texArray.Sample(Filter_MinMagMipLinear_2, float3(input_0.xy, float(_Globals_1_g_ArrayArrayIndex)).xyz);
	            }
	            else
	            {
	                _12501 = 0.0f.xxxx;
	            }
	            _12502 = _12501;
	        }
	        _21709 = _12502;
	    }
	    output_0 = input_1 * lerp(1.0f.xxxx, _21709, _Globals_1_g_ChannelMask);
	}
	
	PS_OUTPUT MainPs(PS_INPUT stage_input)
	{
	    input_0 = stage_input.input_0;
	    input_1 = stage_input.input_1;
	    MainPs_inner();
	    PS_OUTPUT stage_output;
	    stage_output.output_0 = output_0;
	    return stage_output;
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
}
