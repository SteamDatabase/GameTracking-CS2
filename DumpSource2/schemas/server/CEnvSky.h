class CEnvSky : public CBaseModelEntity
{
	CStrongHandle< InfoForResourceTypeIMaterial2 > m_hSkyMaterial;
	CStrongHandle< InfoForResourceTypeIMaterial2 > m_hSkyMaterialLightingOnly;
	bool m_bStartDisabled;
	Color m_vTintColor;
	Color m_vTintColorLightingOnly;
	float32 m_flBrightnessScale;
	int32 m_nFogType;
	float32 m_flFogMinStart;
	float32 m_flFogMinEnd;
	float32 m_flFogMaxStart;
	float32 m_flFogMaxEnd;
	bool m_bEnabled;
}
