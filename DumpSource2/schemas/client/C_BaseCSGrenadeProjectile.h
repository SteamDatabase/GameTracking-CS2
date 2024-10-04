class C_BaseCSGrenadeProjectile : public C_BaseGrenade
{
	Vector m_vInitialPosition;
	Vector m_vInitialVelocity;
	int32 m_nBounces;
	CStrongHandle< InfoForResourceTypeIParticleSystemDefinition > m_nExplodeEffectIndex;
	int32 m_nExplodeEffectTickBegin;
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
}
