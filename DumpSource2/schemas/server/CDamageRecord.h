class CDamageRecord
{
	CHandle< CCSPlayerPawn > m_PlayerDamager;
	CHandle< CCSPlayerPawn > m_PlayerRecipient;
	CHandle< CCSPlayerController > m_hPlayerControllerDamager;
	CHandle< CCSPlayerController > m_hPlayerControllerRecipient;
	CUtlString m_szPlayerDamagerName;
	CUtlString m_szPlayerRecipientName;
	uint64 m_DamagerXuid;
	uint64 m_RecipientXuid;
	int32 m_iBulletsDamage;
	int32 m_iDamage;
	int32 m_iActualHealthRemoved;
	int32 m_iNumHits;
	int32 m_iLastBulletUpdate;
	bool m_bIsOtherEnemy;
	EKillTypes_t m_killType;
};
