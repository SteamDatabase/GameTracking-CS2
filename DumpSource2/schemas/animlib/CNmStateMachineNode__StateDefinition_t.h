// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class CNmStateMachineNode::StateDefinition_t
{
	int16 m_nStateNodeIdx;
	int16 m_nEntryConditionNodeIdx;
	CUtlLeanVectorFixedGrowable< CNmStateMachineNode::TransitionDefinition_t, 5 > m_transitionDefinitions;
};
