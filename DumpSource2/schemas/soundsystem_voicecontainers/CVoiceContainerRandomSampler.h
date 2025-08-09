// MGetKV3ClassDefaults = {
//	"_class": "CVoiceContainerRandomSampler",
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
//	"m_flAmplitude": 0.800000,
//	"m_flAmplitudeJitter": 0.100000,
//	"m_flTimeJitter": 0.200000,
//	"m_flMaxLength": -1.000000,
//	"m_nNumDelayVariations": 0,
//	"m_grainResources":
//	[
//	]
//}
// MPropertyFriendlyName = "Random Smapler Container"
// MPropertyDescription = "Trash Synth"
class CVoiceContainerRandomSampler : public CVoiceContainerBase
{
	float32 m_flAmplitude;
	float32 m_flAmplitudeJitter;
	float32 m_flTimeJitter;
	float32 m_flMaxLength;
	int32 m_nNumDelayVariations;
	CUtlVector< CStrongHandle< InfoForResourceTypeCVoiceContainerBase > > m_grainResources;
};
