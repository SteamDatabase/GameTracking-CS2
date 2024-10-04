class CPulseCell_Step_CallExternalMethod : public CPulseCell_BaseYieldingInflow
{
	CUtlSymbolLarge m_MethodName;
	CUtlSymbolLarge m_GameBlackboard;
	CUtlLeanVector< CPulseRuntimeMethodArg > m_ExpectedArgs;
	PulseMethodCallMode_t m_nAsyncCallMode;
	CPulse_ResumePoint m_OnFinished;
}
