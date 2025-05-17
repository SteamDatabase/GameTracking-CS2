// MEntityAllowsPortraitWorldSpawn
// MNetworkVarNames = "HMaterialStrong m_hDecalMaterial"
// MNetworkVarNames = "float m_flWidth"
// MNetworkVarNames = "float m_flHeight"
// MNetworkVarNames = "float m_flDepth"
// MNetworkVarNames = "uint32 m_nRenderOrder"
// MNetworkVarNames = "bool m_bProjectOnWorld"
// MNetworkVarNames = "bool m_bProjectOnCharacters"
// MNetworkVarNames = "bool m_bProjectOnWater"
// MNetworkVarNames = "float m_flDepthSortBias"
class C_EnvDecal : public C_BaseModelEntity
{
	// MNetworkEnable
	CStrongHandle< InfoForResourceTypeIMaterial2 > m_hDecalMaterial;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnDecalDimensionsChanged"
	float32 m_flWidth;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnDecalDimensionsChanged"
	float32 m_flHeight;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnDecalDimensionsChanged"
	float32 m_flDepth;
	// MNetworkEnable
	uint32 m_nRenderOrder;
	// MNetworkEnable
	bool m_bProjectOnWorld;
	// MNetworkEnable
	bool m_bProjectOnCharacters;
	// MNetworkEnable
	bool m_bProjectOnWater;
	// MNetworkEnable
	float32 m_flDepthSortBias;
};
