// MGetKV3ClassDefaults = {
//	"m_PortName": "",
//	"m_nEditorNodeID": -1,
//	"m_RegisterMap":
//	{
//		"m_Inparams": null,
//		"m_Outparams": null
//	},
//	"m_CallMethodID": -1,
//	"m_nSrcChunk": -1,
//	"m_nSrcInstruction": -1
//}
class CPulse_CallInfo
{
	PulseSymbol_t m_PortName;
	PulseDocNodeID_t m_nEditorNodeID;
	PulseRegisterMap_t m_RegisterMap;
	PulseDocNodeID_t m_CallMethodID;
	PulseRuntimeChunkIndex_t m_nSrcChunk;
	int32 m_nSrcInstruction;
};
