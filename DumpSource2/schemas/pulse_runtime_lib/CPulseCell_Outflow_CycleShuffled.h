// MGetKV3ClassDefaults = {
//	"_class": "CPulseCell_Outflow_CycleShuffled",
//	"m_nEditorNodeID": -1,
//	"m_Outputs":
//	[
//	]
//}
class CPulseCell_Outflow_CycleShuffled : public CPulseCell_BaseFlow
{
	CUtlVector< CPulse_OutflowConnection > m_Outputs;
};
