// MNetworkVarNames = "GameTime_t m_fFireTime"
class CWeaponTaser : public CCSWeaponBaseGun
{
	// MNetworkEnable
	GameTime_t m_fFireTime;
	int32 m_nLastAttackTick;
};
