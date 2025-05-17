// MNetworkVarNames = "float m_flEndDistance"
// MNetworkVarNames = "float m_flStartDistance"
// MNetworkVarNames = "float m_flFogFalloffExponent"
// MNetworkVarNames = "bool m_bHeightFogEnabled"
// MNetworkVarNames = "float m_flFogHeightWidth"
// MNetworkVarNames = "float m_flFogHeightEnd"
// MNetworkVarNames = "float m_flFogHeightStart"
// MNetworkVarNames = "float m_flFogHeightExponent"
// MNetworkVarNames = "float m_flLODBias"
// MNetworkVarNames = "bool m_bActive"
// MNetworkVarNames = "bool m_bStartDisabled"
// MNetworkVarNames = "float m_flFogMaxOpacity"
// MNetworkVarNames = "int m_nCubemapSourceType"
// MNetworkVarNames = "HMaterialStrong m_hSkyMaterial"
// MNetworkVarNames = "string_t m_iszSkyEntity"
// MNetworkVarNames = "HRenderTextureStrong m_hFogCubemapTexture"
// MNetworkVarNames = "bool m_bHasHeightFogEnd"
class C_EnvCubemapFog : public C_BaseEntity
{
	// MNetworkEnable
	float32 m_flEndDistance;
	// MNetworkEnable
	float32 m_flStartDistance;
	// MNetworkEnable
	float32 m_flFogFalloffExponent;
	// MNetworkEnable
	bool m_bHeightFogEnabled;
	// MNetworkEnable
	float32 m_flFogHeightWidth;
	// MNetworkEnable
	float32 m_flFogHeightEnd;
	// MNetworkEnable
	float32 m_flFogHeightStart;
	// MNetworkEnable
	float32 m_flFogHeightExponent;
	// MNetworkEnable
	float32 m_flLODBias;
	// MNetworkEnable
	bool m_bActive;
	// MNetworkEnable
	bool m_bStartDisabled;
	// MNetworkEnable
	float32 m_flFogMaxOpacity;
	// MNetworkEnable
	int32 m_nCubemapSourceType;
	// MNetworkEnable
	CStrongHandle< InfoForResourceTypeIMaterial2 > m_hSkyMaterial;
	// MNetworkEnable
	CUtlSymbolLarge m_iszSkyEntity;
	// MNetworkEnable
	CStrongHandle< InfoForResourceTypeCTextureBase > m_hFogCubemapTexture;
	// MNetworkEnable
	bool m_bHasHeightFogEnd;
	bool m_bFirstTime;
};
