// MParticleMinVersion = 9
// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_InheritFromParentParticlesV2 : public CParticleFunctionOperator
{
	// MPropertyFriendlyName = "scale"
	CPerParticleFloatInput m_flScale;
	// MPropertyFriendlyName = "inherited field"
	// MPropertyAttributeChoiceName = "particlefield"
	ParticleAttributeIndex_t m_nFieldOutput;
	// MPropertyFriendlyName = "particle increment amount"
	CPerParticleFloatInput m_nIncrement;
	// MPropertyFriendlyName = "random parent particle distribution"
	bool m_bRandomDistribution;
	// MPropertyFriendlyName = "start at last parent particle in reverse"
	bool m_bReverse;
	// MPropertyFriendlyName = "behavior if parent particle dies"
	MissingParentInheritBehavior_t m_nMissingParentBehavior;
	// MPropertyFriendlyName = "Interpolation"
	CPerParticleFloatInput m_flInterpolation;
};
