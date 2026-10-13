//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Computes a local ambient occlusion (AO) term using the g-buffer";
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
	Feature( F_SSAO_QUALITY, 0..2 (0="Low (9 Samples)", 1="Medium (16 Samples)", 2="High (25 Samples)"), "" );
	Feature( F_ALPHA_BLEND, 0..1, "" );
}

COMMON
{
	#include "system.fxc"
}

struct VS_INPUT
{
	float3 vPositionSs            : POSITION0  < Semantic( PosXyz ); >;                           
	float4 vCameraToFarPlaneRayWs : TEXCOORD0  < Semantic( CameraToFarPlaneRayWs ); >;            
};

VS
{
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	static float4 gl_Position;
	static float3 vPositionSs;
	static float3 vCameraToFarPlaneRayWs;
	static float3 output_0;
	
	struct VS_INPUT
	{
	    float3 vPositionSs : POSITION0;
	    float3 vCameraToFarPlaneRayWs : TEXCOORD0;
	};
	
	struct PS_INPUT
	{
	    float3 output_0 : TEXCOORD0;
	    float4 gl_Position : SV_Position;
	};
	
	void MainVs_inner()
	{
	    float4 _14456 = float4(vPositionSs, 1.0f);
	    output_0 = vCameraToFarPlaneRayWs;
	    _14456.y = -vPositionSs.y;
	    gl_Position = _14456;
	}
	
	PS_INPUT MainVs(VS_INPUT stage_input)
	{
	    vPositionSs = stage_input.vPositionSs;
	    vCameraToFarPlaneRayWs = stage_input.vCameraToFarPlaneRayWs;
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
	StaticCombo( S_SSAO_QUALITY, F_SSAO_QUALITY );
	StaticCombo( S_ALPHA_BLEND, F_ALPHA_BLEND );
	DynamicCombo( D_Z_PREPASS_OUTPUTS_NORMALS, 0..1 );
	DynamicCombo( D_MSAA_DEPTH_BUFFER, 0..1 );
	
	CreateInputTexture2D(TextureRandom, Linear, 8, "", "_random", "", Default4(0.5, 0.5, 0.5, 0));
	float g_flSSAOBias < Default(0.005); UiType(Slider); >;
	float g_flSampleRadius < Default(11); UiType(Slider); >;
	Texture2D g_tGBufferLinearDepth < Attribute("GBufferLinearDepth"); SrgbRead(false); >;
	Texture2D g_tGBufferNormalAndFresnel < Attribute("GBufferNormalAndFresnel"); SrgbRead(false); >;
	Texture2D g_tRandom < Channel(RGB, Box(TextureRandom), Linear); OutputFormat(DXT1); SrgbRead(false); >;
	float4 g_vInvRenderTargetDim < Attribute("InvRenderTargetDim"); UiType(VectorText); >;
	float4 g_vRandSampleScale < Source(InvTextureDim); SourceArg(g_tRandom) UiType(VectorText); >;
	float4 g_vRelativeViewport < Attribute("RelativeViewport"); UiType(VectorText); >;
	
	// SPIR-V reflection failed for backend HLSL:
	// cbuffer ID 5618 (name: _Globals_), member index 3 (name: g_vInvRenderTargetDim) cannot be expressed with either HLSL packing layout or packoffset.
	//
	// Re-attempting reflection with the GLSL backend.
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, GLSL reflection with SPIRV-Cross by KhronosGroup
	
	#version 460
	
	const vec3 _1197[9] = vec3[](vec3(0.13390399515628814697265625, 0.0365430004894733428955078125, 0.049350000917911529541015625), vec3(-0.12978200614452362060546875, -0.0326079986989498138427734375, 0.098058998584747314453125), vec3(-0.1944600045680999755859375, -0.4137530028820037841796875, 0.8764560222625732421875), vec3(-0.0387840010225772857666015625, 0.43998301029205322265625, 0.0596049986779689788818359375), vec3(-0.118508003652095794677734375, 0.001674000057391822338104248046875, -0.011568999849259853363037109375), vec3(0.0038580000400543212890625, -0.00258699990808963775634765625, -0.00047200001426972448825836181640625), vec3(0.007021999917924404144287109375, 0.000399000011384487152099609375, -0.0054720002226531505584716796875), vec3(-0.16810800135135650634765625, -0.2530579864978790283203125, -0.224711000919342041015625), vec3(0.0112229995429515838623046875, -0.254115998744964599609375, -0.4668669998645782470703125));
	
	struct _1283
	{
	    vec4 g_vRandSampleScale;
	    float g_flSSAOBias;
	    float g_flSampleRadius;
	    vec4 g_vInvRenderTargetDim;
	    vec4 g_vRelativeViewport;
	};
	
	layout(set = 1) uniform _1283 _Globals_;
	
	struct _1288
	{
	    mat4 _m0;
	    vec4 _m1;
	    vec3 _m2;
	};
	
	layout(set = 1) uniform _1288 PerViewConstantBuffer_t;
	
	layout(set = 1, binding = 31) uniform texture2D g_tGBufferLinearDepth;
	layout(set = 1, binding = 15) uniform sampler AddressU_Clamp_AddressV_Clamp_Filter_MinMagMipPoint;
	layout(set = 1, binding = 30) uniform texture2D g_tRandom;
	layout(set = 1, binding = 14) uniform sampler Filter_MinMagMipPoint;
	
	layout(location = 0) in vec3 input_0;
	layout(location = 0) out vec4 output_0;
	
	void main()
	{
	    vec2 _23080 = vec2(0.5, -0.5) * _Globals_.g_vRelativeViewport.zw;
	    vec2 _20508 = (vec2(0.5) * _Globals_.g_vRelativeViewport.zw) + _Globals_.g_vRelativeViewport.xy;
	    vec2 _20779 = (gl_FragCoord.xy * _Globals_.g_vInvRenderTargetDim.xy).xy;
	    vec4 _10799 = textureLodOffset(sampler2D(g_tGBufferLinearDepth, AddressU_Clamp_AddressV_Clamp_Filter_MinMagMipPoint), _20779, 0.0, ivec2(0));
	    float _3362 = _10799.x;
	    vec3 _7153 = (PerViewConstantBuffer_t._m2 + (normalize(input_0.xyz) * _3362)).xyz;
	    vec3 _23396 = dFdx(input_0.xyz);
	    vec3 _10636 = dFdy(input_0.xyz);
	    vec3 _10169 = _7153 - (PerViewConstantBuffer_t._m2 + (normalize(input_0.xyz - _10636) * textureLodOffset(sampler2D(g_tGBufferLinearDepth, AddressU_Clamp_AddressV_Clamp_Filter_MinMagMipPoint), _20779, 0.0, ivec2(0, -1)).x));
	    vec3 _7345 = (PerViewConstantBuffer_t._m2 + (normalize(input_0.xyz + _10636) * textureLodOffset(sampler2D(g_tGBufferLinearDepth, AddressU_Clamp_AddressV_Clamp_Filter_MinMagMipPoint), _20779, 0.0, ivec2(0, 1)).x)) - _7153;
	    vec3 _7119 = (PerViewConstantBuffer_t._m2 + (normalize(input_0.xyz + _23396) * textureLodOffset(sampler2D(g_tGBufferLinearDepth, AddressU_Clamp_AddressV_Clamp_Filter_MinMagMipPoint), _20779, 0.0, ivec2(1, 0)).x)) - _7153;
	    vec3 _13777 = _7153 - (PerViewConstantBuffer_t._m2 + (normalize(input_0.xyz - _23396) * textureLodOffset(sampler2D(g_tGBufferLinearDepth, AddressU_Clamp_AddressV_Clamp_Filter_MinMagMipPoint), _20779, 0.0, ivec2(-1, 0)).x));
	    vec4 _20877 = texture(sampler2D(g_tRandom, Filter_MinMagMipPoint), (gl_FragCoord.xy * _Globals_.g_vRandSampleScale.xy).xy);
	    vec3 _15145 = normalize(((_20877.xyz * 2.0) - vec3(1.0)).xyz);
	    vec3 _24081 = (-normalize(cross(mix(_7119, _13777, bvec3(length(_13777) < length(_7119))), mix(_10169, _7345, bvec3(length(_7345) < length(_10169)))))).xyz;
	    vec3 _12200 = _7153 + (_24081 * (_3362 * _Globals_.g_flSSAOBias));
	    float _20688 = _Globals_.g_flSampleRadius * _Globals_.g_flSampleRadius;
	    float _13155;
	    _13155 = 0.0;
	    float _9828;
	    int _14722;
	    int _16208 = 0;
	    for (;;)
	    {
	        if (!(_16208 < 9))
	        {
	            break;
	        }
	        vec3 _13945 = reflect((_1197[_16208] * _Globals_.g_flSampleRadius).xyz, _15145.xyz);
	        vec3 _22410 = _13945.xyz;
	        vec3 _19629;
	        if (dot(_24081, _22410) < 0.0)
	        {
	            _19629 = reflect(_22410, _24081);
	        }
	        else
	        {
	            _19629 = _13945;
	        }
	        vec3 _21589 = _12200.xyz;
	        vec3 _16060 = _19629.xyz + _21589;
	        vec4 _18621 = (vec4(_16060.xyz, 1.0) + (PerViewConstantBuffer_t._m1 * 1.0)).xyzw * PerViewConstantBuffer_t._m0;
	        vec4 _3300 = textureLodOffset(sampler2D(g_tGBufferLinearDepth, AddressU_Clamp_AddressV_Clamp_Filter_MinMagMipPoint), clamp(((_23080.xy * (_18621.xy / vec2(_18621.w)).xy) + _20508.xy).xy, _Globals_.g_vRelativeViewport.xy, _Globals_.g_vRelativeViewport.zw).xy, 0.0, ivec2(0));
	        float _5202 = _3300.x;
	        vec3 _17519 = _16060.xyz - PerViewConstantBuffer_t._m2.xyz;
	        float _15544 = length(_17519.xyz);
	        vec3 _6560 = ((PerViewConstantBuffer_t._m2.xyz + ((_17519 / vec3(_15544)).xyz * _5202)).xyz - _21589).xyz;
	        _9828 = _13155 + (saturate((_20688 - dot(_6560, _6560)) * 1000000.0) * saturate((_15544 - _5202) * 1000000.0));
	        _14722 = _16208 + 1;
	        _13155 = _9828;
	        _16208 = _14722;
	        continue;
	    }
	    float _19065 = 1.0 - (_13155 * 0.111111111938953399658203125);
	    output_0 = vec4(_19065 * (_19065 * _19065));
	}
	
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
}
