// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_INIT_MoveBetweenPoints : public CParticleFunctionInitializer
{
	// MPropertyFriendlyName = "minimum speed"
	CPerParticleFloatInput m_flSpeedMin;
	// MPropertyFriendlyName = "maximum speed"
	CPerParticleFloatInput m_flSpeedMax;
	// MPropertyFriendlyName = "end spread"
	CPerParticleFloatInput m_flEndSpread;
	// MPropertyFriendlyName = "start offset"
	CPerParticleFloatInput m_flStartOffset;
	// MPropertyFriendlyName = "end offset"
	CPerParticleFloatInput m_flEndOffset;
	// MPropertyFriendlyName = "end control point"
	int32 m_nEndControlPointNumber;
	// MPropertyFriendlyName = "bias lifetime by trail length"
	bool m_bTrailBias;
};
