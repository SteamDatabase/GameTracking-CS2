class C_BaseModelEntity : public C_BaseEntity
{
	CRenderComponent* m_CRenderComponent;
	CHitboxComponent m_CHitboxComponent;
	bool m_bInitModelEffects;
	bool m_bIsStaticProp;
	int32 m_nLastAddDecal;
	int32 m_nDecalsAdded;
	int32 m_iOldHealth;
	RenderMode_t m_nRenderMode;
	RenderFx_t m_nRenderFX;
	bool m_bAllowFadeInView;
	Color m_clrRender;
	C_UtlVectorEmbeddedNetworkVar< EntityRenderAttribute_t > m_vecRenderAttributes;
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
	C_NetworkUtlVectorBase< CHandle< C_BaseModelEntity > > m_ConfigEntitiesToPropagateMaterialDecalsTo;
	CNetworkViewOffsetVector m_vecViewOffset;
	CClientAlphaProperty* m_pClientAlphaProperty;
	Color m_ClientOverrideTint;
	bool m_bUseClientOverrideTint;
}
