// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_INIT_InitialRepulsionVelocity : public CParticleFunctionInitializer
{
	// MPropertyFriendlyName = "collision group"
	char[128] m_CollisionGroupName;
	// MPropertyFriendlyName = "Trace Set"
	ParticleTraceSet_t m_nTraceSet;
	// MPropertyFriendlyName = "minimum velocity"
	// MVectorIsCoordinate
	Vector m_vecOutputMin;
	// MPropertyFriendlyName = "maximum velocity"
	// MVectorIsCoordinate
	Vector m_vecOutputMax;
	// MPropertyFriendlyName = "control point number"
	int32 m_nControlPointNumber;
	// MPropertyFriendlyName = "per particle world collision tests"
	bool m_bPerParticle;
	// MPropertyFriendlyName = "offset instead of accelerate"
	bool m_bTranslate;
	// MPropertyFriendlyName = "offset proportional to radius 0/1"
	bool m_bProportional;
	// MPropertyFriendlyName = "trace length"
	float32 m_flTraceLength;
	// MPropertyFriendlyName = "use radius for per particle trace length"
	bool m_bPerParticleTR;
	// MPropertyFriendlyName = "inherit from parent"
	bool m_bInherit;
	// MPropertyFriendlyName = "control points to broadcast to children (n + 1)"
	int32 m_nChildCP;
	// MPropertyFriendlyName = "child group ID to affect"
	int32 m_nChildGroupID;
};
