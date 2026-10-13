//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Visualize quad overshading";
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
	
	Texture2D g_tQuadOverdrawUAV < Attribute("QuadOverdrawUAV"); SrgbRead(false); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	cbuffer PerViewConstantBuffer_t : register(b0, space1)
	{
	    float4 PerViewConstantBuffer_t_1_m0 : packoffset(c22);
	};
	
	Texture2D<uint4> g_tQuadOverdrawUAV : register(t30, space1);
	
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
	    float4 _21709;
	    switch (g_tQuadOverdrawUAV.Load(int3(uint2(gl_FragCoord.xy * 0.5f.xx), 0)).x)
	    {
	        case 0u:
	        {
	            _21709 = float4(0.0f, 0.0f, 0.0f, 1.0f);
	            break;
	        }
	        case 1u:
	        {
	            _21709 = float4(0.0f, 0.0f, 0.5f, 1.0f);
	            break;
	        }
	        case 2u:
	        {
	            _21709 = float4(0.0f, 0.300000011920928955078125f, 1.0f, 1.0f);
	            break;
	        }
	        case 3u:
	        {
	            _21709 = float4(0.0f, 0.89999997615814208984375f, 1.0f, 1.0f);
	            break;
	        }
	        case 4u:
	        {
	            _21709 = float4(0.300000011920928955078125f, 1.0f, 0.0f, 1.0f);
	            break;
	        }
	        case 5u:
	        {
	            _21709 = float4(0.89999997615814208984375f, 1.0f, 0.0f, 1.0f);
	            break;
	        }
	        case 6u:
	        {
	            _21709 = float4(1.0f, 0.300000011920928955078125f, 0.0f, 1.0f);
	            break;
	        }
	        case 7u:
	        {
	            _21709 = float4(1.0f, 0.0f, 0.300000011920928955078125f, 1.0f);
	            break;
	        }
	        case 8u:
	        {
	            _21709 = float4(1.0f, 0.0f, 0.89999997615814208984375f, 1.0f);
	            break;
	        }
	        case 9u:
	        {
	            _21709 = float4(1.0f, 0.300000011920928955078125f, 0.89999997615814208984375f, 1.0f);
	            break;
	        }
	        default:
	        {
	            _21709 = 1.0f.xxxx;
	            break;
	        }
	    }
	    float2 _21065 = gl_FragCoord.xy * PerViewConstantBuffer_t_1_m0.xy;
	    float2 _12444 = _21065.xy;
	    bool _12885;
	    if (all(bool2(_12444.x > float2(0.100000001490116119384765625f, 0.89999997615814208984375f).x, _12444.y > float2(0.100000001490116119384765625f, 0.89999997615814208984375f).y)))
	    {
	        _12885 = all(bool2(_12444.x < float2(0.89999997615814208984375f, 0.920000016689300537109375f).x, _12444.y < float2(0.89999997615814208984375f, 0.920000016689300537109375f).y));
	    }
	    else
	    {
	        _12885 = false;
	    }
	    float4 _6805;
	    if (_12885)
	    {
	        bool _12886;
	        if (all(bool2(_12444.x > float2(0.1015000045299530029296875f, 0.9014999866485595703125f).x, _12444.y > float2(0.1015000045299530029296875f, 0.9014999866485595703125f).y)))
	        {
	            _12886 = all(bool2(_12444.x < float2(0.898499965667724609375f, 0.918500006198883056640625f).x, _12444.y < float2(0.898499965667724609375f, 0.918500006198883056640625f).y));
	        }
	        else
	        {
	            _12886 = false;
	        }
	        float4 _12502;
	        if (_12886)
	        {
	            float4 _12501;
	            switch (uint((_21065.x - 0.100000001490116119384765625f) * 13.75000095367431640625f))
	            {
	                case 0u:
	                {
	                    _12501 = float4(0.0f, 0.0f, 0.0f, 1.0f);
	                    break;
	                }
	                case 1u:
	                {
	                    _12501 = float4(0.0f, 0.0f, 0.5f, 1.0f);
	                    break;
	                }
	                case 2u:
	                {
	                    _12501 = float4(0.0f, 0.300000011920928955078125f, 1.0f, 1.0f);
	                    break;
	                }
	                case 3u:
	                {
	                    _12501 = float4(0.0f, 0.89999997615814208984375f, 1.0f, 1.0f);
	                    break;
	                }
	                case 4u:
	                {
	                    _12501 = float4(0.300000011920928955078125f, 1.0f, 0.0f, 1.0f);
	                    break;
	                }
	                case 5u:
	                {
	                    _12501 = float4(0.89999997615814208984375f, 1.0f, 0.0f, 1.0f);
	                    break;
	                }
	                case 6u:
	                {
	                    _12501 = float4(1.0f, 0.300000011920928955078125f, 0.0f, 1.0f);
	                    break;
	                }
	                case 7u:
	                {
	                    _12501 = float4(1.0f, 0.0f, 0.300000011920928955078125f, 1.0f);
	                    break;
	                }
	                case 8u:
	                {
	                    _12501 = float4(1.0f, 0.0f, 0.89999997615814208984375f, 1.0f);
	                    break;
	                }
	                case 9u:
	                {
	                    _12501 = float4(1.0f, 0.300000011920928955078125f, 0.89999997615814208984375f, 1.0f);
	                    break;
	                }
	                default:
	                {
	                    _12501 = 1.0f.xxxx;
	                    break;
	                }
	            }
	            _12502 = _12501;
	        }
	        else
	        {
	            _12502 = float4(0.0f, 0.0f, 0.0f, 1.0f);
	        }
	        _6805 = _12502;
	    }
	    else
	    {
	        _6805 = _21709;
	    }
	    output_0 = _6805;
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
