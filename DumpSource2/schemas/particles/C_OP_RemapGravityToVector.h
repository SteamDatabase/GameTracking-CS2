class C_OP_RemapGravityToVector : public CParticleFunctionOperator
{
	CPerParticleVecInput m_vInput1;
	ParticleAttributeIndex_t m_nOutputField;
	ParticleSetMethod_t m_nSetMethod;
	bool m_bNormalizedOutput;
};
