class C_INIT_RingWave : public CParticleFunctionInitializer
{
	CParticleTransformInput m_TransformInput;
	CParticleCollectionFloatInput m_flParticlesPerOrbit;
	CPerParticleFloatInput m_flInitialRadius;
	CPerParticleFloatInput m_flThickness;
	CPerParticleFloatInput m_flInitialSpeedMin;
	CPerParticleFloatInput m_flInitialSpeedMax;
	CPerParticleFloatInput m_flRoll;
	CPerParticleFloatInput m_flPitch;
	CPerParticleFloatInput m_flYaw;
	bool m_bEvenDistribution;
	bool m_bXYVelocityOnly;
};
