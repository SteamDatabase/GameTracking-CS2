class CFire : public CBaseModelEntity
{
	CHandle< CBaseFire > m_hEffect;
	CHandle< CBaseEntity > m_hOwner;
	int32 m_nFireType;
	float32 m_flFuel;
	GameTime_t m_flDamageTime;
	GameTime_t m_lastDamage;
	float32 m_flFireSize;
	GameTime_t m_flLastNavUpdateTime;
	float32 m_flHeatLevel;
	float32 m_flHeatAbsorb;
	float32 m_flDamageScale;
	float32 m_flMaxHeat;
	float32 m_flLastHeatLevel;
	float32 m_flAttackTime;
	bool m_bEnabled;
	bool m_bStartDisabled;
	bool m_bDidActivate;
	CEntityIOOutput m_OnIgnited;
	CEntityIOOutput m_OnExtinguished;
};
