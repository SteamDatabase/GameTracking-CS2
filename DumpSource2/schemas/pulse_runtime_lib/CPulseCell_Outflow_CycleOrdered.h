// MGetKV3ClassDefaults = {
//	"_class": "CPulseCell_Outflow_CycleOrdered",
//	"m_nEditorNodeID": -1,
//	"m_Outputs":
//	[
//	]
//}
// MCellForDomain = "BaseDomain"
// MPulseCellMethodBindings (UNKNOWN FOR PARSER)
// MPulseCellOutflowHookInfo (UNKNOWN FOR PARSER)
// MPulseCellWithCustomDocNode
class CPulseCell_Outflow_CycleOrdered : public CPulseCell_BaseFlow
{
	CUtlVector< CPulse_OutflowConnection > m_Outputs;
};
