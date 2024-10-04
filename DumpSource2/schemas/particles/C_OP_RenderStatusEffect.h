class C_OP_RenderStatusEffect : public CParticleFunctionRenderer
{
	CStrongHandle< InfoForResourceTypeCTextureBase > m_pTextureColorWarp;
	CStrongHandle< InfoForResourceTypeCTextureBase > m_pTextureDetail2;
	CStrongHandle< InfoForResourceTypeCTextureBase > m_pTextureDiffuseWarp;
	CStrongHandle< InfoForResourceTypeCTextureBase > m_pTextureFresnelColorWarp;
	CStrongHandle< InfoForResourceTypeCTextureBase > m_pTextureFresnelWarp;
	CStrongHandle< InfoForResourceTypeCTextureBase > m_pTextureSpecularWarp;
	CStrongHandle< InfoForResourceTypeCTextureBase > m_pTextureEnvMap;
};
