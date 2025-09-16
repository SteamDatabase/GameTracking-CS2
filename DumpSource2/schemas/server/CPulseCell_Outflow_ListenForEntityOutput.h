// MGetKV3ClassDefaults = {
//	"_class": "CPulseCell_Outflow_ListenForEntityOutput",
//	"m_nEditorNodeID": -1,
//	"m_OnFired":
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
//	"m_strEntityOutput": "",
//	"m_strEntityOutputParam": "",
//	"m_bListenUntilCanceled": false
//}
// MPulseCellMethodBindings (UNKNOWN FOR PARSER)
// MPropertyFriendlyName = "Wait for Entity Output"
// MPropertyDescription = "Waits for the entity to fire a specific output. By default, this listens once, but can be configured to listen until canceled."
// MPulseEditorSubHeaderText (UNKNOWN FOR PARSER)
// MPulseEditorHeaderIcon = "tools/images/pulse_editor/inflow_wait.png"
class CPulseCell_Outflow_ListenForEntityOutput : public CPulseCell_BaseYieldingInflow
{
	SignatureOutflow_Resume m_OnFired;
	CPulse_ResumePoint m_OnCanceled;
	CGlobalSymbol m_strEntityOutput;
	// MPropertyDescription = "Optional output value to match if applicable. Leave empty to match any possible value for the output param."
	CUtlString m_strEntityOutputParam;
	// MPropertyDescription = "Continue listening for the output until canceled."
	bool m_bListenUntilCanceled;
};
