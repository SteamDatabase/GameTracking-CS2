// MGetKV3ClassDefaults = {
//	"_class": "C_OP_RenderTreeShake",
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
//	"m_flPeakStrength": 9.000000,
//	"m_nPeakStrengthFieldOverride": 19,
//	"m_flRadius": 256.000000,
//	"m_nRadiusFieldOverride": 19,
//	"m_flShakeDuration": 3.000000,
//	"m_flTransitionTime": 0.500000,
//	"m_flTwistAmount": 0.000000,
//	"m_flRadialAmount": 1.000000,
//	"m_flControlPointOrientationAmount": 0.000000,
//	"m_nControlPointForLinearDirection": -1
//}
class C_OP_RenderTreeShake : public CParticleFunctionRenderer
{
	// MPropertyFriendlyName = "peak strength"
	float32 m_flPeakStrength;
	// MPropertyFriendlyName = "peak strength field override"
	// MPropertyAttributeChoiceName = "particlefield_scalar"
	ParticleAttributeIndex_t m_nPeakStrengthFieldOverride;
	// MPropertyFriendlyName = "radius"
	float32 m_flRadius;
	// MPropertyFriendlyName = "strength field override"
	// MPropertyAttributeChoiceName = "particlefield_scalar"
	ParticleAttributeIndex_t m_nRadiusFieldOverride;
	// MPropertyFriendlyName = "shake duration after end"
	float32 m_flShakeDuration;
	// MPropertyFriendlyName = "amount of time taken to smooth between different shake parameters"
	float32 m_flTransitionTime;
	// MPropertyFriendlyName = "Twist amount (-1..1)"
	float32 m_flTwistAmount;
	// MPropertyFriendlyName = "Radial Amount (-1..1)"
	float32 m_flRadialAmount;
	// MPropertyFriendlyName = "Control Point Orientation Amount (-1..1)"
	float32 m_flControlPointOrientationAmount;
	// MPropertyFriendlyName = "Control Point for Orientation Amount"
	int32 m_nControlPointForLinearDirection;
};
