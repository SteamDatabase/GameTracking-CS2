class C_OP_RemapVectorComponentToScalar : public CParticleFunctionOperator
{
	ParticleAttributeIndex_t m_nFieldInput;
	ParticleAttributeIndex_t m_nFieldOutput;
	int32 m_nComponent;
};
