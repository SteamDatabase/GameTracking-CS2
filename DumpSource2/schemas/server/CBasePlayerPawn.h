class CBasePlayerPawn : public CBaseCombatCharacter
{
	CPlayer_WeaponServices* m_pWeaponServices;
	CPlayer_ItemServices* m_pItemServices;
	CPlayer_AutoaimServices* m_pAutoaimServices;
	CPlayer_ObserverServices* m_pObserverServices;
	CPlayer_WaterServices* m_pWaterServices;
	CPlayer_UseServices* m_pUseServices;
	CPlayer_FlashlightServices* m_pFlashlightServices;
	CPlayer_CameraServices* m_pCameraServices;
	CPlayer_MovementServices* m_pMovementServices;
	CUtlVectorEmbeddedNetworkVar< ViewAngleServerChange_t > m_ServerViewAngleChanges;
	uint32 m_nHighestGeneratedServerViewAngleChangeIndex;
	QAngle v_angle;
	QAngle v_anglePrevious;
	uint32 m_iHideHUD;
	sky3dparams_t m_skybox3d;
	GameTime_t m_fTimeLastHurt;
	GameTime_t m_flDeathTime;
	GameTime_t m_fNextSuicideTime;
	bool m_fInitHUD;
	CAI_Expresser* m_pExpresser;
	CHandle< CBasePlayerController > m_hController;
	float32 m_fHltvReplayDelay;
	float32 m_fHltvReplayEnd;
	CEntityIndex m_iHltvReplayEntity;
	CUtlVector< sndopvarlatchdata_t > m_sndOpvarLatchData;
}
