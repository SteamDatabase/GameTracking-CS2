// MGetKV3ClassDefaults = {
//	"m_harmonics":
//	[
//	],
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
//	"m_bSyncInstances": false
//}
class CVoiceContainerStaticAdditiveSynth::CTone
{
	// MPropertyFriendlyName = "Harmonics"
	CUtlVector< CVoiceContainerStaticAdditiveSynth::CHarmonic > m_harmonics;
	// MPropertyFriendlyName = "Envelope"
	CPiecewiseCurve m_curve;
	// MPropertyFriendlyName = "Play All Instances In Sync"
	bool m_bSyncInstances;
};
