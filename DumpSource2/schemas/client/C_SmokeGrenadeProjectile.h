class C_SmokeGrenadeProjectile : public C_BaseCSGrenadeProjectile
{
	int32 m_nSmokeEffectTickBegin;
	bool m_bDidSmokeEffect;
	int32 m_nRandomSeed;
	Vector m_vSmokeColor;
	Vector m_vSmokeDetonationPos;
	C_NetworkUtlVectorBase< uint8 > m_VoxelFrameData;
	int32 m_nVoxelFrameDataSize;
	int32 m_nVoxelUpdate;
	bool m_bSmokeVolumeDataReceived;
	bool m_bSmokeEffectSpawned;
};
