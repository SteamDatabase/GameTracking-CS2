class CNmFloatRangeComparisonNode::CDefinition : public CNmBoolValueNode::CDefinition
{
	Range_t m_range;
	int16 m_nInputValueNodeIdx;
	bool m_bIsInclusiveCheck;
};
