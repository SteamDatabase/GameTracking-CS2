// MGetKV3ClassDefaults = {
//	"_class": "CVoiceContainerBase",
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
//	"m_pEnvelopeAnalyzer": null
//}
// MVDataRoot
// MVDataNodeType = 1
// MPropertyPolymorphicClass
// MVDataFileExtension = "vsnd"
// MPropertyFriendlyName = "VSND Container"
// MPropertyDescription = "Voice Container Base"
class CVoiceContainerBase
{
	// MPropertySuppressField
	CVSound m_vSound;
	// MPropertySuppressExpr = "true"
	CVoiceContainerAnalysisBase* m_pEnvelopeAnalyzer;
};
