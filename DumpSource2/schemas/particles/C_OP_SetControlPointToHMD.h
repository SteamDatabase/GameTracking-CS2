// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_SetControlPointToHMD : public CParticleFunctionPreEmission
{
	// MPropertyFriendlyName = "control point number"
	int32 m_nCP1;
	// MPropertyFriendlyName = "control point offset"
	// MVectorIsCoordinate
	Vector m_vecCP1Pos;
	// MPropertyFriendlyName = "use hmd orientation"
	bool m_bOrientToHMD;
};
