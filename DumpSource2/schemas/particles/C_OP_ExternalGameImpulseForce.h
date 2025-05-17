// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_ExternalGameImpulseForce : public CParticleFunctionForce
{
	// MPropertyFriendlyName = "force scale"
	CPerParticleFloatInput m_flForceScale;
	// MPropertyFriendlyName = "rope shake"
	bool m_bRopes;
	// MPropertyFriendlyName = "limit rope impulses to Z"
	bool m_bRopesZOnly;
	// MPropertyFriendlyName = "explosions"
	bool m_bExplosions;
	// MPropertyFriendlyName = "particle systems"
	bool m_bParticles;
};
