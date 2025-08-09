// MGetKV3ClassDefaults = {
//	"_class": "CVoiceContainerSwitch",
//	"m_vSound":
//	{
//		"m_nRate": -1986473004,
//		"m_nFormat": 224,
//		"m_nChannels": 0,
//		"m_nLoopStart": 0,
//		"m_nSampleCount": 2172613080,
//		"m_flDuration": 0.000000,
//		"m_Sentences":
//		[
//		],
//		"m_nStreamingSize": 2346635087,
//		"m_nSeekTable":
//		[
//		],
//		"m_nLoopEnd": -1948330344,
//		"m_encodedHeader": "[BINARY BLOB]"
//	},
//	"m_pEnvelopeAnalyzer": null,
//	"m_soundsToPlay":
//	[
//	]
//}
// MPropertyFriendlyName = "Container Switch"
// MPropertyDescription = "An array of containers"
class CVoiceContainerSwitch : public CVoiceContainerBase
{
	// MPropertyFriendlyName = "Container List"
	CUtlVector< CSoundContainerReference > m_soundsToPlay;
};
