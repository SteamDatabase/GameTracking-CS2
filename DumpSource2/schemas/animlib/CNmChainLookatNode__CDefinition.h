// MGetKV3ClassDefaults = {
//	"_class": "CNmChainLookatNode::CDefinition",
//	"m_nNodeIdx": -1,
//	"m_nChildNodeIdx": -1,
//	"m_chainEndBoneID": "",
//	"m_nLookatTargetNodeIdx": -1,
//	"m_nEnabledNodeIdx": -1,
//	"m_flBlendTimeSeconds": 0.000000,
//	"m_nChainLength": 2,
//	"m_bIsTargetInWorldSpace": false,
//	"m_chainForwardDir":
//	[
//		1.000000,
//		0.000000,
//		0.000000
//	]
//}
class CNmChainLookatNode::CDefinition : public CNmPassthroughNode::CDefinition
{
	CGlobalSymbol m_chainEndBoneID;
	int16 m_nLookatTargetNodeIdx;
	int16 m_nEnabledNodeIdx;
	float32 m_flBlendTimeSeconds;
	uint8 m_nChainLength;
	bool m_bIsTargetInWorldSpace;
	Vector m_chainForwardDir;
};
