// MGetKV3ClassDefaults = {
//	"_class": "CVoiceContainerSet",
//	"m_vSound":
//	{
//		"m_nRate": -1122446380,
//		"m_nFormat": 208,
//		"m_nChannels": 894094080,
//		"m_nLoopStart": 32767,
//		"m_nSampleCount": 959136776,
//		"m_flDuration": 0.000000,
//		"m_Sentences":
//		[
//		],
//		"m_nStreamingSize": 3018166440,
//		"m_nSeekTable":
//		[
//		],
//		"m_nLoopEnd": 894095752,
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
