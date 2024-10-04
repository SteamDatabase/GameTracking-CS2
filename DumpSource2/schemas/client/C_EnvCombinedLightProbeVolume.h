class C_EnvCombinedLightProbeVolume : public C_BaseEntity
{
	Color m_Entity_Color;
	float32 m_Entity_flBrightness;
	CStrongHandle< InfoForResourceTypeCTextureBase > m_Entity_hCubemapTexture;
	bool m_Entity_bCustomCubemapTexture;
	CStrongHandle< InfoForResourceTypeCTextureBase > m_Entity_hLightProbeTexture;
	CStrongHandle< InfoForResourceTypeCTextureBase > m_Entity_hLightProbeDirectLightIndicesTexture;
	CStrongHandle< InfoForResourceTypeCTextureBase > m_Entity_hLightProbeDirectLightScalarsTexture;
	CStrongHandle< InfoForResourceTypeCTextureBase > m_Entity_hLightProbeDirectLightShadowsTexture;
	Vector m_Entity_vBoxMins;
	Vector m_Entity_vBoxMaxs;
	bool m_Entity_bMoveable;
	int32 m_Entity_nHandshake;
	int32 m_Entity_nEnvCubeMapArrayIndex;
	int32 m_Entity_nPriority;
	bool m_Entity_bStartDisabled;
	float32 m_Entity_flEdgeFadeDist;
	Vector m_Entity_vEdgeFadeDists;
	int32 m_Entity_nLightProbeSizeX;
	int32 m_Entity_nLightProbeSizeY;
	int32 m_Entity_nLightProbeSizeZ;
	int32 m_Entity_nLightProbeAtlasX;
	int32 m_Entity_nLightProbeAtlasY;
	int32 m_Entity_nLightProbeAtlasZ;
	bool m_Entity_bEnabled;
};
