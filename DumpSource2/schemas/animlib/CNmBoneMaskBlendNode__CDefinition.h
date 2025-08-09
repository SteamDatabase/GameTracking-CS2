// MGetKV3ClassDefaults = {
//	"_class": "CNmBoneMaskBlendNode::CDefinition",
//	"m_nNodeIdx": -1,
//	"m_nSourceMaskNodeIdx": -1,
//	"m_nTargetMaskNodeIdx": -1,
//	"m_nBlendWeightValueNodeIdx": -1
//}
class CNmBoneMaskBlendNode::CDefinition : public CNmBoneMaskValueNode::CDefinition
{
	int16 m_nSourceMaskNodeIdx;
	int16 m_nTargetMaskNodeIdx;
	int16 m_nBlendWeightValueNodeIdx;
};
