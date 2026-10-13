//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Cables shader used for particle system cables";
	DevShader = false;
	Version = 0;
	
	// Platform: VULKAN_SM_50
	// Programs: ps, vs
}

MODES
{
	Forward();
	Depth(S_MODE_DEPTH);
}

FEATURES
{
	Feature( F_NORMAL_MAP, 0..1, "Normal Map" );
}

COMMON
{
	#include "system.fxc"
}

VS
{
	StaticCombo( S_TOOLS_ENABLED, 0, Sys( 1 ) );
	StaticCombo( S_MODE_DEPTH, 0..1 );
	DynamicCombo( D_BLEND_WEIGHT_COUNT, 0..4 );
	DynamicComboRule( Allow0( D_BLEND_WEIGHT_COUNT ) );
	
	[[layer_constant]] StructuredBuffer g_instanceBuffer < Attribute("InstanceBuffer"); >;
	[[layer_constant]] StructuredBuffer g_transformBuffer < Attribute("TransformBuffer"); >;
	float4 g_vColorMapParams < Attribute("ColorMapParams"); UiType(VectorText); >;
	float4 g_vNormalMapParams < Attribute("NormalMapParams"); UiType(VectorText); >;
	
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
	
	static float4 _4;
	
	ByteAddressBuffer g_instanceBuffer : register(t32, space0);
	ByteAddressBuffer g_transformBuffer : register(t30, space0);
	cbuffer _Globals_ : register(b0, space0)
	{
	    float4 _Globals_1_g_vColorMapParams : packoffset(c0);
	    float4 _Globals_1_g_vNormalMapParams : packoffset(c1);
	};
	
	cbuffer PerViewConstantBuffer_t : register(b1, space0)
	{
	    column_major float4x4 PerViewConstantBuffer_t_1_m0 : packoffset(c0);
	    float4 PerViewConstantBuffer_t_1_m1 : packoffset(c17);
	    float4 PerViewConstantBuffer_t_1_m2 : packoffset(c24);
	};
	
	
	static float4 gl_Position;
	static float gl_ClipDistance[1];
	static uint input_TEXCOORD13;
	static float4 input_TEXCOORD0;
	static float4 output_0;
	static float4 output_1;
	static float3 output_2;
	static float3 output_3;
	static float3 output_4;
	
	struct VS_INPUT
	{
	    float4 input_TEXCOORD0 : TEXCOORD0;
	    uint input_TEXCOORD13 : TEXCOORD13;
	};
	
	struct PS_INPUT
	{
	    float4 output_0 : TEXCOORD0;
	    float4 output_1 : TEXCOORD1;
	    float3 output_2 : TEXCOORD2;
	    float3 output_3 : TEXCOORD3;
	    float3 output_4 : TEXCOORD4;
	    float4 gl_Position : SV_Position;
	    float gl_ClipDistance0 : SV_ClipDistance0;
	};
	
	void MainVs_inner()
	{
	    float4 _23812 = float4(uint4(g_instanceBuffer.Load<uint>(input_TEXCOORD13 * 32 + 0) & 255u, (g_instanceBuffer.Load<uint>(input_TEXCOORD13 * 32 + 0) & 65280u) >> uint(8), (g_instanceBuffer.Load<uint>(input_TEXCOORD13 * 32 + 0) & 16711680u) >> uint(16), (g_instanceBuffer.Load<uint>(input_TEXCOORD13 * 32 + 0) & 4278190080u) >> uint(24))) * 0.0039215688593685626983642578125f.xxxx;
	    float3 _6253 = _23812.xyz;
	    float3 _17828 = _6253 * 0.077399380505084991455078125f.xxx;
	    float3 _7676 = pow((_6253 * 0.947867333889007568359375f.xxx) + 0.052132703363895416259765625f.xxx, 2.400000095367431640625f.xxx);
	    float _21354;
	    if (_23812.x <= 0.040449999272823333740234375f)
	    {
	        _21354 = _17828.x;
	    }
	    else
	    {
	        _21354 = _7676.x;
	    }
	    float _21355;
	    if (_23812.y <= 0.040449999272823333740234375f)
	    {
	        _21355 = _17828.y;
	    }
	    else
	    {
	        _21355 = _7676.y;
	    }
	    float _19167;
	    if (_23812.z <= 0.040449999272823333740234375f)
	    {
	        _19167 = _17828.z;
	    }
	    else
	    {
	        _19167 = _7676.z;
	    }
	    float4 _16668;
	    _16668.x = _21354;
	    _16668.y = _21355;
	    _16668.z = _19167;
	    float3x4 _8600 = float3x4(g_transformBuffer.Load<float4>((g_instanceBuffer.Load<uint>(input_TEXCOORD13 * 32 + 16) - 1u) * 48 + 0), g_transformBuffer.Load<float4>((g_instanceBuffer.Load<uint>(input_TEXCOORD13 * 32 + 16) - 1u) * 48 + 16), g_transformBuffer.Load<float4>((g_instanceBuffer.Load<uint>(input_TEXCOORD13 * 32 + 16) - 1u) * 48 + 32));
	    float3x4 _16772 = float3x4(g_transformBuffer.Load<float4>(g_instanceBuffer.Load<uint>(input_TEXCOORD13 * 32 + 16) * 48 + 0), g_transformBuffer.Load<float4>(g_instanceBuffer.Load<uint>(input_TEXCOORD13 * 32 + 16) * 48 + 16), g_transformBuffer.Load<float4>(g_instanceBuffer.Load<uint>(input_TEXCOORD13 * 32 + 16) * 48 + 32));
	    float3x4 _16773 = float3x4(g_transformBuffer.Load<float4>((g_instanceBuffer.Load<uint>(input_TEXCOORD13 * 32 + 16) + 1u) * 48 + 0), g_transformBuffer.Load<float4>((g_instanceBuffer.Load<uint>(input_TEXCOORD13 * 32 + 16) + 1u) * 48 + 16), g_transformBuffer.Load<float4>((g_instanceBuffer.Load<uint>(input_TEXCOORD13 * 32 + 16) + 1u) * 48 + 32));
	    float3x4 _9292 = float3x4(g_transformBuffer.Load<float4>((g_instanceBuffer.Load<uint>(input_TEXCOORD13 * 32 + 16) + 2u) * 48 + 0), g_transformBuffer.Load<float4>((g_instanceBuffer.Load<uint>(input_TEXCOORD13 * 32 + 16) + 2u) * 48 + 16), g_transformBuffer.Load<float4>((g_instanceBuffer.Load<uint>(input_TEXCOORD13 * 32 + 16) + 2u) * 48 + 32));
	    float _23034 = float(g_instanceBuffer.Load<uint>(input_TEXCOORD13 * 32 + 12));
	    uint _21048 = input_TEXCOORD13 + 1u;
	    float4 _23813 = float4(uint4(g_instanceBuffer.Load<uint>(_21048 * 32 + 0) & 255u, (g_instanceBuffer.Load<uint>(_21048 * 32 + 0) & 65280u) >> uint(8), (g_instanceBuffer.Load<uint>(_21048 * 32 + 0) & 16711680u) >> uint(16), (g_instanceBuffer.Load<uint>(_21048 * 32 + 0) & 4278190080u) >> uint(24))) * 0.0039215688593685626983642578125f.xxxx;
	    float3 _6254 = _23813.xyz;
	    float3 _17829 = _6254 * 0.077399380505084991455078125f.xxx;
	    float3 _7677 = pow((_6254 * 0.947867333889007568359375f.xxx) + 0.052132703363895416259765625f.xxx, 2.400000095367431640625f.xxx);
	    float _21356;
	    if (_23813.x <= 0.040449999272823333740234375f)
	    {
	        _21356 = _17829.x;
	    }
	    else
	    {
	        _21356 = _7677.x;
	    }
	    float _21357;
	    if (_23813.y <= 0.040449999272823333740234375f)
	    {
	        _21357 = _17829.y;
	    }
	    else
	    {
	        _21357 = _7677.y;
	    }
	    float _19168;
	    if (_23813.z <= 0.040449999272823333740234375f)
	    {
	        _19168 = _17829.z;
	    }
	    else
	    {
	        _19168 = _7677.z;
	    }
	    float4 _16669;
	    _16669.x = _21356;
	    _16669.y = _21357;
	    _16669.z = _19168;
	    float _13095 = input_TEXCOORD0.z * input_TEXCOORD0.z;
	    float _22215 = input_TEXCOORD0.z * (_13095 * 0.5f);
	    float _22379 = input_TEXCOORD0.z * 0.5f;
	    float _23270 = -_22215;
	    float _9058 = _22215 * 3.0f;
	    float _9059 = _22215 * (-3.0f);
	    float _22330 = _13095 * (-2.5f);
	    float _22334 = _13095 * 2.0f;
	    float _22338 = _13095 * (-0.5f);
	    float _7486 = input_TEXCOORD0.z * (-0.5f);
	    float3 _17546 = float3(_16772[0].x + ((_16773[0].x * _22379) + ((_8600[0].x * _7486) + ((_9292[0].x * _22338) + ((_16773[0].x * _22334) + ((_16772[0].x * _22330) + ((_8600[0].x * _13095) + ((_9292[0].x * _22215) + ((_16773[0].x * _9059) + ((_16772[0].x * _9058) + (_8600[0].x * _23270)))))))))), _16772[0].y + ((_16773[0].y * _22379) + ((_8600[0].y * _7486) + ((_9292[0].y * _22338) + ((_16773[0].y * _22334) + ((_16772[0].y * _22330) + ((_8600[0].y * _13095) + ((_9292[0].y * _22215) + ((_16773[0].y * _9059) + ((_16772[0].y * _9058) + (_8600[0].y * _23270)))))))))), _16772[0].z + ((_16773[0].z * _22379) + ((_8600[0].z * _7486) + ((_9292[0].z * _22338) + ((_16773[0].z * _22334) + ((_16772[0].z * _22330) + ((_8600[0].z * _13095) + ((_9292[0].z * _22215) + ((_16773[0].z * _9059) + ((_16772[0].z * _9058) + (_8600[0].z * _23270)))))))))));
	    float _22343 = (3.0f * input_TEXCOORD0.z) * input_TEXCOORD0.z;
	    float _22344 = _22343 * 0.5f;
	    float _22345 = _22343 * (-0.5f);
	    float _22349 = _22343 * 1.5f;
	    float _22353 = _22343 * (-1.5f);
	    float _7487 = input_TEXCOORD0.z * 2.0f;
	    float _22360 = input_TEXCOORD0.z * (-5.0f);
	    float _22364 = input_TEXCOORD0.z * 4.0f;
	    float _14274 = -input_TEXCOORD0.z;
	    float3 _9326;
	    float _13136;
	    float3 _15070;
	    if (input_TEXCOORD0.z == 0.0f)
	    {
	        _13136 = _16772[0].w;
	        _15070 = _16772[0].xyz;
	        _9326 = _16773[0].xyz - _8600[0].xyz;
	    }
	    else
	    {
	        bool _17899 = input_TEXCOORD0.z == 1.0f;
	        float3 _23151;
	        if (_17899)
	        {
	            _23151 = _9292[0].xyz - _16772[0].xyz;
	        }
	        else
	        {
	            _23151 = float3((_16773[0].x * 0.5f) + ((_8600[0].x * (-0.5f)) + ((_9292[0].x * _14274) + ((_16773[0].x * _22364) + ((_16772[0].x * _22360) + ((_8600[0].x * _7487) + ((_9292[0].x * _22344) + ((_16773[0].x * _22353) + ((_16772[0].x * _22349) + (_8600[0].x * _22345))))))))), (_16773[0].y * 0.5f) + ((_8600[0].y * (-0.5f)) + ((_9292[0].y * _14274) + ((_16773[0].y * _22364) + ((_16772[0].y * _22360) + ((_8600[0].y * _7487) + ((_9292[0].y * _22344) + ((_16773[0].y * _22353) + ((_16772[0].y * _22349) + (_8600[0].y * _22345))))))))), (_16773[0].z * 0.5f) + ((_8600[0].z * (-0.5f)) + ((_9292[0].z * _14274) + ((_16773[0].z * _22364) + ((_16772[0].z * _22360) + ((_8600[0].z * _7487) + ((_9292[0].z * _22344) + ((_16773[0].z * _22353) + ((_16772[0].z * _22349) + (_8600[0].z * _22345))))))))));
	        }
	        bool3 _10724 = _17899.xxx;
	        _13136 = _17899 ? _16773[0].w : (0.5f * ((((2.0f * _16772[0].w) + ((_16773[0].w - _8600[0].w) * input_TEXCOORD0.z)) + (((((2.0f * _8600[0].w) - (5.0f * _16772[0].w)) + (4.0f * _16773[0].w)) - _9292[0].w) * _13095)) + (((((3.0f * _16772[0].w) - _8600[0].w) - (3.0f * _16773[0].w)) + _9292[0].w) * (_13095 * input_TEXCOORD0.z))));
	        _15070 = float3(_10724.x ? _16773[0].xyz.x : _17546.x, _10724.y ? _16773[0].xyz.y : _17546.y, _10724.z ? _16773[0].xyz.z : _17546.z);
	        _9326 = _23151;
	    }
	    float3 _17352;
	    if (input_TEXCOORD0.z == 1.0f)
	    {
	        _17352 = _16773[1].xyz;
	    }
	    else
	    {
	        _17352 = _16772[1].xyz;
	    }
	    float3 _15988 = normalize(cross(_17352, _9326));
	    float3 _7048 = (_15988 * input_TEXCOORD0.x) + (normalize(cross(_9326, _15988)) * input_TEXCOORD0.y);
	    float3 _10252 = _15070 + (_7048 * _13136);
	    float3 _23727;
	    if (_8600[0].w < 0.0f)
	    {
	        _23727 = normalize(_10252 - _8600[0].xyz);
	    }
	    else
	    {
	        _23727 = _7048;
	    }
	    float3 _19321;
	    if (_9292[0].w < 0.0f)
	    {
	        _19321 = normalize(_10252 - _9292[0].xyz);
	    }
	    else
	    {
	        _19321 = _23727;
	    }
	    float3 _14602 = _16668.xyz * 0.077399380505084991455078125f.xxx;
	    float3 _9357 = pow((_16668.xyz * 0.947867333889007568359375f.xxx) + 0.052132703363895416259765625f.xxx, 2.400000095367431640625f.xxx);
	    float _23035;
	    if (_21354 <= 0.040449999272823333740234375f)
	    {
	        _23035 = _14602.x;
	    }
	    else
	    {
	        _23035 = _9357.x;
	    }
	    float _23036;
	    if (_21355 <= 0.040449999272823333740234375f)
	    {
	        _23036 = _14602.y;
	    }
	    else
	    {
	        _23036 = _9357.y;
	    }
	    float _19302;
	    if (_19167 <= 0.040449999272823333740234375f)
	    {
	        _19302 = _14602.z;
	    }
	    else
	    {
	        _19302 = _9357.z;
	    }
	    float3 _10597 = _16669.xyz * 0.077399380505084991455078125f.xxx;
	    float3 _9358 = pow((_16669.xyz * 0.947867333889007568359375f.xxx) + 0.052132703363895416259765625f.xxx, 2.400000095367431640625f.xxx);
	    float _23037;
	    if (_21356 <= 0.040449999272823333740234375f)
	    {
	        _23037 = _10597.x;
	    }
	    else
	    {
	        _23037 = _9358.x;
	    }
	    float _23038;
	    if (_21357 <= 0.040449999272823333740234375f)
	    {
	        _23038 = _10597.y;
	    }
	    else
	    {
	        _23038 = _9358.y;
	    }
	    float _19303;
	    if (_19168 <= 0.040449999272823333740234375f)
	    {
	        _19303 = _10597.z;
	    }
	    else
	    {
	        _19303 = _9358.z;
	    }
	    float4 _18024 = float4(_10252.xyz, 1.0f);
	    float4 _18237 = mul(PerViewConstantBuffer_t_1_m0, (_18024 + (PerViewConstantBuffer_t_1_m2 * 1.0f)).xyzw);
	    output_0 = float4(_Globals_1_g_vColorMapParams.x + (_Globals_1_g_vColorMapParams.z * input_TEXCOORD0.w), (_Globals_1_g_vColorMapParams.y + (_Globals_1_g_vColorMapParams.w * _23034)) + (_Globals_1_g_vColorMapParams.w * input_TEXCOORD0.z), _Globals_1_g_vNormalMapParams.x + (_Globals_1_g_vNormalMapParams.z * input_TEXCOORD0.w), (_Globals_1_g_vNormalMapParams.y + (_Globals_1_g_vNormalMapParams.w * _23034)) + (_Globals_1_g_vNormalMapParams.w * input_TEXCOORD0.z));
	    output_1 = lerp(float4(_23035, _23036, _19302, _23812.w), float4(_23037, _23038, _19303, _23813.w), input_TEXCOORD0.z.xxxx);
	    output_2 = _10252;
	    output_3 = _19321;
	    output_4 = float4(cross(_9326, _7048), 1.0f).xyz;
	    _18237.y = -_18237.y;
	    gl_Position = _18237;
	    gl_ClipDistance[0] = dot(_18024, PerViewConstantBuffer_t_1_m1.xyzw);
	}
	
	PS_INPUT MainVs(VS_INPUT stage_input)
	{
	    input_TEXCOORD13 = stage_input.input_TEXCOORD13;
	    input_TEXCOORD0 = stage_input.input_TEXCOORD0;
	    MainVs_inner();
	    PS_INPUT stage_output;
	    stage_output.gl_Position = gl_Position;
	    stage_output.gl_ClipDistance0.x = gl_ClipDistance[0];
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
	StaticCombo( S_TOOLS_ENABLED, 0, Sys( 1 ) );
	StaticCombo( S_MODE_DEPTH, 0..1 );
	StaticCombo( S_NORMAL_MAP, F_NORMAL_MAP );
	
	Texture2D g_tColor < Channel(RGB, Box(TextureColor), Srgb); OutputFormat(DXT1); SrgbRead(true); >;
	Texture2D g_tNormal < Channel(AG, MipNormal(TextureNormal), Linear); OutputFormat(DXT5); SrgbRead(false); >;
	
	// Color
	CreateInputTexture2D(TextureColor, Srgb, 8, "", "_color", "Color/10", Default4(1, 1, 1, 0));
	
	// Layer 1
	CreateInputTexture2D(TextureNormal, Linear, 8, "NormalizeNormals", "_normal", "Layer 1/Normal,20", Default4(0.5, 0.5, 1, 0));
	
	// Normal Map
	float g_flBumpStrength < Default(1); Range(0, 10); UiType(Slider); UiGroup("Normal Map"); >;
	
	// Lighting
	float g_flDiffuseAmount < Default(1); Range(0, 5); UiType(Slider); UiGroup("Lighting"); >;
	float g_flRoughness < Default(1); Range(1, 0); UiType(Slider); UiGroup("Lighting"); >;
	float g_flSelfIllumAmount < Range(0, 5); UiType(Slider); UiGroup("Lighting"); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	static float4 _2;
	
	cbuffer _Globals_ : register(b0, space1)
	{
	    float _Globals_1_g_flSelfIllumAmount : packoffset(c0.y);
	    float _Globals_1_g_flDiffuseAmount : packoffset(c0.z);
	    float _Globals_1_g_flRoughness : packoffset(c1);
	};
	
	cbuffer RoughnessLightingGlobalsCB_t : register(b2, space1)
	{
	    float4 RoughnessLightingGlobalsCB_t_1_m0 : packoffset(c0);
	};
	
	cbuffer PerViewConstantBuffer_t : register(b1, space1)
	{
	    float PerViewConstantBuffer_t_1_m0 : packoffset(c18);
	    float3 PerViewConstantBuffer_t_1_m1 : packoffset(c26);
	    float3 PerViewConstantBuffer_t_1_m2 : packoffset(c31);
	    float PerViewConstantBuffer_t_1_m3 : packoffset(c31.w);
	    float PerViewConstantBuffer_t_1_m4 : packoffset(c32);
	    float PerViewConstantBuffer_t_1_m5 : packoffset(c32.y);
	    float PerViewConstantBuffer_t_1_m6 : packoffset(c32.z);
	};
	
	cbuffer SunLightShaderParamsCB_t : register(b3, space1)
	{
	    float3 SunLightShaderParamsCB_t_1_m0 : packoffset(c0);
	    float3 SunLightShaderParamsCB_t_1_m1 : packoffset(c1);
	};
	
	Texture2D<float4> g_tColor : register(t30, space1);
	SamplerState DefaultSamplerState_0 : register(s14, space1);
	
	static float4 input_0;
	static float4 input_1;
	static float3 input_3;
	static float3 input_2;
	static float4 output_0;
	
	struct PS_INPUT
	{
	    float4 input_0 : TEXCOORD0;
	    float4 input_1 : TEXCOORD1;
	    float3 input_2 : TEXCOORD2;
	    float3 input_3 : TEXCOORD3;
	};
	
	struct PS_OUTPUT
	{
	    float4 output_0 : SV_Target0;
	};
	
	void MainPs_inner()
	{
	    float3 _14744 = normalize(input_3.xyz).xyz;
	    float3 _23378 = clamp(_14744, 0.0f.xxx, 1.0f.xxx);
	    float3 _23904 = clamp(-_14744, 0.0f.xxx, 1.0f.xxx);
	    float _7644 = 1.0f - _Globals_1_g_flRoughness;
	    float _8478 = _7644 * 0.800000011920928955078125f;
	    float _23619 = exp2(_7644 * 10.0f);
	    float _14805 = pow(saturate(dot(_14744, SunLightShaderParamsCB_t_1_m1.xyz)), _8478 + 0.60000002384185791015625f) * ((_8478 + 1.60000002384185791015625f) * 0.5f);
	    float3 _9146 = ((SunLightShaderParamsCB_t_1_m0.xyz * (((pow(saturate(dot(_14744, normalize(SunLightShaderParamsCB_t_1_m1.xyz + (-normalize(input_2.xyz - PerViewConstantBuffer_t_1_m1.xyz)).xyz).xyz)), _23619) * _14805) * (((_23619 + 2.0f) * (_23619 + 4.0f)) / (8.0f * (exp2(_23619 * (-0.5f)) + _23619)))) * (1.0f - saturate(_Globals_1_g_flRoughness * 0.5f)))) * 1.0f).xyz + ((g_tColor.Sample(DefaultSamplerState_0, input_0.xy).xyz * input_1.xyz) * ((((RoughnessLightingGlobalsCB_t_1_m0.xyz * (dot(float3(0.60000002384185791015625f, 0.4000000059604644775390625f, 1.0f), _23378 * _23378) + dot(float3(0.60000002384185791015625f, 0.4000000059604644775390625f, 0.20000000298023223876953125f), _23904 * _23904))).xyz + ((SunLightShaderParamsCB_t_1_m0.xyz * _14805) * 1.0f)).xyz * _Globals_1_g_flDiffuseAmount) + _Globals_1_g_flSelfIllumAmount.xxx));
	    float4 _20488;
	    _20488.x = _9146.x;
	    _20488.y = _9146.y;
	    _20488.z = _9146.z;
	    float3 _19800 = lerp(_20488.xyz, PerViewConstantBuffer_t_1_m2.xyz, saturate(min(PerViewConstantBuffer_t_1_m5, pow(saturate((distance(input_2.xyz, PerViewConstantBuffer_t_1_m1.xyz) * PerViewConstantBuffer_t_1_m4) + PerViewConstantBuffer_t_1_m3), PerViewConstantBuffer_t_1_m6))).xxx);
	    float4 _17842;
	    _17842.x = _19800.x;
	    _17842.y = _19800.y;
	    _17842.z = _19800.z;
	    output_0 = float4(_17842.xyz * PerViewConstantBuffer_t_1_m0, 1.0f);
	}
	
	PS_OUTPUT MainPs(PS_INPUT stage_input)
	{
	    input_0 = stage_input.input_0;
	    input_1 = stage_input.input_1;
	    input_3 = stage_input.input_3;
	    input_2 = stage_input.input_2;
	    MainPs_inner();
	    PS_OUTPUT stage_output;
	    stage_output.output_0 = output_0;
	    return stage_output;
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
	
	BoolAttribute(bPreviewAsCableParticleSystem, true);
	
}
