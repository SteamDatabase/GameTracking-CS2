//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Texture Generator for Object-Space Normal Map";
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
	uint4  nPackedFrame               : NORMAL0    < Semantic( CompressedTangentFrame ); >;       
	float4 vNormalOs                  : NORMAL0    < Semantic( Normal ); >;                       
	float4 vTangentUOs_flTangentVSign : TANGENT0   < Semantic( TangentU_SignV ); >;               
	float2 vTexCoord                  : TEXCOORD0  < Semantic( LowPrecisionUv ); >;               
};

VS
{
	DynamicCombo( D_COMPRESSED_NORMALS_AND_TANGENTS, 0..1 );
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	static float4 gl_Position;
	static float2 vTexCoord;
	static float3 vNormalOs;
	static float4 vTangentUOs_flTangentVSign;
	static float3 output_0;
	static float2 output_1;
	static float3 output_2;
	static float3 output_3;
	
	struct VS_INPUT
	{
	    float2 vTexCoord : TEXCOORD0;
	    float3 vNormalOs : NORMAL0;
	    float4 vTangentUOs_flTangentVSign : TANGENT0;
	};
	
	struct PS_INPUT
	{
	    float3 output_0 : TEXCOORD0;
	    float2 output_1 : TEXCOORD1;
	    float3 output_2 : TEXCOORD2;
	    float3 output_3 : TEXCOORD3;
	    float4 gl_Position : SV_Position;
	};
	
	void MainVs_inner()
	{
	    float2 _7080 = (float2(vTexCoord.x, 1.0f - vTexCoord.y) - 0.5f.xx) * 2.0f;
	    float4 _14437 = float4(_7080, 1.0f, 1.0f);
	    float3 _24772 = normalize(vTangentUOs_flTangentVSign.xyz - (vNormalOs.xyz * dot(vTangentUOs_flTangentVSign.xyz, vNormalOs.xyz)));
	    output_0 = vNormalOs;
	    output_1 = vTexCoord.xy;
	    output_2 = _24772;
	    output_3 = cross(vNormalOs.xyz, _24772.xyz) * vTangentUOs_flTangentVSign.w;
	    _14437.y = -_7080.y;
	    gl_Position = _14437;
	}
	
	PS_INPUT MainVs(VS_INPUT stage_input)
	{
	    vTexCoord = stage_input.vTexCoord;
	    vNormalOs = stage_input.vNormalOs;
	    vTangentUOs_flTangentVSign = stage_input.vTangentUOs_flTangentVSign;
	    MainVs_inner();
	    PS_INPUT stage_output;
	    stage_output.gl_Position = gl_Position;
	    stage_output.output_0 = output_0;
	    stage_output.output_1 = output_1;
	    stage_output.output_2 = output_2;
	    stage_output.output_3 = output_3;
	    return stage_output;
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
}

PS
{
	DynamicCombo( D_NORMALMAP_FROM_ATTR, 0..1 );
	
	Texture2D g_tNormalFromAttr < Attribute("NormalMap"); SrgbRead(false); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	static float3 input_0;
	static float4 output_0;
	
	struct PS_INPUT
	{
	    float3 input_0 : TEXCOORD0;
	};
	
	struct PS_OUTPUT
	{
	    float4 output_0 : SV_Target0;
	};
	
	void MainPs_inner()
	{
	    float3 _9441 = 0.5f.xxx + (normalize((input_0.xyz * 1.0f).xyz) * 0.5f);
	    output_0 = float4(_9441.y, 1.0f - _9441.x, _9441.z, 1.0f);
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
