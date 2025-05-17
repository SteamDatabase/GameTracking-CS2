// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_INIT_RandomAlpha : public CParticleFunctionInitializer
{
	// MPropertyFriendlyName = "alpha field"
	// MPropertyAttributeChoiceName = "particlefield_alpha"
	ParticleAttributeIndex_t m_nFieldOutput;
	// MPropertyFriendlyName = "alpha min"
	// MPropertyAttributeRange = "0 255"
	int32 m_nAlphaMin;
	// MPropertyFriendlyName = "alpha max"
	// MPropertyAttributeRange = "0 255"
	int32 m_nAlphaMax;
	// MPropertyFriendlyName = "alpha random exponent"
	float32 m_flAlphaRandExponent;
};
