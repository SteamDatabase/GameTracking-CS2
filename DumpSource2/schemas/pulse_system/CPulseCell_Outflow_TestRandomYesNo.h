// MGetKV3ClassDefaults = {
//	"_class": "CPulseCell_Outflow_TestRandomYesNo",
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
