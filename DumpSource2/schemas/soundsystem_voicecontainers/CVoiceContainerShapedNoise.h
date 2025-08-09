// MGetKV3ClassDefaults = {
//	"_class": "CVoiceContainerShapedNoise",
//	"m_vSound":
//	{
//		"m_nRate": 0,
//		"m_nFormat": "PCM16",
//		"m_nChannels": 0,
//		"m_nLoopStart": 0,
//		"m_nSampleCount": 0,
//		"m_flDuration": 0.000000,
//		"m_Sentences":
//		[
//		],
//		"m_nStreamingSize": 0,
//		"m_nSeekTable":
//		[
//		],
//		"m_nLoopEnd": 0,
//		"m_encodedHeader": "[BINARY BLOB]"
//	},
//	"m_pEnvelopeAnalyzer": null,
//	"m_bUseCurveForFrequency": false,
//	"m_flFrequency": 440.000000,
//	"m_frequencySweep":
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
//	},
//	"m_bUseCurveForResonance": false,
//	"m_flResonance": 4.000000,
//	"m_resonanceSweep":
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
//	},
//	"m_bUseCurveForAmplitude": false,
//	"m_flGainInDecibels": 1.000000,
//	"m_gainSweep":
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
// MPropertyFriendlyName = "Wind Generator Container"
// MPropertyDescription = "This is a synth meant to generate whoosh noises."
class CVoiceContainerShapedNoise : public CVoiceContainerBase
{
	bool m_bUseCurveForFrequency;
	// MPropertySuppressExpr = "m_bUseCurveForFrequency == 1"
	float32 m_flFrequency;
	// MPropertySuppressExpr = "m_bUseCurveForFrequency == 0"
	// MPropertyFriendlyName = "Frequency Sweep"
	CPiecewiseCurve m_frequencySweep;
	bool m_bUseCurveForResonance;
	// MPropertySuppressExpr = "m_bUseCurveForResonance == 1"
	float32 m_flResonance;
	// MPropertySuppressExpr = "m_bUseCurveForResonance == 0"
	// MPropertyFriendlyName = "Resonance Sweep"
	CPiecewiseCurve m_resonanceSweep;
	bool m_bUseCurveForAmplitude;
	// MPropertySuppressExpr = "m_bUseCurveForAmplitude == 1"
	float32 m_flGainInDecibels;
	// MPropertySuppressExpr = "m_bUseCurveForAmplitude == 0"
	// MPropertyFriendlyName = "Gain Sweep (in Decibels)"
	CPiecewiseCurve m_gainSweep;
};
