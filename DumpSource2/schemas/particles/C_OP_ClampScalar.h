class C_OP_ClampScalar : public CParticleFunctionOperator
{
	ParticleAttributeIndex_t m_nFieldOutput;
	CPerParticleFloatInput m_flOutputMin;
	CPerParticleFloatInput m_flOutputMax;
};
