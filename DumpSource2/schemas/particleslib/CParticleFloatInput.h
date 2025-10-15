// MGetKV3ClassDefaults = {
//	"m_nType": "PF_TYPE_LITERAL",
//	"m_nMapType": "PF_MAP_TYPE_DIRECT",
//	"m_flLiteralValue": 0.000000,
//	"m_NamedValue": "",
//	"m_nControlPoint": 0,
//	"m_nScalarAttribute": 3,
//	"m_nVectorAttribute": 6,
//	"m_nVectorComponent": 0,
//	"m_bReverseOrder": false,
//	"m_flRandomMin": 0.000000,
//	"m_flRandomMax": 1.000000,
//	"m_bHasRandomSignFlip": false,
//	"m_nRandomSeed": -1,
//	"m_nRandomMode": "PF_RANDOM_MODE_CONSTANT",
//	"m_strSnapshotSubset": "",
//	"m_flLOD0": 0.000000,
//	"m_flLOD1": 0.000000,
//	"m_flLOD2": 0.000000,
//	"m_flLOD3": 0.000000,
//	"m_nNoiseInputVectorAttribute": 0,
//	"m_flNoiseOutputMin": 0.000000,
//	"m_flNoiseOutputMax": 1.000000,
//	"m_flNoiseScale": 0.100000,
//	"m_vecNoiseOffsetRate":
//	[
//		0.000000,
//		0.000000,
//		0.000000
//	],
//	"m_flNoiseOffset": 0.000000,
//	"m_nNoiseOctaves": 1,
//	"m_nNoiseTurbulence": "PF_NOISE_TURB_NONE",
//	"m_nNoiseType": "PF_NOISE_TYPE_PERLIN",
//	"m_nNoiseModifier": "PF_NOISE_MODIFIER_NONE",
//	"m_flNoiseTurbulenceScale": 1.000000,
//	"m_flNoiseTurbulenceMix": 0.500000,
//	"m_flNoiseImgPreviewScale": 1.000000,
//	"m_bNoiseImgPreviewLive": true,
//	"m_flNoCameraFallback": 0.000000,
//	"m_bUseBoundsCenter": false,
//	"m_nInputMode": "PF_INPUT_MODE_CLAMPED",
//	"m_flMultFactor": 1.000000,
//	"m_flInput0": 0.000000,
//	"m_flInput1": 1.000000,
//	"m_flOutput0": 0.000000,
//	"m_flOutput1": 1.000000,
//	"m_flNotchedRangeMin": 0.000000,
//	"m_flNotchedRangeMax": 1.000000,
//	"m_flNotchedOutputOutside": 0.000000,
//	"m_flNotchedOutputInside": 1.000000,
//	"m_nRoundType": "PF_ROUND_TYPE_NEAREST",
//	"m_nBiasType": "PF_BIAS_TYPE_STANDARD",
//	"m_flBiasParameter": 0.000000,
//	"m_Curve":
//	{
//		"m_spline":
//		[
//		],
//		"m_tangents":
//		[
//		],
//		"m_vDomainMins":
//		[
//			0.000000,
//			0.000000
//		],
//		"m_vDomainMaxs":
//		[
//			0.000000,
//			0.000000
//		]
//	}
//}
// MCustomFGDMetadata = "{ SkipImprintFGDClassOnKV3 = true SkipRemoveKeysInKV3AtFGDDefault = true KV3DefaultTestFnName = 'CParticleFloatInputDefaultTestFunc' }"
class CParticleFloatInput : public CParticleInput
{
	ParticleFloatType_t m_nType;
	ParticleFloatMapType_t m_nMapType;
	float32 m_flLiteralValue;
	CParticleNamedValueRef m_NamedValue;
	int32 m_nControlPoint;
	ParticleAttributeIndex_t m_nScalarAttribute;
	ParticleAttributeIndex_t m_nVectorAttribute;
	int32 m_nVectorComponent;
	bool m_bReverseOrder;
	float32 m_flRandomMin;
	float32 m_flRandomMax;
	bool m_bHasRandomSignFlip;
	int32 m_nRandomSeed;
	ParticleFloatRandomMode_t m_nRandomMode;
	CUtlString m_strSnapshotSubset;
	float32 m_flLOD0;
	float32 m_flLOD1;
	float32 m_flLOD2;
	float32 m_flLOD3;
	ParticleAttributeIndex_t m_nNoiseInputVectorAttribute;
	float32 m_flNoiseOutputMin;
	float32 m_flNoiseOutputMax;
	float32 m_flNoiseScale;
	Vector m_vecNoiseOffsetRate;
	float32 m_flNoiseOffset;
	int32 m_nNoiseOctaves;
	PFNoiseTurbulence_t m_nNoiseTurbulence;
	PFNoiseType_t m_nNoiseType;
	PFNoiseModifier_t m_nNoiseModifier;
	float32 m_flNoiseTurbulenceScale;
	float32 m_flNoiseTurbulenceMix;
	float32 m_flNoiseImgPreviewScale;
	bool m_bNoiseImgPreviewLive;
	float32 m_flNoCameraFallback;
	bool m_bUseBoundsCenter;
	ParticleFloatInputMode_t m_nInputMode;
	float32 m_flMultFactor;
	float32 m_flInput0;
	float32 m_flInput1;
	float32 m_flOutput0;
	float32 m_flOutput1;
	float32 m_flNotchedRangeMin;
	float32 m_flNotchedRangeMax;
	float32 m_flNotchedOutputOutside;
	float32 m_flNotchedOutputInside;
	ParticleFloatRoundType_t m_nRoundType;
	ParticleFloatBiasType_t m_nBiasType;
	float32 m_flBiasParameter;
	CPiecewiseCurve m_Curve;
};
