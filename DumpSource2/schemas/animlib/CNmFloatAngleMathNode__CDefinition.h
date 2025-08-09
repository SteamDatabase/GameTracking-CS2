// MGetKV3ClassDefaults = {
//	"_class": "CNmFloatAngleMathNode::CDefinition",
//	"m_nNodeIdx": -1,
//	"m_nInputValueNodeIdx": -1,
//	"m_operation": "ClampTo180"
//}
class CNmFloatAngleMathNode::CDefinition : public CNmFloatValueNode::CDefinition
{
	int16 m_nInputValueNodeIdx;
	CNmFloatAngleMathNode::Operation_t m_operation;
};
