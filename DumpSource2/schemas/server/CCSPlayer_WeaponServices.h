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
	CHandle< CBasePlayerWeapon > m_hSavedWeapon;
	int32 m_nTimeToMelee;
	int32 m_nTimeToSecondary;
	int32 m_nTimeToPrimary;
	int32 m_nTimeToSniperRifle;
	bool m_bIsBeingGivenItem;
	bool m_bIsPickingUpItemWithUse;
	bool m_bPickedUpWeapon;
	bool m_bDisableAutoDeploy;
	bool m_bIsPickingUpGroundWeapon;
	// MNetworkEnable
	CNetworkUtlVectorBase< uint8 > m_networkAnimTiming;
	// MNetworkEnable
	bool m_bBlockInspectUntilNextGraphUpdate;
};
