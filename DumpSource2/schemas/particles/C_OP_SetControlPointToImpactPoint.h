class C_OP_SetControlPointToImpactPoint : public CParticleFunctionPreEmission
{
	int32 m_nCPOut;
	int32 m_nCPIn;
	float32 m_flUpdateRate;
	CParticleCollectionFloatInput m_flTraceLength;
	float32 m_flStartOffset;
	float32 m_flOffset;
	Vector m_vecTraceDir;
	char[128] m_CollisionGroupName;
	ParticleTraceSet_t m_nTraceSet;
	bool m_bSetToEndpoint;
	bool m_bTraceToClosestSurface;
	bool m_bIncludeWater;
};
