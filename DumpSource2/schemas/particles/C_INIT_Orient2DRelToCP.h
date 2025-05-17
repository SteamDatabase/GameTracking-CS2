// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_INIT_Orient2DRelToCP : public CParticleFunctionInitializer
{
	// MPropertyFriendlyName = "control point"
	int32 m_nCP;
	// MPropertyFriendlyName = "rotation field"
	// MPropertyAttributeChoiceName = "particlefield_rotation"
	ParticleAttributeIndex_t m_nFieldOutput;
	// MPropertyFriendlyName = "rotation offset"
	float32 m_flRotOffset;
};
