// MGetKV3ClassDefaults = {
//	"_class": "CVoiceContainerLoopXFade",
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
//	"m_sound":
//	{
//		"m_bUseReference": true,
//		"m_sound": "",
//		"m_pSound": null
//	},
//	"m_flLoopEnd": 0.000000,
//	"m_flLoopStart": 0.000000,
//	"m_flFadeOut": 0.000000,
//	"m_flFadeIn": 0.000000,
//	"m_bPlayHead": false,
//	"m_bPlayTail": false,
//	"m_bEqualPow": false
//}
// MPropertyFriendlyName = "Loop XFade"
// MPropertyDescription = "Sample accurate looping with xfade capabilities."
class CVoiceContainerLoopXFade : public CVoiceContainerBase
{
	// MPropertyFriendlyName = "Vsnd Reference"
	CSoundContainerReference m_sound;
	float32 m_flLoopEnd;
	float32 m_flLoopStart;
	float32 m_flFadeOut;
	float32 m_flFadeIn;
	bool m_bPlayHead;
	bool m_bPlayTail;
	bool m_bEqualPow;
};
