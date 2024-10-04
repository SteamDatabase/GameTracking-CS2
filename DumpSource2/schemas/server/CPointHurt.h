class CPointHurt : public CPointEntity
{
	int32 m_nDamage;
	DamageTypes_t m_bitsDamageType;
	float32 m_flRadius;
	float32 m_flDelay;
	CUtlSymbolLarge m_strTarget;
	CHandle< CBaseEntity > m_pActivator;
}
