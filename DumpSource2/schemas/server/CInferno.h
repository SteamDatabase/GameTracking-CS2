class CInferno : public CBaseModelEntity
{
	Vector[64] m_firePositions;
	Vector[64] m_fireParentPositions;
	bool[64] m_bFireIsBurning;
	Vector[64] m_BurnNormal;
	int32 m_fireCount;
	int32 m_nInfernoType;
	int32 m_nFireEffectTickBegin;
	float32 m_nFireLifetime;
	bool m_bInPostEffectTime;
	int32 m_nFiresExtinguishCount;
	bool m_bWasCreatedInSmoke;
	Extent m_extent;
	CountdownTimer m_damageTimer;
	CountdownTimer m_damageRampTimer;
	Vector m_splashVelocity;
	Vector m_InitialSplashVelocity;
	Vector m_startPos;
	Vector m_vecOriginalSpawnLocation;
	IntervalTimer m_activeTimer;
	int32 m_fireSpawnOffset;
	int32 m_nMaxFlames;
	int32 m_nSpreadCount;
	CountdownTimer m_BookkeepingTimer;
	CountdownTimer m_NextSpreadTimer;
	uint16 m_nSourceItemDefIndex;
}
