// MNetworkVarNames = "Vector m_vInitialPosition"
// MNetworkVarNames = "Vector m_vInitialVelocity"
// MNetworkVarNames = "int m_nBounces"
// MNetworkVarNames = "HParticleSystemDefinitionStrong m_nExplodeEffectIndex"
// MNetworkVarNames = "int m_nExplodeEffectTickBegin"
// MNetworkVarNames = "Vector m_vecExplodeEffectOrigin"
class CBaseCSGrenadeProjectile : public CBaseGrenade
{
	// MNetworkEnable
	Vector m_vInitialPosition;
	// MNetworkEnable
	Vector m_vInitialVelocity;
	// MNetworkEnable
	int32 m_nBounces;
	// MNetworkEnable
	CStrongHandle< InfoForResourceTypeIParticleSystemDefinition > m_nExplodeEffectIndex;
	// MNetworkEnable
	int32 m_nExplodeEffectTickBegin;
	// MNetworkEnable
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
	bool m_bHasEverHitEnemy;
};
