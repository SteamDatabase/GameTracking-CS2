// MGetKV3ClassDefaults = {
//	"_class": "CAnimStateMachineUpdater",
//	"m_states":
//	[
//	],
//	"m_transitions":
//	[
//	],
//	"m_startStateIndex": -1
//}
class CAnimStateMachineUpdater
{
	CUtlVector< CStateUpdateData > m_states;
	CUtlVector< CTransitionUpdateData > m_transitions;
	int32 m_startStateIndex;
};
