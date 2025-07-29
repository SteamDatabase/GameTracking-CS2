// MEntityAllowsPortraitWorldSpawn
// MNetworkVarNames = "float m_flScattering"
// MNetworkVarNames = "Color m_TintColor"
// MNetworkVarNames = "float m_flAnisotropy"
// MNetworkVarNames = "float m_flFadeSpeed"
// MNetworkVarNames = "float m_flDrawDistance"
// MNetworkVarNames = "float m_flFadeInStart"
// MNetworkVarNames = "float m_flFadeInEnd"
// MNetworkVarNames = "float m_flIndirectStrength"
// MNetworkVarNames = "int m_nVolumeDepth"
// MNetworkVarNames = "float m_fFirstVolumeSliceThickness"
// MNetworkVarNames = "int m_nIndirectTextureDimX"
// MNetworkVarNames = "int m_nIndirectTextureDimY"
// MNetworkVarNames = "int m_nIndirectTextureDimZ"
// MNetworkVarNames = "Vector m_vBoxMins"
// MNetworkVarNames = "Vector m_vBoxMaxs"
// MNetworkVarNames = "bool m_bActive"
// MNetworkVarNames = "GameTime_t m_flStartAnisoTime"
// MNetworkVarNames = "GameTime_t m_flStartScatterTime"
// MNetworkVarNames = "GameTime_t m_flStartDrawDistanceTime"
// MNetworkVarNames = "float m_flStartAnisotropy"
// MNetworkVarNames = "float m_flStartScattering"
// MNetworkVarNames = "float m_flStartDrawDistance"
// MNetworkVarNames = "float m_flDefaultAnisotropy"
// MNetworkVarNames = "float m_flDefaultScattering"
// MNetworkVarNames = "float m_flDefaultDrawDistance"
// MNetworkVarNames = "bool m_bStartDisabled"
// MNetworkVarNames = "bool m_bEnableIndirect"
// MNetworkVarNames = "bool m_bIsMaster"
// MNetworkVarNames = "HRenderTextureStrong m_hFogIndirectTexture"
// MNetworkVarNames = "int m_nForceRefreshCount"
// MNetworkVarNames = "float m_fNoiseSpeed"
// MNetworkVarNames = "float m_fNoiseStrength"
// MNetworkVarNames = "Vector m_vNoiseScale"
// MNetworkVarNames = "float m_fWindSpeed"
// MNetworkVarNames = "Vector m_vWindDirection"
class CEnvVolumetricFogController : public CBaseEntity
{
	// MNetworkEnable
	float32 m_flScattering;
	// MNetworkEnable
	Color m_TintColor;
	// MNetworkEnable
	float32 m_flAnisotropy;
	// MNetworkEnable
	float32 m_flFadeSpeed;
	// MNetworkEnable
	float32 m_flDrawDistance;
	// MNetworkEnable
	float32 m_flFadeInStart;
	// MNetworkEnable
	float32 m_flFadeInEnd;
	// MNetworkEnable
	float32 m_flIndirectStrength;
	// MNetworkEnable
	int32 m_nVolumeDepth;
	// MNetworkEnable
	float32 m_fFirstVolumeSliceThickness;
	// MNetworkEnable
	int32 m_nIndirectTextureDimX;
	// MNetworkEnable
	int32 m_nIndirectTextureDimY;
	// MNetworkEnable
	int32 m_nIndirectTextureDimZ;
	// MNetworkEnable
	Vector m_vBoxMins;
	// MNetworkEnable
	Vector m_vBoxMaxs;
	// MNetworkEnable
	bool m_bActive;
	// MNetworkEnable
	GameTime_t m_flStartAnisoTime;
	// MNetworkEnable
	GameTime_t m_flStartScatterTime;
	// MNetworkEnable
	GameTime_t m_flStartDrawDistanceTime;
	// MNetworkEnable
	float32 m_flStartAnisotropy;
	// MNetworkEnable
	float32 m_flStartScattering;
	// MNetworkEnable
	float32 m_flStartDrawDistance;
	// MNetworkEnable
	float32 m_flDefaultAnisotropy;
	// MNetworkEnable
	float32 m_flDefaultScattering;
	// MNetworkEnable
	float32 m_flDefaultDrawDistance;
	// MNetworkEnable
	bool m_bStartDisabled;
	// MNetworkEnable
	bool m_bEnableIndirect;
	// MNetworkEnable
	bool m_bIsMaster;
	// MNetworkEnable
	CStrongHandle< InfoForResourceTypeCTextureBase > m_hFogIndirectTexture;
	// MNetworkEnable
	int32 m_nForceRefreshCount;
	// MNetworkEnable
	float32 m_fNoiseSpeed;
	// MNetworkEnable
	float32 m_fNoiseStrength;
	// MNetworkEnable
	Vector m_vNoiseScale;
	// MNetworkEnable
	float32 m_fWindSpeed;
	// MNetworkEnable
	Vector m_vWindDirection;
	bool m_bFirstTime;
};
