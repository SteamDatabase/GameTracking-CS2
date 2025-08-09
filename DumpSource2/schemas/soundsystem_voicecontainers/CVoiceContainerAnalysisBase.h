// MGetKV3ClassDefaults = {
//	"_class": "CVoiceContainerAnalysisBase",
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
//	}
//}
// MVDataNodeType = 1
// MPropertyPolymorphicClass
// MPropertyFriendlyName = "Analysis Container"
// MPropertyDescription = "Does Not Play Sound, member of CVoiceContainerDefaultDefault"
class CVoiceContainerAnalysisBase
{
	// MPropertyFriendlyName = "Regenerate curve on compile"
	bool m_bRegenerateCurveOnCompile;
	// MPropertyFriendlyName = "Envelope Curve"
	CPiecewiseCurve m_curve;
};
