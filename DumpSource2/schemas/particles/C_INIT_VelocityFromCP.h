// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_INIT_VelocityFromCP : public CParticleFunctionInitializer
{
	// MPropertyFriendlyName = "velocity"
	CParticleCollectionVecInput m_velocityInput;
	// MPropertyFriendlyName = "local space"
	// MParticleInputOptional
	CParticleTransformInput m_transformInput;
	// MPropertyFriendlyName = "velocity scale"
	float32 m_flVelocityScale;
	// MPropertyFriendlyName = "direction only"
	bool m_bDirectionOnly;
};
