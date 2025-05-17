// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_RemapTransformOrientationToYaw : public CParticleFunctionOperator
{
	// MPropertyFriendlyName = "transform input"
	CParticleTransformInput m_TransformInput;
	// MPropertyFriendlyName = "rotation field"
	// MPropertyAttributeChoiceName = "particlefield_rotation"
	ParticleAttributeIndex_t m_nFieldOutput;
	// MPropertyFriendlyName = "rotation offset"
	float32 m_flRotOffset;
	// MPropertyFriendlyName = "spin strength"
	float32 m_flSpinStrength;
};
