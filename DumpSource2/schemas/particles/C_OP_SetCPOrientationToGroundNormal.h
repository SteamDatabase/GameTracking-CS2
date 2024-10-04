class C_OP_SetCPOrientationToGroundNormal : public CParticleFunctionOperator
{
	float32 m_flInterpRate;
	float32 m_flMaxTraceLength;
	float32 m_flTolerance;
	float32 m_flTraceOffset;
	char[128] m_CollisionGroupName;
	ParticleTraceSet_t m_nTraceSet;
	int32 m_nInputCP;
	int32 m_nOutputCP;
	bool m_bIncludeWater;
};
