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
	// MNotSaved
	GameTime_t m_flStartTime;
	// MNetworkEnable
	// MNotSaved
	float32 m_flFadeInStart;
	// MNetworkEnable
	// MNotSaved
	float32 m_flFadeInLength;
	// MNetworkEnable
	// MNotSaved
	float32 m_flFadeOutModelStart;
	// MNetworkEnable
	// MNotSaved
	float32 m_flFadeOutModelLength;
	// MNetworkEnable
	// MNotSaved
	float32 m_flFadeOutStart;
	// MNetworkEnable
	// MNotSaved
	float32 m_flFadeOutLength;
	// MNotSaved
	GameTime_t m_flNextSparkTime;
	// MNetworkEnable
	// MNotSaved
	EntityDisolveType_t m_nDissolveType;
	// MNetworkEnable
	// MNotSaved
	Vector m_vDissolverOrigin;
	// MNetworkEnable
	// MNotSaved
	uint32 m_nMagnitude;
	// MNotSaved
	bool m_bCoreExplode;
	// MNotSaved
	bool m_bLinkedToServerEnt;
};
