class CBaseGrenade : public CBaseFlex
{
	CEntityIOOutput m_OnPlayerPickup;
	CEntityIOOutput m_OnExplode;
	bool m_bHasWarnedAI;
	bool m_bIsSmokeGrenade;
	bool m_bIsLive;
	float32 m_DmgRadius;
	GameTime_t m_flDetonateTime;
	float32 m_flWarnAITime;
	float32 m_flDamage;
	CUtlSymbolLarge m_iszBounceSound;
	CUtlString m_ExplosionSound;
	CHandle< CCSPlayerPawn > m_hThrower;
	GameTime_t m_flNextAttack;
	CHandle< CCSPlayerPawn > m_hOriginalThrower;
};
