class C_INIT_CreateWithinSphereTransform : public CParticleFunctionInitializer
{
	CPerParticleFloatInput m_fRadiusMin;
	CPerParticleFloatInput m_fRadiusMax;
	CPerParticleVecInput m_vecDistanceBias;
	Vector m_vecDistanceBiasAbs;
	CParticleTransformInput m_TransformInput;
	CPerParticleFloatInput m_fSpeedMin;
	CPerParticleFloatInput m_fSpeedMax;
	float32 m_fSpeedRandExp;
	bool m_bLocalCoords;
	float32 m_flEndCPGrowthTime;
	CPerParticleVecInput m_LocalCoordinateSystemSpeedMin;
	CPerParticleVecInput m_LocalCoordinateSystemSpeedMax;
	ParticleAttributeIndex_t m_nFieldOutput;
	ParticleAttributeIndex_t m_nFieldVelocity;
};
