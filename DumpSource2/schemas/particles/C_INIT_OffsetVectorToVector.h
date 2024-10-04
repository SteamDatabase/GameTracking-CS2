class C_INIT_OffsetVectorToVector : public CParticleFunctionInitializer
{
	ParticleAttributeIndex_t m_nFieldInput;
	ParticleAttributeIndex_t m_nFieldOutput;
	Vector m_vecOutputMin;
	Vector m_vecOutputMax;
	CRandomNumberGeneratorParameters m_randomnessParameters;
};
