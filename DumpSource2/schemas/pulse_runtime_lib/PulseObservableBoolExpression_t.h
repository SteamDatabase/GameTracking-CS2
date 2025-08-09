// MGetKV3ClassDefaults = {
//	"m_EvaluateConnection":
//	{
//		"m_SourceOutflowName": "",
//		"m_nDestChunk": -1,
//		"m_nInstruction": -1
//	},
//	"m_DependentObservableVars":
//	[
//	],
//	"m_DependentObservableBlackboardReferences":
//	[
//	]
//}
class PulseObservableBoolExpression_t
{
	CPulse_OutflowConnection m_EvaluateConnection;
	CUtlVector< PulseRuntimeVarIndex_t > m_DependentObservableVars;
	CUtlVector< PulseRuntimeBlackboardReferenceIndex_t > m_DependentObservableBlackboardReferences;
};
