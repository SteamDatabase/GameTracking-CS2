// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_VelocityMatchingForce : public CParticleFunctionOperator
{
	// MPropertyFriendlyName = "direction matching strength"
	float32 m_flDirScale;
	// MPropertyFriendlyName = "speed matching strength"
	float32 m_flSpdScale;
	// MPropertyFriendlyName = "neighbor distance"
	float32 m_flNeighborDistance;
	// MPropertyFriendlyName = "facing strength falloff"
	float32 m_flFacingStrength;
	// MPropertyFriendlyName = "use AABB"
	// MPropertySuppressExpr = "m_flNeighborDistance > 0"
	bool m_bUseAABB;
	// MPropertyFriendlyName = "control point to broadcast speed and direction to"
	int32 m_nCPBroadcast;
};
