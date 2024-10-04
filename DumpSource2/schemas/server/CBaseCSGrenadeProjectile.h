class CBaseCSGrenadeProjectile : public CBaseGrenade
{
	Vector m_vInitialPosition;
	Vector m_vInitialVelocity;
	int32 m_nBounces;
	CStrongHandle< InfoForResourceTypeIParticleSystemDefinition > m_nExplodeEffectIndex;
	int32 m_nExplodeEffectTickBegin;
	Vector m_vecExplodeEffectOrigin;
	GameTime_t m_flSpawnTime;
	uint8 m_unOGSExtraFlags;
	bool m_bDetonationRecorded;
	uint16 m_nItemIndex;
	Vector m_vecOriginalSpawnLocation;
	GameTime_t m_flLastBounceSoundTime;
	RotationVector m_vecGrenadeSpin;
	Vector m_vecLastHitSurfaceNormal;
	int32 m_nTicksAtZeroVelocity;
	bool m_bHasEverHitPlayer;
	bool m_bClearFromPlayers;
};
