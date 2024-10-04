class C_OP_SetVec : public CParticleFunctionOperator
{
	CPerParticleVecInput m_InputValue;
	ParticleAttributeIndex_t m_nOutputField;
	ParticleSetMethod_t m_nSetMethod;
	CPerParticleFloatInput m_Lerp;
	bool m_bNormalizedOutput;
};
