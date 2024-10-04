class C_GradientFog : public C_BaseEntity
{
	CStrongHandle< InfoForResourceTypeCTextureBase > m_hGradientFogTexture;
	float32 m_flFogStartDistance;
	float32 m_flFogEndDistance;
	bool m_bHeightFogEnabled;
	float32 m_flFogStartHeight;
	float32 m_flFogEndHeight;
	float32 m_flFarZ;
	float32 m_flFogMaxOpacity;
	float32 m_flFogFalloffExponent;
	float32 m_flFogVerticalExponent;
	Color m_fogColor;
	float32 m_flFogStrength;
	float32 m_flFadeTime;
	bool m_bStartDisabled;
	bool m_bIsEnabled;
	bool m_bGradientFogNeedsTextures;
};
