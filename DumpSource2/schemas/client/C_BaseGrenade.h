class C_BaseGrenade : public C_BaseFlex
{
	bool m_bHasWarnedAI;
	bool m_bIsSmokeGrenade;
	bool m_bIsLive;
	float32 m_DmgRadius;
	GameTime_t m_flDetonateTime;
	float32 m_flWarnAITime;
	float32 m_flDamage;
	CUtlSymbolLarge m_iszBounceSound;
	CUtlString m_ExplosionSound;
	CHandle< C_CSPlayerPawn > m_hThrower;
	GameTime_t m_flNextAttack;
	CHandle< C_CSPlayerPawn > m_hOriginalThrower;
};
