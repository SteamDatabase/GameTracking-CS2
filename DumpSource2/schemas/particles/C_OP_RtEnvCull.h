class C_OP_RtEnvCull : public CParticleFunctionOperator
{
	Vector m_vecTestDir;
	Vector m_vecTestNormal;
	bool m_bCullOnMiss;
	bool m_bStickInsteadOfCull;
	char[128] m_RtEnvName;
	int32 m_nRTEnvCP;
	int32 m_nComponent;
};
