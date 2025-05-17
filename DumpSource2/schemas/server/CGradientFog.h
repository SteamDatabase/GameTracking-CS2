// MNetworkVarNames = "HRenderTextureStrong m_hGradientFogTexture"
// MNetworkVarNames = "float m_flFogStartDistance"
// MNetworkVarNames = "float m_flFogEndDistance"
// MNetworkVarNames = "bool m_bHeightFogEnabled"
// MNetworkVarNames = "float m_flFogStartHeight"
// MNetworkVarNames = "float m_flFogEndHeight"
// MNetworkVarNames = "float m_flFarZ"
// MNetworkVarNames = "float m_flFogMaxOpacity"
// MNetworkVarNames = "float m_flFogFalloffExponent"
// MNetworkVarNames = "float m_flFogVerticalExponent"
// MNetworkVarNames = "Color m_fogColor"
// MNetworkVarNames = "float m_flFogStrength"
// MNetworkVarNames = "float m_flFadeTime"
// MNetworkVarNames = "bool m_bStartDisabled"
// MNetworkVarNames = "bool m_bIsEnabled"
class CGradientFog : public CBaseEntity
{
	// MNetworkEnable
	CStrongHandle< InfoForResourceTypeCTextureBase > m_hGradientFogTexture;
	// MNetworkEnable
	// MNetworkChangeCallback = "FogStateChanged"
	float32 m_flFogStartDistance;
	// MNetworkEnable
	// MNetworkChangeCallback = "FogStateChanged"
	float32 m_flFogEndDistance;
	// MNetworkEnable
	// MNetworkChangeCallback = "FogStateChanged"
	bool m_bHeightFogEnabled;
	// MNetworkEnable
	// MNetworkChangeCallback = "FogStateChanged"
	float32 m_flFogStartHeight;
	// MNetworkEnable
	// MNetworkChangeCallback = "FogStateChanged"
	float32 m_flFogEndHeight;
	// MNetworkEnable
	// MNetworkChangeCallback = "FogStateChanged"
	float32 m_flFarZ;
	// MNetworkEnable
	// MNetworkChangeCallback = "FogStateChanged"
	float32 m_flFogMaxOpacity;
	// MNetworkEnable
	// MNetworkChangeCallback = "FogStateChanged"
	float32 m_flFogFalloffExponent;
	// MNetworkEnable
	// MNetworkChangeCallback = "FogStateChanged"
	float32 m_flFogVerticalExponent;
	// MNetworkEnable
	// MNetworkChangeCallback = "FogStateChanged"
	Color m_fogColor;
	// MNetworkEnable
	// MNetworkChangeCallback = "FogStateChanged"
	float32 m_flFogStrength;
	// MNetworkEnable
	// MNetworkChangeCallback = "FogStateChanged"
	float32 m_flFadeTime;
	// MNetworkEnable
	bool m_bStartDisabled;
	// MNetworkEnable
	bool m_bIsEnabled;
	bool m_bGradientFogNeedsTextures;
};
