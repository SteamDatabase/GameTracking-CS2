// MNetworkVarNames = "HRenderTextureStrong m_Entity_hLightProbeTexture_AmbientCube"
// MNetworkVarNames = "HRenderTextureStrong m_Entity_hLightProbeTexture_SDF"
// MNetworkVarNames = "HRenderTextureStrong m_Entity_hLightProbeTexture_SH2_DC"
// MNetworkVarNames = "HRenderTextureStrong m_Entity_hLightProbeTexture_SH2_R"
// MNetworkVarNames = "HRenderTextureStrong m_Entity_hLightProbeTexture_SH2_G"
// MNetworkVarNames = "HRenderTextureStrong m_Entity_hLightProbeTexture_SH2_B"
// MNetworkVarNames = "HRenderTextureStrong m_Entity_hLightProbeDirectLightIndicesTexture"
// MNetworkVarNames = "HRenderTextureStrong m_Entity_hLightProbeDirectLightScalarsTexture"
// MNetworkVarNames = "HRenderTextureStrong m_Entity_hLightProbeDirectLightShadowsTexture"
// MNetworkVarNames = "Vector m_Entity_vBoxMins"
// MNetworkVarNames = "Vector m_Entity_vBoxMaxs"
// MNetworkVarNames = "bool m_Entity_bMoveable"
// MNetworkVarNames = "int m_Entity_nHandshake"
// MNetworkVarNames = "int m_Entity_nPriority"
// MNetworkVarNames = "bool m_Entity_bStartDisabled"
// MNetworkVarNames = "int m_Entity_nLightProbeSizeX"
// MNetworkVarNames = "int m_Entity_nLightProbeSizeY"
// MNetworkVarNames = "int m_Entity_nLightProbeSizeZ"
// MNetworkVarNames = "int m_Entity_nLightProbeAtlasX"
// MNetworkVarNames = "int m_Entity_nLightProbeAtlasY"
// MNetworkVarNames = "int m_Entity_nLightProbeAtlasZ"
// MNetworkVarNames = "bool m_Entity_bEnabled"
class CEnvLightProbeVolume : public CBaseEntity
{
	// MNetworkEnable
	CStrongHandle< InfoForResourceTypeCTextureBase > m_Entity_hLightProbeTexture_AmbientCube;
	// MNetworkEnable
	CStrongHandle< InfoForResourceTypeCTextureBase > m_Entity_hLightProbeTexture_SDF;
	// MNetworkEnable
	CStrongHandle< InfoForResourceTypeCTextureBase > m_Entity_hLightProbeTexture_SH2_DC;
	// MNetworkEnable
	CStrongHandle< InfoForResourceTypeCTextureBase > m_Entity_hLightProbeTexture_SH2_R;
	// MNetworkEnable
	CStrongHandle< InfoForResourceTypeCTextureBase > m_Entity_hLightProbeTexture_SH2_G;
	// MNetworkEnable
	CStrongHandle< InfoForResourceTypeCTextureBase > m_Entity_hLightProbeTexture_SH2_B;
	// MNetworkEnable
	CStrongHandle< InfoForResourceTypeCTextureBase > m_Entity_hLightProbeDirectLightIndicesTexture;
	// MNetworkEnable
	CStrongHandle< InfoForResourceTypeCTextureBase > m_Entity_hLightProbeDirectLightScalarsTexture;
	// MNetworkEnable
	CStrongHandle< InfoForResourceTypeCTextureBase > m_Entity_hLightProbeDirectLightShadowsTexture;
	// MNetworkEnable
	Vector m_Entity_vBoxMins;
	// MNetworkEnable
	Vector m_Entity_vBoxMaxs;
	// MNetworkEnable
	bool m_Entity_bMoveable;
	// MNetworkEnable
	int32 m_Entity_nHandshake;
	// MNetworkEnable
	int32 m_Entity_nPriority;
	// MNetworkEnable
	bool m_Entity_bStartDisabled;
	// MNetworkEnable
	int32 m_Entity_nLightProbeSizeX;
	// MNetworkEnable
	int32 m_Entity_nLightProbeSizeY;
	// MNetworkEnable
	int32 m_Entity_nLightProbeSizeZ;
	// MNetworkEnable
	int32 m_Entity_nLightProbeAtlasX;
	// MNetworkEnable
	int32 m_Entity_nLightProbeAtlasY;
	// MNetworkEnable
	int32 m_Entity_nLightProbeAtlasZ;
	// MNetworkEnable
	bool m_Entity_bEnabled;
};
