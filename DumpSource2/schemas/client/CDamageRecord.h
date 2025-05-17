// MNetworkVarNames = "CHandle< CCSPlayerPawn > m_PlayerDamager"
// MNetworkVarNames = "CHandle< CCSPlayerPawn > m_PlayerRecipient"
// MNetworkVarNames = "CHandle< CCSPlayerController > m_hPlayerControllerDamager"
// MNetworkVarNames = "CHandle< CCSPlayerController > m_hPlayerControllerRecipient"
// MNetworkVarNames = "CUtlString m_szPlayerDamagerName"
// MNetworkVarNames = "CUtlString m_szPlayerRecipientName"
// MNetworkVarNames = "uint64 m_DamagerXuid"
// MNetworkVarNames = "uint64 m_RecipientXuid"
// MNetworkVarNames = "int m_iDamage"
// MNetworkVarNames = "int m_iActualHealthRemoved"
// MNetworkVarNames = "int m_iNumHits"
// MNetworkVarNames = "int m_iLastBulletUpdate"
// MNetworkVarNames = "bool m_bIsOtherEnemy"
// MNetworkVarNames = "EKillTypes_t m_killType"
class CDamageRecord
{
	// MNetworkEnable
	CHandle< C_CSPlayerPawn > m_PlayerDamager;
	// MNetworkEnable
	CHandle< C_CSPlayerPawn > m_PlayerRecipient;
	// MNetworkEnable
	CHandle< CCSPlayerController > m_hPlayerControllerDamager;
	// MNetworkEnable
	CHandle< CCSPlayerController > m_hPlayerControllerRecipient;
	// MNetworkEnable
	CUtlString m_szPlayerDamagerName;
	// MNetworkEnable
	CUtlString m_szPlayerRecipientName;
	// MNetworkEnable
	uint64 m_DamagerXuid;
	// MNetworkEnable
	uint64 m_RecipientXuid;
	int32 m_iBulletsDamage;
	// MNetworkEnable
	int32 m_iDamage;
	// MNetworkEnable
	int32 m_iActualHealthRemoved;
	// MNetworkEnable
	int32 m_iNumHits;
	// MNetworkEnable
	int32 m_iLastBulletUpdate;
	// MNetworkEnable
	bool m_bIsOtherEnemy;
	// MNetworkEnable
	EKillTypes_t m_killType;
};
