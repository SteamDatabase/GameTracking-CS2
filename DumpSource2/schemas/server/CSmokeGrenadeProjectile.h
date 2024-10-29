class CSmokeGrenadeProjectile : public CBaseCSGrenadeProjectile
{
	int32 m_nSmokeEffectTickBegin;
	bool m_bDidSmokeEffect;
	int32 m_nRandomSeed;
	Vector m_vSmokeColor;
	Vector m_vSmokeDetonationPos;
	CNetworkUtlVectorBase< uint8 > m_VoxelFrameData;
	int32 m_nVoxelFrameDataSize;
	int32 m_nVoxelUpdate;
	GameTime_t m_flLastBounce;
	GameTime_t m_fllastSimulationTime;
	bool m_bExplodeFromInferno;
};
