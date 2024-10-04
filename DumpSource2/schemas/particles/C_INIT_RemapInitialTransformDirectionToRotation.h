class C_INIT_RemapInitialTransformDirectionToRotation : public CParticleFunctionInitializer
{
	CParticleTransformInput m_TransformInput;
	ParticleAttributeIndex_t m_nFieldOutput;
	float32 m_flOffsetRot;
	int32 m_nComponent;
};
