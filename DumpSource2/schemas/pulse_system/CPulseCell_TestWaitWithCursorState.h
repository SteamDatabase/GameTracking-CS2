// MGetKV3ClassDefaults = {
//	"_class": "CPulseCell_TestWaitWithCursorState",
//	"m_nEditorNodeID": -1,
//	"m_WakeResume":
//	{
//		"m_SourceOutflowName": "",
//		"m_nDestChunk": -1,
//		"m_nInstruction": -1
//	},
//	"m_WakeCancel":
//	{
//		"m_SourceOutflowName": "",
//		"m_nDestChunk": -1,
//		"m_nInstruction": -1
//	},
//	"m_WakeFail":
//	{
//		"m_SourceOutflowName": "",
//		"m_nDestChunk": -1,
//		"m_nInstruction": -1
//	}
//}
class CPulseCell_TestWaitWithCursorState : public CPulseCell_BaseYieldingInflow
{
	CPulse_ResumePoint m_WakeResume;
	CPulse_ResumePoint m_WakeCancel;
	CPulse_ResumePoint m_WakeFail;
};
