class C_OP_Noise : public CParticleFunctionOperator
{
	ParticleAttributeIndex_t m_nFieldOutput;
	float32 m_flOutputMin;
	float32 m_flOutputMax;
	float32 m_fl4NoiseScale;
	bool m_bAdditive;
	float32 m_flNoiseAnimationTimeScale;
};
