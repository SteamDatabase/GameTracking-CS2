// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_RemapSDFDistanceToScalarAttribute : public CParticleFunctionOperator
{
	// MPropertyFriendlyName = "Output field"
	// MPropertyAttributeChoiceName = "particlefield_scalar"
	ParticleAttributeIndex_t m_nFieldOutput;
	// MPropertyFriendlyName = "Input field"
	// MPropertyAttributeChoiceName = "particlefield_vector"
	ParticleAttributeIndex_t m_nVectorFieldInput;
	// MPropertyFriendlyName = "Minimum distance"
	CParticleCollectionFloatInput m_flMinDistance;
	// MPropertyFriendlyName = "Maximum distance"
	CParticleCollectionFloatInput m_flMaxDistance;
	// MPropertyFriendlyName = "Value for dist<min"
	CParticleCollectionFloatInput m_flValueBelowMin;
	// MPropertyFriendlyName = "Value for dist=min"
	CParticleCollectionFloatInput m_flValueAtMin;
	// MPropertyFriendlyName = "Value for dist=max"
	CParticleCollectionFloatInput m_flValueAtMax;
	// MPropertyFriendlyName = "Value for dist>max"
	CParticleCollectionFloatInput m_flValueAboveMax;
};
