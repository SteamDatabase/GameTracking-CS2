// MNetworkVarNames = "float32 m_flFallVelocity"
class CPlayer_MovementServices_Humanoid : public CPlayer_MovementServices
{
	float32 m_flStepSoundTime;
	// MNetworkEnable
	// MNetworkMinValue = -16384.000000
	// MNetworkMaxValue = 16384.000000
	// MNetworkEncodeFlags = 4
	// MNetworkBitCount = 20
	float32 m_flFallVelocity;
	// MNotSaved
	Vector m_groundNormal;
	float32 m_flSurfaceFriction;
	// MNotSaved
	CUtlStringToken m_surfaceProps;
	int32 m_nStepside;
};
