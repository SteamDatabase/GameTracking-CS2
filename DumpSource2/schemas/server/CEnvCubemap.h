// MEntityAllowsPortraitWorldSpawn
// MNetworkVarNames = "HRenderTextureStrong m_Entity_hCubemapTexture"
// MNetworkVarNames = "bool m_Entity_bCustomCubemapTexture"
// MNetworkVarNames = "float m_Entity_flInfluenceRadius"
// MNetworkVarNames = "Vector m_Entity_vBoxProjectMins"
// MNetworkVarNames = "Vector m_Entity_vBoxProjectMaxs"
// MNetworkVarNames = "bool m_Entity_bMoveable"
// MNetworkVarNames = "int m_Entity_nHandshake"
// MNetworkVarNames = "int m_Entity_nEnvCubeMapArrayIndex"
// MNetworkVarNames = "int m_Entity_nPriority"
// MNetworkVarNames = "float m_Entity_flEdgeFadeDist"
// MNetworkVarNames = "Vector m_Entity_vEdgeFadeDists"
// MNetworkVarNames = "float m_Entity_flDiffuseScale"
// MNetworkVarNames = "bool m_Entity_bStartDisabled"
// MNetworkVarNames = "bool m_Entity_bDefaultEnvMap"
// MNetworkVarNames = "bool m_Entity_bDefaultSpecEnvMap"
// MNetworkVarNames = "bool m_Entity_bIndoorCubeMap"
// MNetworkVarNames = "bool m_Entity_bCopyDiffuseFromDefaultCubemap"
// MNetworkVarNames = "bool m_Entity_bEnabled"
class CEnvCubemap : public CBaseEntity
{
	// MNetworkEnable
	CStrongHandle< InfoForResourceTypeCTextureBase > m_Entity_hCubemapTexture;
	// MNetworkEnable
	bool m_Entity_bCustomCubemapTexture;
	// MNetworkEnable
	float32 m_Entity_flInfluenceRadius;
	// MNetworkEnable
	Vector m_Entity_vBoxProjectMins;
	// MNetworkEnable
	Vector m_Entity_vBoxProjectMaxs;
	// MNetworkEnable
	bool m_Entity_bMoveable;
	// MNetworkEnable
	int32 m_Entity_nHandshake;
	// MNetworkEnable
	int32 m_Entity_nEnvCubeMapArrayIndex;
	// MNetworkEnable
	int32 m_Entity_nPriority;
	// MNetworkEnable
	float32 m_Entity_flEdgeFadeDist;
	// MNetworkEnable
	Vector m_Entity_vEdgeFadeDists;
	// MNetworkEnable
	float32 m_Entity_flDiffuseScale;
	// MNetworkEnable
	bool m_Entity_bStartDisabled;
	// MNetworkEnable
	bool m_Entity_bDefaultEnvMap;
	// MNetworkEnable
	bool m_Entity_bDefaultSpecEnvMap;
	// MNetworkEnable
	bool m_Entity_bIndoorCubeMap;
	// MNetworkEnable
	bool m_Entity_bCopyDiffuseFromDefaultCubemap;
	// MNetworkEnable
	bool m_Entity_bEnabled;
};
