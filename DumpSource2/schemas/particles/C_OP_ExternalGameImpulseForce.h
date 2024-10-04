class C_OP_ExternalGameImpulseForce : public CParticleFunctionForce
{
	CPerParticleFloatInput m_flForceScale;
	bool m_bRopes;
	bool m_bRopesZOnly;
	bool m_bExplosions;
	bool m_bParticles;
};
