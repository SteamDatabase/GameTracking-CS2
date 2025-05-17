// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_RenderLightBeam : public CParticleFunctionRenderer
{
	// MPropertyFriendlyName = "Color Blend"
	CParticleCollectionVecInput m_vColorBlend;
	// MPropertyFriendlyName = "Color Blend Type"
	// MPropertySortPriority = 700
	ParticleColorBlendType_t m_nColorBlendType;
	// MPropertyFriendlyName = "Lumens Per Meter"
	CParticleCollectionFloatInput m_flBrightnessLumensPerMeter;
	// MPropertyFriendlyName = "Shadows"
	// MPropertySuppressExpr = "mod == csgo"
	bool m_bCastShadows;
	// MPropertyFriendlyName = "Skirt"
	CParticleCollectionFloatInput m_flSkirt;
	// MPropertyFriendlyName = "Range"
	CParticleCollectionFloatInput m_flRange;
	// MPropertyFriendlyName = "Thickness"
	CParticleCollectionFloatInput m_flThickness;
};
