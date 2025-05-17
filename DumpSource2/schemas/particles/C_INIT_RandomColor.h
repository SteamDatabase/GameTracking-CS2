// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_INIT_RandomColor : public CParticleFunctionInitializer
{
	// MPropertyFriendlyName = "color1"
	Color m_ColorMin;
	// MPropertyFriendlyName = "color2"
	Color m_ColorMax;
	// MPropertyFriendlyName = "tint clamp min"
	Color m_TintMin;
	// MPropertyFriendlyName = "tint clamp max"
	Color m_TintMax;
	// MPropertyFriendlyName = "tint perc"
	float32 m_flTintPerc;
	// MPropertyFriendlyName = "tint update movement threshold"
	float32 m_flUpdateThreshold;
	// MPropertyFriendlyName = "tint control point"
	int32 m_nTintCP;
	// MPropertyFriendlyName = "output field"
	// MPropertyAttributeChoiceName = "particlefield_vector"
	ParticleAttributeIndex_t m_nFieldOutput;
	// MPropertyFriendlyName = "tint blend mode"
	ParticleColorBlendMode_t m_nTintBlendMode;
	// MPropertyFriendlyName = "light amplification amount"
	float32 m_flLightAmplification;
};
