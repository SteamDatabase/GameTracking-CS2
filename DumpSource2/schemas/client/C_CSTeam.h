class C_CSTeam : public C_Team
{
	char[512] m_szTeamMatchStat;
	int32 m_numMapVictories;
	bool m_bSurrendered;
	int32 m_scoreFirstHalf;
	int32 m_scoreSecondHalf;
	int32 m_scoreOvertime;
	char[129] m_szClanTeamname;
	uint32 m_iClanID;
	char[8] m_szTeamFlagImage;
	char[8] m_szTeamLogoImage;
};
