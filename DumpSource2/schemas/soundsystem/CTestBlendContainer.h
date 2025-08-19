// MGetKV3ClassDefaults = {
//	"_class": "CTestBlendContainer",
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
//	"m_firstSound": "",
//	"m_secondSound": ""
//}
// MPropertyFriendlyName = "TESTBED: Nested Voice Containers"
// MPropertyDescription = "Adds to voices to a tree span."
class CTestBlendContainer : public CVoiceContainerBase
{
	CStrongHandle< InfoForResourceTypeCVoiceContainerBase > m_firstSound;
	CStrongHandle< InfoForResourceTypeCVoiceContainerBase > m_secondSound;
};
