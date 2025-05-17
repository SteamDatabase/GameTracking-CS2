// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_OscillateScalar : public CParticleFunctionOperator
{
	// MPropertyFriendlyName = "oscillation rate min"
	float32 m_RateMin;
	// MPropertyFriendlyName = "oscillation rate max"
	float32 m_RateMax;
	// MPropertyFriendlyName = "oscillation frequency min"
	float32 m_FrequencyMin;
	// MPropertyFriendlyName = "oscillation frequency max"
	float32 m_FrequencyMax;
	// MPropertyFriendlyName = "oscillation field"
	// MPropertyAttributeChoiceName = "particlefield_scalar"
	ParticleAttributeIndex_t m_nField;
	// MPropertyFriendlyName = "proportional 0/1"
	bool m_bProportional;
	// MPropertyFriendlyName = "start/end proportional"
	bool m_bProportionalOp;
	// MPropertyFriendlyName = "start time min"
	float32 m_flStartTime_min;
	// MPropertyFriendlyName = "start time max"
	float32 m_flStartTime_max;
	// MPropertyFriendlyName = "end time min"
	float32 m_flEndTime_min;
	// MPropertyFriendlyName = "end time max"
	float32 m_flEndTime_max;
	// MPropertyFriendlyName = "oscillation multiplier"
	float32 m_flOscMult;
	// MPropertyFriendlyName = "oscillation start phase"
	float32 m_flOscAdd;
};
