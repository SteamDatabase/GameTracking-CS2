class C_INIT_RtEnvCull : public CParticleFunctionInitializer
{
	Vector m_vecTestDir;
	Vector m_vecTestNormal;
	bool m_bUseVelocity;
	bool m_bCullOnMiss;
	bool m_bLifeAdjust;
	char[128] m_RtEnvName;
	int32 m_nRTEnvCP;
	int32 m_nComponent;
};
