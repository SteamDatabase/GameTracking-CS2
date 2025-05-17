// MNetworkExcludeByName = "m_flAnimTime"
// MNetworkExcludeByName = "m_flexWeight"
// MNetworkExcludeByUserGroup = "m_flPoseParameter"
// MNetworkExcludeByName = "m_baseLayer.m_hSequence"
// MNetworkExcludeByName = "m_animationController.m_flPlaybackRate"
// MNetworkVarNames = "CCSPlayer_PingServices * m_pPingServices"
// MNetworkVarNames = "CPlayer_ViewModelServices * m_pViewModelServices"
// MNetworkVarNames = "CSPlayerState m_iPlayerState"
// MNetworkVarNames = "bool m_bIsRescuing"
// MNetworkVarNames = "GameTime_t m_fImmuneToGunGameDamageTime"
// MNetworkVarNames = "bool m_bGunGameImmunity"
// MNetworkVarNames = "bool m_bHasMovedSinceSpawn"
// MNetworkVarNames = "float m_fMolotovUseTime"
// MNetworkVarNames = "float m_fMolotovDamageTime"
// MNetworkVarNames = "int m_iThrowGrenadeCounter"
// MNetworkVarNames = "int m_iProgressBarDuration"
// MNetworkVarNames = "float m_flProgressBarStartTime"
// MNetworkVarNames = "float m_flFlashMaxAlpha"
// MNetworkVarNames = "float m_flFlashDuration"
// MNetworkVarNames = "int m_cycleLatch"
// MNetworkVarNames = "CHandle< CCSPlayerController> m_hOriginalController"
class C_CSPlayerPawnBase : public C_BasePlayerPawn
{
	// MNetworkEnable
	CCSPlayer_PingServices* m_pPingServices;
	// MNetworkEnable
	CPlayer_ViewModelServices* m_pViewModelServices;
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
	bool m_bIsRescuing;
	// MNetworkEnable
	GameTime_t m_fImmuneToGunGameDamageTime;
	GameTime_t m_fImmuneToGunGameDamageTimeLast;
	// MNetworkEnable
	bool m_bGunGameImmunity;
	// MNetworkEnable
	bool m_bHasMovedSinceSpawn;
	// MNetworkEnable
	float32 m_fMolotovUseTime;
	// MNetworkEnable
	float32 m_fMolotovDamageTime;
	// MNetworkEnable
	int32 m_iThrowGrenadeCounter;
	GameTime_t m_flLastSpawnTimeIndex;
	// MNetworkEnable
	int32 m_iProgressBarDuration;
	// MNetworkEnable
	float32 m_flProgressBarStartTime;
	Vector m_vecIntroStartEyePosition;
	Vector m_vecIntroStartPlayerForward;
	GameTime_t m_flClientDeathTime;
	bool m_bScreenTearFrameCaptured;
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
	int32 m_iHealthBarRenderMaskIndex;
	float32 m_flHealthFadeValue;
	float32 m_flHealthFadeAlpha;
	float32 m_flDeathCCWeight;
	float32 m_flPrevRoundEndTime;
	float32 m_flPrevMatchEndTime;
	// MNetworkEnable
	// MNetworkEncoder = "qangle_precise"
	// MNetworkChangeCallback = "playerEyeAnglesChanged"
	// MNetworkPriority = 32
	QAngle m_angEyeAngles;
	float32 m_fNextThinkPushAway;
	bool m_bShouldAutobuyDMWeapons;
	bool m_bShouldAutobuyNow;
	CEntityIndex m_iIDEntIndex;
	CountdownTimer m_delayTargetIDTimer;
	CEntityIndex m_iTargetItemEntIdx;
	CEntityIndex m_iOldIDEntIndex;
	CountdownTimer m_holdTargetIDTimer;
	float32 m_flCurrentMusicStartTime;
	float32 m_flMusicRoundStartTime;
	bool m_bDeferStartMusicOnWarmup;
	// MNetworkEnable
	int32 m_cycleLatch;
	float32 m_serverIntendedCycle;
	float32 m_flLastSmokeOverlayAlpha;
	float32 m_flLastSmokeAge;
	Vector m_vLastSmokeOverlayColor;
	ParticleIndex_t m_nPlayerSmokedFx;
	ParticleIndex_t m_nPlayerInfernoBodyFx;
	ParticleIndex_t m_nPlayerInfernoFootFx;
	float32 m_flNextMagDropTime;
	int32 m_nLastMagDropAttachmentIndex;
	Vector m_vecLastAliveLocalVelocity;
	bool m_bGuardianShouldSprayCustomXMark;
	// MNetworkEnable
	CHandle< CCSPlayerController > m_hOriginalController;
};
