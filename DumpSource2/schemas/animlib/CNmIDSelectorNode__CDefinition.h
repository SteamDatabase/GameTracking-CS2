// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class CNmIDSelectorNode::CDefinition : public CNmIDValueNode::CDefinition
{
	CUtlVectorFixedGrowable< int16, 5 > m_conditionNodeIndices;
	CUtlVectorFixedGrowable< CGlobalSymbol, 5 > m_values;
	CGlobalSymbol m_defaultValue;
};
