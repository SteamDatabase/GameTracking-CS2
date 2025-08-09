// MGetKV3ClassDefaults = {
//	"_class": "CPulseCell_Outflow_IntSwitch",
//	"m_nEditorNodeID": -1,
//	"m_DefaultCaseOutflow":
//	{
//		"m_SourceOutflowName": "",
//		"m_nDestChunk": -1,
//		"m_nInstruction": -1
//	},
//	"m_CaseOutflows":
//	[
//	]
//}
// MCellForDomain = "BaseDomain"
// MPulseCellMethodBindings (UNKNOWN FOR PARSER)
// MPulseCellOutflowHookInfo (UNKNOWN FOR PARSER)
// MPulseCellWithCustomDocNode
class CPulseCell_Outflow_IntSwitch : public CPulseCell_BaseFlow
{
	CPulse_OutflowConnection m_DefaultCaseOutflow;
	CUtlVector< CPulse_OutflowConnection > m_CaseOutflows;
};
