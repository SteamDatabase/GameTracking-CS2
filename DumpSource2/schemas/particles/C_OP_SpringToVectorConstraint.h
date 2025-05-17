// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_SpringToVectorConstraint : public CParticleFunctionConstraint
{
	// MPropertyFriendlyName = "slack"
	CPerParticleFloatInput m_flRestLength;
	// MPropertyFriendlyName = "minimum segment length %"
	CPerParticleFloatInput m_flMinDistance;
	// MPropertyFriendlyName = "maximum segment length %"
	CPerParticleFloatInput m_flMaxDistance;
	// MPropertyFriendlyName = "resting spacing"
	CPerParticleFloatInput m_flRestingLength;
	// MPropertyFriendlyName = "anchor vector"
	CPerParticleVecInput m_vecAnchorVector;
};
