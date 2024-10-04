class CTeam : public CBaseEntity
{
	CNetworkUtlVectorBase< CHandle< CBasePlayerController > > m_aPlayerControllers;
	CNetworkUtlVectorBase< CHandle< CBasePlayerPawn > > m_aPlayers;
	int32 m_iScore;
	char[129] m_szTeamname;
}
