// MGetKV3ClassDefaults = {
//	"_class": "CPulseCell_CursorQueue",
//	"m_nEditorNodeID": -1,
//	"m_nCursorsAllowedToWait": -1,
//	"m_WaitComplete":
//	{
//		"m_SourceOutflowName": "",
//		"m_nDestChunk": -1,
//		"m_nInstruction": -1
//	},
//	"m_nCursorsAllowedToRunParallel": 1
//}
// MCellForDomain = "BaseDomain"
// MPulseCellMethodBindings (UNKNOWN FOR PARSER)
// MPulseCellOutflowHookInfo (UNKNOWN FOR PARSER)
// MPropertyFriendlyName = "Cursor Queue"
// MPropertyDescription = "Causes each execution cursor to wait for the completion of all prior cursors that have visited this node. Use this to safely support multiple triggers to areas of the graph that take time to complete."
// MPulseEditorHeaderIcon = "tools/images/pulse_editor/cursor_wait_zone.png"
class CPulseCell_CursorQueue : public CPulseCell_WaitForCursorsWithTagBase
{
	// MPropertyDescription = "Any cursors above this count will wait, up to the limit."
	int32 m_nCursorsAllowedToRunParallel;
};
