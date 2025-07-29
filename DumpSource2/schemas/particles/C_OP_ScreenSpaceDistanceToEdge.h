// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_ScreenSpaceDistanceToEdge : public CParticleFunctionOperator
{
	// MPropertyFriendlyName = "output field"
	// MPropertyAttributeChoiceName = "particlefield_scalar"
	ParticleAttributeIndex_t m_nFieldOutput;
	// MPropertyFriendlyName = "max distance from edge"
	CPerParticleFloatInput m_flMaxDistFromEdge;
	// MPropertyFriendlyName = "output"
	CParticleRemapFloatInput m_flOutputRemap;
	// MPropertyFriendlyName = "set value method"
	ParticleSetMethod_t m_nSetMethod;
};
