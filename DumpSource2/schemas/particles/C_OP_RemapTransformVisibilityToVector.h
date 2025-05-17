// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_RemapTransformVisibilityToVector : public CParticleFunctionOperator
{
	// MPropertyFriendlyName = "set value method"
	ParticleSetMethod_t m_nSetMethod;
	// MPropertyFriendlyName = "transform input"
	CParticleTransformInput m_TransformInput;
	// MPropertyFriendlyName = "output field"
	// MPropertyAttributeChoiceName = "particlefield_vector"
	ParticleAttributeIndex_t m_nFieldOutput;
	// MPropertyFriendlyName = "CP visibility minimum"
	float32 m_flInputMin;
	// MPropertyFriendlyName = "CP visibility maximum"
	float32 m_flInputMax;
	// MPropertyFriendlyName = "output minimum"
	Vector m_vecOutputMin;
	// MPropertyFriendlyName = "output maximum"
	Vector m_vecOutputMax;
	// MPropertyFriendlyName = "visibility radius"
	float32 m_flRadius;
};
