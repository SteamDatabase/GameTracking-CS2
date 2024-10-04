class CNmFootEventConditionNode::CDefinition : public CNmBoolValueNode::CDefinition
{
	int16 m_nSourceStateNodeIdx;
	NmFootPhaseCondition_t m_phaseCondition;
	CNmBitFlags m_eventConditionRules;
}
