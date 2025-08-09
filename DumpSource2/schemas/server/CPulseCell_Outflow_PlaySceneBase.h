// MGetKV3ClassDefaults = {
//	"_class": "CPulseCell_Outflow_PlaySceneBase",
//	"m_nEditorNodeID": -1,
//	"m_OnFinished":
//	{
//		"m_SourceOutflowName": "",
//		"m_nDestChunk": -1,
//		"m_nInstruction": -1
//	},
//	"m_OnCanceled":
//	{
//		"m_SourceOutflowName": "",
//		"m_nDestChunk": -1,
//		"m_nInstruction": -1
//	},
//	"m_Triggers":
//	[
//	]
//}
class CPulseCell_Outflow_PlaySceneBase : public CPulseCell_BaseYieldingInflow
{
	CPulse_ResumePoint m_OnFinished;
	CPulse_ResumePoint m_OnCanceled;
	CUtlVector< CPulse_OutflowConnection > m_Triggers;
};
