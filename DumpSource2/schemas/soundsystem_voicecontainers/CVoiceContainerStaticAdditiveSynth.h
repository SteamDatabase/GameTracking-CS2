// MGetKV3ClassDefaults = {
//	"_class": "CVoiceContainerStaticAdditiveSynth",
//	"m_vSound":
//	{
//		"m_nRate": 89430577,
//		"m_nFormat": "MP3",
//		"m_nChannels": 894094208,
//		"m_nLoopStart": 32767,
//		"m_nSampleCount": 2883879052,
//		"m_flDuration": 0.000000,
//		"m_Sentences":
//		[
//		],
//		"m_nStreamingSize": 959054024,
//		"m_nSeekTable":
//		[
//		],
//		"m_nLoopEnd": -1405581533,
//		"m_encodedHeader": "[BINARY BLOB]"
//	},
//	"m_pEnvelopeAnalyzer": null,
//	"m_tones":
//	[
//	]
//}
// MPropertyFriendlyName = "Additive Synth Container"
// MPropertyDescription = "This is a static additive synth that can scale components of the synth based on how many instances are running."
class CVoiceContainerStaticAdditiveSynth : public CVoiceContainerBase
{
	CUtlVector< CVoiceContainerStaticAdditiveSynth::CTone > m_tones;
};
