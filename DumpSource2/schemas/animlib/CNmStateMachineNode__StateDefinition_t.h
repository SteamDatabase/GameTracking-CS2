// MGetKV3ClassDefaults = {
//	"m_nStateNodeIdx": -1,
//	"m_nEntryConditionNodeIdx": -1,
//	"m_transitionDefinitions":
//	[
//	]
//}
class CNmStateMachineNode::StateDefinition_t
{
	int16 m_nStateNodeIdx;
	int16 m_nEntryConditionNodeIdx;
	CUtlLeanVectorFixedGrowable< CNmStateMachineNode::TransitionDefinition_t, 5 > m_transitionDefinitions;
};
