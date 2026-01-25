class CSAdditionalMatchStats_t : public CSAdditionalPerRoundStats_t
{
	int32 m_numRoundsSurvivedStreak;
	int32 m_maxNumRoundsSurvivedStreak;
	int32 m_numRoundsSurvivedTotal;
	int32 m_iRoundsWonWithoutPurchase;
	int32 m_iRoundsWonWithoutPurchaseTotal;
	int32 m_numFirstKills;
	int32 m_numClutchKills;
	int32 m_numPistolKills;
	int32 m_numSniperKills;
	int32 m_iNumSuicides;
	int32 m_iNumTeamKills;
	float32 m_flTeamDamage;
};
