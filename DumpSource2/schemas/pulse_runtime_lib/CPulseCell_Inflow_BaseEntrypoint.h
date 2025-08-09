// MGetKV3ClassDefaults = {
//	"_class": "CPulseCell_Inflow_BaseEntrypoint",
//	"m_nEditorNodeID": -1,
//	"m_EntryChunk": -1,
//	"m_RegisterMap":
//	{
//		"m_Inparams": null,
//		"m_Outparams": null
//	}
//}
class CPulseCell_Inflow_BaseEntrypoint : public CPulseCell_BaseFlow
{
	PulseRuntimeChunkIndex_t m_EntryChunk;
	PulseRegisterMap_t m_RegisterMap;
};
