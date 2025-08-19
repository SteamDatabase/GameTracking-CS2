// MGetKV3ClassDefaults = {
//	"_class": "CVoiceContainerBlender",
//	"m_vSound":
//	{
//		"m_nRate": 89430577,
//		"m_nFormat": "MP3",
//		"m_nChannels": 894094208,
//		"m_nLoopStart": 32767,
//		"m_nSampleCount": 89430576,
//		"m_flDuration": 0.000000,
//		"m_Sentences":
//		[
//		],
//		"m_nStreamingSize": 959282600,
//		"m_nSeekTable":
//		[
//		],
//		"m_nLoopEnd": 975595040,
//		"m_encodedHeader": "[BINARY BLOB]"
//	},
//	"m_pEnvelopeAnalyzer": null,
//	"m_firstSound":
//	{
//		"m_bUseReference": true,
//		"m_sound": "",
//		"m_pSound": null
//	},
//	"m_secondSound":
//	{
//		"m_bUseReference": true,
//		"m_sound": "",
//		"m_pSound": null
//	},
//	"m_flBlendFactor": 0.000000
//}
// MPropertyFriendlyName = "Blender"
// MPropertyDescription = "Blends two containers."
class CVoiceContainerBlender : public CVoiceContainerBase
{
	CSoundContainerReference m_firstSound;
	CSoundContainerReference m_secondSound;
	float32 m_flBlendFactor;
};
