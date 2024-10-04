class C_EnvCubemapFog : public C_BaseEntity
{
	float32 m_flEndDistance;
	float32 m_flStartDistance;
	float32 m_flFogFalloffExponent;
	bool m_bHeightFogEnabled;
	float32 m_flFogHeightWidth;
	float32 m_flFogHeightEnd;
	float32 m_flFogHeightStart;
	float32 m_flFogHeightExponent;
	float32 m_flLODBias;
	bool m_bActive;
	bool m_bStartDisabled;
	float32 m_flFogMaxOpacity;
	int32 m_nCubemapSourceType;
	CStrongHandle< InfoForResourceTypeIMaterial2 > m_hSkyMaterial;
	CUtlSymbolLarge m_iszSkyEntity;
	CStrongHandle< InfoForResourceTypeCTextureBase > m_hFogCubemapTexture;
	bool m_bHasHeightFogEnd;
	bool m_bFirstTime;
};
