class C_INIT_VelocityFromCP : public CParticleFunctionInitializer
{
	CParticleCollectionVecInput m_velocityInput;
	CParticleTransformInput m_transformInput;
	float32 m_flVelocityScale;
	bool m_bDirectionOnly;
};
