// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_OscillateVectorSimple : public CParticleFunctionOperator
{
	// MPropertyFriendlyName = "oscillation rate"
	// MVectorIsSometimesCoordinate = "m_nField"
	Vector m_Rate;
	// MPropertyFriendlyName = "oscillation frequency"
	Vector m_Frequency;
	// MPropertyFriendlyName = "oscillation field"
	// MPropertyAttributeChoiceName = "particlefield_vector"
	ParticleAttributeIndex_t m_nField;
	// MPropertyFriendlyName = "oscillation multiplier"
	float32 m_flOscMult;
	// MPropertyFriendlyName = "oscillation start phase"
	float32 m_flOscAdd;
	// MPropertyFriendlyName = "offset instead of accelerate position"
	bool m_bOffset;
};
