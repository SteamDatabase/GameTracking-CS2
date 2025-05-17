// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_CurlNoiseForce : public CParticleFunctionForce
{
	// MPropertyFriendlyName = "noise type"
	ParticleDirectionNoiseType_t m_nNoiseType;
	// MPropertyFriendlyName = "noise frequency"
	// MVectorIsCoordinate
	CPerParticleVecInput m_vecNoiseFreq;
	// MPropertyFriendlyName = "noise amplitude"
	// MVectorIsCoordinate
	CPerParticleVecInput m_vecNoiseScale;
	// MPropertyFriendlyName = "offset"
	// MVectorIsCoordinate
	CPerParticleVecInput m_vecOffset;
	// MPropertyFriendlyName = "offset rate"
	// MVectorIsCoordinate
	CPerParticleVecInput m_vecOffsetRate;
	// MPropertyFriendlyName = "worley seed"
	CPerParticleFloatInput m_flWorleySeed;
	// MPropertyFriendlyName = "worley jitter"
	CPerParticleFloatInput m_flWorleyJitter;
};
