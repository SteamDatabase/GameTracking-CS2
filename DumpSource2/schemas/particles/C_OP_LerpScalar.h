class C_OP_LerpScalar : public CParticleFunctionOperator
{
	ParticleAttributeIndex_t m_nFieldOutput;
	CPerParticleFloatInput m_flOutput;
	float32 m_flStartTime;
	float32 m_flEndTime;
};
