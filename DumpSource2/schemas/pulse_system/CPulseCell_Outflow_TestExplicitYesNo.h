// MGetKV3ClassDefaults = {
//	"_class": "CPulseCell_Outflow_TestExplicitYesNo",
//	"m_nEditorNodeID": -1,
//	"m_Yes":
//	{
//		"m_SourceOutflowName": "",
//		"m_nDestChunk": -1,
//		"m_nInstruction": -1
//	},
//	"m_No":
//	{
//		"m_SourceOutflowName": "",
//		"m_nDestChunk": -1,
//		"m_nInstruction": -1
//	}
//}
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
