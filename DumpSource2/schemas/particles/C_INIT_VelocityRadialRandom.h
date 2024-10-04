class C_INIT_VelocityRadialRandom : public CParticleFunctionInitializer
{
	int32 m_nControlPointNumber;
	CPerParticleFloatInput m_fSpeedMin;
	CPerParticleFloatInput m_fSpeedMax;
	Vector m_vecLocalCoordinateSystemSpeedScale;
	bool m_bIgnoreDelta;
};
