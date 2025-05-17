// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_ConstrainDistance : public CParticleFunctionConstraint
{
	// MPropertyFriendlyName = "minimum distance"
	CParticleCollectionFloatInput m_fMinDistance;
	// MPropertyFriendlyName = "maximum distance"
	CParticleCollectionFloatInput m_fMaxDistance;
	// MPropertyFriendlyName = "control point number"
	int32 m_nControlPointNumber;
	// MPropertyFriendlyName = "offset of center"
	// MVectorIsCoordinate
	Vector m_CenterOffset;
	// MPropertyFriendlyName = "global center point"
	bool m_bGlobalCenter;
};
