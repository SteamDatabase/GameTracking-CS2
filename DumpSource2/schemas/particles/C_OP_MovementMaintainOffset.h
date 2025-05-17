// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_MovementMaintainOffset : public CParticleFunctionOperator
{
	// MPropertyFriendlyName = "desired offset"
	// MVectorIsCoordinate
	Vector m_vecOffset;
	// MPropertyFriendlyName = "local space CP"
	int32 m_nCP;
	// MPropertyFriendlyName = "scale by radius"
	bool m_bRadiusScale;
};
