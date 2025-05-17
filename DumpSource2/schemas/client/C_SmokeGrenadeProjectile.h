// MNetworkVarNames = "int m_nSmokeEffectTickBegin"
// MNetworkVarNames = "bool m_bDidSmokeEffect"
// MNetworkVarNames = "int m_nRandomSeed"
// MNetworkVarNames = "Vector m_vSmokeColor"
// MNetworkVarNames = "Vector m_vSmokeDetonationPos"
// MNetworkVarNames = "uint8 m_VoxelFrameData"
// MNetworkVarNames = "int m_nVoxelFrameDataSize"
// MNetworkVarNames = "int m_nVoxelUpdate"
class C_SmokeGrenadeProjectile : public C_BaseCSGrenadeProjectile
{
	// MNetworkEnable
	int32 m_nSmokeEffectTickBegin;
	// MNetworkEnable
	bool m_bDidSmokeEffect;
	// MNetworkEnable
	int32 m_nRandomSeed;
	// MNetworkEnable
	Vector m_vSmokeColor;
	// MNetworkEnable
	Vector m_vSmokeDetonationPos;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnSimulationChanged"
	C_NetworkUtlVectorBase< uint8 > m_VoxelFrameData;
	// MNetworkEnable
	int32 m_nVoxelFrameDataSize;
	// MNetworkEnable
	int32 m_nVoxelUpdate;
	bool m_bSmokeVolumeDataReceived;
	bool m_bSmokeEffectSpawned;
};
