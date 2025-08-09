// MGetKV3ClassDefaults = {
//	"_class": "CPulseCell_Test_MultiOutflow_WithParams",
//	"m_nEditorNodeID": -1,
//	"m_Out1":
//	{
//		"m_SourceOutflowName": "",
//		"m_nDestChunk": -1,
//		"m_nInstruction": -1
//	},
//	"m_Out2":
//	{
//		"m_SourceOutflowName": "",
//		"m_nDestChunk": -1,
//		"m_nInstruction": -1
//	}
//}
// MCellForDomain = "TestDomain"
// MPulseCellMethodBindings (UNKNOWN FOR PARSER)
// MPulseCellOutflowHookInfo (UNKNOWN FOR PARSER)
class CPulseCell_Test_MultiOutflow_WithParams : public CPulseCell_BaseFlow
{
	// MPulseCellOutflow_IsDefault
	SignatureOutflow_Continue m_Out1;
	SignatureOutflow_Continue m_Out2;
};
