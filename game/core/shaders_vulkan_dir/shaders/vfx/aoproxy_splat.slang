//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Splat Ambient Occlusion Proxies";
	DevShader = true;
	Version = 1;
	
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
	float3 vPositionOs : POSITION0  < Semantic( PosXyz ); >;                                      
};

VS
{
	
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	struct _2775
	{
	    float4 _m0[20];
	};
	
	struct _2661
	{
	    int4 _m0[20];
	};
	
	cbuffer AoProxyConstantBuffer_t : register(b1, space0)
	{
	    _2775 AoProxyConstantBuffer_t_1_m0 : packoffset(c5);
	    _2775 AoProxyConstantBuffer_t_1_m1 : packoffset(c25);
	    _2775 AoProxyConstantBuffer_t_1_m2 : packoffset(c45);
	    _2661 AoProxyConstantBuffer_t_1_m3 : packoffset(c65);
	};
	
	cbuffer PerViewConstantBuffer_t : register(b0, space0)
	{
	    column_major float4x4 PerViewConstantBuffer_t_1_m0 : packoffset(c0);
	    float4 PerViewConstantBuffer_t_1_m1 : packoffset(c24);
	    float3 PerViewConstantBuffer_t_1_m2 : packoffset(c26);
	};
	
	
	static float4 gl_Position;
	static int gl_InstanceIndex;
	static int gl_BaseInstanceARB;
	cbuffer SPIRV_Cross_VertexInfo
	{
	    int SPIRV_Cross_BaseVertex;
	    int SPIRV_Cross_BaseInstance;
	};
	
	static float3 vPositionOs;
	static float4 output_0;
	static float3 output_1;
	static float3 output_2;
	static float output_3;
	static uint3 output_4;
	
	struct VS_INPUT
	{
	    float3 vPositionOs : POSITION0;
	    uint gl_InstanceIndex : SV_InstanceID;
	};
	
	struct PS_INPUT
	{
	    float4 output_0 : TEXCOORD0;
	    float3 output_1 : TEXCOORD1;
	    float3 output_2 : TEXCOORD2;
	    float output_3 : TEXCOORD3;
	    nointerpolation uint3 output_4 : TEXCOORD4;
	    float4 gl_Position : SV_Position;
	};
	
	void MainVs_inner()
	{
	    uint _24589 = uint(gl_InstanceIndex - gl_BaseInstanceARB);
	    float3 _9948 = lerp(AoProxyConstantBuffer_t_1_m0._m0[_24589].xyz, AoProxyConstantBuffer_t_1_m1._m0[_24589].xyz, vPositionOs.xyz * 2.0f).xyz;
	    float4 _17971 = mul(PerViewConstantBuffer_t_1_m0, (float4(_9948, 1.0f) + (PerViewConstantBuffer_t_1_m1 * 1.0f)).xyzw);
	    float3 _23026 = 2.0f.xxx / (AoProxyConstantBuffer_t_1_m1._m0[_24589].xyz - AoProxyConstantBuffer_t_1_m0._m0[_24589].xyz);
	    output_0 = float4(((AoProxyConstantBuffer_t_1_m0._m0[_24589].xyz + AoProxyConstantBuffer_t_1_m1._m0[_24589].xyz) * (-0.5f)) * _23026.xyz, AoProxyConstantBuffer_t_1_m2._m0[_24589].x);
	    output_1 = _23026;
	    output_2 = _9948 - PerViewConstantBuffer_t_1_m2.xyz;
	    output_3 = AoProxyConstantBuffer_t_1_m1._m0[_24589].w;
	    output_4 = uint3(AoProxyConstantBuffer_t_1_m3._m0[_24589].xyz);
	    _17971.y = -_17971.y;
	    gl_Position = _17971;
	}
	
	PS_INPUT MainVs(VS_INPUT stage_input)
	{
	    gl_InstanceIndex = int(stage_input.gl_InstanceIndex);
	    gl_BaseInstanceARB = SPIRV_Cross_BaseInstance;
	    vPositionOs = stage_input.vPositionOs;
	    MainVs_inner();
	    PS_INPUT stage_output;
	    stage_output.gl_Position = gl_Position;
	    stage_output.output_0 = output_0;
	    stage_output.output_1 = output_1;
	    stage_output.output_2 = output_2;
	    stage_output.output_3 = output_3;
	    stage_output.output_4 = output_4;
	    return stage_output;
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
}

PS
{
	StaticCombo( S_REVERSE_DEPTH_BUFFER, 0..1 );
	
	Texture2D g_tSceneDepth < Attribute("SceneDepth"); SrgbRead(false); >;
	Texture3D g_tTextureAoConeLUT < Channel(R, None(TextureAoConeLUT), Linear); OutputFormat(ATI1N); SrgbRead(false); >;
	
	// LUT
	CreateInputTexture2D(TextureAoConeLUT, Linear, 8, "", "_lut_z000", "LUT", Default4(1, 1, 1, 0));
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	struct _2704
	{
	    float4 _m0[4];
	};
	
	struct _1257
	{
	    column_major float4x3 _m0[106];
	};
	
	struct _2478
	{
	    float4 _m0[106];
	};
	
	cbuffer PerViewConstantBuffer_t : register(b0, space1)
	{
	    float4 PerViewConstantBuffer_t_1_m0 : packoffset(c16);
	    float PerViewConstantBuffer_t_1_m1 : packoffset(c23);
	    float PerViewConstantBuffer_t_1_m2 : packoffset(c23.y);
	    float3 PerViewConstantBuffer_t_1_m3 : packoffset(c26);
	    float3 PerViewConstantBuffer_t_1_m4 : packoffset(c28);
	};
	
	cbuffer AoProxyConstantBuffer_t : register(b1, space1)
	{
	    _2704 AoProxyConstantBuffer_t_1_m0 : packoffset(c0);
	    float4 AoProxyConstantBuffer_t_1_m1 : packoffset(c4);
	    _1257 AoProxyConstantBuffer_t_1_m2 : packoffset(c85);
	    _2478 AoProxyConstantBuffer_t_1_m3 : packoffset(c403);
	};
	
	Texture2D<float4> g_tSceneDepth : register(t31, space1);
	Texture3D<float4> g_tTextureAoConeLUT : register(t30, space1);
	SamplerState AddressU_Clamp_AddressV_Clamp_AddressW_Clamp_Filter_MinMagLinearMipPoint : register(s14, space1);
	
	static float4 gl_FragCoord;
	static uint3 input_4;
	static float3 input_2;
	static float3 input_1;
	static float4 input_0;
	static float input_3;
	static float4 output_0;
	
	struct PS_INPUT
	{
	    float4 input_0 : TEXCOORD0;
	    float3 input_1 : TEXCOORD1;
	    float3 input_2 : TEXCOORD2;
	    float input_3 : TEXCOORD3;
	    nointerpolation uint3 input_4 : TEXCOORD4;
	    float4 gl_FragCoord : SV_Position;
	};
	
	struct PS_OUTPUT
	{
	    float4 output_0 : SV_Target0;
	};
	
	void MainPs_inner()
	{
	    float3 _10889 = (PerViewConstantBuffer_t_1_m3.xyz + (input_2.xyz * (1.0f / (((saturate((g_tSceneDepth.Load(int3(int3(int2(gl_FragCoord.xy).xy, 0).xy, 0)).x - PerViewConstantBuffer_t_1_m1) / (PerViewConstantBuffer_t_1_m2 - PerViewConstantBuffer_t_1_m1)) * PerViewConstantBuffer_t_1_m0.z) + PerViewConstantBuffer_t_1_m0.w) * dot(PerViewConstantBuffer_t_1_m4.xyz, input_2.xyz))))).xyz;
	    float3 _11842 = mad(_10889, input_1.xyz, input_0.xyz);
	    float3 _3852 = 1.0f.xxx - abs(_11842);
	    float _4208 = saturate(3.0f * min(_3852.x, min(_3852.y, _3852.z))) * saturate(2.7999999523162841796875f - (2.0f * length(_11842)));
	    if ((_4208 - 0.00999999977648258209228515625f) < 0.0f)
	    {
	        discard;
	    }
	    int _16648 = int(input_4.x);
	    int _12017 = int(input_4.y);
	    float4 _13155;
	    _13155 = 1.0f.xxxx;
	    float4 _16164;
	    int _21531;
	    int _16208 = _16648;
	    for (;;)
	    {
	        if (!(_16208 < _12017))
	        {
	            break;
	        }
	        float3 _7095 = mul(float4(_10889, 1.0f), AoProxyConstantBuffer_t_1_m2._m0[_16208]);
	        float3 _11556 = _7095.xyz;
	        float _8132 = rsqrt(dot(_11556, _11556));
	        float3 _16478 = (_7095.xyz * (-_8132)).xyz;
	        _16164 = _13155.xyzw * float4(g_tTextureAoConeLUT.Sample(AddressU_Clamp_AddressV_Clamp_AddressW_Clamp_Filter_MinMagLinearMipPoint, float3(mad(dot(normalize(mul(AoProxyConstantBuffer_t_1_m0._m0[0].xyzw, AoProxyConstantBuffer_t_1_m2._m0[_16208]).xyz).xyz, _16478), 0.5f, 0.5f), _8132, AoProxyConstantBuffer_t_1_m1.x)).x, g_tTextureAoConeLUT.Sample(AddressU_Clamp_AddressV_Clamp_AddressW_Clamp_Filter_MinMagLinearMipPoint, float3(mad(dot(normalize(mul(AoProxyConstantBuffer_t_1_m0._m0[1].xyzw, AoProxyConstantBuffer_t_1_m2._m0[_16208]).xyz).xyz, _16478), 0.5f, 0.5f), _8132, AoProxyConstantBuffer_t_1_m1.y)).x, g_tTextureAoConeLUT.Sample(AddressU_Clamp_AddressV_Clamp_AddressW_Clamp_Filter_MinMagLinearMipPoint, float3(mad(dot(normalize(mul(AoProxyConstantBuffer_t_1_m0._m0[2].xyzw, AoProxyConstantBuffer_t_1_m2._m0[_16208]).xyz).xyz, _16478), 0.5f, 0.5f), _8132, AoProxyConstantBuffer_t_1_m1.z)).x, g_tTextureAoConeLUT.Sample(AddressU_Clamp_AddressV_Clamp_AddressW_Clamp_Filter_MinMagLinearMipPoint, float3(mad(dot(normalize(mul(AoProxyConstantBuffer_t_1_m0._m0[3].xyzw, AoProxyConstantBuffer_t_1_m2._m0[_16208]).xyz).xyz, _16478), 0.5f, 0.5f), _8132, AoProxyConstantBuffer_t_1_m1.w)).x).xyzw;
	        _21531 = _16208 + 1;
	        _13155 = _16164;
	        _16208 = _21531;
	        continue;
	    }
	    int _23852 = int(input_4.z);
	    float4 _13156;
	    _13156 = _13155.xyzw;
	    float4 _16165;
	    int _21532;
	    int _16209 = _12017;
	    for (;;)
	    {
	        if (!(_16209 < _23852))
	        {
	            break;
	        }
	        float3 _24855 = mul(float4(_10889, 1.0f), AoProxyConstantBuffer_t_1_m2._m0[_16209]);
	        float3 _20220 = (clamp(_24855.xyz, -AoProxyConstantBuffer_t_1_m3._m0[_16209].xyz, AoProxyConstantBuffer_t_1_m3._m0[_16209].xyz) * 0.89999997615814208984375f) - _24855.xyz;
	        float3 _10134 = abs(_20220);
	        float _23212 = 1.0f / (1.0f + (dot(_10134 / ((_10134.x + _10134.y) + _10134.z).xxx, 3.1415927410125732421875f.xxx / (AoProxyConstantBuffer_t_1_m3._m0[_16209].yzx * AoProxyConstantBuffer_t_1_m3._m0[_16209].zxy).xyz) * length(_20220)));
	        float3 _16479 = normalize(_20220).xyz;
	        _16165 = _13156.xyzw * float4(g_tTextureAoConeLUT.Sample(AddressU_Clamp_AddressV_Clamp_AddressW_Clamp_Filter_MinMagLinearMipPoint, float3(mad(dot(normalize(mul(AoProxyConstantBuffer_t_1_m0._m0[0].xyzw, AoProxyConstantBuffer_t_1_m2._m0[_16209]).xyz).xyz, _16479), 0.5f, 0.5f), _23212, AoProxyConstantBuffer_t_1_m1.x)).x, g_tTextureAoConeLUT.Sample(AddressU_Clamp_AddressV_Clamp_AddressW_Clamp_Filter_MinMagLinearMipPoint, float3(mad(dot(normalize(mul(AoProxyConstantBuffer_t_1_m0._m0[1].xyzw, AoProxyConstantBuffer_t_1_m2._m0[_16209]).xyz).xyz, _16479), 0.5f, 0.5f), _23212, AoProxyConstantBuffer_t_1_m1.y)).x, g_tTextureAoConeLUT.Sample(AddressU_Clamp_AddressV_Clamp_AddressW_Clamp_Filter_MinMagLinearMipPoint, float3(mad(dot(normalize(mul(AoProxyConstantBuffer_t_1_m0._m0[2].xyzw, AoProxyConstantBuffer_t_1_m2._m0[_16209]).xyz).xyz, _16479), 0.5f, 0.5f), _23212, AoProxyConstantBuffer_t_1_m1.z)).x, g_tTextureAoConeLUT.Sample(AddressU_Clamp_AddressV_Clamp_AddressW_Clamp_Filter_MinMagLinearMipPoint, float3(mad(dot(normalize(mul(AoProxyConstantBuffer_t_1_m0._m0[3].xyzw, AoProxyConstantBuffer_t_1_m2._m0[_16209]).xyz).xyz, _16479), 0.5f, 0.5f), _23212, AoProxyConstantBuffer_t_1_m1.w)).x).xyzw;
	        _21532 = _16209 + 1;
	        _13156 = _16165;
	        _16209 = _21532;
	        continue;
	    }
	    output_0 = lerp(1.0f.xxxx, _13156.xyzw, ((_4208 * input_0.w) * input_3).xxxx);
	}
	
	PS_OUTPUT MainPs(PS_INPUT stage_input)
	{
	    gl_FragCoord = stage_input.gl_FragCoord;
	    gl_FragCoord.w = 1.0 / gl_FragCoord.w;
	    input_4 = stage_input.input_4;
	    input_2 = stage_input.input_2;
	    input_1 = stage_input.input_1;
	    input_0 = stage_input.input_0;
	    input_3 = stage_input.input_3;
	    MainPs_inner();
	    PS_OUTPUT stage_output;
	    stage_output.output_0 = output_0;
	    return stage_output;
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
	
	BoolAttribute(decal, true);
	BoolAttribute(ambientocclusionproxy, true);
	
}
