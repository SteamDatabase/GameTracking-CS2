// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_SetParentControlPointsToChildCP : public CParticleFunctionPreEmission
{
	// MPropertyFriendlyName = "group ID to affect"
	int32 m_nChildGroupID;
	// MPropertyFriendlyName = "control point to set"
	int32 m_nChildControlPoint;
	// MPropertyFriendlyName = "# of children to set"
	int32 m_nNumControlPoints;
	// MPropertyFriendlyName = "first parent control point to set from"
	int32 m_nFirstSourcePoint;
	// MPropertyFriendlyName = "set orientation"
	bool m_bSetOrientation;
};
