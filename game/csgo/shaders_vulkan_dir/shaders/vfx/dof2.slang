//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "DOF2 shader";
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
	float4 vPositionPs : POSITION0  < Semantic( position ); >;                                    
	float4 vTexCoord   : TEXCOORD0  < Semantic( texcoord ); >;                                    
};

VS
{
	DynamicCombo( D_WRITE_COC, 0..1 );
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	static float4 gl_Position;
	static float2 vPositionPs;
	static float2 vTexCoord;
	static float2 output_0;
	
	struct VS_INPUT
	{
	    float2 vPositionPs : POSITION0;
	    float2 vTexCoord : TEXCOORD0;
	};
	
	struct PS_INPUT
	{
	    float2 output_0 : TEXCOORD0;
	    float4 gl_Position : SV_Position;
	};
	
	void MainVs_inner()
	{
	    float4 _14779 = float4(vPositionPs, 0.0f, 1.0f);
	    output_0 = vTexCoord.xy;
	    _14779.y = -vPositionPs.y;
	    gl_Position = _14779;
	}
	
	PS_INPUT MainVs(VS_INPUT stage_input)
	{
	    vPositionPs = stage_input.vPositionPs;
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
	DynamicCombo( D_WRITE_COC, 0..1 );
	DynamicCombo( D_COC_TEXTURE, 0..1 );
	DynamicComboRule( Allow1( D_WRITE_COC, D_COC_TEXTURE ) );
	
	float4x4 g_invViewProjMatrix < Attribute("InvViewProjMatrix"); >;
	Texture2D g_tInputCocNormalized < Attribute("InputCocNormalized"); SrgbRead(false); >;
	Texture2D g_tInputColor_CoC < Attribute("InputColor_CoC"); SrgbRead(false); >;
	Texture2D g_tSceneDepth < Attribute("SceneDepth"); SrgbRead(false); >;
	float4 g_vLensPlane < Attribute("LensPlane"); UiType(VectorText); >;
	
	
	// Variant parameters
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	struct _113
	{
	    float4 _m0[256];
	};
	
	cbuffer Dof2CBParams_t : register(b1, space1)
	{
	    float Dof2CBParams_t_1_m0 : packoffset(c1.y);
	    _113 Dof2CBParams_t_1_m1 : packoffset(c3);
	    int Dof2CBParams_t_1_m2 : packoffset(c259);
	};
	
	Texture2D<float4> g_tInputColor_CoC : register(t30, space1);
	SamplerState AddressU_Clamp_AddressV_Clamp_Filter_MinMagLinearMipPoint : register(s14, space1);
	
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
	    float4 _20360 = g_tInputColor_CoC.Sample(AddressU_Clamp_AddressV_Clamp_Filter_MinMagLinearMipPoint, input_0.xy);
	    float _3670 = _20360.w * 2.0f;
	    float _13136;
	    float3 _16324;
	    _13136 = 1.0f;
	    _16324 = g_tInputColor_CoC.Sample(AddressU_Clamp_AddressV_Clamp_Filter_MinMagLinearMipPoint, input_0.xy).xyz;
	    int _4293;
	    float _5778;
	    float3 _5949;
	    int _17017 = 0;
	    for (;;)
	    {
	        if (!(_17017 < Dof2CBParams_t_1_m2))
	        {
	            break;
	        }
	        float2 _20779 = (input_0.xy + Dof2CBParams_t_1_m1._m0[_17017].xy).xy;
	        float4 _3300 = g_tInputColor_CoC.Sample(AddressU_Clamp_AddressV_Clamp_Filter_MinMagLinearMipPoint, _20779);
	        float4 _21367 = g_tInputColor_CoC.Sample(AddressU_Clamp_AddressV_Clamp_Filter_MinMagLinearMipPoint, _20779);
	        float _19148 = _21367.w;
	        float _21709;
	        if (_19148 > _3670)
	        {
	            _21709 = clamp(_19148, 0.0f, _3670);
	        }
	        else
	        {
	            _21709 = _19148;
	        }
	        _5949 = _16324 + lerp(_16324 / _13136.xxx, _3300.xyz, smoothstep(Dof2CBParams_t_1_m1._m0[_17017].z, Dof2CBParams_t_1_m1._m0[_17017].w, _21709 * Dof2CBParams_t_1_m0).xxx);
	        _5778 = _13136 + 1.0f;
	        _4293 = _17017 + 1;
	        _13136 = _5778;
	        _16324 = _5949;
	        _17017 = _4293;
	        continue;
	    }
	    float3 _13138 = _16324 / _13136.xxx;
	    float4 _22905 = float4(1.0f, 0.0f, 0.0f, 1.0f);
	    _22905.x = _13138.x;
	    _22905.y = _13138.y;
	    _22905.z = _13138.z;
	    output_0 = _22905;
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
