// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_MovementRigidAttachToCP : public CParticleFunctionOperator
{
	// MPropertyFriendlyName = "control point number"
	int32 m_nControlPointNumber;
	// MPropertyFriendlyName = "scale control point number"
	int32 m_nScaleControlPoint;
	// MPropertyFriendlyName = "scale control point field"
	// MPropertyAttributeChoiceName = "vector_component"
	int32 m_nScaleCPField;
	// MPropertyFriendlyName = "cache attribute to read from"
	// MPropertyAttributeChoiceName = "particlefield_vector"
	ParticleAttributeIndex_t m_nFieldInput;
	// MPropertyFriendlyName = "attribute to write to"
	// MPropertyAttributeChoiceName = "particlefield_vector"
	ParticleAttributeIndex_t m_nFieldOutput;
	// MPropertyFriendlyName = "local space"
	bool m_bOffsetLocal;
};
