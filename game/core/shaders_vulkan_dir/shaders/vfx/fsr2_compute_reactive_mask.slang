//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Compute reactive mask for FSR2 upscaling";
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
	float3 vPositionSs : POSITION0  < Semantic( PosXyz ); >;                                      
};

VS
{
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	static float4 gl_Position;
	static float3 vPositionSs;
	
	struct VS_INPUT
	{
	    float3 vPositionSs : POSITION0;
	};
	
	struct PS_INPUT
	{
	    float4 gl_Position : SV_Position;
	};
	
	void MainVs_inner()
	{
	    float4 _22489 = float4(vPositionSs, 1.0f);
	    _22489.y = -vPositionSs.y;
	    gl_Position = _22489;
	}
	
	PS_INPUT MainVs(VS_INPUT stage_input)
	{
	    vPositionSs = stage_input.vPositionSs;
	    MainVs_inner();
	    PS_INPUT stage_output;
	    stage_output.gl_Position = gl_Position;
	    return stage_output;
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
}

PS
{
	DynamicCombo( D_DLSS_MODE, 0..1 );
	DynamicCombo( D_PREPROCESS_OPAQUE, 0..1 );
	DynamicCombo( D_OPAQUE_COLOR_TEXTURE_IS_PREPROCESSED, 0..1 );
	DynamicCombo( D_READ_GBUFFERS_FOR_REACTIVENESS, 0..1 );
	DynamicComboRule( Allow1( D_PREPROCESS_OPAQUE, D_OPAQUE_COLOR_TEXTURE_IS_PREPROCESSED ) );
	
	int g_bUseComponentsMax < Default(1); UiType(Slider); >;
	float g_flMinReactiveness < Default(0.2); Attribute("g_flMinReactiveness"); UiType(Slider); >;
	float g_flOutputScale < Default(1); UiType(Slider); >;
	Texture2D g_tGBuffer1 < Attribute("GBuffer1"); SrgbRead(false); >;
	Texture2D g_tOpaqueColor < Attribute("OpaqueColorTexture"); SrgbRead(false); >;
	Texture2D g_tOpaqueColor < Attribute("OpaqueColorTexture"); SrgbRead(true); >;
	Texture2D g_tTranslucentColor < Attribute("TranslucentColorTexture"); SrgbRead(false); >;
	
	
	// Variant parameters
	Texture2D g_tOpaqueColor < Attribute("OpaqueColorTexture"); SrgbRead(false); >;
	Texture2D g_tOpaqueColor < Attribute("OpaqueColorTexture"); SrgbRead(true); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	cbuffer _Globals_ : register(b0, space1)
	{
	    float _Globals_1_g_flOutputScale : packoffset(c0);
	    int _Globals_1_g_bUseComponentsMax : packoffset(c0.z);
	    float _Globals_1_g_flMinReactiveness : packoffset(c0.w);
	};
	
	Texture2D<float4> g_tOpaqueColor : register(t30, space1);
	Texture2D<float4> g_tTranslucentColor : register(t31, space1);
	
	static float4 gl_FragCoord;
	static float4 output_0;
	
	struct PS_INPUT
	{
	    float4 gl_FragCoord : SV_Position;
	};
	
	struct PS_OUTPUT
	{
	    float4 output_0 : SV_Target0;
	};
	
	void MainPs_inner()
	{
	    int2 _11700 = int3(int2(gl_FragCoord.xy), 0).xy;
	    float4 _19815 = g_tOpaqueColor.Load(int3(_11700, 0));
	    float4 _3300 = g_tTranslucentColor.Load(int3(_11700, 0));
	    float3 _14140 = abs((_3300.xyz / (max(max(0.0f, _3300.x), max(_3300.y, _3300.z)) + 1.0f).xxx) - (_19815.xyz / (max(max(0.0f, _19815.x), max(_19815.y, _19815.z)) + 1.0f).xxx));
	    float _21709;
	    if (_Globals_1_g_bUseComponentsMax != 0)
	    {
	        _21709 = max(_14140.x, max(_14140.y, _14140.z));
	    }
	    else
	    {
	        _21709 = length(_14140);
	    }
	    output_0 = max(_Globals_1_g_flMinReactiveness, ((_21709 * _Globals_1_g_flOutputScale) < 0.20000000298023223876953125f) ? 0.0f : 0.89999997615814208984375f).xxxx;
	}
	
	PS_OUTPUT MainPs(PS_INPUT stage_input)
	{
	    gl_FragCoord = stage_input.gl_FragCoord;
	    gl_FragCoord.w = 1.0 / gl_FragCoord.w;
	    MainPs_inner();
	    PS_OUTPUT stage_output;
	    stage_output.output_0 = output_0;
	    return stage_output;
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
}
