// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_INIT_RemapInitialDirectionToTransformToVector : public CParticleFunctionInitializer
{
	// MPropertyFriendlyName = "transform input"
	CParticleTransformInput m_TransformInput;
	// MPropertyFriendlyName = "output field"
	// MPropertyAttributeChoiceName = "particlefield_vector"
	ParticleAttributeIndex_t m_nFieldOutput;
	// MPropertyFriendlyName = "scale factor"
	float32 m_flScale;
	// MPropertyFriendlyName = "offset rotation"
	float32 m_flOffsetRot;
	// MPropertyFriendlyName = "offset axis"
	// MVectorIsCoordinate
	Vector m_vecOffsetAxis;
	// MPropertyFriendlyName = "normalize"
	bool m_bNormalize;
};
