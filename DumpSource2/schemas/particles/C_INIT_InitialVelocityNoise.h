class C_INIT_InitialVelocityNoise : public CParticleFunctionInitializer
{
	Vector m_vecAbsVal;
	Vector m_vecAbsValInv;
	CPerParticleVecInput m_vecOffsetLoc;
	CPerParticleFloatInput m_flOffset;
	CPerParticleVecInput m_vecOutputMin;
	CPerParticleVecInput m_vecOutputMax;
	CPerParticleFloatInput m_flNoiseScale;
	CPerParticleFloatInput m_flNoiseScaleLoc;
	CParticleTransformInput m_TransformInput;
	bool m_bIgnoreDt;
};
