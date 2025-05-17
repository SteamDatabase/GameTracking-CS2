// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_RenderScreenShake : public CParticleFunctionRenderer
{
	// MPropertyFriendlyName = "duration scale"
	float32 m_flDurationScale;
	// MPropertyFriendlyName = "radius scale"
	float32 m_flRadiusScale;
	// MPropertyFriendlyName = "frequence scale"
	float32 m_flFrequencyScale;
	// MPropertyFriendlyName = "amplitude scale"
	float32 m_flAmplitudeScale;
	// MPropertyFriendlyName = "radius field"
	// MPropertyAttributeChoiceName = "particlefield_scalar"
	ParticleAttributeIndex_t m_nRadiusField;
	// MPropertyFriendlyName = "duration field"
	// MPropertyAttributeChoiceName = "particlefield_scalar"
	ParticleAttributeIndex_t m_nDurationField;
	// MPropertyFriendlyName = "frequency field"
	// MPropertyAttributeChoiceName = "particlefield_scalar"
	ParticleAttributeIndex_t m_nFrequencyField;
	// MPropertyFriendlyName = "amplitude field"
	// MPropertyAttributeChoiceName = "particlefield_scalar"
	ParticleAttributeIndex_t m_nAmplitudeField;
	// MPropertyFriendlyName = "control point of shake recipient (-1 = global)"
	int32 m_nFilterCP;
};
