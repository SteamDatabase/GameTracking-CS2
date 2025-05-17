// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_SetPerChildControlPoint : public CParticleFunctionOperator
{
	// MPropertyFriendlyName = "group ID to affect"
	int32 m_nChildGroupID;
	// MPropertyFriendlyName = "control point to set"
	int32 m_nFirstControlPoint;
	// MPropertyFriendlyName = "# of children to set"
	int32 m_nNumControlPoints;
	// MPropertyFriendlyName = "particle increment amount"
	CParticleCollectionFloatInput m_nParticleIncrement;
	// MPropertyFriendlyName = "first particle to copy"
	CParticleCollectionFloatInput m_nFirstSourcePoint;
	// MPropertyFriendlyName = "set orientation from velocity"
	bool m_bSetOrientation;
	// MPropertyFriendlyName = "orientation vector"
	// MPropertyAttributeChoiceName = "particlefield_vector"
	ParticleAttributeIndex_t m_nOrientationField;
	// MPropertyFriendlyName = "set number of children based on particle count"
	bool m_bNumBasedOnParticleCount;
};
