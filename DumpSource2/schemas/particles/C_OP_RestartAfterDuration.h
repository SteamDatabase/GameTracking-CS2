class C_OP_RestartAfterDuration : public CParticleFunctionOperator
{
	float32 m_flDurationMin;
	float32 m_flDurationMax;
	int32 m_nCP;
	int32 m_nCPField;
	int32 m_nChildGroupID;
	bool m_bOnlyChildren;
};
