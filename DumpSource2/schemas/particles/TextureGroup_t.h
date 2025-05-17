// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class TextureGroup_t
{
	// MPropertyFriendlyName = "Enabled"
	bool m_bEnabled;
	// MPropertyFriendlyName = "Author Texture As Gradient"
	// MPropertySuppressExpr = "( m_nTextureType == SPRITECARD_TEXTURE_NORMALMAP || m_nTextureType == SPRITECARD_TEXTURE_ANIMMOTIONVEC || m_nTextureType == SPRITECARD_TEXTURE_6POINT_XYZ_A || m_nTextureType == SPRITECARD_TEXTURE_6POINT_NEGXYZ_E )"
	bool m_bReplaceTextureWithGradient;
	// MPropertyFriendlyName = "Texture"
	// MPropertySuppressExpr = "m_bReplaceTextureWithGradient"
	// MPropertyAttributeEditor = "AssetBrowse( vtex, *showassetpreview )"
	CStrongHandle< InfoForResourceTypeCTextureBase > m_hTexture;
	// MPropertyFriendlyName = "Gradient"
	// MPropertySuppressExpr = "!m_bReplaceTextureWithGradient"
	CColorGradient m_Gradient;
	// MPropertyFriendlyName = "Texture Type"
	SpriteCardTextureType_t m_nTextureType;
	// MPropertyFriendlyName = "Channel Mix"
	// MPropertySuppressExpr = "( m_nTextureType == SPRITECARD_TEXTURE_NORMALMAP || m_nTextureType == SPRITECARD_TEXTURE_ANIMMOTIONVEC || m_nTextureType == SPRITECARD_TEXTURE_6POINT_XYZ_A || m_nTextureType == SPRITECARD_TEXTURE_6POINT_NEGXYZ_E )"
	SpriteCardTextureChannel_t m_nTextureChannels;
	// MPropertyFriendlyName = "Mix Blend Mode"
	// MPropertySuppressExpr = "( m_nTextureType == SPRITECARD_TEXTURE_NORMALMAP || m_nTextureType == SPRITECARD_TEXTURE_ANIMMOTIONVEC || m_nTextureType == SPRITECARD_TEXTURE_6POINT_XYZ_A || m_nTextureType == SPRITECARD_TEXTURE_6POINT_NEGXYZ_E )"
	ParticleTextureLayerBlendType_t m_nTextureBlendMode;
	// MPropertyFriendlyName = "Blend Amount"
	// MPropertySuppressExpr = "( m_nTextureType == SPRITECARD_TEXTURE_NORMALMAP || m_nTextureType == SPRITECARD_TEXTURE_ANIMMOTIONVEC || m_nTextureType == SPRITECARD_TEXTURE_6POINT_XYZ_A || m_nTextureType == SPRITECARD_TEXTURE_6POINT_NEGXYZ_E )"
	CParticleCollectionRendererFloatInput m_flTextureBlend;
	// MPropertyFriendlyName = "Texture Controls"
	// MPropertySuppressExpr = "( m_nTextureType == SPRITECARD_TEXTURE_NORMALMAP || m_nTextureType == SPRITECARD_TEXTURE_ANIMMOTIONVEC || m_nTextureType == SPRITECARD_TEXTURE_6POINT_XYZ_A || m_nTextureType == SPRITECARD_TEXTURE_6POINT_NEGXYZ_E )"
	TextureControls_t m_TextureControls;
};
