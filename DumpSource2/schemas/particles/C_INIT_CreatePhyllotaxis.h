// MGetKV3ClassDefaults = {
//	"_class": "C_INIT_CreatePhyllotaxis",
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
//	"m_nControlPointNumber": 0,
//	"m_nScaleCP": -1,
//	"m_nComponent": 0,
//	"m_fRadCentCore": 0.000000,
//	"m_fRadPerPoint": 1.000000,
//	"m_fRadPerPointTo": -1.000000,
//	"m_fpointAngle": 137.507996,
//	"m_fsizeOverall": 60.000000,
//	"m_fRadBias": 0.500000,
//	"m_fMinRad": 0.250000,
//	"m_fDistBias": 0.500000,
//	"m_bUseLocalCoords": false,
//	"m_bUseWithContEmit": false,
//	"m_bUseOrigRadius": true
//}
class C_INIT_CreatePhyllotaxis : public CParticleFunctionInitializer
{
	// MPropertyFriendlyName = "control point number"
	int32 m_nControlPointNumber;
	// MPropertyFriendlyName = "scale size multiplier from CP"
	int32 m_nScaleCP;
	// MPropertyFriendlyName = "scale CP component 0/1/2 X/Y/Z"
	// MPropertyAttributeChoiceName = "vector_component"
	int32 m_nComponent;
	// MPropertyFriendlyName = "center core radius"
	float32 m_fRadCentCore;
	// MPropertyFriendlyName = "radius multiplier"
	float32 m_fRadPerPoint;
	// MPropertyFriendlyName = "radius max (-1 procedural growth)"
	float32 m_fRadPerPointTo;
	// MPropertyFriendlyName = "golden angle (is 137.508)"
	float32 m_fpointAngle;
	// MPropertyFriendlyName = "overall size multiplier (-1 count based distribution)"
	float32 m_fsizeOverall;
	// MPropertyFriendlyName = "radius bias"
	float32 m_fRadBias;
	// MPropertyFriendlyName = "radius min "
	float32 m_fMinRad;
	// MPropertyFriendlyName = "distribution bias"
	float32 m_fDistBias;
	// MPropertyFriendlyName = "local space"
	bool m_bUseLocalCoords;
	// MPropertyFriendlyName = "use continuous emission"
	bool m_bUseWithContEmit;
	// MPropertyFriendlyName = "scale radius from initial value"
	bool m_bUseOrigRadius;
};
