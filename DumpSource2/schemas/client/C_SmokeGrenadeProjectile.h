class C_SmokeGrenadeProjectile : public C_BaseCSGrenadeProjectile
{
	int32 m_nSmokeEffectTickBegin;
	bool m_bDidSmokeEffect;
	int32 m_nRandomSeed;
	Vector m_vSmokeColor;
	Vector m_vSmokeDetonationPos;
	CUtlVector< uint8 > m_VoxelFrameData;
	bool m_bSmokeVolumeDataReceived;
	bool m_bSmokeEffectSpawned;
};
