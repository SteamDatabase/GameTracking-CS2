class CEntityFlame : public CBaseEntity
{
	CHandle< CBaseEntity > m_hEntAttached;
	bool m_bCheapEffect;
	float32 m_flSize;
	bool m_bUseHitboxes;
	int32 m_iNumHitboxFires;
	float32 m_flHitboxFireScale;
	GameTime_t m_flLifetime;
	CHandle< CBaseEntity > m_hAttacker;
	int32 m_iDangerSound;
	float32 m_flDirectDamagePerSecond;
	int32 m_iCustomDamageType;
}
