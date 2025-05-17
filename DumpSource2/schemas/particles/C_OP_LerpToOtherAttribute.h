// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_LerpToOtherAttribute : public CParticleFunctionOperator
{
	// MPropertyFriendlyName = "Interpolation"
	CPerParticleFloatInput m_flInterpolation;
	// MPropertyFriendlyName = "input attribute from"
	// MPropertyAttributeChoiceName = "particlefield"
	ParticleAttributeIndex_t m_nFieldInputFrom;
	// MPropertyFriendlyName = "input attribute to"
	// MPropertyAttributeChoiceName = "particlefield"
	ParticleAttributeIndex_t m_nFieldInput;
	// MPropertyFriendlyName = "output attribute"
	// MPropertyAttributeChoiceName = "particlefield"
	ParticleAttributeIndex_t m_nFieldOutput;
};
