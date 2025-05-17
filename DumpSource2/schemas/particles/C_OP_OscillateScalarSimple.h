// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_OscillateScalarSimple : public CParticleFunctionOperator
{
	// MPropertyFriendlyName = "oscillation rate"
	float32 m_Rate;
	// MPropertyFriendlyName = "oscillation frequency"
	float32 m_Frequency;
	// MPropertyFriendlyName = "oscillation field"
	// MPropertyAttributeChoiceName = "particlefield_scalar"
	ParticleAttributeIndex_t m_nField;
	// MPropertyFriendlyName = "oscillation multiplier"
	float32 m_flOscMult;
	// MPropertyFriendlyName = "oscillation start phase"
	float32 m_flOscAdd;
};
