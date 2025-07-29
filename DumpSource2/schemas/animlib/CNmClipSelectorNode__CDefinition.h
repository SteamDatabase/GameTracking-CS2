// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class CNmClipSelectorNode::CDefinition : public CNmClipReferenceNode::CDefinition
{
	CUtlLeanVectorFixedGrowable< int16, 5 > m_optionNodeIndices;
	CUtlLeanVectorFixedGrowable< int16, 5 > m_conditionNodeIndices;
};
