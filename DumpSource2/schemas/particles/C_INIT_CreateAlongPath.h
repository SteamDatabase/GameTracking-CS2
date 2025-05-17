// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_INIT_CreateAlongPath : public CParticleFunctionInitializer
{
	// MPropertyFriendlyName = "maximum distance"
	float32 m_fMaxDistance;
	CPathParameters m_PathParams;
	// MPropertyFriendlyName = "randomly select sequential CP pairs between start and end points"
	bool m_bUseRandomCPs;
	// MPropertyFriendlyName = "Offset from control point for path end"
	// MVectorIsCoordinate
	Vector m_vEndOffset;
	// MPropertyFriendlyName = "save offset"
	bool m_bSaveOffset;
};
