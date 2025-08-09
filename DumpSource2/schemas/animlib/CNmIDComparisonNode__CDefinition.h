// MGetKV3ClassDefaults = {
//	"_class": "CNmIDComparisonNode::CDefinition",
//	"m_nNodeIdx": -1,
//	"m_nInputValueNodeIdx": -1,
//	"m_comparison": "Matches",
//	"m_comparisionIDs":
//	[
//	]
//}
class CNmIDComparisonNode::CDefinition : public CNmBoolValueNode::CDefinition
{
	int16 m_nInputValueNodeIdx;
	CNmIDComparisonNode::Comparison_t m_comparison;
	CUtlLeanVectorFixedGrowable< CGlobalSymbol, 4 > m_comparisionIDs;
};
