// MGetKV3ClassDefaults = {
//	"m_bShouldVoiceDuck": false,
//	"m_RunTimePhonemes":
//	[
//	],
//	"m_EmphasisSamples":
//	[
//	],
//	"m_morphData":
//	{
//		"m_times":
//		[
//		],
//		"m_nameHashCodes":
//		[
//		],
//		"m_nameStrings":
//		[
//		],
//		"m_samples":
//		[
//		],
//		"m_flEaseIn": 0.200000,
//		"m_flEaseOut": 0.200000
//	}
//}
class CAudioSentence
{
	bool m_bShouldVoiceDuck;
	CUtlVector< CAudioPhonemeTag > m_RunTimePhonemes;
	CUtlVector< CAudioEmphasisSample > m_EmphasisSamples;
	CAudioMorphData m_morphData;
};
