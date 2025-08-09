// MGetKV3ClassDefaults = {
//	"_class": "CNmCachedBoolNode::CDefinition",
//	"m_nNodeIdx": -1,
//	"m_nInputValueNodeIdx": -1,
//	"m_mode": "OnEntry"
//}
class CNmCachedBoolNode::CDefinition : public CNmBoolValueNode::CDefinition
{
	int16 m_nInputValueNodeIdx;
	NmCachedValueMode_t m_mode;
};
