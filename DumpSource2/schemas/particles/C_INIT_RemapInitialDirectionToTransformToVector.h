class C_INIT_RemapInitialDirectionToTransformToVector : public CParticleFunctionInitializer
{
	CParticleTransformInput m_TransformInput;
	ParticleAttributeIndex_t m_nFieldOutput;
	float32 m_flScale;
	float32 m_flOffsetRot;
	Vector m_vecOffsetAxis;
	bool m_bNormalize;
};
