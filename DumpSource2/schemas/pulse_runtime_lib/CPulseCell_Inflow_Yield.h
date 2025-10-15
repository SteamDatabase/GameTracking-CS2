// MGetKV3ClassDefaults = {
//	"_class": "CPulseCell_Inflow_Yield",
//	"m_nEditorNodeID": -1,
//	"m_UnyieldResume":
//	{
//		"m_SourceOutflowName": "",
//		"m_nDestChunk": -1,
//		"m_nInstruction": -1
//	}
//}
class CPulseCell_Inflow_Yield : public CPulseCell_BaseYieldingInflow
{
	CPulse_ResumePoint m_UnyieldResume;
};
