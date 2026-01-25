// MGetKV3ClassDefaults = {
//	"_class": "CVoiceContainerRealtimeFMSineWave",
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
//	"m_flCarrierFrequency": 0.000000,
//	"m_flModulatorFrequency": 0.000000,
//	"m_flModulatorAmount": 0.000000
//}
// MPropertyFriendlyName = "TESTBED: FM Synth Container"
// MPropertyDescription = "Real time FM Synthesis"
class CVoiceContainerRealtimeFMSineWave : public CVoiceContainerGenerator
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
