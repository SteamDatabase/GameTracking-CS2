// MGetKV3ClassDefaults = {
//	"_class": "CVoiceContainerSet",
//	"m_vSound":
//	{
//		"m_nRate": -1986473004,
//		"m_nFormat": 224,
//		"m_nChannels": 2346634960,
//		"m_nLoopStart": 32767,
//		"m_nSampleCount": 2172654616,
//		"m_flDuration": 0.000000,
//		"m_Sentences":
//		[
//		],
//		"m_nStreamingSize": 1888837680,
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
// MPropertyFriendlyName = "Container Set"
// MPropertyDescription = "An array of containers that are played all at once."
class CVoiceContainerSet : public CVoiceContainerBase
{
	// MPropertyFriendlyName = "Container List"
	CUtlVector< CVoiceContainerSetElement > m_soundsToPlay;
};
