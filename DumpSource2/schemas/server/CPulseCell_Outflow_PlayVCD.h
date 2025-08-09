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
//	"m_vcdFilename": ""
//}
// MCellForDomain = "ServerEntity"
// MPulseCellMethodBindings (UNKNOWN FOR PARSER)
// MPulseCellOutflowHookInfo (UNKNOWN FOR PARSER)
// MPulseCellWithCustomDocNode
class CPulseCell_Outflow_PlayVCD : public CPulseCell_Outflow_PlaySceneBase
{
	CUtlString m_vcdFilename;
};
