// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_TimeVaryingForce : public CParticleFunctionForce
{
	// MPropertyFriendlyName = "time to start transition"
	float32 m_flStartLerpTime;
	// MPropertyFriendlyName = "starting force"
	// MVectorIsCoordinate
	Vector m_StartingForce;
	// MPropertyFriendlyName = "time to end transition"
	float32 m_flEndLerpTime;
	// MPropertyFriendlyName = "ending force"
	// MVectorIsCoordinate
	Vector m_EndingForce;
};
