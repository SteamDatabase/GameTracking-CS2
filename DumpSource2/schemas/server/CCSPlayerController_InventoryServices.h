// MNetworkVarNames = "item_definition_index_t m_unMusicID"
// MNetworkVarNames = "MedalRank_t m_rank"
// MNetworkVarNames = "int m_nPersonaDataPublicLevel"
// MNetworkVarNames = "int m_nPersonaDataPublicCommendsLeader"
// MNetworkVarNames = "int m_nPersonaDataPublicCommendsTeacher"
// MNetworkVarNames = "int m_nPersonaDataPublicCommendsFriendly"
// MNetworkVarNames = "int m_nPersonaDataXpTrailLevel"
// MNetworkVarNames = "ServerAuthoritativeWeaponSlot_t m_vecServerAuthoritativeWeaponSlots"
// MNetworkVarNames = "CSNetworkableLoadout_t m_vecNetworkableLoadout"
class CCSPlayerController_InventoryServices : public CPlayerControllerComponent
{
	// MNetworkEnable
	uint16 m_unMusicID;
	// MNetworkEnable
	MedalRank_t[6] m_rank;
	// MNetworkEnable
	int32 m_nPersonaDataPublicLevel;
	// MNetworkEnable
	int32 m_nPersonaDataPublicCommendsLeader;
	// MNetworkEnable
	int32 m_nPersonaDataPublicCommendsTeacher;
	// MNetworkEnable
	int32 m_nPersonaDataPublicCommendsFriendly;
	// MNetworkEnable
	int32 m_nPersonaDataXpTrailLevel;
	uint32[1] m_unEquippedPlayerSprayIDs;
	// MNetworkEnable
	// MNetworkUserGroup = "LocalPlayerExclusive"
	CUtlVectorEmbeddedNetworkVar< ServerAuthoritativeWeaponSlot_t > m_vecServerAuthoritativeWeaponSlots;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnNetworkableLoadoutChanged"
	CUtlVectorEmbeddedNetworkVar< CSNetworkableLoadout_t > m_vecNetworkableLoadout;
};
