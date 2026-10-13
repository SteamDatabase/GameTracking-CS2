//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "SVGF version of Edge-Avoiding A-Trous wavelet filter";
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
	float3 vPositionPs : POSITION0  < Semantic( PosXyz ); >;                                      
};

VS
{
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	static float4 gl_Position;
	static float2 vPositionPs;
	
	struct VS_INPUT
	{
	    float2 vPositionPs : POSITION0;
	};
	
	struct PS_INPUT
	{
	    float4 gl_Position : SV_Position;
	};
	
	void MainVs_inner()
	{
	    float4 _22489 = float4(vPositionPs, 0.0f, 1.0f);
	    _22489.y = -vPositionPs.y;
	    gl_Position = _22489;
	}
	
	PS_INPUT MainVs(VS_INPUT stage_input)
	{
	    vPositionPs = stage_input.vPositionPs;
	    MainVs_inner();
	    PS_INPUT stage_output;
	    stage_output.gl_Position = gl_Position;
	    return stage_output;
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
}

PS
{
	DynamicCombo( D_FIRST_PASS, 0..1 );
	DynamicCombo( D_FINAL_PASS, 0..1 );
	DynamicCombo( D_BAKED_SHADOWS, 0..1 );
	DynamicCombo( D_BAKED_AO, 0..1 );
	DynamicComboRule( Allow1( D_BAKED_AO, D_BAKED_SHADOWS ) );
	
	float g_fDepthPhi < Attribute("DepthPhi"); UiType(Slider); >;
	float g_fNormalPhi < Attribute("NormalPhi"); UiType(Slider); >;
	float g_fSignalPhi < Attribute("SignalPhi"); UiType(Slider); >;
	int g_nFilterScale < Attribute("FilterScale"); UiType(Slider); >;
	int g_nInputShadowChannel < Attribute("InputShadowChannel"); UiType(Slider); >;
	Texture2D g_tInputAO < Attribute("InputAO"); SrgbRead(false); >;
	Texture2D g_tInputDepthNormal < Attribute("InputDepthNormal"); SrgbRead(false); >;
	Texture2D g_tInputLighting < Attribute("InputLighting"); SrgbRead(false); >;
	Texture2DArray g_tInputShadows < Attribute("InputShadows"); SrgbRead(false); >;
	Texture2D g_tInputVariance < Attribute("InputVariance"); SrgbRead(false); >;
	RWTexture2D<float4> g_tOutputAO < Attribute("OutputAO"); >;
	RWTexture2D<float4> g_tOutputShadows < Attribute("OutputShadows"); >;
	float4 g_vInputDimensions < Attribute("InputDimensions"); UiType(VectorText); >;
	
	// SPIR-V reflection failed for backend HLSL:
	// cbuffer ID 5618 (name: _Globals_), member index 0 (name: g_vInputDimensions) cannot be expressed with either HLSL packing layout or packoffset.
	//
	// Re-attempting reflection with the GLSL backend.
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, GLSL reflection with SPIRV-Cross by KhronosGroup
	
	#version 460
	#extension GL_EXT_samplerless_texture_functions : require
	
	const float _2048[2][2] = float[][](float[](0.25, 0.125), float[](0.125, 0.0625));
	const float _1989[3] = float[](1.0, 0.666666686534881591796875, 0.16666667163372039794921875);
	
	struct _1104
	{
	    vec4 g_vInputDimensions;
	    int g_nFilterScale;
	    float g_fDepthPhi;
	    float g_fNormalPhi;
	    float g_fSignalPhi;
	};
	
	layout(set = 1) uniform _1104 _Globals_;
	
	layout(set = 1, binding = 32) uniform texture2D g_tInputLighting;
	layout(set = 1, binding = 34) uniform texture2D g_tInputDepthNormal;
	
	layout(location = 0) out vec4 output_0;
	
	void main()
	{
	    ivec2 _19617 = ivec2(gl_FragCoord.xy);
	    ivec2 _17364 = ivec2(_Globals_.g_vInputDimensions.xy);
	    ivec2 _11700 = ivec3(_19617, 0).xy;
	    vec4 _23195 = texelFetch(g_tInputLighting, _11700, 0);
	    vec4 _21078 = texelFetch(g_tInputDepthNormal, _11700, 0);
	    float _12624 = dot(_23195.xyz, vec3(0.2125000059604644775390625, 0.7153999805450439453125, 0.07209999859333038330078125));
	    float _8858 = _21078.x;
	    vec2 _7688 = (_21078.zw * 2.0) - vec2(1.0);
	    float _8347 = _7688.x;
	    float _23404 = (1.0 - abs(_8347)) - abs(_7688.y);
	    vec3 _8254 = vec3(_8347, _7688.y, _23404);
	    float _23072 = saturate(-_23404);
	    vec2 _14348 = _7688 + mix(vec2(_23072), vec2(-_23072), greaterThanEqual(_7688, vec2(0.0)));
	    _8254.x = _14348.x;
	    _8254.y = _14348.y;
	    vec3 _12110 = normalize(_8254);
	    float _13155;
	    _13155 = 0.0;
	    int _21567;
	    float _13156;
	    int _16208 = -1;
	    for (;;)
	    {
	        if (!(_16208 <= 1))
	        {
	            break;
	        }
	        _13156 = _13155;
	        int _14722;
	        float _16832;
	        int _16209 = -1;
	        for (;;)
	        {
	            if (!(_16209 <= 1))
	            {
	                break;
	            }
	            float _23854[2] = _2048[abs(_16209)];
	            _16832 = _13156 + (texelFetch(g_tInputLighting, ivec3(_19617 + ivec2(_16209, _16208), 0).xy, 0).w * _23854[abs(_16208)]);
	            _14722 = _16209 + 1;
	            _13156 = _16832;
	            _16209 = _14722;
	            continue;
	        }
	        _21567 = _16208 + 1;
	        _13155 = _13156;
	        _16208 = _21567;
	        continue;
	    }
	    float _7725 = _Globals_.g_fSignalPhi * sqrt(max(0.0, _13155 + 9.9999999747524270787835121154785e-07));
	    float _10269 = (_Globals_.g_fDepthPhi * max(min(1000.0, _21078.y), 0.00999999977648258209228515625)) * float(_Globals_.g_nFilterScale);
	    float _13136;
	    vec4 _16324;
	    _13136 = 1.0;
	    _16324 = _23195;
	    int _5808;
	    float _13137;
	    vec4 _16325;
	    int _17017 = -2;
	    for (;;)
	    {
	        if (!(_17017 <= 2))
	        {
	            break;
	        }
	        _13137 = _13136;
	        _16325 = _16324;
	        int _5807;
	        float _10913;
	        vec4 _17551;
	        int _17018 = -2;
	        for (;;)
	        {
	            if (!(_17018 <= 2))
	            {
	                break;
	            }
	            ivec2 _5509 = _19617 + (ivec2(_17018, _17017) * ivec2(_Globals_.g_nFilterScale));
	            bvec2 _18202 = greaterThanEqual(_5509, ivec2(0));
	            bvec2 _6560 = lessThan(_5509, _17364);
	            bool _12885;
	            if (all(bvec2(_18202.x && _6560.x, _18202.y && _6560.y)))
	            {
	                bool _12501;
	                if (_17018 != 0)
	                {
	                    _12501 = true;
	                }
	                else
	                {
	                    _12501 = _17017 != 0;
	                }
	                _12885 = _12501;
	            }
	            else
	            {
	                _12885 = false;
	            }
	            if (_12885)
	            {
	                ivec2 _13528 = ivec3(_5509, 0).xy;
	                vec4 _19777 = texelFetch(g_tInputLighting, _13528, 0);
	                vec4 _3300 = texelFetch(g_tInputDepthNormal, _13528, 0);
	                vec2 _7689 = (_3300.zw * 2.0) - vec2(1.0);
	                float _8348 = _7689.x;
	                float _23405 = (1.0 - abs(_8348)) - abs(_7689.y);
	                vec3 _8255 = vec3(_8348, _7689.y, _23405);
	                float _23073 = saturate(-_23405);
	                vec2 _14349 = _7689 + mix(vec2(_23073), vec2(-_23073), greaterThanEqual(_7689, vec2(0.0)));
	                _8255.x = _14349.x;
	                _8255.y = _14349.y;
	                float _18186 = _10269 * length(vec2(float(_17018), float(_17017)));
	                float _9364;
	                if (_18186 == 0.0)
	                {
	                    _9364 = 0.0;
	                }
	                else
	                {
	                    _9364 = abs(_8858 - _3300.x) / _18186;
	                }
	                float _6029 = (exp((-max(0.0, _9364)) - max(0.0, abs(_12624 - dot(_19777.xyz, vec3(0.2125000059604644775390625, 0.7153999805450439453125, 0.07209999859333038330078125))) / _7725)) * pow(saturate(dot(_12110, normalize(_8255))), _Globals_.g_fNormalPhi)) * (_1989[abs(_17017)] * _1989[abs(_17018)]);
	                _10913 = _13137 + _6029;
	                _17551 = _16325 + vec4(_19777.xyz * _6029, _19777.w * (_6029 * _6029));
	            }
	            else
	            {
	                _10913 = _13137;
	                _17551 = _16325;
	            }
	            _5807 = _17018 + 1;
	            _13137 = _10913;
	            _16325 = _17551;
	            _17018 = _5807;
	            continue;
	        }
	        _5808 = _17017 + 1;
	        _13136 = _13137;
	        _16324 = _16325;
	        _17017 = _5808;
	        continue;
	    }
	    output_0 = vec4(_16324.xyz / vec3(_13136), _16324.w / (_13136 * _13136));
	}
	
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
}
