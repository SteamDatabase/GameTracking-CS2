// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
// MCellForDomain = "TestDomain"
// MPulseCellMethodBindings (UNKNOWN FOR PARSER)
// MPulseCellOutflowHookInfo (UNKNOWN FOR PARSER)
class CPulseCell_TestWaitWithCursorState : public CPulseCell_BaseYieldingInflow
{
	// MPulseCellOutflow_IsDefault
	CPulse_ResumePoint m_WakeResume;
	CPulse_ResumePoint m_WakeCancel;
	CPulse_ResumePoint m_WakeFail;
};
