// MGetKV3ClassDefaults = {
//	"_class": "CNmBoneMaskSwitchNode::CDefinition",
//	"m_nNodeIdx": -1,
//	"m_nSwitchValueNodeIdx": -1,
//	"m_nTrueValueNodeIdx": -1,
//	"m_nFalseValueNodeIdx": -1,
//	"m_flBlendTimeSeconds": 0.100000,
//	"m_bSwitchDynamically": false
//}
class CNmBoneMaskSwitchNode::CDefinition : public CNmBoneMaskValueNode::CDefinition
{
	int16 m_nSwitchValueNodeIdx;
	int16 m_nTrueValueNodeIdx;
	int16 m_nFalseValueNodeIdx;
	float32 m_flBlendTimeSeconds;
	bool m_bSwitchDynamically;
};
