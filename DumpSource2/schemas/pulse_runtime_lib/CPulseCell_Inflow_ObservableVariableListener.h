// MGetKV3ClassDefaults = {
//	"_class": "CPulseCell_Inflow_ObservableVariableListener",
//	"m_nEditorNodeID": -1,
//	"m_EntryChunk": -1,
//	"m_RegisterMap":
//	{
//		"m_Inparams": null,
//		"m_Outparams": null
//	},
//	"m_nBlackboardReference": -1,
//	"m_bSelfReference": false
//}
// MCellForDomain = "BaseDomain"
// MPulseCellMethodBindings (UNKNOWN FOR PARSER)
// MPulseCellOutflowHookInfo (UNKNOWN FOR PARSER)
// MPulseCellWithCustomDocNode
class CPulseCell_Inflow_ObservableVariableListener : public CPulseCell_Inflow_BaseEntrypoint
{
	PulseRuntimeBlackboardReferenceIndex_t m_nBlackboardReference;
	bool m_bSelfReference;
};
