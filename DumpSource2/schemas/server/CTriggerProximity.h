class CTriggerProximity : public CBaseTrigger
{
	CHandle< CBaseEntity > m_hMeasureTarget;
	CUtlSymbolLarge m_iszMeasureTarget;
	float32 m_fRadius;
	int32 m_nTouchers;
	CEntityOutputTemplate< float32 > m_NearestEntityDistance;
}
