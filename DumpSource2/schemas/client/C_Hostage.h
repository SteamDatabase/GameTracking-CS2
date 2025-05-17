// MNetworkIncludeByName = "m_iMaxHealth"
// MNetworkIncludeByName = "m_iHealth"
// MNetworkIncludeByName = "m_lifeState"
// MNetworkIncludeByName = "m_fFlags"
// MNetworkIncludeByName = "m_vecViewOffset"
// MNetworkOverride = "m_vecViewOffset C_BaseModelEntity"
// MNetworkVarNames = "EntitySpottedState_t m_entitySpottedState"
// MNetworkVarNames = "CHandle< CBaseEntity> m_leader"
// MNetworkVarNames = "CountdownTimer m_reuseTimer"
// MNetworkVarNames = "Vector m_vel"
// MNetworkVarNames = "bool m_isRescued"
// MNetworkVarNames = "bool m_jumpedThisFrame"
// MNetworkVarNames = "int m_nHostageState"
// MNetworkVarNames = "bool m_bHandsHaveBeenCut"
// MNetworkVarNames = "CHandle< CCSPlayerPawn> m_hHostageGrabber"
// MNetworkVarNames = "GameTime_t m_flRescueStartTime"
// MNetworkVarNames = "GameTime_t m_flGrabSuccessTime"
// MNetworkVarNames = "GameTime_t m_flDropStartTime"
class C_Hostage : public C_BaseCombatCharacter
{
	// MNetworkEnable
	EntitySpottedState_t m_entitySpottedState;
	// MNetworkEnable
	CHandle< C_BaseEntity > m_leader;
	// MNetworkEnable
	CountdownTimer m_reuseTimer;
	// MNetworkEnable
	Vector m_vel;
	// MNetworkEnable
	// MNetworkChangeCallback = "RecvProxy_Rescued"
	bool m_isRescued;
	// MNetworkEnable
	// MNetworkChangeCallback = "RecvProxy_Jumped"
	bool m_jumpedThisFrame;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnHostageStateChanged"
	int32 m_nHostageState;
	// MNetworkEnable
	bool m_bHandsHaveBeenCut;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnGrabberChanged"
	CHandle< C_CSPlayerPawn > m_hHostageGrabber;
	GameTime_t m_fLastGrabTime;
	Vector m_vecGrabbedPos;
	// MNetworkEnable
	GameTime_t m_flRescueStartTime;
	// MNetworkEnable
	GameTime_t m_flGrabSuccessTime;
	// MNetworkEnable
	GameTime_t m_flDropStartTime;
	GameTime_t m_flDeadOrRescuedTime;
	CountdownTimer m_blinkTimer;
	Vector m_lookAt;
	CountdownTimer m_lookAroundTimer;
	bool m_isInit;
	AttachmentHandle_t m_eyeAttachment;
	AttachmentHandle_t m_chestAttachment;
	CBasePlayerController* m_pPredictionOwner;
	GameTime_t m_fNewestAlphaThinkTime;
};
