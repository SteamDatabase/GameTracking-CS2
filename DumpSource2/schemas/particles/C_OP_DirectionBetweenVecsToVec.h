// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_DirectionBetweenVecsToVec : public CParticleFunctionOperator
{
	// MPropertyFriendlyName = "output field"
	// MPropertyAttributeChoiceName = "particlefield_vector"
	ParticleAttributeIndex_t m_nFieldOutput;
	// MPropertyFriendlyName = "first vector"
	CPerParticleVecInput m_vecPoint1;
	// MPropertyFriendlyName = "second vector"
	CPerParticleVecInput m_vecPoint2;
};
