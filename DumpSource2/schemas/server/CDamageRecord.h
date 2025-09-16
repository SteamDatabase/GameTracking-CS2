// MNetworkVarNames = "CHandle< CCSPlayerPawn > m_PlayerDamager"
// MNetworkVarNames = "CHandle< CCSPlayerPawn > m_PlayerRecipient"
// MNetworkVarNames = "CHandle< CCSPlayerController > m_hPlayerControllerDamager"
// MNetworkVarNames = "CHandle< CCSPlayerController > m_hPlayerControllerRecipient"
// MNetworkVarNames = "CUtlString m_szPlayerDamagerName"
// MNetworkVarNames = "CUtlString m_szPlayerRecipientName"
// MNetworkVarNames = "uint64 m_DamagerXuid"
// MNetworkVarNames = "uint64 m_RecipientXuid"
// MNetworkReplayCompatField = "m_iDamage"
// MNetworkVarNames = "float m_flDamage"
// MNetworkReplayCompatField = "m_iActualHealthRemoved"
// MNetworkVarNames = "float m_flActualHealthRemoved"
// MNetworkVarNames = "int m_iNumHits"
// MNetworkVarNames = "int m_iLastBulletUpdate"
// MNetworkVarNames = "bool m_bIsOtherEnemy"
// MNetworkVarNames = "EKillTypes_t m_killType"
class CDamageRecord
{
	// MNetworkEnable
	CHandle< CCSPlayerPawn > m_PlayerDamager;
	// MNetworkEnable
	CHandle< CCSPlayerPawn > m_PlayerRecipient;
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
	float32 m_flBulletsDamage;
	// MNetworkEnable
	float32 m_flDamage;
	// MNetworkEnable
	float32 m_flActualHealthRemoved;
	// MNetworkEnable
	int32 m_iNumHits;
	// MNetworkEnable
	int32 m_iLastBulletUpdate;
	// MNetworkEnable
	bool m_bIsOtherEnemy;
	// MNetworkEnable
	EKillTypes_t m_killType;
};
