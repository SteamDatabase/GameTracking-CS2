class C_INIT_RandomVector : public CParticleFunctionInitializer
{
	Vector m_vecMin;
	Vector m_vecMax;
	ParticleAttributeIndex_t m_nFieldOutput;
	CRandomNumberGeneratorParameters m_randomnessParameters;
};
