// MGetKV3ClassDefaults = {
//	"_class": "CNmCachedIDNode::CDefinition",
//	"m_nNodeIdx": -1,
//	"m_nInputValueNodeIdx": -1,
//	"m_mode": "OnEntry"
//}
class CNmCachedIDNode::CDefinition : public CNmIDValueNode::CDefinition
{
	int16 m_nInputValueNodeIdx;
	NmCachedValueMode_t m_mode;
};
