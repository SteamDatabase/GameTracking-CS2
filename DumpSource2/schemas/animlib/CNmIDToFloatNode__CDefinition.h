// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class CNmIDToFloatNode::CDefinition : public CNmFloatValueNode::CDefinition
{
	int16 m_nInputValueNodeIdx;
	float32 m_defaultValue;
	CUtlLeanVectorFixedGrowable< CGlobalSymbol, 5 > m_IDs;
	CUtlLeanVectorFixedGrowable< float32, 5 > m_values;
};
