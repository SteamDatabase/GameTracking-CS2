class CBaseModelEntity : public CBaseEntity
{
	CRenderComponent* m_CRenderComponent;
	CHitboxComponent m_CHitboxComponent;
	GameTime_t m_flDissolveStartTime;
	CEntityIOOutput m_OnIgnite;
	RenderMode_t m_nRenderMode;
	RenderFx_t m_nRenderFX;
	bool m_bAllowFadeInView;
	Color m_clrRender;
	CUtlVectorEmbeddedNetworkVar< EntityRenderAttribute_t > m_vecRenderAttributes;
	bool m_bRenderToCubemaps;
	bool m_bNoInterpolate;
	CCollisionProperty m_Collision;
	CGlowProperty m_Glow;
	float32 m_flGlowBackfaceMult;
	float32 m_fadeMinDist;
	float32 m_fadeMaxDist;
	float32 m_flFadeScale;
	float32 m_flShadowStrength;
	uint8 m_nObjectCulling;
	int32 m_nAddDecal;
	Vector m_vDecalPosition;
	Vector m_vDecalForwardAxis;
	float32 m_flDecalHealBloodRate;
	float32 m_flDecalHealHeightRate;
	CNetworkUtlVectorBase< CHandle< CBaseModelEntity > > m_ConfigEntitiesToPropagateMaterialDecalsTo;
	CNetworkViewOffsetVector m_vecViewOffset;
};
