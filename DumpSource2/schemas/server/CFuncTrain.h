class CFuncTrain : public CBasePlatTrain
{
	CHandle< CBaseEntity > m_hCurrentTarget;
	bool m_activated;
	CHandle< CBaseEntity > m_hEnemy;
	float32 m_flBlockDamage;
	GameTime_t m_flNextBlockTime;
	CUtlSymbolLarge m_iszLastTarget;
};
