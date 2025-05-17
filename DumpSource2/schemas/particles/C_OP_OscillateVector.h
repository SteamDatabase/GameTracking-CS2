// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_OscillateVector : public CParticleFunctionOperator
{
	// MPropertyFriendlyName = "oscillation rate min"
	// MVectorIsSometimesCoordinate = "m_nField"
	Vector m_RateMin;
	// MPropertyFriendlyName = "oscillation rate max"
	// MVectorIsSometimesCoordinate = "m_nField"
	Vector m_RateMax;
	// MPropertyFriendlyName = "oscillation frequency min"
	// MVectorIsSometimesCoordinate = "m_nField"
	Vector m_FrequencyMin;
	// MPropertyFriendlyName = "oscillation frequency max"
	// MVectorIsSometimesCoordinate = "m_nField"
	Vector m_FrequencyMax;
	// MPropertyFriendlyName = "oscillation field"
	// MPropertyAttributeChoiceName = "particlefield_vector"
	ParticleAttributeIndex_t m_nField;
	// MPropertyFriendlyName = "proportional 0/1"
	bool m_bProportional;
	// MPropertyFriendlyName = "start/end proportional"
	bool m_bProportionalOp;
	// MPropertyFriendlyName = "offset instead of accelerate position"
	bool m_bOffset;
	// MPropertyFriendlyName = "start time min"
	float32 m_flStartTime_min;
	// MPropertyFriendlyName = "start time max"
	float32 m_flStartTime_max;
	// MPropertyFriendlyName = "end time min"
	float32 m_flEndTime_min;
	// MPropertyFriendlyName = "end time max"
	float32 m_flEndTime_max;
	// MPropertyFriendlyName = "oscillation multiplier"
	CPerParticleFloatInput m_flOscMult;
	// MPropertyFriendlyName = "oscillation start phase"
	CPerParticleFloatInput m_flOscAdd;
	// MPropertyFriendlyName = "rate scale"
	CPerParticleFloatInput m_flRateScale;
};
