// MGetKV3ClassDefaults = {
//	"_class": "C_OP_RenderAsModels",
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
//	"VisibilityInputs":
//	{
//		"m_flCameraBias": 0.000000,
//		"m_nCPin": -1,
//		"m_flProxyRadius": 1.000000,
//		"m_flInputMin": 0.000000,
//		"m_flInputMax": 1.000000,
//		"m_flInputPixelVisFade": 0.250000,
//		"m_flNoPixelVisibilityFallback": 1.000000,
//		"m_flDistanceInputMin": 0.000000,
//		"m_flDistanceInputMax": 0.000000,
//		"m_flDotInputMin": 0.000000,
//		"m_flDotInputMax": 0.000000,
//		"m_bDotCPAngles": true,
//		"m_bDotCameraAngles": false,
//		"m_flAlphaScaleMin": 0.000000,
//		"m_flAlphaScaleMax": 1.000000,
//		"m_flRadiusScaleMin": 1.000000,
//		"m_flRadiusScaleMax": 1.000000,
//		"m_flRadiusScaleFOVBase": 0.000000,
//		"m_bRightEye": false
//	},
//	"m_bCannotBeRefracted": true,
//	"m_bSkipRenderingOnMobile": false,
//	"m_ModelList":
//	[
//	],
//	"m_flModelScale": 1.000000,
//	"m_bFitToModelSize": true,
//	"m_bNonUniformScaling": false,
//	"m_nXAxisScalingAttribute": 18,
//	"m_nYAxisScalingAttribute": 18,
//	"m_nZAxisScalingAttribute": 18,
//	"m_nSizeCullBloat": 0
//}
class C_OP_RenderAsModels : public CParticleFunctionRenderer
{
	// MPropertyFriendlyName = "models"
	// MParticleRequireDefaultArrayEntry
	CUtlVector< ModelReference_t > m_ModelList;
	// MPropertyFriendlyName = "scale factor for radius"
	float32 m_flModelScale;
	// MPropertyFriendlyName = "scale model to match particle size"
	bool m_bFitToModelSize;
	// MPropertyFriendlyName = "non-uniform scaling"
	bool m_bNonUniformScaling;
	// MPropertyFriendlyName = "X axis scaling scalar field"
	// MPropertyAttributeChoiceName = "particlefield_scalar"
	ParticleAttributeIndex_t m_nXAxisScalingAttribute;
	// MPropertyFriendlyName = "Y axis scaling scalar field"
	// MPropertyAttributeChoiceName = "particlefield_scalar"
	ParticleAttributeIndex_t m_nYAxisScalingAttribute;
	// MPropertyFriendlyName = "Z axis scaling scalar field"
	// MPropertyAttributeChoiceName = "particlefield_scalar"
	ParticleAttributeIndex_t m_nZAxisScalingAttribute;
	// MPropertyFriendlyName = "model size cull bloat"
	// MPropertyAttributeChoiceName = "particlefield_size_cull_bloat"
	int32 m_nSizeCullBloat;
};
