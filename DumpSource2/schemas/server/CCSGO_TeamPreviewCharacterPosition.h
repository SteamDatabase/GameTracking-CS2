// MNetworkVarNames = "int m_nVariant"
// MNetworkVarNames = "int m_nRandom"
// MNetworkVarNames = "int m_nOrdinal"
// MNetworkVarNames = "CUtlString m_sWeaponName"
// MNetworkVarNames = "XUID m_xuid"
// MNetworkVarNames = "CEconItemView m_agentItem"
// MNetworkVarNames = "CEconItemView m_glovesItem"
// MNetworkVarNames = "CEconItemView m_weaponItem"
class CCSGO_TeamPreviewCharacterPosition : public CBaseEntity
{
	// MNetworkEnable
	int32 m_nVariant;
	// MNetworkEnable
	int32 m_nRandom;
	// MNetworkEnable
	int32 m_nOrdinal;
	// MNetworkEnable
	CUtlString m_sWeaponName;
	// MNetworkEnable
	uint64 m_xuid;
	// MNetworkEnable
	CEconItemView m_agentItem;
	// MNetworkEnable
	CEconItemView m_glovesItem;
	// MNetworkEnable
	CEconItemView m_weaponItem;
};
