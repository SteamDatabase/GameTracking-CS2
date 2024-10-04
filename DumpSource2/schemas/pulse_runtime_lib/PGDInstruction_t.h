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
}
