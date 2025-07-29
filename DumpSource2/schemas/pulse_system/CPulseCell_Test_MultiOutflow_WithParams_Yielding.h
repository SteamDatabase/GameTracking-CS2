// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
// MCellForDomain = "TestDomain"
// MPulseCellMethodBindings (UNKNOWN FOR PARSER)
// MPulseCellOutflowHookInfo (UNKNOWN FOR PARSER)
class CPulseCell_Test_MultiOutflow_WithParams_Yielding : public CPulseCell_BaseYieldingInflow
{
	// MPulseCellOutflow_IsDefault
	SignatureOutflow_Continue m_Out1;
	SignatureOutflow_Continue m_AsyncChild1;
	SignatureOutflow_Continue m_AsyncChild2;
	SignatureOutflow_Resume m_YieldResume1;
	SignatureOutflow_Resume m_YieldResume2;
};
