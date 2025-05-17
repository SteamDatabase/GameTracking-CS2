// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class CNmIDComparisonNode::CDefinition : public CNmBoolValueNode::CDefinition
{
	int16 m_nInputValueNodeIdx;
	CNmIDComparisonNode::Comparison_t m_comparison;
	CUtlLeanVectorFixedGrowable< CGlobalSymbol, 4 > m_comparisionIDs;
};
