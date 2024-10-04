class CSmokeGrenadeProjectile : public CBaseCSGrenadeProjectile
{
	int32 m_nSmokeEffectTickBegin;
	bool m_bDidSmokeEffect;
	int32 m_nRandomSeed;
	Vector m_vSmokeColor;
	Vector m_vSmokeDetonationPos;
	CUtlVector< uint8 > m_VoxelFrameData;
	GameTime_t m_flLastBounce;
	GameTime_t m_fllastSimulationTime;
	bool m_bExplodeFromInferno;
};
