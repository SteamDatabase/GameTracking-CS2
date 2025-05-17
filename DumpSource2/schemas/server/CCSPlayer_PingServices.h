// MNetworkVarNames = "CHandle< CBaseEntity> m_hPlayerPing"
class CCSPlayer_PingServices : public CPlayerPawnComponent
{
	GameTime_t[5] m_flPlayerPingTokens;
	// MNetworkEnable
	CHandle< CBaseEntity > m_hPlayerPing;
};
