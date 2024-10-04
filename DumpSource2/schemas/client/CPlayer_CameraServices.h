class CPlayer_CameraServices : public CPlayerPawnComponent
{
	QAngle m_vecCsViewPunchAngle;
	GameTick_t m_nCsViewPunchAngleTick;
	float32 m_flCsViewPunchAngleTickRatio;
	C_fogplayerparams_t m_PlayerFog;
	CHandle< C_ColorCorrection > m_hColorCorrectionCtrl;
	CHandle< C_BaseEntity > m_hViewEntity;
	CHandle< C_TonemapController2 > m_hTonemapController;
	audioparams_t m_audio;
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
}
