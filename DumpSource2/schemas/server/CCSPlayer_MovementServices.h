// MNetworkVarNames = "int m_nLadderSurfacePropIndex"
// MNetworkVarNames = "bool m_bDucked"
// MNetworkVarNames = "float m_flDuckAmount"
// MNetworkVarNames = "float m_flDuckSpeed"
// MNetworkVarNames = "bool m_bDuckOverride"
// MNetworkVarNames = "bool m_bDesiresDuck"
// MNetworkVarNames = "bool m_bDucking"
// MNetworkVarNames = "float m_flDuckOffset"
// MNetworkVarNames = "uint32 m_nDuckTimeMsecs"
// MNetworkVarNames = "uint32 m_nDuckJumpTimeMsecs"
// MNetworkVarNames = "uint32 m_nJumpTimeMsecs"
// MNetworkVarNames = "float m_flLastDuckTime"
// MNetworkVarNames = "int m_nGameCodeHasMovedPlayerAfterCommand"
// MNetworkVarNames = "GameTime_t m_fStashGrenadeParameterWhen"
// MNetworkVarNames = "ButtonBitMask_t m_nButtonDownMaskPrev"
// MNetworkVarNames = "float m_flOffsetTickCompleteTime"
// MNetworkVarNames = "float m_flOffsetTickStashedSpeed"
// MNetworkVarNames = "float m_flStamina"
// MNetworkVarNames = "CCSPlayerLegacyJump m_LegacyJump"
// MNetworkVarNames = "CCSPlayerModernJump m_ModernJump"
// MNetworkVarNames = "GameTick_t m_nLastJumpTick"
// MNetworkVarNames = "float m_flLastJumpFrac"
// MNetworkVarNames = "float m_flLastJumpVelocityZ"
// MNetworkVarNames = "bool m_bJumpApexPending"
// MNetworkVarNames = "bool m_bWasSurfing"
class CCSPlayer_MovementServices : public CPlayer_MovementServices_Humanoid
{
	Vector m_vecLadderNormal;
	// MNetworkEnable
	int32 m_nLadderSurfacePropIndex;
	// MNetworkEnable
	// MNetworkUserGroup = "LocalPlayerExclusive"
	bool m_bDucked;
	// MNetworkEnable
	float32 m_flDuckAmount;
	// MNetworkEnable
	float32 m_flDuckSpeed;
	// MNetworkEnable
	bool m_bDuckOverride;
	// MNetworkEnable
	bool m_bDesiresDuck;
	// MNetworkEnable
	// MNetworkUserGroup = "LocalPlayerExclusive"
	bool m_bDucking;
	// MNetworkEnable
	float32 m_flDuckOffset;
	// MNetworkEnable
	// MNetworkUserGroup = "LocalPlayerExclusive"
	// MNetworkPriority = 32
	uint32 m_nDuckTimeMsecs;
	// MNetworkEnable
	// MNetworkUserGroup = "LocalPlayerExclusive"
	uint32 m_nDuckJumpTimeMsecs;
	// MNetworkEnable
	// MNetworkUserGroup = "LocalPlayerExclusive"
	uint32 m_nJumpTimeMsecs;
	// MNetworkEnable
	// MNetworkUserGroup = "LocalPlayerExclusive"
	float32 m_flLastDuckTime;
	Vector2D m_vecLastPositionAtFullCrouchSpeed;
	bool m_duckUntilOnGround;
	bool m_bHasWalkMovedSinceLastJump;
	bool m_bInStuckTest;
	int32 m_nTraceCount;
	int32 m_StuckLast;
	bool m_bSpeedCropped;
	int32 m_nOldWaterLevel;
	float32 m_flWaterEntryTime;
	Vector m_vecForward;
	Vector m_vecLeft;
	Vector m_vecUp;
	// MNetworkEnable
	// MNetworkUserGroup = "LocalPlayerExclusive"
	int32 m_nGameCodeHasMovedPlayerAfterCommand;
	bool m_bMadeFootstepNoise;
	int32 m_iFootsteps;
	// MNetworkEnable
	GameTime_t m_fStashGrenadeParameterWhen;
	// MNetworkEnable
	uint64 m_nButtonDownMaskPrev;
	// MNetworkEnable
	float32 m_flOffsetTickCompleteTime;
	// MNetworkEnable
	float32 m_flOffsetTickStashedSpeed;
	// MNetworkEnable
	float32 m_flStamina;
	float32 m_flHeightAtJumpStart;
	float32 m_flMaxJumpHeightThisJump;
	float32 m_flMaxJumpHeightLastJump;
	float32 m_flStaminaAtJumpStart;
	float32 m_flVelMulAtJumpStart;
	float32 m_flAccumulatedJumpError;
	// MNetworkEnable
	CCSPlayerLegacyJump m_LegacyJump;
	// MNetworkEnable
	CCSPlayerModernJump m_ModernJump;
	// MNetworkEnable
	GameTick_t m_nLastJumpTick;
	// MNetworkEnable
	// MNetworkBitCount = 6
	// MNetworkMinValue = 0.000000
	// MNetworkMaxValue = 1.000000
	// MNetworkEncodeFlags = 4
	float32 m_flLastJumpFrac;
	// MNetworkEnable
	float32 m_flLastJumpVelocityZ;
	// MNetworkEnable
	bool m_bJumpApexPending;
	float32 m_flTicksSinceLastSurfingDetected;
	// MNetworkEnable
	bool m_bWasSurfing;
	Vector m_vecInputRotated;
};
