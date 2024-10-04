class C_INIT_InitialRepulsionVelocity : public CParticleFunctionInitializer
{
	char[128] m_CollisionGroupName;
	ParticleTraceSet_t m_nTraceSet;
	Vector m_vecOutputMin;
	Vector m_vecOutputMax;
	int32 m_nControlPointNumber;
	bool m_bPerParticle;
	bool m_bTranslate;
	bool m_bProportional;
	float32 m_flTraceLength;
	bool m_bPerParticleTR;
	bool m_bInherit;
	int32 m_nChildCP;
	int32 m_nChildGroupID;
};
