// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_MovementLoopInsideSphere : public CParticleFunctionOperator
{
	// MPropertyFriendlyName = "control point"
	int32 m_nCP;
	// MPropertyFriendlyName = "distance maximum"
	CParticleCollectionFloatInput m_flDistance;
	// MPropertyFriendlyName = "component scale"
	CParticleCollectionVecInput m_vecScale;
	// MPropertyFriendlyName = "distance squared output attribute"
	// MPropertyAttributeChoiceName = "particlefield_scalar"
	ParticleAttributeIndex_t m_nDistSqrAttr;
};
