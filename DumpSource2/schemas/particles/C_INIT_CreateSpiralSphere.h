class C_INIT_CreateSpiralSphere : public CParticleFunctionInitializer
{
	int32 m_nControlPointNumber;
	int32 m_nOverrideCP;
	int32 m_nDensity;
	float32 m_flInitialRadius;
	float32 m_flInitialSpeedMin;
	float32 m_flInitialSpeedMax;
	bool m_bUseParticleCount;
};
