class CNmFloatComparisonNode::CDefinition : public CNmBoolValueNode::CDefinition
{
	int16 m_nInputValueNodeIdx;
	int16 m_nComparandValueNodeIdx;
	CNmFloatComparisonNode::Comparison_t m_comparison;
	float32 m_flEpsilon;
	float32 m_flComparisonValue;
};
