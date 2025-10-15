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
//	"m_hChoreoScene": ""
//}
class CPulseCell_Outflow_PlayVCD : public CPulseCell_Outflow_PlaySceneBase
{
	CStrongHandle< InfoForResourceTypeCChoreoSceneResource > m_hChoreoScene;
};
