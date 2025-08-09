// MGetKV3ClassDefaults = {
//	"_class": "CVoiceContainerBlender",
//	"m_vSound":
//	{
//		"m_nRate": 1397332433,
//		"m_nFormat": "ADPCM",
//		"m_nChannels": 2346635408,
//		"m_nLoopStart": 32767,
//		"m_nSampleCount": 1397332432,
//		"m_flDuration": 0.000000,
//		"m_Sentences":
//		[
//		],
//		"m_nStreamingSize": 2172796680,
//		"m_nSeekTable":
//		[
//		],
//		"m_nLoopEnd": -2003663293,
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
