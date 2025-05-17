// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class CNmFootstepEventPercentageThroughNode::CDefinition : public CNmFloatValueNode::CDefinition
{
	int16 m_nSourceStateNodeIdx;
	NmFootPhaseCondition_t m_phaseCondition;
	CNmBitFlags m_eventConditionRules;
};
