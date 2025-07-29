// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
// MCellForDomain = "TestDomain"
// MPulseCellMethodBindings (UNKNOWN FOR PARSER)
// MPulseCellOutflowHookInfo (UNKNOWN FOR PARSER)
// MPropertyFriendlyName = "[Test] Random Yes/No Outflow"
// MPropertyDescription = "Test node that randomly picks between two outflows."
class CPulseCell_Outflow_TestRandomYesNo : public CPulseCell_BaseFlow
{
	// MPropertyFriendlyName = "Yes"
	// MPropertyDescription = "Randomly taken half of the time"
	CPulse_OutflowConnection m_Yes;
	// MPropertyFriendlyName = "No"
	// MPropertyDescription = "Randomly taken half of the time"
	CPulse_OutflowConnection m_No;
};
