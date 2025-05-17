// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_INIT_CreateParticleImpulse : public CParticleFunctionInitializer
{
	// MPropertyFriendlyName = "radius"
	CPerParticleFloatInput m_InputRadius;
	// MPropertyFriendlyName = "magnitude"
	CPerParticleFloatInput m_InputMagnitude;
	// MPropertyFriendlyName = "force falloff function"
	ParticleFalloffFunction_t m_nFalloffFunction;
	// MPropertyFriendlyName = "exponential falloff exponent"
	CPerParticleFloatInput m_InputFalloffExp;
	// MPropertyFriendlyName = "impulse type"
	ParticleImpulseType_t m_nImpulseType;
};
