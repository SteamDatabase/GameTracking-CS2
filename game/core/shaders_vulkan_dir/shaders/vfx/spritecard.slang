//=================================================================================================
// Reconstructed with Source 2 Viewer - https://valveresourceformat.github.io
//=================================================================================================
HEADER
{
	Description = "Shader used by the particle system";
	DevShader = true;
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
	Feature( F_REVERSE_DEPTH, 0..1, "" );
	Feature( F_DISABLE_DEPTHTEST, 0..1, "" );
	Feature( F_MOD2X, 0..1, "" );
	Feature( F_LIGHTEN_MODE, 0..1, "" );
	Feature( F_PARTICLE_ORIENTATION, 0..4 (0="Screen", 1="ScreenZ", 2="WorldZ", 3="ParticleNormal", 4="ScreenToParticleNormal"), "" );
	Feature( F_DRAW_AS_TRAIL, 0..1, "" );
	Feature( F_ADDRESS_V_CLAMP, 0..1, "" );
	Feature( F_PER_PIXEL_LIGHTING, 0..1, "" );
	Feature( F_HAS_NO_NORMAL_FOR_LIGHTING, 0..1, "" );
	Feature( F_NUM_SEQUENCES_PER_PARTICLE, 0..1, "" );
	Feature( F_REFRACT, 0..1, "" );
	Feature( F_OPAQUE, 0..1, "" );
	Feature( F_HSV_SHIFT, 0..1, "" );
	Feature( F_TEXTURE_LAYERS, 0..3 (0="None", 1="TextureLayer1", 2="TextureLayer2", 3="TextureLayer3"), "" );
	FeatureRule( Requires( F_ADDRESS_V_CLAMP, F_DRAW_AS_TRAIL ), "AddressVClamp requires trail rendering" );
	FeatureRule( Allow1( F_REVERSE_DEPTH, F_DISABLE_DEPTHTEST ), "Cannot disable depth test and use reverse depth test at the same time" );
	FeatureRule( Allow1( F_MOD2X, F_LIGHTEN_MODE ), "Cannot do mod2x and lighten at the same time" );
}

COMMON
{
	#include "system.fxc"
}

VS
{
	StaticCombo( S_TOOLS_ENABLED, 0, Sys( 1 ) );
	StaticCombo( S_MODE_DEPTH, 0..1 );
	StaticCombo( S_PARTICLE_ORIENTATION, F_PARTICLE_ORIENTATION );
	StaticCombo( S_DRAW_AS_TRAIL, F_DRAW_AS_TRAIL );
	StaticCombo( S_ADDRESS_V_CLAMP, F_ADDRESS_V_CLAMP );
	StaticCombo( S_NUM_SEQUENCES_PER_PARTICLE, F_NUM_SEQUENCES_PER_PARTICLE );
	StaticCombo( S_TEXTURE_LAYERS, F_TEXTURE_LAYERS );
	StaticComboRule( Requires( S_ADDRESS_V_CLAMP, S_DRAW_AS_TRAIL ) );
	StaticComboRule( Requires( S_ADDRESS_V_CLAMP, S_DRAW_AS_TRAIL ) );
	DynamicCombo( D_SUPPORT_FRAME_CROP, 0..1 );
	DynamicComboRule( Requires( D_SUPPORT_FRAME_CROP, S_NUM_SEQUENCES_PER_PARTICLE ) );
	
	Texture2D g_tParticleSheetTexture < Attribute("SheetTexture"); SrgbRead(false); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	static float _4;
	static float4 _5;
	
	cbuffer PerViewConstantBuffer_t : register(b0, space0)
	{
	    column_major float4x4 PerViewConstantBuffer_t_1_m0 : packoffset(c0);
	    float4 PerViewConstantBuffer_t_1_m1 : packoffset(c17);
	    float4 PerViewConstantBuffer_t_1_m2 : packoffset(c24);
	    float3 PerViewConstantBuffer_t_1_m3 : packoffset(c26);
	    float3 PerViewConstantBuffer_t_1_m4 : packoffset(c27);
	    float3 PerViewConstantBuffer_t_1_m5 : packoffset(c28);
	    float3 PerViewConstantBuffer_t_1_m6 : packoffset(c31);
	    float PerViewConstantBuffer_t_1_m7 : packoffset(c31.w);
	    float PerViewConstantBuffer_t_1_m8 : packoffset(c32);
	    float PerViewConstantBuffer_t_1_m9 : packoffset(c32.y);
	    float PerViewConstantBuffer_t_1_m10 : packoffset(c32.z);
	};
	
	cbuffer SpritecardVertexControls_t : register(b4, space0)
	{
	    float4 SpritecardVertexControls_t_1_m0 : packoffset(c0);
	    float4 SpritecardVertexControls_t_1_m1 : packoffset(c1);
	    float4 SpritecardVertexControls_t_1_m2 : packoffset(c2);
	    float4 SpritecardVertexControls_t_1_m3 : packoffset(c4);
	    float4 SpritecardVertexControls_t_1_m4 : packoffset(c5);
	    uint3 SpritecardVertexControls_t_1_m5 : packoffset(c16);
	};
	
	cbuffer SpriteCardPixelControls_t : register(b3, space0)
	{
	    float4 SpriteCardPixelControls_t_1_m0 : packoffset(c3);
	    uint2 SpriteCardPixelControls_t_1_m1 : packoffset(c19);
	};
	
	cbuffer RoughnessLightingGlobalsCB_t : register(b1, space0)
	{
	    float4 RoughnessLightingGlobalsCB_t_1_m0 : packoffset(c0);
	};
	
	cbuffer SunLightShaderParamsCB_t : register(b2, space0)
	{
	    float3 SunLightShaderParamsCB_t_1_m0 : packoffset(c0);
	    float3 SunLightShaderParamsCB_t_1_m1 : packoffset(c1);
	};
	
	
	static float4 gl_Position;
	static float gl_ClipDistance[1];
	static float2 input_TEXCOORD0;
	static float4 input_TEXCOORD1;
	static float4 input_COLOR0;
	static float3 input_POSITION0;
	static float4 input_TEXCOORD3;
	static float4 output_0;
	static float4 output_1;
	static float3 output_2;
	static float3 output_3;
	static float3 output_4;
	static float4 output_5;
	
	struct VS_INPUT
	{
	    float2 input_TEXCOORD0 : TEXCOORD0;
	    float4 input_TEXCOORD1 : TEXCOORD1;
	    float4 input_COLOR0 : COLOR0;
	    float3 input_POSITION0 : POSITION0;
	    float4 input_TEXCOORD3 : TEXCOORD3;
	};
	
	struct PS_INPUT
	{
	    float4 output_0 : TEXCOORD0;
	    float4 output_1 : TEXCOORD1;
	    float3 output_2 : TEXCOORD2;
	    float3 output_3 : TEXCOORD3;
	    float3 output_4 : TEXCOORD4;
	    nointerpolation float4 output_5 : TEXCOORD5;
	    float4 gl_Position : SV_Position;
	    float gl_ClipDistance0 : SV_ClipDistance0;
	};
	
	void MainVs_inner()
	{
	    float _22759 = (input_TEXCOORD0.x * 0.5f) + 0.5f;
	    float _21640 = (input_TEXCOORD0.y * (-0.5f)) + 0.5f;
	    float2 _11357 = float2(SpritecardVertexControls_t_1_m4.xy);
	    float2 _13745 = float2(SpritecardVertexControls_t_1_m4.zw);
	    int _14313 = int(SpritecardVertexControls_t_1_m3.x);
	    float _15588 = float(((_14313 & 31) >> 4) & 1);
	    int _9472 = int(SpritecardVertexControls_t_1_m5.x);
	    uint _11757 = uint(_9472 & 15);
	    uint _12834 = uint(_14313 & 15);
	    uint _14729 = uint(int(SpritecardVertexControls_t_1_m3.y) & 15);
	    int _10221 = _9472 & 65535;
	    int _20704 = int(SpritecardVertexControls_t_1_m3.z);
	    uint _23505 = uint((_20704 >> 12) & 15);
	    uint _14700 = uint((int(SpriteCardPixelControls_t_1_m1.y) >> 16) & 15);
	    float4 _20091;
	    do
	    {
	        if (_14700 == 2u)
	        {
	            float _20482;
	            do
	            {
	                float _13181;
	                bool _16061;
	                switch (_11757)
	                {
	                    case 1u:
	                    {
	                        _13181 = input_TEXCOORD1.z + 1.0f;
	                        _16061 = true;
	                        break;
	                    }
	                    case 2u:
	                    {
	                        _13181 = (input_TEXCOORD1.z * SpritecardVertexControls_t_1_m1.w) + 1.0f;
	                        _16061 = true;
	                        break;
	                    }
	                    case 3u:
	                    {
	                        _13181 = input_TEXCOORD1.y;
	                        _16061 = true;
	                        break;
	                    }
	                    case 4u:
	                    {
	                        _13181 = input_TEXCOORD1.w;
	                        _16061 = true;
	                        break;
	                    }
	                    case 5u:
	                    {
	                        _13181 = input_COLOR0.w;
	                        _16061 = true;
	                        break;
	                    }
	                    case 6u:
	                    {
	                        _13181 = input_TEXCOORD3.w;
	                        _16061 = true;
	                        break;
	                    }
	                    case 7u:
	                    {
	                        _13181 = input_TEXCOORD3.x;
	                        _16061 = true;
	                        break;
	                    }
	                    case 8u:
	                    {
	                        _13181 = input_TEXCOORD3.y;
	                        _16061 = true;
	                        break;
	                    }
	                    case 9u:
	                    {
	                        _13181 = input_TEXCOORD3.z;
	                        _16061 = true;
	                        break;
	                    }
	                    case 10u:
	                    {
	                        _13181 = frac(input_TEXCOORD1.x * 5657.4111328125f);
	                        _16061 = true;
	                        break;
	                    }
	                    case 11u:
	                    {
	                        _13181 = (frac(input_TEXCOORD1.x * 5657.4111328125f) - 0.5f) * 2.0f;
	                        _16061 = true;
	                        break;
	                    }
	                    case 12u:
	                    {
	                        _13181 = (input_TEXCOORD1.z * frac(input_TEXCOORD1.x * 5657.4111328125f)) + 1.0f;
	                        _16061 = true;
	                        break;
	                    }
	                    case 13u:
	                    {
	                        float _12464 = (frac(input_TEXCOORD1.x * 5657.4111328125f) - 0.5f) * 2.0f;
	                        _13181 = (_12464 * input_TEXCOORD1.z) + float(int(sign(_12464)));
	                        _16061 = true;
	                        break;
	                    }
	                    default:
	                    {
	                        _13181 = _4;
	                        _16061 = false;
	                        break;
	                    }
	                }
	                if (_16061)
	                {
	                    _20482 = _13181;
	                    break;
	                }
	                _20482 = 1.0f;
	                break;
	            } while(false);
	            float2 _11181 = 1.0f.xx / (_13745.xy * _20482.xx);
	            float _12906;
	            do
	            {
	                float _13182;
	                bool _16062;
	                switch (_12834)
	                {
	                    case 1u:
	                    {
	                        _13182 = input_TEXCOORD1.z + 1.0f;
	                        _16062 = true;
	                        break;
	                    }
	                    case 2u:
	                    {
	                        _13182 = (input_TEXCOORD1.z * SpritecardVertexControls_t_1_m1.w) + 1.0f;
	                        _16062 = true;
	                        break;
	                    }
	                    case 3u:
	                    {
	                        _13182 = input_TEXCOORD1.y;
	                        _16062 = true;
	                        break;
	                    }
	                    case 4u:
	                    {
	                        _13182 = input_TEXCOORD1.w;
	                        _16062 = true;
	                        break;
	                    }
	                    case 5u:
	                    {
	                        _13182 = input_COLOR0.w;
	                        _16062 = true;
	                        break;
	                    }
	                    case 6u:
	                    {
	                        _13182 = input_TEXCOORD3.w;
	                        _16062 = true;
	                        break;
	                    }
	                    case 7u:
	                    {
	                        _13182 = input_TEXCOORD3.x;
	                        _16062 = true;
	                        break;
	                    }
	                    case 8u:
	                    {
	                        _13182 = input_TEXCOORD3.y;
	                        _16062 = true;
	                        break;
	                    }
	                    case 9u:
	                    {
	                        _13182 = input_TEXCOORD3.z;
	                        _16062 = true;
	                        break;
	                    }
	                    case 10u:
	                    {
	                        _13182 = frac(input_TEXCOORD1.x * 1231.67041015625f);
	                        _16062 = true;
	                        break;
	                    }
	                    case 11u:
	                    {
	                        _13182 = (frac(input_TEXCOORD1.x * 1231.67041015625f) - 0.5f) * 2.0f;
	                        _16062 = true;
	                        break;
	                    }
	                    case 12u:
	                    {
	                        _13182 = (input_TEXCOORD1.z * frac(input_TEXCOORD1.x * 1231.67041015625f)) + 1.0f;
	                        _16062 = true;
	                        break;
	                    }
	                    case 13u:
	                    {
	                        float _12465 = (frac(input_TEXCOORD1.x * 1231.67041015625f) - 0.5f) * 2.0f;
	                        _13182 = (_12465 * input_TEXCOORD1.z) + float(int(sign(_12465)));
	                        _16062 = true;
	                        break;
	                    }
	                    default:
	                    {
	                        _13182 = _4;
	                        _16062 = false;
	                        break;
	                    }
	                }
	                if (_16062)
	                {
	                    _12906 = _13182;
	                    break;
	                }
	                _12906 = 1.0f;
	                break;
	            } while(false);
	            float _19456;
	            do
	            {
	                float _13183;
	                bool _16063;
	                switch (_14729)
	                {
	                    case 1u:
	                    {
	                        _13183 = input_TEXCOORD1.z + 1.0f;
	                        _16063 = true;
	                        break;
	                    }
	                    case 2u:
	                    {
	                        _13183 = (input_TEXCOORD1.z * SpritecardVertexControls_t_1_m1.w) + 1.0f;
	                        _16063 = true;
	                        break;
	                    }
	                    case 3u:
	                    {
	                        _13183 = input_TEXCOORD1.y;
	                        _16063 = true;
	                        break;
	                    }
	                    case 4u:
	                    {
	                        _13183 = input_TEXCOORD1.w;
	                        _16063 = true;
	                        break;
	                    }
	                    case 5u:
	                    {
	                        _13183 = input_COLOR0.w;
	                        _16063 = true;
	                        break;
	                    }
	                    case 6u:
	                    {
	                        _13183 = input_TEXCOORD3.w;
	                        _16063 = true;
	                        break;
	                    }
	                    case 7u:
	                    {
	                        _13183 = input_TEXCOORD3.x;
	                        _16063 = true;
	                        break;
	                    }
	                    case 8u:
	                    {
	                        _13183 = input_TEXCOORD3.y;
	                        _16063 = true;
	                        break;
	                    }
	                    case 9u:
	                    {
	                        _13183 = input_TEXCOORD3.z;
	                        _16063 = true;
	                        break;
	                    }
	                    case 10u:
	                    {
	                        _13183 = frac(input_TEXCOORD1.x * 1542.87060546875f);
	                        _16063 = true;
	                        break;
	                    }
	                    case 11u:
	                    {
	                        _13183 = (frac(input_TEXCOORD1.x * 1542.87060546875f) - 0.5f) * 2.0f;
	                        _16063 = true;
	                        break;
	                    }
	                    case 12u:
	                    {
	                        _13183 = (input_TEXCOORD1.z * frac(input_TEXCOORD1.x * 1542.87060546875f)) + 1.0f;
	                        _16063 = true;
	                        break;
	                    }
	                    case 13u:
	                    {
	                        float _12466 = (frac(input_TEXCOORD1.x * 1542.87060546875f) - 0.5f) * 2.0f;
	                        _13183 = (_12466 * input_TEXCOORD1.z) + float(int(sign(_12466)));
	                        _16063 = true;
	                        break;
	                    }
	                    default:
	                    {
	                        _13183 = _4;
	                        _16063 = false;
	                        break;
	                    }
	                }
	                if (_16063)
	                {
	                    _19456 = _13183;
	                    break;
	                }
	                _19456 = 1.0f;
	                break;
	            } while(false);
	            float2 _8731 = (_11357.xy * float2(_12906, _19456)) + lerp(0.0f.xx, frac(float2(input_TEXCOORD1.x * 1718.4361572265625f, input_TEXCOORD1.x * 1271.89013671875f)), _15588.xx);
	            float _22686;
	            do
	            {
	                float _13184;
	                bool _16064;
	                switch (_23505)
	                {
	                    case 1u:
	                    {
	                        _13184 = input_TEXCOORD1.z + 1.0f;
	                        _16064 = true;
	                        break;
	                    }
	                    case 2u:
	                    {
	                        _13184 = (input_TEXCOORD1.z * SpritecardVertexControls_t_1_m1.w) + 1.0f;
	                        _16064 = true;
	                        break;
	                    }
	                    case 3u:
	                    {
	                        _13184 = input_TEXCOORD1.y;
	                        _16064 = true;
	                        break;
	                    }
	                    case 4u:
	                    {
	                        _13184 = input_TEXCOORD1.w;
	                        _16064 = true;
	                        break;
	                    }
	                    case 5u:
	                    {
	                        _13184 = input_COLOR0.w;
	                        _16064 = true;
	                        break;
	                    }
	                    case 6u:
	                    {
	                        _13184 = input_TEXCOORD3.w;
	                        _16064 = true;
	                        break;
	                    }
	                    case 7u:
	                    {
	                        _13184 = input_TEXCOORD3.x;
	                        _16064 = true;
	                        break;
	                    }
	                    case 8u:
	                    {
	                        _13184 = input_TEXCOORD3.y;
	                        _16064 = true;
	                        break;
	                    }
	                    case 9u:
	                    {
	                        _13184 = input_TEXCOORD3.z;
	                        _16064 = true;
	                        break;
	                    }
	                    case 10u:
	                    {
	                        _13184 = frac(input_TEXCOORD1.x * 4574.43115234375f);
	                        _16064 = true;
	                        break;
	                    }
	                    case 11u:
	                    {
	                        _13184 = (frac(input_TEXCOORD1.x * 4574.43115234375f) - 0.5f) * 2.0f;
	                        _16064 = true;
	                        break;
	                    }
	                    case 12u:
	                    {
	                        _13184 = (input_TEXCOORD1.z * frac(input_TEXCOORD1.x * 4574.43115234375f)) + 1.0f;
	                        _16064 = true;
	                        break;
	                    }
	                    case 13u:
	                    {
	                        float _12467 = (frac(input_TEXCOORD1.x * 4574.43115234375f) - 0.5f) * 2.0f;
	                        _13184 = (_12467 * input_TEXCOORD1.z) + float(int(sign(_12467)));
	                        _16064 = true;
	                        break;
	                    }
	                    default:
	                    {
	                        _13184 = _4;
	                        _16064 = false;
	                        break;
	                    }
	                }
	                if (_16064)
	                {
	                    _22686 = _13184;
	                    break;
	                }
	                _22686 = 1.0f;
	                break;
	            } while(false);
	            _20091 = float4(_8731.x, _8731.y * _11181.y, _11181.x, _22686);
	            break;
	        }
	        else
	        {
	            float _12960;
	            do
	            {
	                float _13174;
	                bool _16054;
	                switch (_11757)
	                {
	                    case 1u:
	                    {
	                        _13174 = input_TEXCOORD1.z + 1.0f;
	                        _16054 = true;
	                        break;
	                    }
	                    case 2u:
	                    {
	                        _13174 = (input_TEXCOORD1.z * SpritecardVertexControls_t_1_m1.w) + 1.0f;
	                        _16054 = true;
	                        break;
	                    }
	                    case 3u:
	                    {
	                        _13174 = input_TEXCOORD1.y;
	                        _16054 = true;
	                        break;
	                    }
	                    case 4u:
	                    {
	                        _13174 = input_TEXCOORD1.w;
	                        _16054 = true;
	                        break;
	                    }
	                    case 5u:
	                    {
	                        _13174 = input_COLOR0.w;
	                        _16054 = true;
	                        break;
	                    }
	                    case 6u:
	                    {
	                        _13174 = input_TEXCOORD3.w;
	                        _16054 = true;
	                        break;
	                    }
	                    case 7u:
	                    {
	                        _13174 = input_TEXCOORD3.x;
	                        _16054 = true;
	                        break;
	                    }
	                    case 8u:
	                    {
	                        _13174 = input_TEXCOORD3.y;
	                        _16054 = true;
	                        break;
	                    }
	                    case 9u:
	                    {
	                        _13174 = input_TEXCOORD3.z;
	                        _16054 = true;
	                        break;
	                    }
	                    case 10u:
	                    {
	                        _13174 = frac(input_TEXCOORD1.x * 5657.4111328125f);
	                        _16054 = true;
	                        break;
	                    }
	                    case 11u:
	                    {
	                        _13174 = (frac(input_TEXCOORD1.x * 5657.4111328125f) - 0.5f) * 2.0f;
	                        _16054 = true;
	                        break;
	                    }
	                    case 12u:
	                    {
	                        _13174 = (input_TEXCOORD1.z * frac(input_TEXCOORD1.x * 5657.4111328125f)) + 1.0f;
	                        _16054 = true;
	                        break;
	                    }
	                    case 13u:
	                    {
	                        float _12457 = (frac(input_TEXCOORD1.x * 5657.4111328125f) - 0.5f) * 2.0f;
	                        _13174 = (_12457 * input_TEXCOORD1.z) + float(int(sign(_12457)));
	                        _16054 = true;
	                        break;
	                    }
	                    default:
	                    {
	                        _13174 = _4;
	                        _16054 = false;
	                        break;
	                    }
	                }
	                if (_16054)
	                {
	                    _12960 = _13174;
	                    break;
	                }
	                _12960 = 1.0f;
	                break;
	            } while(false);
	            float _12904;
	            do
	            {
	                float _13175;
	                bool _16055;
	                switch (_12834)
	                {
	                    case 1u:
	                    {
	                        _13175 = input_TEXCOORD1.z + 1.0f;
	                        _16055 = true;
	                        break;
	                    }
	                    case 2u:
	                    {
	                        _13175 = (input_TEXCOORD1.z * SpritecardVertexControls_t_1_m1.w) + 1.0f;
	                        _16055 = true;
	                        break;
	                    }
	                    case 3u:
	                    {
	                        _13175 = input_TEXCOORD1.y;
	                        _16055 = true;
	                        break;
	                    }
	                    case 4u:
	                    {
	                        _13175 = input_TEXCOORD1.w;
	                        _16055 = true;
	                        break;
	                    }
	                    case 5u:
	                    {
	                        _13175 = input_COLOR0.w;
	                        _16055 = true;
	                        break;
	                    }
	                    case 6u:
	                    {
	                        _13175 = input_TEXCOORD3.w;
	                        _16055 = true;
	                        break;
	                    }
	                    case 7u:
	                    {
	                        _13175 = input_TEXCOORD3.x;
	                        _16055 = true;
	                        break;
	                    }
	                    case 8u:
	                    {
	                        _13175 = input_TEXCOORD3.y;
	                        _16055 = true;
	                        break;
	                    }
	                    case 9u:
	                    {
	                        _13175 = input_TEXCOORD3.z;
	                        _16055 = true;
	                        break;
	                    }
	                    case 10u:
	                    {
	                        _13175 = frac(input_TEXCOORD1.x * 1231.67041015625f);
	                        _16055 = true;
	                        break;
	                    }
	                    case 11u:
	                    {
	                        _13175 = (frac(input_TEXCOORD1.x * 1231.67041015625f) - 0.5f) * 2.0f;
	                        _16055 = true;
	                        break;
	                    }
	                    case 12u:
	                    {
	                        _13175 = (input_TEXCOORD1.z * frac(input_TEXCOORD1.x * 1231.67041015625f)) + 1.0f;
	                        _16055 = true;
	                        break;
	                    }
	                    case 13u:
	                    {
	                        float _12458 = (frac(input_TEXCOORD1.x * 1231.67041015625f) - 0.5f) * 2.0f;
	                        _13175 = (_12458 * input_TEXCOORD1.z) + float(int(sign(_12458)));
	                        _16055 = true;
	                        break;
	                    }
	                    default:
	                    {
	                        _13175 = _4;
	                        _16055 = false;
	                        break;
	                    }
	                }
	                if (_16055)
	                {
	                    _12904 = _13175;
	                    break;
	                }
	                _12904 = 1.0f;
	                break;
	            } while(false);
	            float _22648;
	            do
	            {
	                float _13176;
	                bool _16056;
	                switch (_14729)
	                {
	                    case 1u:
	                    {
	                        _13176 = input_TEXCOORD1.z + 1.0f;
	                        _16056 = true;
	                        break;
	                    }
	                    case 2u:
	                    {
	                        _13176 = (input_TEXCOORD1.z * SpritecardVertexControls_t_1_m1.w) + 1.0f;
	                        _16056 = true;
	                        break;
	                    }
	                    case 3u:
	                    {
	                        _13176 = input_TEXCOORD1.y;
	                        _16056 = true;
	                        break;
	                    }
	                    case 4u:
	                    {
	                        _13176 = input_TEXCOORD1.w;
	                        _16056 = true;
	                        break;
	                    }
	                    case 5u:
	                    {
	                        _13176 = input_COLOR0.w;
	                        _16056 = true;
	                        break;
	                    }
	                    case 6u:
	                    {
	                        _13176 = input_TEXCOORD3.w;
	                        _16056 = true;
	                        break;
	                    }
	                    case 7u:
	                    {
	                        _13176 = input_TEXCOORD3.x;
	                        _16056 = true;
	                        break;
	                    }
	                    case 8u:
	                    {
	                        _13176 = input_TEXCOORD3.y;
	                        _16056 = true;
	                        break;
	                    }
	                    case 9u:
	                    {
	                        _13176 = input_TEXCOORD3.z;
	                        _16056 = true;
	                        break;
	                    }
	                    case 10u:
	                    {
	                        _13176 = frac(input_TEXCOORD1.x * 1542.87060546875f);
	                        _16056 = true;
	                        break;
	                    }
	                    case 11u:
	                    {
	                        _13176 = (frac(input_TEXCOORD1.x * 1542.87060546875f) - 0.5f) * 2.0f;
	                        _16056 = true;
	                        break;
	                    }
	                    case 12u:
	                    {
	                        _13176 = (input_TEXCOORD1.z * frac(input_TEXCOORD1.x * 1542.87060546875f)) + 1.0f;
	                        _16056 = true;
	                        break;
	                    }
	                    case 13u:
	                    {
	                        float _12459 = (frac(input_TEXCOORD1.x * 1542.87060546875f) - 0.5f) * 2.0f;
	                        _13176 = (_12459 * input_TEXCOORD1.z) + float(int(sign(_12459)));
	                        _16056 = true;
	                        break;
	                    }
	                    default:
	                    {
	                        _13176 = _4;
	                        _16056 = false;
	                        break;
	                    }
	                }
	                if (_16056)
	                {
	                    _22648 = _13176;
	                    break;
	                }
	                _22648 = 1.0f;
	                break;
	            } while(false);
	            float _20617;
	            do
	            {
	                float _13177;
	                bool _16057;
	                switch (uint((_10221 >> 4) & 15))
	                {
	                    case 1u:
	                    {
	                        _13177 = input_TEXCOORD1.z + 1.0f;
	                        _16057 = true;
	                        break;
	                    }
	                    case 2u:
	                    {
	                        _13177 = (input_TEXCOORD1.z * SpritecardVertexControls_t_1_m1.w) + 1.0f;
	                        _16057 = true;
	                        break;
	                    }
	                    case 3u:
	                    {
	                        _13177 = input_TEXCOORD1.y;
	                        _16057 = true;
	                        break;
	                    }
	                    case 4u:
	                    {
	                        _13177 = input_TEXCOORD1.w;
	                        _16057 = true;
	                        break;
	                    }
	                    case 5u:
	                    {
	                        _13177 = input_COLOR0.w;
	                        _16057 = true;
	                        break;
	                    }
	                    case 6u:
	                    {
	                        _13177 = input_TEXCOORD3.w;
	                        _16057 = true;
	                        break;
	                    }
	                    case 7u:
	                    {
	                        _13177 = input_TEXCOORD3.x;
	                        _16057 = true;
	                        break;
	                    }
	                    case 8u:
	                    {
	                        _13177 = input_TEXCOORD3.y;
	                        _16057 = true;
	                        break;
	                    }
	                    case 9u:
	                    {
	                        _13177 = input_TEXCOORD3.z;
	                        _16057 = true;
	                        break;
	                    }
	                    case 10u:
	                    {
	                        _13177 = frac(input_TEXCOORD1.x * 2969.86181640625f);
	                        _16057 = true;
	                        break;
	                    }
	                    case 11u:
	                    {
	                        _13177 = (frac(input_TEXCOORD1.x * 2969.86181640625f) - 0.5f) * 2.0f;
	                        _16057 = true;
	                        break;
	                    }
	                    case 12u:
	                    {
	                        _13177 = (input_TEXCOORD1.z * frac(input_TEXCOORD1.x * 2969.86181640625f)) + 1.0f;
	                        _16057 = true;
	                        break;
	                    }
	                    case 13u:
	                    {
	                        float _12460 = (frac(input_TEXCOORD1.x * 2969.86181640625f) - 0.5f) * 2.0f;
	                        _13177 = (_12460 * input_TEXCOORD1.z) + float(int(sign(_12460)));
	                        _16057 = true;
	                        break;
	                    }
	                    default:
	                    {
	                        _13177 = _4;
	                        _16057 = false;
	                        break;
	                    }
	                }
	                if (_16057)
	                {
	                    _20617 = _13177;
	                    break;
	                }
	                _20617 = 1.0f;
	                break;
	            } while(false);
	            float2 _13164 = float4(_22759, _21640, _22759, _21640).xy - 0.5f.xx;
	            float _19474 = SpritecardVertexControls_t_1_m3.w * _20617;
	            float _9168 = cos(_19474);
	            float _25013 = sin(_19474);
	            float _11442 = _13164.x;
	            float _7574 = _13164.y;
	            float4 _8992;
	            _8992.x = (_11442 * _9168) + (_7574 * (-_25013));
	            _8992.y = (_11442 * _25013) + (_7574 * _9168);
	            float _21261;
	            do
	            {
	                float _13178;
	                bool _16058;
	                switch (uint((_10221 >> 8) & 15))
	                {
	                    case 1u:
	                    {
	                        _13178 = input_TEXCOORD1.z + 1.0f;
	                        _16058 = true;
	                        break;
	                    }
	                    case 2u:
	                    {
	                        _13178 = (input_TEXCOORD1.z * SpritecardVertexControls_t_1_m1.w) + 1.0f;
	                        _16058 = true;
	                        break;
	                    }
	                    case 3u:
	                    {
	                        _13178 = input_TEXCOORD1.y;
	                        _16058 = true;
	                        break;
	                    }
	                    case 4u:
	                    {
	                        _13178 = input_TEXCOORD1.w;
	                        _16058 = true;
	                        break;
	                    }
	                    case 5u:
	                    {
	                        _13178 = input_COLOR0.w;
	                        _16058 = true;
	                        break;
	                    }
	                    case 6u:
	                    {
	                        _13178 = input_TEXCOORD3.w;
	                        _16058 = true;
	                        break;
	                    }
	                    case 7u:
	                    {
	                        _13178 = input_TEXCOORD3.x;
	                        _16058 = true;
	                        break;
	                    }
	                    case 8u:
	                    {
	                        _13178 = input_TEXCOORD3.y;
	                        _16058 = true;
	                        break;
	                    }
	                    case 9u:
	                    {
	                        _13178 = input_TEXCOORD3.z;
	                        _16058 = true;
	                        break;
	                    }
	                    case 10u:
	                    {
	                        _13178 = frac(input_TEXCOORD1.x * 1944.34521484375f);
	                        _16058 = true;
	                        break;
	                    }
	                    case 11u:
	                    {
	                        _13178 = (frac(input_TEXCOORD1.x * 1944.34521484375f) - 0.5f) * 2.0f;
	                        _16058 = true;
	                        break;
	                    }
	                    case 12u:
	                    {
	                        _13178 = (input_TEXCOORD1.z * frac(input_TEXCOORD1.x * 1944.34521484375f)) + 1.0f;
	                        _16058 = true;
	                        break;
	                    }
	                    case 13u:
	                    {
	                        float _12461 = (frac(input_TEXCOORD1.x * 1944.34521484375f) - 0.5f) * 2.0f;
	                        _13178 = (_12461 * input_TEXCOORD1.z) + float(int(sign(_12461)));
	                        _16058 = true;
	                        break;
	                    }
	                    default:
	                    {
	                        _13178 = _4;
	                        _16058 = false;
	                        break;
	                    }
	                }
	                if (_16058)
	                {
	                    _21261 = _13178;
	                    break;
	                }
	                _21261 = 1.0f;
	                break;
	            } while(false);
	            float4 _20273 = float4((((_8992.xy / _13745.xy) * (1.0f / _12960)) + frac((_11357.xy * float2(_12904, _22648)) + 0.5f.xx)) + lerp(0.0f.xx, frac(float2(input_TEXCOORD1.x * 1718.4361572265625f, input_TEXCOORD1.x * 1271.89013671875f)), _15588.xx), _21261, 1.0f);
	            float4 _12905;
	            if (_14700 >= 3u)
	            {
	                float _22340;
	                do
	                {
	                    float _13179;
	                    bool _16059;
	                    switch (uint((_10221 >> 12) & 15))
	                    {
	                        case 1u:
	                        {
	                            _13179 = input_TEXCOORD1.z + 1.0f;
	                            _16059 = true;
	                            break;
	                        }
	                        case 2u:
	                        {
	                            _13179 = (input_TEXCOORD1.z * SpritecardVertexControls_t_1_m1.w) + 1.0f;
	                            _16059 = true;
	                            break;
	                        }
	                        case 3u:
	                        {
	                            _13179 = input_TEXCOORD1.y;
	                            _16059 = true;
	                            break;
	                        }
	                        case 4u:
	                        {
	                            _13179 = input_TEXCOORD1.w;
	                            _16059 = true;
	                            break;
	                        }
	                        case 5u:
	                        {
	                            _13179 = input_COLOR0.w;
	                            _16059 = true;
	                            break;
	                        }
	                        case 6u:
	                        {
	                            _13179 = input_TEXCOORD3.w;
	                            _16059 = true;
	                            break;
	                        }
	                        case 7u:
	                        {
	                            _13179 = input_TEXCOORD3.x;
	                            _16059 = true;
	                            break;
	                        }
	                        case 8u:
	                        {
	                            _13179 = input_TEXCOORD3.y;
	                            _16059 = true;
	                            break;
	                        }
	                        case 9u:
	                        {
	                            _13179 = input_TEXCOORD3.z;
	                            _16059 = true;
	                            break;
	                        }
	                        case 10u:
	                        {
	                            _13179 = frac(input_TEXCOORD1.x * 2704.225341796875f);
	                            _16059 = true;
	                            break;
	                        }
	                        case 11u:
	                        {
	                            _13179 = (frac(input_TEXCOORD1.x * 2704.225341796875f) - 0.5f) * 2.0f;
	                            _16059 = true;
	                            break;
	                        }
	                        case 12u:
	                        {
	                            _13179 = (input_TEXCOORD1.z * frac(input_TEXCOORD1.x * 2704.225341796875f)) + 1.0f;
	                            _16059 = true;
	                            break;
	                        }
	                        case 13u:
	                        {
	                            float _12462 = (frac(input_TEXCOORD1.x * 2704.225341796875f) - 0.5f) * 2.0f;
	                            _13179 = (_12462 * input_TEXCOORD1.z) + float(int(sign(_12462)));
	                            _16059 = true;
	                            break;
	                        }
	                        default:
	                        {
	                            _13179 = _4;
	                            _16059 = false;
	                            break;
	                        }
	                    }
	                    if (_16059)
	                    {
	                        _22340 = _13179;
	                        break;
	                    }
	                    _22340 = 1.0f;
	                    break;
	                } while(false);
	                float4 _10002 = _20273;
	                _10002.w = _22340;
	                _12905 = _10002;
	            }
	            else
	            {
	                _12905 = _20273;
	            }
	            float _20309;
	            do
	            {
	                float _13180;
	                bool _16060;
	                switch (_23505)
	                {
	                    case 1u:
	                    {
	                        _13180 = input_TEXCOORD1.z + 1.0f;
	                        _16060 = true;
	                        break;
	                    }
	                    case 2u:
	                    {
	                        _13180 = (input_TEXCOORD1.z * SpritecardVertexControls_t_1_m1.w) + 1.0f;
	                        _16060 = true;
	                        break;
	                    }
	                    case 3u:
	                    {
	                        _13180 = input_TEXCOORD1.y;
	                        _16060 = true;
	                        break;
	                    }
	                    case 4u:
	                    {
	                        _13180 = input_TEXCOORD1.w;
	                        _16060 = true;
	                        break;
	                    }
	                    case 5u:
	                    {
	                        _13180 = input_COLOR0.w;
	                        _16060 = true;
	                        break;
	                    }
	                    case 6u:
	                    {
	                        _13180 = input_TEXCOORD3.w;
	                        _16060 = true;
	                        break;
	                    }
	                    case 7u:
	                    {
	                        _13180 = input_TEXCOORD3.x;
	                        _16060 = true;
	                        break;
	                    }
	                    case 8u:
	                    {
	                        _13180 = input_TEXCOORD3.y;
	                        _16060 = true;
	                        break;
	                    }
	                    case 9u:
	                    {
	                        _13180 = input_TEXCOORD3.z;
	                        _16060 = true;
	                        break;
	                    }
	                    case 10u:
	                    {
	                        _13180 = frac(input_TEXCOORD1.x * 4574.43115234375f);
	                        _16060 = true;
	                        break;
	                    }
	                    case 11u:
	                    {
	                        _13180 = (frac(input_TEXCOORD1.x * 4574.43115234375f) - 0.5f) * 2.0f;
	                        _16060 = true;
	                        break;
	                    }
	                    case 12u:
	                    {
	                        _13180 = (input_TEXCOORD1.z * frac(input_TEXCOORD1.x * 4574.43115234375f)) + 1.0f;
	                        _16060 = true;
	                        break;
	                    }
	                    case 13u:
	                    {
	                        float _12463 = (frac(input_TEXCOORD1.x * 4574.43115234375f) - 0.5f) * 2.0f;
	                        _13180 = (_12463 * input_TEXCOORD1.z) + float(int(sign(_12463)));
	                        _16060 = true;
	                        break;
	                    }
	                    default:
	                    {
	                        _13180 = _4;
	                        _16060 = false;
	                        break;
	                    }
	                }
	                if (_16060)
	                {
	                    _20309 = _13180;
	                    break;
	                }
	                _20309 = 1.0f;
	                break;
	            } while(false);
	            float4 _18602 = _12905;
	            _18602.w = _12905.w * _20309;
	            _20091 = _18602;
	            break;
	        }
	        break; // unreachable workaround
	    } while(false);
	    float4 _20655;
	    if (((int(SpriteCardPixelControls_t_1_m0.z) >> 7) & 1) == 1)
	    {
	        float _12837;
	        do
	        {
	            float _13185;
	            bool _16065;
	            switch (uint(_20704 & 15))
	            {
	                case 1u:
	                {
	                    _13185 = input_TEXCOORD1.z + 1.0f;
	                    _16065 = true;
	                    break;
	                }
	                case 2u:
	                {
	                    _13185 = (input_TEXCOORD1.z * SpritecardVertexControls_t_1_m1.w) + 1.0f;
	                    _16065 = true;
	                    break;
	                }
	                case 3u:
	                {
	                    _13185 = input_TEXCOORD1.y;
	                    _16065 = true;
	                    break;
	                }
	                case 4u:
	                {
	                    _13185 = input_TEXCOORD1.w;
	                    _16065 = true;
	                    break;
	                }
	                case 5u:
	                {
	                    _13185 = input_COLOR0.w;
	                    _16065 = true;
	                    break;
	                }
	                case 6u:
	                {
	                    _13185 = input_TEXCOORD3.w;
	                    _16065 = true;
	                    break;
	                }
	                case 7u:
	                {
	                    _13185 = input_TEXCOORD3.x;
	                    _16065 = true;
	                    break;
	                }
	                case 8u:
	                {
	                    _13185 = input_TEXCOORD3.y;
	                    _16065 = true;
	                    break;
	                }
	                case 9u:
	                {
	                    _13185 = input_TEXCOORD3.z;
	                    _16065 = true;
	                    break;
	                }
	                case 10u:
	                {
	                    _13185 = frac(input_TEXCOORD1.x * 238.839996337890625f);
	                    _16065 = true;
	                    break;
	                }
	                case 11u:
	                {
	                    _13185 = (frac(input_TEXCOORD1.x * 238.839996337890625f) - 0.5f) * 2.0f;
	                    _16065 = true;
	                    break;
	                }
	                case 12u:
	                {
	                    _13185 = (input_TEXCOORD1.z * frac(input_TEXCOORD1.x * 238.839996337890625f)) + 1.0f;
	                    _16065 = true;
	                    break;
	                }
	                case 13u:
	                {
	                    float _12468 = (frac(input_TEXCOORD1.x * 238.839996337890625f) - 0.5f) * 2.0f;
	                    _13185 = (_12468 * input_TEXCOORD1.z) + float(int(sign(_12468)));
	                    _16065 = true;
	                    break;
	                }
	                default:
	                {
	                    _13185 = _4;
	                    _16065 = false;
	                    break;
	                }
	            }
	            if (_16065)
	            {
	                _12837 = _13185;
	                break;
	            }
	            _12837 = 1.0f;
	            break;
	        } while(false);
	        float _19167;
	        do
	        {
	            float _13186;
	            bool _16066;
	            switch (uint((_20704 >> 4) & 15))
	            {
	                case 1u:
	                {
	                    _13186 = input_TEXCOORD1.z + 1.0f;
	                    _16066 = true;
	                    break;
	                }
	                case 2u:
	                {
	                    _13186 = (input_TEXCOORD1.z * SpritecardVertexControls_t_1_m1.w) + 1.0f;
	                    _16066 = true;
	                    break;
	                }
	                case 3u:
	                {
	                    _13186 = input_TEXCOORD1.y;
	                    _16066 = true;
	                    break;
	                }
	                case 4u:
	                {
	                    _13186 = input_TEXCOORD1.w;
	                    _16066 = true;
	                    break;
	                }
	                case 5u:
	                {
	                    _13186 = input_COLOR0.w;
	                    _16066 = true;
	                    break;
	                }
	                case 6u:
	                {
	                    _13186 = input_TEXCOORD3.w;
	                    _16066 = true;
	                    break;
	                }
	                case 7u:
	                {
	                    _13186 = input_TEXCOORD3.x;
	                    _16066 = true;
	                    break;
	                }
	                case 8u:
	                {
	                    _13186 = input_TEXCOORD3.y;
	                    _16066 = true;
	                    break;
	                }
	                case 9u:
	                {
	                    _13186 = input_TEXCOORD3.z;
	                    _16066 = true;
	                    break;
	                }
	                case 10u:
	                {
	                    _13186 = frac(input_TEXCOORD1.x * 84.74559783935546875f);
	                    _16066 = true;
	                    break;
	                }
	                case 11u:
	                {
	                    _13186 = (frac(input_TEXCOORD1.x * 84.74559783935546875f) - 0.5f) * 2.0f;
	                    _16066 = true;
	                    break;
	                }
	                case 12u:
	                {
	                    _13186 = (input_TEXCOORD1.z * frac(input_TEXCOORD1.x * 84.74559783935546875f)) + 1.0f;
	                    _16066 = true;
	                    break;
	                }
	                case 13u:
	                {
	                    float _12469 = (frac(input_TEXCOORD1.x * 84.74559783935546875f) - 0.5f) * 2.0f;
	                    _13186 = (_12469 * input_TEXCOORD1.z) + float(int(sign(_12469)));
	                    _16066 = true;
	                    break;
	                }
	                default:
	                {
	                    _13186 = _4;
	                    _16066 = false;
	                    break;
	                }
	            }
	            if (_16066)
	            {
	                _19167 = _13186;
	                break;
	            }
	            _19167 = 1.0f;
	            break;
	        } while(false);
	        float4 _19841 = float4(-1.0f, -1.0f, 1.0f, 0.0f);
	        _19841.z = 1.0f - _12837;
	        _19841.w = _19167;
	        _20655 = _19841;
	    }
	    else
	    {
	        _20655 = float4(-1.0f, -1.0f, 1.0f, 0.0f);
	    }
	    float3 _18058 = input_COLOR0.xyz * 0.077399380505084991455078125f.xxx;
	    float3 _7676 = pow((input_COLOR0.xyz * 0.947867333889007568359375f.xxx) + 0.052132703363895416259765625f.xxx, 2.400000095367431640625f.xxx);
	    float _21354;
	    if (input_COLOR0.x <= 0.040449999272823333740234375f)
	    {
	        _21354 = _18058.x;
	    }
	    else
	    {
	        _21354 = _7676.x;
	    }
	    float _21355;
	    if (input_COLOR0.y <= 0.040449999272823333740234375f)
	    {
	        _21355 = _18058.y;
	    }
	    else
	    {
	        _21355 = _7676.y;
	    }
	    float _19494;
	    if (input_COLOR0.z <= 0.040449999272823333740234375f)
	    {
	        _19494 = _18058.z;
	    }
	    else
	    {
	        _19494 = _7676.z;
	    }
	    float4 _25152 = lerp(input_COLOR0, float4(float3(_21354, _21355, _19494), input_COLOR0.w), float((_20704 >> 8) & 15).xxxx);
	    float3 _17858 = cross(PerViewConstantBuffer_t_1_m5, PerViewConstantBuffer_t_1_m4);
	    float _8664 = cos(input_TEXCOORD3.x);
	    float _23279 = sin(input_TEXCOORD3.x);
	    float3 _18015 = (PerViewConstantBuffer_t_1_m4 * _8664) - (_17858 * _23279);
	    float _19825 = sin(input_TEXCOORD3.y);
	    float _8898 = cos(input_TEXCOORD3.y);
	    float _9794 = _18015.x;
	    float _21121 = _9794 * _9794;
	    float _24619 = _18015.y;
	    float _7331 = _24619 * _24619;
	    float _6498 = _18015.z;
	    float _17752 = _6498 * _6498;
	    float _22875 = 1.0f - _8898;
	    float _10185 = (_9794 * _24619) * _22875;
	    float _21408 = _6498 * _19825;
	    float _6451 = (_6498 * _9794) * _22875;
	    float _22637 = _24619 * _19825;
	    float _6426 = (_24619 * _6498) * _22875;
	    float _22945 = _9794 * _19825;
	    float _20054 = length(PerViewConstantBuffer_t_1_m3.xyz - input_POSITION0.xyz);
	    float _10020;
	    float4 _24447;
	    if (SpritecardVertexControls_t_1_m2.z > 0.0f)
	    {
	        float _16605 = SpritecardVertexControls_t_1_m0.y * _20054;
	        float4 _20311;
	        if (input_TEXCOORD3.w > _16605)
	        {
	            float4 _12501;
	            if (input_TEXCOORD3.w > (SpritecardVertexControls_t_1_m0.z * _20054))
	            {
	                _12501 = 0.0f.xxxx;
	            }
	            else
	            {
	                _12501 = _25152 * (1.0f - ((input_TEXCOORD3.w - _16605) / (_20054 * (SpritecardVertexControls_t_1_m0.z - SpritecardVertexControls_t_1_m0.y))));
	            }
	            _20311 = _12501;
	        }
	        else
	        {
	            _20311 = _25152;
	        }
	        _10020 = min(max(input_TEXCOORD3.w, SpritecardVertexControls_t_1_m0.x * _20054), SpritecardVertexControls_t_1_m0.w * _20054);
	        _24447 = _20311;
	    }
	    else
	    {
	        _10020 = input_TEXCOORD3.w;
	        _24447 = _25152;
	    }
	    float3 _19802 = input_POSITION0.xyz + (((mul(float3x3(float3(_21121 + ((1.0f - _21121) * _8898), _10185 - _21408, _6451 + _22637), float3(_10185 + _21408, _7331 + ((1.0f - _7331) * _8898), _6426 - _22945), float3(_6451 - _22637, _6426 + _22945, _17752 + ((1.0f - _17752) * _8898))), (_17858 * _8664) + (PerViewConstantBuffer_t_1_m4 * _23279)) * (input_TEXCOORD0.x + SpritecardVertexControls_t_1_m1.y)) + (_18015 * (input_TEXCOORD0.y + SpritecardVertexControls_t_1_m1.z))) * ((_24447.w < 0.0039215688593685626983642578125f) ? 0.0f : _10020));
	    float3 _7336 = _19802.xyz;
	    float4 _8056 = float4(_7336, 1.0f);
	    float4 _21447 = PerViewConstantBuffer_t_1_m2 * 1.0f;
	    float4 _18275 = mul(PerViewConstantBuffer_t_1_m0, (_8056 + _21447).xyzw);
	    float4 _8847 = mul(PerViewConstantBuffer_t_1_m0, (float4((_19802 + (PerViewConstantBuffer_t_1_m5 * SpritecardVertexControls_t_1_m1.x)).xyz, 1.0f) + _21447).xyzw);
	    float4 _15598 = _18275;
	    _15598.z = max(_18275.w * (_8847.z / _8847.w), min(0.001000000047497451305389404296875f, _18275.z));
	    float3 _21709;
	    if (SpriteCardPixelControls_t_1_m0.w != (-1.0f))
	    {
	        float3 _14744 = normalize(-(_7336 - PerViewConstantBuffer_t_1_m3.xyz).xyz).xyz;
	        float3 _23378 = clamp(_14744, 0.0f.xxx, 1.0f.xxx);
	        float3 _23904 = clamp(-_14744, 0.0f.xxx, 1.0f.xxx);
	        _21709 = lerp(((RoughnessLightingGlobalsCB_t_1_m0.xyz * (dot(float3(0.60000002384185791015625f, 0.4000000059604644775390625f, 1.0f), _23378 * _23378) + dot(float3(0.60000002384185791015625f, 0.4000000059604644775390625f, 0.20000000298023223876953125f), _23904 * _23904))).xyz + ((SunLightShaderParamsCB_t_1_m0.xyz * (pow(saturate(dot(_14744, SunLightShaderParamsCB_t_1_m1.xyz)), 0.60000002384185791015625f) * 0.800000011920928955078125f)) * 1.0f)).xyz, PerViewConstantBuffer_t_1_m6.xyz, saturate(min(PerViewConstantBuffer_t_1_m9, pow(saturate((distance(_19802.xyz, PerViewConstantBuffer_t_1_m3.xyz) * PerViewConstantBuffer_t_1_m8) + PerViewConstantBuffer_t_1_m7), PerViewConstantBuffer_t_1_m10))).xxx);
	    }
	    else
	    {
	        _21709 = 0.0f.xxx;
	    }
	    output_0 = _20091;
	    output_1 = _24447;
	    output_2 = _21709;
	    output_3 = _19802;
	    output_4 = 0.0f.xxx;
	    output_5 = _20655;
	    _15598.y = -_18275.y;
	    gl_Position = _15598;
	    gl_ClipDistance[0] = dot(_8056, PerViewConstantBuffer_t_1_m1.xyzw);
	}
	
	PS_INPUT MainVs(VS_INPUT stage_input)
	{
	    input_TEXCOORD0 = stage_input.input_TEXCOORD0;
	    input_TEXCOORD1 = stage_input.input_TEXCOORD1;
	    input_COLOR0 = stage_input.input_COLOR0;
	    input_POSITION0 = stage_input.input_POSITION0;
	    input_TEXCOORD3 = stage_input.input_TEXCOORD3;
	    MainVs_inner();
	    PS_INPUT stage_output;
	    stage_output.gl_Position = gl_Position;
	    stage_output.gl_ClipDistance0.x = gl_ClipDistance[0];
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

PS
{
	StaticCombo( S_TOOLS_ENABLED, 0, Sys( 1 ) );
	StaticCombo( S_MODE_DEPTH, 0..1 );
	StaticCombo( S_MOD2X, F_MOD2X );
	StaticCombo( S_REVERSE_DEPTH, F_REVERSE_DEPTH );
	StaticCombo( S_NUM_SEQUENCES_PER_PARTICLE, F_NUM_SEQUENCES_PER_PARTICLE );
	StaticCombo( S_HAS_NO_NORMAL_FOR_LIGHTING, F_HAS_NO_NORMAL_FOR_LIGHTING );
	StaticCombo( S_REFRACT, F_REFRACT );
	StaticCombo( S_HSV_SHIFT, F_HSV_SHIFT );
	StaticCombo( S_DRAW_AS_TRAIL, F_DRAW_AS_TRAIL );
	StaticCombo( S_OPAQUE, F_OPAQUE );
	StaticCombo( S_TEXTURE_LAYERS, F_TEXTURE_LAYERS );
	StaticComboRule( Allow1( S_MODE_DEPTH, S_OPAQUE ) );
	StaticComboRule( Allow1( S_REFRACT, S_TEXTURE_LAYERS ) );
	DynamicCombo( D_DEPTH_FEATHERING, 0..1 );
	DynamicCombo( D_FASTPATH, 0..1 );
	DynamicComboRule( Allow1( S_MODE_DEPTH, D_DEPTH_FEATHERING ) );
	DynamicComboRule( Allow1( S_REFRACT, D_FASTPATH ) );
	DynamicComboRule( Allow1( S_OPAQUE, D_DEPTH_FEATHERING ) );
	
	RenderState(BlendEnable, true);
	RenderState(BlendOp, F_LIGHTEN_MODE ? Max : Add);
	RenderState(ColorWriteEnable0, R|G|B);
	RenderState(DepthFunc, F_DISABLE_DEPTHTEST ? Always : LessEqual);
	RenderState(DepthWriteEnable, false);
	RenderState(DstBlend, F_LIGHTEN_MODE || (F_MOD2X ? 2 : 5));
	RenderState(SrcBlend, F_MOD2X ? DestColor : One);
	Texture2D g_tBaseTexture < Attribute("BaseTexture"); SrgbRead(true); >;
	Texture2D g_tBaseTextureNoSRGB < Attribute("BaseTexture"); SrgbRead(false); >;
	Texture2D g_tDepthTexture < Attribute("SceneDepth"); SrgbRead(false); >;
	Texture2D g_tFrameBufferCopyTexture < Attribute("FrameBufferCopyTexture"); SrgbRead(true); >;
	Texture2D g_tTextureLayer1 < Attribute("TextureLayer1"); SrgbRead(true); >;
	Texture2D g_tTextureLayer2 < Attribute("TextureLayer2"); SrgbRead(true); >;
	Texture2D g_tTextureLayer3 < Attribute("TextureLayer3"); SrgbRead(true); >;
	
	// Source 2 Viewer - https://valveresourceformat.github.io
	// SPIR-V source, HLSL reflection with SPIRV-Cross by KhronosGroup
	
	static float _2;
	static float4 _3;
	static float4 _4;
	
	static const float3 _877[15] = { 0.0f.xxx, 0.0f.xxx, 0.0f.xxx, float3(0.0f, 1.0f, 0.0f), float3(1.0f, 0.0f, 0.0f), float3(1.0f, 0.0f, 1.0f), 0.0f.xxx, 0.0f.xxx, float3(0.0f, 1.0f, 0.0f), 0.0f.xxx, 0.0f.xxx, 0.0f.xxx, 0.0f.xxx, 0.0f.xxx, 0.0f.xxx };
	static const float2 _2191[15] = { float2(1.0f, 0.0f), 0.0f.xx, float2(0.0f, 1.0f), 0.0f.xx, float2(1.0f, 0.0f), float2(1.0f, 0.0f), 0.0f.xx, float2(0.0f, 1.0f), 0.0f.xx, float2(1.0f, 0.0f), float2(1.0f, 0.0f), float2(1.0f, 0.0f), 0.0f.xx, 0.0f.xx, 0.0f.xx };
	
	cbuffer SpriteCardPixelControls_t : register(b3, space1)
	{
	    float4 SpriteCardPixelControls_t_1_m0 : packoffset(c0);
	    float4 SpriteCardPixelControls_t_1_m1 : packoffset(c1);
	    float4 SpriteCardPixelControls_t_1_m2 : packoffset(c3);
	    float4 SpriteCardPixelControls_t_1_m3 : packoffset(c4);
	    float4 SpriteCardPixelControls_t_1_m4 : packoffset(c5);
	    float4 SpriteCardPixelControls_t_1_m5 : packoffset(c6);
	    float4 SpriteCardPixelControls_t_1_m6 : packoffset(c8);
	    float4 SpriteCardPixelControls_t_1_m7 : packoffset(c9);
	    uint2 SpriteCardPixelControls_t_1_m8 : packoffset(c19);
	};
	
	cbuffer RoughnessLightingGlobalsCB_t : register(b1, space1)
	{
	    float4 RoughnessLightingGlobalsCB_t_1_m0 : packoffset(c0);
	};
	
	cbuffer PerViewConstantBuffer_t : register(b0, space1)
	{
	    float PerViewConstantBuffer_t_1_m0 : packoffset(c18);
	    float3 PerViewConstantBuffer_t_1_m1 : packoffset(c26);
	    float3 PerViewConstantBuffer_t_1_m2 : packoffset(c31);
	    float PerViewConstantBuffer_t_1_m3 : packoffset(c31.w);
	    float PerViewConstantBuffer_t_1_m4 : packoffset(c32);
	    float PerViewConstantBuffer_t_1_m5 : packoffset(c32.y);
	    float PerViewConstantBuffer_t_1_m6 : packoffset(c32.z);
	};
	
	cbuffer SunLightShaderParamsCB_t : register(b2, space1)
	{
	    float3 SunLightShaderParamsCB_t_1_m0 : packoffset(c0);
	    float3 SunLightShaderParamsCB_t_1_m1 : packoffset(c1);
	};
	
	Texture2D<float4> g_tBaseTexture : register(t32, space1);
	SamplerState AddressU_Clamp_AddressV_Clamp_Filter_MinMagMipLinear_MaxAniso_1 : register(s17, space1);
	SamplerState Filter_MinMagMipLinear_MaxAniso_1 : register(s15, space1);
	
	static float4 input_0;
	static float4 input_1;
	static float3 input_2;
	static float3 input_3;
	static float3 input_4;
	static float4 input_5;
	static float4 output_0;
	
	struct PS_INPUT
	{
	    float4 input_0 : TEXCOORD0;
	    float4 input_1 : TEXCOORD1;
	    float3 input_2 : TEXCOORD2;
	    float3 input_3 : TEXCOORD3;
	    float3 input_4 : TEXCOORD4;
	    nointerpolation float4 input_5 : TEXCOORD5;
	};
	
	struct PS_OUTPUT
	{
	    float4 output_0 : SV_Target0;
	};
	
	void MainPs_inner()
	{
	    float4 _15476 = input_0.xyzw;
	    _15476.x = input_0.x;
	    int _10622 = int(SpriteCardPixelControls_t_1_m2.z);
	    int _20632 = _10622 & 1;
	    float4 _21709;
	    if (_20632 == 1)
	    {
	        _21709 = g_tBaseTexture.Sample(AddressU_Clamp_AddressV_Clamp_Filter_MinMagMipLinear_MaxAniso_1, _15476.xy);
	    }
	    else
	    {
	        _21709 = g_tBaseTexture.Sample(Filter_MinMagMipLinear_MaxAniso_1, _15476.xy);
	    }
	    int _18311 = int(SpriteCardPixelControls_t_1_m8.x);
	    int _23893 = _18311 & 15;
	    uint _23505 = uint(((_18311 & 255) >> 4) & 15);
	    float4 _12885;
	    do
	    {
	        float4 _13174;
	        bool _16054;
	        [branch]
	        switch (uint((int(SpriteCardPixelControls_t_1_m8.y) >> 16) & 15))
	        {
	            case 0u:
	            {
	                _13174 = _21709;
	                _16054 = true;
	                break;
	            }
	            case 1u:
	            {
	                bool _13058;
	                float _11534 = frac(SpriteCardPixelControls_t_1_m6.z * input_0.z);
	                float _16439 = _11534 / (((-0.39999997615814208984375f) * (1.0f - _11534)) + 1.0f);
	                float4 _22205 = _15476 - 0.5f.xxxx;
	                float4 _17630 = (_22205 * lerp(4.0f, 1.0f, _16439)) + 0.5f.xxxx;
	                float4 _11008 = (_22205 * lerp(1.0f, 0.0625f, _16439)) + 0.5f.xxxx;
	                float4 _12905;
	                do
	                {
	                    _13058 = float(_20632) == 1.0f;
	                    if (_13058)
	                    {
	                        _12905 = g_tBaseTexture.Sample(AddressU_Clamp_AddressV_Clamp_Filter_MinMagMipLinear_MaxAniso_1, _17630.xy);
	                        break;
	                    }
	                    _12905 = g_tBaseTexture.Sample(Filter_MinMagMipLinear_MaxAniso_1, _17630.xy);
	                    break;
	                } while(false);
	                float4 _19630;
	                do
	                {
	                    if (_13058)
	                    {
	                        _19630 = g_tBaseTexture.Sample(AddressU_Clamp_AddressV_Clamp_Filter_MinMagMipLinear_MaxAniso_1, _11008.xy);
	                        break;
	                    }
	                    _19630 = g_tBaseTexture.Sample(Filter_MinMagMipLinear_MaxAniso_1, _11008.xy);
	                    break;
	                } while(false);
	                float4 _10911 = lerp(_19630.xyzw, _12905.xyzw, (_16439 * _16439).xxxx);
	                _10911.w = lerp(_21709.w, _10911.w, float(_877[_23893].y != 1.0f));
	                _13174 = _10911;
	                _16054 = true;
	                break;
	            }
	            case 3u:
	            {
	                float3 _23252 = _21709.xyz * 12.9200000762939453125f;
	                float3 _7486 = (pow(_21709.xyz, 0.4166666567325592041015625f.xxx) * 1.05499994754791259765625f) - 0.054999999701976776123046875f.xxx;
	                float _21356;
	                if (_21709.x <= 0.003130800090730190277099609375f)
	                {
	                    _21356 = _23252.x;
	                }
	                else
	                {
	                    _21356 = _7486.x;
	                }
	                float _19458;
	                if (_21709.y <= 0.003130800090730190277099609375f)
	                {
	                    _19458 = _23252.y;
	                }
	                else
	                {
	                    _19458 = _7486.y;
	                }
	                float2 _24723 = _15476.xy - (((float3(_21356, _19458, _2).xy - 0.5f.xx) * 2.0f) * (((SpriteCardPixelControls_t_1_m6.w * input_0.w) * 0.125f) * _21709.w));
	                float4 _12502;
	                do
	                {
	                    if (float(_20632) == 1.0f)
	                    {
	                        _12502 = g_tBaseTexture.Sample(AddressU_Clamp_AddressV_Clamp_Filter_MinMagMipLinear_MaxAniso_1, _24723.xy);
	                        break;
	                    }
	                    _12502 = g_tBaseTexture.Sample(Filter_MinMagMipLinear_MaxAniso_1, _24723.xy);
	                    break;
	                } while(false);
	                _13174 = _12502;
	                _16054 = true;
	                break;
	            }
	            case 4u:
	            {
	                bool _13056;
	                float _11533 = frac(SpriteCardPixelControls_t_1_m6.z * input_0.z);
	                float _16438 = _11533 / (((-0.39999997615814208984375f) * (1.0f - _11533)) + 1.0f);
	                float4 _22204 = _15476 - 0.5f.xxxx;
	                float4 _17629 = (_22204 * lerp(4.0f, 1.0f, _16438)) + 0.5f.xxxx;
	                float4 _11007 = (_22204 * lerp(1.0f, 0.0625f, _16438)) + 0.5f.xxxx;
	                float4 _12904;
	                do
	                {
	                    _13056 = float(_20632) == 1.0f;
	                    if (_13056)
	                    {
	                        _12904 = g_tBaseTexture.Sample(AddressU_Clamp_AddressV_Clamp_Filter_MinMagMipLinear_MaxAniso_1, _17629.xy);
	                        break;
	                    }
	                    _12904 = g_tBaseTexture.Sample(Filter_MinMagMipLinear_MaxAniso_1, _17629.xy);
	                    break;
	                } while(false);
	                float4 _19629;
	                do
	                {
	                    if (_13056)
	                    {
	                        _19629 = g_tBaseTexture.Sample(AddressU_Clamp_AddressV_Clamp_Filter_MinMagMipLinear_MaxAniso_1, _11007.xy);
	                        break;
	                    }
	                    _19629 = g_tBaseTexture.Sample(Filter_MinMagMipLinear_MaxAniso_1, _11007.xy);
	                    break;
	                } while(false);
	                float4 _10910 = lerp(_19629.xyzw, _12904.xyzw, (_16438 * _16438).xxxx);
	                float3 _9674 = _10910.xyz;
	                float3 _23251 = _9674 * 12.9200000762939453125f;
	                float3 _9166 = (pow(_9674, 0.4166666567325592041015625f.xxx) * 1.05499994754791259765625f) - 0.054999999701976776123046875f.xxx;
	                float _23035;
	                if (_10910.x <= 0.003130800090730190277099609375f)
	                {
	                    _23035 = _23251.x;
	                }
	                else
	                {
	                    _23035 = _9166.x;
	                }
	                float _19457;
	                if (_10910.y <= 0.003130800090730190277099609375f)
	                {
	                    _19457 = _23251.y;
	                }
	                else
	                {
	                    _19457 = _9166.y;
	                }
	                float2 _20342 = _15476.xy - (((float3(_23035, _19457, _2).xy - 0.5f.xx) * 2.0f) * (((SpriteCardPixelControls_t_1_m6.w * input_0.w) * 0.125f) * lerp(_21709.w, _10910.w, float(_877[_23893].y != 1.0f))));
	                float4 _12501;
	                do
	                {
	                    if (_13056)
	                    {
	                        _12501 = g_tBaseTexture.Sample(AddressU_Clamp_AddressV_Clamp_Filter_MinMagMipLinear_MaxAniso_1, _20342.xy);
	                        break;
	                    }
	                    _12501 = g_tBaseTexture.Sample(Filter_MinMagMipLinear_MaxAniso_1, _20342.xy);
	                    break;
	                } while(false);
	                _13174 = _12501;
	                _16054 = true;
	                break;
	            }
	            case 2u:
	            {
	                float4 _20655 = _2191[_23893].y.xxxx;
	                float4 _9219 = lerp(lerp(float4(_21709.xyz * _21709.www, 1.0f), _21709, _2191[_23893].x.xxxx), _21709.wwww, _20655);
	                float3 _25122 = _9219.xyz;
	                float3 _17379 = _25122 * 12.9200000762939453125f;
	                float3 _7485 = (pow(_25122, 0.4166666567325592041015625f.xxx) * 1.05499994754791259765625f) - 0.054999999701976776123046875f.xxx;
	                float _21354;
	                if (_9219.x <= 0.003130800090730190277099609375f)
	                {
	                    _21354 = _17379.x;
	                }
	                else
	                {
	                    _21354 = _7485.x;
	                }
	                float _21355;
	                if (_9219.y <= 0.003130800090730190277099609375f)
	                {
	                    _21355 = _17379.y;
	                }
	                else
	                {
	                    _21355 = _7485.y;
	                }
	                float _19456;
	                if (_9219.z <= 0.003130800090730190277099609375f)
	                {
	                    _19456 = _17379.z;
	                }
	                else
	                {
	                    _19456 = _7485.z;
	                }
	                float2 _18974 = float2((dot(float3(_21354, _21355, _19456).xyz, float3(0.2125000059604644775390625f, 0.7153999805450439453125f, 0.07209999859333038330078125f)) + input_0.x) * input_0.z, input_0.y);
	                float4 _20940;
	                do
	                {
	                    if (float(_20632) == 1.0f)
	                    {
	                        _20940 = g_tBaseTexture.Sample(AddressU_Clamp_AddressV_Clamp_Filter_MinMagMipLinear_MaxAniso_1, _18974.xy);
	                        break;
	                    }
	                    _20940 = g_tBaseTexture.Sample(Filter_MinMagMipLinear_MaxAniso_1, _18974.xy);
	                    break;
	                } while(false);
	                float4 _19793 = _20940;
	                _19793.w = dot(_20940.xyz, float3(0.2989999949932098388671875f, 0.58700001239776611328125f, 0.114000000059604644775390625f));
	                float4 _6690 = _20940;
	                _6690.w = _21709.w;
	                _13174 = lerp(_6690, _19793, _20655);
	                _16054 = true;
	                break;
	            }
	            default:
	            {
	                _13174 = _3;
	                _16054 = false;
	                break;
	            }
	        }
	        if (_16054)
	        {
	            _12885 = _13174;
	            break;
	        }
	        _12885 = _21709;
	        break;
	    } while(false);
	    float _12906;
	    if (((_10622 >> 12) & 1) == 1)
	    {
	        _12906 = SpriteCardPixelControls_t_1_m6.y * input_0.w;
	    }
	    else
	    {
	        _12906 = SpriteCardPixelControls_t_1_m6.y;
	    }
	    float4 _12907;
	    switch (uint(_23893))
	    {
	        case 0u:
	        {
	            float4 _22456 = _12885;
	            _22456.w = lerp(1.0f, 0.0f, float(_23505 == 4u));
	            _12907 = _22456;
	            break;
	        }
	        case 1u:
	        {
	            _12907 = _12885;
	            break;
	        }
	        case 2u:
	        {
	            float3 _14141 = lerp(1.0f.xxx, 0.0f.xxx, float(_23505 == 4u).xxx);
	            float4 _17848 = _12885;
	            _17848.x = _14141.x;
	            _17848.y = _14141.y;
	            _17848.z = _14141.z;
	            _12907 = _17848;
	            break;
	        }
	        case 3u:
	        {
	            float4 _16296 = _12885;
	            _16296.w = _12885.w;
	            _12907 = _16296;
	            break;
	        }
	        case 4u:
	        {
	            _12907 = float4(lerp(1.0f.xxx, _12885.xyz, _12885.w.xxx), 1.0f);
	            break;
	        }
	        case 5u:
	        {
	            _12907 = float4(lerp(1.0f.xxx, _12885.xyz, dot(_12885.xyz, float3(0.2989999949932098388671875f, 0.58700001239776611328125f, 0.114000000059604644775390625f)).xxx), 1.0f);
	            break;
	        }
	        case 6u:
	        {
	            float4 _12954 = _12885;
	            _12954.w = dot(_12885.xyz, float3(0.2989999949932098388671875f, 0.58700001239776611328125f, 0.114000000059604644775390625f));
	            _12907 = _12954;
	            break;
	        }
	        case 7u:
	        {
	            _12907 = float4(lerp(1.0f.xxx, 0.0f.xxx, float(_23505 == 4u).xxx), dot(_12885.xyz, float3(0.2989999949932098388671875f, 0.58700001239776611328125f, 0.114000000059604644775390625f)));
	            break;
	        }
	        case 8u:
	        {
	            _12907 = float4(1.0f, 1.0f, 1.0f, dot(_12885.xyz, float3(0.2989999949932098388671875f, 0.58700001239776611328125f, 0.114000000059604644775390625f)));
	            break;
	        }
	        case 9u:
	        {
	            float4 _22473 = float4(_12885.xxx, 1.0f);
	            float3 _14140 = lerp(_22473.yzw, 0.0f.xxx, float(_23505 == 4u).xxx);
	            float4 _17847 = _22473;
	            _17847.y = _14140.x;
	            _17847.z = _14140.y;
	            _17847.w = _14140.z;
	            _12907 = _17847;
	            break;
	        }
	        case 10u:
	        {
	            float4 _22472 = float4(_12885.yyy, 1.0f);
	            float3 _14139 = lerp(_22472.xzw, 0.0f.xxx, float(_23505 == 4u).xxx);
	            float4 _17846 = _22472;
	            _17846.x = _14139.x;
	            _17846.z = _14139.y;
	            _17846.w = _14139.z;
	            _12907 = _17846;
	            break;
	        }
	        case 11u:
	        {
	            float4 _22471 = float4(_12885.zzz, 1.0f);
	            float3 _14138 = lerp(_22471.xyw, 0.0f.xxx, float(_23505 == 4u).xxx);
	            float4 _17845 = _22471;
	            _17845.x = _14138.x;
	            _17845.y = _14138.y;
	            _17845.w = _14138.z;
	            _12907 = _17845;
	            break;
	        }
	        case 12u:
	        {
	            float4 _22470 = _12885.x.xxxx;
	            float2 _14137 = lerp(_22470.yz, 0.0f.xx, float(_23505 == 4u).xx);
	            float4 _17844 = _22470;
	            _17844.y = _14137.x;
	            _17844.z = _14137.y;
	            _12907 = _17844;
	            break;
	        }
	        case 13u:
	        {
	            float4 _22469 = _12885.y.xxxx;
	            float2 _14136 = lerp(_22469.xz, 0.0f.xx, float(_23505 == 4u).xx);
	            float4 _17843 = _22469;
	            _17843.x = _14136.x;
	            _17843.z = _14136.y;
	            _12907 = _17843;
	            break;
	        }
	        case 14u:
	        {
	            float4 _22468 = _12885.z.xxxx;
	            float2 _14135 = lerp(_22468.xy, 0.0f.xx, float(_23505 == 4u).xx);
	            float4 _17842 = _22468;
	            _17842.x = _14135.x;
	            _17842.y = _14135.y;
	            _12907 = _17842;
	            break;
	        }
	        default:
	        {
	            _12907 = _12885;
	            break;
	        }
	    }
	    float4 _18229;
	    switch (_23505)
	    {
	        case 0u:
	        {
	            _18229 = _12907;
	            break;
	        }
	        case 3u:
	        {
	            _18229 = 1.0f.xxxx + _12907.xyzw;
	            break;
	        }
	        case 4u:
	        {
	            _18229 = 1.0f.xxxx - _12907.xyzw;
	            break;
	        }
	        case 1u:
	        {
	            _18229 = _12907.xyzw * 2.0f.xxxx;
	            break;
	        }
	        case 2u:
	        {
	            _18229 = _12907;
	            break;
	        }
	        case 5u:
	        {
	            _18229 = (1.0f.xxxx + _12907.xyzw) * 0.5f;
	            break;
	        }
	        case 6u:
	        {
	            float3 _17602 = 1.0f.xxx * dot(_12907.xyz, float3(0.2125000059604644775390625f, 0.7153999805450439453125f, 0.07209999859333038330078125f));
	            float4 _8673 = _12907;
	            _8673.x = _17602.x;
	            _8673.y = _17602.y;
	            _8673.z = _17602.z;
	            _18229 = _8673;
	            break;
	        }
	        default:
	        {
	            _18229 = _12907;
	            break;
	        }
	    }
	    float4 _24406 = clamp(lerp(1.0f.xxxx, _18229, _12906.xxxx), 0.0f.xxxx, 1.0f.xxxx);
	    float3 _21122 = _24406.xyz * input_1.xyz;
	    float _12758 = _21122.x;
	    float4 _23714 = _24406;
	    _23714.x = _12758;
	    _23714.y = _21122.y;
	    _23714.z = _21122.z;
	    float _23577 = _24406.w;
	    int _10282 = (_10622 >> 7) & 1;
	    float4 _19631;
	    if (_10282 == 0)
	    {
	        float4 _21710;
	        [branch]
	        if (SpriteCardPixelControls_t_1_m0.w < SpriteCardPixelControls_t_1_m0.z)
	        {
	            _21710 = float4(_12758, _21122.yz, smoothstep(SpriteCardPixelControls_t_1_m0.w, SpriteCardPixelControls_t_1_m0.z, _23577));
	        }
	        else
	        {
	            _21710 = _23714;
	        }
	        bool _12886;
	        if (_23577 >= SpriteCardPixelControls_t_1_m5.x)
	        {
	            _12886 = _23577 <= SpriteCardPixelControls_t_1_m5.w;
	        }
	        else
	        {
	            _12886 = false;
	        }
	        float4 _12503;
	        [branch]
	        if (_12886)
	        {
	            float _21711;
	            if (_23577 <= SpriteCardPixelControls_t_1_m5.z)
	            {
	                _21711 = smoothstep(SpriteCardPixelControls_t_1_m5.x, SpriteCardPixelControls_t_1_m5.z, _23577);
	            }
	            else
	            {
	                _21711 = smoothstep(SpriteCardPixelControls_t_1_m5.w, SpriteCardPixelControls_t_1_m5.y, _23577);
	            }
	            _12503 = lerp(_21710, SpriteCardPixelControls_t_1_m4, _21711.xxxx);
	        }
	        else
	        {
	            _12503 = _21710;
	        }
	        _19631 = _12503;
	    }
	    else
	    {
	        _19631 = _23714;
	    }
	    float3 _7733 = lerp(_19631.xyz, dot(_19631.xyz, float3(0.2125000059604644775390625f, 0.7153999805450439453125f, 0.07209999859333038330078125f)).xxx, SpriteCardPixelControls_t_1_m7.x.xxx);
	    float4 _17849 = _19631;
	    _17849.x = _7733.x;
	    _17849.y = _7733.y;
	    _17849.z = _7733.z;
	    float4 _21103 = SpriteCardPixelControls_t_1_m3.xyzw * _17849.xyzw;
	    float _12384 = _21103.w + SpriteCardPixelControls_t_1_m6.x;
	    float4 _15395 = _21103;
	    _15395.w = _12384;
	    float4 _7078;
	    if (((_10622 >> 8) & 1) != 0)
	    {
	        float4 _18986 = _15395;
	        _18986.w = saturate(_12384);
	        _7078 = _18986;
	    }
	    else
	    {
	        _7078 = _15395;
	    }
	    float4 _19321;
	    if (_10282 == 1)
	    {
	        float _20523 = max(SpriteCardPixelControls_t_1_m5.x, _7078.w);
	        float _15029 = _7078.w - SpriteCardPixelControls_t_1_m0.w;
	        float4 _13727 = _7078;
	        _13727.w = min(saturate(((input_5.z + input_5.w) - _7078.w) / ((_7078.w + SpriteCardPixelControls_t_1_m0.z) - _7078.w)) * _20523, (saturate((input_5.z - _15029) / (_7078.w - _15029)) * (-_20523)) + _20523) * max(SpriteCardPixelControls_t_1_m5.y, input_1.w);
	        _19321 = _13727;
	    }
	    else
	    {
	        float4 _18602 = _7078;
	        _18602.w = _7078.w * input_1.w;
	        _19321 = _18602;
	    }
	    float3 _9057;
	    if (SpriteCardPixelControls_t_1_m2.w == (-1.0f))
	    {
	        float3 _23378 = clamp(input_4.xyz, 0.0f.xxx, 1.0f.xxx);
	        float3 _23904 = clamp(-input_4.xyz, 0.0f.xxx, 1.0f.xxx);
	        _9057 = lerp(((RoughnessLightingGlobalsCB_t_1_m0.xyz * (dot(float3(0.60000002384185791015625f, 0.4000000059604644775390625f, 1.0f), _23378 * _23378) + dot(float3(0.60000002384185791015625f, 0.4000000059604644775390625f, 0.20000000298023223876953125f), _23904 * _23904))).xyz + ((SunLightShaderParamsCB_t_1_m0.xyz * (pow(saturate(dot(input_4.xyz, SunLightShaderParamsCB_t_1_m1.xyz)), 0.60000002384185791015625f) * 0.800000011920928955078125f)) * 1.0f)).xyz, PerViewConstantBuffer_t_1_m2.xyz, saturate(min(PerViewConstantBuffer_t_1_m5, pow(saturate((distance(input_3.xyz, PerViewConstantBuffer_t_1_m1.xyz) * PerViewConstantBuffer_t_1_m4) + PerViewConstantBuffer_t_1_m3), PerViewConstantBuffer_t_1_m6))).xxx);
	    }
	    else
	    {
	        _9057 = input_2;
	    }
	    float _10929 = lerp(_19321.w, saturate(_19321.w * 128.0f), float((_10622 >> 5) & 1));
	    float3 _11507 = _19321.xyz * ((_9057.xyz * SpriteCardPixelControls_t_1_m0.y) + SpriteCardPixelControls_t_1_m0.x.xxx);
	    float4 _23715;
	    _23715.x = _11507.x;
	    _23715.y = _11507.y;
	    _23715.z = _11507.z;
	    float3 _11003 = _23715.xyz * PerViewConstantBuffer_t_1_m0;
	    float4 _8674;
	    _8674.x = _11003.x;
	    _8674.y = _11003.y;
	    _8674.z = _11003.z;
	    output_0 = float4(_8674.xyz * (lerp(_10929, 1.0f, saturate(-SpriteCardPixelControls_t_1_m1.w)) * SpriteCardPixelControls_t_1_m1.z), _10929 * abs(SpriteCardPixelControls_t_1_m1.w));
	}
	
	PS_OUTPUT MainPs(PS_INPUT stage_input)
	{
	    input_0 = stage_input.input_0;
	    input_1 = stage_input.input_1;
	    input_2 = stage_input.input_2;
	    input_3 = stage_input.input_3;
	    input_4 = stage_input.input_4;
	    input_5 = stage_input.input_5;
	    MainPs_inner();
	    PS_OUTPUT stage_output;
	    stage_output.output_0 = output_0;
	    return stage_output;
	}
	
	// ---------  SPIRV -> HLSL end  --------- 
	
	
	
	BoolAttribute(translucent, true);
	
}
