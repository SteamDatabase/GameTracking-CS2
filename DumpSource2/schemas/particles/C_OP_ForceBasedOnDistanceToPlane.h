// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_ForceBasedOnDistanceToPlane : public CParticleFunctionForce
{
	// MPropertyFriendlyName = "min distance from plane"
	float32 m_flMinDist;
	// MPropertyFriendlyName = "force at min distance"
	// MVectorIsCoordinate
	Vector m_vecForceAtMinDist;
	// MPropertyFriendlyName = "max distance from plane"
	float32 m_flMaxDist;
	// MPropertyFriendlyName = "force at max distance"
	// MVectorIsCoordinate
	Vector m_vecForceAtMaxDist;
	// MPropertyFriendlyName = "plane normal"
	// MVectorIsCoordinate
	Vector m_vecPlaneNormal;
	// MPropertyFriendlyName = "control point number"
	int32 m_nControlPointNumber;
	// MPropertyFriendlyName = "exponent"
	float32 m_flExponent;
};
