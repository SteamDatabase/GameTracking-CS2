class C_INIT_RandomColor : public CParticleFunctionInitializer
{
	Color m_ColorMin;
	Color m_ColorMax;
	Color m_TintMin;
	Color m_TintMax;
	float32 m_flTintPerc;
	float32 m_flUpdateThreshold;
	int32 m_nTintCP;
	ParticleAttributeIndex_t m_nFieldOutput;
	ParticleColorBlendMode_t m_nTintBlendMode;
	float32 m_flLightAmplification;
};
