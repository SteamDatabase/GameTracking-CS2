// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_IntraParticleForce : public CParticleFunctionForce
{
	// MPropertyFriendlyName = "min attraction distance"
	float32 m_flAttractionMinDistance;
	// MPropertyFriendlyName = "max attraction distance"
	float32 m_flAttractionMaxDistance;
	// MPropertyFriendlyName = "max attraction force"
	float32 m_flAttractionMaxStrength;
	// MPropertyFriendlyName = "min repulsion distance"
	float32 m_flRepulsionMinDistance;
	// MPropertyFriendlyName = "max repulsion distance"
	float32 m_flRepulsionMaxDistance;
	// MPropertyFriendlyName = "max repulsion force"
	float32 m_flRepulsionMaxStrength;
	// MPropertyFriendlyName = "use aabbtree"
	bool m_bUseAABB;
};
