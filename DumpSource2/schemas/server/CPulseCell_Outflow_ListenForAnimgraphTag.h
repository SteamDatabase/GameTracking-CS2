// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
// MCellForDomain = "ServerEntity"
// MPulseCellMethodBindings (UNKNOWN FOR PARSER)
// MPulseCellOutflowHookInfo (UNKNOWN FOR PARSER)
// MPropertyFriendlyName = "Listen for AnimGraph Tag"
// MPropertyDescription = "Creates new cursors for when an animgraph tag is handled. Will listen until canceled."
// MPulseEditorSubHeaderText (UNKNOWN FOR PARSER)
class CPulseCell_Outflow_ListenForAnimgraphTag : public CPulseCell_BaseYieldingInflow
{
	// MPulseCellOutflow_IsDefault
	CPulse_ResumePoint m_OnStart;
	CPulse_ResumePoint m_OnEnd;
	CPulse_ResumePoint m_OnCanceled;
	// MPropertyAttributeEditor = "AnimGraphTag()"
	CGlobalSymbol m_TagName;
};
