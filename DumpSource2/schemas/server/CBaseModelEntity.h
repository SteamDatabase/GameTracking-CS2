// MNetworkVarNames = "CRenderComponent::Storage_t m_CRenderComponent"
// MNetworkVarNames = "CHitboxComponent::Storage_t m_CHitboxComponent"
// MNetworkVarNames = "CDestructiblePartsSystemComponent * m_pDestructiblePartsSystemComponent"
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
// MNetworkVarNames = "CHandle< CBaseModelEntity > m_ConfigEntitiesToPropagateMaterialDecalsTo"
// MNetworkVarNames = "CNetworkViewOffsetVector m_vecViewOffset"
class CBaseModelEntity : public CBaseEntity
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
	HitGroup_t m_nDestructiblePartInitialStateDestructed0;
	HitGroup_t m_nDestructiblePartInitialStateDestructed1;
	HitGroup_t m_nDestructiblePartInitialStateDestructed2;
	HitGroup_t m_nDestructiblePartInitialStateDestructed3;
	HitGroup_t m_nDestructiblePartInitialStateDestructed4;
	int32 m_nDestructiblePartInitialStateDestructed0_PartIndex;
	int32 m_nDestructiblePartInitialStateDestructed1_PartIndex;
	int32 m_nDestructiblePartInitialStateDestructed2_PartIndex;
	int32 m_nDestructiblePartInitialStateDestructed3_PartIndex;
	int32 m_nDestructiblePartInitialStateDestructed4_PartIndex;
	// MNetworkEnable
	CDestructiblePartsSystemComponent* m_pDestructiblePartsSystemComponent;
	HitGroup_t m_LastHitGroup;
	CGlobalSymbol m_sLastDamageSourceName;
	Vector m_vLastDamagePosition;
	GameTime_t m_flDissolveStartTime;
	CEntityIOOutput m_OnIgnite;
	// MNetworkEnable
	RenderMode_t m_nRenderMode;
	// MNetworkEnable
	RenderFx_t m_nRenderFX;
	bool m_bAllowFadeInView;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnColorChanged"
	Color m_clrRender;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnRenderAttributesChanged"
	CUtlVectorEmbeddedNetworkVar< EntityRenderAttribute_t > m_vecRenderAttributes;
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
	CNetworkUtlVectorBase< CHandle< CBaseModelEntity > > m_ConfigEntitiesToPropagateMaterialDecalsTo;
	// MNetworkEnable
	// MNetworkPriority = 32
	// MNetworkUserGroup = "Player"
	CNetworkViewOffsetVector m_vecViewOffset;
};
