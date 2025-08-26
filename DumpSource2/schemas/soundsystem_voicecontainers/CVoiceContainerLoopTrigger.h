// MGetKV3ClassDefaults = {
//	"_class": "CVoiceContainerLoopTrigger",
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
//	"m_sound":
//	{
//		"m_bUseReference": true,
//		"m_sound": "",
//		"m_pSound": null
//	},
//	"m_flRetriggerTimeMin": 1.000000,
//	"m_flRetriggerTimeMax": 1.000000,
//	"m_flFadeTime": 0.500000,
//	"m_bCrossFade": false
//}
// MPropertyFriendlyName = "LoopTrigger"
// MPropertyDescription = "Continuously retriggers a sound and optionally fades to the new instance."
class CVoiceContainerLoopTrigger : public CVoiceContainerBase
{
	// MPropertyFriendlyName = "Vsnd Reference"
	CSoundContainerReference m_sound;
	float32 m_flRetriggerTimeMin;
	float32 m_flRetriggerTimeMax;
	float32 m_flFadeTime;
	bool m_bCrossFade;
};
