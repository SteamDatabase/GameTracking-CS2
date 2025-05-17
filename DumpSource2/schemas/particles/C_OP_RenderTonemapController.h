// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_RenderTonemapController : public CParticleFunctionRenderer
{
	// MPropertyFriendlyName = "tonemap level scale"
	float32 m_flTonemapLevel;
	// MPropertyFriendlyName = "tonemap weight scale"
	float32 m_flTonemapWeight;
	// MPropertyFriendlyName = "tonemap level"
	// MPropertyAttributeChoiceName = "particlefield_scalar"
	ParticleAttributeIndex_t m_nTonemapLevelField;
	// MPropertyFriendlyName = "tonemap weight"
	// MPropertyAttributeChoiceName = "particlefield_scalar"
	ParticleAttributeIndex_t m_nTonemapWeightField;
};
