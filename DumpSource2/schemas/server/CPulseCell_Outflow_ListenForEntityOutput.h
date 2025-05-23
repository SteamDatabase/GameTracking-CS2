// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
// MCellForDomain = "ServerPointEntity"
// MPulseCellMethodBindings (UNKNOWN FOR PARSER)
// MPulseCellOutflowHookInfo (UNKNOWN FOR PARSER)
// MPropertyFriendlyName = "Listen for Entity Output"
// MPropertyDescription = "Waits for the entity to fire a specific output. By default, this listens once, but can be configured to listen until canceled."
// MPulseEditorSubHeaderText (UNKNOWN FOR PARSER)
// MPulseEditorHeaderIcon = "tools/images/pulse_editor/eio_output_link.png"
class CPulseCell_Outflow_ListenForEntityOutput : public CPulseCell_BaseYieldingInflow
{
	// MPulseCellOutflow_IsDefault
	// MPulseSignatureName (UNKNOWN FOR PARSER)
	SignatureOutflow_Resume m_OnFired;
	CPulse_ResumePoint m_OnCanceled;
	// MPulseDocCustomAttr (UNKNOWN FOR PARSER)
	CGlobalSymbol m_strEntityOutput;
	// MPropertyDescription = "Optional output value to match if applicable. Leave empty to match any possible value for the output param."
	CUtlString m_strEntityOutputParam;
	// MPropertyDescription = "Continue listening for the output until canceled."
	bool m_bListenUntilCanceled;
};
