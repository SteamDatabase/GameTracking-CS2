class CPulse_RegisterInfo
{
	PulseRuntimeRegisterIndex_t m_nReg;
	CPulseValueFullType m_Type;
	CKV3MemberNameWithStorage m_OriginName;
	int32 m_nWrittenByInstruction;
	int32 m_nLastReadByInstruction;
};
