// MGetKV3ClassDefaults = {
//	"_class": "CNmVectorInfoNode::CDefinition",
//	"m_nNodeIdx": -1,
//	"m_nInputValueNodeIdx": -1,
//	"m_desiredInfo": "X"
//}
class CNmVectorInfoNode::CDefinition : public CNmFloatValueNode::CDefinition
{
	int16 m_nInputValueNodeIdx;
	CNmVectorInfoNode::Info_t m_desiredInfo;
};
