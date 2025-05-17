// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_RenderMaterialProxy : public CParticleFunctionRenderer
{
	// MPropertyFriendlyName = "Control Point for Model"
	int32 m_nMaterialControlPoint;
	// MPropertyFriendlyName = "proxy type"
	MaterialProxyType_t m_nProxyType;
	// MPropertyFriendlyName = "material variables"
	// MPropertyAutoExpandSelf
	CUtlVector< MaterialVariable_t > m_MaterialVars;
	// MPropertyFriendlyName = "material override"
	CStrongHandle< InfoForResourceTypeIMaterial2 > m_hOverrideMaterial;
	// MPropertyFriendlyName = "material override enable"
	CParticleCollectionFloatInput m_flMaterialOverrideEnabled;
	// MPropertyFriendlyName = "model tint"
	CParticleCollectionVecInput m_vecColorScale;
	// MPropertyFriendlyName = "model alpha"
	CPerParticleFloatInput m_flAlpha;
	// MPropertyFriendlyName = "model tint blend type"
	ParticleColorBlendType_t m_nColorBlendType;
};
