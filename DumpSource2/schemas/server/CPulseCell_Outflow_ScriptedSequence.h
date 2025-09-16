// MGetKV3ClassDefaults = {
//	"_class": "CPulseCell_Outflow_ScriptedSequence",
//	"m_nEditorNodeID": -1,
//	"m_szSyncGroup": "",
//	"m_nExpectedNumSequencesInSyncGroup": 0,
//	"m_bEnsureOnNavmeshOnFinish": true,
//	"m_bDontTeleportAtEnd": true,
//	"m_bDisallowInterrupts": true,
//	"m_scriptedSequenceDataMain":
//	{
//		"m_nActorID": 0,
//		"m_szPreIdleSequence": "",
//		"m_szEntrySequence": "",
//		"m_szSequence": "",
//		"m_szExitSequence": "",
//		"m_nMoveTo": "eWaitFacing",
//		"m_nMoveToGait": "eInvalid",
//		"m_nHeldWeaponBehavior": "eInvalid",
//		"m_bLoopPreIdleSequence": false,
//		"m_bLoopActionSequence": false,
//		"m_bLoopPostIdleSequence": false,
//		"m_bIgnoreLookAt": false
//	},
//	"m_vecAdditionalActors":
//	[
//	],
//	"m_OnFinished":
//	{
//		"m_SourceOutflowName": "",
//		"m_nDestChunk": -1,
//		"m_nInstruction": -1
//	},
//	"m_OnCanceled":
//	{
//		"m_SourceOutflowName": "",
//		"m_nDestChunk": -1,
//		"m_nInstruction": -1
//	},
//	"m_Triggers":
//	[
//	]
//}
// MPulseCellMethodBindings (UNKNOWN FOR PARSER)
class CPulseCell_Outflow_ScriptedSequence : public CPulseCell_BaseYieldingInflow
{
	CUtlString m_szSyncGroup;
	int32 m_nExpectedNumSequencesInSyncGroup;
	bool m_bEnsureOnNavmeshOnFinish;
	bool m_bDontTeleportAtEnd;
	bool m_bDisallowInterrupts;
	PulseScriptedSequenceData_t m_scriptedSequenceDataMain;
	CUtlVector< PulseScriptedSequenceData_t > m_vecAdditionalActors;
	CPulse_ResumePoint m_OnFinished;
	CPulse_ResumePoint m_OnCanceled;
	CUtlVector< CPulse_OutflowConnection > m_Triggers;
};
