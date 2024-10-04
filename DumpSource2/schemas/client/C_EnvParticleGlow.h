class C_EnvParticleGlow : public C_ParticleSystem
{
	float32 m_flAlphaScale;
	float32 m_flRadiusScale;
	float32 m_flSelfIllumScale;
	Color m_ColorTint;
	CStrongHandle< InfoForResourceTypeCTextureBase > m_hTextureOverride;
}
