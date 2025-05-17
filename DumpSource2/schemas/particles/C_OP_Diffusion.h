// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_Diffusion : public CParticleFunctionOperator
{
	// MPropertyFriendlyName = "Radius scale for particle influence"
	float32 m_flRadiusScale;
	// MPropertyFriendlyName = "Output field"
	// MPropertyAttributeChoiceName = "particlefield_vector"
	ParticleAttributeIndex_t m_nFieldOutput;
	// MPropertyFriendlyName = "Resolution to use for creating a voxel grid"
	int32 m_nVoxelGridResolution;
};
