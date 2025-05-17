// MNetworkIncludeByName = "m_iTeamNum"
// MNetworkVarNames = "CHandle< CBasePlayerController > m_aPlayerControllers"
// MNetworkVarNames = "CHandle< CBasePlayerPawn > m_aPlayers"
// MNetworkVarNames = "int32 m_iScore"
// MNetworkVarNames = "char m_szTeamname"
class CTeam : public CBaseEntity
{
	// MNetworkEnable
	// MNetworkAlias = "m_aPlayers"
	CNetworkUtlVectorBase< CHandle< CBasePlayerController > > m_aPlayerControllers;
	// MNetworkEnable
	// MNetworkAlias = "m_aPawns"
	CNetworkUtlVectorBase< CHandle< CBasePlayerPawn > > m_aPlayers;
	// MNetworkEnable
	int32 m_iScore;
	// MNetworkEnable
	char[129] m_szTeamname;
};
