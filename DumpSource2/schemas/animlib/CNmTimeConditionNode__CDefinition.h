// MGetKV3ClassDefaults = {
//	"_class": "CNmTimeConditionNode::CDefinition",
//	"m_nNodeIdx": -1,
//	"m_sourceStateNodeIdx": -1,
//	"m_nInputValueNodeIdx": -1,
//	"m_flComparand": 0.000000,
//	"m_type": "ElapsedTime",
//	"m_operator": "LessThan"
//}
class CNmTimeConditionNode::CDefinition : public CNmBoolValueNode::CDefinition
{
	int16 m_sourceStateNodeIdx;
	int16 m_nInputValueNodeIdx;
	float32 m_flComparand;
	CNmTimeConditionNode::ComparisonType_t m_type;
	CNmTimeConditionNode::Operator_t m_operator;
};
