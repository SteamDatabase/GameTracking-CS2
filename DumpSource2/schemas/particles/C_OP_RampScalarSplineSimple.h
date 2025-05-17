// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_RampScalarSplineSimple : public CParticleFunctionOperator
{
	// MPropertyFriendlyName = "ramp rate"
	float32 m_Rate;
	// MPropertyFriendlyName = "start time"
	float32 m_flStartTime;
	// MPropertyFriendlyName = "end time"
	float32 m_flEndTime;
	// MPropertyFriendlyName = "ramp field"
	// MPropertyAttributeChoiceName = "particlefield_scalar"
	ParticleAttributeIndex_t m_nField;
	// MPropertyFriendlyName = "ease out"
	bool m_bEaseOut;
};
