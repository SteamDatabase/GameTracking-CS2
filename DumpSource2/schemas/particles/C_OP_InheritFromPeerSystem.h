// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_InheritFromPeerSystem : public CParticleFunctionOperator
{
	// MPropertyFriendlyName = "read field"
	// MPropertyAttributeChoiceName = "particlefield"
	ParticleAttributeIndex_t m_nFieldOutput;
	// MPropertyFriendlyName = "written field"
	// MPropertyAttributeChoiceName = "particlefield"
	ParticleAttributeIndex_t m_nFieldInput;
	// MPropertyFriendlyName = "particle neighbor increment amount"
	int32 m_nIncrement;
	// MPropertyFriendlyName = "group id"
	int32 m_nGroupID;
};
