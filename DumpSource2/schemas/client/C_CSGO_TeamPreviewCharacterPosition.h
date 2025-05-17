// MNetworkVarNames = "int m_nVariant"
// MNetworkVarNames = "int m_nRandom"
// MNetworkVarNames = "int m_nOrdinal"
// MNetworkVarNames = "CUtlString m_sWeaponName"
// MNetworkVarNames = "XUID m_xuid"
// MNetworkVarNames = "CEconItemView m_agentItem"
// MNetworkVarNames = "CEconItemView m_glovesItem"
// MNetworkVarNames = "CEconItemView m_weaponItem"
class C_CSGO_TeamPreviewCharacterPosition : public C_BaseEntity
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
	C_EconItemView m_agentItem;
	// MNetworkEnable
	C_EconItemView m_glovesItem;
	// MNetworkEnable
	C_EconItemView m_weaponItem;
};
