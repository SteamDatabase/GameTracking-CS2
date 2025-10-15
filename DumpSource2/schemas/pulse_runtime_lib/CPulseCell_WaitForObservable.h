// MGetKV3ClassDefaults = {
//	"_class": "CPulseCell_WaitForObservable",
//	"m_nEditorNodeID": -1,
//	"m_Condition":
//	{
//		"m_EvaluateConnection":
//		{
//			"m_SourceOutflowName": "",
//			"m_nDestChunk": -1,
//			"m_nInstruction": -1
//		},
//		"m_DependentObservableVars":
//		[
//		],
//		"m_DependentObservableBlackboardReferences":
//		[
//		]
//	},
//	"m_OnTrue":
//	{
//		"m_SourceOutflowName": "",
//		"m_nDestChunk": -1,
//		"m_nInstruction": -1
//	}
//}
// MPulseEditorHeaderIcon = "tools/images/pulse_editor/observable_variable_listener.png"
// MPropertyFriendlyName = "Wait For Observable Condition"
class CPulseCell_WaitForObservable : public CPulseCell_BaseYieldingInflow
{
	// MPropertyDescription = "Condition to evaluate when any of its dependent values change."
	PulseObservableBoolExpression_t m_Condition;
	CPulse_ResumePoint m_OnTrue;
};
