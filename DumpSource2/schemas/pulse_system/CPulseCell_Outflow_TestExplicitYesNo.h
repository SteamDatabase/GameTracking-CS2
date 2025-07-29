// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
// MCellForDomain = "TestDomain"
// MPulseCellMethodBindings (UNKNOWN FOR PARSER)
// MPulseCellOutflowHookInfo (UNKNOWN FOR PARSER)
// MPropertyFriendlyName = "[Test] Explicit Yes/No Outflow"
// MPropertyDescription = "Test node that picks between two outflows as specified in the test domain."
class CPulseCell_Outflow_TestExplicitYesNo : public CPulseCell_BaseFlow
{
	// MPropertyFriendlyName = "Yes"
	CPulse_OutflowConnection m_Yes;
	// MPropertyFriendlyName = "No"
	CPulse_OutflowConnection m_No;
};
