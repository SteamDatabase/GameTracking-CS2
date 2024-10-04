class CEnvVolumetricFogVolume : public CBaseEntity
{
	bool m_bActive;
	Vector m_vBoxMins;
	Vector m_vBoxMaxs;
	bool m_bStartDisabled;
	float32 m_flStrength;
	int32 m_nFalloffShape;
	float32 m_flFalloffExponent;
	float32 m_flHeightFogDepth;
	float32 m_fHeightFogEdgeWidth;
	float32 m_fIndirectLightStrength;
	float32 m_fSunLightStrength;
	float32 m_fNoiseStrength;
	bool m_bOverrideIndirectLightStrength;
	bool m_bOverrideSunLightStrength;
	bool m_bOverrideNoiseStrength;
	bool m_bAllowLPVIndirect;
};
