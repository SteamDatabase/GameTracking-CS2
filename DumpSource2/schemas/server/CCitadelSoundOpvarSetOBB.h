// MNetworkVarNames = "string_t m_iszStackName"
// MNetworkVarNames = "string_t m_iszOperatorName"
// MNetworkVarNames = "string_t m_iszOpvarName"
// MNetworkVarNames = "Vector m_vDistanceInnerMins"
// MNetworkVarNames = "Vector m_vDistanceInnerMaxs"
// MNetworkVarNames = "Vector m_vDistanceOuterMins"
// MNetworkVarNames = "Vector m_vDistanceOuterMaxs"
// MNetworkVarNames = "int m_nAABBDirection"
class CCitadelSoundOpvarSetOBB : public CBaseEntity
{
	// MNetworkEnable
	CUtlSymbolLarge m_iszStackName;
	// MNetworkEnable
	CUtlSymbolLarge m_iszOperatorName;
	// MNetworkEnable
	CUtlSymbolLarge m_iszOpvarName;
	// MNetworkEnable
	Vector m_vDistanceInnerMins;
	// MNetworkEnable
	Vector m_vDistanceInnerMaxs;
	// MNetworkEnable
	Vector m_vDistanceOuterMins;
	// MNetworkEnable
	Vector m_vDistanceOuterMaxs;
	// MNetworkEnable
	int32 m_nAABBDirection;
};
