// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_ReadFromNeighboringParticle : public CParticleFunctionOperator
{
	// MPropertyFriendlyName = "read field"
	// MPropertyAttributeChoiceName = "particlefield"
	ParticleAttributeIndex_t m_nFieldInput;
	// MPropertyFriendlyName = "written field"
	// MPropertyAttributeChoiceName = "particlefield"
	ParticleAttributeIndex_t m_nFieldOutput;
	// MPropertyFriendlyName = "particle increment amount"
	int32 m_nIncrement;
	// MPropertyFriendlyName = "maximum distance"
	CPerParticleFloatInput m_DistanceCheck;
	// MPropertyFriendlyName = "Interpolation"
	CPerParticleFloatInput m_flInterpolation;
};
