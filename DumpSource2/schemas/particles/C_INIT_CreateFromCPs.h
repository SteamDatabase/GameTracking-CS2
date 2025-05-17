// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_INIT_CreateFromCPs : public CParticleFunctionInitializer
{
	// MPropertyFriendlyName = "control point increment amount"
	int32 m_nIncrement;
	// MPropertyFriendlyName = "starting control point"
	int32 m_nMinCP;
	// MPropertyFriendlyName = "ending control point"
	// MParticleMinVersion = 2
	int32 m_nMaxCP;
	// MPropertyFriendlyName = "dynamic control point count"
	CParticleCollectionFloatInput m_nDynamicCPCount;
};
