// MGetKV3ClassDefaults = {
//	"m_nTargetStateIdx": -1,
//	"m_nConditionNodeIdx": -1,
//	"m_nTransitionNodeIdx": -1,
//	"m_bCanBeForced": false
//}
class CNmStateMachineNode::TransitionDefinition_t
{
	int16 m_nTargetStateIdx;
	int16 m_nConditionNodeIdx;
	int16 m_nTransitionNodeIdx;
	bool m_bCanBeForced;
};
