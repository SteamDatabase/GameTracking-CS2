// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_ClampVector : public CParticleFunctionOperator
{
	// MPropertyFriendlyName = "output field"
	// MPropertyAttributeChoiceName = "particlefield_vector"
	ParticleAttributeIndex_t m_nFieldOutput;
	// MPropertyFriendlyName = "output minimum"
	// MVectorIsSometimesCoordinate = "m_nFieldOutput"
	CPerParticleVecInput m_vecOutputMin;
	// MPropertyFriendlyName = "output maximum"
	// MVectorIsSometimesCoordinate = "m_nFieldOutput"
	CPerParticleVecInput m_vecOutputMax;
};
