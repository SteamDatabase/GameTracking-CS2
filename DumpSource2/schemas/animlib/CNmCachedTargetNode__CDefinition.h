// MGetKV3ClassDefaults = {
//	"_class": "CNmCachedTargetNode::CDefinition",
//	"m_nNodeIdx": -1,
//	"m_nInputValueNodeIdx": -1,
//	"m_mode": "OnEntry"
//}
class CNmCachedTargetNode::CDefinition : public CNmTargetValueNode::CDefinition
{
	int16 m_nInputValueNodeIdx;
	NmCachedValueMode_t m_mode;
};
