// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_RemapVectorComponentToScalar : public CParticleFunctionOperator
{
	// MPropertyFriendlyName = "Input Vector"
	// MPropertyAttributeChoiceName = "particlefield_vector"
	ParticleAttributeIndex_t m_nFieldInput;
	// MPropertyFriendlyName = "Output Scalar"
	// MPropertyAttributeChoiceName = "particlefield_scalar"
	ParticleAttributeIndex_t m_nFieldOutput;
	// MPropertyFriendlyName = "Vector Component"
	// MPropertyAttributeChoiceName = "vector_component"
	int32 m_nComponent;
};
