// MParticleMinVersion = 8
// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_LockToSavedSequentialPathV2 : public CParticleFunctionOperator
{
	// MPropertyFriendlyName = "start fade time"
	float32 m_flFadeStart;
	// MPropertyFriendlyName = "end fade time"
	float32 m_flFadeEnd;
	// MPropertyFriendlyName = "Use sequential CP pairs between start and end point"
	bool m_bCPPairs;
	CPathParameters m_PathParams;
};
