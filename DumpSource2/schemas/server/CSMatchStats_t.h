// MNetworkVarNames = "int m_iEnemy5Ks"
// MNetworkVarNames = "int m_iEnemy4Ks"
// MNetworkVarNames = "int m_iEnemy3Ks"
// MNetworkVarNames = "int m_iEnemyKnifeKills"
// MNetworkVarNames = "int m_iEnemyTaserKills"
class CSMatchStats_t : public CSPerRoundStats_t
{
	// MNetworkEnable
	int32 m_iEnemy5Ks;
	// MNetworkEnable
	int32 m_iEnemy4Ks;
	// MNetworkEnable
	int32 m_iEnemy3Ks;
	// MNetworkEnable
	int32 m_iEnemyKnifeKills;
	// MNetworkEnable
	int32 m_iEnemyTaserKills;
	int32 m_iEnemy2Ks;
	int32 m_iUtility_Count;
	int32 m_iUtility_Successes;
	int32 m_iUtility_Enemies;
	int32 m_iFlash_Count;
	int32 m_iFlash_Successes;
	float32 m_flHealthPointsRemovedTotal;
	float32 m_flHealthPointsDealtTotal;
	int32 m_nShotsFiredTotal;
	int32 m_nShotsOnTargetTotal;
	int32 m_i1v1Count;
	int32 m_i1v1Wins;
	int32 m_i1v2Count;
	int32 m_i1v2Wins;
	int32 m_iEntryCount;
	int32 m_iEntryWins;
};
