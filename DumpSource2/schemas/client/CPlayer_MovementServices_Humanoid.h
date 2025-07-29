// MNetworkVarNames = "float32 m_flFallVelocity"
// MNetworkVarNames = "bool m_bInCrouch"
// MNetworkVarNames = "uint32 m_nCrouchState"
// MNetworkVarNames = "GameTime_t m_flCrouchTransitionStartTime"
// MNetworkVarNames = "bool m_bDucked"
// MNetworkVarNames = "bool m_bDucking"
// MNetworkVarNames = "bool m_bInDuckJump"
class CPlayer_MovementServices_Humanoid : public CPlayer_MovementServices
{
	float32 m_flStepSoundTime;
	// MNetworkEnable
	// MNetworkBitCount = 17
	// MNetworkMinValue = -4096.000000
	// MNetworkMaxValue = 4096.000000
	// MNetworkEncodeFlags = 4
	float32 m_flFallVelocity;
	// MNetworkEnable
	// MNetworkUserGroup = "LocalPlayerExclusive"
	bool m_bInCrouch;
	// MNetworkEnable
	// MNetworkUserGroup = "LocalPlayerExclusive"
	uint32 m_nCrouchState;
	// MNetworkEnable
	// MNetworkUserGroup = "LocalPlayerExclusive"
	GameTime_t m_flCrouchTransitionStartTime;
	// MNetworkEnable
	// MNetworkUserGroup = "LocalPlayerExclusive"
	bool m_bDucked;
	// MNetworkEnable
	// MNetworkUserGroup = "LocalPlayerExclusive"
	bool m_bDucking;
	// MNetworkEnable
	// MNetworkUserGroup = "LocalPlayerExclusive"
	bool m_bInDuckJump;
	Vector m_groundNormal;
	float32 m_flSurfaceFriction;
	CUtlStringToken m_surfaceProps;
	int32 m_nStepside;
};
