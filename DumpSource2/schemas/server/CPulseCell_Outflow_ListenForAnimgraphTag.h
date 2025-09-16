// MGetKV3ClassDefaults = {
//	"_class": "CPulseCell_Outflow_ListenForAnimgraphTag",
//	"m_nEditorNodeID": -1,
//	"m_OnStart":
//	{
//		"m_SourceOutflowName": "",
//		"m_nDestChunk": -1,
//		"m_nInstruction": -1
//	},
//	"m_OnEnd":
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
//	"m_TagName": ""
//}
// MPulseCellMethodBindings (UNKNOWN FOR PARSER)
// MPropertyFriendlyName = "Listen for AnimGraph Tag"
// MPropertyDescription = "Creates new cursors for when an animgraph tag is handled. Will listen until canceled."
// MPulseEditorSubHeaderText (UNKNOWN FOR PARSER)
class CPulseCell_Outflow_ListenForAnimgraphTag : public CPulseCell_BaseYieldingInflow
{
	CPulse_ResumePoint m_OnStart;
	CPulse_ResumePoint m_OnEnd;
	CPulse_ResumePoint m_OnCanceled;
	// MPropertyAttributeEditor = "AnimGraphTag()"
	CGlobalSymbol m_TagName;
};
