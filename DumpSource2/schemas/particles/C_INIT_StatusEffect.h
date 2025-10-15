// MGetKV3ClassDefaults = {
//	"_class": "C_INIT_StatusEffect",
//	"m_flOpStrength":
//	{
//		"m_nType": "PF_TYPE_LITERAL",
//		"m_nMapType": "PF_MAP_TYPE_DIRECT",
//		"m_flLiteralValue": 1.000000,
//		"m_NamedValue": "",
//		"m_nControlPoint": 0,
//		"m_nScalarAttribute": 3,
//		"m_nVectorAttribute": 6,
//		"m_nVectorComponent": 0,
//		"m_bReverseOrder": false,
//		"m_flRandomMin": 0.000000,
//		"m_flRandomMax": 1.000000,
//		"m_bHasRandomSignFlip": false,
//		"m_nRandomSeed": -1,
//		"m_nRandomMode": "PF_RANDOM_MODE_CONSTANT",
//		"m_strSnapshotSubset": "",
//		"m_flLOD0": 0.000000,
//		"m_flLOD1": 0.000000,
//		"m_flLOD2": 0.000000,
//		"m_flLOD3": 0.000000,
//		"m_nNoiseInputVectorAttribute": 0,
//		"m_flNoiseOutputMin": 0.000000,
//		"m_flNoiseOutputMax": 1.000000,
//		"m_flNoiseScale": 0.100000,
//		"m_vecNoiseOffsetRate":
//		[
//			0.000000,
//			0.000000,
//			0.000000
//		],
//		"m_flNoiseOffset": 0.000000,
//		"m_nNoiseOctaves": 1,
//		"m_nNoiseTurbulence": "PF_NOISE_TURB_NONE",
//		"m_nNoiseType": "PF_NOISE_TYPE_PERLIN",
//		"m_nNoiseModifier": "PF_NOISE_MODIFIER_NONE",
//		"m_flNoiseTurbulenceScale": 1.000000,
//		"m_flNoiseTurbulenceMix": 0.500000,
//		"m_flNoiseImgPreviewScale": 1.000000,
//		"m_bNoiseImgPreviewLive": true,
//		"m_flNoCameraFallback": 0.000000,
//		"m_bUseBoundsCenter": false,
//		"m_nInputMode": "PF_INPUT_MODE_CLAMPED",
//		"m_flMultFactor": 1.000000,
//		"m_flInput0": 0.000000,
//		"m_flInput1": 1.000000,
//		"m_flOutput0": 0.000000,
//		"m_flOutput1": 1.000000,
//		"m_flNotchedRangeMin": 0.000000,
//		"m_flNotchedRangeMax": 1.000000,
//		"m_flNotchedOutputOutside": 0.000000,
//		"m_flNotchedOutputInside": 1.000000,
//		"m_nRoundType": "PF_ROUND_TYPE_NEAREST",
//		"m_nBiasType": "PF_BIAS_TYPE_STANDARD",
//		"m_flBiasParameter": 0.000000,
//		"m_Curve":
//		{
//			"m_spline":
//			[
//			],
//			"m_tangents":
//			[
//			],
//			"m_vDomainMins":
//			[
//				0.000000,
//				0.000000
//			],
//			"m_vDomainMaxs":
//			[
//				0.000000,
//				0.000000
//			]
//		}
//	},
//	"m_nOpEndCapState": "PARTICLE_ENDCAP_ALWAYS_ON",
//	"m_flOpStartFadeInTime": 0.000000,
//	"m_flOpEndFadeInTime": 0.000000,
//	"m_flOpStartFadeOutTime": 0.000000,
//	"m_flOpEndFadeOutTime": 0.000000,
//	"m_flOpFadeOscillatePeriod": 0.000000,
//	"m_bNormalizeToStopTime": false,
//	"m_flOpTimeOffsetMin": 0.000000,
//	"m_flOpTimeOffsetMax": 0.000000,
//	"m_nOpTimeOffsetSeed": 0,
//	"m_nOpTimeScaleSeed": 0,
//	"m_flOpTimeScaleMin": 1.000000,
//	"m_flOpTimeScaleMax": 1.000000,
//	"m_bDisableOperator": false,
//	"m_Notes": "",
//	"m_nAssociatedEmitterIndex": -1,
//	"m_nDetail2Combo": "DETAIL_2_COMBO_UNINITIALIZED",
//	"m_flDetail2Rotation": -1.000000,
//	"m_flDetail2Scale": -1.000000,
//	"m_flDetail2BlendFactor": -1.000000,
//	"m_flColorWarpIntensity": -1.000000,
//	"m_flDiffuseWarpBlendToFull": -1.000000,
//	"m_flEnvMapIntensity": -1.000000,
//	"m_flAmbientScale": -1.000000,
//	"m_specularColor":
//	[
//		0,
//		0,
//		0
//	],
//	"m_flSpecularScale": -1.000000,
//	"m_flSpecularExponent": -1.000000,
//	"m_flSpecularExponentBlendToFull": -1.000000,
//	"m_flSpecularBlendToFull": -1.000000,
//	"m_rimLightColor":
//	[
//		0,
//		0,
//		0
//	],
//	"m_flRimLightScale": -1.000000,
//	"m_flReflectionsTintByBaseBlendToNone": -1.000000,
//	"m_flMetalnessBlendToFull": -1.000000,
//	"m_flSelfIllumBlendToFull": -1.000000
//}
class C_INIT_StatusEffect : public CParticleFunctionInitializer
{
	// MPropertyFriendlyName = "D_DETAIL_2"
	Detail2Combo_t m_nDetail2Combo;
	// MPropertyFriendlyName = "$DETAIL2ROTATION"
	float32 m_flDetail2Rotation;
	// MPropertyFriendlyName = "$DETAIL2SCALE"
	float32 m_flDetail2Scale;
	// MPropertyFriendlyName = "$DETAIL2BLENDFACTOR"
	float32 m_flDetail2BlendFactor;
	// MPropertyFriendlyName = "$COLORWARPINTENSITY"
	float32 m_flColorWarpIntensity;
	// MPropertyFriendlyName = "$DIFFUSEWARPBLENDTOFULL"
	float32 m_flDiffuseWarpBlendToFull;
	// MPropertyFriendlyName = "$ENVMAPINTENSITY"
	float32 m_flEnvMapIntensity;
	// MPropertyFriendlyName = "$AMBIENTSCALE"
	float32 m_flAmbientScale;
	// MPropertyFriendlyName = "$SPECULARCOLOR"
	Color m_specularColor;
	// MPropertyFriendlyName = "$SPECULARSCALE"
	float32 m_flSpecularScale;
	// MPropertyFriendlyName = "$SPECULAREXPONENT"
	float32 m_flSpecularExponent;
	// MPropertyFriendlyName = "$SPECULAREXPONENTBLENDTOFULL"
	float32 m_flSpecularExponentBlendToFull;
	// MPropertyFriendlyName = "$SPECULARBLENDTOFULL"
	float32 m_flSpecularBlendToFull;
	// MPropertyFriendlyName = "$RIMLIGHTCOLOR"
	Color m_rimLightColor;
	// MPropertyFriendlyName = "$RIMLIGHTSCALE"
	float32 m_flRimLightScale;
	// MPropertyFriendlyName = "$REFLECTIONSTINTBYBASEBLENDTONONE"
	float32 m_flReflectionsTintByBaseBlendToNone;
	// MPropertyFriendlyName = "$METALNESSBLENDTOFULL"
	float32 m_flMetalnessBlendToFull;
	// MPropertyFriendlyName = "$SELFILLUMBLENDTOFULL"
	float32 m_flSelfIllumBlendToFull;
};
