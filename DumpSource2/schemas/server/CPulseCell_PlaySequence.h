// MGetKV3ClassDefaults = {
//	"_class": "CPulseCell_PlaySequence",
//	"m_nEditorNodeID": -1,
//	"m_SequenceName": "",
//	"m_PulseAnimEvents":
//	{
//		"m_Outflows":
//		[
//		]
//	},
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
// MPulseProvideFeatureTag (UNKNOWN FOR PARSER)
// MPropertyFriendlyName = "Play Sequence"
// MPropertyDescription = "Play the specified animation sequence on a NON-ANIMGRAPH entity, and wait for it to complete."
class CPulseCell_PlaySequence : public CPulseCell_BaseYieldingInflow
{
	// MPropertyAttributeSuggestionName = "pulse_model_sequence_name"
	CUtlString m_SequenceName;
	// MPulseDocCustomAttr (UNKNOWN FOR PARSER)
	PulseNodeDynamicOutflows_t m_PulseAnimEvents;
	// MPulseCellOutflow_IsDefault
	CPulse_ResumePoint m_OnFinished;
	CPulse_ResumePoint m_OnCanceled;
};
