// MNetworkVarNames = "Vector m_vInitialPosition"
// MNetworkVarNames = "Vector m_vInitialVelocity"
// MNetworkVarNames = "int m_nBounces"
// MNetworkVarNames = "HParticleSystemDefinitionStrong m_nExplodeEffectIndex"
// MNetworkVarNames = "int m_nExplodeEffectTickBegin"
// MNetworkVarNames = "Vector m_vecExplodeEffectOrigin"
class C_BaseCSGrenadeProjectile : public C_BaseGrenade
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
	Vector vecLastTrailLinePos;
	GameTime_t flNextTrailLineTime;
	bool m_bExplodeEffectBegan;
	bool m_bCanCreateGrenadeTrail;
	ParticleIndex_t m_nSnapshotTrajectoryEffectIndex;
	CStrongHandle< InfoForResourceTypeIParticleSnapshot > m_hSnapshotTrajectoryParticleSnapshot;
	CUtlVector< Vector > m_arrTrajectoryTrailPoints;
	CUtlVector< float32 > m_arrTrajectoryTrailPointCreationTimes;
	float32 m_flTrajectoryTrailEffectCreationTime;
};
