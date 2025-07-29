class ParticleNode_t
{
	CHandle< C_BaseEntity > m_hEntity;
	ParticleIndex_t m_iIndex;
	GameTime_t m_flStartTime;
	float32 m_flGrowthDuration;
	Vector m_vecGrowthOrigin;
	float32 m_flEndcapTime;
	bool m_bMarkedForDelete;
};
