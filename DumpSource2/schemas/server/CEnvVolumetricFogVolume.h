// MEntityAllowsPortraitWorldSpawn
// MNetworkVarNames = "bool m_bActive"
// MNetworkVarNames = "Vector m_vBoxMins"
// MNetworkVarNames = "Vector m_vBoxMaxs"
// MNetworkVarNames = "bool m_bStartDisabled"
// MNetworkVarNames = "float m_flStrength"
// MNetworkVarNames = "int m_nFalloffShape"
// MNetworkVarNames = "float m_flFalloffExponent"
// MNetworkVarNames = "float m_flHeightFogDepth"
// MNetworkVarNames = "float m_fHeightFogEdgeWidth"
// MNetworkVarNames = "float m_fIndirectLightStrength"
// MNetworkVarNames = "float m_fSunLightStrength"
// MNetworkVarNames = "float m_fNoiseStrength"
// MNetworkVarNames = "bool m_bOverrideIndirectLightStrength"
// MNetworkVarNames = "bool m_bOverrideSunLightStrength"
// MNetworkVarNames = "bool m_bOverrideNoiseStrength"
// MNetworkVarNames = "bool m_bAllowLPVIndirect"
class CEnvVolumetricFogVolume : public CBaseEntity
{
	// MNetworkEnable
	bool m_bActive;
	// MNetworkEnable
	Vector m_vBoxMins;
	// MNetworkEnable
	Vector m_vBoxMaxs;
	// MNetworkEnable
	bool m_bStartDisabled;
	// MNetworkEnable
	float32 m_flStrength;
	// MNetworkEnable
	int32 m_nFalloffShape;
	// MNetworkEnable
	float32 m_flFalloffExponent;
	// MNetworkEnable
	float32 m_flHeightFogDepth;
	// MNetworkEnable
	float32 m_fHeightFogEdgeWidth;
	// MNetworkEnable
	float32 m_fIndirectLightStrength;
	// MNetworkEnable
	float32 m_fSunLightStrength;
	// MNetworkEnable
	float32 m_fNoiseStrength;
	// MNetworkEnable
	bool m_bOverrideIndirectLightStrength;
	// MNetworkEnable
	bool m_bOverrideSunLightStrength;
	// MNetworkEnable
	bool m_bOverrideNoiseStrength;
	// MNetworkEnable
	bool m_bAllowLPVIndirect;
};
