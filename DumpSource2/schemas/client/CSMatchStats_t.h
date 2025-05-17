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
};
