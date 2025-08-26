// MGetKV3ClassDefaults = {
//	"_class": "CVoiceContainerDecayingSineWave",
//	"m_vSound":
//	{
//		"m_nRate": <HIDDEN FOR DIFF>,
//		"m_nFormat": <HIDDEN FOR DIFF>,
//		"m_nChannels": <HIDDEN FOR DIFF>,
//		"m_nLoopStart": <HIDDEN FOR DIFF>,
//		"m_nSampleCount": <HIDDEN FOR DIFF>,
//		"m_flDuration": 0.000000,
//		"m_Sentences":
//		[
//		],
//		"m_nStreamingSize": <HIDDEN FOR DIFF>,
//		"m_nSeekTable":
//		[
//		],
//		"m_nLoopEnd": <HIDDEN FOR DIFF>,
//		"m_encodedHeader": "[BINARY BLOB]"
//	},
//	"m_pEnvelopeAnalyzer": null,
//	"m_flFrequency": 0.000000,
//	"m_flDecayTime": 0.000000
//}
// MPropertyFriendlyName = "TESTBED: Decaying Sine Wave Container"
// MPropertyDescription = "Only text params, renders in real time"
class CVoiceContainerDecayingSineWave : public CVoiceContainerBase
{
	// MPropertyFriendlyName = "Frequency (Hz)"
	// MPropertyDescription = "The frequency of this sine tone."
	float32 m_flFrequency;
	// MPropertyFriendlyName = "Decay Time (Seconds)"
	// MPropertyDescription = "The frequency of this sine tone."
	float32 m_flDecayTime;
};
