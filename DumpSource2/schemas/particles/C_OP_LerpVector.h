class C_OP_LerpVector : public CParticleFunctionOperator
{
	ParticleAttributeIndex_t m_nFieldOutput;
	Vector m_vecOutput;
	float32 m_flStartTime;
	float32 m_flEndTime;
	ParticleSetMethod_t m_nSetMethod;
};
