// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_MovementRotateParticleAroundAxis : public CParticleFunctionOperator
{
	// MPropertyFriendlyName = "rotation axis"
	// MVectorIsCoordinate
	CParticleCollectionVecInput m_vecRotAxis;
	// MPropertyFriendlyName = "rotation rate"
	CParticleCollectionFloatInput m_flRotRate;
	// MPropertyFriendlyName = "transform input"
	CParticleTransformInput m_TransformInput;
	// MPropertyFriendlyName = "use local space"
	bool m_bLocalSpace;
};
