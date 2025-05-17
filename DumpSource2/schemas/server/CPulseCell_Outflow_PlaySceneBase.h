// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class CPulseCell_Outflow_PlaySceneBase : public CPulseCell_BaseYieldingInflow
{
	CPulse_ResumePoint m_OnFinished;
	CPulse_ResumePoint m_OnCanceled;
	CUtlVector< CPulse_OutflowConnection > m_Triggers;
};
