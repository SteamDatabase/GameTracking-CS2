// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_RampScalarSpline : public CParticleFunctionOperator
{
	// MPropertyFriendlyName = "ramp rate min"
	float32 m_RateMin;
	// MPropertyFriendlyName = "ramp rate max"
	float32 m_RateMax;
	// MPropertyFriendlyName = "start time min"
	float32 m_flStartTime_min;
	// MPropertyFriendlyName = "start time max"
	float32 m_flStartTime_max;
	// MPropertyFriendlyName = "end time min"
	float32 m_flEndTime_min;
	// MPropertyFriendlyName = "end time max"
	float32 m_flEndTime_max;
	// MPropertyFriendlyName = "bias"
	float32 m_flBias;
	// MPropertyFriendlyName = "ramp field"
	// MPropertyAttributeChoiceName = "particlefield_scalar"
	ParticleAttributeIndex_t m_nField;
	// MPropertyFriendlyName = "start/end proportional"
	bool m_bProportionalOp;
	// MPropertyFriendlyName = "ease out"
	bool m_bEaseOut;
};
