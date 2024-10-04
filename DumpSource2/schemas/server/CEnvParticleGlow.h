class CEnvParticleGlow : public CParticleSystem
{
	float32 m_flAlphaScale;
	float32 m_flRadiusScale;
	float32 m_flSelfIllumScale;
	Color m_ColorTint;
	CStrongHandle< InfoForResourceTypeCTextureBase > m_hTextureOverride;
};
