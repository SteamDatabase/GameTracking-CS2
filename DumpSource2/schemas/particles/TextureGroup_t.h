class TextureGroup_t
{
	bool m_bEnabled;
	bool m_bReplaceTextureWithGradient;
	CStrongHandle< InfoForResourceTypeCTextureBase > m_hTexture;
	CColorGradient m_Gradient;
	SpriteCardTextureType_t m_nTextureType;
	SpriteCardTextureChannel_t m_nTextureChannels;
	ParticleTextureLayerBlendType_t m_nTextureBlendMode;
	CParticleCollectionRendererFloatInput m_flTextureBlend;
	TextureControls_t m_TextureControls;
};
