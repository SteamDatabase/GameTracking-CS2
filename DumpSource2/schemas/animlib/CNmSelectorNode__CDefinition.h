// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class CNmSelectorNode::CDefinition : public CNmPoseNode::CDefinition
{
	CUtlLeanVectorFixedGrowable< int16, 5 > m_optionNodeIndices;
	CUtlLeanVectorFixedGrowable< int16, 5 > m_conditionNodeIndices;
};
