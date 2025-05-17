// MNetworkVarNames = "int m_iKills"
// MNetworkVarNames = "int m_iDeaths"
// MNetworkVarNames = "int m_iAssists"
// MNetworkVarNames = "int m_iDamage"
// MNetworkVarNames = "int m_iEquipmentValue"
// MNetworkVarNames = "int m_iMoneySaved"
// MNetworkVarNames = "int m_iKillReward"
// MNetworkVarNames = "int m_iLiveTime"
// MNetworkVarNames = "int m_iHeadShotKills"
// MNetworkVarNames = "int m_iObjective"
// MNetworkVarNames = "int m_iCashEarned"
// MNetworkVarNames = "int m_iUtilityDamage"
// MNetworkVarNames = "int m_iEnemiesFlashed"
class CSPerRoundStats_t
{
	// MNetworkEnable
	int32 m_iKills;
	// MNetworkEnable
	int32 m_iDeaths;
	// MNetworkEnable
	int32 m_iAssists;
	// MNetworkEnable
	// MNetworkUserGroup = "AllPlayersDuringFreezePeriodOrMatchEnd"
	int32 m_iDamage;
	// MNetworkEnable
	// MNetworkUserGroup = "TeammateAndSpectatorExclusive"
	int32 m_iEquipmentValue;
	// MNetworkEnable
	// MNetworkUserGroup = "TeammateAndSpectatorExclusive"
	int32 m_iMoneySaved;
	// MNetworkEnable
	// MNetworkUserGroup = "TeammateAndSpectatorExclusive"
	int32 m_iKillReward;
	// MNetworkEnable
	int32 m_iLiveTime;
	// MNetworkEnable
	int32 m_iHeadShotKills;
	// MNetworkEnable
	// MNetworkUserGroup = "AllPlayersDuringFreezePeriodOrMatchEnd"
	int32 m_iObjective;
	// MNetworkEnable
	// MNetworkUserGroup = "TeammateAndSpectatorExclusive"
	int32 m_iCashEarned;
	// MNetworkEnable
	// MNetworkUserGroup = "AllPlayersDuringFreezePeriodOrMatchEnd"
	int32 m_iUtilityDamage;
	// MNetworkEnable
	// MNetworkUserGroup = "AllPlayersDuringFreezePeriodOrMatchEnd"
	int32 m_iEnemiesFlashed;
};
