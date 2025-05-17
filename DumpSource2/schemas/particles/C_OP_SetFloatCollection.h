// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_SetFloatCollection : public CParticleFunctionOperator
{
	// MPropertyFriendlyName = "value"
	CParticleCollectionFloatInput m_InputValue;
	// MPropertyFriendlyName = "output field"
	// MPropertyAttributeChoiceName = "particlefield_scalar"
	ParticleAttributeIndex_t m_nOutputField;
	// MPropertyFriendlyName = "set value method"
	ParticleSetMethod_t m_nSetMethod;
	// MPropertyFriendlyName = "interpolation"
	CParticleCollectionFloatInput m_Lerp;
};
