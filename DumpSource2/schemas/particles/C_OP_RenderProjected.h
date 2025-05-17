// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_RenderProjected : public CParticleFunctionRenderer
{
	// MPropertyFriendlyName = "project on characters"
	bool m_bProjectCharacter;
	// MPropertyFriendlyName = "project on world"
	bool m_bProjectWorld;
	// MPropertyFriendlyName = "project on water"
	bool m_bProjectWater;
	// MPropertyFriendlyName = "flip horizontal"
	bool m_bFlipHorizontal;
	// MPropertyFriendlyName = "enable projected depth controls"
	bool m_bEnableProjectedDepthControls;
	// MPropertyFriendlyName = "min projection depth"
	// MPropertySuppressExpr = "!m_bEnableProjectedDepthControls"
	float32 m_flMinProjectionDepth;
	// MPropertyFriendlyName = "max projection depth"
	// MPropertySuppressExpr = "!m_bEnableProjectedDepthControls"
	float32 m_flMaxProjectionDepth;
	// MPropertyFriendlyName = "materials"
	// MParticleRequireDefaultArrayEntry
	// MPropertyAutoExpandSelf
	CUtlVector< RenderProjectedMaterial_t > m_vecProjectedMaterials;
	// MPropertyFriendlyName = "material selection"
	CPerParticleFloatInput m_flMaterialSelection;
	// MPropertyFriendlyName = "sheet animation time scale"
	float32 m_flAnimationTimeScale;
	// MPropertyFriendlyName = "orient to normal"
	bool m_bOrientToNormal;
	// MPropertyFriendlyName = "material variables"
	// MPropertyAutoExpandSelf
	CUtlVector< MaterialVariable_t > m_MaterialVars;
	// MPropertyStartGroup = "+Renderer Modifiers"
	// MPropertyFriendlyName = "Radius Scale"
	// MPropertySortPriority = 700
	CParticleCollectionFloatInput m_flRadiusScale;
	// MPropertyFriendlyName = "alpha scale"
	// MPropertySortPriority = 700
	CParticleCollectionFloatInput m_flAlphaScale;
	// MPropertyFriendlyName = "rotation roll scale"
	// MPropertySortPriority = 700
	CParticleCollectionFloatInput m_flRollScale;
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
};
