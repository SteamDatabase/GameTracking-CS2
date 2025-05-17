// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_RemapParticleCountOnScalarEndCap : public CParticleFunctionOperator
{
	// MPropertyFriendlyName = "output field"
	// MPropertyAttributeChoiceName = "particlefield_scalar"
	ParticleAttributeIndex_t m_nFieldOutput;
	// MPropertyFriendlyName = "input minimum"
	int32 m_nInputMin;
	// MPropertyFriendlyName = "input maximum"
	int32 m_nInputMax;
	// MPropertyFriendlyName = "output minimum"
	float32 m_flOutputMin;
	// MPropertyFriendlyName = "output maximum"
	float32 m_flOutputMax;
	// MPropertyFriendlyName = "count back from last particle"
	bool m_bBackwards;
	// MPropertyFriendlyName = "set value method"
	ParticleSetMethod_t m_nSetMethod;
};
