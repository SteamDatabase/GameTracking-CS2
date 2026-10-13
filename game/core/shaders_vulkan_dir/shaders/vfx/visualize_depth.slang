//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Expensive shader to visualize a depth texture";
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
	Feature( F_DEPTH_REMAP, 0..1, "Remap range of depth visualization" );
}

COMMON
{
	#include "system.fxc"
}

struct VS_INPUT
{
	float4 vColor      : COLOR0     < Semantic( Color ); >;                                        // D_IMGUI=1
	float4 vPositionPs : POSITION0  < Semantic( position ); >;                                    
	float4 vTexCoord   : TEXCOORD0  < Semantic( texcoord ); >;                                    
};

VS
{
	StaticCombo( S_REVERSE_DEPTH_BUFFER, 0..1 );
	DynamicCombo( D_IMGUI, 0..1 );
	
	float4 g_OrthoParams < Attribute("ImGuiOrthoParams"); UiType(VectorText); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	static float4 gl_Position;
	static float2 vTexCoord;
	static float2 vPositionPs;
	static float2 output_0;
	static float4 output_1;
	
	struct VS_INPUT
	{
	    float2 vPositionPs : POSITION0;
	    float2 vTexCoord : TEXCOORD0;
	};
	
	struct PS_INPUT
	{
	    float2 output_0 : TEXCOORD0;
	    float4 output_1 : TEXCOORD1;
	    float4 gl_Position : SV_Position;
	};
	
	void MainVs_inner()
	{
	    float4 _18022 = float4(vPositionPs.xy, 0.0f, 1.0f);
	    output_0 = vTexCoord;
	    output_1 = 1.0f.xxxx;
	    _18022.y = -vPositionPs.y;
	    gl_Position = _18022;
	}
	
	PS_INPUT MainVs(VS_INPUT stage_input)
	{
	    vTexCoord = stage_input.vTexCoord;
	    vPositionPs = stage_input.vPositionPs;
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
	StaticCombo( S_REVERSE_DEPTH_BUFFER, 0..1 );
	StaticCombo( S_DEPTH_REMAP, F_DEPTH_REMAP );
	DynamicCombo( D_IMGUI, 0..1 );
	DynamicCombo( D_VR_DEPTH_TEXTURE, 0..2 );
	
	int g_nCombinedSlicesMode < Attribute("g_nCombinedSlicesMode"); UiType(Slider); >;
	int g_nDepthSlice < Attribute("g_nDepthSlice"); UiType(Slider); >;
	Texture2D g_tDepthTexture < Attribute("InputTexture"); SrgbRead(false); >;
	
	
	// Variant parameters
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	static const float3 _2712[3] = { float3(1.0f, 0.0f, 0.0f), float3(0.0f, 1.0f, 0.0f), float3(0.0f, 0.0f, 1.0f) };
	static const float3 _2713[3] = { float3(1.0f, 0.0f, 0.0f), float3(0.0f, 1.0f, 0.0f), float3(0.0f, 0.0f, 1.0f) };
	
	cbuffer _Globals_ : register(b0, space1)
	{
	    int _Globals_1_g_nDepthSlice : packoffset(c0);
	    int _Globals_1_g_nCombinedSlicesMode : packoffset(c0.y);
	};
	
	Texture2D<float4> g_tDepthTexture : register(t30, space1);
	SamplerState AddressU_Clamp_AddressV_Clamp_AddressW_Clamp_Filter_MinMagMipPoint : register(s16, space1);
	
	static float2 input_0;
	static float4 output_0;
	
	struct PS_INPUT
	{
	    float2 input_0 : TEXCOORD0;
	};
	
	struct PS_OUTPUT
	{
	    float4 output_0 : SV_Target0;
	};
	
	void MainPs_inner()
	{
	    float4 _6805;
	    if (_Globals_1_g_nCombinedSlicesMode == 0)
	    {
	        _6805 = frac(g_tDepthTexture.SampleLevel(AddressU_Clamp_AddressV_Clamp_AddressW_Clamp_Filter_MinMagMipPoint, input_0.xy, float(_Globals_1_g_nDepthSlice)).x * 32.0f).xxxx;
	    }
	    else
	    {
	        float4 _12502;
	        if (_Globals_1_g_nCombinedSlicesMode == 1)
	        {
	            int _7603;
	            float3 _22743;
	            int _13039 = 9;
	            for (;;)
	            {
	                if (!(_13039 >= 0))
	                {
	                    _22743 = 0.0f.xxx;
	                    break;
	                }
	                if (frac(g_tDepthTexture.SampleLevel(AddressU_Clamp_AddressV_Clamp_AddressW_Clamp_Filter_MinMagMipPoint, input_0.xy, float(_13039)).x) > 0.0f)
	                {
	                    _22743 = _2712[_13039 - 3 * (_13039 / 3)];
	                    break;
	                }
	                _7603 = _13039 - 1;
	                _13039 = _7603;
	                continue;
	            }
	            _12502 = float4(_22743 * frac(g_tDepthTexture.SampleLevel(AddressU_Clamp_AddressV_Clamp_AddressW_Clamp_Filter_MinMagMipPoint, input_0.xy, 0.0f).x * 64.0f), 1.0f);
	        }
	        else
	        {
	            float4 _12501;
	            if (_Globals_1_g_nCombinedSlicesMode == 2)
	            {
	                float3 _13155;
	                _13155 = 0.0f.xxx;
	                float3 _5949;
	                int _18752;
	                int _16208 = 0;
	                for (;;)
	                {
	                    if (!(_16208 < 10))
	                    {
	                        break;
	                    }
	                    _5949 = _13155 + (_2713[_16208 - 3 * (_16208 / 3)] * frac(g_tDepthTexture.SampleLevel(AddressU_Clamp_AddressV_Clamp_AddressW_Clamp_Filter_MinMagMipPoint, input_0.xy, float(_16208)).x * 32.0f));
	                    _18752 = _16208 + 1;
	                    _13155 = _5949;
	                    _16208 = _18752;
	                    continue;
	                }
	                _12501 = float4(_13155, 1.0f);
	            }
	            else
	            {
	                _12501 = float4(0.0f, 0.0f, 0.0f, 1.0f);
	            }
	            _12502 = _12501;
	        }
	        _6805 = _12502;
	    }
	    output_0 = _6805;
	}
	
	PS_OUTPUT MainPs(PS_INPUT stage_input)
	{
	    input_0 = stage_input.input_0;
	    MainPs_inner();
	    PS_OUTPUT stage_output;
	    stage_output.output_0 = output_0;
	    return stage_output;
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
}
