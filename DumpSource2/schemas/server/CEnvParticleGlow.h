// MNetworkVarNames = "float32 m_flAlphaScale"
// MNetworkVarNames = "float32 m_flRadiusScale"
// MNetworkVarNames = "float32 m_flSelfIllumScale"
// MNetworkVarNames = "Color m_ColorTint"
// MNetworkVarNames = "HRenderTextureStrong m_hTextureOverride"
class CEnvParticleGlow : public CParticleSystem
{
	// MNetworkEnable
	float32 m_flAlphaScale;
	// MNetworkEnable
	float32 m_flRadiusScale;
	// MNetworkEnable
	float32 m_flSelfIllumScale;
	// MNetworkEnable
	Color m_ColorTint;
	// MNetworkEnable
	CStrongHandle< InfoForResourceTypeCTextureBase > m_hTextureOverride;
};
