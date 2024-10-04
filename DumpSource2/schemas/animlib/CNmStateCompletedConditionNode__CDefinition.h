class CNmStateCompletedConditionNode::CDefinition : public CNmBoolValueNode::CDefinition
{
	int16 m_nSourceStateNodeIdx;
	int16 m_nTransitionDurationOverrideNodeIdx;
	float32 m_flTransitionDurationSeconds;
}
