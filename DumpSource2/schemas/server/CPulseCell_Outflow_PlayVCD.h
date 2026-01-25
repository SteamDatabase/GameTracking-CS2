// MGetKV3ClassDefaults = {
//	"_class": "CPulseCell_Outflow_PlayVCD",
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
//	],
//	"m_hChoreoScene": "",
//	"m_OnPaused":
//	{
//		"m_SourceOutflowName": "",
//		"m_nDestChunk": -1,
//		"m_nInstruction": -1
//	},
//	"m_OnResumed":
//	{
//		"m_SourceOutflowName": "",
//		"m_nDestChunk": -1,
//		"m_nInstruction": -1
//	}
//}
class CPulseCell_Outflow_PlayVCD : public CPulseCell_Outflow_PlaySceneBase
{
	CStrongHandle< InfoForResourceTypeCChoreoSceneResource > m_hChoreoScene;
	CPulse_OutflowConnection m_OnPaused;
	CPulse_OutflowConnection m_OnResumed;
};
