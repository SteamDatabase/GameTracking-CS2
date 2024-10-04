class C_OP_SpringToVectorConstraint : public CParticleFunctionConstraint
{
	CPerParticleFloatInput m_flRestLength;
	CPerParticleFloatInput m_flMinDistance;
	CPerParticleFloatInput m_flMaxDistance;
	CPerParticleFloatInput m_flRestingLength;
	CPerParticleVecInput m_vecAnchorVector;
};
