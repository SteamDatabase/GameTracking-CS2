// MNetworkVarNames = "CSPerRoundStats_t m_perRoundStats"
// MNetworkVarNames = "CSMatchStats_t m_matchStats"
// MNetworkVarNames = "int m_iNumRoundKills"
// MNetworkVarNames = "int m_iNumRoundKillsHeadshots"
// MNetworkVarNames = "uint32 m_unTotalRoundDamageDealt"
class CCSPlayerController_ActionTrackingServices : public CPlayerControllerComponent
{
	// MNetworkEnable
	CUtlVectorEmbeddedNetworkVar< CSPerRoundStats_t > m_perRoundStats;
	// MNetworkEnable
	CSMatchStats_t m_matchStats;
	// MNetworkEnable
	int32 m_iNumRoundKills;
	// MNetworkEnable
	int32 m_iNumRoundKillsHeadshots;
	// MNetworkEnable
	uint32 m_unTotalRoundDamageDealt;
};
