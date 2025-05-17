// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_SetVec : public CParticleFunctionOperator
{
	// MPropertyFriendlyName = "value"
	CPerParticleVecInput m_InputValue;
	// MPropertyFriendlyName = "output field"
	// MPropertyAttributeChoiceName = "particlefield_vector"
	ParticleAttributeIndex_t m_nOutputField;
	// MPropertyFriendlyName = "set value method"
	ParticleSetMethod_t m_nSetMethod;
	// MPropertyFriendlyName = "interpolation"
	CPerParticleFloatInput m_Lerp;
	// MPropertyFriendlyName = "normalize result"
	bool m_bNormalizedOutput;
};
