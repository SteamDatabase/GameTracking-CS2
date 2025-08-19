// MGetKV3ClassDefaults = {
//	"_class": "CVoiceContainerEnvelope",
//	"m_vSound":
//	{
//		"m_nRate": -1122446380,
//		"m_nFormat": 208,
//		"m_nChannels": 894093792,
//		"m_nLoopStart": 32767,
//		"m_nSampleCount": 959025352,
//		"m_flDuration": 0.000000,
//		"m_Sentences":
//		[
//		],
//		"m_nStreamingSize": 56,
//		"m_nSeekTable":
//		[
//		],
//		"m_nLoopEnd": 894095752,
//		"m_encodedHeader": "[BINARY BLOB]"
//	},
//	"m_pEnvelopeAnalyzer": null,
//	"m_sound": "",
//	"m_analysisContainer": null
//}
// MPropertyFriendlyName = "Envelope VSND"
// MPropertyDescription = "Plays sound with envelope."
class CVoiceContainerEnvelope : public CVoiceContainerBase
{
	// MPropertyFriendlyName = "Vsnd File"
	CStrongHandle< InfoForResourceTypeCVoiceContainerBase > m_sound;
	// MPropertyFriendlyName = "Container Analyzers"
	CVoiceContainerAnalysisBase* m_analysisContainer;
};
