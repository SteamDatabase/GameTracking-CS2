// MNetworkVarNames = "bool m_bIsRescuing"
// MNetworkVarNames = "WeaponPurchaseTracker_t m_weaponPurchasesThisMatch"
// MNetworkVarNames = "WeaponPurchaseTracker_t m_weaponPurchasesThisRound"
class CCSPlayer_ActionTrackingServices : public CPlayerPawnComponent
{
	CHandle< CBasePlayerWeapon > m_hLastWeaponBeforeC4AutoSwitch;
	// MNetworkEnable
	bool m_bIsRescuing;
	// MNetworkEnable
	WeaponPurchaseTracker_t m_weaponPurchasesThisMatch;
	// MNetworkEnable
	WeaponPurchaseTracker_t m_weaponPurchasesThisRound;
};
