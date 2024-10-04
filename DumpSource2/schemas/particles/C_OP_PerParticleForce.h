class C_OP_PerParticleForce : public CParticleFunctionForce
{
	CPerParticleFloatInput m_flForceScale;
	CPerParticleVecInput m_vForce;
	int32 m_nCP;
};
