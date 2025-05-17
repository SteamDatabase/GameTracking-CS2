// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_INIT_OffsetVectorToVector : public CParticleFunctionInitializer
{
	// MPropertyFriendlyName = "input field"
	// MPropertyAttributeChoiceName = "particlefield_vector"
	ParticleAttributeIndex_t m_nFieldInput;
	// MPropertyFriendlyName = "output field"
	// MPropertyAttributeChoiceName = "particlefield_vector"
	ParticleAttributeIndex_t m_nFieldOutput;
	// MPropertyFriendlyName = "output offset minimum"
	// MVectorIsSometimesCoordinate = "m_nFieldOutput"
	Vector m_vecOutputMin;
	// MPropertyFriendlyName = "output offset maximum"
	// MVectorIsSometimesCoordinate = "m_nFieldOutput"
	Vector m_vecOutputMax;
	// MPropertyFriendlyName = "Random number generator controls"
	CRandomNumberGeneratorParameters m_randomnessParameters;
};
