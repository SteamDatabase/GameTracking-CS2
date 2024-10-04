class C_INIT_DistanceToCPInit : public CParticleFunctionInitializer
{
	ParticleAttributeIndex_t m_nFieldOutput;
	CPerParticleFloatInput m_flInputMin;
	CPerParticleFloatInput m_flInputMax;
	CPerParticleFloatInput m_flOutputMin;
	CPerParticleFloatInput m_flOutputMax;
	int32 m_nStartCP;
	bool m_bLOS;
	char[128] m_CollisionGroupName;
	ParticleTraceSet_t m_nTraceSet;
	CPerParticleFloatInput m_flMaxTraceLength;
	float32 m_flLOSScale;
	ParticleSetMethod_t m_nSetMethod;
	bool m_bActiveRange;
	Vector m_vecDistanceScale;
	float32 m_flRemapBias;
};
