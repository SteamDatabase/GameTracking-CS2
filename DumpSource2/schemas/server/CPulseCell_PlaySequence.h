// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
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
