// MGetKV3ClassDefaults = {
//	"_class": "CNmCachedFloatNode::CDefinition",
//	"m_nNodeIdx": -1,
//	"m_nInputValueNodeIdx": -1,
//	"m_mode": "OnEntry"
//}
class CNmCachedFloatNode::CDefinition : public CNmFloatValueNode::CDefinition
{
	int16 m_nInputValueNodeIdx;
	NmCachedValueMode_t m_mode;
};
