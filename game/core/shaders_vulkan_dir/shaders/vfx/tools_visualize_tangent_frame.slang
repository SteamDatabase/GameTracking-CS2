//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Debug shader that render normals or tangent space as lines";
	DevShader = true;
	Version = 0;
	
	// Platform: VULKAN_SM_50
	// Programs: gs, ps, vs
}

MODES
{
	ToolsWireframe(S_MODE_TOOLS_WIREFRAME);
	ToolsUtil(S_MODE_FORWARD);
}

FEATURES
{
	Feature( F_SHOW_TANGENTS, 0..1, "General" );
	Feature( F_SHOW_BENT_NORMALS, 0..1, "General" );
}

COMMON
{
	#include "system.fxc"
}

struct VS_INPUT
{
	uint4  nPackedFrame               : NORMAL0        < Semantic( CompressedTangentFrame ); >;    // D_COMPRESSED_NORMALS_AND_TANGENTS=1
	float4 vBlendIndices              : BLENDINDICES0  < Semantic( BlendIndices ); >;              // D_BLEND_WEIGHT_COUNT=1, D_BLEND_WEIGHT_COUNT=2, D_BLEND_WEIGHT_COUNT=3, D_BLEND_WEIGHT_COUNT=4
	float4 vTangentUOs_flTangentVSign : TANGENT0       < Semantic( TangentU_SignV ); >;           
	float4 vBlendWeight               : BLENDWEIGHT0   < Semantic( BlendWeight ); >;               // D_BLEND_WEIGHT_COUNT=2, D_BLEND_WEIGHT_COUNT=3, D_BLEND_WEIGHT_COUNT=4
	uint4  nVertexIndex               : TEXCOORD14     < Semantic( MorphIndex ); >;                // D_MORPH=1
	float4 vNormalOs                  : NORMAL0        < Semantic( Normal ); >;                    // D_COMPRESSED_NORMALS_AND_TANGENTS=0
	float3 vPositionOs                : POSITION0      < Semantic( PosXyz ); >;                   
	float2 nInstanceIdx               : TEXCOORD13     < Semantic( InstanceTransformUv ); >;      
};

VS
{
	StaticCombo( S_MODE_FORWARD, 0..1 );
	StaticCombo( S_MODE_TOOLS_WIREFRAME, 0..1 );
	StaticCombo( S_SHOW_TANGENTS, F_SHOW_TANGENTS );
	StaticCombo( S_SHOW_BENT_NORMALS, F_SHOW_BENT_NORMALS );
	StaticComboRule( Allow1( S_MODE_FORWARD, S_MODE_TOOLS_WIREFRAME ) );
	StaticComboRule( Allow1( S_SHOW_BENT_NORMALS, S_SHOW_BENT_NORMALS ) );
	DynamicCombo( D_BLEND_WEIGHT_COUNT, 0..4 );
	DynamicCombo( D_COMPRESSED_NORMALS_AND_TANGENTS, 0..1 );
	DynamicCombo( D_MORPH, 0..1 );
	
	[[layer_constant]] StructuredBuffer g_instanceBuffer < Attribute("InstanceBuffer"); >;
	Texture2D g_tCompositeMorphTextureAtlas < Attribute("CompositeMorphTextureAtlas"); SrgbRead(false); >;
	[[layer_constant]] StructuredBuffer g_transformBuffer < Attribute("TransformBuffer"); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	struct _1125
	{
	    uint _m0;
	    uint _m1;
	    uint _m2;
	    uint _m3;
	    uint _m4;
	    uint _m5;
	    uint _m6;
	    float _m7;
	};
	
	struct _1119
	{
	    row_major float3x4 _m0;
	};
	
	ByteAddressBuffer g_instanceBuffer : register(t32, space0);
	ByteAddressBuffer g_transformBuffer : register(t30, space0);
	
	static float3 vPositionOs;
	static float3 vNormalOs;
	static uint nInstanceIdx;
	static float3 output_0;
	static float3 output_1;
	
	struct VS_INPUT
	{
	    float3 vPositionOs : POSITION0;
	    float3 vNormalOs : NORMAL0;
	    uint nInstanceIdx : TEXCOORD13;
	};
	
	struct PS_INPUT
	{
	    float3 output_0 : TEXCOORD0;
	    float3 output_1 : TEXCOORD1;
	};
	
	void MainVs_inner()
	{
	    float3x4 _9216 = float3x4(g_transformBuffer.Load<float4>(g_instanceBuffer.Load<uint>(nInstanceIdx * 32 + 4) * 48 + 0), g_transformBuffer.Load<float4>(g_instanceBuffer.Load<uint>(nInstanceIdx * 32 + 4) * 48 + 16), g_transformBuffer.Load<float4>(g_instanceBuffer.Load<uint>(nInstanceIdx * 32 + 4) * 48 + 32));
	    output_0 = mul(_9216, float4(vPositionOs.xyz, 1.0f));
	    output_1 = normalize(mul(_9216, float4(vNormalOs.xyz, 0.0f)));
	}
	
	PS_INPUT MainVs(VS_INPUT stage_input)
	{
	    vPositionOs = stage_input.vPositionOs;
	    vNormalOs = stage_input.vNormalOs;
	    nInstanceIdx = stage_input.nInstanceIdx;
	    MainVs_inner();
	    PS_INPUT stage_output;
	    stage_output.output_0 = output_0;
	    stage_output.output_1 = output_1;
	    return stage_output;
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
}

GS
{
	StaticCombo( S_SHOW_TANGENTS, F_SHOW_TANGENTS );
	StaticCombo( S_SHOW_BENT_NORMALS, F_SHOW_BENT_NORMALS );
	
	float g_flVectorLength < Default(1); Range(0, 1000); UiType(Slider); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	cbuffer PerViewConstantBuffer_t : register(b1, space2)
	{
	    column_major float4x4 PerViewConstantBuffer_t_1_m0 : packoffset(c0);
	    float4 PerViewConstantBuffer_t_1_m1 : packoffset(c24);
	};
	
	cbuffer _Globals_ : register(b0, space2)
	{
	    float _Globals_1_g_flVectorLength : packoffset(c0);
	};
	
	
	static float4 gl_Position;
	static float3 input_0[3];
	static float3 input_1[3];
	static float3 output_0;
	
	struct SPIRV_Cross_Input
	{
	    float3 input_0 : TEXCOORD0;
	    float3 input_1 : TEXCOORD1;
	};
	
	struct SPIRV_Cross_Output
	{
	    float3 output_0 : TEXCOORD0;
	    float4 gl_Position : SV_Position;
	};
	
	void MainGs_inner(triangle SPIRV_Cross_Input stage_input[3], inout LineStream<SPIRV_Cross_Output> geometry_stream)
	{
	    int _10337;
	    int _13039 = 0;
	    for (;;)
	    {
	        if (!(_13039 < 3))
	        {
	            break;
	        }
	        float4 _21447 = PerViewConstantBuffer_t_1_m1 * 1.0f;
	        float4 _18241 = mul(PerViewConstantBuffer_t_1_m0, (float4(input_0[_13039].xyz, 1.0f) + _21447).xyzw);
	        output_0 = float3(0.0f, 0.0f, 1.0f);
	        _18241.y = -_18241.y;
	        gl_Position = _18241;
	        {
	            SPIRV_Cross_Output stage_output;
	            stage_output.gl_Position = gl_Position;
	            stage_output.output_0 = output_0;
	            geometry_stream.Append(stage_output);
	        }
	        float4 _8486 = mul(PerViewConstantBuffer_t_1_m0, (float4((input_0[_13039].xyz + (input_1[_13039].xyz * _Globals_1_g_flVectorLength)).xyz, 1.0f) + _21447).xyzw);
	        output_0 = float3(0.300000011920928955078125f, 0.300000011920928955078125f, 1.0f);
	        _8486.y = -_8486.y;
	        gl_Position = _8486;
	        {
	            SPIRV_Cross_Output stage_output;
	            stage_output.gl_Position = gl_Position;
	            stage_output.output_0 = output_0;
	            geometry_stream.Append(stage_output);
	        }
	        geometry_stream.RestartStrip();
	        _10337 = _13039 + 1;
	        _13039 = _10337;
	        continue;
	    }
	}
	
	[maxvertexcount(6)]
	void MainGs(triangle SPIRV_Cross_Input stage_input[3], inout LineStream<SPIRV_Cross_Output> geometry_stream)
	{
	    for (int i = 0; i < 3; i++)
	    {
	        input_0[i] = stage_input[i].input_0;
	    }
	    for (int i = 0; i < 3; i++)
	    {
	        input_1[i] = stage_input[i].input_1;
	    }
	    MainGs_inner(stage_input, geometry_stream);
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
}

PS
{
	
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
	    output_0 = float4(input_0.xyz, 1.0f);
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
