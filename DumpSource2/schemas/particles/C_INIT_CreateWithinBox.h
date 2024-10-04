class C_INIT_CreateWithinBox : public CParticleFunctionInitializer
{
	CPerParticleVecInput m_vecMin;
	CPerParticleVecInput m_vecMax;
	int32 m_nControlPointNumber;
	bool m_bLocalSpace;
	CRandomNumberGeneratorParameters m_randomnessParameters;
};
