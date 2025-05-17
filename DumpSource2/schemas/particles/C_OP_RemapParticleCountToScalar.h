// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_RemapParticleCountToScalar : public CParticleFunctionOperator
{
	// MPropertyFriendlyName = "output field"
	// MPropertyAttributeChoiceName = "particlefield_scalar"
	ParticleAttributeIndex_t m_nFieldOutput;
	// MPropertyFriendlyName = "input minimum"
	CParticleCollectionFloatInput m_nInputMin;
	// MPropertyFriendlyName = "input maximum"
	CParticleCollectionFloatInput m_nInputMax;
	// MPropertyFriendlyName = "output minimum"
	CParticleCollectionFloatInput m_flOutputMin;
	// MPropertyFriendlyName = "output maximum"
	CParticleCollectionFloatInput m_flOutputMax;
	// MPropertyFriendlyName = ""
	bool m_bActiveRange;
	// MPropertyFriendlyName = "set value method"
	ParticleSetMethod_t m_nSetMethod;
};
