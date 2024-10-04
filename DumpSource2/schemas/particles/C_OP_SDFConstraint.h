class C_OP_SDFConstraint : public CParticleFunctionConstraint
{
	CParticleCollectionFloatInput m_flMinDist;
	CParticleCollectionFloatInput m_flMaxDist;
	int32 m_nMaxIterations;
};
