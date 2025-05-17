// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_ColorInterpolate : public CParticleFunctionOperator
{
	// MPropertyFriendlyName = "color fade"
	Color m_ColorFade;
	// MPropertyFriendlyName = "fade start time"
	float32 m_flFadeStartTime;
	// MPropertyFriendlyName = "fade end time"
	float32 m_flFadeEndTime;
	// MPropertyFriendlyName = "output field"
	// MPropertyAttributeChoiceName = "particlefield_vector"
	ParticleAttributeIndex_t m_nFieldOutput;
	// MPropertyFriendlyName = "ease in and out"
	bool m_bEaseInOut;
};
