// MNetworkVarNames = "uint32 m_iFOV"
// MNetworkVarNames = "uint32 m_iFOVStart"
// MNetworkVarNames = "GameTime_t m_flFOVTime"
// MNetworkVarNames = "float32 m_flFOVRate"
// MNetworkVarNames = "CHandle< CBaseEntity> m_hZoomOwner"
class CCSPlayerBase_CameraServices : public CPlayer_CameraServices
{
	// MNetworkEnable
	uint32 m_iFOV;
	// MNetworkEnable
	uint32 m_iFOVStart;
	// MNetworkEnable
	GameTime_t m_flFOVTime;
	// MNetworkEnable
	// MNetworkUserGroup = "LocalPlayerExclusive"
	float32 m_flFOVRate;
	// MNetworkEnable
	CHandle< CBaseEntity > m_hZoomOwner;
	CUtlVector< CHandle< CBaseEntity > > m_hTriggerFogList;
	CHandle< CBaseEntity > m_hLastFogTrigger;
};
