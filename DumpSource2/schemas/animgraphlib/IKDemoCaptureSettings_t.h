// MGetKV3ClassDefaults = {
//	"m_parentBoneName": "",
//	"m_eMode": "TwoBone",
//	"m_ikChainName": "",
//	"m_oneBoneStart": "",
//	"m_oneBoneEnd": ""
//}
class IKDemoCaptureSettings_t
{
	// MPropertyFriendlyName = "Target Parent"
	// MPropertyAttributeChoiceName = "Bone"
	CUtlString m_parentBoneName;
	// MPropertyFriendlyName = "Solver Mode"
	// MPropertyAutoRebuildOnChange
	IKChannelMode m_eMode;
	// MPropertyFriendlyName = "IK Chain"
	// MPropertyAttributeChoiceName = "IKChain"
	// MPropertyAttrStateCallback (UNKNOWN FOR PARSER)
	CUtlString m_ikChainName;
	// MPropertyFriendlyName = "Start Bone"
	// MPropertyAttributeChoiceName = "Bone"
	// MPropertyAttrStateCallback (UNKNOWN FOR PARSER)
	CUtlString m_oneBoneStart;
	// MPropertyFriendlyName = "End Bone"
	// MPropertyAttributeChoiceName = "Bone"
	// MPropertyAttrStateCallback (UNKNOWN FOR PARSER)
	CUtlString m_oneBoneEnd;
};
