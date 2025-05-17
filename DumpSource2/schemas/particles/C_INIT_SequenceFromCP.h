// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_INIT_SequenceFromCP : public CParticleFunctionInitializer
{
	// MPropertyFriendlyName = "kill unused"
	bool m_bKillUnused;
	// MPropertyFriendlyName = "offset propotional to radius"
	bool m_bRadiusScale;
	// MPropertyFriendlyName = "control point"
	int32 m_nCP;
	// MPropertyFriendlyName = "per particle spatial offset"
	// MVectorIsCoordinate
	Vector m_vecOffset;
};
