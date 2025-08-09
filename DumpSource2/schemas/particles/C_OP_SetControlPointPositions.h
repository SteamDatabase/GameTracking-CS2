// MGetKV3ClassDefaults = {
//	"_class": "C_OP_SetControlPointPositions",
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
//		"m_flRandomMin": 0.000000,
//		"m_flRandomMax": 1.000000,
//		"m_bHasRandomSignFlip": false,
//		"m_nRandomSeed": -1,
//		"m_nRandomMode": "PF_RANDOM_MODE_CONSTANT",
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
//	"m_bRunOnce": false,
//	"m_bUseWorldLocation": false,
//	"m_bOrient": false,
//	"m_bSetOnce": false,
//	"m_nCP1": 1,
//	"m_nCP2": 2,
//	"m_nCP3": 3,
//	"m_nCP4": 4,
//	"m_vecCP1Pos":
//	[
//		128.000000,
//		0.000000,
//		0.000000
//	],
//	"m_vecCP2Pos":
//	[
//		0.000000,
//		128.000000,
//		0.000000
//	],
//	"m_vecCP3Pos":
//	[
//		-128.000000,
//		0.000000,
//		0.000000
//	],
//	"m_vecCP4Pos":
//	[
//		0.000000,
//		-128.000000,
//		0.000000
//	],
//	"m_nHeadLocation": 0
//}
class C_OP_SetControlPointPositions : public CParticleFunctionPreEmission
{
	// MPropertyFriendlyName = "set positions in world space"
	bool m_bUseWorldLocation;
	// MPropertyFriendlyName = "inherit CP orientation"
	bool m_bOrient;
	// MPropertyFriendlyName = "only set position once"
	bool m_bSetOnce;
	// MPropertyFriendlyName = "first control point number"
	int32 m_nCP1;
	// MPropertyFriendlyName = "second control point number"
	int32 m_nCP2;
	// MPropertyFriendlyName = "third control point number"
	int32 m_nCP3;
	// MPropertyFriendlyName = "fourth control point number"
	int32 m_nCP4;
	// MPropertyFriendlyName = "first control point location"
	// MVectorIsCoordinate
	Vector m_vecCP1Pos;
	// MPropertyFriendlyName = "second control point location"
	// MVectorIsCoordinate
	Vector m_vecCP2Pos;
	// MPropertyFriendlyName = "third control point location"
	// MVectorIsCoordinate
	Vector m_vecCP3Pos;
	// MPropertyFriendlyName = "fourth control point location"
	// MVectorIsCoordinate
	Vector m_vecCP4Pos;
	// MPropertyFriendlyName = "control point to offset positions from"
	int32 m_nHeadLocation;
};
