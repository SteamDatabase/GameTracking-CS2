// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_ColorInterpolateRandom : public CParticleFunctionOperator
{
	// MPropertyFriendlyName = "color fade min"
	Color m_ColorFadeMin;
	// MPropertyFriendlyName = "color fade max"
	Color m_ColorFadeMax;
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
