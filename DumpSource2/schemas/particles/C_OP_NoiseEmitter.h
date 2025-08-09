// MGetKV3ClassDefaults = {
//	"_class": "C_OP_NoiseEmitter",
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
//	"m_nEmitterIndex": -1,
//	"m_flEmissionDuration": 0.000000,
//	"m_flStartTime": 0.000000,
//	"m_flEmissionScale": 0.000000,
//	"m_nScaleControlPoint": -1,
//	"m_nScaleControlPointField": 0,
//	"m_nWorldNoisePoint": -1,
//	"m_bAbsVal": false,
//	"m_bAbsValInv": false,
//	"m_flOffset": 0.000000,
//	"m_flOutputMin": 0.000000,
//	"m_flOutputMax": 100.000000,
//	"m_flNoiseScale": 0.100000,
//	"m_flWorldNoiseScale": 0.001000,
//	"m_vecOffsetLoc":
//	[
//		0.000000,
//		0.000000,
//		0.000000
//	],
//	"m_flWorldTimeScale": 0.000000
//}
class C_OP_NoiseEmitter : public CParticleFunctionEmitter
{
	// MPropertyFriendlyName = "emission duration"
	float32 m_flEmissionDuration;
	// MPropertyFriendlyName = "emission start time"
	float32 m_flStartTime;
	// MPropertyFriendlyName = "scale emission to used control points"
	// MParticleMaxVersion = 1
	float32 m_flEmissionScale;
	// MPropertyFriendlyName = "emission count scale control point"
	int32 m_nScaleControlPoint;
	// MPropertyFriendlyName = "emission count scale control point field"
	// MPropertyAttributeChoiceName = "vector_component"
	int32 m_nScaleControlPointField;
	// MPropertyFriendlyName = "world noise scale control point"
	int32 m_nWorldNoisePoint;
	// MPropertyFriendlyName = "absolute value"
	bool m_bAbsVal;
	// MPropertyFriendlyName = "invert absolute value"
	bool m_bAbsValInv;
	// MPropertyFriendlyName = "time coordinate offset"
	float32 m_flOffset;
	// MPropertyFriendlyName = "emission minimum"
	float32 m_flOutputMin;
	// MPropertyFriendlyName = "emission maximum"
	float32 m_flOutputMax;
	// MPropertyFriendlyName = "time noise coordinate scale"
	float32 m_flNoiseScale;
	// MPropertyFriendlyName = "world spatial noise coordinate scale"
	float32 m_flWorldNoiseScale;
	// MPropertyFriendlyName = "spatial coordinate offset"
	// MVectorIsCoordinate
	Vector m_vecOffsetLoc;
	// MPropertyFriendlyName = "world time noise coordinate scale"
	float32 m_flWorldTimeScale;
};
