// MNetworkVarNames = "GameTime_t m_flStartTime"
// MNetworkVarNames = "float32 m_flFadeInStart"
// MNetworkVarNames = "float32 m_flFadeInLength"
// MNetworkVarNames = "float32 m_flFadeOutModelStart"
// MNetworkVarNames = "float32 m_flFadeOutModelLength"
// MNetworkVarNames = "float32 m_flFadeOutStart"
// MNetworkVarNames = "float32 m_flFadeOutLength"
// MNetworkVarNames = "EntityDisolveType_t m_nDissolveType"
// MNetworkVarNames = "Vector m_vDissolverOrigin"
// MNetworkVarNames = "uint32 m_nMagnitude"
class C_EntityDissolve : public C_BaseModelEntity
{
	// MNetworkEnable
	GameTime_t m_flStartTime;
	// MNetworkEnable
	float32 m_flFadeInStart;
	// MNetworkEnable
	float32 m_flFadeInLength;
	// MNetworkEnable
	float32 m_flFadeOutModelStart;
	// MNetworkEnable
	float32 m_flFadeOutModelLength;
	// MNetworkEnable
	float32 m_flFadeOutStart;
	// MNetworkEnable
	float32 m_flFadeOutLength;
	GameTime_t m_flNextSparkTime;
	// MNetworkEnable
	EntityDisolveType_t m_nDissolveType;
	// MNetworkEnable
	Vector m_vDissolverOrigin;
	// MNetworkEnable
	uint32 m_nMagnitude;
	bool m_bCoreExplode;
	bool m_bLinkedToServerEnt;
};
