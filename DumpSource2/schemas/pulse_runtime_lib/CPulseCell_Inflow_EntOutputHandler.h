// MGetKV3ClassDefaults = {
//	"_class": "CPulseCell_Inflow_EntOutputHandler",
//	"m_nEditorNodeID": -1,
//	"m_EntryChunk": -1,
//	"m_RegisterMap":
//	{
//		"m_Inparams": null,
//		"m_Outparams": null
//	},
//	"m_SourceEntity": "",
//	"m_SourceOutput": "",
//	"m_ExpectedParamType": "PVAL_VOID"
//}
class CPulseCell_Inflow_EntOutputHandler : public CPulseCell_Inflow_BaseEntrypoint
{
	PulseSymbol_t m_SourceEntity;
	PulseSymbol_t m_SourceOutput;
	CPulseValueFullType m_ExpectedParamType;
};
