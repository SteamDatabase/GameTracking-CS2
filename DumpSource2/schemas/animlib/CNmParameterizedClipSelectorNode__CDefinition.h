// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class CNmParameterizedClipSelectorNode::CDefinition : public CNmClipReferenceNode::CDefinition
{
	CUtlLeanVectorFixedGrowable< int16, 5 > m_optionNodeIndices;
	CUtlLeanVectorFixedGrowable< uint8, 5 > m_optionWeights;
	int16 m_parameterNodeIdx;
	bool m_bIgnoreInvalidOptions;
	bool m_bHasWeightsSet;
};
