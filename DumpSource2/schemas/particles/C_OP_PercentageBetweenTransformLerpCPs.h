// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_PercentageBetweenTransformLerpCPs : public CParticleFunctionOperator
{
	// MPropertyFriendlyName = "output field"
	// MPropertyAttributeChoiceName = "particlefield_scalar"
	ParticleAttributeIndex_t m_nFieldOutput;
	// MPropertyFriendlyName = "percentage minimum"
	float32 m_flInputMin;
	// MPropertyFriendlyName = "percentage maximum"
	float32 m_flInputMax;
	// MPropertyFriendlyName = "strarting transform"
	CParticleTransformInput m_TransformStart;
	// MPropertyFriendlyName = "end transform"
	CParticleTransformInput m_TransformEnd;
	// MPropertyFriendlyName = "output starting control point number"
	int32 m_nOutputStartCP;
	// MPropertyFriendlyName = "output starting control point field 0-2 X/Y/Z"
	int32 m_nOutputStartField;
	// MPropertyFriendlyName = "output ending control point number"
	int32 m_nOutputEndCP;
	// MPropertyFriendlyName = "output ending control point field 0-2 X/Y/Z"
	int32 m_nOutputEndField;
	// MPropertyFriendlyName = "set value method"
	ParticleSetMethod_t m_nSetMethod;
	// MPropertyFriendlyName = "only active within input range"
	bool m_bActiveRange;
	// MPropertyFriendlyName = "treat distance between points as radius"
	bool m_bRadialCheck;
};
