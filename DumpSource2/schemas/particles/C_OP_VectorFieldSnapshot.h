class C_OP_VectorFieldSnapshot : public CParticleFunctionOperator
{
	int32 m_nControlPointNumber;
	ParticleAttributeIndex_t m_nAttributeToWrite;
	int32 m_nLocalSpaceCP;
	CPerParticleFloatInput m_flInterpolation;
	CPerParticleVecInput m_vecScale;
	float32 m_flBoundaryDampening;
	bool m_bSetVelocity;
	bool m_bLockToSurface;
	float32 m_flGridSpacing;
};
