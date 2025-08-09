// MGetKV3ClassDefaults = {
//	"_class": "CPulseCell_Outflow_CycleShuffled",
//	"m_nEditorNodeID": -1,
//	"m_Outputs":
//	[
//	]
//}
// MCellForDomain = "BaseDomain"
// MPulseCellMethodBindings (UNKNOWN FOR PARSER)
// MPulseCellOutflowHookInfo (UNKNOWN FOR PARSER)
// MPulseCellWithCustomDocNode
class CPulseCell_Outflow_CycleShuffled : public CPulseCell_BaseFlow
{
	CUtlVector< CPulse_OutflowConnection > m_Outputs;
};
