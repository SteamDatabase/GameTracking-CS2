//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Scalable Ambient Obscurance Bilateral Blur";
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
	
	Texture2D g_tRawSSAO < Attribute("SSAO"); SrgbRead(false); >;
	float2 g_vAxis < UiType(VectorText); Expression(axis); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	static const float _482[5] = { 0.15317000448703765869140625f, 0.14489300549030303955078125f, 0.12264899909496307373046875f, 0.092901997268199920654296875f, 0.06296999752521514892578125f };
	
	cbuffer _Globals_ : register(b0, space1)
	{
	    float2 _Globals_1_g_vAxis : packoffset(c0);
	};
	
	Texture2D<float4> g_tRawSSAO : register(t30, space1);
	
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
	    int2 _10251 = int2(gl_FragCoord.xy).xy;
	    float4 _19469 = g_tRawSSAO.Load(int3(int3(_10251, 0).xy, 0));
	    float _15233 = _19469.y;
	    float _13136;
	    float _16324;
	    _13136 = _19469.x * 0.15317000448703765869140625f;
	    _16324 = 0.15317000448703765869140625f;
	    int _4292;
	    float _10913;
	    float _17551;
	    int _17017 = -4;
	    [unroll]
	    for (;;)
	    {
	        if (!(_17017 <= 4))
	        {
	            break;
	        }
	        if (_17017 != 0)
	        {
	            float4 _3300 = g_tRawSSAO.Load(int3(int3(int2(float2(_10251) + (_Globals_1_g_vAxis * float(_17017 * 2))), 0).xy, 0));
	            float _3716 = (0.300000011920928955078125f + _482[abs(_17017)]) * max(0.0f, 1.0f - (2000.0f * abs(_3300.y - _15233)));
	            _10913 = _13136 + (_3300.x * _3716);
	            _17551 = _16324 + _3716;
	        }
	        else
	        {
	            _10913 = _13136;
	            _17551 = _16324;
	        }
	        _4292 = _17017 + 1;
	        _13136 = _10913;
	        _16324 = _17551;
	        _17017 = _4292;
	        continue;
	    }
	    output_0 = float4(_13136 / (_16324 + 9.9999997473787516355514526367188e-05f), _15233, _19469.z, 1.0f);
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
