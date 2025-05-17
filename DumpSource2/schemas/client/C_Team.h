// MNetworkIncludeByName = "m_iTeamNum"
// MNetworkVarNames = "CHandle< CBasePlayerController > m_aPlayerControllers"
// MNetworkVarNames = "CHandle< C_BasePlayerPawn > m_aPlayers"
// MNetworkVarNames = "int32 m_iScore"
// MNetworkVarNames = "char m_szTeamname"
class C_Team : public C_BaseEntity
{
	// MNetworkEnable
	// MNetworkAlias = "m_aPlayers"
	C_NetworkUtlVectorBase< CHandle< CBasePlayerController > > m_aPlayerControllers;
	// MNetworkEnable
	// MNetworkAlias = "m_aPawns"
	C_NetworkUtlVectorBase< CHandle< C_BasePlayerPawn > > m_aPlayers;
	// MNetworkEnable
	int32 m_iScore;
	// MNetworkEnable
	char[129] m_szTeamname;
};
