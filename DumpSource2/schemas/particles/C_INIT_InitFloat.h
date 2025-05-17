// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_INIT_InitFloat : public CParticleFunctionInitializer
{
	// MPropertyFriendlyName = "value"
	CPerParticleFloatInput m_InputValue;
	// MPropertyFriendlyName = "output field"
	// MPropertyAttributeChoiceName = "particlefield_scalar"
	ParticleAttributeIndex_t m_nOutputField;
	// MPropertyFriendlyName = "set value method"
	ParticleSetMethod_t m_nSetMethod;
	// MPropertyFriendlyName = "per-particle strength"
	CPerParticleFloatInput m_InputStrength;
};
