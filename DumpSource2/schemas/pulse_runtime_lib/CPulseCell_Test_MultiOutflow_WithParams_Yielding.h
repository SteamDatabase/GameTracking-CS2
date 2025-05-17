// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
// MCellForDomain = "TestDomain"
// MPulseCellMethodBindings (UNKNOWN FOR PARSER)
// MPulseCellOutflowHookInfo (UNKNOWN FOR PARSER)
class CPulseCell_Test_MultiOutflow_WithParams_Yielding : public CPulseCell_BaseYieldingInflow
{
	// MPulseCellOutflow_IsDefault
	// MPulseSignatureName (UNKNOWN FOR PARSER)
	SignatureOutflow_Continue m_Out1;
	// MPulseSignatureName (UNKNOWN FOR PARSER)
	SignatureOutflow_Continue m_AsyncChild1;
	// MPulseSignatureName (UNKNOWN FOR PARSER)
	SignatureOutflow_Continue m_AsyncChild2;
	// MPulseSignatureName (UNKNOWN FOR PARSER)
	SignatureOutflow_Resume m_YieldResume1;
	// MPulseSignatureName (UNKNOWN FOR PARSER)
	SignatureOutflow_Resume m_YieldResume2;
};
