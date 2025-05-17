// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_SetFloat : public CParticleFunctionOperator
{
	// MPropertyFriendlyName = "value"
	CPerParticleFloatInput m_InputValue;
	// MPropertyFriendlyName = "output field"
	// MPropertyAttributeChoiceName = "particlefield_scalar"
	ParticleAttributeIndex_t m_nOutputField;
	// MPropertyFriendlyName = "set value method"
	ParticleSetMethod_t m_nSetMethod;
	// MPropertyFriendlyName = "interpolation"
	CPerParticleFloatInput m_Lerp;
};
