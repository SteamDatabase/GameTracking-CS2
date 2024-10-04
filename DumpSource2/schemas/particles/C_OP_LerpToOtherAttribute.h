class C_OP_LerpToOtherAttribute : public CParticleFunctionOperator
{
	CPerParticleFloatInput m_flInterpolation;
	ParticleAttributeIndex_t m_nFieldInputFrom;
	ParticleAttributeIndex_t m_nFieldInput;
	ParticleAttributeIndex_t m_nFieldOutput;
};
