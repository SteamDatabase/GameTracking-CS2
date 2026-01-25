// MGetKV3ClassDefaults = {
//	"_class": "CVoiceContainerMultiBlender",
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
//	"m_soundsToPlay":
//	{
//		"m_bUseReference": true,
//		"m_sounds":
//		[
//		],
//		"m_pSounds":
//		[
//		]
//	},
//	"m_flBlendFactor": 0.000000,
//	"m_flCrossover": 1.000000
//}
// MPropertyFriendlyName = "Multi Blender"
// MPropertyDescription = "Blends any number of containers"
class CVoiceContainerMultiBlender : public CVoiceContainerBase
{
	// MPropertyFriendlyName = "Sounds To Blend"
	CSoundContainerReferenceArray m_soundsToPlay;
	// MPropertyFriendlyName = "Blend Amount (0.0 = 100% first sound, 1.0 = 100% last sound)"
	float32 m_flBlendFactor;
	// MPropertyFriendlyName = "Crossfade Amount (0.0 = no crossfade, 1.0 = constant crossfading)"
	float32 m_flCrossover;
};
