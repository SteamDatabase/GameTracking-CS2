class C_INIT_CreateInEpitrochoid : public CParticleFunctionInitializer
{
	int32 m_nComponent1;
	int32 m_nComponent2;
	CParticleTransformInput m_TransformInput;
	CPerParticleFloatInput m_flParticleDensity;
	CPerParticleFloatInput m_flOffset;
	CPerParticleFloatInput m_flRadius1;
	CPerParticleFloatInput m_flRadius2;
	bool m_bUseCount;
	bool m_bUseLocalCoords;
	bool m_bOffsetExistingPos;
};
