// MNetworkVarNames = "Vector m_firePositions"
// MNetworkVarNames = "Vector m_fireParentPositions"
// MNetworkVarNames = "bool m_bFireIsBurning"
// MNetworkVarNames = "Vector m_BurnNormal"
// MNetworkVarNames = "int m_fireCount"
// MNetworkVarNames = "int m_nInfernoType"
// MNetworkVarNames = "int m_nFireEffectTickBegin"
// MNetworkVarNames = "float m_nFireLifetime"
// MNetworkVarNames = "bool m_bInPostEffectTime"
class CInferno : public CBaseModelEntity
{
	// MNetworkEnable
	Vector[64] m_firePositions;
	// MNetworkEnable
	Vector[64] m_fireParentPositions;
	// MNetworkEnable
	bool[64] m_bFireIsBurning;
	// MNetworkEnable
	Vector[64] m_BurnNormal;
	// MNetworkEnable
	int32 m_fireCount;
	// MNetworkEnable
	int32 m_nInfernoType;
	// MNetworkEnable
	int32 m_nFireEffectTickBegin;
	// MNetworkEnable
	float32 m_nFireLifetime;
	// MNetworkEnable
	bool m_bInPostEffectTime;
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
};
