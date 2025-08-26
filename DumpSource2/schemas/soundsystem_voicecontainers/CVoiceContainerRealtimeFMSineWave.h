// MGetKV3ClassDefaults = {
//	"_class": "CVoiceContainerRealtimeFMSineWave",
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
//	"m_flCarrierFrequency": 0.000000,
//	"m_flModulatorFrequency": 0.000000,
//	"m_flModulatorAmount": 0.000000
//}
// MPropertyFriendlyName = "TESTBED: FM Synth Container"
// MPropertyDescription = "Real time FM Synthesis"
class CVoiceContainerRealtimeFMSineWave : public CVoiceContainerBase
{
	// MPropertyFriendlyName = "Frequency (Hz)"
	// MPropertyDescription = "The frequency of this sine tone."
	float32 m_flCarrierFrequency;
	// MPropertyFriendlyName = "Mod Frequency (Hz)"
	// MPropertyDescription = "The frequency of the sine tone modulating this sine tone."
	float32 m_flModulatorFrequency;
	// MPropertyFriendlyName = "Mod Amount (Hz)"
	// MPropertyDescription = "The amount the modulating sine tone modulates this sine tone."
	float32 m_flModulatorAmount;
};
