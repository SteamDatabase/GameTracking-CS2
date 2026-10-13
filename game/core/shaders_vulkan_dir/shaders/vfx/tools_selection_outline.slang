//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Shader to draw the selection outline in hammer";
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
	DynamicCombo( D_DEPTH_OUTLINE, 0..1 );
	DynamicCombo( D_MSAA_MODE, 0..2 );
	DynamicComboRule( Requires( D_MSAA_MODE, D_DEPTH_OUTLINE ) );
	
	Texture2D g_tDepth < Attribute("DepthBuffer"); SrgbRead(false); >;
	Texture2D g_tInput < Attribute("InputTexture"); SrgbRead(false); >;
	float4 g_vOccludedColorA < Default4(1, 1, 1, 0.25); Attribute("OccludedColorA"); UiType(VectorText); >;
	float4 g_vOccludedColorB < Default4(1, 1, 1, 0.25); Attribute("OccludedColorB"); UiType(VectorText); >;
	float4 g_vOutlineColorA < Default4(1, 1, 1, 1); Attribute("OutlineColorA"); UiType(VectorText); >;
	float4 g_vOutlineColorB < Default4(1, 1, 1, 1); Attribute("OutlineColorB"); UiType(VectorText); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	cbuffer _Globals_ : register(b0, space1)
	{
	    float4 _Globals_1_g_vOutlineColorA : packoffset(c1);
	    float4 _Globals_1_g_vOccludedColorA : packoffset(c2);
	    float4 _Globals_1_g_vOutlineColorB : packoffset(c3);
	    float4 _Globals_1_g_vOccludedColorB : packoffset(c4);
	};
	
	Texture2D<float4> g_tInput : register(t30, space1);
	
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
	    float4 _8785 = (((((((g_tInput.Load(int3(int3(int2(gl_FragCoord.xy + float2(0.0f, 1.0f)), 0).xy, 0)) + g_tInput.Load(int3(int3(int2(gl_FragCoord.xy + float2(0.0f, -1.0f)), 0).xy, 0))) + g_tInput.Load(int3(int3(int2(gl_FragCoord.xy + float2(1.0f, 0.0f)), 0).xy, 0))) + g_tInput.Load(int3(int3(int2(gl_FragCoord.xy + float2(-1.0f, 0.0f)), 0).xy, 0))) + g_tInput.Load(int3(int3(int2(gl_FragCoord.xy + float2(-1.0f, 1.0f)), 0).xy, 0))) + g_tInput.Load(int3(int3(int2(gl_FragCoord.xy + (-1.0f).xx), 0).xy, 0))) + g_tInput.Load(int3(int3(int2(gl_FragCoord.xy + 1.0f.xx), 0).xy, 0))) + g_tInput.Load(int3(int3(int2(gl_FragCoord.xy + float2(1.0f, -1.0f)), 0).xy, 0))) * 0.25f;
	    float4 _19339 = clamp(_8785, 0.0f.xxxx, 1.0f.xxxx);
	    float2 _5881 = _19339.xz * (1.0f.xx - clamp(g_tInput.Load(int3(int3(int2(gl_FragCoord.xy), 0).xy, 0)) * (_8785 - 1.0f.xxxx), 0.0f.xxxx, 1.0f.xxxx).xz);
	    float _21313 = _5881.x;
	    float _9280 = _5881.y;
	    float _24746 = max(_21313, _9280);
	    if ((_24746 - 0.001000000047497451305389404296875f) < 0.0f)
	    {
	        discard;
	    }
	    float4 _15104 = lerp(lerp(_Globals_1_g_vOccludedColorA, _Globals_1_g_vOutlineColorA, _19339.y.xxxx), lerp(_Globals_1_g_vOccludedColorB, _Globals_1_g_vOutlineColorB, _19339.w.xxxx), ((_21313 > _9280) ? 0.0f : 1.0f).xxxx);
	    _15104.w = _15104.w * _24746;
	    output_0 = _15104;
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
