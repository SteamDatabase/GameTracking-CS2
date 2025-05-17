// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_PercentageBetweenTransformsVector : public CParticleFunctionOperator
{
	// MPropertyFriendlyName = "output field"
	// MPropertyAttributeChoiceName = "particlefield_vector"
	ParticleAttributeIndex_t m_nFieldOutput;
	// MPropertyFriendlyName = "percentage minimum"
	float32 m_flInputMin;
	// MPropertyFriendlyName = "percentage maximum"
	float32 m_flInputMax;
	// MPropertyFriendlyName = "output minimum"
	// MVectorIsSometimesCoordinate = "m_nFieldOutput"
	Vector m_vecOutputMin;
	// MPropertyFriendlyName = "output maximum"
	// MVectorIsSometimesCoordinate = "m_nFieldOutput"
	Vector m_vecOutputMax;
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
