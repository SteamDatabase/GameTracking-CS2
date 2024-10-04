class C_INIT_InitFromVectorFieldSnapshot : public CParticleFunctionInitializer
{
	int32 m_nControlPointNumber;
	int32 m_nLocalSpaceCP;
	int32 m_nWeightUpdateCP;
	bool m_bUseVerticalVelocity;
	CPerParticleVecInput m_vecScale;
};
