// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_DifferencePreviousParticle : public CParticleFunctionOperator
{
	// MPropertyFriendlyName = "input field"
	// MPropertyAttributeChoiceName = "particlefield_vector"
	ParticleAttributeIndex_t m_nFieldInput;
	// MPropertyFriendlyName = "output field"
	// MPropertyAttributeChoiceName = "particlefield_scalar"
	ParticleAttributeIndex_t m_nFieldOutput;
	// MPropertyFriendlyName = "difference minimum"
	float32 m_flInputMin;
	// MPropertyFriendlyName = "difference maximum"
	float32 m_flInputMax;
	// MPropertyFriendlyName = "output minimum"
	float32 m_flOutputMin;
	// MPropertyFriendlyName = "output maximum"
	float32 m_flOutputMax;
	// MPropertyFriendlyName = "set value method"
	ParticleSetMethod_t m_nSetMethod;
	// MPropertyFriendlyName = "only active within specified difference"
	bool m_bActiveRange;
	// MPropertyFriendlyName = "also set ouput to previous particle"
	bool m_bSetPreviousParticle;
};
