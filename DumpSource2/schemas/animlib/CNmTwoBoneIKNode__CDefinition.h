// MGetKV3ClassDefaults = {
//	"_class": "CNmTwoBoneIKNode::CDefinition",
//	"m_nNodeIdx": -1,
//	"m_nChildNodeIdx": -1,
//	"m_effectorBoneID": "",
//	"m_nEffectorTargetNodeIdx": -1,
//	"m_nEnabledNodeIdx": -1,
//	"m_flBlendTimeSeconds": 0.000000,
//	"m_blendMode": "Effector",
//	"m_bIsTargetInWorldSpace": false
//}
class CNmTwoBoneIKNode::CDefinition : public CNmPassthroughNode::CDefinition
{
	CGlobalSymbol m_effectorBoneID;
	int16 m_nEffectorTargetNodeIdx;
	int16 m_nEnabledNodeIdx;
	float32 m_flBlendTimeSeconds;
	NmIKBlendMode_t m_blendMode;
	bool m_bIsTargetInWorldSpace;
};
