class C_INIT_VelocityRandom : public CParticleFunctionInitializer
{
	int32 m_nControlPointNumber;
	CPerParticleFloatInput m_fSpeedMin;
	CPerParticleFloatInput m_fSpeedMax;
	CPerParticleVecInput m_LocalCoordinateSystemSpeedMin;
	CPerParticleVecInput m_LocalCoordinateSystemSpeedMax;
	bool m_bIgnoreDT;
	CRandomNumberGeneratorParameters m_randomnessParameters;
};
