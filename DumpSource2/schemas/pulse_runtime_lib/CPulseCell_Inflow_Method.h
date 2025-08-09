// MGetKV3ClassDefaults = {
//	"_class": "CPulseCell_Inflow_Method",
//	"m_nEditorNodeID": -1,
//	"m_EntryChunk": -1,
//	"m_RegisterMap":
//	{
//		"m_Inparams": null,
//		"m_Outparams": null
//	},
//	"m_MethodName": "",
//	"m_Description": "",
//	"m_bIsPublic": false,
//	"m_ReturnType": "PVAL_VOID",
//	"m_Args":
//	[
//	]
//}
// MCellForDomain = "BaseDomain"
// MPulseCellMethodBindings (UNKNOWN FOR PARSER)
// MPulseCellOutflowHookInfo (UNKNOWN FOR PARSER)
// MPulseCellWithCustomDocNode
class CPulseCell_Inflow_Method : public CPulseCell_Inflow_BaseEntrypoint
{
	PulseSymbol_t m_MethodName;
	CUtlString m_Description;
	bool m_bIsPublic;
	CPulseValueFullType m_ReturnType;
	CUtlLeanVector< CPulseRuntimeMethodArg > m_Args;
};
