// MGetKV3ClassDefaults = {
//	"_class": "CPulseCell_FireCursors",
//	"m_nEditorNodeID": -1,
//	"m_Outflows":
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
// MCellForDomain = "BaseDomain"
// MPulseCellMethodBindings (UNKNOWN FOR PARSER)
// MPulseCellOutflowHookInfo (UNKNOWN FOR PARSER)
// MPulseCellWithCustomDocNode
class CPulseCell_FireCursors : public CPulseCell_BaseYieldingInflow
{
	CUtlVector< CPulse_OutflowConnection > m_Outflows;
	bool m_bWaitForChildOutflows;
	CPulse_ResumePoint m_OnFinished;
	CPulse_ResumePoint m_OnCanceled;
};
