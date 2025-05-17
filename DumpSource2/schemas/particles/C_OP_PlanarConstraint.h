// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_PlanarConstraint : public CParticleFunctionConstraint
{
	// MPropertyFriendlyName = "plane point"
	// MVectorIsCoordinate
	Vector m_PointOnPlane;
	// MPropertyFriendlyName = "plane normal"
	Vector m_PlaneNormal;
	// MPropertyFriendlyName = "control point number"
	int32 m_nControlPointNumber;
	// MPropertyFriendlyName = "global origin"
	bool m_bGlobalOrigin;
	// MPropertyFriendlyName = "global normal"
	bool m_bGlobalNormal;
	// MPropertyFriendlyName = "radius scale"
	CPerParticleFloatInput m_flRadiusScale;
	// MPropertyFriendlyName = "falloff distance from control point"
	CParticleCollectionFloatInput m_flMaximumDistanceToCP;
	// MPropertyFriendlyName = "use old code"
	bool m_bUseOldCode;
};
