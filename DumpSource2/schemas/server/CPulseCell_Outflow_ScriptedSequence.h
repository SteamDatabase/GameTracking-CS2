// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
// MCellForDomain = "ServerPointEntity"
// MPulseCellMethodBindings (UNKNOWN FOR PARSER)
// MPulseCellOutflowHookInfo (UNKNOWN FOR PARSER)
// MPulseCellWithCustomDocNode
class CPulseCell_Outflow_ScriptedSequence : public CPulseCell_BaseYieldingInflow
{
	CUtlString m_szSyncGroup;
	int32 m_nExpectedNumSequencesInSyncGroup;
	bool m_bEnsureOnNavmeshOnFinish;
	bool m_bDontTeleportAtEnd;
	PulseScriptedSequenceData_t m_scriptedSequenceDataMain;
	CUtlVector< PulseScriptedSequenceData_t > m_vecAdditionalActors;
	CPulse_ResumePoint m_OnFinished;
	CPulse_ResumePoint m_OnCanceled;
	CUtlVector< CPulse_OutflowConnection > m_Triggers;
};
