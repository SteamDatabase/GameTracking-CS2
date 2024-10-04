class C_INIT_PositionOffset : public CParticleFunctionInitializer
{
	CPerParticleVecInput m_OffsetMin;
	CPerParticleVecInput m_OffsetMax;
	CParticleTransformInput m_TransformInput;
	bool m_bLocalCoords;
	bool m_bProportional;
	CRandomNumberGeneratorParameters m_randomnessParameters;
};
