class C_INIT_RemapSpeedToScalar : public CParticleFunctionInitializer
{
	ParticleAttributeIndex_t m_nFieldOutput;
	int32 m_nControlPointNumber;
	float32 m_flStartTime;
	float32 m_flEndTime;
	float32 m_flInputMin;
	float32 m_flInputMax;
	float32 m_flOutputMin;
	float32 m_flOutputMax;
	ParticleSetMethod_t m_nSetMethod;
	bool m_bPerParticle;
};
