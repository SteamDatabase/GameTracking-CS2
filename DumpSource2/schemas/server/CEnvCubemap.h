class CEnvCubemap : public CBaseEntity
{
	CStrongHandle< InfoForResourceTypeCTextureBase > m_Entity_hCubemapTexture;
	bool m_Entity_bCustomCubemapTexture;
	float32 m_Entity_flInfluenceRadius;
	Vector m_Entity_vBoxProjectMins;
	Vector m_Entity_vBoxProjectMaxs;
	bool m_Entity_bMoveable;
	int32 m_Entity_nHandshake;
	int32 m_Entity_nEnvCubeMapArrayIndex;
	int32 m_Entity_nPriority;
	float32 m_Entity_flEdgeFadeDist;
	Vector m_Entity_vEdgeFadeDists;
	float32 m_Entity_flDiffuseScale;
	bool m_Entity_bStartDisabled;
	bool m_Entity_bDefaultEnvMap;
	bool m_Entity_bDefaultSpecEnvMap;
	bool m_Entity_bIndoorCubeMap;
	bool m_Entity_bCopyDiffuseFromDefaultCubemap;
	bool m_Entity_bEnabled;
};
