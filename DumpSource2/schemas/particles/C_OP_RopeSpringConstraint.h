// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_RopeSpringConstraint : public CParticleFunctionConstraint
{
	// MPropertyFriendlyName = "slack"
	CParticleCollectionFloatInput m_flRestLength;
	// MPropertyFriendlyName = "minimum segment length %"
	CParticleCollectionFloatInput m_flMinDistance;
	// MPropertyFriendlyName = "maximum segment length %"
	CParticleCollectionFloatInput m_flMaxDistance;
	// MPropertyFriendlyName = "scale factor for spring correction"
	float32 m_flAdjustmentScale;
	// MPropertyFriendlyName = "manual resting spacing"
	CParticleCollectionFloatInput m_flInitialRestingLength;
};
