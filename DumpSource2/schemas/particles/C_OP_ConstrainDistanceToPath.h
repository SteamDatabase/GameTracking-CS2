// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_ConstrainDistanceToPath : public CParticleFunctionConstraint
{
	// MPropertyFriendlyName = "minimum distance"
	float32 m_fMinDistance;
	// MPropertyFriendlyName = "maximum distance"
	float32 m_flMaxDistance0;
	// MPropertyFriendlyName = "maximum distance middle"
	float32 m_flMaxDistanceMid;
	// MPropertyFriendlyName = "maximum distance end"
	float32 m_flMaxDistance1;
	CPathParameters m_PathParameters;
	// MPropertyFriendlyName = "travel time"
	float32 m_flTravelTime;
	// MPropertyFriendlyName = "travel time scale field"
	// MPropertyAttributeChoiceName = "particlefield_scalar"
	ParticleAttributeIndex_t m_nFieldScale;
	// MPropertyFriendlyName = "manual time placement field"
	// MPropertyAttributeChoiceName = "particlefield_scalar"
	ParticleAttributeIndex_t m_nManualTField;
};
