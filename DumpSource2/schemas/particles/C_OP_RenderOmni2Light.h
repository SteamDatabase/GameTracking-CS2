// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_RenderOmni2Light : public CParticleFunctionRenderer
{
	// MPropertyFriendlyName = "Type"
	ParticleOmni2LightTypeChoiceList_t m_nLightType;
	// MPropertyFriendlyName = "Color Blend"
	CParticleCollectionVecInput m_vColorBlend;
	// MPropertyFriendlyName = "Color Blend Type"
	// MPropertySortPriority = 700
	ParticleColorBlendType_t m_nColorBlendType;
	ParticleLightUnitChoiceList_t m_nBrightnessUnit;
	// MPropertyFriendlyName = "Lumens"
	// MPropertySuppressExpr = "m_nBrightnessUnit != PARTICLE_LIGHT_UNIT_LUMENS"
	CPerParticleFloatInput m_flBrightnessLumens;
	// MPropertyFriendlyName = "Candelas"
	// MPropertySuppressExpr = "m_nBrightnessUnit != PARTICLE_LIGHT_UNIT_CANDELAS"
	CPerParticleFloatInput m_flBrightnessCandelas;
	// MPropertyFriendlyName = "Shadows"
	// MPropertySuppressExpr = "mod == csgo"
	bool m_bCastShadows;
	// MPropertyFriendlyName = "Fog"
	bool m_bFog;
	// MPropertyFriendlyName = "Fog Scale"
	// MPropertySuppressExpr = "!m_bFog"
	CPerParticleFloatInput m_flFogScale;
	// MPropertyFriendlyName = "Light Radius"
	CPerParticleFloatInput m_flLuminaireRadius;
	// MPropertyFriendlyName = "Skirt"
	CPerParticleFloatInput m_flSkirt;
	// MPropertyFriendlyName = "Range"
	CPerParticleFloatInput m_flRange;
	// MPropertyFriendlyName = "Inner Cone Angle"
	CPerParticleFloatInput m_flInnerConeAngle;
	// MPropertyFriendlyName = "Outer Cone Angle"
	CPerParticleFloatInput m_flOuterConeAngle;
	// MPropertyFriendlyName = "Cookie"
	CStrongHandle< InfoForResourceTypeCTextureBase > m_hLightCookie;
	// MPropertyFriendlyName = "Cookie is Spherically Mapped"
	bool m_bSphericalCookie;
};
