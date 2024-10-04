class CEnvFireSensor : public CBaseEntity
{
	bool m_bEnabled;
	bool m_bHeatAtLevel;
	float32 m_radius;
	float32 m_targetLevel;
	float32 m_targetTime;
	float32 m_levelTime;
	CEntityIOOutput m_OnHeatLevelStart;
	CEntityIOOutput m_OnHeatLevelEnd;
};
