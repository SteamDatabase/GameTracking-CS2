// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
// MCellForDomain = "BaseDomain"
// MPulseCellMethodBindings (UNKNOWN FOR PARSER)
// MPulseCellOutflowHookInfo (UNKNOWN FOR PARSER)
// MPulseCellWithCustomDocNode
class CPulseCell_Step_CallExternalMethod : public CPulseCell_BaseYieldingInflow
{
	PulseSymbol_t m_MethodName;
	PulseSymbol_t m_GameBlackboard;
	CUtlLeanVector< CPulseRuntimeMethodArg > m_ExpectedArgs;
	PulseMethodCallMode_t m_nAsyncCallMode;
	CPulse_ResumePoint m_OnFinished;
};
