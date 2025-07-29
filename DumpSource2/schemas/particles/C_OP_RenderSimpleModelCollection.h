// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_RenderSimpleModelCollection : public CParticleFunctionRenderer
{
	// MPropertyStartGroup = "Orientation"
	// MPropertyFriendlyName = "center mesh"
	// MPropertySortPriority = 750
	bool m_bCenterOffset;
	// MPropertyStartGroup = "Model"
	// MPropertyFriendlyName = "model"
	CStrongHandle< InfoForResourceTypeCModel > m_hModel;
	// MPropertyFriendlyName = "input model override"
	CParticleModelInput m_modelInput;
	// MPropertyStartGroup = "Rendering"
	// MPropertyFriendlyName = "size cull scale"
	CParticleCollectionFloatInput m_fSizeCullScale;
	// MPropertyFriendlyName = "disable shadows"
	bool m_bDisableShadows;
	// MPropertyFriendlyName = "disable motion blur"
	bool m_bDisableMotionBlur;
	// MPropertyFriendlyName = "accept decals"
	bool m_bAcceptsDecals;
	// MPropertyFriendlyName = "render filter"
	CPerParticleFloatInput m_fDrawFilter;
	// MPropertyFriendlyName = "angular velocity attribute (improves motion blur)"
	// MPropertyAttributeChoiceName = "particlefield_vector"
	ParticleAttributeIndex_t m_nAngularVelocityField;
};
