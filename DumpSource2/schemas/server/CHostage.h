// MNetworkVarNames = "EntitySpottedState_t m_entitySpottedState"
// MNetworkIncludeByName = "m_iMaxHealth"
// MNetworkIncludeByName = "m_iHealth"
// MNetworkIncludeByName = "m_lifeState"
// MNetworkIncludeByName = "m_fFlags"
// MNetworkIncludeByName = "m_vecViewOffset"
// MNetworkVarNames = "Vector m_vel"
// MNetworkVarNames = "bool m_isRescued"
// MNetworkVarNames = "bool m_jumpedThisFrame"
// MNetworkVarNames = "int m_nHostageState"
// MNetworkVarNames = "CHandle< CBaseEntity> m_leader"
// MNetworkVarNames = "CountdownTimer m_reuseTimer"
// MNetworkVarNames = "bool m_bHandsHaveBeenCut"
// MNetworkVarNames = "CHandle< CCSPlayerPawn> m_hHostageGrabber"
// MNetworkVarNames = "GameTime_t m_flRescueStartTime"
// MNetworkVarNames = "GameTime_t m_flGrabSuccessTime"
// MNetworkVarNames = "GameTime_t m_flDropStartTime"
class CHostage : public CHostageExpresserShim
{
	CEntityIOOutput m_OnHostageBeginGrab;
	CEntityIOOutput m_OnFirstPickedUp;
	CEntityIOOutput m_OnDroppedNotRescued;
	CEntityIOOutput m_OnRescued;
	// MNetworkEnable
	EntitySpottedState_t m_entitySpottedState;
	int32 m_nSpotRules;
	uint32 m_uiHostageSpawnExclusionGroupMask;
	uint32 m_nHostageSpawnRandomFactor;
	bool m_bRemove;
	// MNetworkEnable
	Vector m_vel;
	// MNetworkEnable
	bool m_isRescued;
	// MNetworkEnable
	bool m_jumpedThisFrame;
	// MNetworkEnable
	int32 m_nHostageState;
	// MNetworkEnable
	CHandle< CBaseEntity > m_leader;
	CHandle< CCSPlayerPawnBase > m_lastLeader;
	// MNetworkEnable
	CountdownTimer m_reuseTimer;
	bool m_hasBeenUsed;
	Vector m_accel;
	bool m_isRunning;
	bool m_isCrouching;
	CountdownTimer m_jumpTimer;
	bool m_isWaitingForLeader;
	CountdownTimer m_repathTimer;
	CountdownTimer m_inhibitDoorTimer;
	CountdownTimer m_inhibitObstacleAvoidanceTimer;
	CountdownTimer m_wiggleTimer;
	bool m_isAdjusted;
	// MNetworkEnable
	bool m_bHandsHaveBeenCut;
	// MNetworkEnable
	CHandle< CCSPlayerPawn > m_hHostageGrabber;
	GameTime_t m_fLastGrabTime;
	Vector m_vecPositionWhenStartedDroppingToGround;
	Vector m_vecGrabbedPos;
	// MNetworkEnable
	GameTime_t m_flRescueStartTime;
	// MNetworkEnable
	GameTime_t m_flGrabSuccessTime;
	// MNetworkEnable
	GameTime_t m_flDropStartTime;
	int32 m_nApproachRewardPayouts;
	int32 m_nPickupEventCount;
	Vector m_vecSpawnGroundPos;
	Vector m_vecHostageResetPosition;
};
