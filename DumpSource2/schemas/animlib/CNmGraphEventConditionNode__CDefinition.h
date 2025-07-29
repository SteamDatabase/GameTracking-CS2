// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class CNmGraphEventConditionNode::CDefinition : public CNmBoolValueNode::CDefinition
{
	int16 m_nSourceStateNodeIdx;
	CNmBitFlags m_eventConditionRules;
	CUtlVectorFixedGrowable< CNmGraphEventConditionNode::Condition_t, 5 > m_conditions;
};
