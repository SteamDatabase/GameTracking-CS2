// MNetworkOutOfPVSUpdates (UNKNOWN FOR PARSER)
// MNetworkVarNames = "WeaponGameplayAnimState m_iWeaponGameplayAnimState"
// MNetworkVarNames = "GameTime_t m_flWeaponGameplayAnimStateTimestamp"
// MNetworkVarNames = "GameTime_t m_flInspectCancelCompleteTime"
// MNetworkVarNames = "bool m_bInspectPending"
// MNetworkVarNames = "CSWeaponMode m_weaponMode"
// MNetworkVarNames = "float m_fAccuracyPenalty"
// MNetworkVarNames = "int m_iRecoilIndex"
// MNetworkVarNames = "float m_flRecoilIndex"
// MNetworkVarNames = "bool m_bBurstMode"
// MNetworkVarNames = "GameTick_t m_nPostponeFireReadyTicks"
// MNetworkVarNames = "float m_flPostponeFireReadyFrac"
// MNetworkVarNames = "bool m_bInReload"
// MNetworkVarNames = "GameTime_t m_flDisallowAttackAfterReloadStartUntilTime"
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
// MNetworkVarNames = "bool m_bWasActiveWeaponWhenDropped"
// MNetworkVarNames = "GameTime_t m_fLastShotTime"
// MNetworkVarNames = "int m_iIronSightMode"
// MNetworkVarNames = "float m_flWatTickOffset"
class CCSWeaponBase : public CBasePlayerWeapon
{
	bool m_bRemoveable;
	CUtlVector< HSequence > m_thirdPersonFireSequences;
	HSequence m_hCurrentThirdPersonSequence;
	HSequence[7] m_thirdPersonSequences;
	bool m_bPlayerAmmoStockOnPickup;
	bool m_bRequireUseToTouch;
	// MNetworkEnable
	// MNetworkChangeCallback = "WeaponGameplayAnimStateNetworkChangeCallback"
	WeaponGameplayAnimState m_iWeaponGameplayAnimState;
	// MNetworkEnable
	GameTime_t m_flWeaponGameplayAnimStateTimestamp;
	// MNetworkEnable
	GameTime_t m_flInspectCancelCompleteTime;
	// MNetworkEnable
	bool m_bInspectPending;
	bool m_bInspectShouldLoop;
	int32 m_nLastEmptySoundCmdNum;
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
	GameTime_t m_flDisallowAttackAfterReloadStartUntilTime;
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
	// MNetworkEnable
	bool m_bWasActiveWeaponWhenDropped;
	bool m_donated;
	// MNetworkEnable
	GameTime_t m_fLastShotTime;
	bool m_bWasOwnedByCT;
	bool m_bWasOwnedByTerrorist;
	int32 m_numRemoveUnownedWeaponThink;
	CIronSightController m_IronSightController;
	// MNetworkEnable
	int32 m_iIronSightMode;
	GameTime_t m_flLastLOSTraceFailureTime;
	// MNetworkEnable
	float32 m_flWatTickOffset;
};
