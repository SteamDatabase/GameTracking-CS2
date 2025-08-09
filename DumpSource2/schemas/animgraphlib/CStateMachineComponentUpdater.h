// MGetKV3ClassDefaults = {
//	"_class": "CStateMachineComponentUpdater",
//	"m_name": "State Machine",
//	"m_id":
//	{
//		"m_id": 4294967295
//	},
//	"m_networkMode": "ServerAuthoritative",
//	"m_bStartEnabled": false,
//	"m_stateMachine":
//	{
//		"_class": "CAnimStateMachineUpdater",
//		"m_states":
//		[
//		],
//		"m_transitions":
//		[
//		],
//		"m_startStateIndex": -1
//	}
//}
class CStateMachineComponentUpdater : public CAnimComponentUpdater
{
	CAnimStateMachineUpdater m_stateMachine;
};
