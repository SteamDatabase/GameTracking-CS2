// MGetKV3ClassDefaults = {
//	"m_nCode": "INVALID",
//	"m_nVar": -1,
//	"m_nReg0": -1,
//	"m_nReg1": -1,
//	"m_nReg2": -1,
//	"m_nInvokeBindingIndex": -1,
//	"m_nChunk": -1,
//	"m_nDestInstruction": 0,
//	"m_nCallInfoIndex": -1,
//	"m_nConstIdx": -1,
//	"m_nDomainValueIdx": -1,
//	"m_nBlackboardReferenceIdx": -1
//}
class PGDInstruction_t
{
	PulseInstructionCode_t m_nCode;
	PulseRuntimeVarIndex_t m_nVar;
	PulseRuntimeRegisterIndex_t m_nReg0;
	PulseRuntimeRegisterIndex_t m_nReg1;
	PulseRuntimeRegisterIndex_t m_nReg2;
	PulseRuntimeInvokeIndex_t m_nInvokeBindingIndex;
	PulseRuntimeChunkIndex_t m_nChunk;
	int32 m_nDestInstruction;
	PulseRuntimeCallInfoIndex_t m_nCallInfoIndex;
	PulseRuntimeConstantIndex_t m_nConstIdx;
	PulseRuntimeDomainValueIndex_t m_nDomainValueIdx;
	PulseRuntimeBlackboardReferenceIndex_t m_nBlackboardReferenceIdx;
};
