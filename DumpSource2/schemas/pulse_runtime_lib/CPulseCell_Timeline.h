// MGetKV3ClassDefaults = {
//	"_class": "CPulseCell_Timeline",
//	"m_nEditorNodeID": -1,
//	"m_TimelineEvents":
//	[
//	],
//	"m_bWaitForChildOutflows": true,
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
//	}
//}
class CPulseCell_Timeline : public CPulseCell_BaseYieldingInflow
{
	CUtlVector< CPulseCell_Timeline::TimelineEvent_t > m_TimelineEvents;
	bool m_bWaitForChildOutflows;
	CPulse_ResumePoint m_OnFinished;
	CPulse_ResumePoint m_OnCanceled;
};
