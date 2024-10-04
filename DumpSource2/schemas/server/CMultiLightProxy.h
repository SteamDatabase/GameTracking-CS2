class CMultiLightProxy : public CLogicalEntity
{
	CUtlSymbolLarge m_iszLightNameFilter;
	CUtlSymbolLarge m_iszLightClassFilter;
	float32 m_flLightRadiusFilter;
	float32 m_flBrightnessDelta;
	bool m_bPerformScreenFade;
	float32 m_flTargetBrightnessMultiplier;
	float32 m_flCurrentBrightnessMultiplier;
	CUtlVector< CHandle< CLightEntity > > m_vecLights;
};
