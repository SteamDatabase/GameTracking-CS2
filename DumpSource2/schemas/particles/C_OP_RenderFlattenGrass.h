// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_RenderFlattenGrass : public CParticleFunctionRenderer
{
	// MPropertyFriendlyName = "flattening strength"
	float32 m_flFlattenStrength;
	// MPropertyFriendlyName = "strength field override"
	// MPropertyAttributeChoiceName = "particlefield_scalar"
	ParticleAttributeIndex_t m_nStrengthFieldOverride;
	// MPropertyFriendlyName = "radius scale"
	float32 m_flRadiusScale;
};
