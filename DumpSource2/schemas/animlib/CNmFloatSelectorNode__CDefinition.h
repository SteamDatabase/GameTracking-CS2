class CNmFloatSelectorNode::CDefinition : public CNmFloatValueNode::CDefinition
{
	CUtlVectorFixedGrowable< int16, 5 > m_conditionNodeIndices;
	CUtlVectorFixedGrowable< float32, 5 > m_values;
	float32 m_flDefaultValue;
	float32 m_flEaseTime;
	NmEasingOperation_t m_easingOp;
};
