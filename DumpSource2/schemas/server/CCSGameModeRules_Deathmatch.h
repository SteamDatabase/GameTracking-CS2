// MNetworkVarNames = "GameTime_t m_flDMBonusStartTime"
// MNetworkVarNames = "float m_flDMBonusTimeLength"
// MNetworkVarNames = "CUtlString m_sDMBonusWeapon"
class CCSGameModeRules_Deathmatch : public CCSGameModeRules
{
	// MNetworkEnable
	GameTime_t m_flDMBonusStartTime;
	// MNetworkEnable
	float32 m_flDMBonusTimeLength;
	// MNetworkEnable
	CUtlString m_sDMBonusWeapon;
};
