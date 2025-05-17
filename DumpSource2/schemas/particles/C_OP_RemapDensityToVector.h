// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_RemapDensityToVector : public CParticleFunctionOperator
{
	// MPropertyFriendlyName = "Radius scale for particle influence"
	float32 m_flRadiusScale;
	// MPropertyFriendlyName = "Output field"
	// MPropertyAttributeChoiceName = "particlefield_vector"
	ParticleAttributeIndex_t m_nFieldOutput;
	// MPropertyFriendlyName = "Density value to map to min value"
	float32 m_flDensityMin;
	// MPropertyFriendlyName = "Density value to map to max value"
	float32 m_flDensityMax;
	// MPropertyFriendlyName = "Output minimum"
	Vector m_vecOutputMin;
	// MPropertyFriendlyName = "Output maximum"
	Vector m_vecOutputMax;
	// MPropertyFriendlyName = "Use parent density instead of ours"
	bool m_bUseParentDensity;
	// MPropertyFriendlyName = "Resolution to use for creating a voxel grid"
	int32 m_nVoxelGridResolution;
};
