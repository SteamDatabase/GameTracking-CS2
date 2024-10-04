class CCSPlayerBase_CameraServices : public CPlayer_CameraServices
{
	uint32 m_iFOV;
	uint32 m_iFOVStart;
	GameTime_t m_flFOVTime;
	float32 m_flFOVRate;
	CHandle< C_BaseEntity > m_hZoomOwner;
	float32 m_flLastShotFOV;
};
