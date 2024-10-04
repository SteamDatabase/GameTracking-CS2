class CCSPlayerBase_CameraServices : public CPlayer_CameraServices
{
	uint32 m_iFOV;
	uint32 m_iFOVStart;
	GameTime_t m_flFOVTime;
	float32 m_flFOVRate;
	CHandle< CBaseEntity > m_hZoomOwner;
	CUtlVector< CHandle< CBaseEntity > > m_hTriggerFogList;
	CHandle< CBaseEntity > m_hLastFogTrigger;
};
