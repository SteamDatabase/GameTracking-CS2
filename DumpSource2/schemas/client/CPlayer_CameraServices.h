// MNetworkVarNames = "QAngle m_vecCsViewPunchAngle"
// MNetworkVarNames = "GameTick_t m_nCsViewPunchAngleTick"
// MNetworkVarNames = "float32 m_flCsViewPunchAngleTickRatio"
// MNetworkVarNames = "fogplayerparams_t m_PlayerFog"
// MNetworkVarNames = "CHandle< CColorCorrection> m_hColorCorrectionCtrl"
// MNetworkVarNames = "CHandle< CBaseEntity> m_hViewEntity"
// MNetworkVarNames = "CHandle< CTonemapController2> m_hTonemapController"
// MNetworkVarNames = "audioparams_t m_audio"
// MNetworkVarNames = "CHandle<C_PostProcessingVolume> m_PostProcessingVolumes"
class CPlayer_CameraServices : public CPlayerPawnComponent
{
	// MNetworkEnable
	// MNetworkEncoder = "qangle_precise"
	QAngle m_vecCsViewPunchAngle;
	// MNetworkEnable
	GameTick_t m_nCsViewPunchAngleTick;
	// MNetworkEnable
	float32 m_flCsViewPunchAngleTickRatio;
	// MNetworkEnable
	C_fogplayerparams_t m_PlayerFog;
	// MNetworkEnable
	CHandle< C_ColorCorrection > m_hColorCorrectionCtrl;
	// MNetworkEnable
	CHandle< C_BaseEntity > m_hViewEntity;
	// MNetworkEnable
	// MNetworkUserGroup = "LocalPlayerAndObserversExclusive"
	CHandle< C_TonemapController2 > m_hTonemapController;
	// MNetworkEnable
	// MNetworkUserGroup = "LocalPlayerAndObserversExclusive"
	audioparams_t m_audio;
	// MNetworkEnable
	// MNetworkUserGroup = "LocalPlayerAndObserversExclusive"
	C_NetworkUtlVectorBase< CHandle< C_PostProcessingVolume > > m_PostProcessingVolumes;
	float32 m_flOldPlayerZ;
	float32 m_flOldPlayerViewOffsetZ;
	fogparams_t m_CurrentFog;
	CHandle< C_FogController > m_hOldFogController;
	bool[5] m_bOverrideFogColor;
	Color[5] m_OverrideFogColor;
	bool[5] m_bOverrideFogStartEnd;
	float32[5] m_fOverrideFogStart;
	float32[5] m_fOverrideFogEnd;
	CHandle< C_PostProcessingVolume > m_hActivePostProcessingVolume;
	QAngle m_angDemoViewAngles;
};
