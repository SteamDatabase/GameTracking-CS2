// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_SetControlPointsToParticle : public CParticleFunctionOperator
{
	// MPropertyFriendlyName = "group ID to affect"
	int32 m_nChildGroupID;
	// MPropertyFriendlyName = "first control point to set"
	int32 m_nFirstControlPoint;
	// MPropertyFriendlyName = "# of control points to set"
	int32 m_nNumControlPoints;
	// MPropertyFriendlyName = "first particle to copy"
	int32 m_nFirstSourcePoint;
	// MPropertyFriendlyName = "set orientation"
	bool m_bSetOrientation;
	// MPropertyFriendlyName = "orientation style"
	ParticleOrientationSetMode_t m_nOrientationMode;
	// MPropertyFriendlyName = "set parent"
	ParticleParentSetMode_t m_nSetParent;
};
