class CCSTeam : public CTeam
{
	int32 m_nLastRecievedShorthandedRoundBonus;
	int32 m_nShorthandedRoundBonusStartRound;
	bool m_bSurrendered;
	char[512] m_szTeamMatchStat;
	int32 m_numMapVictories;
	int32 m_scoreFirstHalf;
	int32 m_scoreSecondHalf;
	int32 m_scoreOvertime;
	char[129] m_szClanTeamname;
	uint32 m_iClanID;
	char[8] m_szTeamFlagImage;
	char[8] m_szTeamLogoImage;
	float32 m_flNextResourceTime;
	int32 m_iLastUpdateSentAt;
}
