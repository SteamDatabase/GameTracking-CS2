// MNetworkOutOfPVSUpdates (UNKNOWN FOR PARSER)
// MNetworkVarNames = "WeaponGameplayAnimState m_iWeaponGameplayAnimState"
// MNetworkVarNames = "GameTime_t m_flWeaponGameplayAnimStateTimestamp"
// MNetworkVarNames = "GameTime_t m_flInspectCancelCompleteTime"
// MNetworkVarNames = "bool m_bInspectPending"
// MNetworkVarNames = "bool m_bInspectShouldLoop"
// MNetworkVarNames = "CSWeaponMode m_weaponMode"
// MNetworkVarNames = "float m_fAccuracyPenalty"
// MNetworkVarNames = "int m_iRecoilIndex"
// MNetworkVarNames = "float m_flRecoilIndex"
// MNetworkVarNames = "bool m_bBurstMode"
// MNetworkVarNames = "GameTick_t m_nPostponeFireReadyTicks"
// MNetworkVarNames = "float m_flPostponeFireReadyFrac"
// MNetworkVarNames = "bool m_bInReload"
// MNetworkVarNames = "GameTime_t m_flDroppedAtTime"
// MNetworkVarNames = "bool m_bIsHauledBack"
// MNetworkVarNames = "bool m_bSilencerOn"
// MNetworkVarNames = "GameTime_t m_flTimeSilencerSwitchComplete"
// MNetworkVarNames = "float m_flWeaponActionPlaybackRate"
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
// MNetworkVarNames = "GameTime_t m_flLastShakeTime"
class C_CSWeaponBase : public C_BasePlayerWeapon
{
	// MNetworkEnable
	// MNetworkChangeCallback = "WeaponGameplayAnimStateNetworkChangeCallback"
	WeaponGameplayAnimState m_iWeaponGameplayAnimState;
	// MNetworkEnable
	GameTime_t m_flWeaponGameplayAnimStateTimestamp;
	// MNetworkEnable
	GameTime_t m_flInspectCancelCompleteTime;
	// MNetworkEnable
	bool m_bInspectPending;
	// MNetworkEnable
	bool m_bInspectShouldLoop;
	float32 m_flCrosshairDistance;
	int32 m_iAmmoLastCheck;
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
	GameTime_t m_flLastBurstModeChangeTime;
	// MNetworkEnable
	GameTick_t m_nPostponeFireReadyTicks;
	// MNetworkEnable
	float32 m_flPostponeFireReadyFrac;
	// MNetworkEnable
	bool m_bInReload;
	// MNetworkEnable
	GameTime_t m_flDroppedAtTime;
	// MNetworkEnable
	bool m_bIsHauledBack;
	// MNetworkEnable
	bool m_bSilencerOn;
	// MNetworkEnable
	GameTime_t m_flTimeSilencerSwitchComplete;
	// MNetworkEnable
	float32 m_flWeaponActionPlaybackRate;
	// MNetworkEnable
	int32 m_iOriginalTeamNumber;
	// MNetworkEnable
	int32 m_iMostRecentTeamNumber;
	// MNetworkEnable
	bool m_bDroppedNearBuyZone;
	float32 m_flNextAttackRenderTimeOffset;
	bool m_bClearWeaponIdentifyingUGC;
	bool m_bVisualsDataSet;
	bool m_bUIWeapon;
	int32 m_nCustomEconReloadEventId;
	// MNetworkEnable
	GameTime_t m_nextPrevOwnerUseTime;
	// MNetworkEnable
	CHandle< C_CSPlayerPawn > m_hPrevOwner;
	// MNetworkEnable
	GameTick_t m_nDropTick;
	// MNetworkEnable
	bool m_bWasActiveWeaponWhenDropped;
	bool m_donated;
	// MNetworkEnable
	GameTime_t m_fLastShotTime;
	bool m_bWasOwnedByCT;
	bool m_bWasOwnedByTerrorist;
	float32 m_flNextClientFireBulletTime;
	float32 m_flNextClientFireBulletTime_Repredict;
	C_IronSightController m_IronSightController;
	// MNetworkEnable
	int32 m_iIronSightMode;
	GameTime_t m_flLastLOSTraceFailureTime;
	// MNetworkEnable
	float32 m_flWatTickOffset;
	// MNetworkEnable
	GameTime_t m_flLastShakeTime;
};
