// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_RenderDeferredLight : public CParticleFunctionRenderer
{
	// MPropertyFriendlyName = "projected texture use alpha test window"
	// MPropertySuppressExpr = "!m_bUseTexture"
	bool m_bUseAlphaTestWindow;
	// MPropertyFriendlyName = "projected texture light"
	bool m_bUseTexture;
	// MPropertyStartGroup = "+Renderer Modifiers"
	// MPropertyFriendlyName = "radius scale"
	// MPropertySortPriority = 700
	float32 m_flRadiusScale;
	// MPropertyFriendlyName = "alpha scale"
	// MPropertySortPriority = 700
	float32 m_flAlphaScale;
	// MPropertyFriendlyName = "per-particle alpha scale attribute"
	// MPropertyAttributeChoiceName = "particlefield_scalar"
	// MPropertySortPriority = 700
	ParticleAttributeIndex_t m_nAlpha2Field;
	// MPropertyFriendlyName = "color blend"
	// MPropertySortPriority = 700
	CParticleCollectionVecInput m_vecColorScale;
	// MPropertyFriendlyName = "color blend type"
	// MPropertySortPriority = 700
	ParticleColorBlendType_t m_nColorBlendType;
	// MPropertyStartGroup = ""
	// MPropertyFriendlyName = "spotlight distance"
	float32 m_flLightDistance;
	// MPropertyFriendlyName = "light start falloff"
	float32 m_flStartFalloff;
	// MPropertyFriendlyName = "spotlight distance falloff"
	float32 m_flDistanceFalloff;
	// MPropertyFriendlyName = "spotlight FoV"
	float32 m_flSpotFoV;
	// MPropertyFriendlyName = "projected texture alpha test point scale field"
	// MPropertyAttributeChoiceName = "particlefield_scalar"
	// MPropertySuppressExpr = "!m_bUseTexture"
	ParticleAttributeIndex_t m_nAlphaTestPointField;
	// MPropertyFriendlyName = "projected texture alpha test range scale field"
	// MPropertyAttributeChoiceName = "particlefield_scalar"
	// MPropertySuppressExpr = "!m_bUseTexture"
	ParticleAttributeIndex_t m_nAlphaTestRangeField;
	// MPropertyFriendlyName = "projected texture alpha test sharpness scale field"
	// MPropertyAttributeChoiceName = "particlefield_scalar"
	// MPropertySuppressExpr = "!m_bUseTexture"
	ParticleAttributeIndex_t m_nAlphaTestSharpnessField;
	// MPropertyFriendlyName = "texture"
	// MPropertySuppressExpr = "!m_bUseTexture"
	CStrongHandle< InfoForResourceTypeCTextureBase > m_hTexture;
	// MPropertyFriendlyName = "HSV Shift Control Point"
	int32 m_nHSVShiftControlPoint;
};
