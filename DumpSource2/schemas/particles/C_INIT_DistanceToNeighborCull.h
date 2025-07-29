// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_INIT_DistanceToNeighborCull : public CParticleFunctionInitializer
{
	// MPropertyFriendlyName = "cull distance"
	CPerParticleFloatInput m_flDistance;
	// MPropertyFriendlyName = "include particle radius"
	bool m_bIncludeRadii;
	// MPropertyFriendlyName = "lifespan overlap percentage"
	CPerParticleFloatInput m_flLifespanOverlap;
};
