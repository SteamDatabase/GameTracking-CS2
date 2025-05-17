// MParticleMaxVersion = 8
// MParticleReplacementOp = "C_OP_InheritFromParentParticlesV2"
// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_InheritFromParentParticles : public CParticleFunctionOperator
{
	// MPropertyFriendlyName = "scale"
	float32 m_flScale;
	// MPropertyFriendlyName = "inherited field"
	// MPropertyAttributeChoiceName = "particlefield"
	ParticleAttributeIndex_t m_nFieldOutput;
	// MPropertyFriendlyName = "particle increment amount"
	int32 m_nIncrement;
	// MPropertyFriendlyName = "random parent particle distribution"
	bool m_bRandomDistribution;
};
