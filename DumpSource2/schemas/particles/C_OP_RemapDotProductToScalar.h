// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_RemapDotProductToScalar : public CParticleFunctionOperator
{
	// MPropertyFriendlyName = "first input control point"
	int32 m_nInputCP1;
	// MPropertyFriendlyName = "second input control point"
	int32 m_nInputCP2;
	// MPropertyFriendlyName = "output field"
	// MPropertyAttributeChoiceName = "particlefield_scalar"
	ParticleAttributeIndex_t m_nFieldOutput;
	// MPropertyFriendlyName = "input minimum (-1 to 1)"
	float32 m_flInputMin;
	// MPropertyFriendlyName = "input maximum (-1 to 1)"
	float32 m_flInputMax;
	// MPropertyFriendlyName = "output minimum"
	float32 m_flOutputMin;
	// MPropertyFriendlyName = "output maximum"
	float32 m_flOutputMax;
	// MPropertyFriendlyName = "use particle velocity for first input"
	bool m_bUseParticleVelocity;
	// MPropertyFriendlyName = "set value method"
	ParticleSetMethod_t m_nSetMethod;
	// MPropertyFriendlyName = "only active within specified input range"
	bool m_bActiveRange;
	// MPropertyFriendlyName = "use particle normal for first input"
	bool m_bUseParticleNormal;
};
