// MGetKV3ClassDefaults = {
//	"_class": "CVoiceContainerEnvelopeAnalyzer",
//	"m_bRegenerateCurveOnCompile": false,
//	"m_curve":
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
//	"m_mode": "Peak",
//	"m_fAnalysisWindowMs": 200.000000,
//	"m_flThreshold": 0.000000
//}
// MPropertyFriendlyName = "Envelope Analyzer"
// MPropertyDescription = "Generates an Envelope Curve on compile"
class CVoiceContainerEnvelopeAnalyzer : public CVoiceContainerAnalysisBase
{
	// MPropertyFriendlyName = "Envelope Mode"
	EMode_t m_mode;
	// MPropertyFriendlyName = "Analysis Window"
	float32 m_fAnalysisWindowMs;
	// MPropertyFriendlyName = "Threshold"
	float32 m_flThreshold;
};
