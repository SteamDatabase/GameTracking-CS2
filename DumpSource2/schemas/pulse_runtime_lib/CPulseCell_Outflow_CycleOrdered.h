// MGetKV3ClassDefaults = {
//	"_class": "CPulseCell_Outflow_CycleOrdered",
//	"m_nEditorNodeID": -1,
//	"m_Outputs":
//	[
//	]
//}
class CPulseCell_Outflow_CycleOrdered : public CPulseCell_BaseFlow
{
	CUtlVector< CPulse_OutflowConnection > m_Outputs;
};
