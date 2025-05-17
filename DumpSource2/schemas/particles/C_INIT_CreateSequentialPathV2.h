// MParticleMinVersion = 8
// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_INIT_CreateSequentialPathV2 : public CParticleFunctionInitializer
{
	// MPropertyFriendlyName = "maximum distance"
	CPerParticleFloatInput m_fMaxDistance;
	// MPropertyFriendlyName = "particles to map from start to end"
	CParticleCollectionFloatInput m_flNumToAssign;
	// MPropertyFriendlyName = "restart behavior (0 = bounce, 1 = loop )"
	bool m_bLoop;
	// MPropertyFriendlyName = "use sequential CP pairs between start and end point"
	bool m_bCPPairs;
	// MPropertyFriendlyName = "save offset"
	bool m_bSaveOffset;
	CPathParameters m_PathParams;
};
