class C_OP_RopeSpringConstraint : public CParticleFunctionConstraint
{
	CParticleCollectionFloatInput m_flRestLength;
	CParticleCollectionFloatInput m_flMinDistance;
	CParticleCollectionFloatInput m_flMaxDistance;
	float32 m_flAdjustmentScale;
	CParticleCollectionFloatInput m_flInitialRestingLength;
};
