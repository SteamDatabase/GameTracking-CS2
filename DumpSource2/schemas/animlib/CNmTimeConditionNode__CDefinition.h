class CNmTimeConditionNode::CDefinition : public CNmBoolValueNode::CDefinition
{
	int16 m_sourceStateNodeIdx;
	int16 m_nInputValueNodeIdx;
	float32 m_flComparand;
	CNmTimeConditionNode::ComparisonType_t m_type;
	CNmTimeConditionNode::Operator_t m_operator;
}
