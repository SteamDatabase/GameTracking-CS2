// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_RenderCables : public CParticleFunctionRenderer
{
	// MPropertyStartGroup = "Renderer Modifiers"
	// MPropertyFriendlyName = "Radius Scale"
	// MPropertySortPriority = 700
	CParticleCollectionFloatInput m_flRadiusScale;
	// MPropertyFriendlyName = "alpha scale"
	// MPropertySortPriority = 700
	CParticleCollectionFloatInput m_flAlphaScale;
	// MPropertyFriendlyName = "color blend"
	// MPropertySortPriority = 700
	CParticleCollectionVecInput m_vecColorScale;
	// MPropertyFriendlyName = "color blend type"
	// MPropertySortPriority = 700
	ParticleColorBlendType_t m_nColorBlendType;
	// MPropertyStartGroup = ""
	// MPropertyFriendlyName = "cable material"
	// MPropertyAttributeEditor = "AssetBrowse( vmat, *extraFilterString=(shader=cables.vfx) )"
	CStrongHandle< InfoForResourceTypeIMaterial2 > m_hMaterial;
	// MPropertyFriendlyName = "texture repetition mode"
	TextureRepetitionMode_t m_nTextureRepetitionMode;
	// MPropertyFriendlyName = "texture repetitions"
	CParticleCollectionFloatInput m_flTextureRepeatsPerSegment;
	// MPropertyFriendlyName = "texture repetitions around cable"
	CParticleCollectionFloatInput m_flTextureRepeatsCircumference;
	// MPropertyFriendlyName = "color map offset along path"
	CParticleCollectionFloatInput m_flColorMapOffsetV;
	// MPropertyFriendlyName = "color map offset around cable"
	CParticleCollectionFloatInput m_flColorMapOffsetU;
	// MPropertyFriendlyName = "normal map offset along path"
	CParticleCollectionFloatInput m_flNormalMapOffsetV;
	// MPropertyFriendlyName = "normal map offset around cable"
	CParticleCollectionFloatInput m_flNormalMapOffsetU;
	// MPropertyFriendlyName = "draw caps at each end of the cable"
	bool m_bDrawCableCaps;
	// MPropertyFriendlyName = "cable end cap shape factor"
	// MPropertyAttributeRange = "0 2"
	float32 m_flCapRoundness;
	// MPropertyFriendlyName = "cable end cap offset amount"
	// MPropertyAttributeRange = "0 2"
	float32 m_flCapOffsetAmount;
	// MPropertyFriendlyName = "tessellation scale factor"
	float32 m_flTessScale;
	// MPropertyFriendlyName = "minimum steps between particles"
	int32 m_nMinTesselation;
	// MPropertyFriendlyName = "maximum steps between particles"
	int32 m_nMaxTesselation;
	// MPropertyFriendlyName = "roundness factor"
	int32 m_nRoundness;
	// MPropertyFriendlyName = "diffuse lighting origin"
	// MParticleInputOptional
	CParticleTransformInput m_LightingTransform;
	// MPropertyFriendlyName = "material float variables"
	CUtlLeanVector< FloatInputMaterialVariable_t > m_MaterialFloatVars;
	// MPropertyFriendlyName = "material vector variables"
	CUtlLeanVector< VecInputMaterialVariable_t > m_MaterialVecVars;
};
