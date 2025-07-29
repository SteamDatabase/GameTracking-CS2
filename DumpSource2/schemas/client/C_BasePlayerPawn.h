// MNetworkUserGroupProxy = "C_BasePlayerPawn"
// MNetworkExcludeByUserGroup = "FogController"
// MNetworkIncludeByUserGroup = "Player"
// MNetworkIncludeByUserGroup = "Water"
// MNetworkIncludeByUserGroup = "LocalPlayerExclusive"
// MNetworkOverride = "m_vecX CNetworkOriginCellCoordQuantizedVector"
// MNetworkOverride = "m_vecY CNetworkOriginCellCoordQuantizedVector"
// MNetworkOverride = "m_vecZ CNetworkOriginCellCoordQuantizedVector"
// MNetworkOverride = "m_lifeState"
// MNetworkExcludeByName = "m_pWeaponServices"
// MNetworkExcludeByName = "m_pItemServices"
// MNetworkExcludeByName = "m_pAutoaimServices"
// MNetworkExcludeByName = "m_pObserverServices"
// MNetworkExcludeByName = "m_pWaterServices"
// MNetworkExcludeByName = "m_pUseServices"
// MNetworkExcludeByName = "m_pFlashlightServices"
// MNetworkExcludeByName = "m_pMovementServices"
// MNetworkVarNames = "CPlayer_WeaponServices * m_pWeaponServices"
// MNetworkVarNames = "CPlayer_ItemServices * m_pItemServices"
// MNetworkVarNames = "CPlayer_AutoaimServices * m_pAutoaimServices"
// MNetworkVarNames = "CPlayer_ObserverServices * m_pObserverServices"
// MNetworkVarNames = "CPlayer_WaterServices * m_pWaterServices"
// MNetworkVarNames = "CPlayer_UseServices * m_pUseServices"
// MNetworkVarNames = "CPlayer_FlashlightServices * m_pFlashlightServices"
// MNetworkVarNames = "CPlayer_CameraServices * m_pCameraServices"
// MNetworkVarNames = "CPlayer_MovementServices * m_pMovementServices"
// MNetworkVarNames = "ViewAngleServerChange_t m_ServerViewAngleChanges"
// MNetworkVarNames = "uint32 m_iHideHUD"
// MNetworkVarNames = "sky3dparams_t m_skybox3d"
// MNetworkVarNames = "GameTime_t m_flDeathTime"
// MNetworkVarNames = "CHandle< CBasePlayerController> m_hController"
// MNetworkVarNames = "CHandle< CBasePlayerController> m_hDefaultController"
class C_BasePlayerPawn : public C_BaseCombatCharacter
{
	// MNetworkEnable
	CPlayer_WeaponServices* m_pWeaponServices;
	// MNetworkEnable
	CPlayer_ItemServices* m_pItemServices;
	// MNetworkEnable
	// MNetworkUserGroup = "LocalPlayerExclusive"
	CPlayer_AutoaimServices* m_pAutoaimServices;
	// MNetworkEnable
	CPlayer_ObserverServices* m_pObserverServices;
	// MNetworkEnable
	CPlayer_WaterServices* m_pWaterServices;
	// MNetworkEnable
	CPlayer_UseServices* m_pUseServices;
	// MNetworkEnable
	CPlayer_FlashlightServices* m_pFlashlightServices;
	// MNetworkEnable
	CPlayer_CameraServices* m_pCameraServices;
	// MNetworkEnable
	CPlayer_MovementServices* m_pMovementServices;
	// MNetworkEnable
	// MNetworkUserGroup = "LocalPlayerExclusive"
	C_UtlVectorEmbeddedNetworkVar< ViewAngleServerChange_t > m_ServerViewAngleChanges;
	QAngle v_angle;
	QAngle v_anglePrevious;
	// MNetworkEnable
	// MNetworkUserGroup = "LocalPlayerExclusive"
	uint32 m_iHideHUD;
	// MNetworkEnable
	// MNetworkUserGroup = "LocalPlayerExclusive"
	sky3dparams_t m_skybox3d;
	// MNetworkEnable
	GameTime_t m_flDeathTime;
	Vector m_vecPredictionError;
	GameTime_t m_flPredictionErrorTime;
	Vector m_vecLastCameraSetupLocalOrigin;
	GameTime_t m_flLastCameraSetupTime;
	float32 m_flFOVSensitivityAdjust;
	float32 m_flMouseSensitivity;
	Vector m_vOldOrigin;
	float32 m_flOldSimulationTime;
	int32 m_nLastExecutedCommandNumber;
	int32 m_nLastExecutedCommandTick;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnControllerChanged"
	CHandle< CBasePlayerController > m_hController;
	// MNetworkEnable
	CHandle< CBasePlayerController > m_hDefaultController;
	bool m_bIsSwappingToPredictableController;
};
