// MGetKV3ClassDefaults = {
//	"_class": "CVoiceContainerBlender",
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
//	"m_flBlendFactor": -0.000000
//}
// MPropertyFriendlyName = "Blender"
// MPropertyDescription = "Blends two containers."
class CVoiceContainerBlender : public CVoiceContainerBase
{
	CSoundContainerReference m_firstSound;
	CSoundContainerReference m_secondSound;
	float32 m_flBlendFactor;
};
