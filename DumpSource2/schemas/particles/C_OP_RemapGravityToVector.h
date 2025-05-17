// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_RemapGravityToVector : public CParticleFunctionOperator
{
	// MPropertyFriendlyName = "position input"
	CPerParticleVecInput m_vInput1;
	// MPropertyFriendlyName = "output field"
	// MPropertyAttributeChoiceName = "particlefield_vector"
	ParticleAttributeIndex_t m_nOutputField;
	// MPropertyFriendlyName = "set value method"
	ParticleSetMethod_t m_nSetMethod;
	// MPropertyFriendlyName = "normalize result"
	bool m_bNormalizedOutput;
};
