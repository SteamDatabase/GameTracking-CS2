// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_INIT_LifespanFromVelocity : public CParticleFunctionInitializer
{
	// MPropertyFriendlyName = "bias distance"
	// MVectorIsCoordinate
	Vector m_vecComponentScale;
	// MPropertyFriendlyName = "trace offset"
	float32 m_flTraceOffset;
	// MPropertyFriendlyName = "maximum trace length"
	float32 m_flMaxTraceLength;
	// MPropertyFriendlyName = "trace recycle tolerance"
	float32 m_flTraceTolerance;
	// MPropertyFriendlyName = "maximum points to cache"
	int32 m_nMaxPlanes;
	// MPropertyFriendlyName = "trace collision group"
	char[128] m_CollisionGroupName;
	// MPropertyFriendlyName = "Trace Set"
	ParticleTraceSet_t m_nTraceSet;
	// MPropertyFriendlyName = "collide with water"
	bool m_bIncludeWater;
};
