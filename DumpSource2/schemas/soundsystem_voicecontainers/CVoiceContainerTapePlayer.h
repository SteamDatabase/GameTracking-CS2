// MGetKV3ClassDefaults = {
//	"_class": "CVoiceContainerTapePlayer",
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
//	"m_bShouldWraparound": false,
//	"m_sourceAudio": "",
//	"m_flTapeSpeedAttackTime": 0.300000,
//	"m_flTapeSpeedReleaseTime": 0.700000
//}
// MPropertyFriendlyName = "Tape Player"
class CVoiceContainerTapePlayer : public CVoiceContainerAsyncGenerator
{
	bool m_bShouldWraparound;
	CStrongHandle< InfoForResourceTypeCVoiceContainerBase > m_sourceAudio;
	float32 m_flTapeSpeedAttackTime;
	float32 m_flTapeSpeedReleaseTime;
};
