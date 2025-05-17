// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_RemapSDFDistanceToVectorAttribute : public CParticleFunctionOperator
{
	// MPropertyFriendlyName = "Output field"
	// MPropertyAttributeChoiceName = "particlefield_vector"
	ParticleAttributeIndex_t m_nVectorFieldOutput;
	// MPropertyFriendlyName = "Input field"
	// MPropertyAttributeChoiceName = "particlefield_vector"
	ParticleAttributeIndex_t m_nVectorFieldInput;
	// MPropertyFriendlyName = "Minimum distance"
	CParticleCollectionFloatInput m_flMinDistance;
	// MPropertyFriendlyName = "Maximum distance"
	CParticleCollectionFloatInput m_flMaxDistance;
	// MPropertyFriendlyName = "Value for dist<min"
	Vector m_vValueBelowMin;
	// MPropertyFriendlyName = "Value for dist=min"
	Vector m_vValueAtMin;
	// MPropertyFriendlyName = "Value for dist=max"
	Vector m_vValueAtMax;
	// MPropertyFriendlyName = "Value for dist>max"
	Vector m_vValueAboveMax;
};
