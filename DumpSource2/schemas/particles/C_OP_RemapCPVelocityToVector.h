// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_RemapCPVelocityToVector : public CParticleFunctionOperator
{
	// MPropertyFriendlyName = "control point"
	int32 m_nControlPoint;
	// MPropertyFriendlyName = "output field"
	// MPropertyAttributeChoiceName = "particlefield_vector"
	ParticleAttributeIndex_t m_nFieldOutput;
	// MPropertyFriendlyName = "scale factor"
	float32 m_flScale;
	// MPropertyFriendlyName = "normalize"
	bool m_bNormalize;
};
