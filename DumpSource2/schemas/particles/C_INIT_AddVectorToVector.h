class C_INIT_AddVectorToVector : public CParticleFunctionInitializer
{
	Vector m_vecScale;
	ParticleAttributeIndex_t m_nFieldOutput;
	ParticleAttributeIndex_t m_nFieldInput;
	Vector m_vOffsetMin;
	Vector m_vOffsetMax;
	CRandomNumberGeneratorParameters m_randomnessParameters;
};
