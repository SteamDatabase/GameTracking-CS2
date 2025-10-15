// MParticleMinVersion = 8
// MGetKV3ClassDefaults = {
//	"_class": "C_OP_LockToSavedSequentialPathV2",
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
//	"m_flFadeStart": 1.000000,
//	"m_flFadeEnd": 1.000000,
//	"m_bCPPairs": false,
//	"m_PathParams":
//	{
//		"m_nStartControlPointNumber": 0,
//		"m_nEndControlPointNumber": 0,
//		"m_nBulgeControl": 0,
//		"m_flBulge": 0.000000,
//		"m_flMidPoint": 0.500000,
//		"m_vStartPointOffset":
//		[
//			0.000000,
//			0.000000,
//			0.000000
//		],
//		"m_vMidPointOffset":
//		[
//			0.000000,
//			0.000000,
//			0.000000
//		],
//		"m_vEndOffset":
//		[
//			0.000000,
//			0.000000,
//			0.000000
//		]
//	}
//}
class C_OP_LockToSavedSequentialPathV2 : public CParticleFunctionOperator
{
	// MPropertyFriendlyName = "start fade time"
	float32 m_flFadeStart;
	// MPropertyFriendlyName = "end fade time"
	float32 m_flFadeEnd;
	// MPropertyFriendlyName = "Use sequential CP pairs between start and end point"
	bool m_bCPPairs;
	CPathParameters m_PathParams;
};
