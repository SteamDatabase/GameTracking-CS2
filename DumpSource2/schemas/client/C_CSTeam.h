// MNetworkVarNames = "char m_szTeamMatchStat"
// MNetworkVarNames = "int m_numMapVictories"
// MNetworkVarNames = "bool m_bSurrendered"
// MNetworkVarNames = "int32 m_scoreFirstHalf"
// MNetworkVarNames = "int32 m_scoreSecondHalf"
// MNetworkVarNames = "int32 m_scoreOvertime"
// MNetworkVarNames = "char m_szClanTeamname"
// MNetworkVarNames = "uint32 m_iClanID"
// MNetworkVarNames = "char m_szTeamFlagImage"
// MNetworkVarNames = "char m_szTeamLogoImage"
class C_CSTeam : public C_Team
{
	// MNetworkEnable
	char[512] m_szTeamMatchStat;
	// MNetworkEnable
	int32 m_numMapVictories;
	// MNetworkEnable
	bool m_bSurrendered;
	// MNetworkEnable
	int32 m_scoreFirstHalf;
	// MNetworkEnable
	int32 m_scoreSecondHalf;
	// MNetworkEnable
	int32 m_scoreOvertime;
	// MNetworkEnable
	char[129] m_szClanTeamname;
	// MNetworkEnable
	uint32 m_iClanID;
	// MNetworkEnable
	char[8] m_szTeamFlagImage;
	// MNetworkEnable
	char[8] m_szTeamLogoImage;
};
