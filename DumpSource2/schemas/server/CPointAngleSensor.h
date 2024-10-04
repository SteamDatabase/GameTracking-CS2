class CPointAngleSensor : public CPointEntity
{
	bool m_bDisabled;
	CUtlSymbolLarge m_nLookAtName;
	CHandle< CBaseEntity > m_hTargetEntity;
	CHandle< CBaseEntity > m_hLookAtEntity;
	float32 m_flDuration;
	float32 m_flDotTolerance;
	GameTime_t m_flFacingTime;
	bool m_bFired;
	CEntityIOOutput m_OnFacingLookat;
	CEntityIOOutput m_OnNotFacingLookat;
	CEntityOutputTemplate< Vector > m_TargetDir;
	CEntityOutputTemplate< float32 > m_FacingPercentage;
}
