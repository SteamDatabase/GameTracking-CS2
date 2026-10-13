//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Rasterize Lightmap to produce discrete samples";
	DevShader = true;
	Version = 0;
	
	// Platform: VULKAN_SM_50
	// Programs: gs, ps, vs
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
	uint4  nPackedFrame : NORMAL0    < Semantic( CompressedTangentFrame ); >;                     
	float4 vPositionWs  : POSITION0  < Semantic( position ); >;                                   
	float2 vLightmapUv  : TEXCOORD0  < Semantic( lightmapuv ); >;                                 
};

VS
{
	
	float4 g_vWindow < Attribute("g_vWindow"); UiType(VectorText); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	static float _3;
	
	cbuffer _Globals_ : register(b0, space0)
	{
	    float4 _Globals_1_g_vWindow : packoffset(c0);
	};
	
	
	static float4 gl_Position;
	static float3 vPositionWs;
	static float2 vLightmapUv;
	static uint nPackedFrame;
	static float3 output_0;
	static float3 output_1;
	static float3 output_2;
	static float4 output_3;
	static float2 output_4;
	static uint output_5;
	
	struct VS_INPUT
	{
	    float3 vPositionWs : POSITION0;
	    float2 vLightmapUv : TEXCOORD0;
	    uint nPackedFrame : NORMAL0;
	};
	
	struct PS_INPUT
	{
	    float3 output_0 : TEXCOORD0;
	    float3 output_1 : TEXCOORD1;
	    float3 output_2 : TEXCOORD2;
	    float4 output_3 : TEXCOORD3;
	    float2 output_4 : TEXCOORD4;
	    nointerpolation uint output_5 : TEXCOORD5;
	    float4 gl_Position : SV_Position;
	};
	
	void MainVs_inner()
	{
	    float _22483 = (float((nPackedFrame >> 12u) & 1023u) * 0.00195503421127796173095703125f) - 1.0f;
	    float _7589 = (float((nPackedFrame >> 22u) & 1023u) * 0.00195503421127796173095703125f) - 1.0f;
	    float _23404 = (1.0f - abs(_22483)) - abs(_7589);
	    float3 _8254 = float3(_22483, _7589, _23404);
	    float _24228 = saturate(-_23404);
	    float2 _7335 = float2(_22483, _7589);
	    bool2 _10803 = bool2(_7335.x >= 0.0f.xx.x, _7335.y >= 0.0f.xx.y);
	    float2 _14501 = (-_24228).xx;
	    float2 _8565 = _24228.xx;
	    float2 _14348 = _7335 + float2(_10803.x ? _14501.x : _8565.x, _10803.y ? _14501.y : _8565.y);
	    _8254.x = _14348.x;
	    _8254.y = _14348.y;
	    float3 _21001 = normalize(_8254);
	    float _6384 = _21001.z;
	    float _8220 = (_6384 >= 0.0f) ? 1.0f : (-1.0f);
	    float _16417 = (-1.0f) / (_8220 + _6384);
	    float _14755 = _21001.x;
	    float3 _23176 = float3(1.0f + (((_8220 * _14755) * _14755) * _16417), _8220 * ((_14755 * _21001.y) * _16417), (-_8220) * _14755);
	    float _23966 = float((nPackedFrame >> uint(1)) & 2047u) * 0.003069460391998291015625f;
	    float4 _15436 = float4((((vLightmapUv.x - _Globals_1_g_vWindow.x) / (_Globals_1_g_vWindow.z - _Globals_1_g_vWindow.x)) * 2.0f) + (-1.0f), _3, 0.0f, 1.0f);
	    output_0 = vPositionWs;
	    output_1 = _21001;
	    output_2 = 0.0f.xxx;
	    output_3 = float4((_23176 * cos(_23966)) + (cross(_21001, _23176) * sin(_23966)), ((nPackedFrame & 1u) == 0u) ? (-1.0f) : 1.0f);
	    output_4 = vLightmapUv;
	    output_5 = 4294967295u;
	    _15436.y = 1.0f - (((vLightmapUv.y - _Globals_1_g_vWindow.y) / (_Globals_1_g_vWindow.w - _Globals_1_g_vWindow.y)) * 2.0f);
	    gl_Position = _15436;
	}
	
	PS_INPUT MainVs(VS_INPUT stage_input)
	{
	    vPositionWs = stage_input.vPositionWs;
	    vLightmapUv = stage_input.vLightmapUv;
	    nPackedFrame = stage_input.nPackedFrame;
	    MainVs_inner();
	    PS_INPUT stage_output;
	    stage_output.gl_Position = gl_Position;
	    stage_output.output_0 = output_0;
	    stage_output.output_1 = output_1;
	    stage_output.output_2 = output_2;
	    stage_output.output_3 = output_3;
	    stage_output.output_4 = output_4;
	    stage_output.output_5 = output_5;
	    return stage_output;
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
}

GS
{
	
	StructuredBuffer g_ChartIDs < Attribute("g_ChartIDs"); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	ByteAddressBuffer g_ChartIDs : register(t30, space2);
	
	static float4 gl_PositionIn[3];
	static float4 gl_Position;
	static uint gl_PrimitiveIDIn;
	static float3 input_0[3];
	static float3 input_1[3];
	static float4 input_3[3];
	static float2 input_4[3];
	static float3 output_0;
	static float3 output_1;
	static float3 output_2;
	static float4 output_3;
	static float2 output_4;
	static uint output_5;
	
	struct SPIRV_Cross_Input
	{
	    float3 input_0 : TEXCOORD0;
	    float3 input_1 : TEXCOORD1;
	    float4 input_3 : TEXCOORD3;
	    float2 input_4 : TEXCOORD4;
	    float4 gl_PositionIn : SV_Position;
	};
	
	struct SPIRV_Cross_Output
	{
	    float3 output_0 : TEXCOORD0;
	    float3 output_1 : TEXCOORD1;
	    float3 output_2 : TEXCOORD2;
	    float4 output_3 : TEXCOORD3;
	    float2 output_4 : TEXCOORD4;
	    nointerpolation uint output_5 : TEXCOORD5;
	    float4 gl_Position : SV_Position;
	};
	
	void MainGs_inner(triangle SPIRV_Cross_Input stage_input[3], inout TriangleStream<SPIRV_Cross_Output> geometry_stream)
	{
	    float3 _7777 = normalize(cross(input_0[1] - input_0[0], input_0[2] - input_0[0]));
	    uint _11093 = uint(gl_PrimitiveIDIn);
	    uint2 _16324;
	    _16324 = uint2(_11093, 0u);
	    int _6352;
	    uint _15272;
	    uint2 _16189;
	    uint _13136 = 0u;
	    int _17017 = 0;
	    for (;;)
	    {
	        if (!(_17017 < 6))
	        {
	            break;
	        }
	        _15272 = _13136 + 2654435769u;
	        _16189 = _16324.xy + ((((_16324.yx << uint2(int2(4, 4))) + uint2(2738958700u, 2911926141u)) ^ (_16324.yx + _15272.xx)) ^ ((_16324.yx >> uint2(int2(5, 5))) + uint2(3355524772u, 2123724318u)));
	        _6352 = _17017 + 1;
	        _13136 = _15272;
	        _16324 = _16189;
	        _17017 = _6352;
	        continue;
	    }
	    float _21748 = float(_16324.x & 1048575u) * 9.5367431640625e-07f;
	    float4 _9829 = gl_PositionIn[0];
	    float4 _12875 = _9829;
	    _12875.z = _21748;
	    output_0 = input_0[0];
	    output_1 = input_1[0];
	    output_2 = _7777;
	    output_3 = input_3[0];
	    output_4 = input_4[0];
	    output_5 = g_ChartIDs.Load<uint>(_11093 * 4 + 0);
	    _12875.y = -_9829.y;
	    gl_Position = _12875;
	    {
	        SPIRV_Cross_Output stage_output;
	        stage_output.gl_Position = gl_Position;
	        stage_output.output_0 = output_0;
	        stage_output.output_1 = output_1;
	        stage_output.output_2 = output_2;
	        stage_output.output_3 = output_3;
	        stage_output.output_4 = output_4;
	        stage_output.output_5 = output_5;
	        geometry_stream.Append(stage_output);
	    }
	    float4 _9830 = gl_PositionIn[1];
	    float4 _12876 = _9830;
	    _12876.z = _21748;
	    output_0 = input_0[1];
	    output_1 = input_1[1];
	    output_2 = _7777;
	    output_3 = input_3[1];
	    output_4 = input_4[1];
	    output_5 = g_ChartIDs.Load<uint>(_11093 * 4 + 0);
	    _12876.y = -_9830.y;
	    gl_Position = _12876;
	    {
	        SPIRV_Cross_Output stage_output;
	        stage_output.gl_Position = gl_Position;
	        stage_output.output_0 = output_0;
	        stage_output.output_1 = output_1;
	        stage_output.output_2 = output_2;
	        stage_output.output_3 = output_3;
	        stage_output.output_4 = output_4;
	        stage_output.output_5 = output_5;
	        geometry_stream.Append(stage_output);
	    }
	    float4 _9831 = gl_PositionIn[2];
	    float4 _12877 = _9831;
	    _12877.z = _21748;
	    output_0 = input_0[2];
	    output_1 = input_1[2];
	    output_2 = _7777;
	    output_3 = input_3[2];
	    output_4 = input_4[2];
	    output_5 = g_ChartIDs.Load<uint>(_11093 * 4 + 0);
	    _12877.y = -_9831.y;
	    gl_Position = _12877;
	    {
	        SPIRV_Cross_Output stage_output;
	        stage_output.gl_Position = gl_Position;
	        stage_output.output_0 = output_0;
	        stage_output.output_1 = output_1;
	        stage_output.output_2 = output_2;
	        stage_output.output_3 = output_3;
	        stage_output.output_4 = output_4;
	        stage_output.output_5 = output_5;
	        geometry_stream.Append(stage_output);
	    }
	    geometry_stream.RestartStrip();
	}
	
	[maxvertexcount(3)]
	void MainGs(triangle SPIRV_Cross_Input stage_input[3], uint gl_PrimitiveID : SV_PrimitiveID, inout TriangleStream<SPIRV_Cross_Output> geometry_stream)
	{
	    for (int i = 0; i < 3; i++)
	    {
	        gl_PositionIn[i] = stage_input[i].gl_PositionIn;
	    }
	    gl_PrimitiveIDIn = gl_PrimitiveID;
	    for (int i = 0; i < 3; i++)
	    {
	        input_0[i] = stage_input[i].input_0;
	    }
	    for (int i = 0; i < 3; i++)
	    {
	        input_1[i] = stage_input[i].input_1;
	    }
	    for (int i = 0; i < 3; i++)
	    {
	        input_3[i] = stage_input[i].input_3;
	    }
	    for (int i = 0; i < 3; i++)
	    {
	        input_4[i] = stage_input[i].input_4;
	    }
	    MainGs_inner(stage_input, geometry_stream);
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
}

PS
{
	DynamicCombo( D_PASS, 0..1 );
	DynamicCombo( D_REVERSE_DEPTH, 0..1 );
	DynamicComboRule( Requires( D_REVERSE_DEPTH, D_PASS==0 ) );
	
	StructuredBuffer g_ChartInfo < Attribute("g_ChartInfo"); >;
	RWStructuredBuffer g_LightmapSamples < Attribute("g_LightmapSamples"); >;
	Texture2D g_LuxelChartIDs < Attribute("g_LuxelChartIDs"); SrgbRead(false); >;
	int g_nSampleStride < Attribute("g_nSampleStride"); UiType(Slider); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	Texture2D<uint4> g_LuxelChartIDs : register(t30, space1);
	
	static float4 gl_FragCoord;
	static uint input_5;
	static float4 output_0;
	
	struct PS_INPUT
	{
	    nointerpolation uint input_5 : TEXCOORD5;
	    float4 gl_FragCoord : SV_Position;
	};
	
	struct PS_OUTPUT
	{
	    float4 output_0 : SV_Target0;
	};
	
	void MainPs_inner()
	{
	    if (input_5 != g_LuxelChartIDs.Load(int3(uint2(gl_FragCoord.xy), 0)).x)
	    {
	        discard;
	    }
	    output_0 = 0.0f.xxxx;
	}
	
	[earlydepthstencil]
	PS_OUTPUT MainPs(PS_INPUT stage_input)
	{
	    gl_FragCoord = stage_input.gl_FragCoord;
	    gl_FragCoord.w = 1.0 / gl_FragCoord.w;
	    input_5 = stage_input.input_5;
	    MainPs_inner();
	    PS_OUTPUT stage_output;
	    stage_output.output_0 = output_0;
	    return stage_output;
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
}
