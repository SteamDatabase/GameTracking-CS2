// MNetworkExcludeByName = "m_flexWeight"
// MNetworkExcludeByUserGroup = "m_flPoseParameter"
// MNetworkExcludeByName = "m_baseLayer.m_hSequence"
// MNetworkExcludeByName = "m_animationController.m_flPlaybackRate"
// MNetworkVarNames = "CCSPlayer_PingServices * m_pPingServices"
// MNetworkVarNames = "CSPlayerState m_iPlayerState"
// MNetworkVarNames = "bool m_bHasMovedSinceSpawn"
// MNetworkVarNames = "int m_iProgressBarDuration"
// MNetworkVarNames = "float m_flProgressBarStartTime"
// MNetworkVarNames = "float m_flFlashMaxAlpha"
// MNetworkVarNames = "float m_flFlashDuration"
// MNetworkVarNames = "CHandle< CCSPlayerController> m_hOriginalController"
class C_CSPlayerPawnBase : public C_BasePlayerPawn
{
	// MNetworkEnable
	CCSPlayer_PingServices* m_pPingServices;
	float32[4] m_fRenderingClipPlane;
	int32 m_nLastClipPlaneSetupFrame;
	Vector m_vecLastClipCameraPos;
	Vector m_vecLastClipCameraForward;
	bool m_bClipHitStaticWorld;
	bool m_bCachedPlaneIsValid;
	C_CSWeaponBase* m_pClippingWeapon;
	CSPlayerState m_previousPlayerState;
	// MNetworkEnable
	CSPlayerState m_iPlayerState;
	// MNetworkEnable
	bool m_bHasMovedSinceSpawn;
	GameTime_t m_flLastSpawnTimeIndex;
	// MNetworkEnable
	int32 m_iProgressBarDuration;
	// MNetworkEnable
	float32 m_flProgressBarStartTime;
	GameTime_t m_flClientDeathTime;
	float32 m_flFlashBangTime;
	float32 m_flFlashScreenshotAlpha;
	float32 m_flFlashOverlayAlpha;
	bool m_bFlashBuildUp;
	bool m_bFlashDspHasBeenCleared;
	bool m_bFlashScreenshotHasBeenGrabbed;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnFlashMaxAlphaChanged"
	float32 m_flFlashMaxAlpha;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnFlashDurationChanged"
	float32 m_flFlashDuration;
	GameTime_t m_flClientHealthFadeChangeTimestamp;
	int32 m_nClientHealthFadeParityValue;
	// MNetworkEnable
	// MNetworkEncoder = "qangle_precise"
	// MNetworkChangeCallback = "playerEyeAnglesChanged"
	// MNetworkPriority = 32
	QAngle m_angEyeAngles;
	float32 m_fNextThinkPushAway;
	CEntityIndex m_iIDEntIndex;
	CountdownTimer m_delayTargetIDTimer;
	CEntityIndex m_iTargetItemEntIdx;
	CEntityIndex m_iOldIDEntIndex;
	CountdownTimer m_holdTargetIDTimer;
	float32 m_flCurrentMusicStartTime;
	float32 m_flMusicRoundStartTime;
	bool m_bDeferStartMusicOnWarmup;
	float32 m_flLastSmokeOverlayAlpha;
	float32 m_flLastSmokeAge;
	Vector m_vLastSmokeOverlayColor;
	ParticleIndex_t m_nPlayerInfernoBodyFx;
	Vector m_vecLastAliveLocalVelocity;
	// MNetworkEnable
	CHandle< CCSPlayerController > m_hOriginalController;
};
