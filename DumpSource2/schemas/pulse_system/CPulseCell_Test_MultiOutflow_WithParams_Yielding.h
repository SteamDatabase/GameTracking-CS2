// MGetKV3ClassDefaults = {
//	"_class": "CPulseCell_Test_MultiOutflow_WithParams_Yielding",
//	"m_nEditorNodeID": -1,
//	"m_Out1":
//	{
//		"m_SourceOutflowName": "",
//		"m_nDestChunk": -1,
//		"m_nInstruction": -1
//	},
//	"m_AsyncChild1":
//	{
//		"m_SourceOutflowName": "",
//		"m_nDestChunk": -1,
//		"m_nInstruction": -1
//	},
//	"m_AsyncChild2":
//	{
//		"m_SourceOutflowName": "",
//		"m_nDestChunk": -1,
//		"m_nInstruction": -1
//	},
//	"m_YieldResume1":
//	{
//		"m_SourceOutflowName": "",
//		"m_nDestChunk": -1,
//		"m_nInstruction": -1
//	},
//	"m_YieldResume2":
//	{
//		"m_SourceOutflowName": "",
//		"m_nDestChunk": -1,
//		"m_nInstruction": -1
//	}
//}
// MCellForDomain = "TestDomain"
// MPulseCellMethodBindings (UNKNOWN FOR PARSER)
// MPulseCellOutflowHookInfo (UNKNOWN FOR PARSER)
class CPulseCell_Test_MultiOutflow_WithParams_Yielding : public CPulseCell_BaseYieldingInflow
{
	// MPulseCellOutflow_IsDefault
	SignatureOutflow_Continue m_Out1;
	SignatureOutflow_Continue m_AsyncChild1;
	SignatureOutflow_Continue m_AsyncChild2;
	SignatureOutflow_Resume m_YieldResume1;
	SignatureOutflow_Resume m_YieldResume2;
};
