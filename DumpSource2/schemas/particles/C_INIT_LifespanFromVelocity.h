class C_INIT_LifespanFromVelocity : public CParticleFunctionInitializer
{
	Vector m_vecComponentScale;
	float32 m_flTraceOffset;
	float32 m_flMaxTraceLength;
	float32 m_flTraceTolerance;
	int32 m_nMaxPlanes;
	char[128] m_CollisionGroupName;
	ParticleTraceSet_t m_nTraceSet;
	bool m_bIncludeWater;
};
