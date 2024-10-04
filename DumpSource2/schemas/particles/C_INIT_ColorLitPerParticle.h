class C_INIT_ColorLitPerParticle : public CParticleFunctionInitializer
{
	Color m_ColorMin;
	Color m_ColorMax;
	Color m_TintMin;
	Color m_TintMax;
	float32 m_flTintPerc;
	ParticleColorBlendMode_t m_nTintBlendMode;
	float32 m_flLightAmplification;
};
