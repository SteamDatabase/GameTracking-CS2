class C_OP_LerpToInitialPosition : public CParticleFunctionOperator
{
	int32 m_nControlPointNumber;
	CPerParticleFloatInput m_flInterpolation;
	ParticleAttributeIndex_t m_nCacheField;
	CParticleCollectionFloatInput m_flScale;
	CParticleCollectionVecInput m_vecScale;
};
