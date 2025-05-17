// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_RemapControlPointDirectionToVector : public CParticleFunctionOperator
{
	// MPropertyFriendlyName = "output field"
	// MPropertyAttributeChoiceName = "particlefield_vector"
	ParticleAttributeIndex_t m_nFieldOutput;
	// MPropertyFriendlyName = "scale factor"
	float32 m_flScale;
	// MPropertyFriendlyName = "control point number"
	int32 m_nControlPointNumber;
};
