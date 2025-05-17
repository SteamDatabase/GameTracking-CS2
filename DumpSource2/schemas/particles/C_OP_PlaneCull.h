// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_PlaneCull : public CParticleFunctionOperator
{
	// MPropertyFriendlyName = "control point for point on plane"
	int32 m_nPlaneControlPoint;
	// MPropertyFriendlyName = "plane normal"
	// MVectorIsCoordinate
	Vector m_vecPlaneDirection;
	// MPropertyFriendlyName = "use local space"
	bool m_bLocalSpace;
	// MPropertyFriendlyName = "cull plane offset"
	float32 m_flPlaneOffset;
};
