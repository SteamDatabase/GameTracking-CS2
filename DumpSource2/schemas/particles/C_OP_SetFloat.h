class C_OP_SetFloat : public CParticleFunctionOperator
{
	CPerParticleFloatInput m_InputValue;
	ParticleAttributeIndex_t m_nOutputField;
	ParticleSetMethod_t m_nSetMethod;
	CPerParticleFloatInput m_Lerp;
};
