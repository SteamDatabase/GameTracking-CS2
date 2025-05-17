// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_PercentageBetweenTransforms : public CParticleFunctionOperator
{
	// MPropertyFriendlyName = "output field"
	// MPropertyAttributeChoiceName = "particlefield_scalar"
	ParticleAttributeIndex_t m_nFieldOutput;
	// MPropertyFriendlyName = "percentage minimum"
	float32 m_flInputMin;
	// MPropertyFriendlyName = "percentage maximum"
	float32 m_flInputMax;
	// MPropertyFriendlyName = "output minimum"
	float32 m_flOutputMin;
	// MPropertyFriendlyName = "output maximum"
	float32 m_flOutputMax;
	// MPropertyFriendlyName = "strarting transform"
	CParticleTransformInput m_TransformStart;
	// MPropertyFriendlyName = "end transform"
	CParticleTransformInput m_TransformEnd;
	// MPropertyFriendlyName = "set value method"
	ParticleSetMethod_t m_nSetMethod;
	// MPropertyFriendlyName = "only active within input range"
	bool m_bActiveRange;
	// MPropertyFriendlyName = "treat distance between points as radius"
	bool m_bRadialCheck;
};
