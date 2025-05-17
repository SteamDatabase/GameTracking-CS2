// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class TextureControls_t
{
	// MPropertyFriendlyName = "horizontal texture scale"
	CParticleCollectionRendererFloatInput m_flFinalTextureScaleU;
	// MPropertyFriendlyName = "vertical texture scale"
	CParticleCollectionRendererFloatInput m_flFinalTextureScaleV;
	// MPropertyFriendlyName = "horizontal texture offset"
	CParticleCollectionRendererFloatInput m_flFinalTextureOffsetU;
	// MPropertyFriendlyName = "vertical texture offset"
	CParticleCollectionRendererFloatInput m_flFinalTextureOffsetV;
	// MPropertyFriendlyName = "texture rotation / animation rate scale"
	CParticleCollectionRendererFloatInput m_flFinalTextureUVRotation;
	// MPropertyFriendlyName = "Infinite Zoom Scale"
	CParticleCollectionRendererFloatInput m_flZoomScale;
	// MPropertyFriendlyName = "Distortion Amount"
	CParticleCollectionRendererFloatInput m_flDistortion;
	// MPropertyFriendlyName = "Randomize Initial Offset"
	bool m_bRandomizeOffsets;
	// MPropertyFriendlyName = "Clamp UVs"
	bool m_bClampUVs;
	// MPropertyFriendlyName = "per-particle scalar for blend"
	SpriteCardPerParticleScale_t m_nPerParticleBlend;
	// MPropertyFriendlyName = "per-particle scalar for scale"
	SpriteCardPerParticleScale_t m_nPerParticleScale;
	// MPropertyFriendlyName = "per-particle scalar for horizontal offset"
	SpriteCardPerParticleScale_t m_nPerParticleOffsetU;
	// MPropertyFriendlyName = "per-particle scalar for vertical offset"
	SpriteCardPerParticleScale_t m_nPerParticleOffsetV;
	// MPropertyFriendlyName = "per-particle scalar for rotation"
	SpriteCardPerParticleScale_t m_nPerParticleRotation;
	// MPropertyFriendlyName = "per-particle scalar for zoom"
	SpriteCardPerParticleScale_t m_nPerParticleZoom;
	// MPropertyFriendlyName = "per-particle scalar for distortion"
	SpriteCardPerParticleScale_t m_nPerParticleDistortion;
};
