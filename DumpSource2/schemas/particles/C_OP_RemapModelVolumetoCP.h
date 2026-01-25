// MGetKV3ClassDefaults = {
//	"_class": "C_OP_RemapModelVolumetoCP",
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
//	"m_bRunOnce": false,
//	"m_nBBoxType": "BBOX_VOLUME",
//	"m_nInControlPointNumber": 0,
//	"m_nOutControlPointNumber": -1,
//	"m_nOutControlPointMaxNumber": -1,
//	"m_nField": 0,
//	"m_flInputMin": 0.000000,
//	"m_flInputMax": 128.000000,
//	"m_flOutputMin": 0.000000,
//	"m_flOutputMax": 1.000000,
//	"m_bBBoxOnly": true,
//	"m_bCubeRoot": true
//}
class C_OP_RemapModelVolumetoCP : public CParticleFunctionPreEmission
{
	// MPropertyFriendlyName = "output BBox Type"
	BBoxVolumeType_t m_nBBoxType;
	// MPropertyFriendlyName = "input control point"
	int32 m_nInControlPointNumber;
	// MPropertyFriendlyName = "output control point"
	int32 m_nOutControlPointNumber;
	// MPropertyFriendlyName = "output max control point"
	// MPropertySuppressExpr = "m_nBBoxType != BBOX_MINS_MAXS"
	int32 m_nOutControlPointMaxNumber;
	// MPropertyFriendlyName = "output CP component"
	// MPropertyAttributeChoiceName = "vector_component"
	// MPropertySuppressExpr = "m_nBBoxType != BBOX_VOLUME && m_nBBoxType != BBOX_RADIUS"
	int32 m_nField;
	// MPropertyFriendlyName = "input volume minimum"
	// MPropertySuppressExpr = "m_nBBoxType != BBOX_VOLUME && m_nBBoxType != BBOX_RADIUS"
	float32 m_flInputMin;
	// MPropertyFriendlyName = "input volume maximum"
	// MPropertySuppressExpr = "m_nBBoxType != BBOX_VOLUME && m_nBBoxType != BBOX_RADIUS"
	float32 m_flInputMax;
	// MPropertyFriendlyName = "output minimum"
	// MPropertySuppressExpr = "m_nBBoxType != BBOX_VOLUME && m_nBBoxType != BBOX_RADIUS"
	float32 m_flOutputMin;
	// MPropertyFriendlyName = "output maximum"
	// MPropertySuppressExpr = "m_nBBoxType != BBOX_VOLUME && m_nBBoxType != BBOX_RADIUS"
	float32 m_flOutputMax;
	// MPropertyFriendlyName = "check full bbox only"
	// MPropertySuppressExpr = "m_nBBoxType != BBOX_VOLUME"
	bool m_bBBoxOnly;
	// MPropertyFriendlyName = "cube root of volume"
	// MPropertySuppressExpr = "m_nBBoxType != BBOX_VOLUME"
	bool m_bCubeRoot;
};
