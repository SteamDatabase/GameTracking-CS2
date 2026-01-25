// MGetKV3ClassDefaults = {
//	"_class": "CVoiceContainerEnum",
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
//	"m_iSelection": 0,
//	"m_flCrossfadeTime": 0.100000
//}
// MPropertyFriendlyName = "VSND Enum"
// MPropertyDescription = "Switches between a selection of vsnds based on a provided index."
class CVoiceContainerEnum : public CVoiceContainerBase
{
	// MPropertyFriendlyName = "Sounds To Play"
	CSoundContainerReferenceArray m_soundsToPlay;
	// MPropertyFriendlyName = "Index"
	int32 m_iSelection;
	// MPropertyFriendlyName = "Crossfade Time"
	float32 m_flCrossfadeTime;
};
