// MGetKV3ClassDefaults = {
//	"_class": "CTestBlendContainer",
//	"m_vSound":
//	{
//		"m_nRate": 993970224,
//		"m_nFormat": 161,
//		"m_nChannels": 8,
//		"m_nLoopStart": 0,
//		"m_nSampleCount": 894093808,
//		"m_flDuration": 0.000000,
//		"m_Sentences":
//		[
//		],
//		"m_nStreamingSize": 2885849517,
//		"m_nSeekTable":
//		[
//		],
//		"m_nLoopEnd": 0,
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
