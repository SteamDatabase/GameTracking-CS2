class CNmStateMachineNode::TransitionDefinition_t
{
	int16 m_nTargetStateIdx;
	int16 m_nConditionNodeIdx;
	int16 m_nTransitionNodeIdx;
	bool m_bCanBeForced;
};
