// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_SetCPOrientationToGroundNormal : public CParticleFunctionOperator
{
	// MPropertyFriendlyName = "interpolation rate"
	float32 m_flInterpRate;
	// MPropertyFriendlyName = "max trace length"
	float32 m_flMaxTraceLength;
	// MPropertyFriendlyName = "CP movement tolerance"
	float32 m_flTolerance;
	// MPropertyFriendlyName = "trace offset"
	float32 m_flTraceOffset;
	// MPropertyFriendlyName = "collision group"
	char[128] m_CollisionGroupName;
	// MPropertyFriendlyName = "Trace Set"
	ParticleTraceSet_t m_nTraceSet;
	// MPropertyFriendlyName = "CP to trace from"
	int32 m_nInputCP;
	// MPropertyFriendlyName = "CP to set"
	int32 m_nOutputCP;
	// MPropertyFriendlyName = "include water"
	bool m_bIncludeWater;
};
