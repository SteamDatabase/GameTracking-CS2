class CEnvEntityMaker : public CPointEntity
{
	Vector m_vecEntityMins;
	Vector m_vecEntityMaxs;
	CHandle< CBaseEntity > m_hCurrentInstance;
	CHandle< CBaseEntity > m_hCurrentBlocker;
	Vector m_vecBlockerOrigin;
	QAngle m_angPostSpawnDirection;
	float32 m_flPostSpawnDirectionVariance;
	float32 m_flPostSpawnSpeed;
	bool m_bPostSpawnUseAngles;
	CUtlSymbolLarge m_iszTemplate;
	CEntityIOOutput m_pOutputOnSpawned;
	CEntityIOOutput m_pOutputOnFailedSpawn;
}
