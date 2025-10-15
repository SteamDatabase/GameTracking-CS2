// MGetKV3ClassDefaults = {
//	"_class": "C_INIT_StatusEffectCitadel",
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
//	"m_flSFXColorWarpAmount": 0.000000,
//	"m_flSFXNormalAmount": 0.000000,
//	"m_flSFXMetalnessAmount": 0.000000,
//	"m_flSFXRoughnessAmount": 0.000000,
//	"m_flSFXSelfIllumAmount": 0.000000,
//	"m_flSFXSScale": 1.000000,
//	"m_flSFXSScrollX": 0.000000,
//	"m_flSFXSScrollY": 0.000000,
//	"m_flSFXSScrollZ": 0.000000,
//	"m_flSFXSOffsetX": 0.000000,
//	"m_flSFXSOffsetY": 0.000000,
//	"m_flSFXSOffsetZ": 0.000000,
//	"m_nDetailCombo": "DETAIL_COMBO_OFF",
//	"m_flSFXSDetailAmount": 0.000000,
//	"m_flSFXSDetailScale": 1.000000,
//	"m_flSFXSDetailScrollX": 0.000000,
//	"m_flSFXSDetailScrollY": 0.000000,
//	"m_flSFXSDetailScrollZ": 0.000000,
//	"m_flSFXSUseModelUVs": 0.000000
//}
class C_INIT_StatusEffectCitadel : public CParticleFunctionInitializer
{
	// MPropertyFriendlyName = "$SFXColorWarpAmount"
	float32 m_flSFXColorWarpAmount;
	// MPropertyFriendlyName = "$SFXNormalAmount"
	float32 m_flSFXNormalAmount;
	// MPropertyFriendlyName = "$SFXMetalnessAmount"
	float32 m_flSFXMetalnessAmount;
	// MPropertyFriendlyName = "$SFXRoughnessAmount"
	float32 m_flSFXRoughnessAmount;
	// MPropertyFriendlyName = "$SFXSelfIllumAmount"
	float32 m_flSFXSelfIllumAmount;
	// MPropertyFriendlyName = "$SFXTextureScale"
	float32 m_flSFXSScale;
	// MPropertyFriendlyName = "$SFXTextureScrollX"
	float32 m_flSFXSScrollX;
	// MPropertyFriendlyName = "$SFXTextureScrollY"
	float32 m_flSFXSScrollY;
	// MPropertyFriendlyName = "$SFXTextureScrollZ"
	float32 m_flSFXSScrollZ;
	// MPropertyFriendlyName = "$SFXTextureOffsetX"
	float32 m_flSFXSOffsetX;
	// MPropertyFriendlyName = "$SFXTextureOffsetY"
	float32 m_flSFXSOffsetY;
	// MPropertyFriendlyName = "$SFXTextureOffsetZ"
	float32 m_flSFXSOffsetZ;
	// MPropertyFriendlyName = "D_DETAIL"
	DetailCombo_t m_nDetailCombo;
	// MPropertyFriendlyName = "$SFXDetailAmount"
	float32 m_flSFXSDetailAmount;
	// MPropertyFriendlyName = "$SFXDetailTextureScale"
	float32 m_flSFXSDetailScale;
	// MPropertyFriendlyName = "$SFXDetailTextureScrollX"
	float32 m_flSFXSDetailScrollX;
	// MPropertyFriendlyName = "$SFXDetailTextureScrollY"
	float32 m_flSFXSDetailScrollY;
	// MPropertyFriendlyName = "$SFXDetailTextureScrollZ"
	float32 m_flSFXSDetailScrollZ;
	// MPropertyFriendlyName = "$SFXUseModelUVs"
	float32 m_flSFXSUseModelUVs;
};
