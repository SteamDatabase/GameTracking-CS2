class CAimMatrixUpdateNode : public CUnaryUpdateNode
{
	AimMatrixOpFixedSettings_t m_opFixedSettings;
	AnimVectorSource m_target;
	CAnimParamHandle m_paramIndex;
	HSequence m_hSequence;
	bool m_bResetChild;
	bool m_bLockWhenWaning;
}
