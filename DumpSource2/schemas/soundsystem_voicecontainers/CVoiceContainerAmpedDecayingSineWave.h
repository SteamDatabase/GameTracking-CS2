// MGetKV3ClassDefaults = {
//	"_class": "CVoiceContainerAmpedDecayingSineWave",
//	"m_vSound":
//	{
//		"m_nRate": <HIDDEN FOR DIFF>,
//		"m_nFormat": <HIDDEN FOR DIFF>,
//		"m_nChannels": 3,
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
//	"m_flFrequency": 0.000000,
//	"m_flDecayTime": 0.000000,
//	"m_flGainAmount": 0.000000
//}
// MPropertyFriendlyName = "TESTBED: Amped Decaying Sine Wave Container"
// MPropertyDescription = "Bytecode instruction"
class CVoiceContainerAmpedDecayingSineWave : public CVoiceContainerDecayingSineWave
{
	// MPropertyFriendlyName = "Attenuation Amount (dB)"
	// MPropertyDescription = "The amount of attenuation ."
	float32 m_flGainAmount;
};
