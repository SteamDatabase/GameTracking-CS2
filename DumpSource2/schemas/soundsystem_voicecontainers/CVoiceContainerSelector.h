// MGetKV3ClassDefaults = {
//	"_class": "CVoiceContainerSelector",
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
//	"m_mode": "Random",
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
//	"m_fProbabilityWeights":
//	[
//	]
//}
// MPropertyFriendlyName = "Selector"
// MPropertyDescription = "Plays a selected vsnd on playback."
class CVoiceContainerSelector : public CVoiceContainerBase
{
	// MPropertyFriendlyName = "Playback Mode"
	PlayBackMode_t m_mode;
	// MPropertyFriendlyName = "Sounds To play"
	CSoundContainerReferenceArray m_soundsToPlay;
	// MPropertyFriendlyName = "Relative Weights"
	CUtlVector< float32 > m_fProbabilityWeights;
};
