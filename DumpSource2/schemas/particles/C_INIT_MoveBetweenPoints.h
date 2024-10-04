class C_INIT_MoveBetweenPoints : public CParticleFunctionInitializer
{
	CPerParticleFloatInput m_flSpeedMin;
	CPerParticleFloatInput m_flSpeedMax;
	CPerParticleFloatInput m_flEndSpread;
	CPerParticleFloatInput m_flStartOffset;
	CPerParticleFloatInput m_flEndOffset;
	int32 m_nEndControlPointNumber;
	bool m_bTrailBias;
};
