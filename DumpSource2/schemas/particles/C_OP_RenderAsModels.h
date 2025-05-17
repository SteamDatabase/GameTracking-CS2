// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_RenderAsModels : public CParticleFunctionRenderer
{
	// MPropertyFriendlyName = "models"
	// MParticleRequireDefaultArrayEntry
	CUtlVector< ModelReference_t > m_ModelList;
	// MPropertyFriendlyName = "scale factor for radius"
	float32 m_flModelScale;
	// MPropertyFriendlyName = "scale model to match particle size"
	bool m_bFitToModelSize;
	// MPropertyFriendlyName = "non-uniform scaling"
	bool m_bNonUniformScaling;
	// MPropertyFriendlyName = "X axis scaling scalar field"
	// MPropertyAttributeChoiceName = "particlefield_scalar"
	ParticleAttributeIndex_t m_nXAxisScalingAttribute;
	// MPropertyFriendlyName = "Y axis scaling scalar field"
	// MPropertyAttributeChoiceName = "particlefield_scalar"
	ParticleAttributeIndex_t m_nYAxisScalingAttribute;
	// MPropertyFriendlyName = "Z axis scaling scalar field"
	// MPropertyAttributeChoiceName = "particlefield_scalar"
	ParticleAttributeIndex_t m_nZAxisScalingAttribute;
	// MPropertyFriendlyName = "model size cull bloat"
	// MPropertyAttributeChoiceName = "particlefield_size_cull_bloat"
	int32 m_nSizeCullBloat;
};
