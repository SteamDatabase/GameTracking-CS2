// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_MovementPlaceOnGround : public CParticleFunctionOperator
{
	// MPropertyFriendlyName = "offset"
	CPerParticleFloatInput m_flOffset;
	// MPropertyFriendlyName = "max trace length"
	float32 m_flMaxTraceLength;
	// MPropertyFriendlyName = "CP movement tolerance"
	float32 m_flTolerance;
	// MPropertyFriendlyName = "trace offset"
	float32 m_flTraceOffset;
	// MPropertyFriendlyName = "interpolation rate"
	float32 m_flLerpRate;
	// MPropertyFriendlyName = "collision group"
	char[128] m_CollisionGroupName;
	// MPropertyFriendlyName = "Trace Set"
	ParticleTraceSet_t m_nTraceSet;
	// MPropertyFriendlyName = "reference CP 1"
	int32 m_nRefCP1;
	// MPropertyFriendlyName = "reference CP 2"
	int32 m_nRefCP2;
	// MPropertyFriendlyName = "interploation distance tolerance cp"
	int32 m_nLerpCP;
	// MPropertyFriendlyName = "No Collision Behavior"
	ParticleTraceMissBehavior_t m_nTraceMissBehavior;
	// MPropertyFriendlyName = "include default contents trace hulls"
	bool m_bIncludeShotHull;
	// MPropertyFriendlyName = "include water"
	bool m_bIncludeWater;
	// MPropertyFriendlyName = "set normal"
	bool m_bSetNormal;
	// MPropertyFriendlyName = "treat offset as scalar of particle radius"
	bool m_bScaleOffset;
	// MPropertyFriendlyName = "preserve initial Z-offset relative to cp"
	int32 m_nPreserveOffsetCP;
	// MPropertyFriendlyName = "CP Entity to Ignore for Collisions"
	int32 m_nIgnoreCP;
};
