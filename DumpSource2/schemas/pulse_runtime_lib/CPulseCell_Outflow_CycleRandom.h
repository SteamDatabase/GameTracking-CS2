// MGetKV3ClassDefaults = {
//	"_class": "CPulseCell_Outflow_CycleRandom",
//	"m_nEditorNodeID": -1,
//	"m_Outputs":
//	[
//	]
//}
class CPulseCell_Outflow_CycleRandom : public CPulseCell_BaseFlow
{
	CUtlVector< CPulse_OutflowConnection > m_Outputs;
};
