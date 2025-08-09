// MGetKV3ClassDefaults = {
//	"m_name": "",
//	"m_hScript":
//	{
//		"m_id": 4294967295
//	},
//	"m_transitionIndices":
//	[
//	],
//	"m_actions":
//	[
//	],
//	"m_stateID":
//	{
//		"m_id": 4294967295
//	},
//	"m_bIsStartState": 0,
//	"m_bIsEndState": 0,
//	"m_bIsPassthrough": 0,
//	"m_bIsPassthroughRootMotion": 0,
//	"m_bPreEvaluatePassthroughTransitionPath": 0
//}
class CStateUpdateData
{
	CUtlString m_name;
	AnimScriptHandle m_hScript;
	CUtlVector< int32 > m_transitionIndices;
	CUtlVector< CStateActionUpdater > m_actions;
	AnimStateID m_stateID;
	bitfield:1 m_bIsStartState;
	bitfield:1 m_bIsEndState;
	bitfield:1 m_bIsPassthrough;
	bitfield:1 m_bIsPassthroughRootMotion;
	bitfield:1 m_bPreEvaluatePassthroughTransitionPath;
};
