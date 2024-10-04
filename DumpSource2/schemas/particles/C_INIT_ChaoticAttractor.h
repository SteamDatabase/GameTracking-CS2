class C_INIT_ChaoticAttractor : public CParticleFunctionInitializer
{
	float32 m_flAParm;
	float32 m_flBParm;
	float32 m_flCParm;
	float32 m_flDParm;
	float32 m_flScale;
	float32 m_flSpeedMin;
	float32 m_flSpeedMax;
	int32 m_nBaseCP;
	bool m_bUniformSpeed;
};
