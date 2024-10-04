class CTriggerHurt : public CBaseTrigger
{
	float32 m_flOriginalDamage;
	float32 m_flDamage;
	float32 m_flDamageCap;
	GameTime_t m_flLastDmgTime;
	float32 m_flForgivenessDelay;
	DamageTypes_t m_bitsDamageInflict;
	int32 m_damageModel;
	bool m_bNoDmgForce;
	Vector m_vDamageForce;
	bool m_thinkAlways;
	float32 m_hurtThinkPeriod;
	CEntityIOOutput m_OnHurt;
	CEntityIOOutput m_OnHurtPlayer;
	CUtlVector< CHandle< CBaseEntity > > m_hurtEntities;
};
