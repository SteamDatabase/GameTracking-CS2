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
// MPropertyFriendlyName = "Play Sequence"
// MPropertyDescription = "Play the specified animation sequence on a NON-ANIMGRAPH entity, and wait for it to complete."
class CPulseCell_PlaySequence : public CPulseCell_BaseYieldingInflow
{
	// MPropertyAttributeSuggestionName = "pulse_model_sequence_name"
	CUtlString m_SequenceName;
	PulseNodeDynamicOutflows_t m_PulseAnimEvents;
	CPulse_ResumePoint m_OnFinished;
	CPulse_ResumePoint m_OnCanceled;
};
