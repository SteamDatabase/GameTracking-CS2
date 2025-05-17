// MNetworkExcludeByName = "m_flTimeWeaponIdle"
// MNetworkVarNames = "float m_flFireSequenceStartTime"
// MNetworkVarNames = "int m_nFireSequenceStartTimeChange"
// MNetworkVarNames = "PlayerAnimEvent_t m_ePlayerFireEvent"
// MNetworkVarNames = "WeaponAttackType_t m_ePlayerFireEventAttackType"
// MNetworkVarNames = "CSWeaponState_t m_iState"
// MNetworkVarNames = "uint32 m_nViewModelIndex"
// MNetworkVarNames = "GameTime_t m_flTimeWeaponIdle"
// MNetworkVarNames = "CSWeaponMode m_weaponMode"
// MNetworkVarNames = "float m_fAccuracyPenalty"
// MNetworkVarNames = "int m_iRecoilIndex"
// MNetworkVarNames = "float m_flRecoilIndex"
// MNetworkVarNames = "bool m_bBurstMode"
// MNetworkVarNames = "GameTick_t m_nPostponeFireReadyTicks"
// MNetworkVarNames = "float m_flPostponeFireReadyFrac"
// MNetworkVarNames = "bool m_bInReload"
// MNetworkVarNames = "bool m_bReloadVisuallyComplete"
// MNetworkVarNames = "GameTime_t m_flDroppedAtTime"
// MNetworkVarNames = "bool m_bIsHauledBack"
// MNetworkVarNames = "bool m_bSilencerOn"
// MNetworkVarNames = "GameTime_t m_flTimeSilencerSwitchComplete"
// MNetworkVarNames = "int m_iOriginalTeamNumber"
// MNetworkVarNames = "int m_iMostRecentTeamNumber"
// MNetworkVarNames = "bool m_bDroppedNearBuyZone"
// MNetworkVarNames = "GameTime_t m_nextPrevOwnerUseTime"
// MNetworkVarNames = "CHandle< CCSPlayerPawn> m_hPrevOwner"
// MNetworkVarNames = "GameTick_t m_nDropTick"
// MNetworkVarNames = "GameTime_t m_fLastShotTime"
// MNetworkVarNames = "int m_iIronSightMode"
// MNetworkVarNames = "int m_iNumEmptyAttacks"
class CCSWeaponBase : public CBasePlayerWeapon
{
	bool m_bRemoveable;
	// MNetworkEnable
	float32 m_flFireSequenceStartTime;
	// MNetworkEnable
	int32 m_nFireSequenceStartTimeChange;
	int32 m_nFireSequenceStartTimeAck;
	// MNetworkEnable
	PlayerAnimEvent_t m_ePlayerFireEvent;
	// MNetworkEnable
	WeaponAttackType_t m_ePlayerFireEventAttackType;
	HSequence m_seqIdle;
	HSequence m_seqFirePrimary;
	HSequence m_seqFireSecondary;
	CUtlVector< HSequence > m_thirdPersonFireSequences;
	HSequence m_hCurrentThirdPersonSequence;
	int32 m_nSilencerBoneIndex;
	HSequence[7] m_thirdPersonSequences;
	bool m_bPlayerAmmoStockOnPickup;
	bool m_bRequireUseToTouch;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnWeaponStateNetworkChange"
	CSWeaponState_t m_iState;
	GameTime_t m_flLastTimeInAir;
	int32 m_nLastEmptySoundCmdNum;
	// MNetworkEnable
	// MNetworkUserGroup = "LocalWeaponExclusive"
	uint32 m_nViewModelIndex;
	bool m_bReloadsWithClips;
	// MNetworkEnable
	// MNetworkUserGroup = "LocalWeaponExclusive"
	// MNetworkPriority = 32
	GameTime_t m_flTimeWeaponIdle;
	bool m_bFireOnEmpty;
	CEntityIOOutput m_OnPlayerPickup;
	// MNetworkEnable
	CSWeaponMode m_weaponMode;
	float32 m_flTurningInaccuracyDelta;
	Vector m_vecTurningInaccuracyEyeDirLast;
	float32 m_flTurningInaccuracy;
	// MNetworkEnable
	float32 m_fAccuracyPenalty;
	GameTime_t m_flLastAccuracyUpdateTime;
	float32 m_fAccuracySmoothedForZoom;
	GameTime_t m_fScopeZoomEndTime;
	// MNetworkEnable
	int32 m_iRecoilIndex;
	// MNetworkEnable
	float32 m_flRecoilIndex;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnWeaponBurstModeNetworkChange"
	bool m_bBurstMode;
	// MNetworkEnable
	GameTick_t m_nPostponeFireReadyTicks;
	// MNetworkEnable
	float32 m_flPostponeFireReadyFrac;
	// MNetworkEnable
	bool m_bInReload;
	// MNetworkEnable
	bool m_bReloadVisuallyComplete;
	// MNetworkEnable
	GameTime_t m_flDroppedAtTime;
	// MNetworkEnable
	bool m_bIsHauledBack;
	// MNetworkEnable
	bool m_bSilencerOn;
	// MNetworkEnable
	GameTime_t m_flTimeSilencerSwitchComplete;
	// MNetworkEnable
	int32 m_iOriginalTeamNumber;
	// MNetworkEnable
	int32 m_iMostRecentTeamNumber;
	// MNetworkEnable
	bool m_bDroppedNearBuyZone;
	float32 m_flNextAttackRenderTimeOffset;
	bool m_bCanBePickedUp;
	bool m_bUseCanOverrideNextOwnerTouchTime;
	GameTime_t m_nextOwnerTouchTime;
	GameTime_t m_nextPrevOwnerTouchTime;
	// MNetworkEnable
	GameTime_t m_nextPrevOwnerUseTime;
	// MNetworkEnable
	CHandle< CCSPlayerPawn > m_hPrevOwner;
	// MNetworkEnable
	GameTick_t m_nDropTick;
	bool m_donated;
	// MNetworkEnable
	GameTime_t m_fLastShotTime;
	bool m_bWasOwnedByCT;
	bool m_bWasOwnedByTerrorist;
	bool m_bFiredOutOfAmmoEvent;
	int32 m_numRemoveUnownedWeaponThink;
	CIronSightController m_IronSightController;
	// MNetworkEnable
	int32 m_iIronSightMode;
	GameTime_t m_flLastLOSTraceFailureTime;
	// MNetworkEnable
	int32 m_iNumEmptyAttacks;
	float32 m_flWatTickOffset;
};
