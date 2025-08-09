// MGetKV3ClassDefaults = {
//	"_class": "CStateMachineUpdateNode",
//	"m_nodePath":
//	{
//		"m_path":
//		[
//			{
//				"m_id": 4294967295
//			},
//			{
//				"m_id": 4294967295
//			},
//			{
//				"m_id": 4294967295
//			},
//			{
//				"m_id": 4294967295
//			},
//			{
//				"m_id": 4294967295
//			},
//			{
//				"m_id": 4294967295
//			},
//			{
//				"m_id": 4294967295
//			},
//			{
//				"m_id": 4294967295
//			},
//			{
//				"m_id": 4294967295
//			},
//			{
//				"m_id": 4294967295
//			},
//			{
//				"m_id": 4294967295
//			}
//		],
//		"m_nCount": 0
//	},
//	"m_networkMode": "ServerAuthoritative",
//	"m_name": "",
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
//	},
//	"m_stateData":
//	[
//	],
//	"m_transitionData":
//	[
//	],
//	"m_bBlockWaningTags": false,
//	"m_bLockStateWhenWaning": false,
//	"m_bResetWhenActivated": false
//}
class CStateMachineUpdateNode : public CAnimUpdateNodeBase
{
	CAnimStateMachineUpdater m_stateMachine;
	CUtlVector< CStateNodeStateData > m_stateData;
	CUtlVector< CStateNodeTransitionData > m_transitionData;
	bool m_bBlockWaningTags;
	bool m_bLockStateWhenWaning;
	bool m_bResetWhenActivated;
};
