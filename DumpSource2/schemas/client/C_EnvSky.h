// MEntityAllowsPortraitWorldSpawn
// MNetworkVarNames = "HMaterialStrong m_hSkyMaterial"
// MNetworkVarNames = "HMaterialStrong m_hSkyMaterialLightingOnly"
// MNetworkVarNames = "bool m_bStartDisabled"
// MNetworkVarNames = "Color m_vTintColor"
// MNetworkVarNames = "Color m_vTintColorLightingOnly"
// MNetworkVarNames = "float m_flBrightnessScale"
// MNetworkVarNames = "int m_nFogType"
// MNetworkVarNames = "float m_flFogMinStart"
// MNetworkVarNames = "float m_flFogMinEnd"
// MNetworkVarNames = "float m_flFogMaxStart"
// MNetworkVarNames = "float m_flFogMaxEnd"
// MNetworkVarNames = "bool m_bEnabled"
class C_EnvSky : public C_BaseModelEntity
{
	// MNetworkEnable
	// MNetworkChangeCallback = "SkyStateChanged"
	CStrongHandle< InfoForResourceTypeIMaterial2 > m_hSkyMaterial;
	// MNetworkEnable
	// MNetworkChangeCallback = "SkyStateChanged"
	CStrongHandle< InfoForResourceTypeIMaterial2 > m_hSkyMaterialLightingOnly;
	// MNetworkEnable
	// MNetworkChangeCallback = "SkyStateChanged"
	bool m_bStartDisabled;
	// MNetworkEnable
	// MNetworkChangeCallback = "SkyStateChanged"
	Color m_vTintColor;
	// MNetworkEnable
	// MNetworkChangeCallback = "SkyStateChanged"
	Color m_vTintColorLightingOnly;
	// MNetworkEnable
	// MNetworkChangeCallback = "SkyStateChanged"
	float32 m_flBrightnessScale;
	// MNetworkEnable
	// MNetworkChangeCallback = "SkyStateChanged"
	int32 m_nFogType;
	// MNetworkEnable
	// MNetworkChangeCallback = "SkyStateChanged"
	float32 m_flFogMinStart;
	// MNetworkEnable
	// MNetworkChangeCallback = "SkyStateChanged"
	float32 m_flFogMinEnd;
	// MNetworkEnable
	// MNetworkChangeCallback = "SkyStateChanged"
	float32 m_flFogMaxStart;
	// MNetworkEnable
	// MNetworkChangeCallback = "SkyStateChanged"
	float32 m_flFogMaxEnd;
	// MNetworkEnable
	// MNetworkChangeCallback = "SkyStateChanged"
	bool m_bEnabled;
};
