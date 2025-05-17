// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_INIT_ColorLitPerParticle : public CParticleFunctionInitializer
{
	// MPropertyFriendlyName = "color1"
	Color m_ColorMin;
	// MPropertyFriendlyName = "color2"
	Color m_ColorMax;
	// MPropertyFriendlyName = "tint clamp min"
	Color m_TintMin;
	// MPropertyFriendlyName = "tint clamp max"
	Color m_TintMax;
	// MPropertyFriendlyName = "light bias"
	float32 m_flTintPerc;
	// MPropertyFriendlyName = "tint blend mode"
	ParticleColorBlendMode_t m_nTintBlendMode;
	// MPropertyFriendlyName = "light amplification amount"
	float32 m_flLightAmplification;
};
