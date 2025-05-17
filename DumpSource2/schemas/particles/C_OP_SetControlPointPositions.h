// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_SetControlPointPositions : public CParticleFunctionPreEmission
{
	// MPropertyFriendlyName = "set positions in world space"
	bool m_bUseWorldLocation;
	// MPropertyFriendlyName = "inherit CP orientation"
	bool m_bOrient;
	// MPropertyFriendlyName = "only set position once"
	bool m_bSetOnce;
	// MPropertyFriendlyName = "first control point number"
	int32 m_nCP1;
	// MPropertyFriendlyName = "second control point number"
	int32 m_nCP2;
	// MPropertyFriendlyName = "third control point number"
	int32 m_nCP3;
	// MPropertyFriendlyName = "fourth control point number"
	int32 m_nCP4;
	// MPropertyFriendlyName = "first control point location"
	// MVectorIsCoordinate
	Vector m_vecCP1Pos;
	// MPropertyFriendlyName = "second control point location"
	// MVectorIsCoordinate
	Vector m_vecCP2Pos;
	// MPropertyFriendlyName = "third control point location"
	// MVectorIsCoordinate
	Vector m_vecCP3Pos;
	// MPropertyFriendlyName = "fourth control point location"
	// MVectorIsCoordinate
	Vector m_vecCP4Pos;
	// MPropertyFriendlyName = "control point to offset positions from"
	int32 m_nHeadLocation;
};
