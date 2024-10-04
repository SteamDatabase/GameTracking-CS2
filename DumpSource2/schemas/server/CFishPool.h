class CFishPool : public CBaseEntity
{
	int32 m_fishCount;
	float32 m_maxRange;
	float32 m_swimDepth;
	float32 m_waterLevel;
	bool m_isDormant;
	CUtlVector< CHandle< CFish > > m_fishes;
	CountdownTimer m_visTimer;
}
