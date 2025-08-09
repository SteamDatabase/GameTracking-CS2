// MGetKV3ClassDefaults = {
//	"m_nReg": -1,
//	"m_Type": "PVAL_VOID",
//	"m_OriginName": "",
//	"m_nWrittenByInstruction": -1,
//	"m_nLastReadByInstruction": -1
//}
class CPulse_RegisterInfo
{
	PulseRuntimeRegisterIndex_t m_nReg;
	CPulseValueFullType m_Type;
	CKV3MemberNameWithStorage m_OriginName;
	int32 m_nWrittenByInstruction;
	int32 m_nLastReadByInstruction;
};
