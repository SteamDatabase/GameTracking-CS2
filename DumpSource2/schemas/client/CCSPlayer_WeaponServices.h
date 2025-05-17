// MNetworkVarNames = "GameTime_t m_flNextAttack"
// MNetworkVarNames = "bool m_bIsLookingAtWeapon"
// MNetworkVarNames = "bool m_bIsHoldingLookAtWeapon"
class CCSPlayer_WeaponServices : public CPlayer_WeaponServices
{
	// MNetworkEnable
	// MNetworkUserGroup = "LocalPlayerExclusive"
	GameTime_t m_flNextAttack;
	// MNetworkEnable
	bool m_bIsLookingAtWeapon;
	// MNetworkEnable
	bool m_bIsHoldingLookAtWeapon;
	uint32 m_nOldShootPositionHistoryCount;
	uint32 m_nOldInputHistoryCount;
};
