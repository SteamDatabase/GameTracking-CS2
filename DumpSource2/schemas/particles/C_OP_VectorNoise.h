class C_OP_VectorNoise : public CParticleFunctionOperator
{
	ParticleAttributeIndex_t m_nFieldOutput;
	Vector m_vecOutputMin;
	Vector m_vecOutputMax;
	float32 m_fl4NoiseScale;
	bool m_bAdditive;
	bool m_bOffset;
	float32 m_flNoiseAnimationTimeScale;
};
