// MVDataRoot
// MVDataNodeType = 1
// MPropertyPolymorphicClass
// MVDataFileExtension = "vsnd"
// MVDataSingleton
// MPropertyFriendlyName = "VSND Container"
// MPropertyDescription = "Voice Container Base"
// MHasKV3TransferPolymorphicClassname
class CVoiceContainerBase
{
	bool m_bRegisteredVMix;
	CUtlStringToken m_nResourceName;
	// MPropertySuppressField
	CVSound m_vSound;
	// MPropertySuppressExpr = "true"
	CVoiceContainerAnalysisBase* m_pEnvelopeAnalyzer;
};
