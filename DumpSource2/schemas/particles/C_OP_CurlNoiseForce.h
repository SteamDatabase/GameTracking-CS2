class C_OP_CurlNoiseForce : public CParticleFunctionForce
{
	ParticleDirectionNoiseType_t m_nNoiseType;
	CPerParticleVecInput m_vecNoiseFreq;
	CPerParticleVecInput m_vecNoiseScale;
	CPerParticleVecInput m_vecOffset;
	CPerParticleVecInput m_vecOffsetRate;
	CPerParticleFloatInput m_flWorleySeed;
	CPerParticleFloatInput m_flWorleyJitter;
};
