// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_ConnectParentParticleToNearest : public CParticleFunctionOperator
{
	// MPropertyFriendlyName = "control point to set"
	int32 m_nFirstControlPoint;
	// MPropertyFriendlyName = "Second Control point to set"
	int32 m_nSecondControlPoint;
	// MPropertyFriendlyName = "Take radius into account for distance"
	bool m_bUseRadius;
	// MPropertyFriendlyName = "Radius scale for distance calc"
	// MPropertySuppressExpr = "!m_bUseRadius"
	CParticleCollectionFloatInput m_flRadiusScale;
	// MPropertyFriendlyName = "Parent radius scale for distance calc"
	// MPropertySuppressExpr = "!m_bUseRadius"
	CParticleCollectionFloatInput m_flParentRadiusScale;
};
