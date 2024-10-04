class C_OP_RenderStatusEffectCitadel : public CParticleFunctionRenderer
{
	CStrongHandle< InfoForResourceTypeCTextureBase > m_pTextureColorWarp;
	CStrongHandle< InfoForResourceTypeCTextureBase > m_pTextureNormal;
	CStrongHandle< InfoForResourceTypeCTextureBase > m_pTextureMetalness;
	CStrongHandle< InfoForResourceTypeCTextureBase > m_pTextureRoughness;
	CStrongHandle< InfoForResourceTypeCTextureBase > m_pTextureSelfIllum;
	CStrongHandle< InfoForResourceTypeCTextureBase > m_pTextureDetail;
};
