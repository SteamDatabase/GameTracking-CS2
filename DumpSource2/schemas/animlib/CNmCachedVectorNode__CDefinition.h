// MGetKV3ClassDefaults = {
//	"_class": "CNmCachedVectorNode::CDefinition",
//	"m_nNodeIdx": -1,
//	"m_nInputValueNodeIdx": -1,
//	"m_mode": "OnEntry"
//}
class CNmCachedVectorNode::CDefinition : public CNmVectorValueNode::CDefinition
{
	int16 m_nInputValueNodeIdx;
	NmCachedValueMode_t m_mode;
};
