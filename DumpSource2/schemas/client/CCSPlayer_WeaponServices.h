// MNetworkVarNames = "GameTime_t m_flNextAttack"
// MNetworkVarNames = "bool m_bIsLookingAtWeapon"
// MNetworkVarNames = "bool m_bIsHoldingLookAtWeapon"
// MNetworkVarNames = "uint8 m_networkAnimTiming"
// MNetworkVarNames = "bool m_bBlockInspectUntilNextGraphUpdate"
class CCSPlayer_WeaponServices : public CPlayer_WeaponServices
{
	// MNetworkEnable
	// MNetworkUserGroup = "LocalPlayerExclusive"
	GameTime_t m_flNextAttack;
	// MNetworkEnable
	bool m_bIsLookingAtWeapon;
	// MNetworkEnable
	bool m_bIsHoldingLookAtWeapon;
	uint32 m_nOldTotalShootPositionHistoryCount;
	uint32 m_nOldTotalInputHistoryCount;
	// MNetworkEnable
	C_NetworkUtlVectorBase< uint8 > m_networkAnimTiming;
	// MNetworkEnable
	bool m_bBlockInspectUntilNextGraphUpdate;
};
