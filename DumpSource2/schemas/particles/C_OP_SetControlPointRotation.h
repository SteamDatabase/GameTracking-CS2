// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_SetControlPointRotation : public CParticleFunctionPreEmission
{
	// MPropertyFriendlyName = "rotation axis"
	// MVectorIsCoordinate
	CParticleCollectionVecInput m_vecRotAxis;
	// MPropertyFriendlyName = "rotation rate"
	CParticleCollectionFloatInput m_flRotRate;
	// MPropertyFriendlyName = "control point"
	int32 m_nCP;
	// MPropertyFriendlyName = "local space control point"
	int32 m_nLocalCP;
};
