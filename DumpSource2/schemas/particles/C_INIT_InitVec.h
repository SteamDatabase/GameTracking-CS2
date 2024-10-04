class C_INIT_InitVec : public CParticleFunctionInitializer
{
	CPerParticleVecInput m_InputValue;
	ParticleAttributeIndex_t m_nOutputField;
	ParticleSetMethod_t m_nSetMethod;
	bool m_bNormalizedOutput;
	bool m_bWritePreviousPosition;
};
