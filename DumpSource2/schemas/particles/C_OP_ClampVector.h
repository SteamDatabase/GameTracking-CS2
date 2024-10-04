class C_OP_ClampVector : public CParticleFunctionOperator
{
	ParticleAttributeIndex_t m_nFieldOutput;
	CPerParticleVecInput m_vecOutputMin;
	CPerParticleVecInput m_vecOutputMax;
};
