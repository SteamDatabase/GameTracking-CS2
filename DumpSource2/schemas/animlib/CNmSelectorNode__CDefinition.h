// MGetKV3ClassDefaults = {
//	"_class": "CNmSelectorNode::CDefinition",
//	"m_nNodeIdx": -1,
//	"m_optionNodeIndices":
//	[
//	],
//	"m_conditionNodeIndices":
//	[
//	]
//}
class CNmSelectorNode::CDefinition : public CNmPoseNode::CDefinition
{
	CUtlLeanVectorFixedGrowable< int16, 5 > m_optionNodeIndices;
	CUtlLeanVectorFixedGrowable< int16, 5 > m_conditionNodeIndices;
};
