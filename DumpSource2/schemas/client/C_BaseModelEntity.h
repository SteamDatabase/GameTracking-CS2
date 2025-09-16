// MNetworkVarNames = "CRenderComponent::Storage_t m_CRenderComponent"
// MNetworkVarNames = "CHitboxComponent::Storage_t m_CHitboxComponent"
// MNetworkVarNames = "CDestructiblePartsComponent * m_pDestructiblePartsSystemComponent"
// MNetworkVarNames = "RenderMode_t m_nRenderMode"
// MNetworkVarNames = "RenderFx_t m_nRenderFX"
// MNetworkVarNames = "Color m_clrRender"
// MNetworkVarNames = "EntityRenderAttribute_t m_vecRenderAttributes"
// MNetworkVarNames = "bool m_bRenderToCubemaps"
// MNetworkVarNames = "bool m_bNoInterpolate"
// MNetworkVarNames = "CCollisionProperty m_Collision"
// MNetworkVarNames = "CGlowProperty m_Glow"
// MNetworkVarNames = "float m_flGlowBackfaceMult"
// MNetworkVarNames = "float32 m_fadeMinDist"
// MNetworkVarNames = "float32 m_fadeMaxDist"
// MNetworkVarNames = "float32 m_flFadeScale"
// MNetworkVarNames = "float32 m_flShadowStrength"
// MNetworkVarNames = "uint8 m_nObjectCulling"
// MNetworkVarNames = "int m_nAddDecal"
// MNetworkVarNames = "Vector m_vDecalPosition"
// MNetworkVarNames = "Vector m_vDecalForwardAxis"
// MNetworkVarNames = "float m_flDecalHealBloodRate"
// MNetworkVarNames = "float m_flDecalHealHeightRate"
// MNetworkVarNames = "DecalMode_t m_nDecalMode"
// MNetworkVarNames = "DecalMode_t m_nRequiredDecalMode"
// MNetworkVarNames = "CHandle< C_BaseModelEntity > m_ConfigEntitiesToPropagateMaterialDecalsTo"
// MNetworkVarNames = "uint32 m_bvDisabledHitGroups"
class C_BaseModelEntity : public C_BaseEntity
{
	// MNetworkEnable
	// MNetworkUserGroup = "CRenderComponent"
	// MNetworkAlias = "CRenderComponent"
	// MNetworkTypeAlias = "CRenderComponent"
	CRenderComponent* m_CRenderComponent;
	// MNetworkEnable
	// MNetworkUserGroup = "CHitboxComponent"
	// MNetworkAlias = "CHitboxComponent"
	// MNetworkTypeAlias = "CHitboxComponent"
	CHitboxComponent m_CHitboxComponent;
	// MNetworkEnable
	// MNetworkTypeAlias = "CDestructiblePartsSystemComponent*"
	CDestructiblePartsComponent* m_pDestructiblePartsSystemComponent;
	HitGroup_t m_LastHitGroup;
	CGlobalSymbol m_sLastDamageSourceName;
	Vector m_vLastDamagePosition;
	bool m_bInitModelEffects;
	bool m_bIsStaticProp;
	int32 m_nLastAddDecal;
	int32 m_nDecalsAdded;
	int32 m_iOldHealth;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnRenderModeChanged"
	RenderMode_t m_nRenderMode;
	// MNetworkEnable
	RenderFx_t m_nRenderFX;
	bool m_bAllowFadeInView;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnColorChanged"
	Color m_clrRender;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnRenderAttributesChanged"
	C_UtlVectorEmbeddedNetworkVar< EntityRenderAttribute_t > m_vecRenderAttributes;
	// MNetworkEnable
	bool m_bRenderToCubemaps;
	// MNetworkEnable
	bool m_bNoInterpolate;
	// MNetworkEnable
	CCollisionProperty m_Collision;
	// MNetworkEnable
	CGlowProperty m_Glow;
	// MNetworkEnable
	float32 m_flGlowBackfaceMult;
	// MNetworkEnable
	float32 m_fadeMinDist;
	// MNetworkEnable
	float32 m_fadeMaxDist;
	// MNetworkEnable
	float32 m_flFadeScale;
	// MNetworkEnable
	float32 m_flShadowStrength;
	// MNetworkEnable
	uint8 m_nObjectCulling;
	// MNetworkEnable
	int32 m_nAddDecal;
	// MNetworkEnable
	Vector m_vDecalPosition;
	// MNetworkEnable
	Vector m_vDecalForwardAxis;
	// MNetworkEnable
	float32 m_flDecalHealBloodRate;
	// MNetworkEnable
	float32 m_flDecalHealHeightRate;
	// MNetworkEnable
	DecalMode_t m_nDecalMode;
	// MNetworkEnable
	DecalMode_t m_nRequiredDecalMode;
	// MNetworkEnable
	C_NetworkUtlVectorBase< CHandle< C_BaseModelEntity > > m_ConfigEntitiesToPropagateMaterialDecalsTo;
	// MNetworkEnable
	// MNetworkPriority = 32
	// MNetworkUserGroup = "Player"
	// MNetworkChangeCallback = "OnViewOffsetChanged"
	CNetworkViewOffsetVector m_vecViewOffset;
	CClientAlphaProperty* m_pClientAlphaProperty;
	Color m_ClientOverrideTint;
	bool m_bUseClientOverrideTint;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnDisabledHitgroupsChanged"
	uint32[1] m_bvDisabledHitGroups;
};
